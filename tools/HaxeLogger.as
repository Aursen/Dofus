package tools
{
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import damageCalculation.spellManagement.HaxeSpell;
    import damageCalculation.spellManagement.RunningEffect;
    import damageCalculation.DamageCalculator;

    public class HaxeLogger 
    {

        public function HaxeLogger():void
        {
        }

        public static function logInfiniteLoop(_arg_1:String, _arg_2:RunningEffect):void
        {
            var _local_7:int;
            var _local_8:* = (null as HaxeSpellEffect);
            var _local_9:* = (null as HaxeSpell);
            var _local_3:String = _arg_1;
            var _local_4:String = "";
            var _local_5:RunningEffect = _arg_2;
            var _local_6:int;
            while (_local_6 < 10)
            {
                _local_7 = _local_6++;
                _local_8 = _arg_2.getSpellEffect();
                _local_9 = _arg_2.getSpell();
                _local_4 = (_local_4 + ((((("\n   effect " + ("" + _local_8.id)) + " with actionId ") + _local_8.actionId) + " in spell ") + _local_9.id));
                _arg_2 = _arg_2.getParentEffect();
                if (_arg_2 == null) break;
                _local_5 = _arg_2;
            };
            while (_local_5.getParentEffect() != null)
            {
                _local_5 = _local_5.getParentEffect();
            };
            _local_3 = (_local_3 + ("\nCasting spell : " + _local_5.getSpell().id));
            _local_3 = (_local_3 + ("\nLast effects : " + _local_4));
            DamageCalculator.logger.logError(_local_3);
        }


    }
}

