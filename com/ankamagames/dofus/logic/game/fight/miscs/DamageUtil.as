package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.fight.frames.Preview.FighterTranslator;
    import damageCalculation.FightContext;
    import damageCalculation.fighterManagement.HaxeFighter;
    import com.ankamagames.dofus.logic.game.fight.frames.Preview.SpellEffectTranslator;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.logic.game.fight.frames.Preview.MapTranslator;
    import damageCalculation.spellManagement.SpellManager;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;

    public class DamageUtil 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DamageUtil));
        public static const HEALING_EFFECTS_IDS:Array = [81, 108, 1109, 90];
        public static const HP_BASED_DAMAGE_EFFECTS_IDS:Array = [672, 85, 86, 87, 88, 89, 90];


        public static function verifySpellEffectMask(pCasterId:Number, pTargetId:Number, pEffect:EffectInstance, pSpellImpactCell:int, pTriggeringSpellCasterId:Number=0):Boolean
        {
            var caster:FighterTranslator;
            var gameTurn:int;
            var fightContext:FightContext;
            var target:HaxeFighter;
            var effect:SpellEffectTranslator;
            var triggeringFighter:HaxeFighter;
            var fcf:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            if (!pEffect.targetMask)
            {
                return (true);
            };
            if (((!(pEffect)) || (pEffect.delay > 0)))
            {
                return (false);
            };
            var infos:GameFightFighterInformations = (fcf.entitiesFrame.getEntityInfos(pCasterId) as GameFightFighterInformations);
            if (infos != null)
            {
                caster = new FighterTranslator(infos, pCasterId);
                gameTurn = (1 + CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn);
                fightContext = new FightContext(gameTurn, new MapTranslator(fcf), pSpellImpactCell, caster);
                target = fightContext.getFighterById(pTargetId);
                effect = SpellEffectTranslator.fromSpell(pEffect, 1, false);
                triggeringFighter = fightContext.getFighterById(pTriggeringSpellCasterId);
                return (SpellManager.isSelectedByMask(caster, effect.masks, target, triggeringFighter, fightContext));
            };
            return (false);
        }


    }
} com.ankamagames.dofus.logic.game.fight.miscs

