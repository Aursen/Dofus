package damageCalculation.spellManagement
{
    public class HaxeSpellState 
    {

        public var id:uint;
        public var _stateEffects:Array;

        public function HaxeSpellState(_arg_1:uint, _arg_2:Array):void
        {
            id = _arg_1;
            _stateEffects = _arg_2;
        }

        public function hasEffect(_arg_1:int):Boolean
        {
            return (!(_stateEffects.indexOf(_arg_1) == -1));
        }


    }
} damageCalculation.spellManagement

