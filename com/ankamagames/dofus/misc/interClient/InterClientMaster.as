package com.ankamagames.dofus.misc.interClient
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.net.LocalConnection;
    import flash.events.AsyncErrorEvent;
    import flash.events.StatusEvent;
    import flash.utils.getTimer;

    public class InterClientMaster 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InterClientSlave));
        private static var _receiving_lc:LocalConnection;

        private var _sending_lc:LocalConnection;
        private var _lastPingTs:uint;
        private var _lastClientPing:Array = new Array();

        public function InterClientMaster()
        {
            this._sending_lc = new LocalConnection();
            this._sending_lc.allowDomain("*");
            this._sending_lc.allowInsecureDomain("*");
            this._sending_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onError);
            this._sending_lc.addEventListener(StatusEvent.STATUS, this.onStatusEvent);
            _receiving_lc.client = new Object();
            _receiving_lc.allowDomain("*");
            _receiving_lc.allowInsecureDomain("*");
            _receiving_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onError);
            _receiving_lc.addEventListener(StatusEvent.STATUS, this.onStatusEvent);
            _receiving_lc.client.ping = this.ping;
            _receiving_lc.client.clientGainFocus = this.clientGainFocus;
            _receiving_lc.client.updateFocusMessage = this.updateFocusMessage;
            this._lastPingTs = getTimer();
        }

        public static function etreLeCalif():InterClientMaster
        {
            try
            {
                if (!_receiving_lc)
                {
                    _receiving_lc = new LocalConnection();
                };
                _receiving_lc.connect("_dofus");
                return (new (InterClientMaster)());
            }
            catch(e:ArgumentError)
            {
            };
            return (null);
        }


        public function get isAlone():Boolean
        {
            return ((getTimer() - this._lastPingTs) > 20000);
        }

        public function destroy():void
        {
            this._sending_lc = null;
            _receiving_lc.close();
        }

        public function clientGainFocus(baseInfo:String):void
        {
            var clientListInfo:Array;
            var num:int;
            var i:int;
            var id:String;
            var info:Array = baseInfo.split(",");
            var connId:String = info[0];
            var time:Number = info[1];
            clientListInfo = InterClientManager.getInstance().clientListInfo;
            var index:int = clientListInfo.indexOf(connId);
            if (index == -1)
            {
                clientListInfo.push(connId, time);
            }
            else
            {
                clientListInfo[(index + 1)] = time;
            };
            var baseClientListInfo:String = clientListInfo.join(",");
            num = clientListInfo.length;
            i = 0;
            while (i < num)
            {
                id = clientListInfo[i];
                try
                {
                    this._sending_lc.send(id, "updateFocusMessage", baseClientListInfo);
                }
                catch(e:Error)
                {
                    _log.debug(e.getStackTrace());
                    clientListInfo.splice(i, 2);
                    i = (i - 2);
                    num = (num - 2);
                };
                i = (i + 2);
            };
        }

        private function onError(e:AsyncErrorEvent):void
        {
            _log.debug(e.error.getStackTrace());
        }

        private function onStatusEvent(e:StatusEvent):void
        {
        }

        public function updateFocusMessage(focusList:String):void
        {
            InterClientManager.getInstance().clientListInfo = focusList.split(",");
            InterClientManager.getInstance().updateFocusList();
        }

        private function ping(connId:String):void
        {
            var clientId:String;
            this._lastPingTs = getTimer();
            this._sending_lc.send(connId, "pong");
            this._lastClientPing[connId] = this._lastPingTs;
            var clientList:Array = InterClientManager.getInstance().clientListInfo;
            var num:int = clientList.length;
            var i:int;
            while (i < num)
            {
                clientId = clientList[i];
                if (clientId == "_dofus")
                {
                }
                else
                {
                    if (this._lastClientPing[clientId])
                    {
                        if ((this._lastPingTs - this._lastClientPing[clientId]) > 20000)
                        {
                            clientList.splice(i, 2);
                            i = (i - 2);
                            num = (num - 2);
                        };
                    }
                    else
                    {
                        this._lastClientPing[clientId] = this._lastPingTs;
                    };
                };
                i = (i + 2);
            };
        }


    }
} com.ankamagames.dofus.misc.interClient

