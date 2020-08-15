package com.ankama.haapi.client.model
{
    public class KardKardStock 
    {

        public var id:Number = 0;
        public var kard:KardKard = null;


        public function toString():String
        {
            var str:String = "KardKardStock: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (kard: " + this.kard) + ")"));
            return (str);
        }


    }
}

