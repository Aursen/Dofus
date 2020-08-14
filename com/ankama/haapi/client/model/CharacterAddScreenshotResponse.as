package com.ankama.haapi.client.model
{
    public class CharacterAddScreenshotResponse 
    {

        public var status:Boolean = false;
        public var item_id:Number = 0;
        public var url:String = null;


        public function toString():String
        {
            var str:String = "CharacterAddScreenshotResponse: ";
            str = (str + ((" (status: " + this.status) + ")"));
            str = (str + ((" (item_id: " + this.item_id) + ")"));
            str = (str + ((" (url: " + this.url) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

