package mx.managers
{
    [ExcludeClass]
    public interface ICursorManager 
    {

        function get currentCursorID():int;
        function set currentCursorID(_arg_1:int):void;
        function get currentCursorXOffset():Number;
        function set currentCursorXOffset(_arg_1:Number):void;
        function get currentCursorYOffset():Number;
        function set currentCursorYOffset(_arg_1:Number):void;
        function showCursor():void;
        function hideCursor():void;
        function setCursor(_arg_1:Class, _arg_2:int=2, _arg_3:Number=0, _arg_4:Number=0):int;
        function removeCursor(_arg_1:int):void;
        function removeAllCursors():void;
        function setBusyCursor():void;
        function removeBusyCursor():void;
        function registerToUseBusyCursor(_arg_1:Object):void;
        function unRegisterToUseBusyCursor(_arg_1:Object):void;

    }
} mx.managers

