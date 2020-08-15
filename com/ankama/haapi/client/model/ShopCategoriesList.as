package com.ankama.haapi.client.model
{
    public class ShopCategoriesList 
    {

        public var total_count:Number = 0;
        private var _categories_obj_class:Array = null;
        public var categories:Array = new Array();


        public function toString():String
        {
            var str:String = "ShopCategoriesList: ";
            str = (str + ((" (total_count: " + this.total_count) + ")"));
            str = (str + ((" (categories: " + this.categories) + ")"));
            return (str);
        }


    }
}

