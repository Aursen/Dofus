package com.ankama.haapi.client.model
{
    public class MoneyBalance 
    {

        public static const CurrencyEnum_OGR:String = "OGR";
        public static const CurrencyEnum_KRZ:String = "KRZ";
        public static const CurrencyEnum_FRG:String = "FRG";
        public static const CurrencyEnum_GOU:String = "GOU";

        public var currency:String = null;
        public var amount:Number = 0;


        public function toString():String
        {
            var str:String = "MoneyBalance: ";
            str = (str + ((" (currency: " + this.currency) + ")"));
            str = (str + ((" (amount: " + this.amount) + ")"));
            return (str);
        }


    }
}

