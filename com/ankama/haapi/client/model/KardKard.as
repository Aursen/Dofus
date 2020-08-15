package com.ankama.haapi.client.model
{
    public class KardKard 
    {

        public var id:Number = 0;
        public var name:String = null;
        public var image:String = null;
        public var description:String = null;
        public var type:String = null;
        private var _kards_obj_class:Array = null;
        public var kards:Array = new Array();
        private var _kard_multiple_obj_class:Array = null;
        public var kard_multiple:Array = new Array();
        public var kard_krosmaster:KardTypeKrosmaster = null;
        public var kard_game_action:KardTypeAction = null;
        public var kard_action:KardTypeAction = null;
        public var kard_virtual_subscription_level:KardTypeVirtualSubscriptionLevel = null;
        public var kard_virtual_subscription:KardTypeVirtualSubscription = null;


        public function toString():String
        {
            var str:String = "KardKard: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (image: " + this.image) + ")"));
            str = (str + ((" (description: " + this.description) + ")"));
            str = (str + ((" (type: " + this.type) + ")"));
            str = (str + ((" (kards: " + this.kards) + ")"));
            str = (str + ((" (kard_multiple: " + this.kard_multiple) + ")"));
            str = (str + ((" (kard_krosmaster: " + this.kard_krosmaster) + ")"));
            str = (str + ((" (kard_game_action: " + this.kard_game_action) + ")"));
            str = (str + ((" (kard_action: " + this.kard_action) + ")"));
            str = (str + ((" (kard_virtual_subscription_level: " + this.kard_virtual_subscription_level) + ")"));
            str = (str + ((" (kard_virtual_subscription: " + this.kard_virtual_subscription) + ")"));
            return (str);
        }


    }
}

