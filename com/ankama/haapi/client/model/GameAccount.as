package com.ankama.haapi.client.model
{
    public class GameAccount 
    {

        public var game_id:Number = 0;
        public var total_time_elapsed:Number = 0;
        public var subscribed:Boolean = false;
        public var first_subscription_date:Date = null;
        public var expiration_date:Date = null;
        public var free_expiration_date:Date = null;
        public var ban_end_date:Date = null;
        public var added_date:Date = null;
        public var login_date:Date = null;
        public var login_ip:String = null;


        public function toString():String
        {
            var str:String = "GameAccount: ";
            str = (str + ((" (game_id: " + this.game_id) + ")"));
            str = (str + ((" (total_time_elapsed: " + this.total_time_elapsed) + ")"));
            str = (str + ((" (subscribed: " + this.subscribed) + ")"));
            str = (str + ((" (first_subscription_date: " + this.first_subscription_date) + ")"));
            str = (str + ((" (expiration_date: " + this.expiration_date) + ")"));
            str = (str + ((" (free_expiration_date: " + this.free_expiration_date) + ")"));
            str = (str + ((" (ban_end_date: " + this.ban_end_date) + ")"));
            str = (str + ((" (added_date: " + this.added_date) + ")"));
            str = (str + ((" (login_date: " + this.login_date) + ")"));
            str = (str + ((" (login_ip: " + this.login_ip) + ")"));
            return (str);
        }


    }
}

