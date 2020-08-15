package com.ankama.zaap
{
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import org.apache.thrift.protocol.TProtocol;
    import org.apache.thrift.protocol.TBinaryProtocol;
    import flash.events.ErrorEvent;

    public class ZaapClient extends EventDispatcher 
    {

        public var client:ZaapService;
        public var connection:TFixedSocket;
        public var session:String;
        private var _port:int;
        private var _gameName:String;
        private var _gameRelease:String;
        private var _instanceId:int;
        private var _hash:String;
        private var _onConnectErrorCallback:Function;
        private var _onConnectSuccessCallback:Function;
        private var _onConnectClosedCallback:Function;


        public function connect(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:int, _arg_5:String, _arg_6:Function, _arg_7:Function, _arg_8:Function):void
        {
            this._port = _arg_1;
            this._gameName = _arg_2;
            this._gameRelease = _arg_3;
            this._instanceId = _arg_4;
            this._hash = _arg_5;
            this._onConnectErrorCallback = _arg_6;
            this._onConnectSuccessCallback = _arg_7;
            this._onConnectClosedCallback = _arg_8;
            this.connection = new TFixedSocket("localhost", this._port);
            this.connection.addEventListener(Event.CONNECT, this.onSocketConnected);
            this.connection.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketError);
            this.connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSocketError);
            this.connection.addEventListener(Event.CLOSE, this.onSocketClosed);
            this.connection.open();
        }

        public function disconnect():void
        {
            if (((this.connection) && (this.connection.isOpen())))
            {
                this.connection.close();
            };
            this.client = null;
            this.connection = null;
            this.session = null;
            this._port = 0;
            this._gameName = null;
            this._gameRelease = null;
            this._instanceId = 0;
            this._hash = null;
            this._onConnectErrorCallback = null;
            this._onConnectSuccessCallback = null;
            this._onConnectClosedCallback = null;
        }

        private function onSocketConnected(e:Event):void
        {
            this.removeSocketEventListeners();
            var protocol:TProtocol = new TBinaryProtocol(this.connection);
            this.client = new ZaapServiceImpl(protocol);
            this.client.connect(this._gameName, this._gameRelease, this._instanceId, this._hash, this.onConnectError, function (_arg_1:String):void
            {
                session = _arg_1;
                if (_onConnectSuccessCallback != null)
                {
                    _onConnectSuccessCallback();
                };
            });
        }

        private function onConnectError(_arg_1:Error):void
        {
            this.onSocketError(new ErrorEvent(_arg_1.name, false, false, _arg_1.message, _arg_1.errorID));
        }

        private function onSocketClosed(_arg_1:Event):void
        {
            this.removeSocketEventListeners();
            if (this._onConnectClosedCallback != null)
            {
                this._onConnectClosedCallback(_arg_1);
            };
            this.disconnect();
        }

        private function onSocketError(_arg_1:Event):void
        {
            this.removeSocketEventListeners();
            if (this._onConnectErrorCallback != null)
            {
                this._onConnectErrorCallback(_arg_1);
            };
            this.disconnect();
        }

        private function removeSocketEventListeners():void
        {
            this.connection.removeEventListener(Event.CONNECT, this.onSocketConnected);
            this.connection.removeEventListener(IOErrorEvent.IO_ERROR, this.onSocketError);
            this.connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSocketError);
            this.connection.removeEventListener(Event.CLOSE, this.onSocketError);
        }


    }
}

