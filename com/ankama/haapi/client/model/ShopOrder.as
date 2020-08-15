package com.ankama.haapi.client.model
{
    public class ShopOrder 
    {

        public var id:Number = 0;
        public var status:String = null;
        private var _articles_obj_class:Array = null;
        public var articles:Array = new Array();


        public function toString():String
        {
            var str:String = "ShopOrder: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (status: " + this.status) + ")"));
            str = (str + ((" (articles: " + this.articles) + ")"));
            return (str);
        }


    }
}

