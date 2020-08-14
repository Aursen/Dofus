package com.ankama.haapi.client.model
{
    public class AlmanaxEvent 
    {

        public var id:Number = 0;
        public var type:String = null;
        public var mobile_info:String = null;
        public var color:String = null;
        public var date:Date = null;
        public var color_date:String = null;
        public var recurring:Boolean = false;
        public var background:Boolean = false;
        public var background_url:String = null;
        public var day_background_url:String = null;
        public var border_background_url:String = null;
        public var image_url:String = null;
        public var name:String = null;
        public var boss_image_url:String = null;
        public var boss_name:String = null;
        public var boss_text:String = null;
        public var ephemeris:String = null;
        public var rubrikabrax:String = null;
        public var show_fest:Boolean = false;
        public var fest_text:String = null;
        public var weight:Number = 0;


        public function toString():String
        {
            var str:String = "AlmanaxEvent: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (type: " + this.type) + ")"));
            str = (str + ((" (mobile_info: " + this.mobile_info) + ")"));
            str = (str + ((" (color: " + this.color) + ")"));
            str = (str + ((" (date: " + this.date) + ")"));
            str = (str + ((" (color_date: " + this.color_date) + ")"));
            str = (str + ((" (recurring: " + this.recurring) + ")"));
            str = (str + ((" (background: " + this.background) + ")"));
            str = (str + ((" (background_url: " + this.background_url) + ")"));
            str = (str + ((" (day_background_url: " + this.day_background_url) + ")"));
            str = (str + ((" (border_background_url: " + this.border_background_url) + ")"));
            str = (str + ((" (image_url: " + this.image_url) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (boss_image_url: " + this.boss_image_url) + ")"));
            str = (str + ((" (boss_name: " + this.boss_name) + ")"));
            str = (str + ((" (boss_text: " + this.boss_text) + ")"));
            str = (str + ((" (ephemeris: " + this.ephemeris) + ")"));
            str = (str + ((" (rubrikabrax: " + this.rubrikabrax) + ")"));
            str = (str + ((" (show_fest: " + this.show_fest) + ")"));
            str = (str + ((" (fest_text: " + this.fest_text) + ")"));
            str = (str + ((" (weight: " + this.weight) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

