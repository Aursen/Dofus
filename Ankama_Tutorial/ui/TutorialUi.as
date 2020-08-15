package Ankama_Tutorial.ui
{
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.QuestApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.components.Slot;
    import com.ankamagames.berilia.components.ProgressBar;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Texture;
    import d2hooks.QuestStarted;
    import d2hooks.QuestInfosUpdated;
    import d2hooks.QuestStepValidated;
    import d2hooks.GameFightEnd;
    import d2hooks.GameFightJoin;
    import d2hooks.ExchangeLeave;
    import d2hooks.ExchangeStarted;
    import d2hooks.ExchangeStartOkHumanVendor;
    import d2hooks.ExchangeShopStockStarted;
    import d2hooks.ExchangeStartOkNpcTrade;
    import d2hooks.GameRolePlayPlayerLifeStatus;
    import d2hooks.TeleportDestinationList;
    import d2hooks.ExchangeStartOkCraft;
    import d2hooks.ExchangeStartOkNpcShop;
    import d2hooks.DocumentReadingBegin;
    import d2hooks.NpcDialogCreation;
    import d2hooks.LeaveDialog;
    import d2hooks.UiLoaded;
    import Ankama_Tutorial.managers.TutorialStepManager;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import Ankama_Tutorial.TutorialConstants;
    import d2hooks.RewardableAchievementsVisible;
    import Ankama_Tutorial.Api;
    import d2actions.QuestInfosRequest;
    import d2hooks.ShowObjectLinked;
    import d2actions.GuidedModeReturnRequest;
    import d2actions.GuidedModeQuitRequest;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import d2hooks.*;
    import d2actions.*;

    public class TutorialUi 
    {

        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="QuestApi")]
        public var questApi:QuestApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        public var ctr_joinTutorial:GraphicContainer;
        public var ctr_quest:GraphicContainer;
        public var ctr_reward:GraphicContainer;
        public var lbl_stepName:Label;
        public var lbl_expRewardValue:Label;
        public var tx_expRewardIcon:TextureBitmap;
        public var slot_reward1:Slot;
        public var texta_description:Label;
        public var pb_progressBar:ProgressBar;
        public var btn_close_ctr_quest:ButtonContainer;
        public var btn_joinTutorial:ButtonContainer;
        public var tx_stepImage:Texture;
        private var _iconTexture:Texture;
        private var _tutorialManager:Object;
        private var _questInfo:Object;
        private var _quest:Object;
        private var _currentStepNumber:uint;
        private var _tipsUiClass:Object = null;
        private var _heightBackground:int;
        private var _yReward:int;
        private var _yProgress:int;
        private var _popupName:String;
        private var _unloading:Boolean = false;


        public function main(param:Object):void
        {
            this.sysApi.addHook(QuestStarted, this.onQuestStarted);
            this.sysApi.addHook(QuestInfosUpdated, this.onQuestInfosUpdated);
            this.sysApi.addHook(QuestStepValidated, this.onQuestStepValidated);
            this.sysApi.addHook(GameFightEnd, this.onGameFightEnd);
            this.sysApi.addHook(GameFightJoin, this.onGameFightJoin);
            this.sysApi.addHook(ExchangeLeave, this.onExchangeLeave);
            this.sysApi.addHook(ExchangeStarted, this.onExchangeStarted);
            this.sysApi.addHook(ExchangeStartOkHumanVendor, this.onExchangeStartOkHumanVendor);
            this.sysApi.addHook(ExchangeShopStockStarted, this.onExchangeShopStockStarted);
            this.sysApi.addHook(ExchangeStartOkNpcTrade, this.onExchangeStartOkNpcTrade);
            this.sysApi.addHook(GameRolePlayPlayerLifeStatus, this.onGameRolePlayPlayerLifeStatus);
            this.sysApi.addHook(TeleportDestinationList, this.onTeleportDestinationList);
            this.sysApi.addHook(ExchangeStartOkCraft, this.onExchangeStartOkCraft);
            this.sysApi.addHook(ExchangeStartOkNpcShop, this.onExchangeStartOkNpcShop);
            this.sysApi.addHook(DocumentReadingBegin, this.onDocumentReadingBegin);
            this.sysApi.addHook(NpcDialogCreation, this.onNpcDialogCreation);
            this.sysApi.addHook(LeaveDialog, this.onLeaveDialog);
            if (this.uiApi.getUi("tips"))
            {
                this._tipsUiClass = this.uiApi.getUi("tips").uiClass;
            }
            else
            {
                this.sysApi.addHook(UiLoaded, this.onUiLoaded);
            };
            this._heightBackground = this.uiApi.me().getConstant("height_background");
            this._yReward = this.uiApi.me().getConstant("y_reward");
            this._yProgress = this.uiApi.me().getConstant("y_progress");
            TutorialStepManager.initStepManager();
            this._tutorialManager = TutorialStepManager.getInstance();
            var bannerMenu:Object = this.uiApi.getUi("bannerMenu");
            if (bannerMenu)
            {
                this._tutorialManager.bannerMenuUiClass = bannerMenu.uiClass;
            };
            this._tutorialManager.disabled = false;
            if (!this._tutorialManager.preloaded)
            {
                this._tutorialManager.preload();
            };
            this.uiApi.addComponentHook(this.slot_reward1, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.slot_reward1, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.slot_reward1, ComponentHookList.ON_RIGHT_CLICK);
            this.uiApi.addComponentHook(this.slot_reward1, ComponentHookList.ON_RELEASE);
            this._iconTexture = (this.uiApi.createComponent("Texture") as Texture);
            this._iconTexture.width = this.slot_reward1.icon.width;
            this._iconTexture.height = this.slot_reward1.icon.height;
            this.uiApi.addChild(this.uiApi.getUi(UIEnum.BANNER), this._iconTexture);
            if (param[0])
            {
                this.displayTutorial(false);
            }
            else
            {
                this.closeTutorial();
            };
            this.moveDefault();
        }

        public function get tutorialDisabled():Boolean
        {
            return (this._tutorialManager.disabled);
        }

        public function get quest():Object
        {
            if (!this._quest)
            {
                this._quest = this.dataApi.getQuest(TutorialConstants.QUEST_TUTORIAL_ID);
            };
            return (this._quest);
        }

        public function unload():void
        {
            this._unloading = true;
            if (this._tutorialManager)
            {
                if (!this._tutorialManager.disabled)
                {
                    this._tutorialManager.disabled = true;
                    this._tutorialManager.removeHooks();
                };
                this._tutorialManager.unload();
                this._tutorialManager = null;
            };
            this.showHud(false, true);
            var tipsUi:Object = this.getTipsUi();
            if (tipsUi)
            {
                tipsUi.activate();
            };
            if (((((this.sysApi) && (this.questApi)) && (this.questApi.getRewardableAchievements())) && (this.questApi.getRewardableAchievements().length > 0)))
            {
                this.sysApi.dispatchHook(RewardableAchievementsVisible, true);
            };
            if (Api.highlight)
            {
                Api.highlight.stop();
            };
            this.uiApi.removeChild(this.uiApi.getUi(UIEnum.BANNER), this._iconTexture);
            this.uiApi.unloadUi(this._popupName);
        }

        public function onQuestStarted(questId:uint):void
        {
            if (questId == TutorialConstants.QUEST_TUTORIAL_ID)
            {
                this.sysApi.sendAction(new QuestInfosRequest(TutorialConstants.QUEST_TUTORIAL_ID));
            };
        }

        public function moveLeft():void
        {
            this.ctr_quest.x = 5;
            this.ctr_quest.y = 15;
        }

        public function moveDefault():void
        {
            this.ctr_quest.x = 850;
            this.ctr_quest.y = 15;
        }

        private function onQuestStepValidated(questId:uint, stepId:uint):void
        {
            this.sysApi.sendAction(new QuestInfosRequest(questId));
        }

        private function onQuestInfosUpdated(questId:uint, infosAvailable:Boolean):void
        {
            var stepId:uint;
            if ((((questId == TutorialConstants.QUEST_TUTORIAL_ID) && (infosAvailable)) && (!(this._tutorialManager.disabled))))
            {
                if (((this.questApi.getRewardableAchievements()) && (this.questApi.getRewardableAchievements().length > 0)))
                {
                    this.sysApi.dispatchHook(RewardableAchievementsVisible, false);
                };
                this._questInfo = this.questApi.getQuestInformations(questId);
                this._quest = this.dataApi.getQuest(this._questInfo.questId);
                this._currentStepNumber = 0;
                for each (stepId in this.quest.stepIds)
                {
                    if (stepId == this._questInfo.stepId)
                    {
                        break;
                    };
                    this._currentStepNumber++;
                };
                this.showHud((this._currentStepNumber > 1), false);
                if ((((questId == 489) && (!(this._tutorialManager.doneIntroStep))) && (this._currentStepNumber <= 1)))
                {
                    this._tutorialManager.jumpToStep(0);
                }
                else
                {
                    this._tutorialManager.jumpToStep((this._currentStepNumber + 1));
                };
                this.setStep(this._currentStepNumber);
                this.ctr_quest.visible = this.visible;
            };
        }

        private function onUiLoaded(name:String):void
        {
            var tipsUi:Object;
            if (((name == "tips") && (!(this._tutorialManager.disabled))))
            {
                tipsUi = this.getTipsUi();
                if (tipsUi)
                {
                    tipsUi.deactivate();
                };
            };
            this.sysApi.dispatchHook(RewardableAchievementsVisible, false);
        }

        private function setStep(stepCount:int):void
        {
            var iw:Object;
            var steps:Object = this.quest.stepIds;
            var stepId:uint = steps[stepCount];
            var step:Object = this.dataApi.getQuestStep(stepId);
            this.lbl_stepName.text = step.name;
            this.texta_description.text = step.description;
            this.tx_stepImage.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("illus") + "tutorial/illu_tuto_") + (stepCount + 1)) + ".png"));
            var textHeight:int = (this.texta_description.textHeight + 10);
            this.ctr_quest.height = (this._heightBackground + textHeight);
            this.ctr_reward.y = ((this.texta_description.y + 5) + textHeight);
            if (this._iconTexture)
            {
                this._iconTexture.y = ((this.ctr_quest.y + ((this._yReward + this.texta_description.textHeight) + 10)) + this.slot_reward1.y);
            };
            var maxSteps:int = steps.length;
            this.pb_progressBar.value = (stepCount / maxSteps);
            if (step.experienceReward > 0)
            {
                this.lbl_expRewardValue.text = step.experienceReward;
                this.lbl_expRewardValue.visible = true;
                this.tx_expRewardIcon.visible = true;
            }
            else
            {
                this.lbl_expRewardValue.visible = false;
                this.tx_expRewardIcon.visible = false;
            };
            if (((step.itemsReward) && (step.itemsReward.length > 0)))
            {
                this.slot_reward1.visible = true;
                iw = this.dataApi.getItemWrapper(step.itemsReward[0][0]);
                this.slot_reward1.data = iw;
            }
            else
            {
                this.slot_reward1.visible = false;
                this.slot_reward1.data = null;
            };
            this.uiApi.me().render();
        }

        public function onRollOver(target:Object):void
        {
            switch (target)
            {
                case this.slot_reward1:
                    if (target.data)
                    {
                        this.uiApi.showTooltip(target.data, target, false, "standard", 0, 2, 3, null, null, {
                            "showEffects":true,
                            "header":true,
                            "averagePrice":false
                        }, ("ItemInfo" + target.data.objectGID));
                    };
                    break;
                case this.btn_joinTutorial:
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tutorial.joinTutorialTooltip")), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                    break;
                case this.btn_close_ctr_quest:
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tutorial.leaveTutorialTooltip")), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                    break;
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRightClick(target:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (target == this.slot_reward1)
            {
                data = target.data;
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_joinTutorial:
                    this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.tutorial.tutorial"), this.uiApi.getText("ui.tutorial.joinTutorialPopup"), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onJoinTutorial, this.nullFunction], this.onJoinTutorial, this.nullFunction);
                    break;
                case this.btn_close_ctr_quest:
                    this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.tutorial.tutorial"), this.uiApi.getText("ui.tutorial.closeTutorialPopup"), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onCloseTutorial, this.nullFunction], this.onCloseTutorial, this.nullFunction);
                    break;
                case this.slot_reward1:
                    if (!this.sysApi.getOption("displayTooltips", "dofus"))
                    {
                        this.sysApi.dispatchHook(ShowObjectLinked, this.slot_reward1.data);
                    };
                    break;
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (item.data)
            {
                this.uiApi.showTooltip(item.data, item.container, false, "standard", 8, 0, 0, "itemName", null, {
                    "showEffects":true,
                    "header":true
                }, "ItemInfo");
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onJoinTutorial():void
        {
            if (this._unloading)
            {
                return;
            };
            this.sysApi.sendAction(new GuidedModeReturnRequest());
            this.sysApi.dispatchHook(RewardableAchievementsVisible, false);
        }

        public function onCloseTutorial():void
        {
            if (this._unloading)
            {
                return;
            };
            this.sysApi.sendAction(new GuidedModeQuitRequest());
            if (this.questApi.getRewardableAchievements().length > 0)
            {
                this.sysApi.dispatchHook(RewardableAchievementsVisible, true);
            };
        }

        public function displayTutorial(visible:Boolean=true):void
        {
            var uirc:UiRootContainer;
            var tipsUi:Object;
            this.sysApi.sendAction(new QuestInfosRequest(TutorialConstants.QUEST_TUTORIAL_ID));
            this.ctr_joinTutorial.visible = false;
            this.ctr_quest.visible = visible;
            var uish:Array = this.hintsApi.getAllOpenedUiWithSubHints();
            for each (uirc in uish)
            {
                uirc.getElement("btn_help").visible = false;
            };
            this._tutorialManager.disabled = false;
            tipsUi = this.getTipsUi();
            if (tipsUi)
            {
                tipsUi.deactivate();
            };
        }

        public function get visible():Boolean
        {
            return (!(this._tutorialManager.disabled));
        }

        public function closeTutorial():void
        {
            var uirc:UiRootContainer;
            var tipsUi:Object;
            this.showHud(false, true);
            this.ctr_quest.visible = false;
            this.ctr_joinTutorial.visible = true;
            this._tutorialManager.disabled = true;
            var uish:Array = this.hintsApi.getAllOpenedUiWithSubHints();
            for each (uirc in uish)
            {
                uirc.getElement("btn_help").visible = true;
            };
            tipsUi = this.getTipsUi();
            if (tipsUi)
            {
                tipsUi.activate();
            };
            Api.highlight.stop();
        }

        private function getTipsUi():Object
        {
            var tipsUi:Object = this.uiApi.getUi("tips");
            if (tipsUi)
            {
                this._tipsUiClass = tipsUi.uiClass;
                if (this._tipsUiClass)
                {
                    return (this._tipsUiClass);
                };
            };
            return (null);
        }

        private function showHud(show:Boolean=false, endTuto:Boolean=false):void
        {
            var uirc:UiRootContainer;
            var uiArr:Array = this.uiApi.getHud();
            for each (uirc in uiArr)
            {
                if (!uirc)
                {
                }
                else
                {
                    if (endTuto)
                    {
                        if (uirc.uiData.name == "questList")
                        {
                            uirc.uiClass.visible = true;
                            uirc.uiClass.unfollowQuest(null);
                        }
                        else
                        {
                            if (((uirc.uiData.name == "questListMinimized") && (uirc.uiClass)))
                            {
                                uirc.uiClass.visible = true;
                            }
                            else
                            {
                                uirc.visible = true;
                            };
                        };
                    }
                    else
                    {
                        if (show)
                        {
                            uirc.visible = (((uirc.uiData.name == "banner") || (uirc.uiData.name == "bannerMenu")) || (uirc.uiData.name == "chat"));
                        }
                        else
                        {
                            uirc.visible = false;
                        };
                    };
                };
            };
        }

        public function nullFunction():void
        {
        }

        public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int, alliesPreparation:Boolean):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.visible = false;
            };
            this.btn_close_ctr_quest.disabled = true;
        }

        public function onGameFightEnd(params:Object):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.visible = true;
            };
            this.btn_close_ctr_quest.disabled = false;
        }

        public function onNpcDialogCreation(mapId:Number, npcId:int, look:Object):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = true;
            };
        }

        public function onLeaveDialog():void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = false;
            };
        }

        private function onExchangeStarted(pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object, pSourceCurrentPods:int, pTargetCurrentPods:int, pSourceMaxPods:int, pTargetMaxPods:int, otherId:Number):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = true;
            };
        }

        private function onExchangeLeave(success:Boolean):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = false;
            };
        }

        private function onExchangeStartOkHumanVendor(vendorName:String, shopStock:Object, look:Object):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = true;
            };
        }

        private function onExchangeShopStockStarted(shopStock:Object):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = true;
            };
        }

        private function onExchangeStartOkNpcShop(pNCPSellerId:int, pObjects:Object, pLook:Object, tokenId:int):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = true;
            };
        }

        private function onExchangeStartOkNpcTrade(pNPCId:uint, pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = true;
            };
        }

        private function onDocumentReadingBegin(documentId:uint):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = true;
            };
        }

        private function onTeleportDestinationList(teleportList:Object, tpType:uint):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = true;
            };
        }

        private function onExchangeStartOkCraft(skillId:uint):void
        {
            if (this._tutorialManager.disabled)
            {
                this.ctr_joinTutorial.disabled = true;
            };
        }

        private function onGameRolePlayPlayerLifeStatus(status:uint, hardcore:uint):void
        {
            if (hardcore == 0)
            {
                switch (status)
                {
                    case 0:
                        if (this._tutorialManager.disabled)
                        {
                            this.ctr_joinTutorial.disabled = false;
                        };
                        break;
                    case 1:
                        if (this._tutorialManager.disabled)
                        {
                            this.ctr_joinTutorial.disabled = true;
                        };
                        break;
                    case 2:
                        if (this._tutorialManager.disabled)
                        {
                            this.ctr_joinTutorial.disabled = true;
                        };
                        break;
                };
            };
        }


    }
}

