package cmodule.lua_wrapper
{
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldType;
    import flash.utils.ByteArray;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;

    public class CSystemLocal implements CSystem 
    {

        private var forceSync:Boolean;

        private const fds:Array = [];
        private const statCache:Object = {};

        public function CSystemLocal(_arg_1:Boolean=false)
        {
            this.forceSync = _arg_1;
            gtextField = new TextField();
            gtextField.width = ((gsprite) ? gsprite.stage.stageWidth : 800);
            gtextField.height = ((gsprite) ? gsprite.stage.stageHeight : 600);
            gtextField.multiline = true;
            gtextField.defaultTextFormat = new TextFormat("Courier New");
            gtextField.type = TextFieldType.INPUT;
            gtextField.doubleClickEnabled = true;
            this.fds[0] = new TextFieldI(gtextField);
            this.fds[1] = new TextFieldO(gtextField, (gsprite == null));
            this.fds[2] = new TextFieldO(gtextField, true);
            if (((gsprite) && (gtextField)))
            {
                gsprite.addChild(gtextField);
            }
            else
            {
                log(3, "local system w/o gsprite");
            };
        }

        public function getargv():Array
        {
            return (gargs);
        }

        public function lseek(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:IO;
            _local_4 = this.fds[_arg_1];
            if (_arg_3 == 0)
            {
                _local_4.position = _arg_2;
            }
            else
            {
                if (_arg_3 == 1)
                {
                    _local_4.position = (_local_4.position + _arg_2);
                }
                else
                {
                    if (_arg_3 == 2)
                    {
                        _local_4.position = (_local_4.size + _arg_2);
                    };
                };
            };
            return (_local_4.position);
        }

        public function open(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:String;
            var _local_5:Object;
            var _local_6:int;
            var _local_7:ByteArrayIO;
            _local_4 = gstate.gworker.stringFromPtr(_arg_1);
            if (_arg_2 != 0)
            {
                log(3, (((("failed open(" + _local_4) + ") flags(") + _arg_2) + ")"));
                return (-1);
            };
            _local_5 = this.fetch(_local_4);
            if (_local_5.pending)
            {
                throw (new AlchemyBlock());
            };
            if (_local_5.size < 0)
            {
                log(3, (("failed open(" + _local_4) + ") doesn't exist"));
                return (-1);
            };
            _local_6 = 0;
            while (this.fds[_local_6])
            {
                _local_6++;
            };
            _local_7 = new ByteArrayIO();
            _local_7.byteArray = new ByteArray();
            _local_7.byteArray.writeBytes(_local_5.data);
            _local_7.byteArray.position = 0;
            this.fds[_local_6] = _local_7;
            log(4, ((("open(" + _local_4) + "): ") + _local_7.size));
            return (_local_6);
        }

        public function psize(_arg_1:int):int
        {
            var _local_2:String;
            var _local_3:Object;
            _local_2 = gstate.gworker.stringFromPtr(_arg_1);
            _local_3 = this.fetch(_local_2);
            if (_local_3.pending)
            {
                throw (new AlchemyBlock());
            };
            if (_local_3.size < 0)
            {
                log(3, (("psize(" + _local_2) + ") failed"));
            }
            else
            {
                log(3, ((("psize(" + _local_2) + "): ") + _local_3.size));
            };
            return (_local_3.size);
        }

        public function read(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return (this.fds[_arg_1].read(_arg_2, _arg_3));
        }

        public function getenv():Object
        {
            return (genv);
        }

        public function write(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return (this.fds[_arg_1].write(_arg_2, _arg_3));
        }

        public function access(_arg_1:int, _arg_2:int):int
        {
            var _local_3:String;
            var _local_4:Object;
            _local_3 = gstate.gworker.stringFromPtr(_arg_1);
            if ((_arg_2 & (~(0x04))))
            {
                log(3, (((("failed access(" + _local_3) + ") mode(") + _arg_2) + ")"));
                return (-1);
            };
            _local_4 = this.fetch(_local_3);
            if (_local_4.pending)
            {
                throw (new AlchemyBlock());
            };
            log(3, ((("access(" + _local_3) + "): ") + (_local_4.size >= 0)));
            if (_local_4.size < 0)
            {
                return (-1);
            };
            return (0);
        }

        public function exit(_arg_1:int):void
        {
            log(3, ("exit: " + _arg_1));
            shellExit(_arg_1);
        }

        public function fsize(_arg_1:int):int
        {
            return (this.fds[_arg_1].size);
        }

        public function tell(_arg_1:int):int
        {
            return (this.fds[_arg_1].position);
        }

        public function ioctl(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return (-1);
        }

        public function close(_arg_1:int):int
        {
            var _local_2:int;
            _local_2 = this.fds[_arg_1].close();
            this.fds[_arg_1] = null;
            return (_local_2);
        }

        private function fetch(path:String):Object
        {
            var res:Object;
            var gf:ByteArray;
            var request:URLRequest;
            var loader:URLLoader;
            res = this.statCache[path];
            if (!res)
            {
                gf = gfiles[path];
                if (gf)
                {
                    res = {
                        "pending":false,
                        "size":gf.length,
                        "data":gf
                    };
                    this.statCache[path] = res;
                    return (res);
                };
            };
            if (this.forceSync)
            {
                return ((res) || ({
                    "size":-1,
                    "pending":false
                }));
            };
            if (!res)
            {
                request = new URLRequest(path);
                loader = new URLLoader();
                loader.dataFormat = URLLoaderDataFormat.BINARY;
                loader.addEventListener(Event.COMPLETE, function (_arg_1:Event):void
                {
                    statCache[path].data = loader.data;
                    statCache[path].size = loader.data.length;
                    statCache[path].pending = false;
                });
                loader.addEventListener(IOErrorEvent.IO_ERROR, function (_arg_1:Event):void
                {
                    statCache[path].size = -1;
                    statCache[path].pending = false;
                });
                this.statCache[path] = (res = {"pending":true});
                loader.load(request);
            };
            return (res);
        }

        public function setup(_arg_1:Function):void
        {
            (_arg_1());
        }


    }
}

