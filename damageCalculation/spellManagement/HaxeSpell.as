package damageCalculation.spellManagement
{
    public class HaxeSpell 
    {

        public var needsTakenCell:Boolean;
        public var needsFreeCell:Boolean;
        public var minimaleRange:int;
        public var maximaleRange:int;
        public var maxEffectsStack:int;
        public var level:int;
        public var id:int;
        public var criticalHitProbability:int;
        public var canAlwaysTriggerSpells:Boolean;
        public var _effects:Array;
        public var _criticalEffects:Array;

        public var canBeReflected:Boolean = true;
        public var isRune:Boolean = false;
        public var isGlyph:Boolean = false;
        public var isTrap:Boolean = false;
        public var isWeapon:Boolean = false;

        public function HaxeSpell(_arg_1:int, _arg_2:Array, _arg_3:Array, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:Boolean, _arg_11:Boolean, _arg_12:int=-1):void
        {
            _effects = _arg_2;
            _criticalEffects = _arg_3;
            id = _arg_1;
            minimaleRange = 1;
            maximaleRange = 1;
            level = _arg_4;
            canAlwaysTriggerSpells = _arg_5;
            isWeapon = _arg_6;
            minimaleRange = _arg_7;
            maximaleRange = _arg_8;
            criticalHitProbability = _arg_9;
            needsFreeCell = _arg_10;
            needsTakenCell = _arg_11;
            maxEffectsStack = _arg_12;
        }

        public function hasAtLeastOneRandomEffect():Boolean
        {
            var _local_1:int;
            var _local_2:* = (null as Array);
            var _local_3:* = (null as HaxeSpellEffect);
            if (_effects != null)
            {
                _local_1 = 0;
                _local_2 = _effects;
                while (_local_1 < _local_2.length)
                {
                    _local_3 = _local_2[_local_1];
                    _local_1++;
                    if (_local_3.randomWeight > 0)
                    {
                        return (true);
                    };
                };
            };
            if (_criticalEffects != null)
            {
                _local_1 = 0;
                _local_2 = _criticalEffects;
                while (_local_1 < _local_2.length)
                {
                    _local_3 = _local_2[_local_1];
                    _local_1++;
                    if (_local_3.randomWeight > 0)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public function getEffects():Array
        {
            return (_effects);
        }

        public function getEffectById(_arg_1:uint):HaxeSpellEffect
        {
            var _local_4:* = (null as HaxeSpellEffect);
            var _local_2:int;
            var _local_3:Array = _effects;
            while (_local_2 < _local_3.length)
            {
                _local_4 = _local_3[_local_2];
                _local_2++;
                if ((_local_4.id == _arg_1))
                {
                    return (_local_4);
                };
            };
            return (null);
        }

        public function getEffectByActionId(_arg_1:int):HaxeSpellEffect
        {
            var _local_4:* = (null as HaxeSpellEffect);
            var _local_2:int;
            var _local_3:Array = _effects;
            while (_local_2 < _local_3.length)
            {
                _local_4 = _local_3[_local_2];
                _local_2++;
                if (_local_4.actionId == _arg_1)
                {
                    return (_local_4);
                };
            };
            return (null);
        }

        public function getCriticalEffects():Array
        {
            return (_criticalEffects);
        }

        public function getCriticalEffectById(_arg_1:uint):HaxeSpellEffect
        {
            var _local_4:* = (null as HaxeSpellEffect);
            var _local_2:int;
            var _local_3:Array = _criticalEffects;
            while (_local_2 < _local_3.length)
            {
                _local_4 = _local_3[_local_2];
                _local_2++;
                if ((_local_4.id == _arg_1))
                {
                    return (_local_4);
                };
            };
            return (null);
        }

        public function getCriticalEffectByActionId(_arg_1:int):HaxeSpellEffect
        {
            var _local_4:* = (null as HaxeSpellEffect);
            var _local_2:int;
            var _local_3:Array = _criticalEffects;
            while (_local_2 < _local_3.length)
            {
                _local_4 = _local_3[_local_2];
                _local_2++;
                if (_local_4.actionId == _arg_1)
                {
                    return (_local_4);
                };
            };
            return (null);
        }


    }
} damageCalculation.spellManagement

