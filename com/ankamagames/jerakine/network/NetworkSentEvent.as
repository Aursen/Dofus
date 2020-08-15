package com.ankamagames.jerakine.network
{
    import flash.events.Event;

    public class NetworkSentEvent extends Event 
    {

        public static const EVENT_SENT:String = "messageSent";

        private var _message:INetworkMessage;

        public function NetworkSentEvent(_arg_1:String, msg:INetworkMessage)
        {
            super(_arg_1, false, false);
            this._message = msg;
        }

        public function get message():INetworkMessage
        {
            return (this._message);
        }


    }
}

