package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
    import com.ankamagames.dofus.logic.game.fight.types.BlockEvadeBuff;
    import com.ankama.dofus.enums.ActionIds;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
    import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;

    public class StatBuffFactory 
    {


        public static function createStatBuff(pEffect:FightTemporaryBoostEffect, pCastingSpell:CastingSpell, pActionId:uint):StatBuff
        {
            var buff:StatBuff;
            switch (pActionId)
            {
                case ActionIds.ACTION_CHARACTER_BOOST_TAKLE_EVADE:
                case ActionIds.ACTION_CHARACTER_BOOST_TAKLE_BLOCK:
                case ActionIds.ACTION_CHARACTER_DEBOOST_TAKLE_EVADE:
                case ActionIds.ACTION_CHARACTER_DEBOOST_TAKLE_BLOCK:
                    buff = new BlockEvadeBuff(pEffect, pCastingSpell, pActionId);
                    break;
                default:
                    buff = new StatBuff(pEffect, pCastingSpell, pActionId);
            };
            return (buff);
        }


    }
}

