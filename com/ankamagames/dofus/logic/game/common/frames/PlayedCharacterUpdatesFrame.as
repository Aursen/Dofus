package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.messages.game.initialization.SetCharacterRestrictionsMessage;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.messages.game.initialization.ServerExperienceModificatorMessage;
    import com.ankamagames.dofus.network.messages.game.character.stats.CharacterStatsListMessage;
    import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.network.messages.game.initialization.CharacterCapabilitiesMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.ResetCharacterStatsRequestAction;
    import com.ankamagames.dofus.network.messages.game.character.stats.ResetCharacterStatsRequestMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.StatsUpgradeRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.stats.StatsUpgradeRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.stats.StatsUpgradeResultMessage;
    import com.ankamagames.dofus.network.messages.game.character.stats.CharacterLevelUpMessage;
    import com.ankamagames.dofus.network.messages.game.character.stats.CharacterExperienceGainMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.death.GameRolePlayPlayerLifeStatusMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.death.GameRolePlayGameOverMessage;
    import com.ankamagames.dofus.network.messages.game.almanach.AlmanachCalendarDateMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.SetUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.atlas.compass.CompassResetMessage;
    import com.ankamagames.dofus.network.messages.game.atlas.compass.CompassUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.basic.BasicTimeMessage;
    import com.ankamagames.dofus.network.messages.game.startup.StartupActionsListMessage;
    import com.ankamagames.dofus.network.messages.game.startup.StartupActionAddMessage;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignRequestAction;
    import com.ankamagames.dofus.network.messages.game.startup.StartupActionsObjetAttributionMessage;
    import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignAllRequestAction;
    import com.ankamagames.dofus.network.messages.game.startup.StartupActionsAllAttributionMessage;
    import com.ankamagames.dofus.network.messages.game.startup.StartupActionFinishedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMoneyMovementInformationMessage;
    import com.ankamagames.dofus.network.messages.game.character.debt.DebtsUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.character.debt.DebtsDeleteMessage;
    import com.ankamagames.dofus.network.messages.game.character.spell.forgettable.ForgettableSpellListUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.character.spell.forgettable.ForgettableSpellDeleteMessage;
    import com.ankamagames.dofus.network.messages.game.character.spell.forgettable.ForgettableSpellEquipmentSlotsMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
    import com.ankamagames.dofus.datacenter.spells.SpellVariant;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.network.messages.game.character.stats.CharacterLevelUpInformationMessage;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
    import com.ankamagames.dofus.network.types.game.startup.StartupActionAddObject;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemInformationWithQuantity;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.dofus.network.types.game.data.items.ForgettableSpellItem;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.PrismHookList;
    import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
    import com.ankamagames.dofus.network.enums.PrismStateEnum;
    import com.ankamagames.dofus.misc.lists.AlignmentHookList;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.network.enums.StatsUpgradeResultEnum;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
    import com.ankamagames.dofus.misc.lists.TriggerHookList;
    import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
    import com.ankamagames.dofus.logic.game.common.managers.AlmanaxManager;
    import com.ankamagames.dofus.datacenter.almanax.AlmanaxCalendar;
    import com.ankamagames.dofus.types.data.PlayerSetInfo;
    import com.ankamagames.dofus.misc.lists.InventoryHookList;
    import com.ankamagames.dofus.misc.lists.SocialHookList;
    import com.ankamagames.dofus.network.enums.CompassTypeEnum;
    import com.ankamagames.dofus.network.messages.game.atlas.compass.CompassUpdatePartyMemberMessage;
    import com.ankamagames.dofus.network.messages.game.atlas.compass.CompassUpdatePvpSeekMessage;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.misc.lists.RoleplayHookList;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
    import com.ankamagames.dofus.logic.game.common.managers.DebtManager;
    import com.ankamagames.dofus.network.enums.ForgettableSpellListActionEnum;
    import com.ankamagames.dofus.logic.common.managers.NotificationManager;
    import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
    import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;

    public class PlayedCharacterUpdatesFrame implements Frame 
    {

        public static var SPELL_TOOLTIP_CACHE_NUM:int = 0;
        public static var FORGETTABLE_SPELL_FIRST_NOTIF_NAME:String = "firstForgettableSpell";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayedCharacterUpdatesFrame));

        public var setList:Array;
        public var guildEmblemSymbolCategories:int;
        private var _kamasLimit:Number;


        public function get priority():int
        {
            return (Priority.HIGH);
        }

        public function get roleplayContextFrame():RoleplayContextFrame
        {
            return (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
        }

        public function get kamasLimit():Number
        {
            return (this._kamasLimit);
        }

        public function pushed():Boolean
        {
            this.setList = new Array();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var name:String;
            var followingPlayerId:Number;
            var playerTemporisSpellsDict:Dictionary;
            var scrmsg:SetCharacterRestrictionsMessage;
            var rpEntitiesFrame:RoleplayEntitiesFrame;
            var semsg:ServerExperienceModificatorMessage;
            var cslmsg:CharacterStatsListMessage;
            var fightBattleFrame:FightBattleFrame;
            var mcidmsg:MapComplementaryInformationsDataMessage;
            var grai:GameRolePlayActorInformations;
            var grpci:GameRolePlayCharacterInformations;
            var opt:* = undefined;
            var newSubArea:SubArea;
            var ccmsg:CharacterCapabilitiesMessage;
            var rcsra:ResetCharacterStatsRequestAction;
            var rcsrmsg:ResetCharacterStatsRequestMessage;
            var sura:StatsUpgradeRequestAction;
            var surqmsg:StatsUpgradeRequestMessage;
            var surmsg:StatsUpgradeResultMessage;
            var statUpgradeErrorText:String;
            var clumsg:CharacterLevelUpMessage;
            var messageId:uint;
            var cegmsg:CharacterExperienceGainMessage;
            var grplsmsg:GameRolePlayPlayerLifeStatusMessage;
            var grpgomsg:GameRolePlayGameOverMessage;
            var acdmsg:AlmanachCalendarDateMessage;
            var sumsg:SetUpdateMessage;
            var crmsg:CompassResetMessage;
            var cumsg:CompassUpdateMessage;
            var legend:String;
            var color:uint;
            var btmsg:BasicTimeMessage;
            var date:Date;
            var receptionDelay:int;
            var salm:StartupActionsListMessage;
            var giftList:Array;
            var saam:StartupActionAddMessage;
            var items:Array;
            var module:UiModule;
            var gar:GiftAssignRequestAction;
            var sao:StartupActionsObjetAttributionMessage;
            var gaara:GiftAssignAllRequestAction;
            var saaamsg:StartupActionsAllAttributionMessage;
            var safm:StartupActionFinishedMessage;
            var indexToDelete:int;
            var emmim:ExchangeMoneyMovementInformationMessage;
            var dum:DebtsUpdateMessage;
            var ddm:DebtsDeleteMessage;
            var fslumsg:ForgettableSpellListUpdateMessage;
            var fsdmsg:ForgettableSpellDeleteMessage;
            var fsesmsg:ForgettableSpellEquipmentSlotsMessage;
            var infos:GameRolePlayHumanoidInformations;
            var playerInfos:GameRolePlayCharacterInformations;
            var currentLook:TiphonEntityLook;
            var newLook:TiphonEntityLook;
            var prism:PrismSubAreaWrapper;
            var allianceFrame:AllianceFrame;
            var previousLevel:int;
            var caracPointEarned:uint;
            var healPointEarned:uint;
            var newSpellWrappers:Array;
            var obtentionLevel:uint;
            var spellVariant:SpellVariant;
            var playerBreed:Breed;
            var spellLevelBreed:SpellLevel;
            var cluimsg:CharacterLevelUpInformationMessage;
            var onSameMap:Boolean;
            var displayTextInfo:String;
            var spellBreed:Spell;
            var spellLevelBreedId:uint;
            var spellWrapper:SpellWrapper;
            var ssequencer:SerialSequencer;
            var entityId:Number;
            var ss:SerialSequencer;
            var socialFrame:SocialFrame;
            var memberId:Number;
            var active:Boolean;
            var socialFrame2:SocialFrame;
            var pmFrame:PartyManagementFrame;
            var memberInfo:PartyMemberWrapper;
            var gift:StartupActionAddObject;
            var _items:Array;
            var item:ObjectItemInformationWithQuantity;
            var obj:Object;
            var iw:ItemWrapper;
            var mod:UiModule;
            var dst:DataStoreType;
            var itema:ObjectItemInformationWithQuantity;
            var dataStoreType:DataStoreType;
            var giftAction:Object;
            var newSpellList:Dictionary;
            var ds:DataStoreType;
            var nid:uint;
            var forgettableSpell:ForgettableSpellItem;
            var forgettableSpellId:uint;
            switch (true)
            {
                case (msg is SetCharacterRestrictionsMessage):
                    scrmsg = (msg as SetCharacterRestrictionsMessage);
                    if (scrmsg.actorId == PlayedCharacterManager.getInstance().id)
                    {
                        PlayedCharacterManager.getInstance().restrictions = scrmsg.restrictions;
                    };
                    rpEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    if (rpEntitiesFrame)
                    {
                        infos = (rpEntitiesFrame.getEntityInfos(scrmsg.actorId) as GameRolePlayHumanoidInformations);
                        if (((infos) && (infos.humanoidInfo)))
                        {
                            infos.humanoidInfo.restrictions = scrmsg.restrictions;
                        };
                    };
                    return (true);
                case (msg is ServerExperienceModificatorMessage):
                    semsg = (msg as ServerExperienceModificatorMessage);
                    PlayedCharacterManager.getInstance().experiencePercent = (semsg.experiencePercent - 100);
                    return (true);
                case (msg is CharacterStatsListMessage):
                    cslmsg = (msg as CharacterStatsListMessage);
                    fightBattleFrame = (Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame);
                    if (((!(fightBattleFrame == null)) && (fightBattleFrame.executingSequence)))
                    {
                        fightBattleFrame.delayCharacterStatsList(cslmsg);
                    }
                    else
                    {
                        this.updateCharacterStatsList(cslmsg.stats);
                    };
                    if (((this.roleplayContextFrame) && (this.roleplayContextFrame.entitiesFrame)))
                    {
                        playerInfos = (this.roleplayContextFrame.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayCharacterInformations);
                        if (playerInfos)
                        {
                            playerInfos.alignmentInfos = cslmsg.stats.alignmentInfos;
                        };
                    };
                    if ((Kernel.getWorker().getFrame(QuestFrame) as QuestFrame).achievmentsListProcessed == false)
                    {
                        (Kernel.getWorker().getFrame(QuestFrame) as QuestFrame).processAchievements(true);
                    };
                    return (true);
                case (msg is MapComplementaryInformationsDataMessage):
                    mcidmsg = (msg as MapComplementaryInformationsDataMessage);
                    for each (grai in mcidmsg.actors)
                    {
                        grpci = (grai as GameRolePlayCharacterInformations);
                        if (((grpci) && (grpci.contextualId == PlayedCharacterManager.getInstance().id)))
                        {
                            currentLook = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
                            newLook = EntityLookAdapter.fromNetwork(grpci.look);
                            if (((!(currentLook.equals(newLook))) && (this.roleplayContextFrame.entitiesFrame)))
                            {
                                this.roleplayContextFrame.entitiesFrame.dispatchPlayerNewLook = true;
                            };
                            PlayedCharacterManager.getInstance().infos.entityLook = grpci.look;
                            for each (opt in grpci.humanoidInfo.options)
                            {
                                if ((opt is HumanOptionAlliance))
                                {
                                    PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable = (opt as HumanOptionAlliance).aggressable;
                                    KernelEventsManager.getInstance().processCallback(PrismHookList.PvpAvaStateChange, (opt as HumanOptionAlliance).aggressable, PlayedCharacterManager.getInstance().characteristics.probationTime);
                                    break;
                                };
                            };
                            break;
                        };
                    };
                    if (!((((PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.AvA_DISQUALIFIED) || (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE)) || (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.AvA_ENABLED_NON_AGGRESSABLE)) || (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE)))
                    {
                        return (false);
                    };
                    newSubArea = SubArea.getSubAreaByMapId(mcidmsg.mapId);
                    if (((PlayedCharacterManager.getInstance().currentSubArea) && (newSubArea)))
                    {
                        if (PrismSubAreaWrapper.prismList[newSubArea.id])
                        {
                            prism = PrismSubAreaWrapper.prismList[newSubArea.id];
                            if (prism.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
                            {
                                KernelEventsManager.getInstance().processCallback(PrismHookList.KohState, prism);
                                if (Kernel.getWorker().contains(AllianceFrame))
                                {
                                    allianceFrame = (Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame);
                                    KernelEventsManager.getInstance().processCallback(AlignmentHookList.KohUpdate, allianceFrame.alliancesOnTheHill, allianceFrame.actualKohInfos.allianceMapWinners, allianceFrame.actualKohInfos.allianceMapWinnerScore, allianceFrame.actualKohInfos.allianceMapMyAllianceScore, allianceFrame.actualKohInfos.nextTickTime);
                                };
                            };
                        };
                    };
                    return (false);
                case (msg is CharacterCapabilitiesMessage):
                    ccmsg = (msg as CharacterCapabilitiesMessage);
                    this.guildEmblemSymbolCategories = ccmsg.guildEmblemSymbolCategories;
                    return (true);
                case (msg is ResetCharacterStatsRequestAction):
                    rcsra = (msg as ResetCharacterStatsRequestAction);
                    rcsrmsg = new ResetCharacterStatsRequestMessage();
                    rcsrmsg.initResetCharacterStatsRequestMessage();
                    ConnectionsHandler.getConnection().send(rcsrmsg);
                    return (true);
                case (msg is StatsUpgradeRequestAction):
                    sura = (msg as StatsUpgradeRequestAction);
                    surqmsg = new StatsUpgradeRequestMessage();
                    surqmsg.initStatsUpgradeRequestMessage(sura.useAdditionnal, sura.statId, sura.boostPoint);
                    ConnectionsHandler.getConnection().send(surqmsg);
                    return (true);
                case (msg is StatsUpgradeResultMessage):
                    surmsg = (msg as StatsUpgradeResultMessage);
                    switch (surmsg.result)
                    {
                        case StatsUpgradeResultEnum.SUCCESS:
                            KernelEventsManager.getInstance().processCallback(HookList.StatsUpgradeResult, surmsg.nbCharacBoost);
                            break;
                        case StatsUpgradeResultEnum.NONE:
                            statUpgradeErrorText = I18n.getUiText("ui.popup.statboostFailed.text");
                            break;
                        case StatsUpgradeResultEnum.GUEST:
                            statUpgradeErrorText = I18n.getUiText("ui.fight.guestAccount");
                            break;
                        case StatsUpgradeResultEnum.RESTRICTED:
                            statUpgradeErrorText = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                            break;
                        case StatsUpgradeResultEnum.IN_FIGHT:
                            statUpgradeErrorText = I18n.getUiText("ui.error.cantDoInFight");
                            break;
                        case StatsUpgradeResultEnum.NOT_ENOUGH_POINT:
                            statUpgradeErrorText = I18n.getUiText("ui.popup.statboostFailed.notEnoughPoint");
                            break;
                    };
                    if (statUpgradeErrorText)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, statUpgradeErrorText, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is CharacterLevelUpMessage):
                    clumsg = (msg as CharacterLevelUpMessage);
                    messageId = clumsg.getMessageId();
                    switch (messageId)
                    {
                        case CharacterLevelUpMessage.protocolId:
                            previousLevel = PlayedCharacterManager.getInstance().infos.level;
                            PlayedCharacterManager.getInstance().infos.level = clumsg.newLevel;
                            if (((clumsg.newLevel == 10) && (!(PlayerManager.getInstance().server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS))))
                            {
                                InventoryManagementFrame.displayNewsPopupClassic();
                            };
                            caracPointEarned = 0;
                            healPointEarned = 0;
                            caracPointEarned = ((clumsg.newLevel - previousLevel) * 5);
                            healPointEarned = ((clumsg.newLevel - previousLevel) * 5);
                            newSpellWrappers = new Array();
                            playerBreed = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                            for each (spellVariant in playerBreed.breedSpellVariants)
                            {
                                for each (spellBreed in spellVariant.spells)
                                {
                                    for each (spellLevelBreedId in spellBreed.spellLevels)
                                    {
                                        spellLevelBreed = SpellLevel.getLevelById(spellLevelBreedId);
                                        if (!spellLevelBreed)
                                        {
                                        }
                                        else
                                        {
                                            obtentionLevel = spellLevelBreed.minPlayerLevel;
                                            if (((obtentionLevel <= clumsg.newLevel) && (obtentionLevel > previousLevel)))
                                            {
                                                newSpellWrappers.push(SpellWrapper.create(spellBreed.id, spellLevelBreed.grade, false));
                                            };
                                        };
                                    };
                                };
                            };
                            for each (spellWrapper in PlayedCharacterManager.getInstance().spellsInventory)
                            {
                                spellWrapper.updateSpellLevelAndEffectsAccordingToPlayerLevel();
                            };
                            if (newSpellWrappers.length)
                            {
                                KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerNewSpell);
                            };
                            try
                            {
                                ssequencer = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
                                ssequencer.addStep(new AddGfxEntityStep(152, DofusEntities.getEntity(PlayedCharacterManager.getInstance().id).position.cellId));
                                ssequencer.start();
                            }
                            catch(e:Error)
                            {
                            };
                            SoundManager.getInstance().manager.playUISound(UISoundEnum.LEVEL_UP);
                            KernelEventsManager.getInstance().processCallback(HookList.CharacterLevelUp, previousLevel, clumsg.newLevel, caracPointEarned, healPointEarned, newSpellWrappers);
                            break;
                        case CharacterLevelUpInformationMessage.protocolId:
                            cluimsg = (msg as CharacterLevelUpInformationMessage);
                            onSameMap = false;
                            try
                            {
                                for each (entityId in this.roleplayContextFrame.entitiesFrame.getEntitiesIdsList())
                                {
                                    if (entityId == cluimsg.id)
                                    {
                                        onSameMap = true;
                                    };
                                };
                                if (onSameMap)
                                {
                                    ss = new SerialSequencer();
                                    ss.addStep(new AddGfxEntityStep(152, DofusEntities.getEntity(cluimsg.id).position.cellId));
                                    ss.start();
                                };
                            }
                            catch(e:Error)
                            {
                                _log.warn(("Un problème est survenu lors du traitement du message CharacterLevelUpInformationMessage. " + "Un personnage vient de changer de niveau mais on n'est surement pas encore sur la map"));
                            };
                            if (cluimsg.newLevel <= ProtocolConstantsEnum.MAX_LEVEL)
                            {
                                displayTextInfo = I18n.getUiText("ui.common.characterLevelUp", [(((("{player," + cluimsg.name) + ",") + cluimsg.id) + "}"), cluimsg.newLevel]);
                            }
                            else
                            {
                                displayTextInfo = I18n.getUiText("ui.common.characterOmegaUp", [(((("{player," + cluimsg.name) + ",") + cluimsg.id) + "}"), (cluimsg.newLevel - ProtocolConstantsEnum.MAX_LEVEL)]);
                            };
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, displayTextInfo, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                            break;
                    };
                    return (true);
                case (msg is CharacterExperienceGainMessage):
                    cegmsg = (msg as CharacterExperienceGainMessage);
                    if (cegmsg.experienceCharacter > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.mine", [StringUtils.formateIntToString(cegmsg.experienceCharacter)]), "n", (cegmsg.experienceCharacter == 1), (cegmsg.experienceCharacter == 0)), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    if (cegmsg.experienceIncarnation > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.incarnation", [StringUtils.formateIntToString(cegmsg.experienceIncarnation)]), "n", (cegmsg.experienceIncarnation == 1), (cegmsg.experienceIncarnation == 0)), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    if (cegmsg.experienceGuild > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.guild", [StringUtils.formateIntToString(cegmsg.experienceGuild)]), "n", (cegmsg.experienceGuild == 1), (cegmsg.experienceGuild == 0)), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    if (cegmsg.experienceMount > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, PatternDecoder.combine(I18n.getUiText("ui.stats.xpgain.mount", [StringUtils.formateIntToString(cegmsg.experienceMount)]), "n", (cegmsg.experienceMount == 1), (cegmsg.experienceMount == 0)), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is GameRolePlayPlayerLifeStatusMessage):
                    grplsmsg = (msg as GameRolePlayPlayerLifeStatusMessage);
                    PlayedCharacterManager.getInstance().state = grplsmsg.state;
                    KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayPlayerLifeStatus, grplsmsg.state, 0);
                    KernelEventsManager.getInstance().processCallback(HookList.PhoenixUpdate, grplsmsg.phenixMapId);
                    return (true);
                case (msg is GameRolePlayGameOverMessage):
                    grpgomsg = (msg as GameRolePlayGameOverMessage);
                    PlayedCharacterManager.getInstance().state = PlayerLifeStatusEnum.STATUS_TOMBSTONE;
                    KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayPlayerLifeStatus, 2, 1);
                    return (true);
                case (msg is AlmanachCalendarDateMessage):
                    acdmsg = (msg as AlmanachCalendarDateMessage);
                    AlmanaxManager.getInstance().calendar = AlmanaxCalendar.getAlmanaxCalendarById(acdmsg.date);
                    KernelEventsManager.getInstance().processCallback(HookList.CalendarDate, acdmsg.date);
                    return (true);
                case (msg is SetUpdateMessage):
                    sumsg = (msg as SetUpdateMessage);
                    this.setList[sumsg.setId] = new PlayerSetInfo(sumsg.setId, sumsg.setObjects, sumsg.setEffects);
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.SetUpdate, sumsg.setId);
                    return (true);
                case (msg is CompassResetMessage):
                    crmsg = (msg as CompassResetMessage);
                    name = ("flag_srv" + crmsg.type);
                    switch (crmsg.type)
                    {
                        case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                            socialFrame = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame);
                            socialFrame.spouse.followSpouse = false;
                            KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated, false);
                            break;
                        case CompassTypeEnum.COMPASS_TYPE_PARTY:
                            for each (followingPlayerId in PlayedCharacterManager.getInstance().followingPlayerIds)
                            {
                                KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, ((name + "_") + followingPlayerId), PlayedCharacterManager.getInstance().currentWorldMapId);
                            };
                            PlayedCharacterManager.getInstance().followingPlayerIds.length = 0;
                            return (true);
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, name, PlayedCharacterManager.getInstance().currentWorldMapId);
                    return (true);
                case (msg is CompassUpdatePartyMemberMessage):
                case (msg is CompassUpdatePvpSeekMessage):
                case (msg is CompassUpdateMessage):
                    cumsg = (msg as CompassUpdateMessage);
                    name = ("flag_srv" + cumsg.type);
                    switch (cumsg.type)
                    {
                        case CompassTypeEnum.COMPASS_TYPE_PARTY:
                            memberId = CompassUpdatePartyMemberMessage(msg).memberId;
                            active = CompassUpdatePartyMemberMessage(msg).active;
                            if (((memberId == 0) && (!(active))))
                            {
                                for each (followingPlayerId in PlayedCharacterManager.getInstance().followingPlayerIds)
                                {
                                    KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, ((name + "_") + followingPlayerId), PlayedCharacterManager.getInstance().currentWorldMapId);
                                };
                                PlayedCharacterManager.getInstance().followingPlayerIds.length = 0;
                            }
                            else
                            {
                                pmFrame = (Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame);
                                if (pmFrame)
                                {
                                    memberInfo = pmFrame.getGroupMemberById(memberId);
                                    if (memberInfo)
                                    {
                                        legend = (((((I18n.getUiText("ui.cartography.positionof", [memberInfo.name]) + " (") + cumsg.coords.worldX) + ",") + cumsg.coords.worldY) + ")");
                                    };
                                    name = (name + ("_" + memberId));
                                };
                                if (active)
                                {
                                    KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag, name, legend, PlayedCharacterManager.getInstance().currentWorldMapId, cumsg.coords.worldX, cumsg.coords.worldY, 39423, false);
                                }
                                else
                                {
                                    KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag, name, PlayedCharacterManager.getInstance().currentWorldMapId);
                                };
                            };
                            return (true);
                        case CompassTypeEnum.COMPASS_TYPE_PVP_SEEK:
                            legend = (((((I18n.getUiText("ui.cartography.positionof", [CompassUpdatePvpSeekMessage(msg).memberName]) + " (") + CompassUpdatePvpSeekMessage(msg).coords.worldX) + ",") + CompassUpdatePvpSeekMessage(msg).coords.worldY) + ")");
                            color = 0xFF0000;
                            break;
                        case CompassTypeEnum.COMPASS_TYPE_QUEST:
                            legend = ((cumsg.coords.worldX + ",") + cumsg.coords.worldY);
                            color = 0x558800;
                            break;
                        case CompassTypeEnum.COMPASS_TYPE_SIMPLE:
                            legend = ((cumsg.coords.worldX + ",") + cumsg.coords.worldY);
                            color = 0xFFEE00;
                            break;
                        case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                            color = 16724889;
                            socialFrame2 = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame);
                            socialFrame2.spouse.followSpouse = true;
                            legend = (((((I18n.getUiText("ui.cartography.positionof", [socialFrame2.spouse.name]) + " (") + cumsg.coords.worldX) + ",") + cumsg.coords.worldY) + ")");
                            KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated, true);
                            break;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag, name, legend, PlayedCharacterManager.getInstance().currentWorldMapId, cumsg.coords.worldX, cumsg.coords.worldY, color, false);
                    return (true);
                case (msg is BasicTimeMessage):
                    btmsg = (msg as BasicTimeMessage);
                    date = new Date();
                    receptionDelay = (getTimer() - btmsg.receptionTime);
                    TimeManager.getInstance().serverTimeLag = (((btmsg.timestamp + ((btmsg.timezoneOffset * 60) * 1000)) - date.getTime()) + receptionDelay);
                    TimeManager.getInstance().serverUtcTimeLag = ((btmsg.timestamp - date.getTime()) + receptionDelay);
                    return (true);
                case (msg is StartupActionsListMessage):
                    salm = (msg as StartupActionsListMessage);
                    giftList = new Array();
                    for each (gift in salm.actions)
                    {
                        _items = new Array();
                        for each (item in gift.items)
                        {
                            iw = ItemWrapper.create(0, 0, item.objectGID, item.quantity, item.effects, false);
                            _items.push(iw);
                        };
                        obj = {
                            "uid":gift.uid,
                            "title":gift.title,
                            "text":gift.text,
                            "items":_items
                        };
                        giftList.push(obj);
                    };
                    PlayedCharacterManager.getInstance().waitingGifts = giftList;
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.GiftsWaitingAllocation, (giftList.length > 0));
                    if (giftList.length > 0)
                    {
                        mod = UiModuleManager.getInstance().getModule("Ankama_Web");
                        if (mod)
                        {
                            dst = new DataStoreType(("Module_" + mod.id), true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_CHARACTER);
                            StoreDataManager.getInstance().setData(dst, "giftNotification", true);
                            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.CodesAndGiftNotificationValue, true);
                        };
                    };
                    return (true);
                case (msg is StartupActionAddMessage):
                    saam = (msg as StartupActionAddMessage);
                    items = new Array();
                    for each (itema in saam.newAction.items)
                    {
                        iw = ItemWrapper.create(0, 0, itema.objectGID, itema.quantity, itema.effects, false);
                        items.push(iw);
                    };
                    obj = {
                        "uid":saam.newAction.uid,
                        "title":saam.newAction.title,
                        "text":saam.newAction.text,
                        "items":items
                    };
                    PlayedCharacterManager.getInstance().waitingGifts.push(obj);
                    module = UiModuleManager.getInstance().getModule("Ankama_Web");
                    if (module)
                    {
                        dataStoreType = new DataStoreType(("Module_" + module.id), true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_CHARACTER);
                        StoreDataManager.getInstance().setData(dataStoreType, "giftNotification", true);
                    };
                    KernelEventsManager.getInstance().processCallback(RoleplayHookList.GiftsWaitingAllocation, true);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.gift.newGiftInGame"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is GiftAssignRequestAction):
                    gar = (msg as GiftAssignRequestAction);
                    sao = new StartupActionsObjetAttributionMessage();
                    sao.initStartupActionsObjetAttributionMessage(gar.giftId, gar.characterId);
                    ConnectionsHandler.getConnection().send(sao);
                    return (true);
                case (msg is GiftAssignAllRequestAction):
                    gaara = (msg as GiftAssignAllRequestAction);
                    saaamsg = new StartupActionsAllAttributionMessage();
                    saaamsg.initStartupActionsAllAttributionMessage(gaara.characterId);
                    ConnectionsHandler.getConnection().send(saaamsg);
                    return (true);
                case (msg is StartupActionFinishedMessage):
                    safm = (msg as StartupActionFinishedMessage);
                    indexToDelete = -1;
                    for each (giftAction in PlayedCharacterManager.getInstance().waitingGifts)
                    {
                        if (giftAction.uid == safm.actionId)
                        {
                            indexToDelete = PlayedCharacterManager.getInstance().waitingGifts.indexOf(giftAction);
                            break;
                        };
                    };
                    if (indexToDelete > -1)
                    {
                        PlayedCharacterManager.getInstance().waitingGifts.splice(indexToDelete, 1);
                        KernelEventsManager.getInstance().processCallback(HookList.GiftAssigned, safm.actionId);
                        KernelEventsManager.getInstance().processCallback(ExternalGameHookList.CodesAndGiftGiftAssigned, giftAction.items);
                        if (PlayedCharacterManager.getInstance().waitingGifts.length == 0)
                        {
                            KernelEventsManager.getInstance().processCallback(RoleplayHookList.GiftsWaitingAllocation, false);
                        };
                    };
                    return (true);
                case (msg is ExchangeMoneyMovementInformationMessage):
                    emmim = (msg as ExchangeMoneyMovementInformationMessage);
                    this._kamasLimit = emmim.limit;
                    return (true);
                case (msg is DebtsUpdateMessage):
                    dum = (msg as DebtsUpdateMessage);
                    DebtManager.getInstance().updateDebts(dum.debts);
                    return (true);
                case (msg is DebtsDeleteMessage):
                    ddm = (msg as DebtsDeleteMessage);
                    DebtManager.getInstance().removeDebts(ddm.debts);
                    break;
                case (msg is ForgettableSpellListUpdateMessage):
                    fslumsg = (msg as ForgettableSpellListUpdateMessage);
                    if (fslumsg.action === ForgettableSpellListActionEnum.FORGETTABLE_SPELL_LIST_DISPATCH)
                    {
                        newSpellList = new Dictionary();
                        for each (forgettableSpell in fslumsg.spells)
                        {
                            newSpellList[forgettableSpell.spellId] = forgettableSpell;
                        };
                        PlayedCharacterManager.getInstance().playerTemporisSpellDictionary = newSpellList;
                    }
                    else
                    {
                        ds = new DataStoreType("AccountModule_", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
                        if (!StoreDataManager.getInstance().getData(ds, FORGETTABLE_SPELL_FIRST_NOTIF_NAME))
                        {
                            StoreDataManager.getInstance().setData(ds, FORGETTABLE_SPELL_FIRST_NOTIF_NAME, true);
                            nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.temporis.popupFirstSpellAddedTitle"), I18n.getUiText("ui.temporis.popupFirstSpellAddedContent"), NotificationTypeEnum.TUTORIAL, "FirstForgettableSpellNotif");
                            NotificationManager.getInstance().addButtonToNotification(nid, I18n.getUiText("ui.temporis.popupFirstSpellAddedButton"), "OpenTemporisSpellsUi");
                            NotificationManager.getInstance().sendNotification(nid);
                        };
                        playerTemporisSpellsDict = PlayedCharacterManager.getInstance().playerTemporisSpellDictionary;
                        for each (forgettableSpell in fslumsg.spells)
                        {
                            playerTemporisSpellsDict[forgettableSpell.spellId] = forgettableSpell;
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.ForgettableSpellListUpdate);
                    StorageOptionManager.getInstance().updateStorageView();
                    InventoryManager.getInstance().inventory.releaseHooks();
                    return (true);
                case (msg is ForgettableSpellDeleteMessage):
                    fsdmsg = (msg as ForgettableSpellDeleteMessage);
                    playerTemporisSpellsDict = PlayedCharacterManager.getInstance().playerTemporisSpellDictionary;
                    for each (forgettableSpellId in fsdmsg.spells)
                    {
                        delete playerTemporisSpellsDict[forgettableSpellId];
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.ForgettableSpellDelete);
                    StorageOptionManager.getInstance().updateStorageView();
                    InventoryManager.getInstance().inventory.releaseHooks();
                    return (true);
                case (msg is ForgettableSpellEquipmentSlotsMessage):
                    fsesmsg = (msg as ForgettableSpellEquipmentSlotsMessage);
                    PlayedCharacterManager.getInstance().playerMaxTemporisSpellsNumber = fsesmsg.quantity;
                    KernelEventsManager.getInstance().processCallback(HookList.ForgettableSpellEquipmentSlots);
                    return (true);
            };
            return (false);
        }

        public function updateCharacterStatsList(stats:CharacterCharacteristicsInformations):void
        {
            var iSM:int;
            var spellIdToRefresh:int;
            var swToUpdate:SpellWrapper;
            var lastCharacteristics:CharacterCharacteristicsInformations = PlayedCharacterManager.getInstance().characteristics;
            if (((lastCharacteristics) && (lastCharacteristics.energyPoints > stats.energyPoints)))
            {
                KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerIsDead);
            };
            if (stats.kamas != InventoryManager.getInstance().inventory.kamas)
            {
                InventoryManager.getInstance().inventory.kamas = stats.kamas;
            };
            var oldSM:Vector.<CharacterSpellModification> = ((lastCharacteristics) ? (PlayedCharacterManager.getInstance().characteristics.spellModifications) : null);
            var newSM:Vector.<CharacterSpellModification> = stats.spellModifications;
            var lengthSM:int = ((oldSM) ? Math.max(oldSM.length, newSM.length) : newSM.length);
            var idSpellsToRefresh:Array = new Array();
            if (oldSM)
            {
                iSM = 0;
                while (iSM < lengthSM)
                {
                    if (oldSM.length <= iSM)
                    {
                        if (idSpellsToRefresh.indexOf(newSM[iSM].spellId) == -1)
                        {
                            idSpellsToRefresh.push(newSM[iSM].spellId);
                        };
                    }
                    else
                    {
                        if (newSM.length <= iSM)
                        {
                            if (idSpellsToRefresh.indexOf(oldSM[iSM].spellId) == -1)
                            {
                                idSpellsToRefresh.push(oldSM[iSM].spellId);
                            };
                        }
                        else
                        {
                            if (oldSM[iSM] != newSM[iSM])
                            {
                                if (idSpellsToRefresh.indexOf(newSM[iSM].spellId) == -1)
                                {
                                    idSpellsToRefresh.push(newSM[iSM].spellId);
                                };
                                if (idSpellsToRefresh.indexOf(oldSM[iSM].spellId) == -1)
                                {
                                    idSpellsToRefresh.push(oldSM[iSM].spellId);
                                };
                            };
                        };
                    };
                    iSM++;
                };
            }
            else
            {
                iSM = 0;
                while (iSM < lengthSM)
                {
                    idSpellsToRefresh.push(newSM[iSM].spellId);
                    iSM++;
                };
            };
            PlayedCharacterManager.getInstance().characteristics = stats;
            for each (spellIdToRefresh in idSpellsToRefresh)
            {
                swToUpdate = SpellWrapper.getSpellWrapperById(spellIdToRefresh, PlayedCharacterManager.getInstance().id);
                if (swToUpdate)
                {
                    swToUpdate = swToUpdate.clone();
                    swToUpdate.versionNum++;
                };
            };
            if (PlayedCharacterManager.getInstance().isFighting)
            {
                if (CurrentPlayedFighterManager.getInstance().isRealPlayer())
                {
                    KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
                };
                SpellWrapper.refreshAllPlayerSpellHolder(PlayedCharacterManager.getInstance().id);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
            };
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function getPlayerSet(objectGID:uint):PlayerSetInfo
        {
            var playerSetInfo:PlayerSetInfo;
            var itemList:Vector.<uint>;
            var nbItem:int;
            var k:int;
            var nbSet:int = this.setList.length;
            var i:int;
            while (i < nbSet)
            {
                playerSetInfo = this.setList[i];
                if (playerSetInfo)
                {
                    itemList = playerSetInfo.setObjects;
                    nbItem = itemList.length;
                    k = 0;
                    while (k < nbItem)
                    {
                        if (itemList[k] == objectGID)
                        {
                            return (playerSetInfo);
                        };
                        k++;
                    };
                };
                i++;
            };
            return (null);
        }


    }
}

