package com.ankama.haapi.client.model
{
    public class AccountOrigin 
    {

        public static const TypeEnum_game:String = "game";

        public var type:String = null;
        public var value:String = null;


        public function toString():String
        {
            var str:String = "AccountOrigin: ";
            str = (str + ((" (type: " + this.type) + ")"));
            str = (str + ((" (value: " + this.value) + ")"));
            return (str);
        }


    }
}

