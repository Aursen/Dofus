package com.ankama.haapi.client.model
{
    public class ShopHighlight 
    {

        public var id:Number = 0;
        private var _image_obj_class:Array = null;
        public var image:Array = new Array();
        public var mode:String = null;
        public var type:String = null;
        public var link:String = null;
        public var description:String = null;
        public var name:String = null;
        public var external_category:ShopCategory = null;
        public var external_article:ShopArticle = null;
        public var external_gondolahead:ShopGondolaHead = null;
        public var external_direct:String = null;


        public function toString():String
        {
            var str:String = "ShopHighlight: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (image: " + this.image) + ")"));
            str = (str + ((" (mode: " + this.mode) + ")"));
            str = (str + ((" (type: " + this.type) + ")"));
            str = (str + ((" (link: " + this.link) + ")"));
            str = (str + ((" (description: " + this.description) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (external_category: " + this.external_category) + ")"));
            str = (str + ((" (external_article: " + this.external_article) + ")"));
            str = (str + ((" (external_gondolahead: " + this.external_gondolahead) + ")"));
            str = (str + ((" (external_direct: " + this.external_direct) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

