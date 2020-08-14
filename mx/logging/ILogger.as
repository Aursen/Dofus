package mx.logging
{
    import flash.events.IEventDispatcher;

    public interface ILogger extends IEventDispatcher 
    {

        function get category():String;
        function log(_arg_1:int, _arg_2:String, ... _args):void;
        function debug(_arg_1:String, ... _args):void;
        function error(_arg_1:String, ... _args):void;
        function fatal(_arg_1:String, ... _args):void;
        function info(_arg_1:String, ... _args):void;
        function warn(_arg_1:String, ... _args):void;

    }
} mx.logging

