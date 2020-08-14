package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.datacenter.temporis.CustomModeBreedSpell;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.network.messages.game.inventory.spells.SpellListMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.SlaveSwitchContextMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
    import com.ankamagames.dofus.logic.game.roleplay.actions.SpellVariantActivationRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.SpellVariantActivationRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.SpellVariantActivationMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.FinishMoveListRequestAction;
    import com.ankamagames.dofus.network.messages.game.finishmoves.FinishMoveListRequestMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.FinishMoveSetRequestAction;
    import com.ankamagames.dofus.network.messages.game.finishmoves.FinishMoveSetRequestMessage;
    import com.ankamagames.dofus.network.messages.game.finishmoves.FinishMoveListMessage;
    import com.ankamagames.dofus.datacenter.spells.FinishMove;
    import com.ankamagames.dofus.network.types.game.finishmoves.FinishMoveInformations;
    import com.ankamagames.dofus.network.types.game.data.items.SpellItem;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import com.ankamagames.dofus.datacenter.spells.SpellVariant;
    import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
    import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
    import com.ankamagames.dofus.datacenter.servers.ServerTemporisSeason;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.uiApi.FightApi;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.dofus.misc.lists.InventoryHookList;
    import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.jerakine.messages.Message;
    import __AS3__.vec.*;

    public class SpellInventoryManagementFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellInventoryManagementFrame));

        private var _fullSpellList:Array = new Array();
        private var _spellsGlobalCooldowns:Dictionary = new Dictionary();


        private static function generateCurrentCustomModeBreedSpells():Array
        {
            var spellId:int;
            var playerApi:PlayedCharacterApi = PlayedCharacterApi.getInstance();
            if (playerApi === null)
            {
                return ([]);
            };
            var customSpells:Array = [];
            var playerBreed:int = playerApi.getPlayedCharacterInfo().breed;
            var spellsInventory:Array = playerApi.getSpellInventory();
            var allSpellIds:Array = playerApi.getCustomModeSpellIds();
            var spellWrapper:SpellWrapper;
            var customModeBreedSpell:CustomModeBreedSpell;
            for each (spellWrapper in spellsInventory)
            {
                spellId = spellWrapper.spell.id;
                if (allSpellIds.indexOf(spellId) === -1)
                {
                }
                else
                {
                    customModeBreedSpell = playerApi.getCustomModeBreedSpellById(spellId);
                    if (((customModeBreedSpell === null) || (!(customModeBreedSpell.breedId === playerBreed))))
                    {
                    }
                    else
                    {
                        customSpells.push([spellWrapper]);
                    };
                };
            };
            return (customSpells);
        }


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var sw:SpellWrapper;
            var playerId:Number;
            var spellData:Spell;
            var slmsg:SpellListMessage;
            var isTemporisSpellsUi:Boolean;
            var idsList:Array;
            var spellInVariantData:Spell;
            var sscmsg:SlaveSwitchContextMessage;
            var slaveId:int;
            var sgcds:Vector.<GameFightSpellCooldown>;
            var imf:InventoryManagementFrame;
            var svara:SpellVariantActivationRequestAction;
            var svarmsg:SpellVariantActivationRequestMessage;
            var svamsg:SpellVariantActivationMessage;
            var fmlra:FinishMoveListRequestAction;
            var fmlrmsg:FinishMoveListRequestMessage;
            var fmsra:FinishMoveSetRequestAction;
            var fmId:int;
            var fmsrmsg:FinishMoveSetRequestMessage;
            var fmlmsg:FinishMoveListMessage;
            var finishMoves:Array;
            var fm:FinishMove;
            var fmi:FinishMoveInformations;
            var spell:SpellItem;
            var customModeBreedSpells:Array;
            var index:uint;
            var spellId:int;
            var playerBreed:Breed;
            var spellVariant:SpellVariant;
            var swBreed:Spell;
            var spellInvoc:SpellItem;
            var gfsc:GameFightSpellCooldown;
            var spellLevel:uint;
            var gcdvalue:int;
            var spellCastManager:SpellCastInFightManager;
            var spellManager:SpellManager;
            var spellKnown:Boolean;
            var deactivatedSpellId:int;
            var variants:Array;
            var variant:SpellVariant;
            var spellIdInVariant:int;
            switch (true)
            {
                case (msg is SpellListMessage):
                    slmsg = (msg as SpellListMessage);
                    isTemporisSpellsUi = ServerTemporisSeason.isTemporisSpellsUi;
                    playerId = PlayedCharacterManager.getInstance().id;
                    this._fullSpellList[playerId] = new Array();
                    idsList = new Array();
                    for each (spell in slmsg.spells)
                    {
                        spellData = Spell.getSpellById(spell.spellId);
                        if (spellData == null)
                        {
                            _log.warn(("Unknown spell with id " + spell.spellId));
                        }
                        else
                        {
                            if (!spellData.spellVariant)
                            {
                                this._fullSpellList[playerId].push(SpellWrapper.create(spell.spellId, spell.spellLevel, true, PlayedCharacterManager.getInstance().id, true));
                                if (isTemporisSpellsUi)
                                {
                                    idsList.push(spell.spellId);
                                };
                            }
                            else
                            {
                                for each (spellInVariantData in spellData.spellVariant.spells)
                                {
                                    if (spellInVariantData.id == spell.spellId)
                                    {
                                        this._fullSpellList[playerId].push(SpellWrapper.create(spellInVariantData.id, spell.spellLevel, true, PlayedCharacterManager.getInstance().id, true));
                                    }
                                    else
                                    {
                                        this._fullSpellList[playerId].push(SpellWrapper.create(spellInVariantData.id, 0, true, PlayedCharacterManager.getInstance().id));
                                    };
                                    idsList.push(spellInVariantData.id);
                                };
                            };
                        };
                    };
                    if (slmsg.spellPrevisualization)
                    {
                        if (isTemporisSpellsUi)
                        {
                            customModeBreedSpells = CustomModeBreedSpell.getCustomModeBreedSpellList(PlayedCharacterManager.getInstance().infos.breed);
                            index = 0;
                            while (index < customModeBreedSpells.length)
                            {
                                spellId = customModeBreedSpells[index].id;
                                if (idsList.indexOf(spellId) !== -1)
                                {
                                }
                                else
                                {
                                    spellData = Spell.getSpellById(spellId);
                                    if (spellData === null)
                                    {
                                        _log.warn(("Unknown spell with id " + spellId));
                                    }
                                    else
                                    {
                                        if (!spellData.spellVariant)
                                        {
                                            this._fullSpellList[playerId].push(SpellWrapper.create(spellData.id, 0, true, PlayedCharacterManager.getInstance().id, true));
                                        }
                                        else
                                        {
                                            for each (spellInVariantData in spellData.spellVariant.spells)
                                            {
                                                if (spellInVariantData.id === spellData.id)
                                                {
                                                    this._fullSpellList[playerId].push(SpellWrapper.create(spellInVariantData.id, 0, true, PlayedCharacterManager.getInstance().id, true));
                                                }
                                                else
                                                {
                                                    this._fullSpellList[playerId].push(SpellWrapper.create(spellInVariantData.id, 0, true, PlayedCharacterManager.getInstance().id));
                                                };
                                            };
                                        };
                                    };
                                };
                                index++;
                            };
                        }
                        else
                        {
                            playerBreed = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                            for each (spellVariant in playerBreed.breedSpellVariants)
                            {
                                for each (swBreed in spellVariant.spells)
                                {
                                    if (idsList.indexOf(swBreed.id) == -1)
                                    {
                                        this._fullSpellList[playerId].push(SpellWrapper.create(swBreed.id, 0, true, PlayedCharacterManager.getInstance().id));
                                    };
                                };
                            };
                        };
                    };
                    PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList[playerId];
                    PlayedCharacterManager.getInstance().playerSpellList = this._fullSpellList[playerId];
                    KernelEventsManager.getInstance().processCallback(HookList.SpellListUpdate, this._fullSpellList[playerId]);
                    return (true);
                case (msg is SlaveSwitchContextMessage):
                    sscmsg = (msg as SlaveSwitchContextMessage);
                    FightApi.slaveContext = true;
                    slaveId = sscmsg.slaveId;
                    this._fullSpellList[slaveId] = new Array();
                    for each (spellInvoc in sscmsg.slaveSpells)
                    {
                        this._fullSpellList[slaveId].push(SpellWrapper.create(spellInvoc.spellId, spellInvoc.spellLevel, true, slaveId));
                    };
                    PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList[slaveId];
                    if (!CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(slaveId))
                    {
                        CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(slaveId, sscmsg.slaveStats);
                    };
                    if (CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(slaveId).needCooldownUpdate)
                    {
                        CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(slaveId).updateCooldowns();
                    };
                    sgcds = this._spellsGlobalCooldowns[slaveId];
                    if (sgcds)
                    {
                        for each (gfsc in sgcds)
                        {
                            spellCastManager = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(slaveId);
                            gcdvalue = gfsc.cooldown;
                            spellKnown = false;
                            for each (sw in this._fullSpellList[slaveId])
                            {
                                if (sw.spellId == gfsc.spellId)
                                {
                                    spellKnown = true;
                                    spellLevel = sw.spellLevel;
                                    if (gcdvalue == -1)
                                    {
                                        gcdvalue = sw.spellLevelInfos.minCastInterval;
                                    };
                                    break;
                                };
                            };
                            if (spellKnown)
                            {
                                if (!spellCastManager.getSpellManagerBySpellId(gfsc.spellId))
                                {
                                    spellCastManager.castSpell(gfsc.spellId, spellLevel, [], false);
                                };
                                spellManager = spellCastManager.getSpellManagerBySpellId(gfsc.spellId);
                                spellManager.forceCooldown(gcdvalue);
                            };
                        };
                        sgcds.length = 0;
                        delete this._spellsGlobalCooldowns[slaveId];
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.SpellListUpdate, this._fullSpellList[slaveId]);
                    if (Kernel.getWorker().contains(FightSpellCastFrame))
                    {
                        Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(FightSpellCastFrame));
                    };
                    imf = (Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame);
                    InventoryManager.getInstance().shortcutBarSpells = imf.getWrappersFromShortcuts(sscmsg.shortcuts);
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, ShortcutBarEnum.SPELL_SHORTCUT_BAR);
                    return (false);
                case (msg is SpellVariantActivationRequestAction):
                    svara = (msg as SpellVariantActivationRequestAction);
                    svarmsg = new SpellVariantActivationRequestMessage();
                    svarmsg.initSpellVariantActivationRequestMessage(svara.spellId);
                    ConnectionsHandler.getConnection().send(svarmsg);
                    return (true);
                case (msg is SpellVariantActivationMessage):
                    svamsg = (msg as SpellVariantActivationMessage);
                    if (svamsg.result)
                    {
                        deactivatedSpellId = 0;
                        variants = SpellVariant.getSpellVariants();
                        for each (variant in variants)
                        {
                            if (variant.spellIds.indexOf(svamsg.spellId) != -1)
                            {
                                for each (spellIdInVariant in variant.spellIds)
                                {
                                    if (spellIdInVariant != svamsg.spellId)
                                    {
                                        deactivatedSpellId = spellIdInVariant;
                                    };
                                };
                            };
                        };
                        for each (sw in this._fullSpellList[PlayedCharacterManager.getInstance().id])
                        {
                            if (((sw.spellId == svamsg.spellId) && (!(sw.variantActivated))))
                            {
                                sw.variantActivated = true;
                            }
                            else
                            {
                                if (((sw.spellId == deactivatedSpellId) && (sw.variantActivated)))
                                {
                                    sw.variantActivated = false;
                                };
                            };
                        };
                        KernelEventsManager.getInstance().processCallback(InventoryHookList.SpellVariantActivated, svamsg.spellId, deactivatedSpellId);
                    };
                    return (true);
                case (msg is FinishMoveListRequestAction):
                    fmlra = (msg as FinishMoveListRequestAction);
                    fmlrmsg = new FinishMoveListRequestMessage();
                    fmlrmsg.initFinishMoveListRequestMessage();
                    ConnectionsHandler.getConnection().send(fmlrmsg);
                    return (true);
                case (msg is FinishMoveSetRequestAction):
                    fmsra = (msg as FinishMoveSetRequestAction);
                    for each (fmId in fmsra.enabledFinishedMoves)
                    {
                        fmsrmsg = new FinishMoveSetRequestMessage();
                        fmsrmsg.initFinishMoveSetRequestMessage(fmId, true);
                        ConnectionsHandler.getConnection().send(fmsrmsg);
                    };
                    for each (fmId in fmsra.disabledFinishedMoves)
                    {
                        fmsrmsg = new FinishMoveSetRequestMessage();
                        fmsrmsg.initFinishMoveSetRequestMessage(fmId, false);
                        ConnectionsHandler.getConnection().send(fmsrmsg);
                    };
                    return (true);
                case (msg is FinishMoveListMessage):
                    fmlmsg = (msg as FinishMoveListMessage);
                    finishMoves = new Array();
                    for each (fmi in fmlmsg.finishMoves)
                    {
                        fm = FinishMove.getFinishMoveById(fmi.finishMoveId);
                        finishMoves.push({
                            "id":fm.id,
                            "name":Spell.getSpellById(fm.getSpellLevel().spellId).name,
                            "enabled":fmi.finishMoveState
                        });
                    };
                    finishMoves.sortOn("id", Array.NUMERIC);
                    KernelEventsManager.getInstance().processCallback(HookList.FinishMoveList, finishMoves);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function getFullSpellListByOwnerId(ownerId:Number):Array
        {
            return (this._fullSpellList[ownerId]);
        }

        public function addSpellGlobalCoolDownInfo(pEntityId:Number, pGameFightSpellCooldown:GameFightSpellCooldown):void
        {
            if (!this._spellsGlobalCooldowns[pEntityId])
            {
                this._spellsGlobalCooldowns[pEntityId] = new Vector.<GameFightSpellCooldown>(0);
            };
            this._spellsGlobalCooldowns[pEntityId].push(pGameFightSpellCooldown);
        }

        public function deleteSpellsGlobalCoolDownsData():void
        {
            var id:*;
            for (id in this._spellsGlobalCooldowns)
            {
                this._spellsGlobalCooldowns[id].length = 0;
                delete this._spellsGlobalCooldowns[id];
            };
        }

        public function getBreedSpellsInVariantsArray():Array
        {
            var spellWrapper:SpellWrapper;
            var firstSpellId:int;
            var spellId:int;
            var idsPack:Vector.<uint>;
            var spellVariant:SpellVariant;
            var spellIdInVector:Vector.<uint>;
            var variants:Array;
            if (ServerTemporisSeason.isTemporisSpellsUi)
            {
                return (generateCurrentCustomModeBreedSpells());
            };
            var playerBreedId:int = PlayedCharacterManager.getInstance().infos.breed;
            var breedData:Breed = Breed.getBreedById(playerBreedId);
            var breedSpellsId:Array = breedData.allSpellsId;
            var spellsInventory:Array = PlayedCharacterManager.getInstance().spellsInventory;
            var spells:Array = new Array();
            var variantIdsPacks:Array = new Array();
            var spellWrappersById:Dictionary = new Dictionary(true);
            var processedVariantIds:Array = new Array();
            for each (spellWrapper in spellsInventory)
            {
                if (breedSpellsId.indexOf(spellWrapper.spell.id) == -1)
                {
                }
                else
                {
                    spellWrappersById[spellWrapper.id] = spellWrapper;
                    spellVariant = spellWrapper.spell.spellVariant;
                    if (spellVariant)
                    {
                        firstSpellId = spellVariant.spellIds[0];
                        if (processedVariantIds.indexOf(firstSpellId) == -1)
                        {
                            processedVariantIds.push(firstSpellId);
                            variantIdsPacks.push(spellVariant.spellIds);
                        };
                    }
                    else
                    {
                        spellIdInVector = new Vector.<uint>();
                        spellIdInVector.push(spellWrapper.id);
                        variantIdsPacks.push(spellIdInVector);
                    };
                };
            };
            for each (idsPack in variantIdsPacks)
            {
                variants = new Array();
                for each (spellId in idsPack)
                {
                    if (spellWrappersById[spellId])
                    {
                        variants.push(spellWrappersById[spellId]);
                    };
                };
                spells.push(variants);
            };
            spells.sort(this.sortOnObtentionLevel);
            return (spells);
        }

        public function getCommonSpellsInVariantsArray():Array
        {
            var breedSpellsId:Array;
            var spellWrapper:SpellWrapper;
            var firstSpellId:int;
            var spellId:int;
            var idsPack:Vector.<uint>;
            var isTemporisSpell:Boolean;
            var breedData:Breed;
            var spellVariant:SpellVariant;
            var spellIdInVector:Vector.<uint>;
            var variants:Array;
            var playerBreedId:int = PlayedCharacterManager.getInstance().infos.breed;
            var _isTemporisSpellsUi:Boolean = ServerTemporisSeason.isTemporisSpellsUi;
            if (_isTemporisSpellsUi)
            {
                breedSpellsId = CustomModeBreedSpell.getCustomModeBreedSpellIds(playerBreedId);
            }
            else
            {
                breedData = Breed.getBreedById(playerBreedId);
                breedSpellsId = breedData.allSpellsId;
            };
            var spellsInventory:Array = PlayedCharacterManager.getInstance().spellsInventory;
            var spells:Array = new Array();
            var variantIdsPacks:Array = new Array();
            var spellWrappersById:Dictionary = new Dictionary(true);
            var processedVariantIds:Array = new Array();
            for each (spellWrapper in spellsInventory)
            {
                isTemporisSpell = ((_isTemporisSpellsUi) && (SpellManager.isForgettableSpell(spellWrapper.spell.id)));
                if (((!(breedSpellsId.indexOf(spellWrapper.spell.id) == -1)) || (isTemporisSpell)))
                {
                }
                else
                {
                    spellWrappersById[spellWrapper.id] = spellWrapper;
                    spellVariant = spellWrapper.spell.spellVariant;
                    if (spellVariant)
                    {
                        firstSpellId = spellVariant.spellIds[0];
                        if (processedVariantIds.indexOf(firstSpellId) == -1)
                        {
                            processedVariantIds.push(firstSpellId);
                            variantIdsPacks.push(spellVariant.spellIds);
                        };
                    }
                    else
                    {
                        spellIdInVector = new Vector.<uint>();
                        spellIdInVector.push(spellWrapper.id);
                        variantIdsPacks.push(spellIdInVector);
                    };
                };
            };
            for each (idsPack in variantIdsPacks)
            {
                variants = new Array();
                for each (spellId in idsPack)
                {
                    if (spellWrappersById[spellId])
                    {
                        variants.push(spellWrappersById[spellId]);
                    };
                };
                spells.push(variants);
            };
            spells.sort(this.sortOnObtentionLevel);
            return (spells);
        }

        private function sortOnObtentionLevel(spellsA:Object, spellsB:Object):Number
        {
            var aObtentionLevel:int = spellsA[0].spell.getSpellLevel(0).minPlayerLevel;
            var bObtentionLevel:int = spellsB[0].spell.getSpellLevel(0).minPlayerLevel;
            var aObtentionLevelVariant1:int;
            if (spellsA.length > 1)
            {
                aObtentionLevelVariant1 = spellsA[1].spell.getSpellLevel(0).minPlayerLevel;
            };
            var bObtentionLevelVariant1:int;
            if (spellsB.length > 1)
            {
                bObtentionLevelVariant1 = spellsB[1].spell.getSpellLevel(0).minPlayerLevel;
            };
            if (aObtentionLevel > bObtentionLevel)
            {
                return (1);
            };
            if (aObtentionLevel < bObtentionLevel)
            {
                return (-1);
            };
            if (aObtentionLevelVariant1 > bObtentionLevelVariant1)
            {
                return (1);
            };
            if (aObtentionLevelVariant1 < bObtentionLevelVariant1)
            {
                return (-1);
            };
            if (spellsA[0].id > spellsB[0].id)
            {
                return (1);
            };
            if (spellsA[0].id < spellsB[0].id)
            {
                return (-1);
            };
            return (0);
        }


    }
} com.ankamagames.dofus.logic.game.common.frames

