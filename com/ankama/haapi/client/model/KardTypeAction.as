package com.ankama.haapi.client.model
{
    public class KardTypeAction 
    {

        public var id:Number = 0;
        public var quantity:Number = 0;
        public var name:String = null;
        public var title:String = null;
        public var description:String = null;


        public function toString():String
        {
            var str:String = "KardTypeAction: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (quantity: " + this.quantity) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (title: " + this.title) + ")"));
            str = (str + ((" (description: " + this.description) + ")"));
            return (str);
        }


    }
}

