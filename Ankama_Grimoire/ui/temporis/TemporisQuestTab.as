package Ankama_Grimoire.ui.temporis
{
    import mapTools.Point;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.InventoryApi;
    import com.ankamagames.dofus.uiApi.QuestApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementAchievedRewardable;
    import d2hooks.AchievementRewardSuccess;
    import d2hooks.AchievementFinished;
    import d2hooks.LocatePorisAssistant;
    import d2hooks.UiLoaded;
    import d2enums.ComponentHookList;
    import d2hooks.NewAreNewTemporisRewardsAvailable;
    import flash.display.Sprite;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.dofus.datacenter.temporis.AchievementProgressStep;
    import com.ankamagames.dofus.datacenter.quest.AchievementReward;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
    import com.ankamagames.dofus.internalDatacenter.appearance.OrnamentWrapper;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.internalDatacenter.appearance.TitleWrapper;
    import com.ankamagames.dofus.datacenter.quest.Achievement;
    import com.ankamagames.dofus.datacenter.servers.ServerTemporisSeason;
    import com.ankamagames.dofus.datacenter.temporis.AchievementProgress;
    import d2actions.AchievementRewardRequest;
    import d2hooks.AddMapFlag;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
    import flash.utils.setTimeout;

    public class TemporisQuestTab 
    {

        public static const TOOLTIP_UI_NAME:String = "TemporisQuestTabTooltip";
        public static const STANDARD_TOOLTIP_UI_NAME:String = "standard";
        public static const CAT_TOP:uint = 0;
        public static const CAT_BIG:uint = 1;
        public static const CAT_SMALL:uint = 2;
        public static const LINE_HEIGHT_AND_VERTICAL_PADDING:uint = 110;
        private static const GRID_COLUMNS:uint = 9;
        private static const PAGE_PACE:uint = 6;
        private static const EMPTY_CONTAINER_NAME:String = "ctr_empty";
        private static const STEP_CONTAINER_NAME:String = "ctr_step";
        private static const SEE_RANKING_BUTTON_MARGIN:uint = 10;
        private static const SEE_RANKING_BUTTON_ICON_OFFSET:uint = 10;
        private static const TEMPOTON_OBJECT_GID:int = 20763;
        private static const TEMPOTONS_NEEDED_TO_UNLOCK_MISSIONS:Number = 3500;
        private static const PORIS_ASSISTANT_POSITION:Point = new Point(4, -19);
        private static const MIN_TEMPOTON_AMOUNT_FOR_MISSIONS:uint = 4000;
        private static const STORAGE_NEW_TEMPORIS_4_REWARD:String = "storageNewTemporis4Reward";
        private static const SCROLL_MAGIC_WORKSHOP_POSITION:Point = new Point(-4, -24);

        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="InventoryApi")]
        public var inventoryApi:InventoryApi;
        [Api(name="QuestApi")]
        public var questApi:QuestApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Api(name="PlayedCharacterApi")]
        public var playedCharacterApi:PlayedCharacterApi;
        [Api(name="SystemApi")]
        public var systemApi:SystemApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        private var _lastNameExtension:String = "";
        private var _achievements:Array;
        private var _rewardableAchievements:Array;
        private var _tempotonsAmountList:Array;
        private var _obtainedTempotons:uint = 0;
        private var _obtainedRewards:uint = 0;
        private var _rewardsNumber:uint = 0;
        private var _currentProgressBarIndex:Number = 0;
        private var _componentsDictionary:Dictionary = new Dictionary(true);
        public var btn_previousAchievements:ButtonContainer;
        public var btn_nextAchievements:ButtonContainer;
        public var btn_seeRanking:ButtonContainer;
        public var btn_getAllRewards:ButtonContainer;
        public var btn_locateScrollMagicWorkshop:ButtonContainer;
        public var ctr_temporisMissionsLocked:GraphicContainer;
        public var ctr_temporisMissionsUnlocked:GraphicContainer;
        public var gd_progress:Grid;
        public var lbl_obtainedTempotons:Label;
        public var lbl_rewardsObtained:Label;
        public var lbl_temporisFourthSeasonDescriptionText:Label;
        public var lbl_temporisSuccesses:Label;
        public var lbl_startMissions:Label;
        public var lbl_tempotonsToUnlock:Label;
        public var tx_seeRanking:Texture;
        public var tx_neededTempotons:Texture;


        private static function isAchievementRewardGiven(achievementId:uint, rewardableAchievementsObject:Object):Boolean
        {
            var achievementAchievedRewardable:AchievementAchievedRewardable;
            for each (achievementAchievedRewardable in rewardableAchievementsObject)
            {
                if (achievementAchievedRewardable.id === achievementId)
                {
                    return (false);
                };
            };
            return (true);
        }


        public function main(paramsObject:Object=null):void
        {
            this.systemApi.addHook(AchievementRewardSuccess, this.onAchievementRewardSuccess);
            this.systemApi.addHook(AchievementFinished, this.onAchievementFinished);
            this.systemApi.addHook(LocatePorisAssistant, this.onLocatePorisAssistant);
            this.systemApi.addHook(UiLoaded, this.onUiLoaded);
            this.uiApi.addComponentHook(this.btn_seeRanking, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_locateScrollMagicWorkshop, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_locateScrollMagicWorkshop, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_locateScrollMagicWorkshop, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_nextAchievements, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_previousAchievements, ComponentHookList.ON_RELEASE);
            this.setSeeRankingButton();
            this.updateTempotonAmount();
            this.questApi.refreshAchievementsCriterions();
            this.loadAchievementRewards();
            this.updateAchievementData();
            this.updateAchievementArrowButtons();
            this.lbl_temporisFourthSeasonDescriptionText.text = this.uiApi.getText("ui.temporis.openTemporisSpellsUiDescription", (("{openTemporisSpellsUi::" + this.uiApi.getText("ui.temporis.openTemporisSpellsUiLink")) + "}"));
            this.lbl_temporisSuccesses.text = this.uiApi.getText("ui.temporis.openTemporisSuccesses", (("{openTemporisSuccesses::" + this.uiApi.getText("ui.temporis.openTemporisSuccessesLink")) + "}"));
            this.lbl_startMissions.text = this.uiApi.getText("ui.temporis.startMissions", (("{locatePorisAssistant::" + this.uiApi.getText("ui.temporis.startMissionsLink")) + "}"));
            this.systemApi.setData(STORAGE_NEW_TEMPORIS_4_REWARD, false);
            this.systemApi.dispatchHook(NewAreNewTemporisRewardsAvailable, false);
        }

        public function unload():void
        {
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
        }

        public function showTabHints():void
        {
            this.hintsApi.showSubHints();
        }

        public function updateColumn(data:*, componentsRef:*, isSelected:Boolean, line:uint):void
        {
            var subData:Object;
            switch (this.getColumnType(data, line))
            {
                case EMPTY_CONTAINER_NAME:
                    break;
                case STEP_CONTAINER_NAME:
                    this._lastNameExtension = componentsRef.gd_step.name.slice(7);
                    for each (subData in data)
                    {
                        if (subData)
                        {
                            subData.nameExtension = this._lastNameExtension;
                        };
                    };
                    componentsRef.gd_step.dataProvider = data;
                    componentsRef.gd_step.height = ((data.length * LINE_HEIGHT_AND_VERTICAL_PADDING) + 10);
                    break;
            };
        }

        public function getColumnType(data:*, line:uint):String
        {
            if (data !== null)
            {
                return (STEP_CONTAINER_NAME);
            };
            return (EMPTY_CONTAINER_NAME);
        }

        public function updateLine(data:*, componentsRef:*, isSelected:Boolean, line:uint):void
        {
            var firstSlotIndex:Number;
            var isNextStep:Boolean;
            var previousStepType:String;
            var minValue:Number;
            var maxValue:Number;
            var nextStepValue:Number;
            if (data === null)
            {
                return;
            };
            if (data.cat === CAT_TOP)
            {
                firstSlotIndex = this.gd_progress.firstItemDisplayedIndex;
                isNextStep = (data.index < ((firstSlotIndex + GRID_COLUMNS) - 1));
                previousStepType = ((data.index === firstSlotIndex) ? "beginning" : data.previousStepType);
                componentsRef.lbl_tempoton.text = data.tempotonAmount.toString();
                componentsRef.lbl_tempoton.fullWidth();
                componentsRef.tx_tempoton.x = (componentsRef.lbl_tempoton.width + 2);
                componentsRef.tx_tempoton.y = -2;
                componentsRef.ctr_tempoton.width = ((componentsRef.lbl_tempoton.width + componentsRef.tx_tempoton.width) + 2);
                componentsRef.ctr_tempoton.x = ((componentsRef.tx_tempotonBg.x + (componentsRef.tx_tempotonBg.width / 2)) - (componentsRef.ctr_tempoton.width / 2));
                componentsRef.ctr_tempoton.y = 10;
                componentsRef.tx_greenRectangleTop.visible = data.highlighted;
                if (data.currentStepType === "big")
                {
                    if (previousStepType === "big")
                    {
                        componentsRef.pb_previous.x = -8;
                        componentsRef.pb_previous.y = 129;
                        componentsRef.pb_previous.width = 9;
                        componentsRef.pb_previous.height = 10;
                    }
                    else
                    {
                        if (previousStepType === "small")
                        {
                            componentsRef.pb_previous.x = -37;
                            componentsRef.pb_previous.y = 129;
                            componentsRef.pb_previous.width = 36;
                            componentsRef.pb_previous.height = 10;
                        }
                        else
                        {
                            if (previousStepType === "beginning")
                            {
                                componentsRef.pb_previous.x = -12;
                                componentsRef.pb_previous.y = 129;
                                componentsRef.pb_previous.width = 13;
                                componentsRef.pb_previous.height = 10;
                            };
                        };
                    };
                    if (!isNextStep)
                    {
                        componentsRef.pb_next.visible = true;
                        componentsRef.pb_next.x = 119;
                        componentsRef.pb_next.y = 129;
                        componentsRef.pb_next.width = 19;
                        componentsRef.pb_next.height = 10;
                    }
                    else
                    {
                        componentsRef.pb_next.visible = false;
                    };
                }
                else
                {
                    if (data.currentStepType === "small")
                    {
                        if (previousStepType === "big")
                        {
                            componentsRef.pb_previous.x = -8;
                            componentsRef.pb_previous.y = 129;
                            componentsRef.pb_previous.width = 39;
                            componentsRef.pb_previous.height = 10;
                        }
                        else
                        {
                            if (previousStepType === "small")
                            {
                                componentsRef.pb_previous.x = -37;
                                componentsRef.pb_previous.y = 129;
                                componentsRef.pb_previous.width = 68;
                                componentsRef.pb_previous.height = 10;
                            }
                            else
                            {
                                if (previousStepType === "beginning")
                                {
                                    componentsRef.pb_previous.x = -12;
                                    componentsRef.pb_previous.y = 129;
                                    componentsRef.pb_previous.width = 43;
                                    componentsRef.pb_previous.height = 10;
                                };
                            };
                        };
                        if (!isNextStep)
                        {
                            componentsRef.pb_next.visible = true;
                            componentsRef.pb_next.x = 90;
                            componentsRef.pb_next.y = 129;
                            componentsRef.pb_next.width = 47;
                            componentsRef.pb_next.height = 10;
                        }
                        else
                        {
                            componentsRef.pb_next.visible = false;
                        };
                    };
                };
                if (data.highlighted)
                {
                    componentsRef.pb_previous.width = (componentsRef.pb_previous.width - 2);
                };
                minValue = ((data.index === 0) ? 0 : this._tempotonsAmountList[(data.index - 1)]);
                maxValue = this._tempotonsAmountList[data.index];
                if (this._obtainedTempotons >= maxValue)
                {
                    componentsRef.pb_previous.value = 1;
                }
                else
                {
                    if (this._obtainedTempotons <= minValue)
                    {
                        componentsRef.pb_previous.value = 0;
                    }
                    else
                    {
                        componentsRef.pb_previous.value = ((this._obtainedTempotons - minValue) / (maxValue - minValue));
                    };
                };
                if (((!(isNextStep)) && (data.index < (this._achievements.length - 1))))
                {
                    nextStepValue = ((data.index >= (this._tempotonsAmountList.length - 1)) ? maxValue : this._tempotonsAmountList[(data.index + 1)]);
                    componentsRef.pb_next.visible = true;
                    if (this._obtainedTempotons > nextStepValue)
                    {
                        componentsRef.pb_next.value = 1;
                    }
                    else
                    {
                        if (this._obtainedTempotons < maxValue)
                        {
                            componentsRef.pb_next.value = 0;
                        }
                        else
                        {
                            componentsRef.pb_next.value = ((this._obtainedTempotons - maxValue) / (nextStepValue - maxValue));
                        };
                    };
                }
                else
                {
                    componentsRef.pb_next.visible = false;
                };
            }
            else
            {
                if (data.cat === CAT_SMALL)
                {
                    if (data.rewardGiven)
                    {
                        componentsRef.tx_validated.uri = this.uiApi.createUri(this.uiApi.me().getConstant("tx_given"));
                        componentsRef.ctr_validated.visible = true;
                        componentsRef.tx_validated.x = 50;
                        componentsRef.tx_validated.y = 66;
                    }
                    else
                    {
                        if (!data.rewardValidated)
                        {
                            componentsRef.tx_validated.uri = this.uiApi.createUri(this.uiApi.me().getConstant("tx_not_validated"));
                            componentsRef.ctr_validated.visible = true;
                            componentsRef.tx_validated.x = 49;
                            componentsRef.tx_validated.y = 64;
                        }
                        else
                        {
                            componentsRef.ctr_validated.visible = false;
                        };
                    };
                    componentsRef.tx_verticalLink.uri = this.uiApi.createUri(this.uiApi.me().getConstant(((data.highlighted) ? "verticalSeparatorHighlighted" : "verticalSeparator")));
                    componentsRef.btn_getReward.visible = ((!(data.rewardGiven)) && (data.rewardValidated));
                    componentsRef.tx_reward.uri = this.uiApi.createUri(data.txUri);
                    this.uiApi.addComponentHook(componentsRef.tx_reward, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(componentsRef.tx_reward, ComponentHookList.ON_ROLL_OUT);
                    this._componentsDictionary[componentsRef.tx_reward.name] = data.data;
                    componentsRef.tx_greenRectangle.visible = data.highlighted;
                    componentsRef.btn_getReward.value = data.achievementId;
                    if (data.quantity > 1)
                    {
                        componentsRef.lbl_itemQuantity.text = ("x " + this.utilApi.kamasToString(data.quantity, ""));
                        componentsRef.lbl_itemQuantity.visible = true;
                    }
                    else
                    {
                        componentsRef.lbl_itemQuantity.visible = false;
                    };
                }
                else
                {
                    if (data.cat === CAT_BIG)
                    {
                        if (data.rewardGiven)
                        {
                            componentsRef.tx_validatedBig.uri = this.uiApi.createUri(this.uiApi.me().getConstant("tx_given"));
                            componentsRef.ctr_validatedBig.visible = true;
                            componentsRef.tx_validatedBig.x = 49;
                            componentsRef.tx_validatedBig.y = 115;
                        }
                        else
                        {
                            if (!data.rewardValidated)
                            {
                                componentsRef.tx_validatedBig.uri = this.uiApi.createUri(this.uiApi.me().getConstant("tx_not_validated"));
                                componentsRef.ctr_validatedBig.visible = true;
                                componentsRef.tx_validatedBig.x = 49;
                                componentsRef.tx_validatedBig.y = 114;
                            }
                            else
                            {
                                componentsRef.ctr_validatedBig.visible = false;
                            };
                        };
                        componentsRef.ctr_getRewardBig.visible = ((!(data.rewardGiven)) && (data.rewardValidated));
                        componentsRef.tx_rewardBig.uri = this.uiApi.createUri(data.txUri);
                        this.uiApi.addComponentHook(componentsRef.tx_rewardBig, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(componentsRef.tx_rewardBig, ComponentHookList.ON_ROLL_OUT);
                        this._componentsDictionary[componentsRef.tx_rewardBig.name] = data.data;
                        componentsRef.tx_verticalLinkBig.uri = this.uiApi.createUri(this.uiApi.me().getConstant(((data.highlighted) ? "verticalSeparatorHighlighted" : "verticalSeparator")));
                        componentsRef.tx_greenRectangleBig.visible = data.highlighted;
                        componentsRef.btn_getRewardBig.value = data.achievementId;
                    };
                };
            };
            if (!isNextStep)
            {
                this.updateAchievementArrowButtons();
            };
        }

        public function getLineType(data:*, line:uint):String
        {
            if (data !== null)
            {
                switch (data.cat)
                {
                    case CAT_TOP:
                        return ("ctr_top" + data.nameExtension);
                    case CAT_SMALL:
                        return ("ctr_small" + data.nameExtension);
                    case CAT_BIG:
                        return ("ctr_big" + data.nameExtension);
                };
                return ("ctr_emptyLine" + data.nameExtension);
            };
            return ("ctr_emptyLine" + this._lastNameExtension);
        }

        private function refreshAchievements():void
        {
            this.loadAchievementRewards();
            this.updateAchievementData();
        }

        private function seeRanking():void
        {
            this.systemApi.goToUrl(this.uiApi.getText("ui.link.temporisLeaderboard"));
        }

        private function updateTempotonAmount():void
        {
            this._obtainedTempotons = this.inventoryApi.getItemQty(TEMPOTON_OBJECT_GID);
            var areMissionsUnlocked:* = (this._obtainedTempotons >= MIN_TEMPOTON_AMOUNT_FOR_MISSIONS);
            this.ctr_temporisMissionsLocked.visible = (!(areMissionsUnlocked));
            this.ctr_temporisMissionsUnlocked.visible = areMissionsUnlocked;
            if (!areMissionsUnlocked)
            {
                this.lbl_tempotonsToUnlock.text = TEMPOTONS_NEEDED_TO_UNLOCK_MISSIONS.toString();
                this.lbl_tempotonsToUnlock.fullWidth();
                this.lbl_tempotonsToUnlock.width = (this.lbl_tempotonsToUnlock.width + 5);
                this.tx_neededTempotons.x = ((this.lbl_tempotonsToUnlock.x + this.lbl_tempotonsToUnlock.width) - 5);
            };
        }

        private function setSeeRankingButton():void
        {
            if (this.btn_seeRanking.numChildren < 2)
            {
                return;
            };
            var textureParent:Sprite = (this.btn_seeRanking.getChildAt(0) as Sprite);
            var labelParent:Sprite = (this.btn_seeRanking.getChildAt(1) as Sprite);
            if (((((textureParent === null) || (labelParent === null)) || (textureParent.numChildren < 1)) || (labelParent.numChildren < 1)))
            {
                return;
            };
            var texture:TextureBitmap = (textureParent.getChildAt(0) as TextureBitmap);
            var label:Label = (labelParent.getChildAt(0) as Label);
            if (((texture === null) || (label === null)))
            {
                return;
            };
            label.fullWidth();
            var labelWidth:Number = this.uiApi.getTextSize(label.text, label.css, label.cssClass).width;
            texture.width = (this.btn_seeRanking.width = (((labelWidth + this.tx_seeRanking.width) + (2 * SEE_RANKING_BUTTON_MARGIN)) + SEE_RANKING_BUTTON_ICON_OFFSET));
            label.x = (this.btn_seeRanking.x + SEE_RANKING_BUTTON_MARGIN);
            this.tx_seeRanking.x = ((label.x + labelWidth) + SEE_RANKING_BUTTON_ICON_OFFSET);
        }

        private function loadAchievementRewards():void
        {
            var achievementProgressStep:AchievementProgressStep;
            var currentStepType:String;
            var jndex:uint;
            var itemAwardIndex:uint;
            var itemQuantity:uint;
            var itemId:uint;
            var spellId:uint;
            var emoteId:uint;
            var ornamentId:uint;
            var titleId:uint;
            this._achievements = [];
            this._rewardableAchievements = [];
            this._tempotonsAmountList = [];
            this._obtainedRewards = 0;
            this._rewardsNumber = 0;
            var finishedAchievementIds:Array = this.questApi.getFinishedCharacterAchievementIds();
            var rewardableAchievementsObject:Object = this.questApi.getRewardableAchievements();
            var index:uint;
            var currentSubArray:Array = [];
            var currentAchievementReward:AchievementReward;
            var currentItemAward:ItemWrapper;
            var currentEmoteAward:EmoteWrapper;
            var currentOrnamentAward:OrnamentWrapper;
            var currentSpellAward:SpellWrapper;
            var currentTitleAward:TitleWrapper;
            var isRewardGiven:Boolean;
            var isRewardValidated:Boolean = true;
            var isHighlighted:Boolean;
            var previousStepType:String;
            var currentAchievement:Achievement;
            var currentSeason:ServerTemporisSeason = this.dataApi.getCurrentSeason();
            if (currentSeason === null)
            {
                return;
            };
            var achievementProgress:AchievementProgress = this.dataApi.getAchievementProgressWithSeasonId(currentSeason.uid);
            if (achievementProgress === null)
            {
                return;
            };
            var achievementProgressSteps:Array = this.dataApi.getAchievementProgressStepsWithProgressId(achievementProgress.id);
            for each (achievementProgressStep in achievementProgressSteps)
            {
                currentAchievement = this.dataApi.getAchievementById(achievementProgressStep.achievementId);
                if (currentAchievement === null)
                {
                }
                else
                {
                    isHighlighted = false;
                    this._tempotonsAmountList.push(achievementProgressStep.score);
                    if (isRewardValidated)
                    {
                        isRewardValidated = (!(finishedAchievementIds.indexOf(currentAchievement.id) === -1));
                        if (!isRewardValidated)
                        {
                            isHighlighted = true;
                        };
                        if (isRewardValidated)
                        {
                            this._currentProgressBarIndex = index;
                        };
                    };
                    isRewardGiven = ((isRewardValidated) && (isAchievementRewardGiven(currentAchievement.id, rewardableAchievementsObject)));
                    if (((isRewardValidated) && (!(isRewardGiven))))
                    {
                        this._rewardableAchievements.push(currentAchievement.id);
                    };
                    currentStepType = ((achievementProgressStep.isCosmetic) ? "big" : "small");
                    currentSubArray = [];
                    currentSubArray.push(new Top(index, achievementProgressStep.score, isHighlighted, currentStepType, previousStepType));
                    if (achievementProgressStep.isCosmetic)
                    {
                        currentAchievementReward = this.dataApi.getAchievementReward(currentAchievement.rewardIds[0]);
                        if ((((currentAchievementReward === null) || (currentAchievementReward.itemsReward.length <= 0)) || (currentAchievementReward.itemsQuantityReward.length <= 0)))
                        {
                            continue;
                        };
                        currentItemAward = this.dataApi.getItemWrapper(currentAchievementReward.itemsReward[0], currentAchievementReward.itemsQuantityReward[0]);
                        currentSubArray.push(new Reward(CAT_BIG, currentAchievement.id, currentItemAward.fullSizeIconUri.toString(), isRewardGiven, isRewardValidated, isHighlighted, currentItemAward));
                        if (isRewardValidated)
                        {
                            this._obtainedRewards++;
                        };
                        this._rewardsNumber++;
                        previousStepType = "big";
                    }
                    else
                    {
                        if (currentAchievement.rewardIds.length > 0)
                        {
                            jndex = 0;
                            while (jndex < currentAchievement.rewardIds.length)
                            {
                                currentAchievementReward = this.dataApi.getAchievementReward(currentAchievement.rewardIds[jndex]);
                                if (currentAchievementReward === null)
                                {
                                }
                                else
                                {
                                    itemAwardIndex = 0;
                                    itemQuantity = 0;
                                    for each (itemId in currentAchievementReward.itemsReward)
                                    {
                                        itemQuantity = ((currentAchievementReward.itemsQuantityReward.length > itemAwardIndex) ? currentAchievementReward.itemsQuantityReward[itemAwardIndex] : 1);
                                        currentItemAward = this.dataApi.getItemWrapper(itemId, 0, 0, itemQuantity);
                                        this.addReward(currentSubArray, currentAchievement.id, isRewardGiven, isRewardValidated, isHighlighted, currentItemAward, itemQuantity);
                                        itemAwardIndex++;
                                    };
                                    for each (spellId in currentAchievementReward.spellsReward)
                                    {
                                        currentSpellAward = this.dataApi.getSpellWrapper(spellId);
                                        this.addReward(currentSubArray, currentAchievement.id, isRewardGiven, isRewardValidated, isHighlighted, currentSpellAward);
                                    };
                                    for each (emoteId in currentAchievementReward.emotesReward)
                                    {
                                        currentEmoteAward = this.dataApi.getEmoteWrapper(emoteId);
                                        this.addReward(currentSubArray, currentAchievement.id, isRewardGiven, isRewardValidated, isHighlighted, currentEmoteAward);
                                    };
                                    for each (ornamentId in currentAchievementReward.ornamentsReward)
                                    {
                                        currentOrnamentAward = this.dataApi.getOrnamentWrapper(ornamentId);
                                        this.addReward(currentSubArray, currentAchievement.id, isRewardGiven, isRewardValidated, isHighlighted, currentOrnamentAward);
                                    };
                                    for each (titleId in currentAchievementReward.titlesReward)
                                    {
                                        currentTitleAward = this.dataApi.getTitleWrapper(titleId);
                                        this.addReward(currentSubArray, currentAchievement.id, isRewardGiven, isRewardValidated, isHighlighted, currentTitleAward);
                                    };
                                };
                                jndex++;
                            };
                            previousStepType = "small";
                        };
                    };
                    this._achievements.push(currentSubArray);
                    index++;
                };
            };
            this.lbl_obtainedTempotons.text = this.uiApi.getText("ui.temporis.tempotonsAmount", this._obtainedTempotons);
            this.lbl_rewardsObtained.text = this.uiApi.getText("ui.temporis.rewardsObtained", ((this._obtainedRewards + "/") + this._rewardsNumber));
            if (((this._rewardableAchievements === null) || (this._rewardableAchievements.length <= 0)))
            {
                this.uiApi.removeComponentHook(this.btn_getAllRewards, ComponentHookList.ON_RELEASE);
                this.btn_getAllRewards.disabled = true;
            }
            else
            {
                this.uiApi.addComponentHook(this.btn_getAllRewards, ComponentHookList.ON_RELEASE);
                this.btn_getAllRewards.disabled = false;
            };
        }

        private function addReward(currentSubArray:Array, achievementId:uint, isRewardGiven:Boolean, isRewardValidated:Boolean, isHighlighted:Boolean, data:*, quantity:int=-1):void
        {
            if (data !== null)
            {
                currentSubArray.push(new Reward(CAT_SMALL, achievementId, data.iconUri.toString(), isRewardGiven, isRewardValidated, isHighlighted, data, quantity));
            };
            if (isRewardValidated)
            {
                this._obtainedRewards++;
            };
            this._rewardsNumber++;
        }

        private function updateAchievementData():void
        {
            var tempArray:Array;
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
            this.gd_progress.dataProvider = this._achievements;
            var maxHeight:uint = 1;
            for each (tempArray in this.gd_progress.dataProvider)
            {
                if (tempArray.length > maxHeight)
                {
                    maxHeight = tempArray.length;
                };
            };
            this.gd_progress.height = ((maxHeight * LINE_HEIGHT_AND_VERTICAL_PADDING) + 15);
        }

        private function updateAchievementArrowButtons():void
        {
            this.btn_nextAchievements.visible = (this.gd_progress.firstItemDisplayedIndex < (this._achievements.length - GRID_COLUMNS));
            this.btn_previousAchievements.visible = (this.gd_progress.firstItemDisplayedIndex > 0);
        }

        private function turnPage(isNext:Boolean):void
        {
            var newIndex:Number;
            if (isNext)
            {
                newIndex = (this.gd_progress.firstItemDisplayedIndex + PAGE_PACE);
            }
            else
            {
                newIndex = (this.gd_progress.firstItemDisplayedIndex - PAGE_PACE);
            };
            this.gd_progress.moveTo(newIndex, true);
            this.updateAchievementArrowButtons();
        }

        private function getAllRewards():void
        {
            var achievementId:uint;
            if (this._rewardableAchievements === null)
            {
                return;
            };
            for each (achievementId in this._rewardableAchievements)
            {
                this.getRewards(achievementId);
            };
        }

        private function getRewards(achievementId:int):void
        {
            this.systemApi.sendAction(new AchievementRewardRequest(achievementId));
        }

        private function locateScrollMagicWorkshop():void
        {
            var scrollMagicWorkshopPosition:Point;
            if (SCROLL_MAGIC_WORKSHOP_POSITION !== null)
            {
                scrollMagicWorkshopPosition = SCROLL_MAGIC_WORKSHOP_POSITION;
            }
            else
            {
                scrollMagicWorkshopPosition = new Point(0, 0);
            };
            this.systemApi.dispatchHook(AddMapFlag, "flag_chat", (((((this.uiApi.getText("ui.temporis.scrollMagicWorkshop") + " (") + scrollMagicWorkshopPosition.x) + ",") + scrollMagicWorkshopPosition.y) + ")"), 1, scrollMagicWorkshopPosition.x, scrollMagicWorkshopPosition.y, 15636787, true);
        }

        public function onRollOver(target:Object):void
        {
            var itemData:*;
            var tooltipText:String;
            var tooltipPosition:Object;
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
            if (((!(target.name.indexOf("tx_reward") === -1)) && (target.name in this._componentsDictionary)))
            {
                itemData = this._componentsDictionary[target.name];
                tooltipText = null;
                tooltipPosition = {
                    "point":LocationEnum.POINT_TOP,
                    "relativePoint":LocationEnum.POINT_BOTTOM
                };
                if ((itemData is ItemWrapper))
                {
                    this.uiApi.showTooltip(itemData, target, false, STANDARD_TOOLTIP_UI_NAME, tooltipPosition.point, tooltipPosition.relativePoint, 0, "itemName", null, {
                        "showEffects":true,
                        "header":true
                    }, "ItemInfo");
                    return;
                };
                if ((itemData is EmoteWrapper))
                {
                    tooltipText = this.uiApi.getText("ui.common.emote", itemData.emote.name);
                }
                else
                {
                    if ((itemData is SpellWrapper))
                    {
                        tooltipText = this.uiApi.getText("ui.common.spell", itemData.spell.name);
                    }
                    else
                    {
                        if ((itemData is TitleWrapper))
                        {
                            tooltipText = this.uiApi.getText("ui.common.title", itemData.title.name);
                        }
                        else
                        {
                            if ((itemData is OrnamentWrapper))
                            {
                                tooltipText = this.uiApi.getText("ui.common.ornament", itemData.name);
                            };
                        };
                    };
                };
                if (tooltipText !== null)
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, TOOLTIP_UI_NAME, tooltipPosition.point, tooltipPosition.relativePoint, 0, null, null, null, "TextInfo");
                };
            }
            else
            {
                if (target === this.btn_locateScrollMagicWorkshop)
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.temporis.locateScrollMagicWorkshop")), target, false, TOOLTIP_UI_NAME, LocationEnum.POINT_TOP, LocationEnum.POINT_BOTTOM, 0, null, null, null, "TextInfo");
                };
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_nextAchievements:
                case this.btn_previousAchievements:
                    this.turnPage((target === this.btn_nextAchievements));
                    break;
                case this.btn_seeRanking:
                    this.seeRanking();
                    break;
                case this.btn_getAllRewards:
                    this.getAllRewards();
                    break;
                case this.btn_locateScrollMagicWorkshop:
                    this.locateScrollMagicWorkshop();
                    break;
                default:
                    if (target.id.indexOf("btn_getReward") !== -1)
                    {
                        this.getRewards(target.value);
                    };
            };
        }

        private function onAchievementFinished(finishedAchievement:AchievementAchieved):void
        {
            var rewardUi:UiRootContainer = this.uiApi.getUi(UIEnum.REWARDS);
            if (((!(rewardUi === null)) && (!(this.playedCharacterApi.isInFight()))))
            {
                rewardUi.uiClass.onRewardableAchievementsVisible();
            };
            this.refreshAchievements();
        }

        public function onAchievementRewardSuccess(achievementId:int):void
        {
            var rewardUi:UiRootContainer = this.uiApi.getUi(UIEnum.REWARDS);
            if (rewardUi !== null)
            {
                rewardUi.uiClass.onAchievementRewardSuccess();
            };
            this.refreshAchievements();
        }

        private function onLocatePorisAssistant():void
        {
            var porisAssistantPosition:Point;
            if (PORIS_ASSISTANT_POSITION !== null)
            {
                porisAssistantPosition = PORIS_ASSISTANT_POSITION;
            }
            else
            {
                porisAssistantPosition = new Point(0, 0);
            };
            this.systemApi.dispatchHook(AddMapFlag, "flag_chat", (((((this.uiApi.getText("ui.temporis.porisAssistant") + " (") + porisAssistantPosition.x) + ",") + porisAssistantPosition.y) + ")"), 1, porisAssistantPosition.x, porisAssistantPosition.y, 15636787, true);
        }

        public function onUiLoaded(name:String):void
        {
            if (name === "subQuestUi")
            {
                setTimeout(function ():void
                {
                    gd_progress.moveTo(_currentProgressBarIndex, true);
                }, 100);
            };
        }


    }
} Ankama_Grimoire.ui.temporis

