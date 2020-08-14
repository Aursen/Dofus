package com.ankama.haapi.client.model
{
    public class ShopArticle 
    {

        public var id:Number = 0;
        public var key:String = null;
        public var name:String = null;
        public var subtitle:String = null;
        public var description:String = null;
        public var currency:String = null;
        public var original_price:Number = 0;
        public var price:Number = 0;
        public var startdate:Date = null;
        public var enddate:Date = null;
        public var showCountDown:Boolean = false;
        public var stock:Number = 0;
        private var _image_obj_class:Array = null;
        public var image:Array = new Array();
        private var _references_obj_class:Array = null;
        public var references:Array = new Array();
        private var _promo_obj_class:Array = null;
        public var promo:Array = new Array();
        private var _media_obj_class:Array = null;
        public var media:Array = new Array();
        private var _metas_obj_class:Array = null;
        public var metas:Array = new Array();
        private var _pricelist_obj_class:Array = null;
        public var pricelist:Array = new Array();
        public var most_precise_category_id:Number = 0;


        public function toString():String
        {
            var str:String = "ShopArticle: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (key: " + this.key) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (subtitle: " + this.subtitle) + ")"));
            str = (str + ((" (description: " + this.description) + ")"));
            str = (str + ((" (currency: " + this.currency) + ")"));
            str = (str + ((" (original_price: " + this.original_price) + ")"));
            str = (str + ((" (price: " + this.price) + ")"));
            str = (str + ((" (startdate: " + this.startdate) + ")"));
            str = (str + ((" (enddate: " + this.enddate) + ")"));
            str = (str + ((" (showCountDown: " + this.showCountDown) + ")"));
            str = (str + ((" (stock: " + this.stock) + ")"));
            str = (str + ((" (image: " + this.image) + ")"));
            str = (str + ((" (references: " + this.references) + ")"));
            str = (str + ((" (promo: " + this.promo) + ")"));
            str = (str + ((" (media: " + this.media) + ")"));
            str = (str + ((" (metas: " + this.metas) + ")"));
            str = (str + ((" (pricelist: " + this.pricelist) + ")"));
            str = (str + ((" (most_precise_category_id: " + this.most_precise_category_id) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

