package com.ankama.haapi.client.model
{
    public class ShopHome 
    {

        private var _categories_obj_class:Array = null;
        public var categories:Array = new Array();
        private var _gondolahead_main_obj_class:Array = null;
        public var gondolahead_main:Array = new Array();
        private var _gondolahead_article_obj_class:Array = null;
        public var gondolahead_article:Array = new Array();
        private var _hightlight_carousel_obj_class:Array = null;
        public var hightlight_carousel:Array = new Array();
        private var _hightlight_image_obj_class:Array = null;
        public var hightlight_image:Array = new Array();
        private var _hightlight_popup_obj_class:Array = null;
        public var hightlight_popup:Array = new Array();


        public function toString():String
        {
            var str:String = "ShopHome: ";
            str = (str + ((" (categories: " + this.categories) + ")"));
            str = (str + ((" (gondolahead_main: " + this.gondolahead_main) + ")"));
            str = (str + ((" (gondolahead_article: " + this.gondolahead_article) + ")"));
            str = (str + ((" (hightlight_carousel: " + this.hightlight_carousel) + ")"));
            str = (str + ((" (hightlight_image: " + this.hightlight_image) + ")"));
            str = (str + ((" (hightlight_popup: " + this.hightlight_popup) + ")"));
            return (str);
        }


    }
}

