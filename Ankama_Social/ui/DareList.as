package Ankama_Social.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.internalDatacenter.dare.DareWrapper;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import d2hooks.DareListUpdated;
    import d2hooks.DareUpdated;
    import d2hooks.OpenDareSearch;
    import d2hooks.KeyUp;
    import d2enums.ComponentHookList;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
    import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
    import com.ankamagames.dofus.network.enums.DareCriteriaTypeEnum;
    import d2actions.DareCancelRequest;
    import d2actions.DareSubscribeRequest;
    import flash.ui.Keyboard;
    import d2hooks.MouseShiftClick;
    import d2actions.DareInformationsRequest;
    import com.ankamagames.dofus.types.enums.DareSubscribeErrorEnum;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;
    import d2hooks.*;
    import d2actions.*;

    public class DareList 
    {

        private static var _onlyShowIfSubscribable:Boolean = true;
        private static var _onlyShowIfFightable:Boolean = true;
        private static var CTR_GRID_DARE:String = "ctr_dare";
        private static var CTR_GRID_DETAILS:String = "ctr_details";
        public static const SEARCH_FILTER_ID:String = "searchFilterId";
        public static const SEARCH_FILTER_CREATOR:String = "searchFilterCreator";
        public static const SEARCH_FILTER_MONSTER:String = "searchFilterMonster";
        public static const SEARCH_FILTER_CRITERIA:String = "searchFilterCriteria";
        public static const SEARCH_FILTER_SUBAREA:String = "searchFilterSubArea";
        public static const SEARCH_FILTER_GUILD:String = "searchFilterGuild";
        public static const SEARCH_FILTER_ALLIANCE:String = "searchFilterAlliance";

        private const DARE_COMPLETE_LIST:int = 0;
        private const DARE_CREATION_LIST:int = 2;
        private const DARE_SUBSCRIBE_LIST:int = 3;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var _emblemsPath:String;
        private var _criteriaTypePath:String;
        private var _monsterSpritePath:String;
        private var _breedUri:String;
        private var _criteriaCtrY:int;
        private var _criteriaListLineX:int;
        private var _detailsRightCtrMinY:int;
        private var _propertyNameSort:String = "";
        private var _bDescendingSort:Boolean = false;
        private var _lockSearchTimer:Timer;
        private var _previousSearchCriteria:String;
        private var _searchCriteria:String;
        private var _searchFilterTexts:Dictionary = new Dictionary(true);
        private var _searchFilterStates:Dictionary;
        private var _searchFilterStatesForced:Dictionary;
        private var _componentsList:Dictionary = new Dictionary(true);
        private var _currentListType:int;
        private var _currentTabName:String;
        private var _selectedDare:DareWrapper;
        private var _popupDareId:Number;
        private var _currentScrollValue:int;
        private var _currentDaresList:Array;
        private var _hiddenDaresIds:Dictionary = new Dictionary(true);
        private var _breedGfxIdById:Array;
        public var lbl_noResult:Label;
        public var gd_list:Grid;
        public var btn_onlyShowIfSubscribable:ButtonContainer;
        public var btn_onlyShowIfFightable:ButtonContainer;
        public var lbl_daresCount:Label;
        public var inp_search:Input;
        public var tx_inputBg_search:TextureBitmap;
        public var btn_resetSearch:ButtonContainer;
        public var btn_searchFilter:ButtonContainer;
        public var btn_tabMonster:ButtonContainer;
        public var btn_tabJackpot:ButtonContainer;
        public var btn_tabFee:ButtonContainer;
        public var btn_tabWinners:ButtonContainer;
        public var btn_tabDuration:ButtonContainer;


        public function get currentTabName():String
        {
            return (this._currentTabName);
        }

        public function set currentTabName(value:String):void
        {
            this._currentTabName = value;
        }

        public function main(... params):void
        {
            var b:Breed;
            var hiddenDares:Array;
            var idAndDate:String;
            var id:Number;
            this.sysApi.addHook(DareListUpdated, this.onDareListUpdated);
            this.sysApi.addHook(DareUpdated, this.onDareUpdated);
            this.sysApi.addHook(OpenDareSearch, this.onOpenDareSearch);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.uiApi.addComponentHook(this.btn_onlyShowIfSubscribable, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_onlyShowIfFightable, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.gd_list, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_onlyShowIfSubscribable, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_onlyShowIfSubscribable, ComponentHookList.ON_ROLL_OUT);
            this._emblemsPath = this.uiApi.me().getConstant("emblems_uri");
            this._criteriaTypePath = this.uiApi.me().getConstant("criteriaType_uri");
            this._monsterSpritePath = this.uiApi.me().getConstant("monsterSprite_uri");
            this._breedUri = this.uiApi.me().getConstant("heads_uri");
            this._criteriaCtrY = this.uiApi.me().getConstant("criteriaCtrY");
            this._criteriaListLineX = this.uiApi.me().getConstant("criteriaListLineX");
            this._detailsRightCtrMinY = this.uiApi.me().getConstant("detailsRightCtrY");
            this._lockSearchTimer = new Timer(500, 1);
            this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            this._searchFilterTexts[SEARCH_FILTER_ID] = this.uiApi.getText("ui.dare.id");
            this._searchFilterTexts[SEARCH_FILTER_CREATOR] = this.uiApi.getText("ui.dare.creator");
            this._searchFilterTexts[SEARCH_FILTER_MONSTER] = this.uiApi.getText("ui.dare.target");
            this._searchFilterTexts[SEARCH_FILTER_CRITERIA] = this.uiApi.getText("ui.dare.criteria");
            this._searchFilterTexts[SEARCH_FILTER_SUBAREA] = this.uiApi.getText("ui.map.subarea");
            this._searchFilterTexts[SEARCH_FILTER_GUILD] = this.uiApi.getText("ui.common.guild");
            this._searchFilterTexts[SEARCH_FILTER_ALLIANCE] = this.uiApi.getText("ui.common.alliance");
            this._searchFilterStates = Dare.getInstance().searchFilterStates;
            this._propertyNameSort = "jackpot";
            this.btn_onlyShowIfSubscribable.selected = _onlyShowIfSubscribable;
            this.btn_onlyShowIfFightable.selected = _onlyShowIfFightable;
            this._breedGfxIdById = new Array();
            var breeds:Object = this.dataApi.getBreeds();
            for each (b in breeds)
            {
                this._breedGfxIdById[b.id] = ((b.id + "") + (b.id % 2));
            };
            this._currentListType = params[0][0];
            this.currentTabName = this.getButtonByTab(this._currentListType);
            hiddenDares = this.sysApi.getData("HiddenDaresIds");
            for each (idAndDate in hiddenDares)
            {
                id = Number(idAndDate.split("_")[0]);
                this._hiddenDaresIds[id] = true;
            };
            if (params[0][1])
            {
                this.onOpenDareSearch(params[0][1][0], params[0][1][1], false);
            };
            this.onDareListUpdated();
        }

        public function unload():void
        {
            if (this._lockSearchTimer)
            {
                this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
                this._lockSearchTimer.stop();
                this._lockSearchTimer = null;
            };
        }

        private function getButtonByTab(tab:uint):String
        {
            if (tab == 0)
            {
                return ("btn_totalList");
            };
            if (tab == 2)
            {
                return ("btn_mineList");
            };
            if (tab == 3)
            {
                return ("btn_successList");
            };
            return (null);
        }

        public function updateDareLine(data:*, components:*, selected:Boolean, line:uint):void
        {
            var criteriaWithoutMonster:Array;
            var c:Object;
            var now:Date;
            var backEmblem:EmblemWrapper;
            var upEmblem:EmblemWrapper;
            var icon:EmblemSymbol;
            var remainingTime:Number;
            var delay:Number;
            now = new Date();
            if (!this._componentsList[components.lbl_duration.name])
            {
                this.uiApi.addComponentHook(components.lbl_duration, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.lbl_duration, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[components.lbl_duration.name] = data;
            if (!this._componentsList[components.ctr_guildalliance.name])
            {
                this.uiApi.addComponentHook(components.ctr_guildalliance, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.ctr_guildalliance, ComponentHookList.ON_ROLL_OUT);
                this.uiApi.addComponentHook(components.ctr_guildalliance, ComponentHookList.ON_RELEASE);
            };
            this._componentsList[components.ctr_guildalliance.name] = data;
            if (!this._componentsList[components.btn_visible.name])
            {
                this.uiApi.addComponentHook(components.btn_visible, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_visible, ComponentHookList.ON_ROLL_OUT);
                this.uiApi.addComponentHook(components.btn_visible, ComponentHookList.ON_RELEASE);
            };
            this._componentsList[components.btn_visible.name] = data;
            if (!this._componentsList[components.ctr_dareLine.name])
            {
                this.uiApi.addComponentHook(components.ctr_dareLine, ComponentHookList.ON_RELEASE);
            };
            this._componentsList[components.ctr_dareLine.name] = data;
            if (!this._componentsList[components.gd_criteriaTxList.name])
            {
                this.uiApi.addComponentHook(components.gd_criteriaTxList, ComponentHookList.ON_RELEASE);
            };
            this._componentsList[components.gd_criteriaTxList.name] = data;
            components.ctr_dareLine.handCursor = true;
            components.tx_sprite.uri = this.uiApi.createUri(((this._monsterSpritePath + data.monster.id) + ".png"));
            components.lbl_monster.text = data.monster.name;
            components.lbl_jackpot.text = data.jackpotString;
            components.lbl_fee.text = data.subscriptionFeeString;
            components.tx_k1.visible = true;
            components.tx_k2.visible = true;
            if (data.won)
            {
                components.ctr_bg.bgColor = this.sysApi.getConfigEntry("colors.multigrid.selected");
            }
            else
            {
                components.ctr_bg.bgColor = this.sysApi.getConfigEntry("colors.multigrid.line");
            };
            if (data.maxCountWinners > 0)
            {
                components.lbl_winners.text = ((data.countWinners + " / ") + data.maxCountWinners);
            }
            else
            {
                components.lbl_winners.text = data.countWinners;
            };
            if (data.endDate > now.time)
            {
                components.lbl_duration.text = this.timeApi.getShortDuration((data.endDate - ((data.startDate > now.time) ? data.startDate : now.time)));
            }
            else
            {
                components.lbl_duration.text = this.uiApi.getText("ui.dare.time.over");
            };
            if (!this._hiddenDaresIds[data.dareId])
            {
                components.btn_visible.selected = false;
            }
            else
            {
                components.btn_visible.selected = true;
            };
            if (((data.alliance) || (data.guild)))
            {
                if (data.allianceId > 0)
                {
                    backEmblem = data.alliance.backEmblem;
                    upEmblem = data.alliance.upEmblem;
                }
                else
                {
                    backEmblem = data.guild.backEmblem;
                    upEmblem = data.guild.upEmblem;
                };
                components.tx_emblemBack.uri = backEmblem.iconUri;
                components.tx_emblemUp.uri = upEmblem.iconUri;
                this.utilApi.changeColor(components.tx_emblemBack, backEmblem.color, 1);
                icon = this.dataApi.getEmblemSymbol(upEmblem.idEmblem);
                if (icon.colorizable)
                {
                    this.utilApi.changeColor(components.tx_emblemUp, upEmblem.color, 0);
                }
                else
                {
                    this.utilApi.changeColor(components.tx_emblemUp, upEmblem.color, 0, true);
                };
                components.ctr_guildalliance.x = this._criteriaListLineX;
                components.ctr_guildalliance.visible = true;
                components.gd_criteriaTxList.x = (this._criteriaListLineX + components.ctr_guildalliance.width);
            }
            else
            {
                components.ctr_guildalliance.visible = false;
                components.gd_criteriaTxList.x = this._criteriaListLineX;
            };
            criteriaWithoutMonster = new Array();
            for each (c in data.criteria)
            {
                criteriaWithoutMonster.push(c);
            };
            if (criteriaWithoutMonster.length > 1)
            {
                components.gd_criteriaTxList.dataProvider = criteriaWithoutMonster.slice(1);
                components.gd_criteriaTxList.visible = true;
            }
            else
            {
                components.gd_criteriaTxList.visible = false;
            };
            switch (this.getDareLineType(data, line))
            {
                case CTR_GRID_DETAILS:
                    if (!this._componentsList[components.tx_private.name])
                    {
                        this.uiApi.addComponentHook(components.tx_private, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(components.tx_private, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._componentsList[components.tx_private.name] = data;
                    if (!this._componentsList[components.btn_subscribe.name])
                    {
                        this.uiApi.addComponentHook(components.btn_subscribe, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(components.btn_subscribe, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._componentsList[components.btn_subscribe.name] = data;
                    if (!this._componentsList[components.btn_web.name])
                    {
                        this.uiApi.addComponentHook(components.btn_web, ComponentHookList.ON_RELEASE);
                        this.uiApi.addComponentHook(components.btn_web, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(components.btn_web, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._componentsList[components.btn_web.name] = data;
                    if (!this._componentsList[components.lbl_realDuration.name])
                    {
                        this.uiApi.addComponentHook(components.lbl_realDuration, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(components.lbl_realDuration, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._componentsList[components.lbl_realDuration.name] = data;
                    components.lbl_creator.text = this.uiApi.getText("ui.dare.createdBy", (((((("{player," + data.creatorName) + ",") + data.creatorId) + "::") + data.creatorName) + "}"));
                    if (data.isPrivate)
                    {
                        components.tx_private.visible = true;
                    }
                    else
                    {
                        components.tx_private.visible = false;
                    };
                    if (data.isMyCreation)
                    {
                        components.btn_lbl_btn_subscribe.text = this.uiApi.getText("ui.popup.delete");
                        if (data.countEntrants == 0)
                        {
                            components.btn_subscribe.softDisabled = false;
                        }
                        else
                        {
                            components.btn_subscribe.softDisabled = true;
                        };
                    }
                    else
                    {
                        if (data.subscribed)
                        {
                            components.btn_lbl_btn_subscribe.text = this.uiApi.getText("ui.dare.unregister");
                            if (!data.won)
                            {
                                components.btn_subscribe.softDisabled = false;
                            }
                            else
                            {
                                components.btn_subscribe.softDisabled = true;
                            };
                        }
                        else
                        {
                            components.btn_lbl_btn_subscribe.text = this.uiApi.getText("ui.dare.register");
                            if (data.subscribable)
                            {
                                components.btn_subscribe.softDisabled = false;
                            }
                            else
                            {
                                components.btn_subscribe.softDisabled = true;
                            };
                        };
                    };
                    if ((data.endDate - now.time) < 0)
                    {
                        components.btn_subscribe.softDisabled = true;
                    };
                    components.btn_subscribe.visible = true;
                    components.lbl_entrants.text = this.uiApi.processText(this.uiApi.getText("ui.dare.currentEntrants", data.countEntrants), "n", (data.countEntrants <= 1), (data.countEntrants == 0));
                    components.lbl_realDuration.text = ((this.uiApi.getText("ui.fightend.duration") + this.uiApi.getText("ui.common.colon")) + this.timeApi.getDuration((data.endDate - data.startDate)));
                    remainingTime = (data.endDate - now.time);
                    if (remainingTime < 0)
                    {
                        components.lbl_remainingTime.text = this.uiApi.getText("ui.dare.time.over");
                    }
                    else
                    {
                        delay = (data.startDate - now.time);
                        if (delay > 0)
                        {
                            components.lbl_remainingTime.text = this.uiApi.getText("ui.dare.time.beginIn", this.timeApi.getDuration(delay));
                        }
                        else
                        {
                            components.lbl_remainingTime.text = this.uiApi.getText("ui.dare.time.endIn", this.timeApi.getDuration(remainingTime));
                        };
                    };
                    criteriaWithoutMonster = new Array();
                    for each (c in data.criteria)
                    {
                        criteriaWithoutMonster.push(c);
                    };
                    if (criteriaWithoutMonster.length > 1)
                    {
                        components.lbl_noCriteria.visible = false;
                        components.gd_listCrit.height = ((data.criteria.length - 1) * components.gd_listCrit.slotHeight);
                        components.gd_listCrit.dataProvider = criteriaWithoutMonster.slice(1);
                    }
                    else
                    {
                        components.gd_listCrit.height = (1 * components.gd_listCrit.slotHeight);
                        components.gd_listCrit.dataProvider = new Array();
                        components.lbl_noCriteria.visible = true;
                    };
                    break;
                case CTR_GRID_DARE:
                    break;
            };
        }

        public function getDareLineType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("");
            };
            if ((((data) && (this._selectedDare)) && (data.dareId == this._selectedDare.dareId)))
            {
                return (CTR_GRID_DETAILS);
            };
            return (CTR_GRID_DARE);
        }

        public function getDareDataLength(data:*, selected:Boolean):*
        {
            if (selected)
            {
                return (9);
            };
            return (3);
        }

        public function updateCritLine(data:*, components:*, selected:Boolean):void
        {
            if (data != null)
            {
                components.tx_iconCrit.uri = this.uiApi.createUri((((this._criteriaTypePath + "") + data.type) + "_normal.png"));
                components.lbl_nameCrit.text = (data.name + this.uiApi.getText("ui.common.colon"));
                if (data.type == DareCriteriaTypeEnum.CHALLENGE_ID)
                {
                    components.gd_slotsCrit.visible = true;
                    components.gd_dataCrit.visible = false;
                    components.lbl_valueCrit.visible = false;
                    components.gd_slotsCrit.width = ((components.gd_slotsCrit.slotWidth * data.paramsData.length) + ((data.paramsData.length - 1) * 5));
                    components.gd_slotsCrit.dataProvider = data.paramsData;
                }
                else
                {
                    if (data.type == DareCriteriaTypeEnum.IDOLS)
                    {
                        components.gd_slotsCrit.visible = true;
                        components.gd_dataCrit.visible = false;
                        components.lbl_valueCrit.visible = false;
                        components.gd_slotsCrit.width = ((components.gd_slotsCrit.slotWidth * data.paramsData.length) + ((data.paramsData.length - 1) * 5));
                        components.gd_slotsCrit.dataProvider = data.paramsData;
                    }
                    else
                    {
                        if (((data.type == DareCriteriaTypeEnum.FORBIDDEN_BREEDS) || (data.type == DareCriteriaTypeEnum.MANDATORY_BREEDS)))
                        {
                            components.gd_slotsCrit.visible = false;
                            components.gd_dataCrit.visible = true;
                            components.lbl_valueCrit.visible = false;
                            components.gd_dataCrit.dataProvider = data.paramsData;
                        }
                        else
                        {
                            components.gd_slotsCrit.visible = false;
                            components.gd_dataCrit.visible = false;
                            components.lbl_valueCrit.visible = true;
                            components.lbl_valueCrit.text = data.params[0];
                        };
                    };
                };
            }
            else
            {
                components.tx_iconCrit.uri = null;
                components.lbl_nameCrit.text = "";
                components.lbl_valueCrit.text = "";
                components.gd_slotsCrit.visible = false;
                components.gd_dataCrit.visible = false;
            };
        }

        public function updateDareCriteriaTxLine(data:*, components:*, selected:Boolean):void
        {
            if (!this._componentsList[components.tx_criteria.name])
            {
                this.uiApi.addComponentHook(components.tx_criteria, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.tx_criteria, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[components.tx_criteria.name] = data;
            if (data != null)
            {
                components.tx_criteria.uri = this.uiApi.createUri((((this._criteriaTypePath + "") + data.type) + "_normal.png"));
            }
            else
            {
                components.tx_criteria.uri = null;
            };
        }

        public function updateBreed(data:*, componentsRef:*, selected:Boolean):void
        {
            var gender:int;
            if (!this._componentsList[componentsRef.ctr_breed.name])
            {
                this.uiApi.addComponentHook(componentsRef.ctr_breed, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.ctr_breed, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[componentsRef.ctr_breed.name] = data;
            if (data)
            {
                if (data.id > 0)
                {
                    gender = int(Math.round(Math.random()));
                    componentsRef.tx_breed.uri = this.uiApi.createUri((((this._breedUri + "") + this._breedGfxIdById[data.id]) + ".png"));
                    componentsRef.ctr_breed.visible = true;
                }
                else
                {
                    componentsRef.ctr_breed.visible = false;
                };
            }
            else
            {
                componentsRef.ctr_breed.visible = false;
            };
        }

        private function updateDareGrid():void
        {
            var dares:Object;
            var limitedByCheckboxList:Boolean;
            var dare:Object;
            if (this._currentListType == this.DARE_SUBSCRIBE_LIST)
            {
                limitedByCheckboxList = _onlyShowIfFightable;
            }
            else
            {
                limitedByCheckboxList = _onlyShowIfSubscribable;
            };
            if (this._searchFilterStatesForced)
            {
                dares = this.socialApi.getFilteredDareList(limitedByCheckboxList, (this._currentListType == this.DARE_CREATION_LIST), (this._currentListType == this.DARE_SUBSCRIBE_LIST), this._searchCriteria, this._searchFilterStatesForced[SEARCH_FILTER_ID], this._searchFilterStatesForced[SEARCH_FILTER_CREATOR], this._searchFilterStatesForced[SEARCH_FILTER_MONSTER], this._searchFilterStatesForced[SEARCH_FILTER_CRITERIA], this._searchFilterStatesForced[SEARCH_FILTER_SUBAREA], this._searchFilterStatesForced[SEARCH_FILTER_GUILD], this._searchFilterStatesForced[SEARCH_FILTER_ALLIANCE]);
            }
            else
            {
                dares = this.socialApi.getFilteredDareList(limitedByCheckboxList, (this._currentListType == this.DARE_CREATION_LIST), (this._currentListType == this.DARE_SUBSCRIBE_LIST), this._searchCriteria, this._searchFilterStates[SEARCH_FILTER_ID], this._searchFilterStates[SEARCH_FILTER_CREATOR], this._searchFilterStates[SEARCH_FILTER_MONSTER], this._searchFilterStates[SEARCH_FILTER_CRITERIA], this._searchFilterStates[SEARCH_FILTER_SUBAREA], this._searchFilterStates[SEARCH_FILTER_GUILD], this._searchFilterStates[SEARCH_FILTER_ALLIANCE]);
            };
            this._currentDaresList = new Array();
            for each (dare in dares)
            {
                this._currentDaresList.push(dare);
            };
            if (dares.length > 0)
            {
                this.prepareDareList();
                this.lbl_noResult.visible = false;
                this.gd_list.visible = true;
                this.lbl_daresCount.text = this.uiApi.processText(this.uiApi.getText("ui.dare.dareCount", dares.length), "", (dares.length == 1), (dares.length == 0));
            }
            else
            {
                this.lbl_noResult.visible = true;
                this.gd_list.visible = false;
                this.lbl_noResult.text = this.uiApi.getText("ui.search.noResult");
                this.lbl_daresCount.text = "";
            };
        }

        private function prepareDareList():void
        {
            var dare:DareWrapper;
            var daresTemp:Array = new Array();
            if (this._propertyNameSort == "monsterName")
            {
                if (this._bDescendingSort)
                {
                    this._currentDaresList.sortOn([this._propertyNameSort, "dareId"], [Array.CASEINSENSITIVE, Array.NUMERIC]);
                }
                else
                {
                    this._currentDaresList.sortOn([this._propertyNameSort, "dareId"], [(Array.CASEINSENSITIVE | Array.DESCENDING), (Array.NUMERIC | Array.DESCENDING)]);
                };
            }
            else
            {
                if (((((this._propertyNameSort == "jackpot") || (this._propertyNameSort == "subscriptionFee")) || (this._propertyNameSort == "countWinners")) || (this._propertyNameSort == "endDate")))
                {
                    if (this._bDescendingSort)
                    {
                        this._currentDaresList.sortOn([this._propertyNameSort, "dareId"], [Array.NUMERIC, Array.NUMERIC]);
                    }
                    else
                    {
                        this._currentDaresList.sortOn([this._propertyNameSort, "dareId"], [(Array.NUMERIC | Array.DESCENDING), (Array.NUMERIC | Array.DESCENDING)]);
                    };
                };
            };
            for each (dare in this._currentDaresList)
            {
                daresTemp.push(dare);
                daresTemp.push(null);
                daresTemp.push(null);
                if ((((this._selectedDare) && (dare)) && (dare.dareId == this._selectedDare.dareId)))
                {
                    daresTemp.push(null);
                    daresTemp.push(null);
                    daresTemp.push(null);
                    daresTemp.push(null);
                    daresTemp.push(null);
                    daresTemp.push(null);
                };
            };
            this.gd_list.dataProvider = daresTemp;
            this.gd_list.verticalScrollValue = this._currentScrollValue;
        }

        private function onConfirmCancelDare():void
        {
            this.sysApi.sendAction(new DareCancelRequest(this._popupDareId));
        }

        private function onConfirmSubscribeDare():void
        {
            this.sysApi.sendAction(new DareSubscribeRequest(this._popupDareId, true));
        }

        private function onConfirmUnsubscribeDare():void
        {
            this.sysApi.sendAction(new DareSubscribeRequest(this._popupDareId, false));
        }

        private function onCancel():void
        {
        }

        private function changeSearchFilter(filterId:String):void
        {
            this._searchFilterStates[filterId] = (!(this._searchFilterStates[filterId]));
            this.toggleInputSearch();
            if (((this._searchCriteria) && (!(this._searchCriteria == ""))))
            {
                this.updateDareGrid();
            };
        }

        private function toggleInputSearch():void
        {
            if ((((((((!(this._searchFilterStates[SEARCH_FILTER_ID])) && (!(this._searchFilterStates[SEARCH_FILTER_CREATOR]))) && (!(this._searchFilterStates[SEARCH_FILTER_MONSTER]))) && (!(this._searchFilterStates[SEARCH_FILTER_CRITERIA]))) && (!(this._searchFilterStates[SEARCH_FILTER_SUBAREA]))) && (!(this._searchFilterStates[SEARCH_FILTER_GUILD]))) && (!(this._searchFilterStates[SEARCH_FILTER_ALLIANCE]))))
            {
                this.inp_search.visible = false;
                this.tx_inputBg_search.disabled = true;
            }
            else
            {
                this.inp_search.visible = true;
                this.tx_inputBg_search.disabled = false;
            };
        }

        private function hideDares(dares:Array, hide:Boolean=true):void
        {
            var dare:DareWrapper;
            var ids:Array;
            var idDate:String;
            var index:int;
            var oldHiddenIds:Array = this.sysApi.getData("HiddenDaresIds");
            if (hide)
            {
                if (!oldHiddenIds)
                {
                    oldHiddenIds = new Array();
                };
                for each (dare in dares)
                {
                    this._hiddenDaresIds[dare.dareId] = true;
                    oldHiddenIds.push(((dare.dareId + "_") + dare.endDate));
                };
            }
            else
            {
                ids = new Array();
                for each (idDate in oldHiddenIds)
                {
                    ids.push(Number(idDate.split("_")[0]));
                };
                for each (dare in dares)
                {
                    delete this._hiddenDaresIds[dare.dareId];
                    index = ids.indexOf(dare.dareId);
                    if (index > -1)
                    {
                        oldHiddenIds.splice(index, 1);
                    };
                };
            };
            this.sysApi.setData("HiddenDaresIds", oldHiddenIds);
        }

        public function onSelectItem(target:Object, method:uint, isNew:Boolean):void
        {
        }

        public function showTabHints():void
        {
            this.hintsApi.showSubHints(this.currentTabName);
        }

        public function onRelease(target:Object):void
        {
            var contextMenu:Array;
            var data:DareWrapper;
            var data2:DareWrapper;
            var index:int;
            var i:*;
            var currentScroll:int;
            if (target == this.btn_onlyShowIfSubscribable)
            {
                _onlyShowIfSubscribable = this.btn_onlyShowIfSubscribable.selected;
                this.updateDareGrid();
            }
            else
            {
                if (target == this.btn_onlyShowIfFightable)
                {
                    _onlyShowIfFightable = this.btn_onlyShowIfFightable.selected;
                    this.updateDareGrid();
                }
                else
                {
                    if (target == this.btn_tabMonster)
                    {
                        if (this._propertyNameSort == "monsterName")
                        {
                            this._bDescendingSort = (!(this._bDescendingSort));
                        }
                        else
                        {
                            this._propertyNameSort = "monsterName";
                        };
                        this.prepareDareList();
                    }
                    else
                    {
                        if (target == this.btn_tabJackpot)
                        {
                            if (this._propertyNameSort == "jackpot")
                            {
                                this._bDescendingSort = (!(this._bDescendingSort));
                            }
                            else
                            {
                                this._propertyNameSort = "jackpot";
                            };
                            this.prepareDareList();
                        }
                        else
                        {
                            if (target == this.btn_tabFee)
                            {
                                if (this._propertyNameSort == "subscriptionFee")
                                {
                                    this._bDescendingSort = (!(this._bDescendingSort));
                                }
                                else
                                {
                                    this._propertyNameSort = "subscriptionFee";
                                };
                                this.prepareDareList();
                            }
                            else
                            {
                                if (target == this.btn_tabWinners)
                                {
                                    if (this._propertyNameSort == "countWinners")
                                    {
                                        this._bDescendingSort = (!(this._bDescendingSort));
                                    }
                                    else
                                    {
                                        this._propertyNameSort = "countWinners";
                                    };
                                    this.prepareDareList();
                                }
                                else
                                {
                                    if (target == this.btn_tabDuration)
                                    {
                                        if (this._propertyNameSort == "endDate")
                                        {
                                            this._bDescendingSort = (!(this._bDescendingSort));
                                        }
                                        else
                                        {
                                            this._propertyNameSort = "endDate";
                                        };
                                        this.prepareDareList();
                                    }
                                    else
                                    {
                                        if (target == this.btn_resetSearch)
                                        {
                                            this._searchCriteria = null;
                                            this.inp_search.text = "";
                                            this._searchFilterStatesForced = null;
                                            this.updateDareGrid();
                                        }
                                        else
                                        {
                                            if (target == this.btn_searchFilter)
                                            {
                                                contextMenu = new Array();
                                                contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.search.criteria")));
                                                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchFilterTexts[SEARCH_FILTER_ID], this.changeSearchFilter, [SEARCH_FILTER_ID], false, null, this._searchFilterStates[SEARCH_FILTER_ID], false));
                                                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchFilterTexts[SEARCH_FILTER_CREATOR], this.changeSearchFilter, [SEARCH_FILTER_CREATOR], false, null, this._searchFilterStates[SEARCH_FILTER_CREATOR], false));
                                                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchFilterTexts[SEARCH_FILTER_MONSTER], this.changeSearchFilter, [SEARCH_FILTER_MONSTER], false, null, this._searchFilterStates[SEARCH_FILTER_MONSTER], false));
                                                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchFilterTexts[SEARCH_FILTER_CRITERIA], this.changeSearchFilter, [SEARCH_FILTER_CRITERIA], false, null, this._searchFilterStates[SEARCH_FILTER_CRITERIA], false));
                                                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchFilterTexts[SEARCH_FILTER_SUBAREA], this.changeSearchFilter, [SEARCH_FILTER_SUBAREA], false, null, this._searchFilterStates[SEARCH_FILTER_SUBAREA], false));
                                                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchFilterTexts[SEARCH_FILTER_GUILD], this.changeSearchFilter, [SEARCH_FILTER_GUILD], false, null, this._searchFilterStates[SEARCH_FILTER_GUILD], false));
                                                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchFilterTexts[SEARCH_FILTER_ALLIANCE], this.changeSearchFilter, [SEARCH_FILTER_ALLIANCE], false, null, this._searchFilterStates[SEARCH_FILTER_ALLIANCE], false));
                                                this.modContextMenu.createContextMenu(contextMenu);
                                            }
                                            else
                                            {
                                                if (target.name.indexOf("btn_web") != -1)
                                                {
                                                    this.sysApi.goToDare(this._selectedDare);
                                                }
                                                else
                                                {
                                                    if ((((!(target.name.indexOf("ctr_dareLine") == -1)) || (!(target.name.indexOf("gd_criteriaTxList") == -1))) || (!(target.name.indexOf("ctr_guildalliance") == -1))))
                                                    {
                                                        data = this._componentsList[target.name];
                                                        if (this.uiApi.keyIsDown(Keyboard.SHIFT))
                                                        {
                                                            this.sysApi.dispatchHook(MouseShiftClick, {"data":data});
                                                            return;
                                                        };
                                                        if (((!(this._selectedDare)) || ((data) && (!(this._selectedDare.dareId == data.dareId)))))
                                                        {
                                                            this._currentScrollValue = this.gd_list.verticalScrollValue;
                                                            this._selectedDare = data;
                                                            this.sysApi.sendAction(new DareInformationsRequest(data.dareId));
                                                            this.prepareDareList();
                                                        }
                                                        else
                                                        {
                                                            this._currentScrollValue = this.gd_list.verticalScrollValue;
                                                            this._selectedDare = null;
                                                            this.prepareDareList();
                                                        };
                                                    }
                                                    else
                                                    {
                                                        if (target.name.indexOf("btn_visible") != -1)
                                                        {
                                                            data2 = this._componentsList[target.name];
                                                            if (!this._hiddenDaresIds[data2.dareId])
                                                            {
                                                                this.hideDares([data2]);
                                                                if (((_onlyShowIfSubscribable) && (this._currentListType == this.DARE_COMPLETE_LIST)))
                                                                {
                                                                    currentScroll = this.gd_list.verticalScrollValue;
                                                                    this.updateDareGrid();
                                                                    this.gd_list.verticalScrollValue = currentScroll;
                                                                    return;
                                                                };
                                                            }
                                                            else
                                                            {
                                                                this.hideDares([data2], false);
                                                            };
                                                            this.uiApi.hideTooltip();
                                                            index = 0;
                                                            for (i in this.gd_list.dataProvider)
                                                            {
                                                                if (((this.gd_list.dataProvider[i]) && (this.gd_list.dataProvider[i].dareId == data2.dareId)))
                                                                {
                                                                    index = i;
                                                                };
                                                            };
                                                            this.gd_list.updateItem(index);
                                                        }
                                                        else
                                                        {
                                                            if (target.name.indexOf("btn_subscribe") != -1)
                                                            {
                                                                if (this._selectedDare.isMyCreation)
                                                                {
                                                                    this._popupDareId = this._selectedDare.dareId;
                                                                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.dare.cancelConfirm"), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmCancelDare, this.onCancel], this.onConfirmCancelDare, this.onCancel);
                                                                }
                                                                else
                                                                {
                                                                    if (!this._selectedDare.subscribed)
                                                                    {
                                                                        this._popupDareId = this._selectedDare.dareId;
                                                                        if (this._selectedDare.subscriptionFee > 0)
                                                                        {
                                                                            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.dare.subscribeConfirm", this._selectedDare.subscriptionFeeString), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmSubscribeDare, this.onCancel], this.onConfirmSubscribeDare, this.onCancel);
                                                                        }
                                                                        else
                                                                        {
                                                                            this.onConfirmSubscribeDare();
                                                                        };
                                                                    }
                                                                    else
                                                                    {
                                                                        this._popupDareId = this._selectedDare.dareId;
                                                                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.dare.unsubscribeConfirm"), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmUnsubscribeDare, this.onCancel], this.onConfirmUnsubscribeDare, this.onCancel);
                                                                    };
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var data:Object;
            var now:Date;
            var remainingTime:Number;
            var delay:Number;
            var now2:Date;
            var reason:int;
            var point:uint = 6;
            var relPoint:uint;
            if (target == this.btn_searchFilter)
            {
                tooltipText = this.uiApi.getText("ui.search.criteria");
            };
            if (target == this.btn_onlyShowIfSubscribable)
            {
                tooltipText = this.uiApi.getText("ui.dare.info.subscribable");
            }
            else
            {
                if (target.name.indexOf("lbl_duration") != -1)
                {
                    data = this._componentsList[target.name];
                    if (!data)
                    {
                        return;
                    };
                    now = new Date();
                    remainingTime = (data.endDate - now.time);
                    if (remainingTime > 0)
                    {
                        delay = (data.startDate - now.time);
                        if (delay > 0)
                        {
                            tooltipText = this.uiApi.getText("ui.dare.time.beginIn", this.timeApi.getDuration(delay));
                            tooltipText = (tooltipText + "\n");
                            tooltipText = (tooltipText + ((this.uiApi.getText("ui.fightend.duration") + this.uiApi.getText("ui.common.colon")) + this.timeApi.getDuration((data.endDate - data.startDate))));
                        }
                        else
                        {
                            tooltipText = this.uiApi.getText("ui.dare.time.endIn", this.timeApi.getDuration(remainingTime));
                        };
                    };
                }
                else
                {
                    if (target.name.indexOf("lbl_realDuration") != -1)
                    {
                        tooltipText = this.uiApi.getText("ui.dare.info.realduration");
                    }
                    else
                    {
                        if (target.name.indexOf("ctr_guildalliance") != -1)
                        {
                            data = this._componentsList[target.name];
                            if (!data)
                            {
                                return;
                            };
                            if (data.allianceId > 0)
                            {
                                tooltipText = this.uiApi.getText("ui.dare.info.alliance", data.alliance.allianceName);
                            }
                            else
                            {
                                if (data.guildId > 0)
                                {
                                    tooltipText = this.uiApi.getText("ui.dare.info.guild", data.guild.guildName);
                                };
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("btn_visible") != -1)
                            {
                                data = this._componentsList[target.name];
                                if (!data)
                                {
                                    return;
                                };
                                if (this._hiddenDaresIds[data.dareId])
                                {
                                    tooltipText = this.uiApi.getText("ui.dare.hiddenDare");
                                }
                                else
                                {
                                    tooltipText = this.uiApi.getText("ui.dare.visibleDare");
                                };
                            }
                            else
                            {
                                if (target.name.indexOf("tx_private") != -1)
                                {
                                    tooltipText = this.uiApi.getText("ui.dare.info.private");
                                }
                                else
                                {
                                    if (target.name.indexOf("btn_subscribe") != -1)
                                    {
                                        if (!this._selectedDare)
                                        {
                                            return;
                                        };
                                        now2 = new Date();
                                        if (this._selectedDare.endDate < now2.time)
                                        {
                                            tooltipText = this.uiApi.getText("ui.dare.info.dareTimeOver");
                                        }
                                        else
                                        {
                                            if (this._selectedDare.isMyCreation)
                                            {
                                                if (this._selectedDare.countEntrants == 0)
                                                {
                                                    tooltipText = this.uiApi.getText("ui.dare.info.cancelOk");
                                                }
                                                else
                                                {
                                                    tooltipText = this.uiApi.getText("ui.dare.info.cancelImpossible");
                                                };
                                            }
                                            else
                                            {
                                                if (this._selectedDare.subscribed)
                                                {
                                                    if (this._selectedDare.won)
                                                    {
                                                        tooltipText = this.uiApi.getText("ui.dare.info.unsubscribeAlreadyWon");
                                                    }
                                                    else
                                                    {
                                                        tooltipText = this.uiApi.getText("ui.dare.info.unsubscribeOk");
                                                    };
                                                }
                                                else
                                                {
                                                    if (!target.softDisabled)
                                                    {
                                                        tooltipText = this.uiApi.getText("ui.dare.info.subscribeOk");
                                                    }
                                                    else
                                                    {
                                                        tooltipText = (this.uiApi.getText("ui.dare.info.subscribeImpossible") + "\n");
                                                        for each (reason in this._selectedDare.subscribableErrors)
                                                        {
                                                            if (reason == DareSubscribeErrorEnum.NO_MORE_WINNERS)
                                                            {
                                                                tooltipText = (tooltipText + (this.uiApi.getText("ui.dare.info.subscribeNoMoreWinners") + "\n"));
                                                            };
                                                            if (reason == DareSubscribeErrorEnum.GUILD_LIMITED)
                                                            {
                                                                tooltipText = (tooltipText + (this.uiApi.getText("ui.dare.info.subscribeGuildLimited") + "\n"));
                                                            };
                                                            if (reason == DareSubscribeErrorEnum.ALLIANCE_LIMITED)
                                                            {
                                                                tooltipText = (tooltipText + (this.uiApi.getText("ui.dare.info.subscribeAllianceLimited") + "\n"));
                                                            };
                                                            if (reason == DareSubscribeErrorEnum.NOT_ENOUGH_MONEY)
                                                            {
                                                                tooltipText = (tooltipText + (this.uiApi.getText("ui.dare.info.subscribeNotEnoughMoney") + "\n"));
                                                            };
                                                            if (reason == DareSubscribeErrorEnum.BREED_LIMITED)
                                                            {
                                                                tooltipText = (tooltipText + (this.uiApi.getText("ui.dare.info.subscribeBreedLimited") + "\n"));
                                                            };
                                                            if (reason == DareSubscribeErrorEnum.LEVEL_TOO_HIGH)
                                                            {
                                                                tooltipText = (tooltipText + (this.uiApi.getText("ui.dare.info.subscribeLevelTooHigh") + "\n"));
                                                            };
                                                        };
                                                        tooltipText = tooltipText.slice(0, (tooltipText.length - 2));
                                                    };
                                                };
                                            };
                                        };
                                    }
                                    else
                                    {
                                        if (target.name.indexOf("btn_web") != -1)
                                        {
                                            tooltipText = this.uiApi.getText("ui.dare.share");
                                        }
                                        else
                                        {
                                            if (target.name.indexOf("tx_criteria") != -1)
                                            {
                                                data = this._componentsList[target.name];
                                                if (!data)
                                                {
                                                    return;
                                                };
                                                tooltipText = data.label;
                                            }
                                            else
                                            {
                                                if (target.name.indexOf("ctr_breed") != -1)
                                                {
                                                    data = this._componentsList[target.name];
                                                    if (((data) && (data.id > 0)))
                                                    {
                                                        tooltipText = data.name;
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (tooltipText)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var text:String;
            var pos:Object;
            if (((!(item)) || (!(item.data))))
            {
                return;
            };
            if (target.name.indexOf("gd_slots") != -1)
            {
                pos = {
                    "point":LocationEnum.POINT_BOTTOMRIGHT,
                    "relativePoint":LocationEnum.POINT_TOPLEFT
                };
                if ((item.data is ItemWrapper))
                {
                    this.uiApi.showTooltip(item.data, target, false, "standard", pos.point, pos.relativePoint, 0, "itemName", null, {
                        "showEffects":true,
                        "header":true
                    }, "ItemInfo");
                    return;
                };
                if ((item.data is ChallengeWrapper))
                {
                    this.uiApi.showTooltip(item.data, target, false, "standard", pos.point, pos.relativePoint, 0, null, null, {"effects":false});
                };
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 0, null, null, null, "TextInfo");
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (this.inp_search.haveFocus)
            {
                this._lockSearchTimer.reset();
                this._lockSearchTimer.start();
            };
        }

        public function onTimeOut(e:TimerEvent):void
        {
            if (this.inp_search.text.length > 2)
            {
                this._searchCriteria = this.inp_search.text.toLowerCase();
                this._currentScrollValue = 0;
                this._searchFilterStatesForced = null;
                this.updateDareGrid();
            }
            else
            {
                if (this._searchCriteria)
                {
                    this._searchCriteria = null;
                };
                if (this.inp_search.text.length == 0)
                {
                    this._searchFilterStatesForced = null;
                    this.updateDareGrid();
                };
            };
        }

        private function onDareListUpdated():void
        {
            this._currentListType = Dare.getInstance().currentTab;
            if (this._currentListType == this.DARE_COMPLETE_LIST)
            {
                this.btn_onlyShowIfSubscribable.visible = true;
            }
            else
            {
                this.btn_onlyShowIfSubscribable.visible = false;
            };
            if (this._currentListType == this.DARE_SUBSCRIBE_LIST)
            {
                this.btn_onlyShowIfFightable.visible = true;
            }
            else
            {
                this.btn_onlyShowIfFightable.visible = false;
            };
            this.currentTabName = this.getButtonByTab(this._currentListType);
            this.hintsApi.uiTutoTabLaunch();
            this.updateDareGrid();
        }

        private function onDareUpdated(dareId:Number):void
        {
            var l:int;
            var dare:DareWrapper = this.socialApi.getDareById(dareId);
            var found:Boolean;
            var i:int;
            l = this._currentDaresList.length;
            while (i < l)
            {
                if (((this._currentDaresList[i]) && (this._currentDaresList[i].dareId == dareId)))
                {
                    this._currentDaresList[i] = dare;
                    found = true;
                    break;
                };
                i++;
            };
            if (found)
            {
                l = this.gd_list.dataProvider.length;
                i = 0;
                while (i < l)
                {
                    if (((this.gd_list.dataProvider[i]) && (this.gd_list.dataProvider[i].dareId == dareId)))
                    {
                        this.gd_list.dataProvider[i] = dare;
                        this.gd_list.updateItem(i);
                        break;
                    };
                    i++;
                };
            }
            else
            {
                if (this._searchCriteria == ("" + dareId))
                {
                    this.updateDareGrid();
                };
            };
        }

        private function onOpenDareSearch(search:String, filter:String=null, forceRefresh:Boolean=true):void
        {
            this._searchCriteria = search;
            this.inp_search.text = search;
            this.btn_onlyShowIfSubscribable.selected = false;
            this.btn_onlyShowIfFightable.selected = false;
            _onlyShowIfSubscribable = false;
            _onlyShowIfFightable = false;
            if (filter)
            {
                this._searchFilterStatesForced = new Dictionary(true);
                this._searchFilterStatesForced[SEARCH_FILTER_ID] = false;
                this._searchFilterStatesForced[SEARCH_FILTER_CREATOR] = false;
                this._searchFilterStatesForced[SEARCH_FILTER_MONSTER] = false;
                this._searchFilterStatesForced[SEARCH_FILTER_CRITERIA] = false;
                this._searchFilterStatesForced[SEARCH_FILTER_SUBAREA] = false;
                this._searchFilterStatesForced[SEARCH_FILTER_GUILD] = false;
                this._searchFilterStatesForced[SEARCH_FILTER_ALLIANCE] = false;
                this._searchFilterStatesForced[filter] = true;
            };
            if (forceRefresh)
            {
                this.updateDareGrid();
            };
        }


    }
} Ankama_Social.ui

