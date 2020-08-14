package com.ankama.haapi.client.model
{
    public class ShopArticlesList 
    {

        public var total_count:Number = 0;
        private var _articles_obj_class:Array = null;
        public var articles:Array = new Array();


        public function toString():String
        {
            var str:String = "ShopArticlesList: ";
            str = (str + ((" (total_count: " + this.total_count) + ")"));
            str = (str + ((" (articles: " + this.articles) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

