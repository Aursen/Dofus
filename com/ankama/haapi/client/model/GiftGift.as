package com.ankama.haapi.client.model
{
    public class GiftGift 
    {

        public var id:Number = 0;
        public var action_id:Number = 0;
        public var game_id:Number = 0;
        public var type:Number = 0;
        public var params:String = null;
        public var description:String = null;
        public var text:String = null;
        public var title:String = null;
        public var version_restriction:String = null;
        private var _server_limitation_obj_class:Array = null;
        public var server_limitation:Array = new Array();
        public var distribution:String = null;
        private var _pictures_obj_class:Array = null;
        public var pictures:Array = new Array();


        public function toString():String
        {
            var str:String = "GiftGift: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (action_id: " + this.action_id) + ")"));
            str = (str + ((" (game_id: " + this.game_id) + ")"));
            str = (str + ((" (type: " + this.type) + ")"));
            str = (str + ((" (params: " + this.params) + ")"));
            str = (str + ((" (description: " + this.description) + ")"));
            str = (str + ((" (text: " + this.text) + ")"));
            str = (str + ((" (title: " + this.title) + ")"));
            str = (str + ((" (version_restriction: " + this.version_restriction) + ")"));
            str = (str + ((" (server_limitation: " + this.server_limitation) + ")"));
            str = (str + ((" (distribution: " + this.distribution) + ")"));
            str = (str + ((" (pictures: " + this.pictures) + ")"));
            return (str);
        }


    }
}

