package com.ankama.haapi.client.model
{
    public class ShopGondolaHead 
    {

        private var _image_obj_class:Array = null;
        public var image:Array = new Array();
        public var home:Boolean = false;
        public var main:Boolean = false;
        public var link:String = null;
        public var name:String = null;
        public var id:Number = 0;


        public function toString():String
        {
            var str:String = "ShopGondolaHead: ";
            str = (str + ((" (image: " + this.image) + ")"));
            str = (str + ((" (home: " + this.home) + ")"));
            str = (str + ((" (main: " + this.main) + ")"));
            str = (str + ((" (link: " + this.link) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (id: " + this.id) + ")"));
            return (str);
        }


    }
}

