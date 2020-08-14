package haxe.ds
{
    public class ArraySort 
    {

        public function ArraySort():void
        {
        }

        public static function sort(_arg_1:Array, _arg_2:Function):void
        {
            ArraySort.rec(_arg_1, _arg_2, 0, _arg_1.length);
        }

        public static function rec(_arg_1:Array, _arg_2:Function, _arg_3:int, _arg_4:int):void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_5:* = ((_arg_3 + _arg_4) >> 1);
            if ((_arg_4 - _arg_3) < 12)
            {
                if (_arg_4 <= _arg_3)
                {
                    return;
                };
                _local_6 = (_arg_3 + 1);
                _local_7 = _arg_4;
                while (_local_6 < _local_7)
                {
                    _local_8 = _local_6++;
                    _local_9 = _local_8;
                    while (_local_9 > _arg_3)
                    {
                        if (_arg_2(_arg_1[_local_9], _arg_1[(_local_9 - 1)]) < 0)
                        {
                            ArraySort.swap(_arg_1, (_local_9 - 1), _local_9);
                        }
                        else
                        {
                            break;
                        };
                        _local_9--;
                    };
                };
                return;
            };
            ArraySort.rec(_arg_1, _arg_2, _arg_3, _local_5);
            ArraySort.rec(_arg_1, _arg_2, _local_5, _arg_4);
            ArraySort.doMerge(_arg_1, _arg_2, _arg_3, _local_5, _arg_4, (_local_5 - _arg_3), (_arg_4 - _local_5));
        }

        public static function doMerge(_arg_1:Array, _arg_2:Function, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int):void
        {
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            if (((_arg_6 == (0)) || (_arg_7 == 0)))
            {
                return;
            };
            if ((_arg_6 + _arg_7) == 2)
            {
                if (_arg_2(_arg_1[_arg_4], _arg_1[_arg_3]) < 0)
                {
                    ArraySort.swap(_arg_1, _arg_4, _arg_3);
                };
                return;
            };
            if (_arg_6 > _arg_7)
            {
                _local_10 = (_arg_6 >> 1);
                _local_8 = (_arg_3 + _local_10);
                _local_9 = ArraySort.lower(_arg_1, _arg_2, _arg_4, _arg_5, _local_8);
                _local_11 = (_local_9 - _arg_4);
            }
            else
            {
                _local_11 = (_arg_7 >> 1);
                _local_9 = (_arg_4 + _local_11);
                _local_8 = ArraySort.upper(_arg_1, _arg_2, _arg_3, _arg_4, _local_9);
                _local_10 = (_local_8 - _arg_3);
            };
            ArraySort.rotate(_arg_1, _arg_2, _local_8, _arg_4, _local_9);
            var _local_12:* = (_local_8 + _local_11);
            ArraySort.doMerge(_arg_1, _arg_2, _arg_3, _local_8, _local_12, _local_10, _local_11);
            ArraySort.doMerge(_arg_1, _arg_2, _local_12, _local_9, _arg_5, (_arg_6 - _local_10), (_arg_7 - _local_11));
        }

        public static function rotate(_arg_1:Array, _arg_2:Function, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            var _local_7:* = (null as Object);
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            if (((_arg_3 == (_arg_4)) || (_arg_4 == _arg_5)))
            {
                return;
            };
            var _local_6:int = ArraySort.gcd((_arg_5 - _arg_3), (_arg_4 - _arg_3));
            while (_local_6-- != 0)
            {
                _local_7 = _arg_1[(_arg_3 + _local_6)];
                _local_8 = (_arg_4 - _arg_3);
                _local_9 = (_arg_3 + _local_6);
                _local_10 = ((_arg_3 + _local_6) + _local_8);
                while (_local_10 != (_arg_3 + _local_6))
                {
                    _arg_1[_local_9] = _arg_1[_local_10];
                    _local_9 = _local_10;
                    if ((_arg_5 - _local_10) > _local_8)
                    {
                        _local_10 = (_local_10 + _local_8);
                    }
                    else
                    {
                        _local_10 = (_arg_3 + (_local_8 - (_arg_5 - _local_10)));
                    };
                };
                _arg_1[_local_9] = _local_7;
            };
        }

        public static function gcd(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            while (_arg_2 != 0)
            {
                _local_3 = (_arg_1 % _arg_2);
                _arg_1 = _arg_2;
                _arg_2 = _local_3;
            };
            return (_arg_1);
        }

        public static function upper(_arg_1:Array, _arg_2:Function, _arg_3:int, _arg_4:int, _arg_5:int):int
        {
            var _local_7:int;
            var _local_8:int;
            var _local_6:* = (_arg_4 - _arg_3);
            while (_local_6 > 0)
            {
                _local_7 = (_local_6 >> 1);
                _local_8 = (_arg_3 + _local_7);
                if (_arg_2(_arg_1[_arg_5], _arg_1[_local_8]) < 0)
                {
                    _local_6 = _local_7;
                }
                else
                {
                    _arg_3 = (_local_8 + 1);
                    _local_6 = ((_local_6 - _local_7) - 1);
                };
            };
            return (_arg_3);
        }

        public static function lower(_arg_1:Array, _arg_2:Function, _arg_3:int, _arg_4:int, _arg_5:int):int
        {
            var _local_7:int;
            var _local_8:int;
            var _local_6:* = (_arg_4 - _arg_3);
            while (_local_6 > 0)
            {
                _local_7 = (_local_6 >> 1);
                _local_8 = (_arg_3 + _local_7);
                if (_arg_2(_arg_1[_local_8], _arg_1[_arg_5]) < 0)
                {
                    _arg_3 = (_local_8 + 1);
                    _local_6 = ((_local_6 - _local_7) - 1);
                }
                else
                {
                    _local_6 = _local_7;
                };
            };
            return (_arg_3);
        }

        public static function swap(_arg_1:Array, _arg_2:int, _arg_3:int):void
        {
            var _local_4:Object = _arg_1[_arg_2];
            _arg_1[_arg_2] = _arg_1[_arg_3];
            _arg_1[_arg_3] = _local_4;
        }


    }
} haxe.ds

