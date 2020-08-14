package com.ankama.haapi.client.model
{
    public class AlmanaxMonth 
    {

        public var id:Number = 0;
        public var month:Number = 0;
        public var name:String = null;
        public var color:String = null;
        public var background:Boolean = false;
        public var background_url:String = null;
        public var protector_name:String = null;
        public var protector_description:String = null;
        public var protector_image_url:String = null;


        public function toString():String
        {
            var str:String = "AlmanaxMonth: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (month: " + this.month) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (color: " + this.color) + ")"));
            str = (str + ((" (background: " + this.background) + ")"));
            str = (str + ((" (background_url: " + this.background_url) + ")"));
            str = (str + ((" (protector_name: " + this.protector_name) + ")"));
            str = (str + ((" (protector_description: " + this.protector_description) + ")"));
            str = (str + ((" (protector_image_url: " + this.protector_image_url) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

