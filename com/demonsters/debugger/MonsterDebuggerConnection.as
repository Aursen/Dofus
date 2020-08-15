package com.demonsters.debugger
{
    internal class MonsterDebuggerConnection 
    {

        private static var connector:IMonsterDebuggerConnection;


        internal static function initialize():void
        {
            connector = new MonsterDebuggerConnectionDefault();
        }

        internal static function processQueue():void
        {
            connector.processQueue();
        }

        internal static function set address(value:String):void
        {
            connector.address = value;
        }

        internal static function get connected():Boolean
        {
            return (connector.connected);
        }

        internal static function connect():void
        {
            connector.connect();
        }

        internal static function send(id:String, data:Object, direct:Boolean=false):void
        {
            connector.send(id, data, direct);
        }


    }
}

