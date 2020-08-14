package damageCalculation.spellManagement
{
    import haxe.ds._IntMap.IntMapValuesIterator;
    import haxe.IMap;
    import haxe.ds.IntMap;

    public class RandomGroup 
    {

        public var weight:int;
        public var effects:Array;

        public function RandomGroup(_arg_1:Array):void
        {
            var _local_3:* = (null as HaxeSpellEffect);
            effects = _arg_1;
            weight = 0;
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                _local_3 = _arg_1[_local_2];
                _local_2++;
                weight = (weight + _local_3.randomWeight);
            };
        }

        public static function totalWeight(_arg_1:IMap):int
        {
            var _local_4:* = (null as RandomGroup);
            var _local_2:int;
            var _local_3:* = new IntMapValuesIterator(_arg_1.h);
            while (_local_3.hasNext())
            {
                _local_4 = _local_3.next();
                _local_2 = (_local_2 + _local_4.weight);
            };
            return (_local_2);
        }

        public static function createGroups(_arg_1:Array):IMap
        {
            var _local_5:* = (null as HaxeSpellEffect);
            var _local_6:int;
            var _local_7:* = (null as RandomGroup);
            var _local_8:int;
            var _local_2:IMap = new IntMap();
            var _local_3:int;
            var _local_4:int;
            while (_local_4 < _arg_1.length)
            {
                _local_5 = _arg_1[_local_4];
                _local_4++;
                if (_local_5.randomWeight > 0)
                {
                    if (_local_5.randomGroup == 0)
                    {
                        _local_5.randomGroup = --_local_3;
                    };
                    _local_6 = _local_5.randomGroup;
                    if ((_local_6 in _local_2.h))
                    {
                        _local_7 = _local_2.h[_local_5.randomGroup];
                        _local_7.effects.push(_local_5);
                        _local_7.weight = (_local_7.weight + _local_5.randomWeight);
                    }
                    else
                    {
                        _local_8 = _local_5.randomGroup;
                        _local_7 = new RandomGroup([_local_5]);
                        _local_2.h[_local_8] = _local_7;
                    };
                };
            };
            return (_local_2);
        }

        public static function selectRandomGroup(_arg_1:IMap):Array
        {
            var _local_5:* = (null as RandomGroup);
            var _local_2:int = int(Math.floor((RandomGroup.totalWeight(_arg_1) * Math.random())));
            var _local_3:RandomGroup;
            var _local_4:* = new IntMapValuesIterator(_arg_1.h);
            while (_local_4.hasNext())
            {
                _local_5 = _local_4.next();
                _local_2 = (_local_2 - _local_5.weight);
                if (_local_2 <= 0) break;
            };
            return (_local_3.effects);
        }


        public function addEffect(_arg_1:HaxeSpellEffect):void
        {
            effects.push(_arg_1);
            weight = (weight + _arg_1.randomWeight);
        }


    }
} damageCalculation.spellManagement

