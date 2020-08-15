package com.ankama.haapi.client.model
{
    public class KardTicket 
    {

        private var _order_list_obj_class:Array = null;
        public var order_list:Array = new Array();
        private var _kard_list_obj_class:Array = null;
        public var kard_list:Array = new Array();


        public function toString():String
        {
            var str:String = "KardTicket: ";
            str = (str + ((" (order_list: " + this.order_list) + ")"));
            str = (str + ((" (kard_list: " + this.kard_list) + ")"));
            return (str);
        }


    }
}

