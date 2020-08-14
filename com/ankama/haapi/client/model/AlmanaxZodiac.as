package com.ankama.haapi.client.model
{
    public class AlmanaxZodiac 
    {

        public var id:Number = 0;
        public var begin:Date = null;
        public var end:Date = null;
        public var color:String = null;
        public var background:Boolean = false;
        public var background_url:String = null;
        public var name:String = null;
        public var description:String = null;
        public var image_url:String = null;


        public function toString():String
        {
            var str:String = "AlmanaxZodiac: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (begin: " + this.begin) + ")"));
            str = (str + ((" (end: " + this.end) + ")"));
            str = (str + ((" (color: " + this.color) + ")"));
            str = (str + ((" (background: " + this.background) + ")"));
            str = (str + ((" (background_url: " + this.background_url) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (description: " + this.description) + ")"));
            str = (str + ((" (image_url: " + this.image_url) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

