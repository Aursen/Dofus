package mx.collections
{
    public interface ISortField 
    {

        function get arraySortOnOptions():int;
        function get compareFunction():Function;
        function set compareFunction(_arg_1:Function):void;
        function get descending():Boolean;
        function set descending(_arg_1:Boolean):void;
        function get name():String;
        function set name(_arg_1:String):void;
        function get numeric():Object;
        function set numeric(_arg_1:Object):void;
        function get sortCompareType():String;
        function set sortCompareType(_arg_1:String):void;
        function get usingCustomCompareFunction():Boolean;
        function initializeDefaultCompareFunction(_arg_1:Object):void;
        function reverse():void;
        function updateSortCompareType():Boolean;
        function objectHasSortField(_arg_1:Object):Boolean;

    }
}

