package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOkMultiCraftMessage;
    import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.CraftHookList;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkCraftWithInformationMessage;
    import com.ankamagames.dofus.datacenter.jobs.Skill;
    import com.ankamagames.dofus.misc.lists.ExchangeHookList;
    import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangePlayerMultiCraftRequestAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangePlayerMultiCraftRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayStopAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeReplayStopMessage;
    import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeSetCraftRecipeAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeSetCraftRecipeMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemAutoCraftStopedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkCraftMessage;
    import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeCraftPaymentModificationAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftPaymentModificationRequestMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftPaymentModifiedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectModifiedInBagMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectPutInBagMessage;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectRemovedFromBagMessage;
    import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeObjectUseInWorkshopAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectUseInWorkshopMessage;
    import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeMultiCraftCrafterCanUseHisRessourcesMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMulticraftCrafterMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMulticraftCustomerMessage;
    import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftCountRequestMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftCountModifiedMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultWithObjectIdMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultMagicWithObjectDescMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultWithObjectDescMessage;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDice;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
    import com.ankamagames.dofus.datacenter.effects.Effect;
    import com.ankama.dofus.enums.ActionIds;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectMinMax;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkItemManager;
    import com.ankamagames.dofus.network.enums.ExchangeReplayStopReasonEnum;
    import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;

    public class CraftFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CraftFrame));

        public var playerList:PlayerExchangeCraftList = new PlayerExchangeCraftList();
        public var otherPlayerList:PlayerExchangeCraftList = new PlayerExchangeCraftList();
        public var paymentCraftList:PaymentCraftList = new PaymentCraftList();
        private var _crafterInfos:PlayerInfo = new PlayerInfo();
        private var _customerInfos:PlayerInfo = new PlayerInfo();
        public var bagList:Array = new Array();
        private var _isCrafter:Boolean;
        private var _recipes:Array;
        private var _skillId:int;
        private var _craftType:int;
        private var _smithMagicOldObject:ItemWrapper;
        private var _success:Boolean;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        private function get socialFrame():SocialFrame
        {
            return (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame);
        }

        public function get crafterInfos():PlayerInfo
        {
            return (this._crafterInfos);
        }

        public function get customerInfos():PlayerInfo
        {
            return (this._customerInfos);
        }

        public function get skillId():int
        {
            return (this._skillId);
        }

        private function get roleplayContextFrame():RoleplayContextFrame
        {
            return (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
        }

        private function get commonExchangeFrame():CommonExchangeManagementFrame
        {
            return (Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame);
        }

        public function processExchangeOkMultiCraftMessage(msg:ExchangeOkMultiCraftMessage):void
        {
            PlayedCharacterManager.getInstance().isInExchange = true;
            var eomcmsg:ExchangeOkMultiCraftMessage = (msg as ExchangeOkMultiCraftMessage);
            if (eomcmsg.role == ExchangeTypeEnum.MULTICRAFT_CRAFTER)
            {
                this.playerList.isCrafter = true;
                this.otherPlayerList.isCrafter = false;
                this._crafterInfos.id = PlayedCharacterManager.getInstance().id;
                if (this.crafterInfos.id == eomcmsg.initiatorId)
                {
                    this._customerInfos.id = eomcmsg.otherId;
                }
                else
                {
                    this._customerInfos.id = eomcmsg.initiatorId;
                };
            }
            else
            {
                this.playerList.isCrafter = false;
                this.otherPlayerList.isCrafter = true;
                this._customerInfos.id = PlayedCharacterManager.getInstance().id;
                if (this.customerInfos.id == eomcmsg.initiatorId)
                {
                    this._crafterInfos.id = eomcmsg.otherId;
                }
                else
                {
                    this._crafterInfos.id = eomcmsg.initiatorId;
                };
            };
            var crafterEntity:GameContextActorInformations = this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.crafterInfos.id);
            if (crafterEntity)
            {
                this._crafterInfos.look = EntityLookAdapter.getRiderLook(crafterEntity.look);
                this._crafterInfos.name = (crafterEntity as GameRolePlayNamedActorInformations).name;
            }
            else
            {
                this._crafterInfos.look = null;
                this._crafterInfos.name = "";
            };
            var customerEntity:GameContextActorInformations = this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.customerInfos.id);
            if (customerEntity)
            {
                this._customerInfos.look = EntityLookAdapter.getRiderLook(customerEntity.look);
                this._customerInfos.name = (customerEntity as GameRolePlayNamedActorInformations).name;
            }
            else
            {
                this._customerInfos.look = null;
                this._customerInfos.name = "";
            };
            var otherName:String = "";
            var askerId:Number = eomcmsg.initiatorId;
            if (eomcmsg.initiatorId == PlayedCharacterManager.getInstance().id)
            {
                if (eomcmsg.initiatorId == this.crafterInfos.id)
                {
                    this._isCrafter = true;
                    otherName = this.customerInfos.name;
                }
                else
                {
                    this._isCrafter = false;
                    otherName = this.crafterInfos.name;
                };
            }
            else
            {
                if (eomcmsg.otherId == this.crafterInfos.id)
                {
                    this._isCrafter = false;
                    otherName = this.crafterInfos.name;
                    if (!Kernel.getWorker().contains(ExchangeManagementFrame))
                    {
                        Kernel.getWorker().addFrame(new ExchangeManagementFrame());
                    };
                }
                else
                {
                    this._isCrafter = true;
                    otherName = this.customerInfos.name;
                };
            };
            if (!this.socialFrame.isIgnored(otherName))
            {
                KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeMultiCraftRequest, eomcmsg.role, otherName, askerId);
            };
        }

        public function processExchangeStartOkCraftWithInformationMessage(msg:ExchangeStartOkCraftWithInformationMessage):void
        {
            var esocwimsg:ExchangeStartOkCraftWithInformationMessage = (msg as ExchangeStartOkCraftWithInformationMessage);
            PlayedCharacterManager.getInstance().isInExchange = true;
            this._skillId = esocwimsg.skillId;
            var skill:Skill = Skill.getSkillById(this._skillId);
            this._isCrafter = true;
            if (skill.isForgemagus)
            {
                this._craftType = 1;
            }
            else
            {
                this._craftType = 0;
            };
            KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkCraft, esocwimsg.skillId);
        }

        public function pushed():Boolean
        {
            this._success = false;
            return (true);
        }

        public function pulled():Boolean
        {
            if (Kernel.getWorker().contains(CommonExchangeManagementFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
            };
            if (Kernel.getWorker().contains(ExchangeManagementFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(ExchangeManagementFrame));
            };
            KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave, this._success);
            this.playerList = new PlayerExchangeCraftList();
            this.otherPlayerList = new PlayerExchangeCraftList();
            this.bagList = new Array();
            this._crafterInfos = new PlayerInfo();
            this._customerInfos = new PlayerInfo();
            this._smithMagicOldObject = null;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var epmcra:ExchangePlayerMultiCraftRequestAction;
            var epmcrmsg:ExchangePlayerMultiCraftRequestMessage;
            var ersa:ExchangeReplayStopAction;
            var rsmsg:ExchangeReplayStopMessage;
            var escra:ExchangeSetCraftRecipeAction;
            var escrmsg:ExchangeSetCraftRecipeMessage;
            var ecrmsg:ExchangeCraftResultMessage;
            var messageId:uint;
            var objectName:String;
            var craftResultMessage:String;
            var itemW:ItemWrapper;
            var success:Boolean;
            var eiacsmsg:ExchangeItemAutoCraftStopedMessage;
            var autoCraftStopedMessage:String;
            var showPopup:Boolean;
            var esocmsg:ExchangeStartOkCraftMessage;
            var msgId:uint;
            var acpma:ExchangeCraftPaymentModificationAction;
            var ecpmrmsg:ExchangeCraftPaymentModificationRequestMessage;
            var ecpmmsg:ExchangeCraftPaymentModifiedMessage;
            var eomiwmsg:ExchangeObjectModifiedInBagMessage;
            var bagItemM:ItemWrapper;
            var eopiwmsg:ExchangeObjectPutInBagMessage;
            var obj:ObjectItem;
            var bagItemA:ItemWrapper;
            var eorfwmsg:ExchangeObjectRemovedFromBagMessage;
            var eosiwa:ExchangeObjectUseInWorkshopAction;
            var eouiwmsg:ExchangeObjectUseInWorkshopMessage;
            var emcsccuhra:ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
            var emcsccuhrmsg:ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage;
            var emcccuhrmsg:ExchangeMultiCraftCrafterCanUseHisRessourcesMessage;
            var esomcmsg:ExchangeStartOkMulticraftCrafterMessage;
            var skill:Skill;
            var esomcustomermsg:ExchangeStartOkMulticraftCustomerMessage;
            var skill2:Skill;
            var era:ExchangeReplayAction;
            var ermsg:ExchangeCraftCountRequestMessage;
            var ercmmsg:ExchangeCraftCountModifiedMessage;
            var elm:ExchangeLeaveMessage;
            var ecrwoimsg:ExchangeCraftResultWithObjectIdMessage;
            var ecrmwodmsg:ExchangeCraftResultMagicWithObjectDescMessage;
            var smithText:String;
            var successS:Boolean;
            var deltas:Array;
            var newEffects:Vector.<ObjectEffect>;
            var effect:EffectInstance;
            var sameEffectsCount:Array;
            var residualMagicText:String;
            var finalText:String;
            var shortenedText:String;
            var ecrwodmsg:ExchangeCraftResultWithObjectDescMessage;
            var quantity:int;
            var oldEffect:ObjectEffect;
            var sameEffectExists:Boolean;
            var newEffect:ObjectEffect;
            var oldValue:int;
            var newValue:int;
            var result:int;
            var effectInteger:EffectInstanceInteger;
            var effectDice:EffectInstanceDice;
            var newEffect2:ObjectEffect;
            var reallyNew:Boolean;
            var oldEffect2:ObjectEffect;
            var effectMinMax:EffectInstanceMinMax;
            var commonMod:Object;
            switch (true)
            {
                case (msg is ExchangePlayerMultiCraftRequestAction):
                    epmcra = (msg as ExchangePlayerMultiCraftRequestAction);
                    epmcrmsg = new ExchangePlayerMultiCraftRequestMessage();
                    epmcrmsg.initExchangePlayerMultiCraftRequestMessage(epmcra.exchangeType, epmcra.target, epmcra.skillId);
                    ConnectionsHandler.getConnection().send(epmcrmsg);
                    return (true);
                case (msg is ExchangeOkMultiCraftMessage):
                    this.processExchangeOkMultiCraftMessage((msg as ExchangeOkMultiCraftMessage));
                    return (true);
                case (msg is ExchangeReplayStopAction):
                    ersa = (msg as ExchangeReplayStopAction);
                    rsmsg = new ExchangeReplayStopMessage();
                    rsmsg.initExchangeReplayStopMessage();
                    ConnectionsHandler.getConnection().send(rsmsg);
                    return (true);
                case (msg is ExchangeSetCraftRecipeAction):
                    escra = (msg as ExchangeSetCraftRecipeAction);
                    escrmsg = new ExchangeSetCraftRecipeMessage();
                    escrmsg.initExchangeSetCraftRecipeMessage(escra.recipeId);
                    ConnectionsHandler.getConnection().send(escrmsg);
                    return (true);
                case (msg is ExchangeCraftResultMessage):
                    ecrmsg = (msg as ExchangeCraftResultMessage);
                    messageId = ecrmsg.getMessageId();
                    itemW = null;
                    success = false;
                    switch (messageId)
                    {
                        case ExchangeCraftResultMessage.protocolId:
                            craftResultMessage = I18n.getUiText("ui.craft.noResult");
                            break;
                        case ExchangeCraftResultWithObjectIdMessage.protocolId:
                            ecrwoimsg = (msg as ExchangeCraftResultWithObjectIdMessage);
                            itemW = ItemWrapper.create(63, 0, ecrwoimsg.objectGenericId, 1, null, false);
                            objectName = Item.getItemById(ecrwoimsg.objectGenericId).name;
                            craftResultMessage = I18n.getUiText("ui.craft.failed");
                            success = (ecrwoimsg.craftResult == 2);
                            break;
                        case ExchangeCraftResultMagicWithObjectDescMessage.protocolId:
                            ecrmwodmsg = (msg as ExchangeCraftResultMagicWithObjectDescMessage);
                            smithText = "";
                            successS = false;
                            deltas = new Array();
                            newEffects = ecrmwodmsg.objectInfo.effects;
                            sameEffectsCount = new Array();
                            if (this._smithMagicOldObject)
                            {
                                for each (oldEffect in this._smithMagicOldObject.effectsList)
                                {
                                    sameEffectsCount.push(oldEffect);
                                    if (((oldEffect is ObjectEffectInteger) || (oldEffect is ObjectEffectDice)))
                                    {
                                        sameEffectExists = false;
                                        for each (newEffect in newEffects)
                                        {
                                            if ((((newEffect is ObjectEffectInteger) || (newEffect is ObjectEffectDice)) && (newEffect.actionId == oldEffect.actionId)))
                                            {
                                                sameEffectExists = true;
                                                oldValue = Effect.getEffectById(oldEffect.actionId).bonusType;
                                                newValue = Effect.getEffectById(newEffect.actionId).bonusType;
                                                if (((newEffect is ObjectEffectInteger) && (oldEffect is ObjectEffectInteger)))
                                                {
                                                    oldValue = (oldValue * ObjectEffectInteger(oldEffect).value);
                                                    newValue = (newValue * ObjectEffectInteger(newEffect).value);
                                                    if (newValue != oldValue)
                                                    {
                                                        result = (newValue - oldValue);
                                                        effectInteger = new EffectInstanceInteger();
                                                        effectInteger.effectId = newEffect.actionId;
                                                        if (result > 0)
                                                        {
                                                            successS = true;
                                                        };
                                                        effectInteger.value = (ObjectEffectInteger(newEffect).value - ObjectEffectInteger(oldEffect).value);
                                                        smithText = (smithText + (effectInteger.description + ", "));
                                                        smithText = smithText.replace("+-", "-");
                                                        smithText = smithText.replace("--", "+");
                                                        deltas.push({
                                                            "id":effectInteger.effectId,
                                                            "value":result
                                                        });
                                                        effect = effectInteger;
                                                    };
                                                }
                                                else
                                                {
                                                    if (((newEffect is ObjectEffectDice) && (oldEffect is ObjectEffectDice)))
                                                    {
                                                        oldValue = ObjectEffectDice(oldEffect).diceNum;
                                                        newValue = ObjectEffectDice(newEffect).diceNum;
                                                        if (newValue != oldValue)
                                                        {
                                                            result = (newValue - oldValue);
                                                            if (oldEffect.actionId == ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
                                                            {
                                                                smithText = (smithText + (("+" + result) + ", "));
                                                                deltas.push({
                                                                    "id":oldEffect.actionId,
                                                                    "value":result
                                                                });
                                                                result = newValue;
                                                            };
                                                            effectDice = new EffectInstanceDice();
                                                            effectDice.effectId = newEffect.actionId;
                                                            if (result > 0)
                                                            {
                                                                successS = true;
                                                            };
                                                            effectDice.diceNum = result;
                                                            effectDice.diceSide = result;
                                                            effectDice.value = ObjectEffectDice(newEffect).diceConst;
                                                            effect = effectDice;
                                                            smithText = (smithText + (effect.description + ", "));
                                                            smithText = smithText.replace("+-", "-");
                                                            smithText = smithText.replace("--", "+");
                                                            deltas.push({
                                                                "id":effectDice.effectId,
                                                                "value":result
                                                            });
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                        if (((!(sameEffectExists)) && (oldEffect is ObjectEffectInteger)))
                                        {
                                            effectInteger = new EffectInstanceInteger();
                                            effectInteger.effectId = oldEffect.actionId;
                                            effectInteger.value = -(ObjectEffectInteger(oldEffect).value);
                                            smithText = (smithText + (effectInteger.description + ", "));
                                            smithText = smithText.replace("+-", "-");
                                            smithText = smithText.replace("--", "+");
                                            deltas.push({
                                                "id":effectInteger.effectId,
                                                "value":effectInteger.value
                                            });
                                            effect = effectInteger;
                                            if (effect.description.substr(0, 2) == "--")
                                            {
                                                successS = true;
                                            };
                                        };
                                    };
                                };
                            };
                            for each (newEffect2 in newEffects)
                            {
                                reallyNew = true;
                                for each (oldEffect2 in sameEffectsCount)
                                {
                                    if (((newEffect2 is ObjectEffectInteger) || (newEffect2 is ObjectEffectMinMax)))
                                    {
                                        if (newEffect2.actionId == oldEffect2.actionId)
                                        {
                                            reallyNew = false;
                                            sameEffectsCount.splice(sameEffectsCount.indexOf(oldEffect2), 1);
                                            break;
                                        };
                                    }
                                    else
                                    {
                                        reallyNew = false;
                                    };
                                };
                                if (reallyNew)
                                {
                                    if ((newEffect2 is ObjectEffectMinMax))
                                    {
                                        effectMinMax = new EffectInstanceMinMax();
                                        effectMinMax.effectId = newEffect2.actionId;
                                        effectMinMax.min = ObjectEffectMinMax(newEffect2).min;
                                        effectMinMax.max = ObjectEffectMinMax(newEffect2).max;
                                        effect = effectMinMax;
                                        successS = true;
                                    }
                                    else
                                    {
                                        if ((newEffect2 is ObjectEffectInteger))
                                        {
                                            effectInteger = new EffectInstanceInteger();
                                            effectInteger.effectId = newEffect2.actionId;
                                            effectInteger.value = ObjectEffectInteger(newEffect2).value;
                                            if (((effectInteger.value > 0) && (!(effectInteger.description.charAt(0) == "-"))))
                                            {
                                                successS = true;
                                            };
                                            smithText = (smithText + (effectInteger.description + ", "));
                                            deltas.push({
                                                "id":effectInteger.effectId,
                                                "value":effectInteger.value
                                            });
                                            effect = effectInteger;
                                        };
                                    };
                                };
                            };
                            residualMagicText = "";
                            if (ecrmwodmsg.magicPoolStatus == 2)
                            {
                                residualMagicText = ("+" + I18n.getUiText("ui.craft.smithResidualMagic"));
                            }
                            else
                            {
                                if (ecrmwodmsg.magicPoolStatus == 3)
                                {
                                    residualMagicText = ("-" + I18n.getUiText("ui.craft.smithResidualMagic"));
                                };
                            };
                            finalText = "";
                            shortenedText = "";
                            if (successS)
                            {
                                finalText = (finalText + I18n.getUiText("ui.craft.success"));
                            }
                            else
                            {
                                finalText = (finalText + I18n.getUiText("ui.craft.failure"));
                            };
                            if (((!(smithText == "")) || (!(residualMagicText == ""))))
                            {
                                shortenedText = smithText;
                                if (residualMagicText != "")
                                {
                                    shortenedText = (shortenedText + residualMagicText);
                                }
                                else
                                {
                                    shortenedText = shortenedText.substring(0, (shortenedText.length - 2));
                                };
                                finalText = (finalText + (I18n.getUiText("ui.common.colon") + shortenedText));
                            }
                            else
                            {
                                shortenedText = finalText;
                            };
                            KernelEventsManager.getInstance().processCallback(CraftHookList.ItemMagedResult, successS, shortenedText, deltas);
                            itemW = ItemWrapper.create(63, ecrmwodmsg.objectInfo.objectUID, ecrmwodmsg.objectInfo.objectGID, 1, ecrmwodmsg.objectInfo.effects, false);
                            this._smithMagicOldObject = itemW.clone();
                            success = (ecrmwodmsg.craftResult == 2);
                            break;
                        case ExchangeCraftResultWithObjectDescMessage.protocolId:
                            ecrwodmsg = (msg as ExchangeCraftResultWithObjectDescMessage);
                            if (ecrwodmsg.objectInfo.objectGID == 0)
                            {
                                break;
                            };
                            itemW = ItemWrapper.create(63, ecrwodmsg.objectInfo.objectUID, ecrwodmsg.objectInfo.objectGID, 1, ecrwodmsg.objectInfo.effects, false);
                            objectName = HyperlinkItemManager.newChatItem(itemW);
                            quantity = ecrwodmsg.objectInfo.quantity;
                            switch (true)
                            {
                                case (this._crafterInfos.id == PlayedCharacterManager.getInstance().id):
                                    craftResultMessage = I18n.getUiText("ui.craft.successTarget", [quantity, objectName, this._customerInfos.name]);
                                    break;
                                case (this._customerInfos.id == PlayedCharacterManager.getInstance().id):
                                    craftResultMessage = I18n.getUiText("ui.craft.successOther", [this._crafterInfos.name, quantity, objectName]);
                                    break;
                                default:
                                    craftResultMessage = I18n.getUiText("ui.craft.successSelf", [quantity, objectName]);
                            };
                            success = (ecrwodmsg.craftResult == 2);
                            KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeItemAutoCraftStoped, ExchangeReplayStopReasonEnum.STOPPED_REASON_OK);
                            break;
                    };
                    if (success)
                    {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CRAFT_OK);
                    }
                    else
                    {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CRAFT_KO);
                    };
                    if (((craftResultMessage) && (!(craftResultMessage == ""))))
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, craftResultMessage, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeCraftResult, ecrmsg.craftResult, itemW);
                    return (true);
                case (msg is ExchangeItemAutoCraftStopedMessage):
                    eiacsmsg = (msg as ExchangeItemAutoCraftStopedMessage);
                    autoCraftStopedMessage = "";
                    showPopup = true;
                    switch (eiacsmsg.reason)
                    {
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_IMPOSSIBLE_MODIFICATION:
                            autoCraftStopedMessage = I18n.getUiText("ui.craft.autoCraftStopedInvalidRecipe");
                            break;
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_MISSING_RESSOURCE:
                            autoCraftStopedMessage = I18n.getUiText("ui.craft.autoCraftStopedNoRessource");
                            break;
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_OK:
                            break;
                        case ExchangeReplayStopReasonEnum.STOPPED_REASON_USER:
                            autoCraftStopedMessage = I18n.getUiText("ui.craft.autoCraftStoped");
                            showPopup = false;
                            break;
                    };
                    if (((showPopup) && (!(autoCraftStopedMessage == ""))))
                    {
                        commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                        commonMod.openPopup(I18n.getUiText("ui.popup.information"), autoCraftStopedMessage, [I18n.getUiText("ui.common.ok")]);
                    };
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, autoCraftStopedMessage, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeItemAutoCraftStoped, eiacsmsg.reason);
                    return (true);
                case (msg is ExchangeStartOkCraftMessage):
                    esocmsg = (msg as ExchangeStartOkCraftMessage);
                    PlayedCharacterManager.getInstance().isInExchange = true;
                    msgId = esocmsg.getMessageId();
                    switch (msgId)
                    {
                        case ExchangeStartOkCraftMessage.protocolId:
                            KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkCraft);
                            break;
                        case ExchangeStartOkCraftWithInformationMessage.protocolId:
                            this.processExchangeStartOkCraftWithInformationMessage((msg as ExchangeStartOkCraftWithInformationMessage));
                            break;
                    };
                    return (true);
                case (msg is ExchangeCraftPaymentModificationAction):
                    acpma = (msg as ExchangeCraftPaymentModificationAction);
                    ecpmrmsg = new ExchangeCraftPaymentModificationRequestMessage();
                    ecpmrmsg.initExchangeCraftPaymentModificationRequestMessage(acpma.kamas);
                    ConnectionsHandler.getConnection().send(ecpmrmsg);
                    return (true);
                case (msg is ExchangeCraftPaymentModifiedMessage):
                    ecpmmsg = (msg as ExchangeCraftPaymentModifiedMessage);
                    if (this.commonExchangeFrame)
                    {
                        this.commonExchangeFrame.incrementEchangeSequence();
                    };
                    this.paymentCraftList.kamaPayment = ecpmmsg.goldSum;
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
                    return (true);
                case (msg is ExchangeObjectModifiedInBagMessage):
                    eomiwmsg = (msg as ExchangeObjectModifiedInBagMessage);
                    bagItemM = ItemWrapper.create(63, eomiwmsg.object.objectUID, eomiwmsg.object.objectGID, eomiwmsg.object.quantity, eomiwmsg.object.effects, false);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.BagItemModified, bagItemM, eomiwmsg.remote);
                    return (true);
                case (msg is ExchangeObjectPutInBagMessage):
                    eopiwmsg = (msg as ExchangeObjectPutInBagMessage);
                    obj = eopiwmsg.object;
                    bagItemA = ItemWrapper.create(63, obj.objectUID, obj.objectGID, obj.quantity, obj.effects, false);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.BagItemAdded, bagItemA, eopiwmsg.remote);
                    return (true);
                case (msg is ExchangeObjectRemovedFromBagMessage):
                    eorfwmsg = (msg as ExchangeObjectRemovedFromBagMessage);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.BagItemDeleted, eorfwmsg.objectUID, eorfwmsg.remote);
                    return (true);
                case (msg is ExchangeObjectUseInWorkshopAction):
                    eosiwa = (msg as ExchangeObjectUseInWorkshopAction);
                    eouiwmsg = new ExchangeObjectUseInWorkshopMessage();
                    eouiwmsg.initExchangeObjectUseInWorkshopMessage(eosiwa.objectUID, eosiwa.quantity);
                    ConnectionsHandler.getConnection().send(eouiwmsg);
                    return (true);
                case (msg is ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction):
                    emcsccuhra = (msg as ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction);
                    emcsccuhrmsg = new ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage();
                    emcsccuhrmsg.initExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(emcsccuhra.allow);
                    ConnectionsHandler.getConnection().send(emcsccuhrmsg);
                    return (true);
                case (msg is ExchangeMultiCraftCrafterCanUseHisRessourcesMessage):
                    emcccuhrmsg = (msg as ExchangeMultiCraftCrafterCanUseHisRessourcesMessage);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeMultiCraftCrafterCanUseHisRessources, emcccuhrmsg.allowed);
                    return (true);
                case (msg is ExchangeStartOkMulticraftCrafterMessage):
                    esomcmsg = (msg as ExchangeStartOkMulticraftCrafterMessage);
                    this._skillId = esomcmsg.skillId;
                    skill = Skill.getSkillById(this._skillId);
                    if (skill.isForgemagus)
                    {
                        this._craftType = 1;
                    }
                    else
                    {
                        this._craftType = 0;
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkMultiCraft, esomcmsg.skillId, this.crafterInfos, this.customerInfos);
                    return (true);
                case (msg is ExchangeStartOkMulticraftCustomerMessage):
                    esomcustomermsg = (msg as ExchangeStartOkMulticraftCustomerMessage);
                    this.crafterInfos.skillLevel = esomcustomermsg.crafterJobLevel;
                    this._skillId = esomcustomermsg.skillId;
                    skill2 = Skill.getSkillById(this._skillId);
                    if (skill2.isForgemagus)
                    {
                        this._craftType = 1;
                    }
                    else
                    {
                        this._craftType = 0;
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkMultiCraft, esomcustomermsg.skillId, this.crafterInfos, this.customerInfos);
                    return (true);
                case (msg is ExchangeReplayAction):
                    era = (msg as ExchangeReplayAction);
                    ermsg = new ExchangeCraftCountRequestMessage();
                    ermsg.initExchangeCraftCountRequestMessage(era.count);
                    ConnectionsHandler.getConnection().send(ermsg);
                    return (true);
                case (msg is ExchangeCraftCountModifiedMessage):
                    ercmmsg = (msg as ExchangeCraftCountModifiedMessage);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeReplayCountModified, ercmmsg.count);
                    return (true);
                case (msg is ExchangeLeaveMessage):
                    elm = (msg as ExchangeLeaveMessage);
                    if (elm.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        PlayedCharacterManager.getInstance().isInExchange = false;
                        this._success = elm.success;
                        Kernel.getWorker().removeFrame(this);
                    };
                    return (true);
            };
            return (false);
        }

        private function resetLists():void
        {
            this.paymentCraftList.kamaPayment = 0;
            this.paymentCraftList.kamaPaymentOnlySuccess = 0;
            this.paymentCraftList.objectsPayment = new Array();
            this.paymentCraftList.objectsPaymentOnlySuccess = new Array();
        }

        public function addCraftComponent(pRemote:Boolean, pItemWrapper:ItemWrapper):void
        {
            var playerExchangeCraftList:PlayerExchangeCraftList;
            if (pRemote)
            {
                playerExchangeCraftList = this.otherPlayerList;
            }
            else
            {
                playerExchangeCraftList = this.playerList;
            };
            playerExchangeCraftList.componentList.push(pItemWrapper);
            this.sendUpdateHook(playerExchangeCraftList);
            if ((((((((!(this._craftType == 0)) && (!(pItemWrapper.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE))) && (!(pItemWrapper.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_TRANSCENDANCE_RUNE))) && (!(pItemWrapper.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_CORRUPTION_RUNE))) && (!(pItemWrapper.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_POTION))) && (!(pItemWrapper.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_ORB))) && (!(pItemWrapper.objectGID == DataEnum.ITEM_GID_SIGNATURE_RUNE))))
            {
                this._smithMagicOldObject = pItemWrapper.clone();
            };
        }

        public function modifyCraftComponent(pRemote:Boolean, pItemWrapper:ItemWrapper):void
        {
            var playerExchangeCraftList:PlayerExchangeCraftList;
            if (pRemote)
            {
                playerExchangeCraftList = this.otherPlayerList;
            }
            else
            {
                playerExchangeCraftList = this.playerList;
            };
            var index:int;
            while (index < playerExchangeCraftList.componentList.length)
            {
                if (((playerExchangeCraftList.componentList[index].objectGID == pItemWrapper.objectGID) && (playerExchangeCraftList.componentList[index].objectUID == pItemWrapper.objectUID)))
                {
                    playerExchangeCraftList.componentList.splice(index, 1, pItemWrapper);
                };
                index++;
            };
            this.sendUpdateHook(playerExchangeCraftList);
        }

        public function removeCraftComponent(pRemote:Boolean, pUID:uint):void
        {
            var itemo:ItemWrapper;
            var itemp:ItemWrapper;
            var compt:uint;
            for each (itemo in this.otherPlayerList.componentList)
            {
                if (itemo.objectUID == pUID)
                {
                    this.otherPlayerList.componentList.splice(compt, 1);
                    this.sendUpdateHook(this.otherPlayerList);
                    break;
                };
                compt++;
            };
            compt = 0;
            for each (itemp in this.playerList.componentList)
            {
                if (itemp.objectUID == pUID)
                {
                    this.playerList.componentList.splice(compt, 1);
                    this.sendUpdateHook(this.playerList);
                    break;
                };
                compt++;
            };
        }

        public function addObjetPayment(pOnlySuccess:Boolean, pItemWrapper:ItemWrapper):void
        {
            if (pOnlySuccess)
            {
                this.paymentCraftList.objectsPaymentOnlySuccess.push(pItemWrapper);
            }
            else
            {
                this.paymentCraftList.objectsPayment.push(pItemWrapper);
            };
        }

        public function removeObjetPayment(pUID:uint, pOnlySuccess:Boolean):void
        {
            var objects:Array;
            var itemW:ItemWrapper;
            var compt:uint;
            if (pOnlySuccess)
            {
                objects = this.paymentCraftList.objectsPaymentOnlySuccess;
            }
            else
            {
                objects = this.paymentCraftList.objectsPayment;
            };
            for each (itemW in objects)
            {
                if (itemW.objectUID == pUID)
                {
                    objects.splice(compt, 1);
                };
                compt++;
            };
            KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList, this.paymentCraftList, true);
        }

        private function sendUpdateHook(pPlayerExchangeCraftList:PlayerExchangeCraftList):void
        {
            switch (pPlayerExchangeCraftList)
            {
                case this.otherPlayerList:
                    KernelEventsManager.getInstance().processCallback(CraftHookList.OtherPlayerListUpdate, pPlayerExchangeCraftList);
                    break;
                case this.playerList:
                    KernelEventsManager.getInstance().processCallback(CraftHookList.PlayerListUpdate, pPlayerExchangeCraftList);
                    break;
            };
        }


    }
}

import com.ankamagames.tiphon.types.look.TiphonEntityLook;

class PaymentCraftList 
{

    public var kamaPaymentOnlySuccess:Number = 0;
    public var objectsPaymentOnlySuccess:Array;
    public var kamaPayment:Number = 0;
    public var objectsPayment:Array;

    public function PaymentCraftList():void
    {
        this.kamaPaymentOnlySuccess = 0;
        this.objectsPaymentOnlySuccess = new Array();
        this.kamaPayment = 0;
        this.objectsPayment = new Array();
    }

}

class PlayerExchangeCraftList 
{

    public var componentList:Array;
    public var isCrafter:Boolean;

    public function PlayerExchangeCraftList():void
    {
        this.componentList = new Array();
        this.isCrafter = false;
    }

}

class PlayerInfo 
{

    public var id:Number;
    public var name:String;
    public var look:TiphonEntityLook;
    public var skillLevel:int;


}


