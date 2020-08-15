package tools
{
    import damageCalculation.fighterManagement.HaxeFighter;
    import damageCalculation.damageManagement.DamageRange;
    import haxe.ds.List;
    import haxe.ds._List.ListNode;
    import damageCalculation.damageManagement.EffectOutput;
    import damageCalculation.spellManagement.Mark;
    import damageCalculation.spellManagement.HaxeSpellEffect;

    public class FpUtils 
    {

        public function FpUtils():void
        {
        }

        public static function arrayRemove_damageCalculation_fighterManagement_HaxeFighter(_arg_1:Array, _arg_2:HaxeFighter):void
        {
            var _local_3:int = _arg_1.indexOf(_arg_2);
            if (_local_3 != -1)
            {
                _arg_1.splice(_local_3, 1);
            };
        }

        public static function arrayDistinct_damageCalculation_FighterId(_arg_1:Array):Array
        {
            var _local_4:Number;
            var _local_2:Array = [];
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = _arg_1[_local_3];
                _local_3++;
                if (_arg_1.indexOf(_local_4) == _arg_1.lastIndexOf(_local_4))
                {
                    _local_2.push(_local_4);
                };
            };
            return (_local_2);
        }

        public static function arrayMap_damageCalculation_damageManagement_EffectOutput_damageCalculation_FighterId(_arg_1:Array, _arg_2:Function):Array
        {
            var _local_6:int;
            var _local_3:Array = [];
            var _local_4:int;
            var _local_5:int = _arg_1.length;
            while (_local_4 < _local_5)
            {
                _local_6 = _local_4++;
                _local_3[_local_6] = _arg_2(_arg_1[_local_6]);
            };
            return (_local_3);
        }

        public static function arrayFold_Array_damageCalculation_damageManagement_EffectOutput_Array_damageCalculation_damageManagement_EffectOutput(_arg_1:Array, _arg_2:Function, _arg_3:Array):Array
        {
            var _local_6:* = (null as Array);
            var _local_4:Array = _arg_3;
            var _local_5:int;
            while (_local_5 < _arg_1.length)
            {
                _local_6 = _arg_1[_local_5];
                _local_5++;
                _local_4 = _arg_2(_local_6, _local_4);
            };
            return (_local_4);
        }

        public static function arrayMap_damageCalculation_fighterManagement_HaxeFighter_Array_damageCalculation_damageManagement_EffectOutput(_arg_1:Array, _arg_2:Function):Array
        {
            var _local_6:int;
            var _local_3:Array = [];
            var _local_4:int;
            var _local_5:int = _arg_1.length;
            while (_local_4 < _local_5)
            {
                _local_6 = _local_4++;
                _local_3[_local_6] = _arg_2(_arg_1[_local_6]);
            };
            return (_local_3);
        }

        public static function listConcat_damageCalculation_damageManagement_DamageRange(_arg_1:List, _arg_2:List):List
        {
            var _local_5:* = (null as DamageRange);
            var _local_6:* = (null as DamageRange);
            var _local_3:List = new List();
            var _local_4:ListNode = _arg_1.h;
            while (_local_4 != null)
            {
                _local_5 = _local_4.item;
                _local_4 = _local_4.next;
                _local_6 = _local_5;
                _local_3.add(_local_6);
            };
            _local_4 = _arg_2.h;
            while (_local_4 != null)
            {
                _local_5 = _local_4.item;
                _local_4 = _local_4.next;
                _local_6 = _local_5;
                _local_3.add(_local_6);
            };
            return (_local_3);
        }

        public static function listCopy_damageCalculation_damageManagement_EffectOutput(_arg_1:List):List
        {
            var _local_4:* = (null as EffectOutput);
            var _local_5:* = (null as EffectOutput);
            var _local_2:List = new List();
            var _local_3:ListNode = _arg_1.h;
            while (_local_3 != null)
            {
                _local_4 = _local_3.item;
                _local_3 = _local_3.next;
                _local_5 = _local_4;
                _local_2.add(_local_5);
            };
            return (_local_2);
        }

        public static function listConcat_damageCalculation_damageManagement_EffectOutput(_arg_1:List, _arg_2:List):List
        {
            var _local_5:* = (null as EffectOutput);
            var _local_6:* = (null as EffectOutput);
            var _local_3:List = new List();
            var _local_4:ListNode = _arg_1.h;
            while (_local_4 != null)
            {
                _local_5 = _local_4.item;
                _local_4 = _local_4.next;
                _local_6 = _local_5;
                _local_3.add(_local_6);
            };
            _local_4 = _arg_2.h;
            while (_local_4 != null)
            {
                _local_5 = _local_4.item;
                _local_4 = _local_4.next;
                _local_6 = _local_5;
                _local_3.add(_local_6);
            };
            return (_local_3);
        }

        public static function listAfter_damageCalculation_damageManagement_EffectOutput(_arg_1:List, _arg_2:EffectOutput):List
        {
            var _local_6:* = (null as EffectOutput);
            var _local_7:* = (null as EffectOutput);
            var _local_3:List = new List();
            var _local_4:Boolean;
            var _local_5:ListNode = _arg_1.h;
            while (_local_5 != null)
            {
                _local_6 = _local_5.item;
                _local_5 = _local_5.next;
                _local_7 = _local_6;
                if (_local_4)
                {
                    _local_3.add(_local_7);
                };
                if (_local_7 == _arg_2)
                {
                    _local_4 = true;
                };
            };
            return (_local_3);
        }

        public static function arrayRemove_damageCalculation_spellManagement_Mark(_arg_1:Array, _arg_2:Mark):void
        {
            var _local_3:int = _arg_1.indexOf(_arg_2);
            if (_local_3 != -1)
            {
                _arg_1.splice(_local_3, 1);
            };
        }

        public static function arrayFind_damageCalculation_spellManagement_Mark(_arg_1:Array, _arg_2:Function):Mark
        {
            var _local_4:* = (null as Mark);
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = _arg_1[_local_3];
                _local_3++;
                if (_arg_2(_local_4))
                {
                    return (_local_4);
                };
            };
            return (null);
        }

        public static function arrayFilter_damageCalculation_spellManagement_Mark(_arg_1:Array, _arg_2:Function):Array
        {
            var _local_5:* = (null as Mark);
            var _local_3:Array = [];
            var _local_4:int;
            while (_local_4 < _arg_1.length)
            {
                _local_5 = _arg_1[_local_4];
                _local_4++;
                if (_arg_2(_local_5))
                {
                    _local_3.push(_local_5);
                };
            };
            return (_local_3);
        }

        public static function arrayFilter_damageCalculation_fighterManagement_HaxeFighter(_arg_1:Array, _arg_2:Function):Array
        {
            var _local_5:* = (null as HaxeFighter);
            var _local_3:Array = [];
            var _local_4:int;
            while (_local_4 < _arg_1.length)
            {
                _local_5 = _arg_1[_local_4];
                _local_4++;
                if (_arg_2(_local_5))
                {
                    _local_3.push(_local_5);
                };
            };
            return (_local_3);
        }

        public static function arrayCopy_String(_arg_1:Array):Array
        {
            var _local_4:* = (null as String);
            var _local_2:Array = [];
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = _arg_1[_local_3];
                _local_3++;
                _local_2.push(_local_4);
            };
            return (_local_2);
        }

        public static function arrayCopy_damageCalculation_spellManagement_HaxeSpellEffect(_arg_1:Array):Array
        {
            var _local_4:* = (null as HaxeSpellEffect);
            var _local_2:Array = [];
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = _arg_1[_local_3];
                _local_3++;
                _local_2.push(_local_4);
            };
            return (_local_2);
        }

        public static function arrayContains_Int(_arg_1:Array, _arg_2:int):Boolean
        {
            return (!(_arg_1.indexOf(_arg_2) == -1));
        }

        public static function arrayFilter_String(_arg_1:Array, _arg_2:Function):Array
        {
            var _local_5:* = (null as String);
            var _local_3:Array = [];
            var _local_4:int;
            while (_local_4 < _arg_1.length)
            {
                _local_5 = _arg_1[_local_4];
                _local_4++;
                if (_arg_2(_local_5))
                {
                    _local_3.push(_local_5);
                };
            };
            return (_local_3);
        }

        public static function arrayMap_Int_flash_geom_Point(_arg_1:Array, _arg_2:Function):Array
        {
            var _local_6:int;
            var _local_3:Array = [];
            var _local_4:int;
            var _local_5:int = _arg_1.length;
            while (_local_4 < _local_5)
            {
                _local_6 = _local_4++;
                _local_3[_local_6] = _arg_2(_arg_1[_local_6]);
            };
            return (_local_3);
        }


    }
}

