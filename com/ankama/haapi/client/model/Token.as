package com.ankama.haapi.client.model
{
    public class Token 
    {

        public var token:String = null;


        public function toString():String
        {
            var str:String = "Token: ";
            str = (str + ((" (token: " + this.token) + ")"));
            return (str);
        }


    }
}

