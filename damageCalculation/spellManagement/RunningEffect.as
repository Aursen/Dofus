package damageCalculation.spellManagement
{
    import damageCalculation.fighterManagement.HaxeFighter;
    import damageCalculation.damageManagement.EffectOutput;

    public class RunningEffect 
    {

        public var _spellEffect:HaxeSpellEffect;
        public var _spell:HaxeSpell;
        public var _caster:HaxeFighter;
        public var _canAlwaysTriggerSpells:Boolean;

        public var forceCritical:Boolean = false;
        public var isTriggered:Boolean = false;
        public var isReflect:Boolean = false;
        public var probability:int = 0;
        public var triggeringOutput:EffectOutput = null;
        public var triggeringFighter:HaxeFighter = null;
        public var _parentEffect:RunningEffect = null;

        public function RunningEffect(_arg_1:HaxeFighter, _arg_2:HaxeSpell, _arg_3:HaxeSpellEffect, _arg_4:int=0, _arg_5:Boolean=true):void
        {
            _spell = _arg_2;
            _spellEffect = _arg_3;
            _caster = _arg_1;
            _canAlwaysTriggerSpells = _arg_5;
            probability = _arg_4;
        }

        public function triggeredByEffectSetting(_arg_1:RunningEffect):void
        {
            _parentEffect = _arg_1;
            triggeringFighter = _arg_1.getCaster();
        }

        public function setParentEffect(_arg_1:RunningEffect):void
        {
            _parentEffect = _arg_1;
            if (((triggeringFighter == (null)) && (!(_parentEffect == null))))
            {
                triggeringFighter = _parentEffect.triggeringFighter;
            };
        }

        public function overrideSpellEffect(_arg_1:HaxeSpellEffect):void
        {
            _spellEffect = _arg_1;
        }

        public function overrideCaster(_arg_1:HaxeFighter):void
        {
            _caster = _arg_1;
        }

        public function isTargetingAnAncestor(_arg_1:HaxeFighter):Boolean
        {
            var _local_2:RunningEffect = this;
            while (_local_2 != null)
            {
                if (_local_2.getCaster().id == _arg_1.id)
                {
                    return (true);
                };
                _local_2 = _local_2.getParentEffect();
            };
            return (false);
        }

        public function getSpellEffect():HaxeSpellEffect
        {
            return (_spellEffect);
        }

        public function getSpell():HaxeSpell
        {
            return (_spell);
        }

        public function getParentEffect():RunningEffect
        {
            return (_parentEffect);
        }

        public function getFirstParentEffect():RunningEffect
        {
            var _local_1:RunningEffect = this;
            while (_local_1._parentEffect != null)
            {
                _local_1 = _local_1._parentEffect;
            };
            return (_local_1);
        }

        public function getCaster():HaxeFighter
        {
            return (_caster);
        }

        public function copy():RunningEffect
        {
            var _local_1:RunningEffect = new RunningEffect(_caster, _spell, _spellEffect, probability, _canAlwaysTriggerSpells);
            _local_1.setParentEffect(this);
            _local_1.triggeringOutput = triggeringOutput;
            _local_1.forceCritical = forceCritical;
            _local_1.isTriggered = isTriggered;
            _local_1.isReflect = isReflect;
            _local_1.triggeringFighter = triggeringFighter;
            return (_local_1);
        }

        public function canAlwaysTriggerSpells():Boolean
        {
            return (_canAlwaysTriggerSpells);
        }


    }
}

