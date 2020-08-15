package com.ankama.haapi.client.model
{
    public class ShopBuyResult 
    {

        public static const OrderStatusEnum_PENDING:String = "PENDING";
        public static const OrderStatusEnum_CANCELED:String = "CANCELED";
        public static const OrderStatusEnum_TO_PREPARE:String = "TO_PREPARE";
        public static const OrderStatusEnum_IN_PROGRESS:String = "IN_PROGRESS";
        public static const OrderStatusEnum_PROCESSED:String = "PROCESSED";

        private var _balance_obj_class:Array = null;
        public var balance:Array = new Array();
        public var order_id:Number = 0;
        public var order_status:String = null;


        public function toString():String
        {
            var str:String = "ShopBuyResult: ";
            str = (str + ((" (balance: " + this.balance) + ")"));
            str = (str + ((" (order_id: " + this.order_id) + ")"));
            str = (str + ((" (order_status: " + this.order_status) + ")"));
            return (str);
        }


    }
}

