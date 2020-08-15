package com.ankamagames.dofus.logic.game.fight.types
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporarySpellBoostEffect;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
    import com.ankama.dofus.enums.ActionIds;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class SpellBuff extends BasicBuff 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellBuff));

        public var spellId:int;
        public var delta:int;
        public var modifType:int;

        public function SpellBuff(effect:FightTemporarySpellBoostEffect=null, castingSpell:CastingSpell=null, actionId:int=0)
        {
            if (effect)
            {
                super(effect, castingSpell, actionId, effect.boostedSpellId, null, effect.delta);
                this.spellId = effect.boostedSpellId;
                this.delta = effect.delta;
            };
        }

        override public function get type():String
        {
            return ("SpellBuff");
        }

        override public function onApplied():void
        {
            var spellModifExists:Boolean;
            var spellModif:CharacterSpellModification;
            var swToUpdate:SpellWrapper;
            var basicBuff:BasicBuff;
            var carac:CharacterBaseCharacteristic;
            var modif:CharacterSpellModification;
            var targetCaracs:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(targetId);
            if (targetCaracs)
            {
                switch (actionId)
                {
                    case ActionIds.ACTION_BOOST_SPELL_RANGEABLE:
                        this.modifType = CharacterSpellModificationTypeEnum.RANGEABLE;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_DMG:
                        this.modifType = CharacterSpellModificationTypeEnum.DAMAGE;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_BASE_DMG:
                        this.modifType = CharacterSpellModificationTypeEnum.BASE_DAMAGE;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_HEAL:
                        this.modifType = CharacterSpellModificationTypeEnum.HEAL_BONUS;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_AP_COST:
                        this.modifType = CharacterSpellModificationTypeEnum.AP_COST;
                        break;
                    case ActionIds.ACTION_DEBOOST_SPELL_AP_COST:
                        this.modifType = CharacterSpellModificationTypeEnum.AP_COST;
                        this.delta = -(this.delta);
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_CAST_INTVL:
                        this.modifType = CharacterSpellModificationTypeEnum.CAST_INTERVAL;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_CAST_INTVL_SET:
                        this.modifType = CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_CC:
                        this.modifType = CharacterSpellModificationTypeEnum.CRITICAL_HIT_BONUS;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_CASTOUTLINE:
                        this.modifType = CharacterSpellModificationTypeEnum.CAST_LINE;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_NOLINEOFSIGHT:
                        this.modifType = CharacterSpellModificationTypeEnum.LOS;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_MAXPERTURN:
                        this.modifType = CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_MAXPERTARGET:
                        this.modifType = CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET;
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_RANGE_MAX:
                        this.modifType = CharacterSpellModificationTypeEnum.RANGE_MAX;
                        break;
                    case ActionIds.ACTION_DEBOOST_SPELL_RANGE_MAX:
                        this.modifType = CharacterSpellModificationTypeEnum.RANGE_MAX;
                        this.delta = -(this.delta);
                        break;
                    case ActionIds.ACTION_BOOST_SPELL_RANGE_MIN:
                        this.modifType = CharacterSpellModificationTypeEnum.RANGE_MIN;
                        break;
                    case ActionIds.ACTION_DEBOOST_SPELL_RANGE_MIN:
                        this.modifType = CharacterSpellModificationTypeEnum.RANGE_MIN;
                        this.delta = -(this.delta);
                        break;
                };
                spellModifExists = false;
                for each (spellModif in targetCaracs.spellModifications)
                {
                    if (((this.spellId == spellModif.spellId) && (spellModif.modificationType == this.modifType)))
                    {
                        spellModifExists = true;
                        if (stack)
                        {
                            for each (basicBuff in stack)
                            {
                                if ((basicBuff is SpellBuff))
                                {
                                    spellModif.value.contextModif = (spellModif.value.contextModif + (basicBuff as SpellBuff).delta);
                                };
                            };
                        }
                        else
                        {
                            spellModif.value.contextModif = (spellModif.value.contextModif + this.delta);
                        };
                        break;
                    };
                };
                if (!spellModifExists)
                {
                    carac = new CharacterBaseCharacteristic();
                    carac.base = 0;
                    carac.additionnal = 0;
                    carac.alignGiftBonus = 0;
                    carac.contextModif = this.delta;
                    carac.objectsAndMountBonus = 0;
                    modif = new CharacterSpellModification();
                    modif.modificationType = this.modifType;
                    modif.spellId = this.spellId;
                    modif.value = carac;
                    targetCaracs.spellModifications.push(modif);
                };
                swToUpdate = SpellWrapper.getSpellWrapperById(this.spellId, targetId);
                if (swToUpdate)
                {
                    swToUpdate.versionNum++;
                    if (((this.modifType == CharacterSpellModificationTypeEnum.CAST_INTERVAL) && (CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(targetId).getSpellManagerBySpellId(this.spellId))))
                    {
                        swToUpdate.actualCooldown = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(targetId).getSpellManagerBySpellId(this.spellId).cooldown;
                    }
                    else
                    {
                        if (this.modifType == CharacterSpellModificationTypeEnum.AP_COST)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.SpellUpdate, swToUpdate);
                        };
                    };
                };
            };
            super.onApplied();
        }

        override public function onRemoved():void
        {
            var targetCaracs:CharacterCharacteristicsInformations;
            var spellModif:CharacterSpellModification;
            var swToUpdate:SpellWrapper;
            var basicBuff:BasicBuff;
            if (!_removed)
            {
                targetCaracs = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(targetId);
                if (!targetCaracs)
                {
                    return;
                };
                for each (spellModif in targetCaracs.spellModifications)
                {
                    if (((this.spellId == spellModif.spellId) && (spellModif.modificationType == this.modifType)))
                    {
                        if (stack)
                        {
                            for each (basicBuff in stack)
                            {
                                if ((basicBuff is SpellBuff))
                                {
                                    spellModif.value.contextModif = (spellModif.value.contextModif - (basicBuff as SpellBuff).delta);
                                };
                            };
                        }
                        else
                        {
                            spellModif.value.contextModif = (spellModif.value.contextModif - this.delta);
                        };
                        break;
                    };
                };
                swToUpdate = SpellWrapper.getSpellWrapperById(this.spellId, targetId);
                if (swToUpdate)
                {
                    swToUpdate = swToUpdate.clone();
                    swToUpdate.versionNum++;
                };
            };
            super.onRemoved();
        }

        override public function clone(id:int=0):BasicBuff
        {
            var sb:SpellBuff = new SpellBuff();
            sb.spellId = this.spellId;
            sb.delta = this.delta;
            sb.modifType = this.modifType;
            sb.id = uid;
            sb.uid = uid;
            sb.dataUid = dataUid;
            sb.actionId = actionId;
            sb.targetId = targetId;
            sb.castingSpell = castingSpell;
            sb.duration = duration;
            sb.dispelable = dispelable;
            sb.source = source;
            sb.aliveSource = aliveSource;
            sb.sourceJustReaffected = sourceJustReaffected;
            sb.parentBoostUid = parentBoostUid;
            sb.initParam(param1, param2, param3);
            return (sb);
        }


    }
}

