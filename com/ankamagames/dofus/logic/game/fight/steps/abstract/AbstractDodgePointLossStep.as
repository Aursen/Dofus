package com.ankamagames.dofus.logic.game.fight.steps.abstract
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import __AS3__.vec.Vector;

    public class AbstractDodgePointLossStep extends AbstractSequencable 
    {

        protected var _fighterId:Number;
        protected var _amount:int;

        public function AbstractDodgePointLossStep(fighterId:Number, amount:int)
        {
            this._fighterId = fighterId;
            this._amount = amount;
        }

        public function get targets():Vector.<Number>
        {
            return (new <Number>[this._fighterId]);
        }


    }
} com.ankamagames.dofus.logic.game.fight.steps.abstract

