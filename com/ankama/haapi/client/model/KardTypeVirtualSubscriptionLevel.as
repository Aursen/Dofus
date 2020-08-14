package com.ankama.haapi.client.model
{
    public class KardTypeVirtualSubscriptionLevel 
    {

        public var game:Number = 0;
        public var quantity:Number = 0;
        public var level:Number = 0;
        public var server:Number = 0;


        public function toString():String
        {
            var str:String = "KardTypeVirtualSubscriptionLevel: ";
            str = (str + ((" (game: " + this.game) + ")"));
            str = (str + ((" (quantity: " + this.quantity) + ")"));
            str = (str + ((" (level: " + this.level) + ")"));
            str = (str + ((" (server: " + this.server) + ")"));
            return (str);
        }


    }
} com.ankama.haapi.client.model

