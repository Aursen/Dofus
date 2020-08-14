package com.ankama.zaap
{
    import org.apache.thrift.transport.TTransport;
    import flash.net.Socket;
    import flash.utils.ByteArray;
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import flash.events.EventDispatcher;
    import flash.errors.EOFError;
    import org.apache.thrift.transport.TTransportError;
    import flash.errors.IOError;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.ProgressEvent;

    public class TFixedSocket extends TTransport 
    {

        private var socket:Socket = null;
        private var host:String;
        private var port:int;
        private var obuffer:ByteArray = new ByteArray();
        private var input:IDataInput;
        private var output:IDataOutput;
        private var ioCallback:Function = null;
        private var eventDispatcher:EventDispatcher = new EventDispatcher();

        public function TFixedSocket(_arg_1:String, _arg_2:int):void
        {
            this.host = _arg_1;
            this.port = _arg_2;
        }

        override public function close():void
        {
            this.input = null;
            this.output = null;
            this.socket.close();
        }

        override public function peek():Boolean
        {
            if (this.socket.connected)
            {
                return (this.socket.bytesAvailable > 0);
            };
            return (false);
        }

        override public function read(buf:ByteArray, off:int, len:int):int
        {
            try
            {
                this.input.readBytes(buf, off, len);
            }
            catch(e:EOFError)
            {
                throw (new TTransportError(TTransportError.END_OF_FILE, "No more data available."));
            }
            catch(e:IOError)
            {
                if (isOpen())
                {
                    throw (new TTransportError(TTransportError.UNKNOWN, ("IO error while reading: " + e)));
                };
                throw (new TTransportError(TTransportError.NOT_OPEN, ("Socket seem not to be opened: " + e)));
            }
            catch(e:Error)
            {
                throw (new TTransportError(TTransportError.UNKNOWN, ("Bad IO error: " + e)));
            };
            return (len);
        }

        override public function write(_arg_1:ByteArray, _arg_2:int, _arg_3:int):void
        {
            this.obuffer.writeBytes(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this.eventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this.eventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        override public function open():void
        {
            this.socket = new Socket();
            this.socket.addEventListener(Event.CONNECT, this.socketConnected);
            this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.socketError);
            this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.socketSecurityError);
            this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.socketDataHandler);
            this.socket.addEventListener(Event.CLOSE, this.socketClosed);
            this.socket.connect(this.host, this.port);
        }

        public function socketConnected(_arg_1:Event):void
        {
            this.output = this.socket;
            this.input = this.socket;
            this.eventDispatcher.dispatchEvent(_arg_1);
        }

        public function socketError(_arg_1:IOErrorEvent):void
        {
            this.close();
            if (this.ioCallback != null)
            {
                this.ioCallback(new TTransportError(TTransportError.UNKNOWN, ("IOError: " + _arg_1.text)));
            };
            this.eventDispatcher.dispatchEvent(_arg_1);
        }

        public function socketSecurityError(_arg_1:SecurityErrorEvent):void
        {
            this.close();
            this.eventDispatcher.dispatchEvent(_arg_1);
        }

        public function socketClosed(_arg_1:Event):void
        {
            this.input = null;
            this.output = null;
            this.eventDispatcher.dispatchEvent(_arg_1);
        }

        public function socketDataHandler(_arg_1:ProgressEvent):void
        {
            if (this.ioCallback != null)
            {
                this.ioCallback(null);
            };
            this.eventDispatcher.dispatchEvent(_arg_1);
        }

        override public function flush(_arg_1:Function=null):void
        {
            this.ioCallback = _arg_1;
            this.output.writeBytes(this.obuffer);
            this.socket.flush();
            this.obuffer.clear();
        }

        override public function isOpen():Boolean
        {
            return ((this.socket == null) ? false : this.socket.connected);
        }


    }
} com.ankama.zaap

