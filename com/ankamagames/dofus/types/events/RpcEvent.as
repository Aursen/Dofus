package com.ankamagames.dofus.types.events
{
    import flash.events.Event;

    public class RpcEvent extends Event 
    {

        public static const EVENT_DATA:String = "RpcEvent_data";
        public static const EVENT_ERROR:String = "RpcEvent_error";

        private var _result:Object;
        private var _method:String;

        public function RpcEvent(_arg_1:String, method:String, result:Object=null)
        {
            super(_arg_1, false, false);
            this._result = result;
            this._method = method;
        }

        public function get result():Object
        {
            return (this._result);
        }

        public function get method():String
        {
            return (this._method);
        }


    }
}

