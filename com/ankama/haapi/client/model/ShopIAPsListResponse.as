package com.ankama.haapi.client.model
{
    public class ShopIAPsListResponse 
    {

        public var key:String = null;
        public var type:String = null;


        public function toString():String
        {
            var str:String = "ShopIAPsListResponse: ";
            str = (str + ((" (key: " + this.key) + ")"));
            str = (str + ((" (type: " + this.type) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

