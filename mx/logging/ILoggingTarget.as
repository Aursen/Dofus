package mx.logging
{
    public interface ILoggingTarget 
    {

        function get filters():Array;
        function set filters(_arg_1:Array):void;
        function get level():int;
        function set level(_arg_1:int):void;
        function addLogger(_arg_1:ILogger):void;
        function removeLogger(_arg_1:ILogger):void;

    }
}

