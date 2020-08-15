package mx.core
{
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public interface IChildList 
    {

        function get numChildren():int;
        function addChild(_arg_1:DisplayObject):DisplayObject;
        function addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject;
        function removeChild(_arg_1:DisplayObject):DisplayObject;
        function removeChildAt(_arg_1:int):DisplayObject;
        function getChildAt(_arg_1:int):DisplayObject;
        function getChildByName(_arg_1:String):DisplayObject;
        function getChildIndex(_arg_1:DisplayObject):int;
        function setChildIndex(_arg_1:DisplayObject, _arg_2:int):void;
        function getObjectsUnderPoint(_arg_1:Point):Array;
        function contains(_arg_1:DisplayObject):Boolean;

    }
}

