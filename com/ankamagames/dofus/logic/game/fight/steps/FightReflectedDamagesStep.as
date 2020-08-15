package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
    import __AS3__.vec.Vector;

    public class FightReflectedDamagesStep extends AbstractSequencable implements IFightStep 
    {

        private var _fighterId:Number;

        public function FightReflectedDamagesStep(fighterId:Number)
        {
            this._fighterId = fighterId;
        }

        public function get stepType():String
        {
            return ("reflectedDamages");
        }

        override public function start():void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_REFLECTED_DAMAGES, [this._fighterId], this._fighterId, castingSpellId);
            executeCallbacks();
        }

        public function get targets():Vector.<Number>
        {
            return (new <Number>[this._fighterId]);
        }


    }
}

