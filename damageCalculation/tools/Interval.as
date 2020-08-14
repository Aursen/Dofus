package damageCalculation.tools
{
    public class Interval 
    {

        public var min:int;
        public var max:int;

        public function Interval(_arg_1:int=0, _arg_2:int=0):void
        {
            min = _arg_1;
            max = _arg_2;
        }

        public function toString():String
        {
            return (((("[" + min) + " - ") + max) + "]");
        }

        public function toArray():Array
        {
            return ([min, max]);
        }

        public function subInterval(_arg_1:Interval):Interval
        {
            min = (min - _arg_1.min);
            max = (max - _arg_1.max);
            return (this);
        }

        public function setToZero():Interval
        {
            min = 0;
            max = 0;
            return (this);
        }

        public function multiplyInterval(_arg_1:Interval):Interval
        {
            min = (min * _arg_1.min);
            max = (max * _arg_1.max);
            return (this);
        }

        public function multiply(_arg_1:Number):Interval
        {
            min = (min * _arg_1);
            max = (max * _arg_1);
            return (this);
        }

        public function minimizeByInterval(_arg_1:Interval):Interval
        {
            if (min < _arg_1.min)
            {
                min = _arg_1.min;
            };
            if (max < _arg_1.max)
            {
                max = _arg_1.max;
            };
            return (this);
        }

        public function minimizeBy(_arg_1:int):Interval
        {
            if (min < _arg_1)
            {
                min = _arg_1;
            };
            if (max < _arg_1)
            {
                max = _arg_1;
            };
            return (this);
        }

        public function maximizeByInterval(_arg_1:Interval):Interval
        {
            if (min > _arg_1.min)
            {
                min = _arg_1.min;
            };
            if (max > _arg_1.max)
            {
                max = _arg_1.max;
            };
            return (this);
        }

        public function maximizeBy(_arg_1:int):Interval
        {
            if (min > _arg_1)
            {
                min = _arg_1;
            };
            if (max > _arg_1)
            {
                max = _arg_1;
            };
            return (this);
        }

        public function isZero():Boolean
        {
            if (min == 0)
            {
                return (max == 0);
            };
            return (false);
        }

        public function increaseByPercent(_arg_1:int):Interval
        {
            return (multiply(((100 + _arg_1) / 100)));
        }

        public function decreaseByPercent(_arg_1:int):Interval
        {
            return (multiply(((100 - _arg_1) / 100)));
        }

        public function copy():Interval
        {
            return (new Interval(min, max));
        }

        public function addInterval(_arg_1:Interval):Interval
        {
            min = (min + _arg_1.min);
            max = (max + _arg_1.max);
            return (this);
        }

        public function add(_arg_1:int):Interval
        {
            min = (min + _arg_1);
            max = (max + _arg_1);
            return (this);
        }

        public function abs():Interval
        {
            if (min < 0)
            {
                min = -(min);
            };
            if (max < 0)
            {
                max = -(max);
            };
            return (this);
        }


    }
} damageCalculation.tools

