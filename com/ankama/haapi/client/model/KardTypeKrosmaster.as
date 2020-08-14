package com.ankama.haapi.client.model
{
    public class KardTypeKrosmaster 
    {

        public var id:Number = 0;
        public var name:String = null;
        public var pedestal_id:Number = 0;
        public var pedestal_name:String = null;


        public function toString():String
        {
            var str:String = "KardTypeKrosmaster: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (pedestal_id: " + this.pedestal_id) + ")"));
            str = (str + ((" (pedestal_name: " + this.pedestal_name) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

