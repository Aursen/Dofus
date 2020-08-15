package com.ankama.haapi.client.model
{
    public class ShopOneClickToken 
    {

        public var id:Number = 0;
        public var pan:String = null;
        public var brand:String = null;
        public var expiry_year:Number = 0;
        public var expiry_month:Number = 0;
        public var security_method:String = null;
        public var security_method_value:String = null;
        public var added_date:String = null;


        public function toString():String
        {
            var str:String = "ShopOneClickToken: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (pan: " + this.pan) + ")"));
            str = (str + ((" (brand: " + this.brand) + ")"));
            str = (str + ((" (expiry_year: " + this.expiry_year) + ")"));
            str = (str + ((" (expiry_month: " + this.expiry_month) + ")"));
            str = (str + ((" (security_method: " + this.security_method) + ")"));
            str = (str + ((" (security_method_value: " + this.security_method_value) + ")"));
            str = (str + ((" (added_date: " + this.added_date) + ")"));
            return (str);
        }


    }
}

