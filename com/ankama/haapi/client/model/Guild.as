package com.ankama.haapi.client.model
{
    public class Guild 
    {

        public var id:Number = 0;
        public var name:String = null;
        public var level:Number = 0;


        public function toString():String
        {
            var str:String = "Guild: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (level: " + this.level) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

