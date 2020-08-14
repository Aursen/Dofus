package Ankama_Social.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.EntityDisplayer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import d2hooks.DareCreated;
    import d2hooks.GuildMembershipUpdated;
    import d2hooks.AllianceMembershipUpdated;
    import d2enums.ComponentHookList;
    import d2hooks.KeyUp;
    import d2hooks.KeyDown;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import flash.utils.clearTimeout;
    import Ankama_Social.Social;
    import com.ankamagames.dofus.network.enums.DareCriteriaTypeEnum;
    import com.ankamagames.berilia.enums.StatesEnum;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.datacenter.dare.DareCriteria;
    import flash.geom.Point;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.datacenter.challenges.Challenge;
    import com.ankamagames.dofus.datacenter.idols.Idol;
    import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
    import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
    import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import __AS3__.vec.Vector;
    import d2actions.DareCreationRequest;
    import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;
    import flash.ui.Keyboard;
    import flash.utils.setTimeout;
    import com.ankamagames.berilia.types.LocationEnum;
    import __AS3__.vec.*;
    import d2hooks.*;
    import d2actions.*;

    public class DareCreation 
    {

        private static var GRID_CTR_SEARCH:String = "ctr_search";
        private static var GRID_CTR_INPUT:String = "ctr_input";
        private static var GRID_CTR_GRID:String = "ctr_searchGrid";
        private static var GRID_CTR_SLOTS:String = "ctr_searchSlots";

        private const INT_LIMIT:int = 999999999;
        private const DAYS_TO_SECONDS:int = 86400;
        private const HOURS_TO_SECONDS:int = 3600;
        private const MAX_HOURS:int = 23;
        private const SEARCH_MODE_FILTERED_LIST:uint = 0;
        private const SEARCH_MODE_FULL_LIST:uint = 1;
        private const MONSTERS_INCOMPATIBLE_WITH_MAX_FIGHT_TURNS:Array = [3826, 3824, 3823, 3828, 3827, 3822, 3825, 4263, 3835];
        private const MONSTERS_INCOMPATIBLE_WITH_GROUP_IDOLS:Array = [3137, 605, 267, 268, 265, 266, 800, 804, 808, 423];
        private const MONSTERS_INCOMPATIBLE_WITH_MIN_MONSTER_COUNT:Array = [780, 675, 677, 673, 681];

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        private var INPUT_SEARCH_TEXT:String;
        private var _jackpot:Number = 0;
        private var _subscriptionFee:Number = 0;
        private var _maxCountWinners:uint = 0;
        private var _delayBeforeStart:uint = 0;
        private var _delayBeforeStartH:uint = 0;
        private var _duration:uint = 14;
        private var _durationH:uint = 0;
        private var _isPrivate:Boolean;
        private var _isForGuild:Boolean;
        private var _isForAlliance:Boolean;
        private var _needNotifications:Boolean = true;
        private var _criteria:Array = new Array();
        private var _criteriaToDisplay:Array = new Array();
        private var _criteriaTypeData:Object;
        private var _incompatibleIdolsForThisMonster:Array;
        private var _chosenIdolIds:Array;
        private var _chosenBreedIds:Array;
        private var _chosenChallengeIds:Array;
        private var _chosenMonsterName:String;
        private var _notEnoughMoney:Boolean;
        private var _noMonsterSelected:Boolean = true;
        private var _wrongJackpot:Boolean;
        private var _criteriaOk:Boolean = true;
        private var _gridComponents:Dictionary = new Dictionary(true);
        private var _searchCriteria:String;
        private var _searchTimeoutId:uint;
        private var _addEntryHighlight:Boolean;
        private var _removeEntryHighlight:Boolean;
        private var _ctrMaxHeight:uint;
        private var _searchMaxHeight:uint;
        private var _searchSlotHeight:uint;
        private var _lastSearch:String;
        private var _searchMode:uint;
        private var _breedUri:String;
        private var _breedGfxIdById:Array;
        private var _emblemsPath:String;
        private var _criteriaTypePath:String;
        private var _monsterSpritesPath:String;
        private var _currentSearchCriteriaType:int = -1;
        private var _currentSearchInput:Input;
        private var _currentCritLineIndex:int = 0;
        private var _criteriaDataProviderIndexByCriteriaIndex:Array;
        private var _saveOnUnload:Boolean;
        public var mainCtr:GraphicContainer;
        public var inp_jackpot:Input;
        public var inp_fee:Input;
        public var inp_maxCountWinners:Input;
        public var inp_duration:Input;
        public var inp_durationH:Input;
        public var inp_delayBeforeStart:Input;
        public var inp_delayBeforeStartH:Input;
        public var lbl_feeInfo:Label;
        public var lbl_maxCountWinnersInfo:Label;
        public var lbl_durationInfo:Label;
        public var lbl_delayBeforeStartInfo:Label;
        public var btn_isPrivate:ButtonContainer;
        public var cb_restriction:ComboBox;
        public var ctr_guildalliance:GraphicContainer;
        public var tx_emblemBack:Texture;
        public var tx_emblemUp:Texture;
        public var btn_needNotifications:ButtonContainer;
        public var inp_monster:Input;
        public var tx_monsterUnknown:Texture;
        public var ed_monster:EntityDisplayer;
        public var btn_closeMonster:ButtonContainer;
        public var lbl_criteriaTitle:Label;
        public var gd_criteriaType:Grid;
        public var gd_criteria:Grid;
        public var ctr_search:GraphicContainer;
        public var ctr_searchBg:Texture;
        public var gd_searchResult:Grid;
        public var lbl_searchResult:Label;
        public var btn_valid:ButtonContainer;
        public var lbl_creationCost:Label;


        public function main(... params):void
        {
            var b:Breed;
            this.sysApi.addHook(DareCreated, this.onDareCreated);
            this.sysApi.addHook(GuildMembershipUpdated, this.onGuildAllianceMembershipUpdated);
            this.sysApi.addHook(AllianceMembershipUpdated, this.onGuildAllianceMembershipUpdated);
            this.uiApi.addComponentHook(this.mainCtr, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.inp_jackpot, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.inp_jackpot, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.inp_jackpot, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.inp_fee, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.inp_maxCountWinners, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.inp_duration, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.inp_delayBeforeStart, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.inp_durationH, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.inp_delayBeforeStartH, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.inp_monster, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.inp_monster, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.inp_monster, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.inp_monster, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_isPrivate, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_isPrivate, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_isPrivate, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.cb_restriction, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.cb_restriction, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.cb_restriction, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_searchResult, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.lbl_feeInfo, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_feeInfo, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_maxCountWinnersInfo, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_maxCountWinnersInfo, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_durationInfo, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_durationInfo, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_delayBeforeStartInfo, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_delayBeforeStartInfo, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_guildalliance, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_guildalliance, ComponentHookList.ON_ROLL_OUT);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.sysApi.addHook(KeyDown, this.onKeyDown);
            this._searchMaxHeight = this.uiApi.me().getConstant("searchMaxHeight");
            this._ctrMaxHeight = this.uiApi.me().getConstant("ctrMaxHeight");
            this._searchSlotHeight = this.uiApi.me().getConstant("searchSlotHeight");
            this._breedUri = this.uiApi.me().getConstant("heads_uri");
            this._emblemsPath = this.uiApi.me().getConstant("emblems_uri");
            this._criteriaTypePath = this.uiApi.me().getConstant("criteriaType_uri");
            this._monsterSpritesPath = this.uiApi.me().getConstant("monsterSprite_uri");
            this._criteriaTypeData = this.dataApi.getAllDareCriteria();
            this.inp_jackpot.restrictChars = "0-9";
            this.inp_fee.restrictChars = "0-9";
            this.inp_maxCountWinners.restrictChars = "0-9";
            this.inp_duration.restrictChars = "0-9";
            this.inp_durationH.restrictChars = "0-9";
            this.inp_delayBeforeStart.restrictChars = "0-9";
            this.inp_delayBeforeStartH.restrictChars = "0-9";
            this.inp_duration.numberMax = ProtocolConstantsEnum.MAX_DARE_DURATION;
            this.inp_delayBeforeStart.numberMax = ProtocolConstantsEnum.MAX_DARE_DURATION;
            this.inp_durationH.numberMax = this.MAX_HOURS;
            this.inp_delayBeforeStartH.numberMax = this.MAX_HOURS;
            this.INPUT_SEARCH_TEXT = this.uiApi.getText("ui.common.search.input");
            this.inp_monster.text = this.INPUT_SEARCH_TEXT;
            this.lbl_criteriaTitle.text = ((this.uiApi.getText("ui.dare.criteria") + " ") + this.uiApi.getText("ui.dare.maxCriteria.short", (ProtocolConstantsEnum.MAX_CRITERION_BY_DARE - 1)));
            this.onGuildAllianceMembershipUpdated(true);
            this._breedGfxIdById = new Array();
            var breeds:Object = this.dataApi.getBreeds();
            for each (b in breeds)
            {
                this._breedGfxIdById[b.id] = ((b.id + "") + (b.id % 2));
            };
            this.initUI();
        }

        public function unload():void
        {
            var creationStatus:Object;
            clearTimeout(this._searchTimeoutId);
            if (this._saveOnUnload)
            {
                creationStatus = new Object();
                creationStatus.jackpot = this._jackpot;
                creationStatus.subscriptionFee = this._subscriptionFee;
                creationStatus.maxCountWinners = this._maxCountWinners;
                creationStatus.delayBeforeStart = this._delayBeforeStart;
                creationStatus.duration = this._duration;
                creationStatus.delayBeforeStartH = this._delayBeforeStartH;
                creationStatus.durationH = this._durationH;
                creationStatus.isPrivate = this._isPrivate;
                creationStatus.isForGuild = this._isForGuild;
                creationStatus.isForAlliance = this._isForAlliance;
                creationStatus.needNotifications = this._needNotifications;
                creationStatus.criteria = ((this._criteria) ? this._criteria : new Array());
                Social.getInstance().dareCreationStatus = creationStatus;
            };
        }

        public function initUI():void
        {
            var creationStatus:Object;
            var restrictionIndex:int;
            this.ctr_search.visible = false;
            if (Social.getInstance().dareCreationStatus)
            {
                creationStatus = Social.getInstance().dareCreationStatus;
                this._jackpot = creationStatus.jackpot;
                this._subscriptionFee = creationStatus.subscriptionFee;
                this._maxCountWinners = creationStatus.maxCountWinners;
                this._delayBeforeStart = creationStatus.delayBeforeStart;
                this._duration = creationStatus.duration;
                this._delayBeforeStartH = creationStatus.delayBeforeStartH;
                this._durationH = creationStatus.durationH;
                this._isPrivate = creationStatus.isPrivate;
                this._isForGuild = creationStatus.isForGuild;
                this._isForAlliance = creationStatus.isForAlliance;
                this._needNotifications = creationStatus.needNotifications;
                this._criteria = creationStatus.criteria;
                restrictionIndex = 0;
                if (this._isForAlliance)
                {
                    if (this.socialApi.hasAlliance())
                    {
                        restrictionIndex = 1;
                    }
                    else
                    {
                        this._isForAlliance = false;
                    };
                }
                else
                {
                    if (this._isForGuild)
                    {
                        if (this.socialApi.hasGuild())
                        {
                            if (this.socialApi.hasAlliance())
                            {
                                restrictionIndex = 2;
                            }
                            else
                            {
                                restrictionIndex = 1;
                            };
                        }
                        else
                        {
                            this._isForGuild = false;
                        };
                    };
                };
                this.cb_restriction.value = this.cb_restriction.dataProvider[restrictionIndex];
            }
            else
            {
                this._jackpot = 0;
                this._subscriptionFee = 0;
                this._maxCountWinners = 0;
                this._delayBeforeStart = 0;
                this._duration = ProtocolConstantsEnum.MAX_DARE_DURATION;
                this._delayBeforeStartH = 0;
                this._durationH = 0;
                this._isPrivate = false;
                this._isForGuild = false;
                this._isForAlliance = false;
                this._needNotifications = true;
                this.cb_restriction.value = this.cb_restriction.dataProvider[0];
                this._criteria = new Array();
                this.addDareCriteria(0, DareCriteriaTypeEnum.MONSTER_ID);
            };
            this._saveOnUnload = true;
            this.inp_jackpot.text = ("" + this._jackpot);
            this.inp_fee.text = ("" + this._subscriptionFee);
            this.inp_maxCountWinners.text = ("" + this._maxCountWinners);
            this.inp_duration.text = ("" + this._duration);
            this.inp_delayBeforeStart.text = ("" + this._delayBeforeStart);
            this.inp_durationH.text = ("" + this._durationH);
            this.inp_delayBeforeStartH.text = ("" + this._delayBeforeStartH);
            this.btn_needNotifications.selected = this._needNotifications;
            this.btn_isPrivate.selected = this._isPrivate;
            this.lbl_creationCost.text = this.utilApi.kamasToString((ProtocolConstantsEnum.DARE_CREATION_TAX + this._jackpot), "");
            this.clearSearchResults();
            if ((((((this._criteria) && (this._criteria.length)) && (this._criteria[0])) && (this._criteria[0].params.length)) && (this._criteria[0].params[0])))
            {
                this.selectMonster(this._criteria[0].params[0]);
            }
            else
            {
                this.selectMonster(0);
            };
            this._currentCritLineIndex = 0;
            this._currentSearchCriteriaType = -1;
            this._currentSearchInput = null;
            this.updateValidationButton();
            this.updateCriteriaTypeList();
            this.updateCriteriaGrid();
        }

        public function updateSearchEntryLine(result:Object, components:*, selected:Boolean):void
        {
            var data:Object;
            components.btn_result.y = 1;
            if (result)
            {
                if (this._removeEntryHighlight)
                {
                    components.btn_result.state = ((result.selected) ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL);
                    this._removeEntryHighlight = false;
                    return;
                };
                if (this._addEntryHighlight)
                {
                    components.btn_result.state = ((result.selected) ? StatesEnum.STATE_SELECTED_OVER : StatesEnum.STATE_OVER);
                    this._addEntryHighlight = false;
                    return;
                };
                components.btn_result.state = ((result.selected) ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL);
                data = ((result.hasOwnProperty("tooltipData")) ? result.tooltipData : result.data);
                components.btn_result.selected = result.selected;
                if (data)
                {
                    if (data.hasOwnProperty("iconUri"))
                    {
                        components.tx_result.uri = data.iconUri;
                    }
                    else
                    {
                        if (result.type == DareCriteriaTypeEnum.MONSTER_ID)
                        {
                            components.tx_result.uri = this.uiApi.createUri(((this._monsterSpritesPath + data.id) + ".png"));
                        }
                        else
                        {
                            if (((result.type == DareCriteriaTypeEnum.FORBIDDEN_BREEDS) || (result.type == DareCriteriaTypeEnum.MANDATORY_BREEDS)))
                            {
                                components.tx_result.uri = this.uiApi.createUri((((this._breedUri + "") + this._breedGfxIdById[data.id]) + ".png"));
                            };
                        };
                    };
                };
                components.lbl_result.text = result.label;
                this.uiApi.addComponentHook(components.btn_result, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_result, ComponentHookList.ON_ROLL_OUT);
                this._gridComponents[components.btn_result.name] = result;
            }
            else
            {
                components.btn_result.state = StatesEnum.STATE_NORMAL;
                components.btn_result.selected = false;
                components.tx_result.uri = null;
                components.lbl_result.text = "";
                this.uiApi.removeComponentHook(components.btn_result, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.removeComponentHook(components.btn_result, ComponentHookList.ON_ROLL_OUT);
                delete this._gridComponents[components.btn_result.name];
            };
        }

        public function updateCriteria(data:*, compRef:*, selected:Boolean, line:uint):void
        {
            if (!data)
            {
                return;
            };
            if (!this._gridComponents[compRef.tx_warning.name])
            {
                this.uiApi.addComponentHook(compRef.tx_warning, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(compRef.tx_warning, ComponentHookList.ON_ROLL_OUT);
            };
            this._gridComponents[compRef.tx_warning.name] = data;
            if (data.warning != "")
            {
                compRef.lbl_name.cssClass = "red";
                compRef.tx_warning.x = ((compRef.lbl_name.x + compRef.lbl_name.textWidth) + 15);
                compRef.tx_warning.visible = true;
            }
            else
            {
                compRef.lbl_name.cssClass = "p";
                compRef.tx_warning.visible = false;
            };
            compRef.tx_icon.uri = this.uiApi.createUri((((this._criteriaTypePath + "") + data.criteria.id) + "_normal.png"));
            var name:String = data.criteria.name;
            if (data.criteria.maxParameters > 1)
            {
                name = (name + (" " + this.uiApi.getText("ui.dare.maxCriteria.short", data.criteria.maxParameters)));
            };
            compRef.lbl_name.text = name;
            switch (this.getCriteriaLineType(data, line))
            {
                case GRID_CTR_SEARCH:
                    if (!this._gridComponents[compRef.inp_search.name])
                    {
                        this.uiApi.addComponentHook(compRef.inp_search, ComponentHookList.ON_RELEASE);
                    };
                    this._gridComponents[compRef.inp_search.name] = data;
                    if (((!(data.params[data.selectedParamIndex])) && (!(this.ctr_search.visible))))
                    {
                        compRef.inp_search.text = this.INPUT_SEARCH_TEXT;
                    };
                    break;
                case GRID_CTR_INPUT:
                    if (!this._gridComponents[compRef.inp_value.name])
                    {
                        this.uiApi.addComponentHook(compRef.inp_value, ComponentHookList.ON_CHANGE);
                    };
                    this._gridComponents[compRef.inp_value.name] = data;
                    compRef.inp_value.numberMax = data.criteria.maxParameterBound;
                    compRef.inp_value.restrictChars = "0-9";
                    if (data.params[0])
                    {
                        compRef.inp_value.text = data.params[0];
                    }
                    else
                    {
                        compRef.inp_value.text = "";
                    };
                    break;
                case GRID_CTR_GRID:
                    if (!this._gridComponents[compRef.inp_search.name])
                    {
                        this.uiApi.addComponentHook(compRef.inp_search, ComponentHookList.ON_RELEASE);
                    };
                    this._gridComponents[compRef.inp_search.name] = data;
                    if (!this._gridComponents[compRef.gd_data.name])
                    {
                        this.uiApi.addComponentHook(compRef.gd_data, ComponentHookList.ON_SELECT_ITEM);
                    };
                    this._gridComponents[compRef.gd_data.name] = data;
                    compRef.gd_data.dataProvider = data.params;
                    if (((!(data.params[data.selectedParamIndex])) && (!(this.ctr_search.visible))))
                    {
                        compRef.inp_search.text = this.INPUT_SEARCH_TEXT;
                    };
                    break;
                case GRID_CTR_SLOTS:
                    if (!this._gridComponents[compRef.inp_search.name])
                    {
                        this.uiApi.addComponentHook(compRef.inp_search, ComponentHookList.ON_RELEASE);
                    };
                    this._gridComponents[compRef.inp_search.name] = data;
                    if (!this._gridComponents[compRef.gd_slots.name])
                    {
                        this.uiApi.addComponentHook(compRef.gd_slots, ComponentHookList.ON_ITEM_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.gd_slots, ComponentHookList.ON_ITEM_ROLL_OUT);
                        this.uiApi.addComponentHook(compRef.gd_slots, ComponentHookList.ON_SELECT_ITEM);
                    };
                    this._gridComponents[compRef.gd_slots.name] = data;
                    compRef.gd_slots.dataProvider = data.params;
                    if (((!(data.params[data.selectedParamIndex])) && (!(this.ctr_search.visible))))
                    {
                        compRef.inp_search.text = this.INPUT_SEARCH_TEXT;
                    };
                    break;
            };
        }

        public function getCriteriaLineType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("");
            };
            if (data.criteria.id == DareCriteriaTypeEnum.CHALLENGE_ID)
            {
                return (GRID_CTR_SEARCH);
            };
            if (((data.criteria.id == DareCriteriaTypeEnum.FORBIDDEN_BREEDS) || (data.criteria.id == DareCriteriaTypeEnum.MANDATORY_BREEDS)))
            {
                return (GRID_CTR_GRID);
            };
            if (data.criteria.id == DareCriteriaTypeEnum.IDOLS)
            {
                return (GRID_CTR_SLOTS);
            };
            return (GRID_CTR_INPUT);
        }

        public function getCriteriaDataLength(data:*, selected:Boolean):*
        {
            return (1);
        }

        public function updateBreed(data:*, componentsRef:*, selected:Boolean):void
        {
            var gender:int;
            if (!this._gridComponents[componentsRef.ctr_breed.name])
            {
                this.uiApi.addComponentHook(componentsRef.ctr_breed, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.ctr_breed, ComponentHookList.ON_ROLL_OUT);
            };
            this._gridComponents[componentsRef.ctr_breed.name] = data;
            if (data)
            {
                if (data.id > 0)
                {
                    gender = int(Math.round(Math.random()));
                    componentsRef.tx_breed.uri = this.uiApi.createUri((((this._breedUri + "") + this._breedGfxIdById[data.id]) + ".png"));
                }
                else
                {
                    componentsRef.tx_breed.uri = null;
                };
            }
            else
            {
                componentsRef.tx_breed.uri = null;
            };
        }

        public function updateCriteriaType(data:*, components:*, selected:Boolean):void
        {
            var uriString:String;
            if (!this._gridComponents[components.tx_type.name])
            {
                this.uiApi.addComponentHook(components.tx_type, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.tx_type, ComponentHookList.ON_ROLL_OUT);
                this.uiApi.addComponentHook(components.tx_type, ComponentHookList.ON_RELEASE);
            };
            this._gridComponents[components.tx_type.name] = data;
            if (data)
            {
                uriString = (this._criteriaTypePath + data.id);
                if (data.selected)
                {
                    uriString = (uriString + "_selected.png");
                }
                else
                {
                    uriString = (uriString + "_disabled.png");
                };
                components.tx_type.uri = this.uiApi.createUri(uriString);
            }
            else
            {
                components.tx_type.uri = null;
            };
        }

        private function getCriteriaParams(_arg_1:int):Array
        {
            var param:int;
            var result:Array = new Array();
            var l:int = this._criteria.length;
            var i:int;
            while (i < l)
            {
                if (this._criteria[i].type == _arg_1)
                {
                    for each (param in this._criteria[i].params)
                    {
                        result.push(param);
                    };
                };
                i++;
            };
            return (result);
        }

        private function getCriteriaMonster():Monster
        {
            var monster:Monster;
            var monsterCriteriaParam:Array = this.getCriteriaParams(DareCriteriaTypeEnum.MONSTER_ID);
            if (monsterCriteriaParam.length)
            {
                monster = this.dataApi.getMonsterFromId(monsterCriteriaParam[0]);
            };
            return (monster);
        }

        private function addDareCriteria(index:int, _arg_2:int):void
        {
            if (this._criteria[index])
            {
                this.sysApi.log(2, ((("Un critere de type " + this._criteria[index].type) + " existe deja à l'index ") + index));
                return;
            };
            var o:Object = {
                "type":_arg_2,
                "params":new Vector.<int>(),
                "warning":"",
                "lastModifiedParamIndex":0
            };
            this._criteria[index] = o;
            this.updateCriteriaTypeList();
            this.updateCriteriaGrid();
        }

        private function removeDareCriteria(index:int):void
        {
            if (((this._criteria[index]) && (index > 0)))
            {
                this._criteria[index] = null;
                this._criteria.splice(index, 1);
                this.checkCriteria();
                this.updateCriteriaTypeList();
                this.updateCriteriaGrid();
            };
        }

        private function selectMonster(monsterId:int):void
        {
            var monster:Monster;
            var idolId:int;
            if (monsterId > 0)
            {
                this._noMonsterSelected = false;
                this._incompatibleIdolsForThisMonster = new Array();
                monster = this.dataApi.getMonsterFromId(monsterId);
                if (monster)
                {
                    if (monster.allIdolsDisabled)
                    {
                        this._incompatibleIdolsForThisMonster.push(-1);
                    }
                    else
                    {
                        for each (idolId in monster.incompatibleIdols)
                        {
                            this._incompatibleIdolsForThisMonster.push(idolId);
                        };
                    };
                    this._chosenMonsterName = monster.name;
                };
                this.tx_monsterUnknown.visible = false;
                this.ed_monster.look = monster.look;
                this.ed_monster.visible = true;
                this.inp_monster.text = monster.name;
            }
            else
            {
                this._noMonsterSelected = true;
                this._incompatibleIdolsForThisMonster = new Array();
                this._chosenMonsterName = "";
                this.tx_monsterUnknown.visible = true;
                this.ed_monster.visible = false;
                this.inp_monster.text = this.INPUT_SEARCH_TEXT;
            };
        }

        private function modifyDareCriteriaParam(index:int, _arg_2:int, param:int=0, paramIndex:int=-1):void
        {
            if (((!(this._criteria[index])) || (!(this._criteria[index].type == _arg_2))))
            {
                this.sysApi.log(2, (("Le critère n'existe pas ou n'est pas du bon type, ajout du parametre " + param) + " impossible."));
                return;
            };
            var typeData:DareCriteria = this.dataApi.getDareCriteria(_arg_2);
            if (paramIndex >= typeData.maxParameters)
            {
                this.sysApi.log(2, ((((("Le critere " + typeData.name) + " est limité à ") + typeData.maxParameters) + " parametres, impossible d'en ajouter un à l'index ") + paramIndex));
                return;
            };
            if (param == 0)
            {
                if (paramIndex == -1)
                {
                    this._criteria[index].params.pop();
                    this._criteria[index].lastModifiedParamIndex = this._criteria[index].params.length;
                }
                else
                {
                    if (paramIndex < this._criteria[index].params.length)
                    {
                        this._criteria[index].params.splice(paramIndex, 1);
                        this._criteria[index].lastModifiedParamIndex = paramIndex;
                    }
                    else
                    {
                        return;
                    };
                };
            }
            else
            {
                if (paramIndex == -1)
                {
                    if (this._criteria[index].params.length < typeData.maxParameters)
                    {
                        this._criteria[index].params.push(param);
                    }
                    else
                    {
                        this._criteria[index].params[(typeData.maxParameters - 1)] = param;
                    };
                    this._criteria[index].lastModifiedParamIndex = (this._criteria[index].params.length - 1);
                }
                else
                {
                    this._criteria[index].params[paramIndex] = param;
                    this._criteria[index].lastModifiedParamIndex = paramIndex;
                };
            };
            if (_arg_2 == DareCriteriaTypeEnum.MONSTER_ID)
            {
                this.selectMonster(param);
            };
            this.checkCriteria();
            this.updateCriteriaGrid();
            var l:int = this._criteria.length;
            var io:int;
            while (io < l)
            {
                this.sysApi.log(32, (((((" - critere [" + io) + "] : ") + this.dataApi.getDareCriteria(this._criteria[io].type).name) + "     ") + this._criteria[io].params));
                io++;
            };
        }

        private function updateCriteriaTypeList():void
        {
            var criteriaType:Object;
            var addedCriteria:Object;
            var criteriaTypes:Array = new Array();
            var selected:Boolean;
            for each (criteriaType in this._criteriaTypeData)
            {
                selected = false;
                for each (addedCriteria in this._criteria)
                {
                    if (criteriaType.id == addedCriteria.type)
                    {
                        selected = true;
                        break;
                    };
                };
                if (criteriaType.id != DareCriteriaTypeEnum.MONSTER_ID)
                {
                    criteriaTypes.push({
                        "id":criteriaType.id,
                        "label":criteriaType.name,
                        "selected":selected
                    });
                };
            };
            this.gd_criteriaType.dataProvider = criteriaTypes;
        }

        private function updateCriteriaGrid():void
        {
            var params:Array;
            var dataCriteria:DareCriteria;
            var i:int;
            var j:int;
            var maxParam:int;
            var id:int;
            var criteriaObject:Object;
            var selectedIndex:int;
            var criteriaDisplay:Object;
            this._criteriaToDisplay = new Array();
            var critLength:int = this._criteria.length;
            this._criteriaDataProviderIndexByCriteriaIndex = [];
            i = 0;
            while (i < critLength)
            {
                criteriaObject = this._criteria[i];
                if (criteriaObject.type == DareCriteriaTypeEnum.MONSTER_ID)
                {
                }
                else
                {
                    dataCriteria = this.dataApi.getDareCriteria(criteriaObject.type);
                    params = new Array();
                    maxParam = dataCriteria.maxParameters;
                    if (((criteriaObject.params) && (criteriaObject.params.length > 0)))
                    {
                        if (criteriaObject.type == DareCriteriaTypeEnum.CHALLENGE_ID)
                        {
                            params.push(this.dataApi.getChallenge(criteriaObject.params[0]));
                        }
                        else
                        {
                            if (criteriaObject.type == DareCriteriaTypeEnum.IDOLS)
                            {
                                j = 0;
                                while (j < maxParam)
                                {
                                    if (criteriaObject.params.length > j)
                                    {
                                        id = criteriaObject.params[j];
                                        if (id > 0)
                                        {
                                            params.push(this.dataApi.getItemWrapper(this.dataApi.getIdol(id).itemId));
                                        }
                                        else
                                        {
                                            params.push(new Object());
                                        };
                                    }
                                    else
                                    {
                                        params.push(new Object());
                                    };
                                    j++;
                                };
                            }
                            else
                            {
                                if (((criteriaObject.type == DareCriteriaTypeEnum.FORBIDDEN_BREEDS) || (criteriaObject.type == DareCriteriaTypeEnum.MANDATORY_BREEDS)))
                                {
                                    j = 0;
                                    while (j < maxParam)
                                    {
                                        if (criteriaObject.params.length > j)
                                        {
                                            id = criteriaObject.params[j];
                                            params.push(this.dataApi.getBreed(id));
                                        }
                                        else
                                        {
                                            params.push(new Object());
                                        };
                                        j++;
                                    };
                                }
                                else
                                {
                                    params.push(criteriaObject.params[0]);
                                };
                            };
                        };
                    };
                    selectedIndex = criteriaObject.lastModifiedParamIndex;
                    if (params[selectedIndex])
                    {
                        selectedIndex++;
                    };
                    if (dataCriteria.maxParameters <= selectedIndex)
                    {
                        selectedIndex = (dataCriteria.maxParameters - 1);
                    };
                    this._criteriaDataProviderIndexByCriteriaIndex[i] = this._criteriaToDisplay.length;
                    criteriaDisplay = {
                        "criteria":dataCriteria,
                        "params":params,
                        "index":i,
                        "warning":criteriaObject.warning,
                        "selectedParamIndex":selectedIndex
                    };
                    this._criteriaToDisplay.push(criteriaDisplay);
                };
                i++;
            };
            this.gd_criteria.dataProvider = this._criteriaToDisplay;
        }

        private function buildInputList(_arg_1:int):void
        {
        }

        private function searchAll(pSearch:String, _arg_2:int=-1):void
        {
            var searchIndex:int;
            var i:int;
            var resultsText:String;
            if (((_arg_2 == DareCriteriaTypeEnum.MONSTER_ID) && ((!(pSearch)) || (pSearch.length == 0))))
            {
                this.ctr_search.visible = false;
                return;
            };
            if (pSearch == null)
            {
                pSearch = "";
            };
            pSearch = this.utilApi.noAccent(pSearch).toLowerCase();
            if (_arg_2 == -1)
            {
                this.sysApi.log(8, "Search impossible with no data type selected");
                return;
            };
            if (_arg_2 == DareCriteriaTypeEnum.MONSTER_ID)
            {
                this._searchMode = this.SEARCH_MODE_FILTERED_LIST;
            }
            else
            {
                this._searchMode = this.SEARCH_MODE_FULL_LIST;
            };
            var results:Array = this.getSearchAllResults(pSearch, _arg_2);
            var position:Point = (this.mainCtr as Object).globalToLocal((this._currentSearchInput as Object).localToGlobal(new Point(this._currentSearchInput.x, this._currentSearchInput.y)));
            this.ctr_search.x = (position.x - 7);
            this.ctr_search.y = ((position.y + this._currentSearchInput.height) + 4);
            var currentMaxHeight:int = (this._ctrMaxHeight - this.ctr_search.y);
            if (currentMaxHeight > this._searchMaxHeight)
            {
                currentMaxHeight = this._searchMaxHeight;
            };
            var height:Number = (results.length * this._searchSlotHeight);
            this.gd_searchResult.height = ((height > currentMaxHeight) ? currentMaxHeight : height);
            this.gd_searchResult.dataProvider = results;
            if (((this._searchMode == this.SEARCH_MODE_FULL_LIST) && (pSearch.length)))
            {
                i = 0;
                while (i < results.length)
                {
                    if (results[i].selectString.indexOf(pSearch) == 0)
                    {
                        this.gd_searchResult.selectedIndex = i;
                        break;
                    };
                    i++;
                };
            }
            else
            {
                this.gd_searchResult.selectedIndex = 0;
            };
            this.ctr_searchBg.height = (this.gd_searchResult.height + this.gd_searchResult.slotHeight);
            this.ctr_searchBg.width = (this.gd_searchResult.width + this.gd_searchResult.x);
            if (this._searchMode == this.SEARCH_MODE_FILTERED_LIST)
            {
                if (results.length == 0)
                {
                    this.lbl_searchResult.text = this.uiApi.getText("ui.search.noResult");
                    this.gd_searchResult.visible = false;
                }
                else
                {
                    this.gd_searchResult.visible = true;
                    resultsText = this.uiApi.processText(this.uiApi.getText("ui.search.results", results.length), "n", (results.length <= 1), (results.length == 0));
                    this.lbl_searchResult.text = resultsText;
                };
            }
            else
            {
                this.gd_searchResult.visible = true;
                this.ctr_searchBg.height = (this.ctr_searchBg.height - this.lbl_searchResult.height);
                this.lbl_searchResult.text = "";
            };
            this.lbl_searchResult.y = (((this.ctr_searchBg.height - this.lbl_searchResult.textHeight) - ((this.gd_searchResult.slotHeight / 2) - (this.lbl_searchResult.textHeight / 2))) - 4);
            this.ctr_search.visible = true;
            this._lastSearch = pSearch;
        }

        private function getSearchAllResults(search:String, _arg_2:int):Array
        {
            var result:Object;
            var searchClass:Class;
            var ids:Object;
            var id:int;
            var dataArray:Object;
            var data:Object;
            var criteriaParams:Array;
            var entryIsSelected:Boolean;
            var idolItem:ItemWrapper;
            var results:Array = new Array();
            var nameProperty:String = "name";
            if (this._searchMode == this.SEARCH_MODE_FILTERED_LIST)
            {
                if (_arg_2 == DareCriteriaTypeEnum.MONSTER_ID)
                {
                    searchClass = Monster;
                    ids = this.dataApi.queryString(searchClass, nameProperty, search);
                    for each (id in ids)
                    {
                        result = this.getSearchResultEntry(id, _arg_2, search);
                        if (result)
                        {
                            results.push(result);
                        };
                    };
                }
                else
                {
                    this.sysApi.log(16, "This criteria type is not supported for this searchMode yet!");
                };
            }
            else
            {
                criteriaParams = this.getCriteriaParams(_arg_2);
                entryIsSelected = false;
                switch (_arg_2)
                {
                    case DareCriteriaTypeEnum.FORBIDDEN_BREEDS:
                    case DareCriteriaTypeEnum.MANDATORY_BREEDS:
                        dataArray = this.dataApi.getBreeds();
                        for each (data in dataArray)
                        {
                            entryIsSelected = (!(criteriaParams.indexOf(data.id) == -1));
                            results.push({
                                "data":data,
                                "name":data.shortName,
                                "type":_arg_2,
                                "label":data.shortName,
                                "selected":entryIsSelected,
                                "selectString":this.utilApi.noAccent(data.shortName).toLowerCase()
                            });
                        };
                        break;
                    case DareCriteriaTypeEnum.IDOLS:
                        dataArray = this.dataApi.getAllIdols();
                        for each (data in dataArray)
                        {
                            idolItem = this.dataApi.getItemWrapper(data.itemId);
                            entryIsSelected = (!(criteriaParams.indexOf(data.id) == -1));
                            results.push({
                                "data":data,
                                "tooltipData":idolItem,
                                "name":data.name,
                                "type":_arg_2,
                                "label":data.name,
                                "selected":entryIsSelected,
                                "selectString":idolItem.undiatricalName
                            });
                        };
                        break;
                    case DareCriteriaTypeEnum.CHALLENGE_ID:
                        dataArray = this.dataApi.getChallenges();
                        for each (data in dataArray)
                        {
                            if (data.dareAvailable)
                            {
                                entryIsSelected = (!(criteriaParams.indexOf(data.id) == -1));
                                results.push({
                                    "data":data,
                                    "tooltipData":this.dataApi.getChallengeWrapper(data.id),
                                    "name":data.name,
                                    "type":_arg_2,
                                    "label":data.name,
                                    "selected":entryIsSelected,
                                    "selectString":this.utilApi.noAccent(data.name).toLowerCase()
                                });
                            };
                        };
                        break;
                    default:
                        this.sysApi.log(16, "This criteria type is not supported for this searchMode yet!");
                };
            };
            if (((results) && (results.length)))
            {
                this.utilApi.sortOnString(results, "name");
            };
            return (results);
        }

        private function getSearchResultEntry(pId:int, pType:uint, pSearch:String):Object
        {
            var entry:Object;
            var i:int;
            var j:int;
            var strNoAccent:String;
            var nextIndex:int;
            var numReplaced:int;
            var monster:Monster;
            var chosenChalls:Array;
            var challenge:Challenge;
            var chosenIdols:Array;
            var forbiddenBreeds:Array;
            var mandatoryBreeds:Array;
            var moreInfo:String = "";
            switch (pType)
            {
                case DareCriteriaTypeEnum.MONSTER_ID:
                    monster = this.dataApi.getMonsterFromId(pId);
                    if (!monster.dareAvailable)
                    {
                        return (null);
                    };
                    entry = new Object();
                    entry.data = monster;
                    entry.name = entry.data.name;
                    break;
                case DareCriteriaTypeEnum.CHALLENGE_ID:
                    chosenChalls = this.getCriteriaParams(DareCriteriaTypeEnum.CHALLENGE_ID);
                    if (chosenChalls.indexOf(pId) != -1)
                    {
                        return (null);
                    };
                    challenge = this.dataApi.getChallenge(pId);
                    if (!challenge.dareAvailable)
                    {
                        return (null);
                    };
                    entry = new Object();
                    entry.data = challenge;
                    entry.name = entry.data.name;
                    break;
                case DareCriteriaTypeEnum.IDOLS:
                    chosenIdols = this.getCriteriaParams(DareCriteriaTypeEnum.IDOLS);
                    if (chosenIdols.indexOf(pId) != -1)
                    {
                        return (null);
                    };
                    entry = new Object();
                    entry.data = this.dataApi.getIdol(pId);
                    entry.name = entry.data.name;
                    break;
                case DareCriteriaTypeEnum.FORBIDDEN_BREEDS:
                    forbiddenBreeds = this.getCriteriaParams(DareCriteriaTypeEnum.FORBIDDEN_BREEDS);
                    if (forbiddenBreeds.indexOf(pId) != -1)
                    {
                        return (null);
                    };
                    entry = new Object();
                    entry.data = this.dataApi.getBreed(pId);
                    entry.name = entry.data.name;
                    break;
                case DareCriteriaTypeEnum.MANDATORY_BREEDS:
                    mandatoryBreeds = this.getCriteriaParams(DareCriteriaTypeEnum.MANDATORY_BREEDS);
                    if (mandatoryBreeds.indexOf(pId) != -1)
                    {
                        return (null);
                    };
                    entry = new Object();
                    entry.data = this.dataApi.getBreed(pId);
                    entry.name = entry.data.name;
                    break;
            };
            entry.type = pType;
            entry.selected = false;
            var labelTmp:String = entry.name.toLowerCase();
            var label:String = entry.name;
            var len:int = label.length;
            var searchLen:int = pSearch.length;
            i = 0;
            while (i < len)
            {
                strNoAccent = this.utilApi.noAccent(labelTmp.substring(i, (i + searchLen)));
                if (strNoAccent == pSearch)
                {
                    nextIndex = (i + (numReplaced * 7));
                    j = (nextIndex + searchLen);
                    label = ((((label.substring(0, nextIndex) + "<b>") + label.substring(nextIndex, j)) + "</b>") + label.substring(j));
                    numReplaced++;
                };
                i++;
            };
            entry.label = (label + moreInfo);
            return (entry);
        }

        private function checkCriteria():void
        {
            var maxCountChar:Array;
            var criteriaType:DareCriteria;
            var breedId:int;
            var criteria:Object;
            var i:int;
            var challenge:Challenge;
            var chosenChalls:Array;
            var mandatoryBreeds:Array;
            var forbiddenBreeds:Array;
            var maxCountChars:Array;
            var idolData:Idol;
            var idolsName:String;
            var idolsData:Array;
            var maxLevel:Array;
            var idolScore:Array;
            var idolId:int;
            var idols:Array;
            var minCountChar:Array;
            var mandaroryBreeds:Array;
            var minCountMonster:Array;
            var resultText:String = "";
            this._criteriaOk = true;
            var monster:Monster = this.getCriteriaMonster();
            for each (criteria in this._criteria)
            {
                resultText = "";
                if (criteria.params.length == 0)
                {
                    criteria.warning = resultText;
                }
                else
                {
                    this.sysApi.log(2, (((" - " + criteria.type) + " : ") + criteria.params));
                    if (criteria.type == DareCriteriaTypeEnum.CHALLENGE_ID)
                    {
                        if (criteria.params[0] == 0)
                        {
                            continue;
                        };
                        if (((monster) && (!(monster.incompatibleChallenges.indexOf(criteria.params[0]) == -1))))
                        {
                            resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.challengeMonster"));
                            this._criteriaOk = false;
                        };
                        challenge = this.dataApi.getChallenge(criteria.params[0]);
                        chosenChalls = this.getCriteriaParams(DareCriteriaTypeEnum.CHALLENGE_ID);
                        for each (i in chosenChalls)
                        {
                            if (challenge.incompatibleChallenges.indexOf(i) != -1)
                            {
                                if (resultText != "")
                                {
                                    resultText = (resultText + "\n");
                                };
                                resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.challengesTogether"));
                                this._criteriaOk = false;
                            };
                        };
                        criteria.warning = resultText;
                    }
                    else
                    {
                        if (criteria.type == DareCriteriaTypeEnum.FORBIDDEN_BREEDS)
                        {
                            if (!criteria.params.length)
                            {
                                continue;
                            };
                            mandatoryBreeds = this.getCriteriaParams(DareCriteriaTypeEnum.MANDATORY_BREEDS);
                            for each (breedId in criteria.params)
                            {
                                if (((breedId > 0) && (!(mandatoryBreeds.indexOf(breedId) == -1))))
                                {
                                    resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.classMandatoryForbidden"));
                                    this._criteriaOk = false;
                                    break;
                                };
                            };
                            criteria.warning = resultText;
                        }
                        else
                        {
                            if (criteria.type == DareCriteriaTypeEnum.MANDATORY_BREEDS)
                            {
                                if (!criteria.params.length)
                                {
                                    continue;
                                };
                                forbiddenBreeds = this.getCriteriaParams(DareCriteriaTypeEnum.FORBIDDEN_BREEDS);
                                for each (breedId in criteria.params)
                                {
                                    if (((breedId > 0) && (!(forbiddenBreeds.indexOf(breedId) == -1))))
                                    {
                                        resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.classMandatoryForbidden"));
                                        this._criteriaOk = false;
                                        break;
                                    };
                                };
                                maxCountChars = this.getCriteriaParams(DareCriteriaTypeEnum.MAX_COUNT_CHAR);
                                if (((maxCountChars.length) && (criteria.params.length > maxCountChars[0])))
                                {
                                    if (resultText != "")
                                    {
                                        resultText = (resultText + "\n");
                                    };
                                    resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.countCharMaxMandatory"));
                                    this._criteriaOk = false;
                                };
                                criteria.warning = resultText;
                            }
                            else
                            {
                                if (criteria.type == DareCriteriaTypeEnum.IDOLS)
                                {
                                    idolsName = "";
                                    idolsData = new Array();
                                    if (criteria.params.length)
                                    {
                                        for each (idolId in criteria.params)
                                        {
                                            if (idolId > 0)
                                            {
                                                idolsData.push(this.dataApi.getIdol(idolId));
                                            };
                                        };
                                    };
                                    maxCountChar = this.getCriteriaParams(DareCriteriaTypeEnum.MAX_COUNT_CHAR);
                                    if ((((maxCountChar) && (maxCountChar.length)) && (maxCountChar[0] <= ProtocolConstantsEnum.MIN_PLAYERS_FOR_GROUP_IDOLS)))
                                    {
                                        idolsName = "";
                                        for each (idolData in idolsData)
                                        {
                                            if (idolData.groupOnly)
                                            {
                                                idolsName = (idolsName + idolData.name);
                                                idolsName = (idolsName + ", ");
                                            };
                                        };
                                        if (idolsName != "")
                                        {
                                            idolsName = idolsName.slice(0, (idolsName.length - 2));
                                            resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.groupIdol", idolsName));
                                            this._criteriaOk = false;
                                        };
                                    };
                                    if (((monster) && (!(this.MONSTERS_INCOMPATIBLE_WITH_GROUP_IDOLS.indexOf(monster.id) == -1))))
                                    {
                                        idolsName = "";
                                        for each (idolData in idolsData)
                                        {
                                            if (idolData.groupOnly)
                                            {
                                                idolsName = (idolsName + idolData.name);
                                                idolsName = (idolsName + ", ");
                                            };
                                        };
                                        if (idolsName != "")
                                        {
                                            idolsName = idolsName.slice(0, (idolsName.length - 2));
                                            if (resultText != "")
                                            {
                                                resultText = (resultText + "\n");
                                            };
                                            resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.monsterIdol", idolsName));
                                            this._criteriaOk = false;
                                        };
                                    };
                                    if (this._incompatibleIdolsForThisMonster.indexOf(-1) != -1)
                                    {
                                        if (resultText != "")
                                        {
                                            resultText = (resultText + "\n");
                                        };
                                        resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.monsterNoIdol"));
                                        this._criteriaOk = false;
                                    };
                                    idolsName = "";
                                    for each (idolData in idolsData)
                                    {
                                        if (this._incompatibleIdolsForThisMonster.indexOf(idolData.id) != -1)
                                        {
                                            idolsName = (idolsName + idolData.name);
                                            idolsName = (idolsName + ", ");
                                        };
                                    };
                                    if (idolsName != "")
                                    {
                                        if (resultText != "")
                                        {
                                            resultText = (resultText + "\n");
                                        };
                                        idolsName = idolsName.slice(0, (idolsName.length - 2));
                                        resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.monsterIdol", idolsName));
                                        this._criteriaOk = false;
                                    };
                                    maxLevel = this.getCriteriaParams(DareCriteriaTypeEnum.MAX_CHAR_LVL);
                                    if (((((maxLevel) && (maxLevel.length)) && (maxLevel[0] > 0)) && (maxLevel[0] < 200)))
                                    {
                                        idolsName = "";
                                        for each (idolData in idolsData)
                                        {
                                            if (idolData.item.level > maxLevel[0])
                                            {
                                                idolsName = (idolsName + idolData.name);
                                                idolsName = (idolsName + ", ");
                                            };
                                        };
                                        if (idolsName != "")
                                        {
                                            idolsName = idolsName.slice(0, (idolsName.length - 2));
                                            if (resultText != "")
                                            {
                                                resultText = (resultText + "\n");
                                            };
                                            resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.idolMaxLevel", idolsName));
                                            this._criteriaOk = false;
                                        };
                                    };
                                    idolScore = this.getCriteriaParams(DareCriteriaTypeEnum.IDOLS_SCORE);
                                    if ((((idolScore) && (idolScore.length)) && (idolScore[0] > 0)))
                                    {
                                        if (resultText != "")
                                        {
                                            resultText = (resultText + "\n");
                                        };
                                        resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.idolsScore"));
                                        this._criteriaOk = false;
                                    };
                                    criteria.warning = resultText;
                                }
                                else
                                {
                                    if (criteria.type == DareCriteriaTypeEnum.IDOLS_SCORE)
                                    {
                                        if (criteria.params[0] == 0)
                                        {
                                            continue;
                                        };
                                        for each (criteriaType in this._criteriaTypeData)
                                        {
                                            if (criteriaType.id == criteria.type)
                                            {
                                                if (((criteriaType.minParameterBound > criteria.params[0]) || (criteriaType.maxParameterBound < criteria.params[0])))
                                                {
                                                    resultText = (resultText + ((criteriaType.name + this.uiApi.getText("ui.common.colon")) + this.uiApi.getText("ui.jobs.collectSkillInfos", criteriaType.minParameterBound, criteriaType.maxParameterBound)));
                                                    this._criteriaOk = false;
                                                };
                                                break;
                                            };
                                        };
                                        idols = this.getCriteriaParams(DareCriteriaTypeEnum.IDOLS);
                                        if (((idols) && (idols.length)))
                                        {
                                            if (resultText != "")
                                            {
                                                resultText = (resultText + "\n");
                                            };
                                            resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.idolsScore"));
                                            this._criteriaOk = false;
                                        };
                                        criteria.warning = resultText;
                                    }
                                    else
                                    {
                                        if (criteria.type == DareCriteriaTypeEnum.MAX_COUNT_CHAR)
                                        {
                                            if (criteria.params[0] == 0)
                                            {
                                                continue;
                                            };
                                            for each (criteriaType in this._criteriaTypeData)
                                            {
                                                if (criteriaType.id == criteria.type)
                                                {
                                                    if (((criteriaType.minParameterBound > criteria.params[0]) || (criteriaType.maxParameterBound < criteria.params[0])))
                                                    {
                                                        resultText = (resultText + ((criteriaType.name + this.uiApi.getText("ui.common.colon")) + this.uiApi.getText("ui.jobs.collectSkillInfos", criteriaType.minParameterBound, criteriaType.maxParameterBound)));
                                                        this._criteriaOk = false;
                                                    };
                                                    break;
                                                };
                                            };
                                            minCountChar = this.getCriteriaParams(DareCriteriaTypeEnum.MIN_COUNT_CHAR);
                                            if (((((minCountChar) && (minCountChar.length)) && (minCountChar[0] > 0)) && (minCountChar[0] > criteria.params[0])))
                                            {
                                                if (resultText != "")
                                                {
                                                    resultText = (resultText + "\n");
                                                };
                                                resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.countCharMaxToMin"));
                                                this._criteriaOk = false;
                                            };
                                            mandaroryBreeds = this.getCriteriaParams(DareCriteriaTypeEnum.MANDATORY_BREEDS);
                                            if (((mandaroryBreeds) && (criteria.params[0] < mandaroryBreeds.length)))
                                            {
                                                if (resultText != "")
                                                {
                                                    resultText = (resultText + "\n");
                                                };
                                                resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.countCharMaxMandatory"));
                                                this._criteriaOk = false;
                                            };
                                            minCountMonster = this.getCriteriaParams(DareCriteriaTypeEnum.MIN_COUNT_MONSTERS);
                                            if (((((minCountMonster) && (minCountMonster.length)) && (minCountMonster[0] > 0)) && (minCountMonster[0] > criteria.params[0])))
                                            {
                                                if (resultText != "")
                                                {
                                                    resultText = (resultText + "\n");
                                                };
                                                resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.countCharMonster"));
                                                this._criteriaOk = false;
                                            };
                                            criteria.warning = resultText;
                                        }
                                        else
                                        {
                                            if (criteria.type == DareCriteriaTypeEnum.MIN_COUNT_CHAR)
                                            {
                                                if (criteria.params[0] == 0)
                                                {
                                                    continue;
                                                };
                                                for each (criteriaType in this._criteriaTypeData)
                                                {
                                                    if (criteriaType.id == criteria.type)
                                                    {
                                                        if (((criteriaType.minParameterBound > criteria.params[0]) || (criteriaType.maxParameterBound < criteria.params[0])))
                                                        {
                                                            resultText = (resultText + ((criteriaType.name + this.uiApi.getText("ui.common.colon")) + this.uiApi.getText("ui.jobs.collectSkillInfos", criteriaType.minParameterBound, criteriaType.maxParameterBound)));
                                                            this._criteriaOk = false;
                                                        };
                                                        break;
                                                    };
                                                };
                                                maxCountChar = this.getCriteriaParams(DareCriteriaTypeEnum.MAX_COUNT_CHAR);
                                                if (((((maxCountChar) && (maxCountChar.length)) && (maxCountChar[0] > 0)) && (maxCountChar[0] < criteria.params[0])))
                                                {
                                                    if (resultText != "")
                                                    {
                                                        resultText = (resultText + "\n");
                                                    };
                                                    resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.countCharMaxToMin"));
                                                    this._criteriaOk = false;
                                                };
                                                criteria.warning = resultText;
                                            }
                                            else
                                            {
                                                if (criteria.type == DareCriteriaTypeEnum.MIN_COUNT_MONSTERS)
                                                {
                                                    if (criteria.params[0] == 0)
                                                    {
                                                        continue;
                                                    };
                                                    for each (criteriaType in this._criteriaTypeData)
                                                    {
                                                        if (criteriaType.id == criteria.type)
                                                        {
                                                            if (((criteriaType.minParameterBound > criteria.params[0]) || (criteriaType.maxParameterBound < criteria.params[0])))
                                                            {
                                                                resultText = (resultText + ((criteriaType.name + this.uiApi.getText("ui.common.colon")) + this.uiApi.getText("ui.jobs.collectSkillInfos", criteriaType.minParameterBound, criteriaType.maxParameterBound)));
                                                                this._criteriaOk = false;
                                                            };
                                                            break;
                                                        };
                                                    };
                                                    maxCountChar = this.getCriteriaParams(DareCriteriaTypeEnum.MAX_COUNT_CHAR);
                                                    if (((((maxCountChar) && (maxCountChar.length)) && (maxCountChar[0] > 0)) && (maxCountChar[0] < criteria.params[0])))
                                                    {
                                                        if (resultText != "")
                                                        {
                                                            resultText = (resultText + "\n");
                                                        };
                                                        resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.countCharMonster"));
                                                        this._criteriaOk = false;
                                                    };
                                                    if (((monster) && ((monster.isBoss) || (!(this.MONSTERS_INCOMPATIBLE_WITH_MIN_MONSTER_COUNT.indexOf(monster.id) == -1)))))
                                                    {
                                                        if (resultText != "")
                                                        {
                                                            resultText = (resultText + "\n");
                                                        };
                                                        resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.monsterNoMinMonsterCount"));
                                                        this._criteriaOk = false;
                                                    };
                                                    criteria.warning = resultText;
                                                }
                                                else
                                                {
                                                    if (((criteria.type == DareCriteriaTypeEnum.MAX_CHAR_LVL) || (criteria.type == DareCriteriaTypeEnum.MAX_FIGHT_TURNS)))
                                                    {
                                                        if (criteria.params[0] == 0)
                                                        {
                                                        }
                                                        else
                                                        {
                                                            for each (criteriaType in this._criteriaTypeData)
                                                            {
                                                                if (criteriaType.id == criteria.type)
                                                                {
                                                                    if (((criteriaType.minParameterBound > criteria.params[0]) || (criteriaType.maxParameterBound < criteria.params[0])))
                                                                    {
                                                                        resultText = (resultText + ((criteriaType.name + this.uiApi.getText("ui.common.colon")) + this.uiApi.getText("ui.jobs.collectSkillInfos", criteriaType.minParameterBound, criteriaType.maxParameterBound)));
                                                                        this._criteriaOk = false;
                                                                    };
                                                                    break;
                                                                };
                                                            };
                                                            if (((criteria.type == DareCriteriaTypeEnum.MAX_FIGHT_TURNS) && ((monster) && (!(this.MONSTERS_INCOMPATIBLE_WITH_MAX_FIGHT_TURNS.indexOf(monster.id) == -1)))))
                                                            {
                                                                if (resultText != "")
                                                                {
                                                                    resultText = (resultText + "\n");
                                                                };
                                                                resultText = (resultText + this.uiApi.getText("ui.dare.criteria.error.monsterNoMaxTurn"));
                                                                this._criteriaOk = false;
                                                            };
                                                            criteria.warning = resultText;
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
            this.updateValidationButton();
        }

        public function onSelectItem(target:Object, method:uint, isNew:Boolean):void
        {
            var data:Object;
            var restrictionType:int;
            var backEmblem:EmblemWrapper;
            var upEmblem:EmblemWrapper;
            var icon:EmblemSymbol;
            var alliance:AllianceWrapper;
            var guild:GuildWrapper;
            var item:Object;
            var paramIndex:int;
            var i:int;
            var criteriaPositionInDataProvider:int;
            var currentCriteriaParamsLength:int;
            if (((!(target == this.gd_searchResult)) && ((method == SelectMethodEnum.DOUBLE_CLICK) || (method == SelectMethodEnum.CLICK))))
            {
                this.clearSearchResults();
            };
            if (target == this.cb_restriction)
            {
                restrictionType = this.cb_restriction.selectedItem.id;
                if (restrictionType == 0)
                {
                    this._isForGuild = false;
                    this._isForAlliance = false;
                }
                else
                {
                    if (restrictionType == 1)
                    {
                        this._isForGuild = false;
                        this._isForAlliance = true;
                    }
                    else
                    {
                        if (restrictionType == 2)
                        {
                            this._isForGuild = true;
                            this._isForAlliance = false;
                        };
                    };
                };
                if (((restrictionType == 1) || (restrictionType == 2)))
                {
                    if (restrictionType == 1)
                    {
                        alliance = this.socialApi.getAlliance();
                        backEmblem = alliance.backEmblem;
                        upEmblem = alliance.upEmblem;
                    }
                    else
                    {
                        guild = this.socialApi.getGuild();
                        backEmblem = guild.backEmblem;
                        upEmblem = guild.upEmblem;
                    };
                    this.tx_emblemBack.uri = backEmblem.iconUri;
                    this.tx_emblemUp.uri = upEmblem.iconUri;
                    this.utilApi.changeColor(this.tx_emblemBack, backEmblem.color, 1);
                    icon = this.dataApi.getEmblemSymbol(upEmblem.idEmblem);
                    if (icon.colorizable)
                    {
                        this.utilApi.changeColor(this.tx_emblemUp, upEmblem.color, 0);
                    }
                    else
                    {
                        this.utilApi.changeColor(this.tx_emblemUp, upEmblem.color, 0, true);
                    };
                    this.ctr_guildalliance.visible = true;
                }
                else
                {
                    this.ctr_guildalliance.visible = false;
                };
                return;
            };
            if (target == this.gd_searchResult)
            {
                item = target.selectedItem;
                if (((method == SelectMethodEnum.DOUBLE_CLICK) || (method == SelectMethodEnum.CLICK)))
                {
                    this.clearSearchResults();
                    this.sysApi.log(2, ((((((((("click sur " + item.name) + " : index ") + this._currentCritLineIndex) + ", type ") + this._currentSearchCriteriaType) + ", id ") + item.data.id) + ", dernier param ") + this._criteria[this._currentCritLineIndex].lastModifiedParam));
                    paramIndex = -1;
                    if (item.selected)
                    {
                        i = 0;
                        while (i < this._criteria[this._currentCritLineIndex].params.length)
                        {
                            paramIndex = this._criteria[this._currentCritLineIndex].params.indexOf(item.data.id);
                            if (paramIndex != -1)
                            {
                                break;
                            };
                            i++;
                        };
                    };
                    this.modifyDareCriteriaParam(this._currentCritLineIndex, this._currentSearchCriteriaType, ((paramIndex == -1) ? item.data.id : 0), paramIndex);
                    if (this._currentSearchCriteriaType == DareCriteriaTypeEnum.CHALLENGE_ID)
                    {
                        this._currentSearchInput.text = item.data.name;
                    }
                    else
                    {
                        if (this._currentSearchCriteriaType != DareCriteriaTypeEnum.MONSTER_ID)
                        {
                            criteriaPositionInDataProvider = this._criteriaDataProviderIndexByCriteriaIndex[this._currentCritLineIndex];
                            currentCriteriaParamsLength = this.gd_criteria.dataProvider[criteriaPositionInDataProvider].params.length;
                            if (currentCriteriaParamsLength != (this._criteria[this._currentCritLineIndex].lastModifiedParamIndex + 1))
                            {
                                this._currentSearchInput.text = "";
                                this._currentSearchInput.focus();
                            }
                            else
                            {
                                if (currentCriteriaParamsLength > 1)
                                {
                                    this._currentSearchInput.text = this.INPUT_SEARCH_TEXT;
                                    this._currentSearchInput.caretIndex = -1;
                                    target.focus();
                                };
                            };
                        };
                    };
                }
                else
                {
                    if (((method == SelectMethodEnum.MANUAL) || (method == SelectMethodEnum.AUTO)))
                    {
                        this._addEntryHighlight = true;
                        this.gd_searchResult.updateItem(target.selectedIndex);
                    };
                };
            }
            else
            {
                if (target.name.indexOf("gd_data") != -1)
                {
                    data = this._gridComponents[target.name];
                    if (this._criteria[data.index])
                    {
                        this._criteria[data.index].lastModifiedParamIndex = target.selectedIndex;
                    };
                    this.sysApi.log(32, ((("clic sur " + target.name) + " sur la case ") + target.selectedIndex));
                    if (((method == SelectMethodEnum.DOUBLE_CLICK) || (method == SelectMethodEnum.CLICK)))
                    {
                        this.modifyDareCriteriaParam(data.index, data.criteria.id, 0, target.selectedIndex);
                    };
                }
                else
                {
                    if (target.name.indexOf("gd_slots") != -1)
                    {
                        data = this._gridComponents[target.name];
                        if (this._criteria[data.index])
                        {
                            this._criteria[data.index].lastModifiedParamIndex = target.selectedIndex;
                        };
                        this.sysApi.log(32, ((("clic sur " + target.name) + " sur la case ") + target.selectedIndex));
                        if (((method == SelectMethodEnum.DOUBLE_CLICK) || (method == SelectMethodEnum.CLICK)))
                        {
                            this.modifyDareCriteriaParam(data.index, data.criteria.id, 0, target.selectedIndex);
                        };
                    };
                };
            };
        }

        public function showTabHints():void
        {
            this.hintsApi.showSubHints();
        }

        public function onRelease(target:Object):void
        {
            var data:Object;
            var vectorCriteria:Vector.<Vector.<int>>;
            var o:Object;
            var crit:Vector.<int>;
            var param:int;
            var index:int;
            var o2:Object;
            if (target != this._currentSearchInput)
            {
                this.clearSearchResults();
            };
            if (target == this.btn_valid)
            {
                this.sysApi.log(2, "Validation de la création d'un défi !");
                this.sysApi.log(2, ((((((((((((((((("  Cagnotte " + this._jackpot) + ", frais ") + this._subscriptionFee) + ", gagnants ") + this._maxCountWinners) + ", durée ") + this._duration) + ", début dans ") + this._delayBeforeStart) + " jours, privé ") + this._isPrivate) + ", reservé guilde ") + this._isForGuild) + ", reservé alliance ") + this._isForAlliance) + ",  notif ") + this._needNotifications));
                vectorCriteria = new Vector.<Vector.<int>>();
                for each (o in this._criteria)
                {
                    crit = new Vector.<int>();
                    this.sysApi.log(2, ((("     - Critere " + o.type) + " : ") + o.params));
                    crit.push(o.type);
                    for each (param in o.params)
                    {
                        crit.push(param);
                    };
                    vectorCriteria.push(crit);
                };
                this.sysApi.sendAction(new DareCreationRequest(this._jackpot, this._subscriptionFee, this._maxCountWinners, ((this._delayBeforeStart * this.DAYS_TO_SECONDS) + (this._delayBeforeStartH * this.HOURS_TO_SECONDS)), ((this._duration * this.DAYS_TO_SECONDS) + (this._durationH * this.HOURS_TO_SECONDS)), this._isPrivate, this._isForGuild, this._isForAlliance, this._needNotifications, vectorCriteria));
            }
            else
            {
                if (target == this.btn_isPrivate)
                {
                    this._isPrivate = this.btn_isPrivate.selected;
                }
                else
                {
                    if (target == this.btn_needNotifications)
                    {
                        this._needNotifications = this.btn_needNotifications.selected;
                    }
                    else
                    {
                        if (target == this.inp_monster)
                        {
                            this.updateInputStates(this.inp_monster);
                        }
                        else
                        {
                            if (target == this.btn_closeMonster)
                            {
                                this.inp_monster.text = this.INPUT_SEARCH_TEXT;
                                this._currentCritLineIndex = 0;
                                this.clearSearchResults();
                                this.modifyDareCriteriaParam(0, DareCriteriaTypeEnum.MONSTER_ID, 0);
                            }
                            else
                            {
                                if (target.name.indexOf("inp_search") != -1)
                                {
                                    this.updateInputStates((target as Input));
                                    this.searchAll(target.text, this._currentSearchCriteriaType);
                                }
                                else
                                {
                                    if (target.name.indexOf("tx_type") != -1)
                                    {
                                        data = this._gridComponents[target.name];
                                        if (!data)
                                        {
                                            return;
                                        };
                                        if (data.id == 0)
                                        {
                                            return;
                                        };
                                        if (!data.selected)
                                        {
                                            if (this._criteria.length < ProtocolConstantsEnum.MAX_CRITERION_BY_DARE)
                                            {
                                                this.addDareCriteria(this._criteria.length, data.id);
                                            };
                                        }
                                        else
                                        {
                                            if (this.ctr_search.visible)
                                            {
                                                this.ctr_search.visible = false;
                                                clearTimeout(this._searchTimeoutId);
                                            };
                                            index = 0;
                                            for each (o2 in this._criteria)
                                            {
                                                if (o2.type == data.id)
                                                {
                                                    break;
                                                };
                                                index++;
                                            };
                                            this.removeDareCriteria(index);
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        private function updateInputStates(newInput:Input):void
        {
            var needInputTxtReset:Boolean = true;
            var data:Object = this._gridComponents[newInput.name];
            if (this._currentSearchInput)
            {
                if (this._currentSearchInput == this.inp_monster)
                {
                    if (this._chosenMonsterName)
                    {
                        needInputTxtReset = false;
                        this._currentSearchInput.text = this._chosenMonsterName;
                    };
                }
                else
                {
                    if (this._currentSearchCriteriaType == DareCriteriaTypeEnum.CHALLENGE_ID)
                    {
                        if (((this._criteria[this._currentCritLineIndex]) && (this._criteria[this._currentCritLineIndex].params.length)))
                        {
                            if (((((this._gridComponents[this._currentSearchInput.name]) && (this._gridComponents[this._currentSearchInput.name].params)) && (this._gridComponents[this._currentSearchInput.name].params.length)) && (this._gridComponents[this._currentSearchInput.name].params[0])))
                            {
                                needInputTxtReset = false;
                                this._currentSearchInput.text = this._gridComponents[this._currentSearchInput.name].params[0].name;
                            };
                        };
                    };
                };
                if (this._currentSearchInput != newInput)
                {
                    if (needInputTxtReset)
                    {
                        this._currentSearchInput.text = this.INPUT_SEARCH_TEXT;
                        this.clearSearchResults();
                    };
                };
            };
            this._currentSearchInput = newInput;
            if (this._currentSearchInput.text == this.INPUT_SEARCH_TEXT)
            {
                this._currentSearchInput.text = "";
            };
            if (data)
            {
                this._currentCritLineIndex = data.index;
                this._currentSearchCriteriaType = data.criteria.id;
            }
            else
            {
                this._currentCritLineIndex = 0;
                this._currentSearchCriteriaType = DareCriteriaTypeEnum.MONSTER_ID;
            };
        }

        private function clearSearchResults():void
        {
            if (this.ctr_search.visible)
            {
                clearTimeout(this._searchTimeoutId);
                this._searchCriteria = "";
                this._lastSearch = "";
                this.ctr_search.visible = false;
            };
        }

        public function onRollOver(target:Object):void
        {
            var data:Object;
            var dataTooltip:Object;
            var textTooltip:String = "";
            var cacheName:String = "TextInfo";
            var makerParams:Object;
            if (target == this.inp_jackpot)
            {
                if (this._notEnoughMoney)
                {
                    textTooltip = this.uiApi.getText("ui.dare.jackpot.notEnoughMoney");
                }
                else
                {
                    if (this._wrongJackpot)
                    {
                        textTooltip = this.uiApi.getText("ui.dare.jackpot.wrongTotal", ProtocolConstantsEnum.MIN_DARE_JACKPOT_VALUE);
                    }
                    else
                    {
                        textTooltip = this.uiApi.getText("ui.dare.info.jackpot");
                    };
                };
            };
            if (target == this.btn_isPrivate)
            {
                textTooltip = this.uiApi.getText("ui.dare.info.privateCreation");
            };
            if (target == this.lbl_feeInfo)
            {
                textTooltip = this.uiApi.getText("ui.dare.info.fees");
            };
            if (target == this.lbl_maxCountWinnersInfo)
            {
                textTooltip = this.uiApi.getText("ui.dare.info.maxWinners");
            };
            if (target == this.lbl_durationInfo)
            {
                textTooltip = this.uiApi.getText("ui.dare.info.duration");
            };
            if (target == this.lbl_delayBeforeStartInfo)
            {
                textTooltip = this.uiApi.getText("ui.dare.info.timeBeforeStart");
            };
            if (((target == this.cb_restriction) && (this.cb_restriction.softDisabled)))
            {
                textTooltip = this.uiApi.getText("ui.dare.info.restriction");
            };
            if (target == this.ctr_guildalliance)
            {
                if (this._isForGuild)
                {
                    textTooltip = this.socialApi.getGuild().guildName;
                }
                else
                {
                    if (this._isForAlliance)
                    {
                        textTooltip = this.socialApi.getAlliance().allianceName;
                    };
                };
            }
            else
            {
                if (target.name.indexOf("ctr_breed") != -1)
                {
                    data = this._gridComponents[target.name];
                    if (((data) && (data.id > 0)))
                    {
                        textTooltip = data.name;
                    };
                }
                else
                {
                    if (target.name.indexOf("tx_warning") != -1)
                    {
                        data = this._gridComponents[target.name];
                        if (((data) && (!(data.warning == ""))))
                        {
                            textTooltip = data.warning;
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("tx_type") != -1)
                        {
                            data = this._gridComponents[target.name];
                            if (((data) && (!(data.label == ""))))
                            {
                                textTooltip = data.label;
                                if (data.selected)
                                {
                                    textTooltip = (textTooltip + ("\n" + this.uiApi.getText("ui.dare.deleteCriteria")));
                                };
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("btn_result_m_gd_searchResult") == 0)
                            {
                                data = this._gridComponents[target.name];
                                if (((data) && (data.hasOwnProperty("tooltipData"))))
                                {
                                    if ((data.tooltipData is ItemWrapper))
                                    {
                                        makerParams = this.tooltipApi.createItemSettings();
                                        makerParams.header = false;
                                        makerParams.averagePrice = false;
                                        makerParams.description = false;
                                        dataTooltip = data.tooltipData;
                                        cacheName = null;
                                    }
                                    else
                                    {
                                        if ((data.tooltipData is ChallengeWrapper))
                                        {
                                            makerParams = {"effects":false};
                                            dataTooltip = data.tooltipData;
                                            cacheName = null;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (((!(textTooltip == "")) || (dataTooltip)))
            {
                this.uiApi.showTooltip(((textTooltip) ? this.uiApi.textTooltipInfo(textTooltip) : dataTooltip), target, false, "standard", 6, 0, 3, null, null, makerParams, cacheName);
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if ((((((this._currentSearchInput) && (this._currentSearchInput.haveFocus)) && (!(keyCode == Keyboard.ENTER))) && (!(keyCode == Keyboard.UP))) && (!(keyCode == Keyboard.DOWN))))
            {
                this._searchCriteria = target.text;
                clearTimeout(this._searchTimeoutId);
                this._searchTimeoutId = setTimeout(this.searchAll, 500, this._searchCriteria, this._currentSearchCriteriaType);
            };
        }

        public function onKeyDown(target:Object, keyCode:uint):void
        {
            var selectedIndex:int;
            if (((((this.ctr_search.visible) && (this._currentSearchInput)) && (this._currentSearchInput.haveFocus)) && (this.gd_searchResult.dataProvider.length > 0)))
            {
                selectedIndex = this.gd_searchResult.selectedIndex;
                if (keyCode == Keyboard.UP)
                {
                    this._removeEntryHighlight = true;
                    this.gd_searchResult.updateItem(selectedIndex);
                    selectedIndex--;
                    if (selectedIndex < 0)
                    {
                        selectedIndex = 0;
                    };
                    this.gd_searchResult.selectedIndex = selectedIndex;
                }
                else
                {
                    if (keyCode == Keyboard.DOWN)
                    {
                        this._removeEntryHighlight = true;
                        this.gd_searchResult.updateItem(selectedIndex);
                        selectedIndex++;
                        if (selectedIndex > (this.gd_searchResult.dataProvider.length - 1))
                        {
                            selectedIndex = (this.gd_searchResult.dataProvider.length - 1);
                        };
                        this.gd_searchResult.selectedIndex = selectedIndex;
                    }
                    else
                    {
                        if (keyCode == Keyboard.ENTER)
                        {
                            this.onSelectItem(this.gd_searchResult, SelectMethodEnum.CLICK, false);
                        };
                    };
                };
            };
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
                    "point":LocationEnum.POINT_BOTTOM,
                    "relativePoint":LocationEnum.POINT_TOP
                };
                if ((item.data is ItemWrapper))
                {
                    this.uiApi.showTooltip(item.data, target, false, "standard", 8, 0, 0, "itemName", null, {
                        "showEffects":true,
                        "header":true
                    }, "ItemInfo");
                    return;
                };
            }
            else
            {
                if (target.name.indexOf("gd_data") != -1)
                {
                    text = this.uiApi.getText(item.data.name);
                    if (text)
                    {
                        this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
                    };
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onChange(target:GraphicContainer):void
        {
            var data:Object;
            if (!(target as Input))
            {
                return;
            };
            var value:Number = this.utilApi.stringToKamas((target as Input).text, "");
            if (target == this.inp_jackpot)
            {
                if (((value > ProtocolConstantsEnum.MAX_KAMA) || (value < 0)))
                {
                    value = ProtocolConstantsEnum.MAX_KAMA;
                    (target as Input).text = this.utilApi.kamasToString(value, "");
                };
                if (value != this._jackpot)
                {
                    this.checkPlayerFund(value);
                };
                this._jackpot = value;
            }
            else
            {
                if (target == this.inp_fee)
                {
                    if (((value > ProtocolConstantsEnum.MAX_KAMA) || (value < 0)))
                    {
                        value = ProtocolConstantsEnum.MAX_KAMA;
                        (target as Input).text = this.utilApi.kamasToString(value, "");
                    };
                    this._subscriptionFee = value;
                }
                else
                {
                    if (target == this.inp_maxCountWinners)
                    {
                        if (((value > ProtocolConstantsEnum.MAX_DARE_WINNERS) || (value < 0)))
                        {
                            value = ProtocolConstantsEnum.MAX_DARE_WINNERS;
                            (target as Input).text = this.utilApi.kamasToString(value, "");
                        };
                        this._maxCountWinners = value;
                    }
                    else
                    {
                        if (target == this.inp_duration)
                        {
                            if (((value > (ProtocolConstantsEnum.MAX_DARE_DURATION - 1)) && (this._durationH > 0)))
                            {
                                value = (ProtocolConstantsEnum.MAX_DARE_DURATION - 1);
                                (target as Input).text = ("" + value);
                            }
                            else
                            {
                                if (value > ProtocolConstantsEnum.MAX_DARE_DURATION)
                                {
                                    value = ProtocolConstantsEnum.MAX_DARE_DURATION;
                                    (target as Input).text = ("" + value);
                                };
                            };
                            this._duration = value;
                            if (((this._duration == 0) && (this._durationH == 0)))
                            {
                                this.inp_durationH.text = "1";
                                this._durationH = 1;
                            };
                        }
                        else
                        {
                            if (target == this.inp_durationH)
                            {
                                if (value > this.MAX_HOURS)
                                {
                                    value = this.MAX_HOURS;
                                    (target as Input).text = ("" + value);
                                };
                                this._durationH = value;
                                if (((value > 0) && (this._duration == ProtocolConstantsEnum.MAX_DARE_DURATION)))
                                {
                                    this._duration = (ProtocolConstantsEnum.MAX_DARE_DURATION - 1);
                                    this.inp_duration.text = ("" + this._duration);
                                };
                                if (((this._duration == 0) && (this._durationH == 0)))
                                {
                                    this.inp_duration.text = "1";
                                    this._duration = 1;
                                };
                            }
                            else
                            {
                                if (target == this.inp_delayBeforeStart)
                                {
                                    if (value > ProtocolConstantsEnum.MAX_DARE_DURATION)
                                    {
                                        value = ProtocolConstantsEnum.MAX_DARE_DURATION;
                                        (target as Input).text = ("" + value);
                                    };
                                    this._delayBeforeStart = value;
                                }
                                else
                                {
                                    if (target == this.inp_delayBeforeStartH)
                                    {
                                        if (value > this.MAX_HOURS)
                                        {
                                            value = this.MAX_HOURS;
                                            (target as Input).text = ("" + value);
                                        };
                                        this._delayBeforeStartH = value;
                                    }
                                    else
                                    {
                                        if (target.name.indexOf("inp_value") != -1)
                                        {
                                            data = this._gridComponents[target.name];
                                            if (data)
                                            {
                                                if (!this._criteria[data.index])
                                                {
                                                    return;
                                                };
                                                if ((((this._criteria[data.index].params.length == 0) && (value > 0)) || ((this._criteria[data.index].params.length > 0) && (!(value == this._criteria[data.index].params[0])))))
                                                {
                                                    this._currentCritLineIndex = data.index;
                                                    this.modifyDareCriteriaParam(this._currentCritLineIndex, data.criteria.id, value);
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

        protected function checkPlayerFund(kamasRequired:Number):void
        {
            var playerFunds:Number = this.playerApi.characteristics().kamas;
            var ktext:String = this.inp_jackpot.text;
            this._wrongJackpot = false;
            if (((kamasRequired < ProtocolConstantsEnum.MIN_DARE_JACKPOT_VALUE) && (!(kamasRequired == 0))))
            {
                if (this.inp_jackpot.cssClass != "redright")
                {
                    this.inp_jackpot.cssClass = "redright";
                    this.inp_jackpot.text = ktext;
                };
                this._wrongJackpot = true;
            }
            else
            {
                if ((kamasRequired + ProtocolConstantsEnum.DARE_CREATION_TAX) > playerFunds)
                {
                    if (this.inp_jackpot.cssClass != "redright")
                    {
                        this.inp_jackpot.cssClass = "redright";
                        this.inp_jackpot.text = ktext;
                    };
                    this._notEnoughMoney = true;
                }
                else
                {
                    if (this.inp_jackpot.cssClass != "right")
                    {
                        this.inp_jackpot.cssClass = "right";
                        this.inp_jackpot.text = ktext;
                    };
                    this._notEnoughMoney = false;
                };
            };
            this.lbl_creationCost.text = this.utilApi.kamasToString((kamasRequired + ProtocolConstantsEnum.DARE_CREATION_TAX), "");
            this.updateValidationButton();
        }

        protected function updateValidationButton():void
        {
            if (((((this._notEnoughMoney) || (this._noMonsterSelected)) || (!(this._criteriaOk))) || (this._wrongJackpot)))
            {
                this.btn_valid.disabled = true;
            }
            else
            {
                this.btn_valid.disabled = false;
            };
        }

        public function onDareCreated(result:Boolean, dareId:Number=0):void
        {
            if (result)
            {
                this._saveOnUnload = false;
                Social.getInstance().dareCreationStatus = null;
                Dare.getInstance().openSelectedTab(2, [dareId.toString(), "searchFilterId"]);
            };
        }

        private function onGuildAllianceMembershipUpdated(value:Boolean):void
        {
            this._isForGuild = false;
            this._isForAlliance = false;
            var hasGuild:Boolean = this.socialApi.hasGuild();
            var hasAlliance:Boolean = this.socialApi.hasAlliance();
            var restrictionTypeNames:Array = new Array();
            restrictionTypeNames.push({
                "id":0,
                "label":this.uiApi.getText("ui.dare.restriction.everyoneAllowed")
            });
            if (hasAlliance)
            {
                restrictionTypeNames.push({
                    "id":1,
                    "label":this.uiApi.getText("ui.dare.restriction.alliance")
                });
            };
            if (hasGuild)
            {
                restrictionTypeNames.push({
                    "id":2,
                    "label":this.uiApi.getText("ui.dare.restriction.guild")
                });
            };
            this.cb_restriction.dataProvider = restrictionTypeNames;
            this.cb_restriction.value = this.cb_restriction.dataProvider[0];
            if (((!(hasGuild)) && (!(hasAlliance))))
            {
                this.cb_restriction.softDisabled = true;
            }
            else
            {
                this.cb_restriction.softDisabled = false;
            };
        }


    }
} Ankama_Social.ui

