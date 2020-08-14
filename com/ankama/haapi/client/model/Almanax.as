package com.ankama.haapi.client.model
{
    public class Almanax 
    {

        public var event:AlmanaxEvent = null;
        public var zodiac:AlmanaxZodiac = null;
        public var month:AlmanaxMonth = null;


        public function toString():String
        {
            var str:String = "Almanax: ";
            str = (str + ((" (event: " + this.event) + ")"));
            str = (str + ((" (zodiac: " + this.zodiac) + ")"));
            str = (str + ((" (month: " + this.month) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

