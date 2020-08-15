package com.ankama.haapi.client.model
{
    public class GameAdminRightWithApiKeyResponse 
    {

        private var _rights_obj_class:Array = null;
        public var rights:Array = new Array();


        public function toString():String
        {
            var str:String = "GameAdminRightWithApiKeyResponse: ";
            str = (str + ((" (rights: " + this.rights) + ")"));
            return (str);
        }


    }
}

