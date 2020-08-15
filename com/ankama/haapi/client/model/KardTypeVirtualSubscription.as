package com.ankama.haapi.client.model
{
    public class KardTypeVirtualSubscription 
    {

        public var game:Number = 0;
        public var quantity:Number = 0;


        public function toString():String
        {
            var str:String = "KardTypeVirtualSubscription: ";
            str = (str + ((" (game: " + this.game) + ")"));
            str = (str + ((" (quantity: " + this.quantity) + ")"));
            return (str);
        }


    }
}

