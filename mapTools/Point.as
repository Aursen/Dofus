package mapTools
{
    import flash.geom.Point;

    public class Point 
    {

        public var y:int;
        public var x:int;

        public function Point(_arg_1:int, _arg_2:int):void
        {
            x = _arg_1;
            y = _arg_2;
        }

        public function toString():String
        {
            return (((("Point(" + x) + ",") + y) + ")");
        }

        public function toFlashPoint():flash.geom.Point
        {
            return (new flash.geom.Point(x, y));
        }

        public function toArray():Array
        {
            return ([x, y]);
        }


    }
} mapTools

