package com.ankama.haapi.client.model
{
    public class SessionLogin 
    {

        public var id:Number = 0;
        public var id_string:String = null;
        public var account:Account = null;
        public var game:GameAccount = null;


        public function toString():String
        {
            var str:String = "SessionLogin: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (id_string: " + this.id_string) + ")"));
            str = (str + ((" (account: " + this.account) + ")"));
            str = (str + ((" (game: " + this.game) + ")"));
            return (str);
        }


    }
}

