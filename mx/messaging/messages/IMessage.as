package mx.messaging.messages
{
    public interface IMessage 
    {

        function get body():Object;
        function set body(_arg_1:Object):void;
        function get clientId():String;
        function set clientId(_arg_1:String):void;
        function get destination():String;
        function set destination(_arg_1:String):void;
        function get headers():Object;
        function set headers(_arg_1:Object):void;
        function get messageId():String;
        function set messageId(_arg_1:String):void;
        function get timestamp():Number;
        function set timestamp(_arg_1:Number):void;
        function get timeToLive():Number;
        function set timeToLive(_arg_1:Number):void;
        function toString():String;

    }
} mx.messaging.messages

