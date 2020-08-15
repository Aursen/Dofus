package com.ankama.haapi.client.model
{
    public class Avatar 
    {

        public var url:String = null;


        public function toString():String
        {
            var str:String = "Avatar: ";
            str = (str + ((" (url: " + this.url) + ")"));
            return (str);
        }


    }
}

