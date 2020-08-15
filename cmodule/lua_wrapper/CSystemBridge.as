package cmodule.lua_wrapper
{
    import flash.net.Socket;
    import flash.utils.ByteArray;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;

    public class CSystemBridge implements CSystem 
    {

        internal static const FSIZE:int = 1;
        internal static const PSIZE:int = 2;
        internal static const ACCESS:int = 3;
        internal static const OPEN:int = 4;
        internal static const CLOSE:int = 5;
        internal static const WRITE:int = 6;
        internal static const READ:int = 7;
        internal static const LSEEK:int = 8;
        internal static const TELL:int = 9;
        internal static const EXIT:int = 10;
        internal static const SETUP:int = 11;

        private var sock:Socket;
        private var sentPackId:int = 1;
        private var curPackLen:int;
        internal var argv:Array;
        internal var env:Object;
        private var curPackId:int;

        private var curPackBuf:ByteArray = new LEByteArray();
        private var handlers:Object = {};
        private var requests:Object = {};

        public function CSystemBridge(_arg_1:String, _arg_2:int)
        {
            this.sock = new Socket();
            this.sock.endian = "littleEndian";
            this.sock.addEventListener(Event.CONNECT, this.sockConnect);
            this.sock.addEventListener(ProgressEvent.SOCKET_DATA, this.sockData);
            this.sock.addEventListener(IOErrorEvent.IO_ERROR, this.sockError);
            this.sock.connect(_arg_1, _arg_2);
        }

        public function psize(p:int):int
        {
            return (this.asyncReq(function (_arg_1:ByteArray):void
            {
                _arg_1.writeInt(PSIZE);
                _arg_1.writeUTFBytes(gstate.gworker.stringFromPtr(p));
            }, function (_arg_1:ByteArray):int
            {
                return (_arg_1.readInt());
            }));
        }

        private function asyncReq(create:Function, handle:Function):*
        {
            var rid:String;
            var req:Object;
            var pack:ByteArray;
            rid = String(gstate.esp);
            req = this.requests[rid];
            if (req)
            {
                if (req.pending)
                {
                    throw (new AlchemyBlock());
                };
                delete this.requests[rid];
                return (req.result);
            };
            req = {"pending":true};
            this.requests[rid] = req;
            pack = new LEByteArray();
            (create(pack));
            this.sendRequest(pack, function (_arg_1:ByteArray):void
            {
                req.result = handle(_arg_1);
                req.pending = false;
            });
            if (req.pending)
            {
                throw (new AlchemyBlock());
            };
        }

        public function setup(f:Function):void
        {
            var pack:ByteArray;
            pack = new LEByteArray();
            pack.writeInt(SETUP);
            this.sendRequest(pack, function (_arg_1:ByteArray):void
            {
                var _local_4:Array;
                var _local_2:int = _arg_1.readInt();
                argv = [];
                while (_local_2--)
                {
                    argv.push(_arg_1.readUTF());
                };
                var _local_3:int = _arg_1.readInt();
                env = {};
                while (_local_3--)
                {
                    _local_4 = /([^\=]*)\=(.*)/.exec(_arg_1.readUTF());
                    if (((_local_4) && (_local_4.length == 3)))
                    {
                        env[_local_4[1]] = _local_4[2];
                    };
                };
                f();
            });
        }

        private function sockConnect(_arg_1:Event):void
        {
            log(2, "bridge connected");
        }

        private function sockData(_arg_1:ProgressEvent):void
        {
            var _local_2:int;
            while (this.sock.bytesAvailable)
            {
                if (!this.curPackLen)
                {
                    if (this.sock.bytesAvailable >= 8)
                    {
                        this.curPackId = this.sock.readInt();
                        this.curPackLen = this.sock.readInt();
                        log(3, ((("bridge packet id: " + this.curPackId) + " len: ") + this.curPackLen));
                        this.curPackBuf.length = this.curPackLen;
                        this.curPackBuf.position = 0;
                    }
                    else
                    {
                        return;
                    };
                }
                else
                {
                    _local_2 = this.sock.bytesAvailable;
                    if (_local_2 > this.curPackLen)
                    {
                        _local_2 = this.curPackLen;
                    };
                    this.curPackLen = (this.curPackLen - _local_2);
                    while (_local_2--)
                    {
                        this.curPackBuf.writeByte(this.sock.readByte());
                    };
                    if (!this.curPackLen)
                    {
                        this.handlePacket();
                    };
                };
            };
        }

        public function read(fd:int, buf:int, nbytes:int):int
        {
            return (this.asyncReq(function (_arg_1:ByteArray):void
            {
                _arg_1.writeInt(READ);
                _arg_1.writeInt(fd);
                _arg_1.writeInt(nbytes);
            }, function (_arg_1:ByteArray):int
            {
                var _local_2:*;
                var _local_3:*;
                var _local_4:*;
                _local_2 = _arg_1.readInt();
                _local_3 = "";
                gstate.ds.position = buf;
                while (_arg_1.bytesAvailable)
                {
                    _local_4 = _arg_1.readByte();
                    _local_3 = (_local_3 + String.fromCharCode(_local_4));
                    gstate.ds.writeByte(_local_4);
                };
                log(4, (((("read from: " + fd) + " : [") + _local_3) + "]"));
                return (_local_2);
            }));
        }

        public function exit(_arg_1:int):void
        {
            var _local_2:ByteArray;
            _local_2 = new LEByteArray();
            _local_2.writeInt(EXIT);
            _local_2.writeInt(_arg_1);
            this.sendRequest(_local_2, null);
            shellExit(_arg_1);
        }

        private function sockError(_arg_1:IOErrorEvent):void
        {
            log(2, "bridge error");
        }

        public function tell(fd:int):int
        {
            return (this.asyncReq(function (_arg_1:ByteArray):void
            {
                _arg_1.writeInt(TELL);
                _arg_1.writeInt(fd);
            }, function (_arg_1:ByteArray):int
            {
                return (_arg_1.readInt());
            }));
        }

        public function ioctl(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return (-1);
        }

        public function getargv():Array
        {
            return (this.argv);
        }

        public function open(path:int, flags:int, mode:int):int
        {
            return (this.asyncReq(function (_arg_1:ByteArray):void
            {
                _arg_1.writeInt(OPEN);
                _arg_1.writeInt(flags);
                _arg_1.writeInt(mode);
                _arg_1.writeUTFBytes(gstate.gworker.stringFromPtr(path));
            }, function (_arg_1:ByteArray):int
            {
                return (_arg_1.readInt());
            }));
        }

        private function handlePacket():void
        {
            this.curPackBuf.position = 0;
            var _local_1:* = this.handlers;
            (_local_1[this.curPackId](this.curPackBuf));
            if (this.curPackId)
            {
                delete this.handlers[this.curPackId];
            };
        }

        public function getenv():Object
        {
            return (this.env);
        }

        public function write(fd:int, buf:int, nbytes:int):int
        {
            return (this.asyncReq(function (_arg_1:ByteArray):void
            {
                _arg_1.writeInt(WRITE);
                _arg_1.writeInt(fd);
                if (nbytes > 0x1000)
                {
                    nbytes = 0x1000;
                };
                _arg_1.writeBytes(gstate.ds, buf, nbytes);
            }, function (_arg_1:ByteArray):int
            {
                return (_arg_1.readInt());
            }));
        }

        private function sendRequest(_arg_1:ByteArray, _arg_2:Function):void
        {
            if (_arg_2)
            {
                this.handlers[this.sentPackId] = _arg_2;
            };
            this.sock.writeInt(this.sentPackId);
            this.sock.writeInt(_arg_1.length);
            this.sock.writeBytes(_arg_1, 0);
            this.sock.flush();
            this.sentPackId++;
        }

        public function lseek(fd:int, offset:int, whence:int):int
        {
            return (this.asyncReq(function (_arg_1:ByteArray):void
            {
                _arg_1.writeInt(LSEEK);
                _arg_1.writeInt(fd);
                _arg_1.writeInt(offset);
                _arg_1.writeInt(whence);
            }, function (_arg_1:ByteArray):int
            {
                return (_arg_1.readInt());
            }));
        }

        public function fsize(fd:int):int
        {
            return (this.asyncReq(function (_arg_1:ByteArray):void
            {
                _arg_1.writeInt(FSIZE);
                _arg_1.writeInt(fd);
            }, function (_arg_1:ByteArray):int
            {
                return (_arg_1.readInt());
            }));
        }

        public function access(path:int, mode:int):int
        {
            return (this.asyncReq(function (_arg_1:ByteArray):void
            {
                _arg_1.writeInt(ACCESS);
                _arg_1.writeInt(mode);
                _arg_1.writeUTFBytes(gstate.gworker.stringFromPtr(path));
            }, function (_arg_1:ByteArray):int
            {
                return (_arg_1.readInt());
            }));
        }

        public function close(fd:int):int
        {
            return (this.asyncReq(function (_arg_1:ByteArray):void
            {
                _arg_1.writeInt(CLOSE);
                _arg_1.writeInt(fd);
            }, function (_arg_1:ByteArray):int
            {
                return (_arg_1.readInt());
            }));
        }


    }
}

