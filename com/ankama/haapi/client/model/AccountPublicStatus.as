package com.ankama.haapi.client.model
{
    public class AccountPublicStatus 
    {

        public var id:String = null;
        public var value:String = null;


        public function toString():String
        {
            var str:String = "AccountPublicStatus: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (value: " + this.value) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

