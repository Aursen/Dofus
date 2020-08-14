package com.ankamagames.dofus.logic.game.fight.types
{
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;

    public class BlockEvadeBuff extends StatBuff 
    {

        public function BlockEvadeBuff(effect:FightTemporaryBoostEffect=null, castingSpell:CastingSpell=null, actionId:int=0)
        {
            super(effect, castingSpell, actionId);
        }

        override public function onApplied():void
        {
            super.onApplied();
            this.updateMovementPath();
        }

        override public function onRemoved():void
        {
            super.onRemoved();
            this.updateMovementPath();
        }

        private function updateMovementPath():void
        {
            var ftf:FightTurnFrame = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
            if (((((targetId == CurrentPlayedFighterManager.getInstance().currentFighterId) && (ftf)) && (ftf.myTurn)) && (ftf.lastPath)))
            {
                ftf.updatePath();
            };
        }


    }
} com.ankamagames.dofus.logic.game.fight.types