import Ankama_Grimoire.ui.temporis.TemporisQuestTab;

class GridData 
{

    protected var _cat:uint;
    protected var _highlighted:Boolean;


    public function get cat():uint
    {
        return (this._cat);
    }

    public function get highlighted():Boolean
    {
        return (this._highlighted);
    }


}

class Top extends GridData 
{

    public var tempotonAmount:Number = 0;
    public var nameExtension:String;
    public var previousStepType:String;
    public var currentStepType:String;
    public var index:uint = 0;

    public function Top(index:uint, tempotonAmount:Number, highlighted:Boolean, currentStepType:String, previousStepType:String)
    {
        if (((!(isNaN(tempotonAmount))) && (tempotonAmount >= 0)))
        {
            this.tempotonAmount = tempotonAmount;
        };
        _cat = TemporisQuestTab.CAT_TOP;
        _highlighted = highlighted;
        this.previousStepType = previousStepType;
        this.currentStepType = currentStepType;
        this.index = index;
    }

}

class Reward extends GridData 
{

    public var txUri:String;
    public var rewardGiven:Boolean;
    public var rewardValidated:Boolean;
    public var nameExtension:String;
    public var quantity:int;
    public var achievementId:int;
    public var data:*;

    public function Reward(cat:uint, achievementId:int, txUri:String, rewardGiven:Boolean, rewardValidated:Boolean, highlighted:Boolean, data:*, quantity:int=-1)
    {
        _cat = cat;
        this.achievementId = achievementId;
        this.txUri = txUri;
        this.rewardGiven = rewardGiven;
        this.rewardValidated = rewardValidated;
        this.quantity = quantity;
        this.data = data;
        _highlighted = highlighted;
    }

}


