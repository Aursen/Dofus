package com.ankama.haapi.client.model
{
    public class CmsPollInGame 
    {

        public var item_id:Number = 0;
        public var title:String = null;
        public var description:String = null;
        public var url:String = null;
        public var criterion:String = null;


        public function toString():String
        {
            var str:String = "CmsPollInGame: ";
            str = (str + ((" (item_id: " + this.item_id) + ")"));
            str = (str + ((" (title: " + this.title) + ")"));
            str = (str + ((" (description: " + this.description) + ")"));
            str = (str + ((" (url: " + this.url) + ")"));
            str = (str + ((" (criterion: " + this.criterion) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

