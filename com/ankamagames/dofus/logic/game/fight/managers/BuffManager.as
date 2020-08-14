package com.ankamagames.dofus.logic.game.fight.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostWeaponDamagesEffect;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporarySpellImmunityEffect;
    import com.ankamagames.dofus.misc.utils.GameDebugManager;
    import com.ankamagames.dofus.logic.game.fight.types.SpellBuff;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporarySpellBoostEffect;
    import com.ankamagames.dofus.logic.game.fight.types.TriggeredBuff;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTriggeredEffect;
    import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostStateEffect;
    import com.ankamagames.dofus.logic.game.fight.miscs.StatBuffFactory;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.FightHookList;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
    import com.ankama.dofus.enums.ActionIds;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdProtocol;
    import __AS3__.vec.*;

    public class BuffManager 
    {

        public static const INCREMENT_MODE_SOURCE:int = 1;
        public static const INCREMENT_MODE_TARGET:int = 2;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BuffManager));
        private static var _self:BuffManager;

        private var _buffs:Dictionary = new Dictionary();
        private var _updateStatList:Boolean = false;
        public var spellBuffsToIgnore:Vector.<CastingSpell> = new Vector.<CastingSpell>();

        public function BuffManager()
        {
            if (_self)
            {
                throw (new SingletonError());
            };
        }

        public static function getInstance():BuffManager
        {
            if (!_self)
            {
                _self = new (BuffManager)();
            };
            return (_self);
        }

        public static function makeBuffFromEffect(effect:AbstractFightDispellableEffect, castingSpell:CastingSpell, actionId:uint):BasicBuff
        {
            var buff:BasicBuff;
            var effectInstanceDice:EffectInstanceDice;
            var criticalEffect:Boolean;
            var level:SpellLevel;
            var ftbwde:FightTemporaryBoostWeaponDamagesEffect;
            var ftsie:FightTemporarySpellImmunityEffect;
            var spellLevel:SpellLevel;
            var effects:Vector.<EffectInstanceDice>;
            var effid:EffectInstanceDice;
            if (GameDebugManager.getInstance().buffsDebugActivated)
            {
                _log.debug(("[BUFFS DEBUG] Creation du buff " + effect.uid));
            };
            switch (true)
            {
                case (effect is FightTemporarySpellBoostEffect):
                    buff = new SpellBuff((effect as FightTemporarySpellBoostEffect), castingSpell, actionId);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((("[BUFFS DEBUG]      Buff " + effect.uid) + " : type SpellBuff"));
                    };
                    break;
                case (effect is FightTriggeredEffect):
                    buff = new TriggeredBuff((effect as FightTriggeredEffect), castingSpell, actionId);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((("[BUFFS DEBUG]      Buff " + effect.uid) + " : type TriggeredBuff"));
                    };
                    break;
                case (effect is FightTemporaryBoostWeaponDamagesEffect):
                    ftbwde = (effect as FightTemporaryBoostWeaponDamagesEffect);
                    buff = new BasicBuff(effect, castingSpell, actionId, ftbwde.weaponTypeId, ftbwde.delta, ftbwde.weaponTypeId);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((("[BUFFS DEBUG]      Buff " + effect.uid) + " : type BasicBuff avec FightTemporaryBoostWeaponDamagesEffect"));
                    };
                    break;
                case (effect is FightTemporaryBoostStateEffect):
                    buff = new StateBuff((effect as FightTemporaryBoostStateEffect), castingSpell, actionId);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((("[BUFFS DEBUG]      Buff " + effect.uid) + " : type StateBuff"));
                    };
                    break;
                case (effect is FightTemporarySpellImmunityEffect):
                    ftsie = (effect as FightTemporarySpellImmunityEffect);
                    buff = new BasicBuff(effect, castingSpell, actionId, ftsie.immuneSpellId, null, null);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((("[BUFFS DEBUG]      Buff " + effect.uid) + " : type BasicBuff avec FightTemporarySpellImmunityEffect"));
                    };
                    break;
                case (effect is FightTemporaryBoostEffect):
                    buff = StatBuffFactory.createStatBuff((effect as FightTemporaryBoostEffect), castingSpell, actionId);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((("[BUFFS DEBUG]      Buff " + effect.uid) + " : type StatBuff"));
                    };
                    break;
            };
            buff.id = effect.uid;
            var spellLevelsId:int = -1;
            var spell:Spell = Spell.getSpellById(effect.spellId);
            for each (level in spell.spellLevelsInfo)
            {
                for each (effectInstanceDice in level.effects)
                {
                    if (effectInstanceDice.effectUid == effect.effectId)
                    {
                        spellLevelsId = level.id;
                        break;
                    };
                };
                if (spellLevelsId == -1)
                {
                    for each (effectInstanceDice in level.criticalEffect)
                    {
                        if (effectInstanceDice.effectUid == effect.effectId)
                        {
                            spellLevelsId = level.id;
                            criticalEffect = true;
                            break;
                        };
                    };
                };
                if (spellLevelsId != -1)
                {
                    break;
                };
            };
            if (spellLevelsId != -1)
            {
                spellLevel = SpellLevel.getLevelById(spellLevelsId);
                effects = ((criticalEffect) ? spellLevel.criticalEffect : spellLevel.effects);
                for each (effid in effects)
                {
                    if (effid.effectUid == effect.effectId)
                    {
                        buff.effect.triggers = effid.triggers;
                        buff.effect.targetMask = effid.targetMask;
                        buff.effect.effectElement = effid.effectElement;
                        break;
                    };
                };
                buff.castingSpell.spellRank = spellLevel;
            };
            if (GameDebugManager.getInstance().buffsDebugActivated)
            {
                _log.debug(((((((((("[BUFFS DEBUG]      Buff " + effect.uid) + " : sort lanceur ") + buff.castingSpell.spell.name) + " (") + buff.castingSpell.spell.id) + ") niveau ") + buff.castingSpell.spellRank.grade) + " par ") + buff.castingSpell.casterId));
            };
            return (buff);
        }


        public function destroy():void
        {
            _self = null;
            this.spellBuffsToIgnore.length = 0;
        }

        public function decrementDuration(targetId:Number):void
        {
            this.incrementDuration(targetId, -1);
        }

        public function synchronize():void
        {
            var entityId:String;
            var buffItem:BasicBuff;
            if (GameDebugManager.getInstance().buffsDebugActivated)
            {
                _log.debug("[BUFFS DEBUG] Annulation du disabled sur tous les buffs");
            };
            for (entityId in this._buffs)
            {
                for each (buffItem in this._buffs[entityId])
                {
                    if (buffItem.disabled)
                    {
                        buffItem.onReenable();
                    };
                };
            };
        }

        public function incrementDuration(targetId:Number, delta:int, dispellEffect:Boolean=false, incrementMode:int=1):void
        {
            var targetBuffs:Array;
            var buffItem:BasicBuff;
            var modified:Boolean;
            var skipBuffUpdate:Boolean;
            var spell:CastingSpell;
            var currentFighterId:Number;
            var newBuffs:Dictionary = new Dictionary();
            this._updateStatList = false;
            for each (targetBuffs in this._buffs)
            {
                for each (buffItem in targetBuffs)
                {
                    if ((((dispellEffect) && (buffItem is TriggeredBuff)) && (TriggeredBuff(buffItem).delay > 0)))
                    {
                        if (newBuffs[buffItem.targetId] == null)
                        {
                            newBuffs[buffItem.targetId] = [];
                        };
                        newBuffs[buffItem.targetId].push(buffItem);
                    }
                    else
                    {
                        if ((((incrementMode == INCREMENT_MODE_SOURCE) && (buffItem.aliveSource == targetId)) || ((incrementMode == INCREMENT_MODE_TARGET) && (buffItem.targetId == targetId))))
                        {
                            if (((incrementMode == INCREMENT_MODE_SOURCE) && ((this.spellBuffsToIgnore.length) || (buffItem.sourceJustReaffected))))
                            {
                                skipBuffUpdate = false;
                                for each (spell in this.spellBuffsToIgnore)
                                {
                                    if (((spell.castingSpellId == buffItem.castingSpell.castingSpellId) && (spell.casterId == targetId)))
                                    {
                                        skipBuffUpdate = true;
                                        break;
                                    };
                                };
                                if (buffItem.sourceJustReaffected)
                                {
                                    skipBuffUpdate = true;
                                    buffItem.sourceJustReaffected = false;
                                };
                                if (skipBuffUpdate)
                                {
                                    if (newBuffs[buffItem.targetId] == null)
                                    {
                                        newBuffs[buffItem.targetId] = [];
                                    };
                                    newBuffs[buffItem.targetId].push(buffItem);
                                    continue;
                                };
                            };
                            modified = buffItem.incrementDuration(delta, dispellEffect);
                            if (buffItem.active)
                            {
                                if (newBuffs[buffItem.targetId] == null)
                                {
                                    newBuffs[buffItem.targetId] = [];
                                };
                                newBuffs[buffItem.targetId].push(buffItem);
                                if (modified)
                                {
                                    KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate, buffItem.id, buffItem.targetId);
                                };
                            }
                            else
                            {
                                buffItem.onRemoved();
                                KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove, buffItem, buffItem.targetId, "CoolDown");
                                currentFighterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
                                if (((targetId == currentFighterId) || (buffItem.targetId == currentFighterId)))
                                {
                                    this._updateStatList = true;
                                };
                            };
                        }
                        else
                        {
                            if (newBuffs[buffItem.targetId] == null)
                            {
                                newBuffs[buffItem.targetId] = [];
                            };
                            newBuffs[buffItem.targetId].push(buffItem);
                        };
                    };
                };
            };
            if (this._updateStatList)
            {
                KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
            };
            this._buffs = newBuffs;
            FightEventsHelper.sendAllFightEvent(true);
        }

        public function markFinishingBuffs(targetId:Number, currentTurnIsEnding:Boolean=true):void
        {
            var buffItem:BasicBuff;
            var buffWillEndBeforeTargetTurn:Boolean;
            var casterIndex:int;
            var targetIndex:int;
            var currentFighterIndex:int;
            var i:int;
            var fightersCount:int;
            var fighterId:Number;
            var fightBattleFrame:FightBattleFrame = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
            if (fightBattleFrame == null)
            {
                return;
            };
            var currentFighterId:Number = fightBattleFrame.currentPlayerId;
            if (GameDebugManager.getInstance().buffsDebugActivated)
            {
                _log.debug(((((("[BUFFS DEBUG] Recherche des buffs de " + targetId) + " qui vont finir durant le tour  (combattant actuel ") + currentFighterId) + ")    currentTurnIsEnding ") + currentTurnIsEnding));
            };
            if (this._buffs[targetId] == null)
            {
                return;
            };
            this._updateStatList = false;
            for each (buffItem in this._buffs[targetId])
            {
                if (buffItem.duration != 1)
                {
                }
                else
                {
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((((((("[BUFFS DEBUG]     - Buff " + buffItem.uid) + " n'a plus qu'un tour     (aliveSource ") + buffItem.aliveSource) + "  sourceJustReaffected ") + buffItem.sourceJustReaffected) + ")"));
                    };
                    buffWillEndBeforeTargetTurn = false;
                    casterIndex = -1;
                    targetIndex = -1;
                    currentFighterIndex = -1;
                    i = 0;
                    fightersCount = fightBattleFrame.fightersList.length;
                    while (i < fightersCount)
                    {
                        fighterId = fightBattleFrame.fightersList[i];
                        if (fighterId == buffItem.aliveSource)
                        {
                            if (buffItem.sourceJustReaffected)
                            {
                                buffItem.sourceJustReaffected = false;
                            }
                            else
                            {
                                casterIndex = i;
                            };
                        };
                        if (fighterId == buffItem.targetId)
                        {
                            targetIndex = i;
                        };
                        if (fighterId == currentFighterId)
                        {
                            currentFighterIndex = i;
                        };
                        i++;
                    };
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug(((((("[BUFFS DEBUG]             Index des combattants pour ce buff : lanceur " + casterIndex) + ", cible ") + targetIndex) + "     combattant actuel ") + currentFighterIndex));
                    };
                    if ((((casterIndex == -1) || (targetIndex == -1)) || (currentFighterIndex == -1)))
                    {
                        _log.warn("Error when marking finishing buff, fighters cannot be found ");
                        return;
                    };
                    if (casterIndex == targetIndex)
                    {
                        if (((currentFighterIndex == targetIndex) && (!(currentTurnIsEnding))))
                        {
                            if (GameDebugManager.getInstance().buffsDebugActivated)
                            {
                                _log.debug("[BUFFS DEBUG]                 cible = target = combattant actuel et ce n'est pas une fin de tour, on ne desactive pas");
                            };
                            continue;
                        };
                        buffWillEndBeforeTargetTurn = true;
                        if (GameDebugManager.getInstance().buffsDebugActivated)
                        {
                            _log.debug("[BUFFS DEBUG]                 cible = target, le buff doit etre desactivé");
                        };
                    }
                    else
                    {
                        if (((currentFighterIndex == targetIndex) && (currentTurnIsEnding)))
                        {
                            buffWillEndBeforeTargetTurn = true;
                            if (GameDebugManager.getInstance().buffsDebugActivated)
                            {
                                _log.debug("[BUFFS DEBUG]                 fin du tour de la cible, le buff doit etre desactivé");
                            };
                        }
                        else
                        {
                            if (casterIndex > targetIndex)
                            {
                                if (currentFighterIndex >= casterIndex)
                                {
                                    currentFighterIndex = (currentFighterIndex - fightersCount);
                                };
                                casterIndex = (casterIndex - fightersCount);
                            };
                            _log.debug(((((("[BUFFS DEBUG]           --->  Index des combattants pour ce buff : lanceur " + casterIndex) + ", cible ") + targetIndex) + "     combattant actuel ") + currentFighterIndex));
                            if (((currentFighterIndex < casterIndex) || (currentFighterIndex > targetIndex)))
                            {
                                buffWillEndBeforeTargetTurn = true;
                                if (GameDebugManager.getInstance().buffsDebugActivated)
                                {
                                    _log.debug("[BUFFS DEBUG]                 le combattant actuel n'est pas entre le caster et la target, le buff doit etre desactivé");
                                };
                            };
                        };
                    };
                    if (buffWillEndBeforeTargetTurn)
                    {
                        if (GameDebugManager.getInstance().buffsDebugActivated)
                        {
                            _log.debug((("[BUFFS DEBUG]                   Buff " + buffItem.uid) + " doit être désactivé, il ne doit plus être affiché dans les stats du combattant"));
                        };
                        BasicBuff(buffItem).onDisabled();
                        if (targetId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                        {
                            this._updateStatList = true;
                        };
                    };
                };
            };
            if (this._updateStatList)
            {
                KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
            };
        }

        public function addBuff(buff:BasicBuff, applyBuff:Boolean=true):void
        {
            var sameBuff:BasicBuff;
            var actualBuff:BasicBuff;
            if (!this._buffs[buff.targetId])
            {
                this._buffs[buff.targetId] = [];
            };
            if (GameDebugManager.getInstance().buffsDebugActivated)
            {
                _log.debug(((("[BUFFS DEBUG] Ajout du buff " + buff.uid) + " sur ") + buff.targetId));
            };
            var buffsCount:int = this._buffs[buff.targetId].length;
            var i:int;
            while (i < buffsCount)
            {
                actualBuff = this._buffs[buff.targetId][i];
                if (buff.equals(actualBuff))
                {
                    sameBuff = actualBuff;
                    break;
                };
                i++;
            };
            if (!sameBuff)
            {
                this._buffs[buff.targetId].push(buff);
            }
            else
            {
                if ((((sameBuff is TriggeredBuff) && (!(sameBuff.effect.triggers.indexOf("|") == -1))) || ((((sameBuff.castingSpell.spellRank) && (sameBuff.castingSpell.spellRank.maxStack > 0)) && (sameBuff.stack)) && (sameBuff.stack.length == sameBuff.castingSpell.spellRank.maxStack))))
                {
                    return;
                };
                sameBuff.add(buff);
            };
            if (applyBuff)
            {
                buff.onApplied();
            };
            if (!sameBuff)
            {
                KernelEventsManager.getInstance().processCallback(FightHookList.BuffAdd, buff.id, buff.targetId);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate, sameBuff.id, sameBuff.targetId);
            };
        }

        public function updateBuff(buff:BasicBuff):Boolean
        {
            var oldBuff:BasicBuff;
            var targetId:Number = buff.targetId;
            if (GameDebugManager.getInstance().buffsDebugActivated)
            {
                _log.debug(((("[BUFFS DEBUG] Mise à jour du buff " + buff.uid) + " sur ") + buff.targetId));
            };
            if (!this._buffs[targetId])
            {
                return (false);
            };
            var i:int = this.getBuffIndex(targetId, buff.id);
            if (i == -1)
            {
                return (false);
            };
            this._buffs[targetId][i].onRemoved();
            this._buffs[targetId][i].updateParam(buff.param1, buff.param2, buff.param3, buff.id);
            oldBuff = this._buffs[targetId][i];
            if (!oldBuff)
            {
                return (false);
            };
            oldBuff.onApplied();
            KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate, oldBuff.id, targetId);
            return (true);
        }

        public function dispell(targetId:Number, forceUndispellable:Boolean=false, critical:Boolean=false, dying:Boolean=false):void
        {
            var buff:BasicBuff;
            if (GameDebugManager.getInstance().buffsDebugActivated)
            {
                _log.debug(("[BUFFS DEBUG] Desenvoutement de tous les buffs de " + targetId));
            };
            var newBuffs:Array = [];
            for each (buff in this._buffs[targetId])
            {
                if (buff.canBeDispell(forceUndispellable, int.MIN_VALUE, dying))
                {
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((("[BUFFS DEBUG]      Buff " + buff.uid) + " doit être retiré"));
                    };
                    KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove, buff.id, targetId, "Dispell");
                    buff.onRemoved();
                }
                else
                {
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((("[BUFFS DEBUG]      Buff " + buff.uid) + " reste"));
                    };
                    newBuffs.push(buff);
                };
            };
            this._buffs[targetId] = newBuffs;
        }

        public function dispellSpell(targetId:Number, spellId:uint, forceUndispellable:Boolean=false, critical:Boolean=false, dying:Boolean=false):void
        {
            var buff:BasicBuff;
            if (GameDebugManager.getInstance().buffsDebugActivated)
            {
                _log.debug(((("[BUFFS DEBUG] Desenvoutement de tous les buffs du sort " + spellId) + " de ") + targetId));
            };
            var newBuffs:Array = [];
            var currentFighterId:Number = CurrentPlayedFighterManager.getInstance().currentFighterId;
            this._updateStatList = false;
            for each (buff in this._buffs[targetId])
            {
                if (((spellId == buff.castingSpell.spell.id) && (buff.canBeDispell(forceUndispellable, int.MIN_VALUE, dying))))
                {
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((("[BUFFS DEBUG]      Buff " + buff.uid) + " doit être retiré"));
                    };
                    buff.onRemoved();
                    if (((targetId == currentFighterId) || (buff.targetId == currentFighterId)))
                    {
                        this._updateStatList = true;
                    };
                    KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove, buff, targetId, "Dispell");
                }
                else
                {
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((("[BUFFS DEBUG]      Buff " + buff.uid) + " reste"));
                    };
                    newBuffs.push(buff);
                };
            };
            this._buffs[targetId] = newBuffs;
            if (this._updateStatList)
            {
                KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
            };
        }

        public function dispellUniqueBuff(targetId:Number, boostUID:int, forceUndispellable:Boolean=false, dying:Boolean=false, ultimateDebuff:Boolean=true):void
        {
            var isState:Boolean;
            var i:int = this.getBuffIndex(targetId, boostUID);
            if (i == -1)
            {
                return;
            };
            var buff:BasicBuff = this._buffs[targetId][i];
            if (buff.canBeDispell(forceUndispellable, ((ultimateDebuff) ? boostUID : int.MIN_VALUE), dying))
            {
                if ((((buff.stack) && (buff.stack.length > 1)) && (!(dying))))
                {
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug(((("[BUFFS DEBUG] Desenvoutement du buff stacké " + boostUID) + " de ") + targetId));
                    };
                    buff.onRemoved();
                    isState = false;
                    switch (buff.actionId)
                    {
                        case ActionIds.ACTION_BOOST_SPELL_BASE_DMG:
                            buff.param1 = buff.stack[0].param1;
                            buff.param2 = (buff.param2 - buff.stack[0].param2);
                            buff.param3 = (buff.param3 - buff.stack[0].param3);
                            break;
                        case ActionIds.ACTION_CHARACTER_PUNISHMENT:
                            buff.param1 = (buff.param1 - buff.stack[0].param2);
                            break;
                        case ActionIds.ACTION_FIGHT_SET_STATE:
                        case ActionIds.ACTION_FIGHT_UNSET_STATE:
                            isState = true;
                            break;
                        default:
                            buff.param1 = (buff.param1 - buff.stack[0].param1);
                            buff.param2 = (buff.param2 - buff.stack[0].param2);
                            buff.param3 = (buff.param3 - buff.stack[0].param3);
                    };
                    buff.stack.shift();
                    buff.refreshDescription();
                    if (!isState)
                    {
                        buff.onApplied();
                    };
                    KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate, buff.id, buff.targetId);
                }
                else
                {
                    KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove, buff.id, targetId, "Dispell");
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug(((("[BUFFS DEBUG] Desenvoutement du buff " + boostUID) + " de ") + targetId));
                    };
                    this._buffs[targetId].splice(this._buffs[targetId].indexOf(buff), 1);
                    buff.onRemoved();
                    if (targetId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
                        SpellWrapper.refreshAllPlayerSpellHolder(targetId);
                    };
                };
            };
        }

        public function removeLinkedBuff(sourceId:Number, forceUndispellable:Boolean=false, dying:Boolean=false):Array
        {
            var buffList:Array;
            var buffListCopy:Array;
            var buff:BasicBuff;
            var impactedTarget:Array = [];
            var entitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            var fightBattleFrame:FightBattleFrame = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
            var infos:GameFightFighterInformations = (entitiesFrame.getEntityInfos(sourceId) as GameFightFighterInformations);
            if (GameDebugManager.getInstance().buffsDebugActivated)
            {
                _log.debug(("[BUFFS DEBUG] Retrait des buffs lancés par " + sourceId));
            };
            for each (buffList in this._buffs)
            {
                buffListCopy = [];
                for each (buff in buffList)
                {
                    buffListCopy.push(buff);
                };
                for each (buff in buffListCopy)
                {
                    if (buff.source == sourceId)
                    {
                        if (GameDebugManager.getInstance().buffsDebugActivated)
                        {
                            _log.debug((("[BUFFS DEBUG]      Buff " + buff.uid) + " doit être retiré"));
                        };
                        this.dispellUniqueBuff(buff.targetId, buff.id, forceUndispellable, dying, false);
                        if (impactedTarget.indexOf(buff.targetId) == -1)
                        {
                            impactedTarget.push(buff.targetId);
                        };
                        if ((((dying) && (infos.stats.summoned)) && (!(infos.stats.summoner == fightBattleFrame.currentPlayerId))))
                        {
                            buff.aliveSource = infos.stats.summoner;
                            if (GameDebugManager.getInstance().buffsDebugActivated)
                            {
                                _log.debug(((("[BUFFS DEBUG]      Buff " + buff.uid) + " doit être reaffecté à l'invocateur ") + infos.stats.summoner));
                            };
                        };
                    };
                };
            };
            return (impactedTarget);
        }

        public function reaffectBuffs(sourceId:Number):void
        {
            var next:Number;
            var frame:FightBattleFrame;
            var dontDecrementBuffThisTurn:Boolean;
            var buffList:Array;
            var buff:BasicBuff;
            var entity:GameFightFighterInformations = (this.fightEntitiesFrame.getEntityInfos(sourceId) as GameFightFighterInformations);
            if (entity.stats.summoned)
            {
                next = this.getNextFighter(sourceId);
                if (GameDebugManager.getInstance().buffsDebugActivated)
                {
                    _log.debug(((("[BUFFS DEBUG] Réaffectation des buffs lancés par " + sourceId) + ", le nouveau 'lanceur' sera ") + next));
                };
                frame = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
                dontDecrementBuffThisTurn = false;
                if (frame.currentPlayerId == sourceId)
                {
                    dontDecrementBuffThisTurn = true;
                };
                for each (buffList in this._buffs)
                {
                    for each (buff in buffList)
                    {
                        if (buff.aliveSource == sourceId)
                        {
                            if (GameDebugManager.getInstance().buffsDebugActivated)
                            {
                                _log.debug((("[BUFFS DEBUG]      Buff " + buff.uid) + " doit être reaffecté"));
                            };
                            buff.aliveSource = next;
                            buff.sourceJustReaffected = dontDecrementBuffThisTurn;
                        };
                    };
                };
            };
        }

        private function getNextFighter(sourceId:Number):Number
        {
            var fighter:Number;
            var frame:FightBattleFrame = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
            if (frame == null)
            {
                return (0);
            };
            var found:Boolean;
            for each (fighter in frame.fightersList)
            {
                if (found)
                {
                    return (fighter);
                };
                if (fighter == sourceId)
                {
                    found = true;
                };
            };
            if (found)
            {
                return (frame.fightersList[0]);
            };
            return (0);
        }

        public function getFighterInfo(targetId:Number):GameFightFighterInformations
        {
            return (this.fightEntitiesFrame.getEntityInfos(targetId) as GameFightFighterInformations);
        }

        public function getAllBuff(targetId:Number):Array
        {
            return (this._buffs[targetId]);
        }

        public function getLifeThreshold(targetId:Number):uint
        {
            var buffObj:Object;
            var lifeThreshold:uint;
            var targetBuffs:Array = this._buffs[targetId];
            if (!targetBuffs)
            {
                return (0);
            };
            var index:uint;
            while (index < targetBuffs.length)
            {
                buffObj = targetBuffs[index];
                if ((((buffObj) && (!(buffObj.removed))) && (buffObj.actionId === ActionIdProtocol.ACTION_CHARACTER_BOOST_THRESHOLD)))
                {
                    lifeThreshold = Math.max(lifeThreshold, buffObj.delta);
                };
                index++;
            };
            return (lifeThreshold);
        }

        public function resetTriggerCount(targetId:Number):Boolean
        {
            var buff:BasicBuff;
            for each (buff in this._buffs[targetId])
            {
                if ((buff is TriggeredBuff))
                {
                    TriggeredBuff(buff).triggerCount = 0;
                    return (true);
                };
            };
            return (false);
        }

        public function getBuff(buffId:uint, playerId:Number):BasicBuff
        {
            var buff:BasicBuff;
            for each (buff in this._buffs[playerId])
            {
                if (buffId == buff.id)
                {
                    return (buff);
                };
            };
            return (null);
        }

        public function getSpellBuffs(spellId:int, targetId:Number):Vector.<SpellBuff>
        {
            var spellBuff:SpellBuff;
            var buff:BasicBuff;
            var targetBuffs:Array = this._buffs[targetId];
            var spellBuffs:Vector.<SpellBuff> = new Vector.<SpellBuff>(0);
            if (targetBuffs !== null)
            {
                for each (buff in targetBuffs)
                {
                    if (!(buff is SpellBuff))
                    {
                    }
                    else
                    {
                        spellBuff = (buff as SpellBuff);
                        if (spellBuff.spellId === spellId)
                        {
                            spellBuffs.push(spellBuff);
                        };
                    };
                };
            };
            return (spellBuffs);
        }

        private function get fightEntitiesFrame():FightEntitiesFrame
        {
            return (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
        }

        private function getBuffIndex(targetId:Number, buffId:int):int
        {
            var i:Object;
            var subBuff:BasicBuff;
            for (i in this._buffs[targetId])
            {
                if (buffId == this._buffs[targetId][i].id)
                {
                    return (int(i));
                };
                for each (subBuff in (this._buffs[targetId][i] as BasicBuff).stack)
                {
                    if (buffId == subBuff.id)
                    {
                        return (int(i));
                    };
                };
            };
            return (-1);
        }


    }
} com.ankamagames.dofus.logic.game.fight.managers

