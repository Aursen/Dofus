package com.ankama.haapi.client.model
{
    public class ShopCategory 
    {

        public var id:Number = 0;
        public var key:String = null;
        public var name:String = null;
        public var displaymode:String = null;
        public var description:String = null;
        public var url:String = null;
        private var _child_obj_class:Array = null;
        public var child:Array = new Array();


        public function toString():String
        {
            var str:String = "ShopCategory: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (key: " + this.key) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (displaymode: " + this.displaymode) + ")"));
            str = (str + ((" (description: " + this.description) + ")"));
            str = (str + ((" (url: " + this.url) + ")"));
            str = (str + ((" (child: " + this.child) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

