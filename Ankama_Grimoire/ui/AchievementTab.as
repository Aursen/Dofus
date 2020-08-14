package Ankama_Grimoire.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.QuestApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.ProgressBar;
    import com.ankamagames.dofus.datacenter.quest.AchievementCategory;
    import com.ankamagames.dofus.network.types.game.guild.GuildMember;
    import d2hooks.AchievementList;
    import d2hooks.AchievementDetailedList;
    import d2hooks.AchievementDetails;
    import d2hooks.AchievementFinished;
    import d2hooks.OpenBook;
    import d2hooks.AchievementRewardSuccess;
    import d2hooks.GuildInformationsMemberUpdate;
    import d2hooks.KeyUp;
    import d2hooks.FocusChange;
    import d2enums.ComponentHookList;
    import flash.events.TimerEvent;
    import Ankama_Grimoire.Grimoire;
    import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
    import d2actions.AchievementDetailsRequest;
    import com.ankamagames.dofus.datacenter.quest.AchievementObjective;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.internalDatacenter.appearance.TitleWrapper;
    import com.ankamagames.dofus.internalDatacenter.appearance.OrnamentWrapper;
    import com.ankamagames.berilia.components.Slot;
    import com.ankamagames.dofus.datacenter.quest.Achievement;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.datacenter.quest.AchievementReward;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.datacenter.communication.Emoticon;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.datacenter.appearance.Title;
    import com.ankamagames.dofus.datacenter.appearance.Ornament;
    import com.ankamagames.dofus.internalDatacenter.quest.AchievementRewardsWrapper;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementAchievedRewardable;
    import d2actions.AchievementDetailedListRequest;
    import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
    import com.ankamagames.berilia.types.LocationEnum;
    import flash.ui.Keyboard;
    import d2hooks.MouseShiftClick;
    import d2actions.AchievementRewardRequest;
    import com.ankamagames.dofus.datacenter.idols.Idol;
    import flash.utils.clearTimeout;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
    import d2hooks.*;
    import d2actions.*;

    public class AchievementTab 
    {

        private static var CTR_CAT_TYPE_CAT:String = "ctr_cat";
        private static var CTR_CAT_TYPE_SUBCAT:String = "ctr_subCat";
        private static var CTR_ACH_ACHIEVEMENT:String = "ctr_achievement";
        private static var CTR_ACH_OBJECTIVES:String = "ctr_objectives";
        private static var CTR_ACH_REWARDS:String = "ctr_rewards";
        private static var CTR_ACH_EMPTY:String = "ctr_empty";
        private static const TEMPORIS_4_CATEGORY:uint = 107;
        private static var GAUGE_WIDTH_OBJECTIVE:int;
        private static var GAUGE_WIDTH_CATEGORY:int;
        private static var GAUGE_WIDTH_TOTAL:int;
        private static const CHARACTER_DISPLAY:int = 0;
        private static const ACCOUNT_DISPLAY:int = 1;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="QuestApi")]
        public var questApi:QuestApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var _displayMode:int;
        private var _successPointsByDisplayMode:Array = new Array();
        private var _finishedAchievementsIdByDisplayMode:Array = new Array();
        private var _progressCategoriesByDisplayMode:Array = new Array();
        private var _totalSuccessPoints:int;
        private var _openCatIndex:int;
        private var _currentSelectedCatId:int;
        private var _selectedAchievementId:int;
        private var _selectedAndOpenedAchievementId:int;
        private var _myGuildXp:int;
        private var _hideAchievedAchievement:Boolean = true;
        private var _lockSearchTimer:Timer;
        private var _previousSearchCriteria:String;
        private var _categories:Array = new Array();
        private var _objectivesTextByAchievementId:Array = new Array();
        private var _searchCriteria:String;
        private var _forceOpenAchievement:Boolean;
        private var _currentScrollValue:int;
        private var _catFinishedAchievements:Dictionary = new Dictionary(true);
        private var _catProgressingAchievements:Dictionary = new Dictionary(true);
        private var _catIlluBtnList:Dictionary = new Dictionary(true);
        private var _catProgressBarList:Dictionary = new Dictionary(true);
        private var _ctrAchPointsList:Dictionary = new Dictionary(true);
        private var _ctrAchBtnsList:Dictionary = new Dictionary(true);
        private var _ctrTxList:Dictionary = new Dictionary(true);
        private var _rewardsListList:Dictionary = new Dictionary(true);
        private var _btnsAcceptRewardList:Dictionary = new Dictionary(true);
        private var _ctrObjectiveMetaList:Dictionary = new Dictionary(true);
        private var _dataAchievements:Array;
        private var _dataCategories:Array;
        private var _progressPopupName:String;
        private var _searchSettimoutId:uint;
        private var _searchTextByCriteriaList:Dictionary = new Dictionary(true);
        private var _searchResultByCriteriaList:Dictionary = new Dictionary(true);
        private var _searchOnName:Boolean;
        private var _searchOnObjective:Boolean;
        private var _searchOnReward:Boolean;
        private var _checkedUri:Object;
        private var _uncheckedUri:Object;
        private var _focusOnSearch:Boolean = false;
        private var _isTemporisSpellsUi:Boolean = false;
        public var ctr_achievements:GraphicContainer;
        public var ctr_summary:GraphicContainer;
        public var ctr_globalProgress:GraphicContainer;
        public var gd_categories:Grid;
        public var gd_achievements:Grid;
        public var gd_summary:Grid;
        public var btn_tabAccount:ButtonContainer;
        public var btn_tabCharacter:ButtonContainer;
        public var btn_closeSearch:ButtonContainer;
        public var btn_searchFilter:ButtonContainer;
        public var btn_hideCompletedAchievements:ButtonContainer;
        public var inp_search:Input;
        public var tx_inputBg_search:TextureBitmap;
        public var lbl_noAchievement:Label;
        public var lbl_myPoints:Label;
        public var lbl_titleProgress:Label;
        public var lbl_percent:Label;
        public var pb_progress:ProgressBar;


        public function main(oParam:Object=null):void
        {
            var hasChild:Boolean;
            var cat:AchievementCategory;
            var mainCat:Object;
            var myMemberInfo:GuildMember;
            var myId:Number;
            var memberInfo:GuildMember;
            var category:AchievementCategory;
            this._isTemporisSpellsUi = this.dataApi.isTemporisSpellsUi();
            this.sysApi.addHook(AchievementList, this.onAchievementList);
            this.sysApi.addHook(AchievementDetailedList, this.onAchievementDetailedList);
            this.sysApi.addHook(AchievementDetails, this.onAchievementDetails);
            this.sysApi.addHook(AchievementFinished, this.onAchievementFinished);
            this.sysApi.addHook(OpenBook, this.onOpenAchievement);
            this.sysApi.addHook(AchievementRewardSuccess, this.onAchievementRewardSuccess);
            this.sysApi.addHook(GuildInformationsMemberUpdate, this.onGuildInformationsMemberUpdate);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.sysApi.addHook(FocusChange, this.onFocusChange);
            this.uiApi.addComponentHook(this.gd_categories, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btn_hideCompletedAchievements, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.lbl_myPoints, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_myPoints, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_globalProgress, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_globalProgress, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.inp_search, ComponentHookList.ON_RELEASE);
            GAUGE_WIDTH_OBJECTIVE = int(this.uiApi.me().getConstant("gauge_width_objective"));
            GAUGE_WIDTH_CATEGORY = int(this.uiApi.me().getConstant("gauge_width_category"));
            GAUGE_WIDTH_TOTAL = int(this.uiApi.me().getConstant("gauge_width_total"));
            this._checkedUri = this.uiApi.createUri(this.uiApi.me().getConstant("tx_checked"));
            this._uncheckedUri = this.uiApi.createUri(this.uiApi.me().getConstant("tx_unchecked"));
            this._lockSearchTimer = new Timer(500, 1);
            this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            this.btn_hideCompletedAchievements.selected = this._hideAchievedAchievement;
            this._searchOnName = Grimoire.getInstance().achievementSearchOnName;
            this._searchOnObjective = Grimoire.getInstance().achievementSearchOnObjective;
            this._searchOnReward = Grimoire.getInstance().achievementSearchOnReward;
            this.inp_search.text = this.uiApi.getText("ui.common.search.input");
            this._searchTextByCriteriaList["_searchOnName"] = this.uiApi.getText("ui.common.name");
            this._searchTextByCriteriaList["_searchOnObjective"] = this.uiApi.getText("ui.grimoire.quest.objectives");
            this._searchTextByCriteriaList["_searchOnReward"] = this.uiApi.getText("ui.common.rewards");
            this._progressCategoriesByDisplayMode = new Array();
            this._finishedAchievementsIdByDisplayMode = new Array();
            this._successPointsByDisplayMode = new Array();
            this._progressCategoriesByDisplayMode[ACCOUNT_DISPLAY] = new Array();
            this._progressCategoriesByDisplayMode[CHARACTER_DISPLAY] = new Array();
            this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY] = new Array();
            this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY] = new Array();
            this.sysApi.getPlayerManager().serverSeason = ((this.sysApi.getCurrentServer().gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS) ? this.dataApi.getCurrentSeason() : null);
            this._dataAchievements = this.dataApi.getAchievements();
            var i:int;
            while (i < this._dataAchievements.length)
            {
                if (this._dataAchievements[i].category.visible)
                {
                    this._totalSuccessPoints = (this._totalSuccessPoints + this._dataAchievements[i].points);
                }
                else
                {
                    this._dataAchievements.removeAt(i);
                    i--;
                };
                i++;
            };
            this._dataCategories = this.dataApi.getAchievementCategories();
            i = 0;
            while (i < this._dataCategories.length)
            {
                if (!this._dataCategories[i].visible)
                {
                    this._dataCategories.removeAt(i);
                    i--;
                }
                else
                {
                    if (this._dataCategories[i].parentId == 0)
                    {
                        this._categories.push({
                            "id":this._dataCategories[i].id,
                            "name":this._dataCategories[i].name,
                            "icon":this._dataCategories[i].icon,
                            "achievements":this._dataCategories[i].achievements,
                            "subcats":new Array(),
                            "color":this._dataCategories[i].color,
                            "order":this._dataCategories[i].order
                        });
                    };
                };
                i++;
            };
            this._categories.sortOn("order", Array.NUMERIC);
            this._categories.splice(0, 0, {
                "id":0,
                "name":this.uiApi.getText("ui.achievement.synthesis"),
                "achievements":null,
                "subcats":null
            });
            for each (mainCat in this._categories)
            {
                hasChild = false;
                for each (cat in this._dataCategories)
                {
                    if ((((!(mainCat.id == 0)) && (cat.parentId == mainCat.id)) && (!((this._isTemporisSpellsUi) && (cat.id === TEMPORIS_4_CATEGORY)))))
                    {
                        mainCat.subcats.push({
                            "id":cat.id,
                            "name":cat.name,
                            "parentId":cat.parentId,
                            "achievements":cat.achievements,
                            "order":cat.order
                        });
                        hasChild = true;
                    };
                };
                if (hasChild)
                {
                    mainCat.name = (mainCat.name + " (+)");
                };
                if (mainCat.id != 0)
                {
                    mainCat.subcats.sortOn("order", Array.NUMERIC);
                };
            };
            this.questApi.refreshAchievementsCriterions();
            this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY] = this.questApi.getFinishedAccountAchievementIds();
            this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY] = this.questApi.getFinishedCharacterAchievementIds();
            this.gd_categories.dataProvider = this._categories;
            if (this.socialApi.hasGuild())
            {
                myId = this.playerApi.id();
                for each (memberInfo in this.socialApi.getGuildMembers())
                {
                    if (memberInfo.id == myId)
                    {
                        myMemberInfo = memberInfo;
                        break;
                    };
                };
                this._myGuildXp = myMemberInfo.experienceGivenPercent;
            };
            this._hideAchievedAchievement = this.sysApi.getData("hideCompletedAchievements");
            this.btn_hideCompletedAchievements.selected = this._hideAchievedAchievement;
            this._objectivesTextByAchievementId = Grimoire.getInstance().objectivesTextByAchievement;
            var openAchId:int;
            var lastAchievementSearchCriteria:String = Grimoire.getInstance().lastAchievementSearchCriteria;
            var lastAchievementOpenedId:int = Grimoire.getInstance().lastAchievementOpenedId;
            var lastAchievementCategoryOpenedId:int = Grimoire.getInstance().lastAchievementCategoryOpenedId;
            var lastAchievementScrollValue:int = Grimoire.getInstance().lastAchievementScrollValue;
            if (((oParam) && (oParam.achievementId)))
            {
                openAchId = oParam.achievementId;
            }
            else
            {
                if (((lastAchievementSearchCriteria) && (!(lastAchievementSearchCriteria == ""))))
                {
                    this._searchCriteria = lastAchievementSearchCriteria.toLowerCase();
                    this.inp_search.text = this._searchCriteria;
                    this._currentScrollValue = lastAchievementScrollValue;
                    if (lastAchievementOpenedId > 0)
                    {
                        this.sysApi.sendAction(new AchievementDetailsRequest(lastAchievementOpenedId));
                        this._selectedAchievementId = lastAchievementOpenedId;
                    };
                    this.updateAchievementGrid(this._currentSelectedCatId);
                }
                else
                {
                    if (lastAchievementOpenedId > 0)
                    {
                        openAchId = lastAchievementOpenedId;
                    }
                    else
                    {
                        if (lastAchievementCategoryOpenedId > 0)
                        {
                            this._currentScrollValue = lastAchievementScrollValue;
                            category = this.dataApi.getAchievementCategory(lastAchievementCategoryOpenedId);
                            this.updateCategories(category, true);
                        };
                    };
                };
            };
            if (openAchId > 0)
            {
                this._selectedAchievementId = openAchId;
                this._forceOpenAchievement = true;
            };
            if ((((openAchId > 0) || (lastAchievementCategoryOpenedId > 0)) || (this._searchCriteria)))
            {
                this.ctr_achievements.visible = true;
                this.ctr_summary.visible = false;
            }
            else
            {
                this.gd_categories.selectedIndex = 0;
                this.ctr_achievements.visible = false;
                this.ctr_summary.visible = true;
            };
            this.onAchievementList();
            this.displayAccountMode(this.sysApi.getData("achievementAccountDisplayMode"), true);
        }

        public function unload():void
        {
            if (this._lockSearchTimer)
            {
                this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
                this._lockSearchTimer.stop();
                this._lockSearchTimer = null;
            };
            this.sysApi.setData("hideCompletedAchievements", this._hideAchievedAchievement);
            Grimoire.getInstance().lastAchievementSearchCriteria = this._searchCriteria;
            Grimoire.getInstance().lastAchievementCategoryOpenedId = this._currentSelectedCatId;
            Grimoire.getInstance().lastAchievementOpenedId = this._selectedAndOpenedAchievementId;
            Grimoire.getInstance().lastAchievementScrollValue = this.gd_achievements.verticalScrollValue;
        }

        public function showTabHints():void
        {
            this.hintsApi.showSubHints();
        }

        public function updateSummary(data:*, componentsRef:*, selected:Boolean):void
        {
            var percentStr:String;
            var id:String;
            var percent:Number;
            if (!this._catIlluBtnList[componentsRef.ctr_illu.name])
            {
                this.uiApi.addComponentHook(componentsRef.ctr_illu, ComponentHookList.ON_RELEASE);
            };
            this._catIlluBtnList[componentsRef.ctr_illu.name] = data;
            if (!this._catProgressBarList[componentsRef.ctr_progress.name])
            {
                this.uiApi.addComponentHook(componentsRef.ctr_progress, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.ctr_progress, ComponentHookList.ON_ROLL_OUT);
            };
            this._catProgressBarList[componentsRef.ctr_progress.name] = data;
            if (data)
            {
                this.sysApi.log(1, (((" - " + data.name) + "  ") + data.value));
                if (data.total > 0)
                {
                    percent = Math.floor(((data.value / data.total) * 100));
                    if (percent > 100)
                    {
                        percent = 100;
                    };
                    percentStr = percent.toString();
                }
                else
                {
                    percentStr = "-";
                };
                componentsRef.lbl_name.text = data.name;
                componentsRef.lbl_percent.text = (percentStr + "%");
                id = data.icon.replace("cat_", "");
                if (!id.length)
                {
                    id = "7";
                };
                componentsRef.tx_illu.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("illusUi") + "success_illu_") + id) + ".png"));
                componentsRef.tx_icon.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("success") + "success_") + data.icon) + ".png"));
                componentsRef.ctr_illu.handCursor = true;
                componentsRef.pb_progress.value = (percent / 100);
                componentsRef.ctr_summary.visible = true;
            }
            else
            {
                componentsRef.ctr_summary.visible = false;
            };
        }

        public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            var finishedNb:int;
            var totalNb:int;
            var ach:Object;
            var percentStr:String;
            var percent:int;
            if (!this._catProgressBarList[componentsRef.lbl_catPercent.name])
            {
                this.uiApi.addComponentHook(componentsRef.lbl_catPercent, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.lbl_catPercent, ComponentHookList.ON_ROLL_OUT);
                this.uiApi.addComponentHook(componentsRef.lbl_catPercent, ComponentHookList.ON_RELEASE);
            };
            this._catProgressBarList[componentsRef.lbl_catPercent.name] = data;
            switch (this.getCatLineType(data, line))
            {
                case CTR_CAT_TYPE_CAT:
                    if (data.icon)
                    {
                        componentsRef.tx_catIcon.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("success") + "success_") + data.icon) + ".png"));
                    }
                    else
                    {
                        componentsRef.tx_catIcon.uri = null;
                    };
                case CTR_CAT_TYPE_SUBCAT:
                    componentsRef.lbl_catName.text = data.name;
                    finishedNb = 0;
                    totalNb = 0;
                    if ((((data.id > 0) && (data.achievements)) && (data.achievements.length > 0)))
                    {
                        for each (ach in data.achievements)
                        {
                            if (ach)
                            {
                                totalNb++;
                                if (this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(ach.id) != -1)
                                {
                                    finishedNb++;
                                };
                            };
                        };
                        if (totalNb > 0)
                        {
                            percent = int(Math.floor(((finishedNb / totalNb) * 100)));
                            percentStr = percent.toString();
                        }
                        else
                        {
                            percentStr = "-";
                        };
                        componentsRef.lbl_catPercent.text = (percentStr + "%");
                    }
                    else
                    {
                        componentsRef.lbl_catPercent.text = "";
                    };
                    componentsRef.btn_cat.selected = selected;
                    break;
            };
        }

        public function getCatLineType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("");
            };
            if (((data) && (data.hasOwnProperty("subcats"))))
            {
                return (CTR_CAT_TYPE_CAT);
            };
            return (CTR_CAT_TYPE_SUBCAT);
        }

        public function getCatDataLength(data:*, selected:Boolean):*
        {
            return (2 + ((selected) ? data.subcats.length : 0));
        }

        public function updateAchievement(data:*, compRef:*, selected:Boolean, line:uint):void
        {
            var achievementObjectiveId:int;
            var achievementObjective:AchievementObjective;
            var monster:Monster;
            var ach:Object;
            var objective:Object;
            var completed:Boolean;
            var obj:Object;
            var rewardData:Object;
            var rewardsSlotContent:Array;
            var firstXPosition:int;
            var indexOA:int;
            var lastValueIndex:int;
            var charAt:String;
            var achId:int;
            var value:Number;
            var maxValue:int;
            var i:int;
            var rewardId:uint;
            var item:ItemWrapper;
            var emote:EmoteWrapper;
            var spell:SpellWrapper;
            var title:TitleWrapper;
            var ornament:OrnamentWrapper;
            var slot:Slot;
            switch (this.getAchievementLineType(data, line))
            {
                case CTR_ACH_ACHIEVEMENT:
                    if (!this._ctrAchPointsList[compRef.ctr_achPoints.name])
                    {
                        this.uiApi.addComponentHook(compRef.ctr_achPoints, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.ctr_achPoints, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._ctrAchPointsList[compRef.ctr_achPoints.name] = data;
                    if (!this._ctrAchBtnsList[compRef.btn_ach.name])
                    {
                        this.uiApi.addComponentHook(compRef.btn_ach, ComponentHookList.ON_RELEASE);
                    };
                    this._ctrAchBtnsList[compRef.btn_ach.name] = data;
                    if (!this._ctrTxList[compRef.tx_incompatibleIdols.name])
                    {
                        this.uiApi.addComponentHook(compRef.tx_incompatibleIdols, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.tx_incompatibleIdols, ComponentHookList.ON_ROLL_OUT);
                    };
                    if (!this._ctrTxList[compRef.tx_successBySomeoneElse.name])
                    {
                        this.uiApi.addComponentHook(compRef.tx_successBySomeoneElse, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.tx_successBySomeoneElse, ComponentHookList.ON_ROLL_OUT);
                    };
                    for each (achievementObjectiveId in data.objectiveIds)
                    {
                        achievementObjective = this.dataApi.getAchievementObjective(achievementObjectiveId);
                        if (((achievementObjective) && (!(achievementObjective.criterion.indexOf("Ei") == -1))))
                        {
                            monster = this.dataApi.getMonsterFromId(achievementObjective.criterion.split(",")[0].split(">")[1]);
                            if (((monster) && (monster.incompatibleIdols.length > 0)))
                            {
                                this._ctrTxList[compRef.tx_incompatibleIdols.name] = monster;
                            };
                        };
                    };
                    compRef.tx_incompatibleIdols.visible = ((monster) && (monster.incompatibleIdols.length > 0));
                    compRef.btn_ach.handCursor = true;
                    compRef.lbl_name.text = data.name;
                    if (this.sysApi.getPlayerManager().hasRights)
                    {
                        compRef.lbl_name.text = (compRef.lbl_name.text + ((" (" + data.id) + ")"));
                    };
                    compRef.lbl_points.text = data.points;
                    compRef.lbl_description.text = data.description;
                    compRef.tx_icon.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("achievementPath") + data.iconId) + ".png"));
                    if (((this._catFinishedAchievements[data.id]) || (!(this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(data.id) == -1))))
                    {
                        compRef.ctr_bg.bgColor = this.sysApi.getConfigEntry("colors.multigrid.selected");
                    }
                    else
                    {
                        compRef.ctr_bg.bgColor = this.sysApi.getConfigEntry("colors.multigrid.line");
                    };
                    if (((!(this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY].indexOf(data.id) == -1)) && (this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY].indexOf(data.id) == -1)))
                    {
                        compRef.tx_successBySomeoneElse.visible = true;
                        if (this._displayMode == CHARACTER_DISPLAY)
                        {
                            compRef.ctr_bg.bgColor = this.sysApi.getConfigEntry("colors.multigrid.subselected");
                        };
                    }
                    else
                    {
                        compRef.tx_successBySomeoneElse.visible = false;
                    };
                    if (((compRef.tx_incompatibleIdols.visible) || (compRef.tx_successBySomeoneElse.visible)))
                    {
                        firstXPosition = ((compRef.lbl_name.x + compRef.lbl_name.textWidth) + 10);
                        if (compRef.tx_incompatibleIdols.visible)
                        {
                            compRef.tx_incompatibleIdols.x = firstXPosition;
                            compRef.tx_successBySomeoneElse.x = (firstXPosition + 20);
                        }
                        else
                        {
                            compRef.tx_successBySomeoneElse.x = firstXPosition;
                        };
                    };
                    break;
                case CTR_ACH_OBJECTIVES:
                    this._selectedAndOpenedAchievementId = this._selectedAchievementId;
                    if (this._catProgressingAchievements[this._selectedAchievementId])
                    {
                        ach = this._catProgressingAchievements[this._selectedAchievementId];
                    }
                    else
                    {
                        if (this._catFinishedAchievements[this._selectedAchievementId])
                        {
                            ach = this._catFinishedAchievements[this._selectedAchievementId];
                        };
                    };
                    if (!ach) break;
                    objective = ((data.hasOwnProperty("objective")) ? data.objective : null);
                    for each (obj in ach.finishedObjective)
                    {
                        if (obj.id == data.objectiveData.id)
                        {
                            objective = obj;
                            completed = true;
                        };
                    };
                    if (!completed)
                    {
                        for each (obj in ach.startedObjectives)
                        {
                            if (obj.id == data.objectiveData.id)
                            {
                                objective = obj;
                            };
                        };
                    };
                    if (!objective) break;
                    if (((this._displayMode == ACCOUNT_DISPLAY) && (data.doneBySomeoneElse)))
                    {
                        completed = true;
                    };
                    if (objective.maxValue == 1)
                    {
                        compRef.lbl_objectiveBin.text = data.objectiveData.name;
                        if (((!(data.objectiveData.id == -1)) && (this.sysApi.getPlayerManager().hasRights)))
                        {
                            compRef.lbl_objectiveBin.text = (compRef.lbl_objectiveBin.text + ((" (" + data.objectiveData.id) + ")"));
                        };
                        if (((completed) || (objective.value == 1)))
                        {
                            compRef.tx_objectiveBin.uri = this._checkedUri;
                            compRef.lbl_objectiveBin.alpha = 0.5;
                        }
                        else
                        {
                            compRef.tx_objectiveBin.uri = this._uncheckedUri;
                            compRef.lbl_objectiveBin.alpha = 1;
                        };
                        compRef.ctr_objectiveBin.visible = true;
                        compRef.ctr_objectiveProgress.visible = false;
                        indexOA = data.objectiveData.criterion.indexOf("OA");
                        if (indexOA != -1)
                        {
                            if (!this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name])
                            {
                                this.uiApi.addComponentHook(compRef.ctr_objectiveBin, ComponentHookList.ON_ROLL_OVER);
                                this.uiApi.addComponentHook(compRef.ctr_objectiveBin, ComponentHookList.ON_ROLL_OUT);
                                this.uiApi.addComponentHook(compRef.ctr_objectiveBin, ComponentHookList.ON_RELEASE);
                            };
                            lastValueIndex = (indexOA + 3);
                            charAt = data.objectiveData.criterion.charAt(lastValueIndex);
                            while (((((((((((charAt == "0") || (charAt == "1")) || (charAt == "2")) || (charAt == "3")) || (charAt == "4")) || (charAt == "5")) || (charAt == "6")) || (charAt == "7")) || (charAt == "8")) || (charAt == "9")))
                            {
                                lastValueIndex++;
                                charAt = data.objectiveData.criterion.charAt(lastValueIndex);
                            };
                            achId = int(data.objectiveData.criterion.substring((indexOA + 3), lastValueIndex));
                            this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name] = achId;
                            compRef.lbl_objectiveBin.text = (compRef.lbl_objectiveBin.text + (" " + this.uiApi.getText("ui.common.fakeLinkSee")));
                            compRef.ctr_objectiveBin.handCursor = true;
                        }
                        else
                        {
                            compRef.ctr_objectiveBin.handCursor = false;
                            this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name] = 0;
                        };
                    }
                    else
                    {
                        maxValue = objective.maxValue;
                        if (completed)
                        {
                            value = maxValue;
                        }
                        else
                        {
                            value = objective.value;
                        };
                        compRef.lbl_objectiveProgress.text = ((value + "/") + maxValue);
                        compRef.tx_objectiveProgress.value = (value / maxValue);
                        compRef.ctr_objectiveBin.visible = false;
                        compRef.ctr_objectiveProgress.visible = true;
                    };
                    break;
                case CTR_ACH_REWARDS:
                    if (this._displayMode == CHARACTER_DISPLAY)
                    {
                        rewardData = data.characterRewardData;
                    }
                    else
                    {
                        rewardData = data.rewardData;
                    };
                    if (data.kamas > 0)
                    {
                        (compRef.lbl_rewardsKama as Label).visible = ((compRef.tx_rewardsKama as TextureBitmap).visible = true);
                        (compRef.lbl_rewardsKama as Label).text = this.utilApi.formateIntToString(data.kamas);
                    }
                    else
                    {
                        (compRef.lbl_rewardsKama as Label).visible = ((compRef.tx_rewardsKama as TextureBitmap).visible = false);
                    };
                    if (data.xp > 0)
                    {
                        (compRef.tx_rewardsXp as TextureBitmap).visible = ((compRef.lbl_rewardsXp as Label).visible = true);
                        (compRef.lbl_rewardsXp as Label).text = this.utilApi.formateIntToString(data.xp);
                    }
                    else
                    {
                        (compRef.tx_rewardsXp as TextureBitmap).visible = ((compRef.lbl_rewardsXp as Label).visible = false);
                    };
                    if (!(((compRef.lbl_rewardsXp as Label).visible) || ((compRef.lbl_rewardsKama as Label).visible)))
                    {
                        (compRef.gd_rewards as Grid).x = this.uiApi.me().getConstant("reward_slot_without_xp_x");
                    }
                    else
                    {
                        (compRef.gd_rewards as Grid).x = this.uiApi.me().getConstant("reward_slot_with_xp_x");
                    };
                    if (data.rewardable)
                    {
                        compRef.btn_accept.visible = true;
                    }
                    else
                    {
                        compRef.btn_accept.visible = false;
                    };
                    if (this._displayMode == ACCOUNT_DISPLAY)
                    {
                        compRef.btn_accept.softDisabled = true;
                    }
                    else
                    {
                        compRef.btn_accept.softDisabled = false;
                    };
                    if (rewardData.rewardTruncated)
                    {
                        compRef.tx_warningReward.visible = true;
                    }
                    else
                    {
                        compRef.tx_warningReward.visible = false;
                    };
                    rewardsSlotContent = new Array();
                    if (rewardData)
                    {
                        i = 0;
                        while (i < rewardData.itemsReward.length)
                        {
                            item = this.dataApi.getItemWrapper(rewardData.itemsReward[i], 0, 0, rewardData.itemsQuantityReward[i]);
                            rewardsSlotContent.push(item);
                            i++;
                        };
                        for each (rewardId in rewardData.emotesReward)
                        {
                            emote = this.dataApi.getEmoteWrapper(rewardId);
                            rewardsSlotContent.push(emote);
                        };
                        for each (rewardId in rewardData.spellsReward)
                        {
                            spell = this.dataApi.getSpellWrapper(rewardId);
                            rewardsSlotContent.push(spell);
                        };
                        for each (rewardId in rewardData.titlesReward)
                        {
                            title = this.dataApi.getTitleWrapper(rewardId);
                            rewardsSlotContent.push(title);
                        };
                        for each (rewardId in rewardData.ornamentsReward)
                        {
                            ornament = this.dataApi.getOrnamentWrapper(rewardId);
                            rewardsSlotContent.push(ornament);
                        };
                    };
                    compRef.gd_rewards.dataProvider = rewardsSlotContent;
                    if ((compRef.gd_rewards.slots as Array).length > 0)
                    {
                        (compRef.gd_rewards as Grid).visible = true;
                        for each (slot in compRef.gd_rewards.slots)
                        {
                            if (!slot.data)
                            {
                                slot.visible = false;
                            }
                            else
                            {
                                slot.visible = true;
                            };
                        };
                    }
                    else
                    {
                        (compRef.gd_rewards as Grid).visible = false;
                    };
                    if (!this._rewardsListList[compRef.gd_rewards.name])
                    {
                        this.uiApi.addComponentHook(compRef.gd_rewards, ComponentHookList.ON_ITEM_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.gd_rewards, ComponentHookList.ON_ITEM_ROLL_OUT);
                    };
                    this._rewardsListList[compRef.gd_rewards.name] = data;
                    if (!this._rewardsListList[compRef.tx_warningReward.name])
                    {
                        this.uiApi.addComponentHook(compRef.tx_warningReward, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.tx_warningReward, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._rewardsListList[compRef.tx_warningReward.name] = data;
                    if (!this._btnsAcceptRewardList[compRef.btn_accept.name])
                    {
                        this.uiApi.addComponentHook(compRef.btn_accept, ComponentHookList.ON_RELEASE);
                        this.uiApi.addComponentHook(compRef.btn_accept, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.btn_accept, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._btnsAcceptRewardList[compRef.btn_accept.name] = this._selectedAchievementId;
                    break;
                case CTR_ACH_EMPTY:
                    break;
            };
        }

        public function getAchievementLineType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("");
            };
            if (((data) && (data.hasOwnProperty("rewardData"))))
            {
                return (CTR_ACH_REWARDS);
            };
            if (((data) && (data.hasOwnProperty("objectiveData"))))
            {
                return (CTR_ACH_OBJECTIVES);
            };
            if (((data) && (data.hasOwnProperty("empty"))))
            {
                return (CTR_ACH_EMPTY);
            };
            return (CTR_ACH_ACHIEVEMENT);
        }

        public function getAchievementDataLength(data:*, selected:Boolean):*
        {
            return (1);
        }

        private function updateAchievementGrid(catId:int, hideAchievedAchievementChanged:Boolean=false):void
        {
            var ach:Achievement;
            var category:AchievementCategory;
            var tempAchs:Array;
            var ts:uint;
            var result:Object;
            var titleName:String;
            var critSplit:Array;
            var options:String;
            var nameResult:Object;
            var objectiveResult:Object;
            var rewardResult:Object;
            var achObj:Object;
            var currentCriteria:String;
            var wannabeCriteria:String;
            var crit:String;
            var index:int;
            var indexToScroll:int;
            var achievements:Array = new Array();
            this._selectedAndOpenedAchievementId = 0;
            if (!this._searchCriteria)
            {
                if (catId == 0)
                {
                    this.ctr_achievements.visible = false;
                    this.ctr_summary.visible = true;
                    this._selectedAchievementId = 0;
                }
                else
                {
                    this.ctr_achievements.visible = true;
                    this.ctr_summary.visible = false;
                    category = this.dataApi.getAchievementCategory(catId);
                    tempAchs = new Array();
                    for each (ach in category.achievements)
                    {
                        if (ach)
                        {
                            if (((this._hideAchievedAchievement) && (this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(ach.id) > -1)))
                            {
                            }
                            else
                            {
                                tempAchs.push(ach);
                            };
                        };
                    };
                    tempAchs.sortOn("order", Array.NUMERIC);
                    for each (ach in tempAchs)
                    {
                        achievements.push(ach);
                        achievements.push(null);
                        achievements.push(null);
                        achievements.push(null);
                        achievements.push(null);
                        achievements.push(null);
                        if (ach.id == this._selectedAchievementId)
                        {
                            indexToScroll = index;
                            achievements = achievements.concat(this.addObjectivesAndRewards(ach, category));
                        };
                        index++;
                        index++;
                        index++;
                        index++;
                        index++;
                        index++;
                    };
                };
            }
            else
            {
                if (((!(this._previousSearchCriteria == ((((((this._searchCriteria + "#") + this._searchOnName) + "") + this._searchOnObjective) + "") + this._searchOnReward))) || ((!(this._hideAchievedAchievement)) && (hideAchievedAchievementChanged))))
                {
                    ts = getTimer();
                    titleName = ((this.playerApi.getPlayedCharacterInfo().sex == 0) ? "nameMale" : "nameFemale");
                    critSplit = ((this._previousSearchCriteria) ? this._previousSearchCriteria.split("#") : []);
                    if (this._searchCriteria != critSplit[0])
                    {
                        nameResult = this.dataApi.queryUnion(this.dataApi.queryString(Achievement, "description", this._searchCriteria), this.dataApi.queryString(Achievement, "name", this._searchCriteria));
                        objectiveResult = this.dataApi.queryEquals(Achievement, "objectiveIds", this.dataApi.queryString(AchievementObjective, "name", this._searchCriteria));
                        rewardResult = this.dataApi.queryEquals(Achievement, "rewardIds", this.dataApi.queryUnion(this.dataApi.queryEquals(AchievementReward, "itemsReward", this.dataApi.queryString(Item, "name", this._searchCriteria)), this.dataApi.queryEquals(AchievementReward, "emotesReward", this.dataApi.queryString(Emoticon, "name", this._searchCriteria)), this.dataApi.queryEquals(AchievementReward, "spellsReward", this.dataApi.queryString(Spell, "name", this._searchCriteria)), this.dataApi.queryEquals(AchievementReward, "titlesReward", this.dataApi.queryString(Title, titleName, this._searchCriteria)), this.dataApi.queryEquals(AchievementReward, "ornamentsReward", this.dataApi.queryString(Ornament, "name", this._searchCriteria))));
                        this._searchResultByCriteriaList["_searchOnName"] = nameResult;
                        this._searchResultByCriteriaList["_searchOnObjective"] = objectiveResult;
                        this._searchResultByCriteriaList["_searchOnReward"] = rewardResult;
                        if ((((nameResult) || (objectiveResult)) || (rewardResult)))
                        {
                            this.sysApi.log(2, (((("Result : " + ((((nameResult) ? nameResult.length : 0) + ((objectiveResult) ? objectiveResult.length : 0)) + ((rewardResult) ? rewardResult.length : 0))) + " in ") + (getTimer() - ts)) + " ms"));
                        };
                    };
                    options = ((((("" + this._searchOnName) + "") + this._searchOnObjective) + "") + this._searchOnReward);
                    switch (options)
                    {
                        case "truetruetrue":
                            result = this.dataApi.queryReturnInstance(Achievement, this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"], this._searchResultByCriteriaList["_searchOnObjective"], this._searchResultByCriteriaList["_searchOnReward"]));
                            break;
                        case "truetruefalse":
                            result = this.dataApi.queryReturnInstance(Achievement, this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"], this._searchResultByCriteriaList["_searchOnObjective"]));
                            break;
                        case "truefalsetrue":
                            result = this.dataApi.queryReturnInstance(Achievement, this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"], this._searchResultByCriteriaList["_searchOnReward"]));
                            break;
                        case "truefalsefalse":
                            result = this.dataApi.queryReturnInstance(Achievement, this._searchResultByCriteriaList["_searchOnName"]);
                            break;
                        case "falsetruetrue":
                            result = this.dataApi.queryReturnInstance(Achievement, this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnObjective"], this._searchResultByCriteriaList["_searchOnReward"]));
                            break;
                        case "falsetruefalse":
                            result = this.dataApi.queryReturnInstance(Achievement, this._searchResultByCriteriaList["_searchOnObjective"]);
                            break;
                        case "falsefalsetrue":
                            result = this.dataApi.queryReturnInstance(Achievement, this._searchResultByCriteriaList["_searchOnReward"]);
                            break;
                        case "falsefalsefalse":
                            this.gd_achievements.dataProvider = new Array();
                            this.lbl_noAchievement.visible = true;
                            this.lbl_noAchievement.text = this.uiApi.getText("ui.search.needCriterion");
                            this._previousSearchCriteria = ((((((this._searchCriteria + "#") + this._searchOnName) + "") + this._searchOnObjective) + "") + this._searchOnReward);
                            return;
                    };
                    for each (ach in result)
                    {
                        if (((!(ach.category.visible)) || ((this._hideAchievedAchievement) && (this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(ach.id) > -1))))
                        {
                        }
                        else
                        {
                            achievements.push(ach);
                            achievements.push(null);
                            achievements.push(null);
                            achievements.push(null);
                            achievements.push(null);
                            achievements.push(null);
                            if (ach.id == this._selectedAchievementId)
                            {
                                achievements = achievements.concat(this.addObjectivesAndRewards(ach, ach.category));
                            };
                        };
                    };
                }
                else
                {
                    for each (achObj in this.gd_achievements.dataProvider)
                    {
                        if (((achObj) && (achObj is Achievement)))
                        {
                            if (((!(achObj.category.visible)) || ((this._hideAchievedAchievement) && (this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(achObj.id) > -1))))
                            {
                            }
                            else
                            {
                                achievements.push(achObj);
                                achievements.push(null);
                                achievements.push(null);
                                achievements.push(null);
                                achievements.push(null);
                                achievements.push(null);
                                if (achObj.id == this._selectedAchievementId)
                                {
                                    indexToScroll = index;
                                    achievements = achievements.concat(this.addObjectivesAndRewards((achObj as Achievement), achObj.category));
                                };
                                index++;
                                index++;
                                index++;
                                index++;
                                index++;
                                index++;
                            };
                        };
                    };
                };
            };
            this.gd_achievements.dataProvider = achievements;
            if (this._forceOpenAchievement)
            {
                this._forceOpenAchievement = false;
                this.gd_achievements.moveTo(indexToScroll, true);
            };
            if (this._currentScrollValue != 0)
            {
                this.gd_achievements.verticalScrollValue = this._currentScrollValue;
            };
            if (achievements.length > 0)
            {
                this.lbl_noAchievement.visible = false;
            }
            else
            {
                this.lbl_noAchievement.visible = true;
                this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResult");
                if (this._searchCriteria)
                {
                    currentCriteria = "";
                    wannabeCriteria = "";
                    for (crit in this._searchTextByCriteriaList)
                    {
                        if (this[crit])
                        {
                            currentCriteria = (currentCriteria + (this._searchTextByCriteriaList[crit] + ", "));
                        }
                        else
                        {
                            if (this._searchResultByCriteriaList[crit].length > 0)
                            {
                                wannabeCriteria = (wannabeCriteria + (this._searchTextByCriteriaList[crit] + ", "));
                            };
                        };
                    };
                    if (currentCriteria.length > 0)
                    {
                        currentCriteria = currentCriteria.slice(0, -2);
                    };
                    if (wannabeCriteria.length > 0)
                    {
                        wannabeCriteria = wannabeCriteria.slice(0, -2);
                    };
                    if (wannabeCriteria.length == 0)
                    {
                        this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResultFor", this._searchCriteria);
                    }
                    else
                    {
                        this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResultsBut", currentCriteria, wannabeCriteria);
                    };
                };
            };
            this._previousSearchCriteria = ((((((this._searchCriteria + "#") + this._searchOnName) + "") + this._searchOnObjective) + "") + this._searchOnReward);
        }

        private function addObjectivesAndRewards(ach:Achievement, category:AchievementCategory):Array
        {
            var objectiveId:int;
            var objective:AchievementObjective;
            var finishedLevel:int;
            var rewardable:Boolean;
            var rewards:AchievementRewardsWrapper;
            var playerRewards:AchievementRewardsWrapper;
            var o:AchievementObjective;
            var ar:AchievementAchievedRewardable;
            var achievementSucceedBySomeoneElse:Boolean;
            if (((!(this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY].indexOf(ach.id) == -1)) && (this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY].indexOf(ach.id) == -1)))
            {
                achievementSucceedBySomeoneElse = true;
            };
            var achievements:Array = new Array();
            var objectives:Array = new Array();
            for each (objectiveId in ach.objectiveIds)
            {
                o = this.dataApi.getAchievementObjective(objectiveId);
                if (o)
                {
                    objectives.push(o);
                };
            };
            objectives.sortOn("order", Array.NUMERIC);
            if (objectives.length > 0)
            {
                achievements.push({"empty":true});
            };
            for each (objective in objectives)
            {
                if (category.parentId == 0)
                {
                    achievements.push({
                        "objectiveData":objective,
                        "color":category.color,
                        "doneBySomeoneElse":achievementSucceedBySomeoneElse
                    });
                }
                else
                {
                    achievements.push({
                        "objectiveData":objective,
                        "color":this.dataApi.getAchievementCategory(category.parentId).color,
                        "doneBySomeoneElse":achievementSucceedBySomeoneElse
                    });
                };
                achievements.push(null);
            };
            if (objectives.length > 0)
            {
                achievements.push({"empty":true});
            };
            var reward:Object = {
                "rewardData":null,
                "characterRewardData":null,
                "kamas":0,
                "xp":0,
                "rewardable":false
            };
            if (this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(ach.id) != -1)
            {
                for each (ar in this.questApi.getRewardableAchievements())
                {
                    if (ar.id == ach.id)
                    {
                        finishedLevel = ar.finishedlevel;
                        rewardable = true;
                        break;
                    };
                };
            };
            if (finishedLevel)
            {
                rewards = this.questApi.getAchievementReward(ach, finishedLevel, true);
                playerRewards = this.questApi.getAchievementReward(ach, finishedLevel, false);
            }
            else
            {
                rewards = this.questApi.getAchievementReward(ach, 0, true);
                playerRewards = this.questApi.getAchievementReward(ach, 0, false);
            };
            reward.characterRewardData = playerRewards;
            reward.rewardData = rewards;
            reward.kamas = this.questApi.getAchievementKamasReward(ach, finishedLevel);
            reward.xp = this.questApi.getAchievementExperienceReward(ach, finishedLevel);
            reward.rewardable = rewardable;
            achievements.push(reward);
            achievements.push(null);
            achievements.push(null);
            achievements.push(null);
            achievements.push(null);
            achievements.push(null);
            return (achievements);
        }

        private function updateCategories(selectedCategory:Object, forceOpen:Boolean=false, fakeOpen:Boolean=false):void
        {
            var alreadyInTheRightCategory:Boolean;
            var myIndex:int;
            var cat:Object;
            var cat2:Object;
            var subcat:Object;
            if (!fakeOpen)
            {
                if (((selectedCategory.id > 0) && (!(this._currentSelectedCatId == selectedCategory.id))))
                {
                    this.sysApi.sendAction(new AchievementDetailedListRequest(selectedCategory.id));
                }
                else
                {
                    alreadyInTheRightCategory = true;
                };
                if ((((selectedCategory.parentId > 0) && (this._openCatIndex == selectedCategory.parentId)) || (this._openCatIndex == selectedCategory.id)))
                {
                    this._currentSelectedCatId = selectedCategory.id;
                    for each (cat2 in this.gd_categories.dataProvider)
                    {
                        if (cat2.id == this._currentSelectedCatId)
                        {
                            break;
                        };
                        myIndex++;
                    };
                    if (this.gd_categories.selectedIndex != myIndex)
                    {
                        this.gd_categories.silent = true;
                        this.gd_categories.selectedIndex = myIndex;
                        this.gd_categories.silent = false;
                    };
                    this.gd_categories.focus();
                    this.gd_categories.selectWithArrows = false;
                    if (((this._forceOpenAchievement) && (alreadyInTheRightCategory)))
                    {
                        this.updateAchievementGrid(this._currentSelectedCatId);
                    };
                    if (this._openCatIndex != selectedCategory.id)
                    {
                        return;
                    };
                };
            };
            var bigCatId:int = selectedCategory.id;
            if (selectedCategory.parentId > 0)
            {
                bigCatId = selectedCategory.parentId;
            };
            var index:int = -1;
            var tempCats:Array = new Array();
            var categoryOpened:int = -1;
            for each (cat in this._categories)
            {
                tempCats.push(cat);
                index++;
                if (bigCatId == cat.id)
                {
                    myIndex = index;
                    if ((((!(this._currentSelectedCatId == cat.id)) || (this._openCatIndex == 0)) || (forceOpen)))
                    {
                        categoryOpened = cat.id;
                        for each (subcat in cat.subcats)
                        {
                            tempCats.push(subcat);
                            index++;
                            if (subcat.id == selectedCategory.id)
                            {
                                myIndex = index;
                            };
                        };
                    };
                };
            };
            if (categoryOpened >= 0)
            {
                this._openCatIndex = categoryOpened;
            }
            else
            {
                this._openCatIndex = 0;
            };
            if (!fakeOpen)
            {
                this._currentSelectedCatId = selectedCategory.id;
            };
            this.uiApi.hideTooltip();
            this.gd_categories.dataProvider = tempCats;
            if (this.gd_categories.selectedIndex != myIndex)
            {
                this.gd_categories.silent = true;
                this.gd_categories.selectedIndex = myIndex;
                this.gd_categories.silent = false;
            };
            this.gd_categories.focus();
            if (((!(fakeOpen)) && (this._currentSelectedCatId == 0)))
            {
                this.updateAchievementGrid(this._currentSelectedCatId);
            };
        }

        private function updateGeneralInfo():void
        {
            var percentStr:String;
            var percent:Number;
            this.lbl_myPoints.text = this.utilApi.kamasToString(this._successPointsByDisplayMode[this._displayMode], "");
            if (this._dataAchievements.length > 0)
            {
                percent = Math.floor(((this._finishedAchievementsIdByDisplayMode[this._displayMode].length / this._dataAchievements.length) * 100));
                percentStr = percent.toString();
                this.pb_progress.value = (percent / 100);
            }
            else
            {
                percentStr = "-";
                this.pb_progress.value = 0;
            };
            this.lbl_percent.text = (percentStr + "%");
        }

        private function displayAccountMode(displayModeRequested:int, forceDisplay:Boolean=false):void
        {
            if (((displayModeRequested == this._displayMode) && (!(forceDisplay))))
            {
                return;
            };
            this.sysApi.setData("achievementAccountDisplayMode", displayModeRequested);
            this._displayMode = displayModeRequested;
            this.updateGeneralInfo();
            this.gd_summary.dataProvider = this._progressCategoriesByDisplayMode[this._displayMode];
            this.gd_categories.updateItems();
            this.gd_achievements.updateItems();
            if (displayModeRequested == ACCOUNT_DISPLAY)
            {
                this.uiApi.setRadioGroupSelectedItem("tabHGroup", this.btn_tabAccount, this.uiApi.me());
                this.btn_tabAccount.selected = true;
            }
            else
            {
                this.uiApi.setRadioGroupSelectedItem("tabHGroup", this.btn_tabCharacter, this.uiApi.me());
                this.btn_tabCharacter.selected = true;
            };
        }

        private function getMountPercentXp():int
        {
            var xpRatio:int;
            if ((((!(this.playerApi.getMount() == null)) && (this.playerApi.isRidding())) && (this.playerApi.getMount().xpRatio > 0)))
            {
                xpRatio = this.playerApi.getMount().xpRatio;
            };
            return (xpRatio);
        }

        private function changeSearchOnName():void
        {
            this._searchOnName = (!(this._searchOnName));
            Grimoire.getInstance().achievementSearchOnName = this._searchOnName;
            if ((((!(this._searchOnName)) && (!(this._searchOnObjective))) && (!(this._searchOnReward))))
            {
                this.inp_search.visible = false;
                this.tx_inputBg_search.disabled = true;
            }
            else
            {
                this.inp_search.visible = true;
                this.tx_inputBg_search.disabled = false;
            };
            if (((this._searchCriteria) && (!(this._searchCriteria == ""))))
            {
                this.updateAchievementGrid(this.gd_categories.selectedItem);
            };
        }

        private function changeSearchOnObjective():void
        {
            this._searchOnObjective = (!(this._searchOnObjective));
            Grimoire.getInstance().achievementSearchOnObjective = this._searchOnObjective;
            if ((((!(this._searchOnName)) && (!(this._searchOnObjective))) && (!(this._searchOnReward))))
            {
                this.inp_search.visible = false;
                this.tx_inputBg_search.disabled = true;
            }
            else
            {
                this.inp_search.visible = true;
                this.tx_inputBg_search.disabled = false;
            };
            if (((this._searchCriteria) && (!(this._searchCriteria == ""))))
            {
                this.updateAchievementGrid(this.gd_categories.selectedItem);
            };
        }

        private function changeSearchOnReward():void
        {
            this._searchOnReward = (!(this._searchOnReward));
            Grimoire.getInstance().achievementSearchOnReward = this._searchOnReward;
            if ((((!(this._searchOnName)) && (!(this._searchOnObjective))) && (!(this._searchOnReward))))
            {
                this.inp_search.visible = false;
                this.tx_inputBg_search.disabled = true;
            }
            else
            {
                this.inp_search.visible = true;
                this.tx_inputBg_search.disabled = false;
            };
            if (((this._searchCriteria) && (!(this._searchCriteria == ""))))
            {
                this.updateAchievementGrid(this.gd_categories.selectedItem);
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (target == this.gd_categories)
            {
                if (selectMethod != GridItemSelectMethodEnum.AUTO)
                {
                    this._searchCriteria = null;
                    this.inp_search.text = this.uiApi.getText("ui.common.search.input");
                    this._currentScrollValue = 0;
                    this.updateCategories(target.selectedItem);
                };
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (((item.data) && (!(target.name.indexOf("gd_rewards") == -1))))
            {
                data = item.data;
                if (((data == null) || (!(data is ItemWrapper))))
                {
                    return;
                };
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var text:String;
            var pos:Object;
            if (((item.data) && (!(target.name.indexOf("gd_rewards") == -1))))
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
                if ((item.data is EmoteWrapper))
                {
                    text = this.uiApi.getText("ui.common.emote", item.data.emote.name);
                }
                else
                {
                    if ((item.data is SpellWrapper))
                    {
                        text = this.uiApi.getText("ui.common.spell", item.data.spell.name);
                    }
                    else
                    {
                        if ((item.data is TitleWrapper))
                        {
                            text = this.uiApi.getText("ui.common.title", item.data.title.name);
                        }
                        else
                        {
                            if ((item.data is OrnamentWrapper))
                            {
                                text = this.uiApi.getText("ui.common.ornament", item.data.name);
                            };
                        };
                    };
                };
                if (text)
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRelease(target:Object):void
        {
            var contextMenu:Array;
            var data:Object;
            var achievement:Achievement;
            var category:AchievementCategory;
            var achMetaId:int;
            this._focusOnSearch = false;
            switch (target)
            {
                case this.btn_closeSearch:
                    this._searchCriteria = null;
                    this.inp_search.text = this.uiApi.getText("ui.common.search.input");
                    this.updateAchievementGrid(this.gd_categories.selectedItem.id);
                    break;
                case this.btn_searchFilter:
                    contextMenu = new Array();
                    contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.search.criteria")));
                    contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnName"], this.changeSearchOnName, null, false, null, this._searchOnName, false));
                    contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnObjective"], this.changeSearchOnObjective, null, false, null, this._searchOnObjective, false));
                    contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnReward"], this.changeSearchOnReward, null, false, null, this._searchOnReward, false));
                    this.modContextMenu.createContextMenu(contextMenu);
                    break;
                case this.btn_hideCompletedAchievements:
                    this._hideAchievedAchievement = this.btn_hideCompletedAchievements.selected;
                    this.updateAchievementGrid(this.gd_categories.selectedItem.id, true);
                    break;
                case this.inp_search:
                    if (this.uiApi.getText("ui.common.search.input") == this.inp_search.text)
                    {
                        this.inp_search.text = "";
                    };
                    this._focusOnSearch = true;
                    break;
                case this.btn_tabAccount:
                    this.displayAccountMode(ACCOUNT_DISPLAY);
                    break;
                case this.btn_tabCharacter:
                    this.displayAccountMode(CHARACTER_DISPLAY);
                    break;
                default:
                    if (target)
                    {
                        if (target.name.indexOf("ctr_illu") != -1)
                        {
                            this._searchCriteria = null;
                            this.inp_search.text = "";
                            this.gd_categories.selectedIndex = (this._catIlluBtnList[target.name].order + 1);
                        }
                        else
                        {
                            if (target.name.indexOf("btn_ach") != -1)
                            {
                                if (this.uiApi.keyIsDown(Keyboard.SHIFT))
                                {
                                    this.sysApi.dispatchHook(MouseShiftClick, {"data":this._ctrAchBtnsList[target.name]});
                                    break;
                                };
                                data = this._ctrAchBtnsList[target.name];
                                if (((this._selectedAchievementId == 0) || (!(this._selectedAchievementId == data.id))))
                                {
                                    this.gd_achievements.selectedItem = data;
                                    this._selectedAchievementId = data.id;
                                }
                                else
                                {
                                    this._selectedAchievementId = 0;
                                };
                                if ((((this._selectedAchievementId > 0) && (!(this._catProgressingAchievements[this._selectedAchievementId]))) && (!(this._catFinishedAchievements[this._selectedAchievementId]))))
                                {
                                    this.sysApi.sendAction(new AchievementDetailsRequest(this._selectedAchievementId));
                                }
                                else
                                {
                                    this.updateAchievementGrid(this.gd_categories.selectedItem.id);
                                    if ((((!(this._searchCriteria == "")) && (!(this._searchCriteria == null))) && (this._selectedAchievementId > 0)))
                                    {
                                        achievement = this.dataApi.getAchievement(this._selectedAchievementId);
                                        category = this.dataApi.getAchievementCategory(achievement.categoryId);
                                        this.updateCategories(category, true, true);
                                    };
                                    this.gd_achievements.focus();
                                };
                            }
                            else
                            {
                                if (target.name.indexOf("ctr_objectiveBin") != -1)
                                {
                                    achMetaId = this._ctrObjectiveMetaList[target.name];
                                    if (achMetaId > 0)
                                    {
                                        this.uiApi.hideTooltip();
                                        this.onOpenAchievement("achievementTab", {
                                            "forceOpen":true,
                                            "achievementId":achMetaId
                                        });
                                    };
                                }
                                else
                                {
                                    if (target.name.indexOf("btn_accept") != -1)
                                    {
                                        this.uiApi.hideTooltip();
                                        this.sysApi.sendAction(new AchievementRewardRequest(this._btnsAcceptRewardList[target.name]));
                                    };
                                };
                            };
                        };
                    };
            };
            if ((((!(target == this.inp_search)) && (this.inp_search)) && (this.inp_search.text.length == 0)))
            {
                this.inp_search.text = this.uiApi.getText("ui.common.search.input");
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var param:String;
            var footer:String;
            var achMetaId:int;
            var achMeta:Achievement;
            var myMountXp:int;
            var monster:Monster;
            var incompatibleIdols:String;
            var id:uint;
            var idol:Idol;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            switch (target)
            {
                case this.lbl_myPoints:
                    if (this._displayMode == ACCOUNT_DISPLAY)
                    {
                        param = ((this.utilApi.kamasToString(this._successPointsByDisplayMode[ACCOUNT_DISPLAY], "") + " / ") + this.utilApi.kamasToString(this._totalSuccessPoints, ""));
                        footer = (" " + this.uiApi.getText("ui.achievement.pointsForAccount"));
                    }
                    else
                    {
                        param = ((this.utilApi.kamasToString(this._successPointsByDisplayMode[CHARACTER_DISPLAY], "") + " / ") + this.utilApi.kamasToString(this._totalSuccessPoints, ""));
                        footer = (" " + this.uiApi.getText("ui.achievement.pointsForCharacter"));
                    };
                    text = this.uiApi.processText(this.uiApi.getText("ui.achievement.successPoints", param), "n", false);
                    text = (text + footer);
                    break;
                case this.ctr_globalProgress:
                    text = ((this._finishedAchievementsIdByDisplayMode[this._displayMode].length + " / ") + this._dataAchievements.length);
                    break;
                case this.btn_searchFilter:
                    text = this.uiApi.getText("ui.search.criteria");
                    break;
                default:
                    if (target.name.indexOf("ctr_achPoints") != -1)
                    {
                        text = this.uiApi.getText("ui.achievement.successPointsText");
                    }
                    else
                    {
                        if (target.name.indexOf("lbl_catPercent") != -1)
                        {
                            if ((((this._catProgressBarList[target.name]) && (this._catProgressBarList[target.name].subcats)) && (this._catProgressBarList[target.name].subcats.length > 0)))
                            {
                                text = this.uiApi.getText("ui.achievement.noSubCategoryIncluded");
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("ctr_objectiveBin") != -1)
                            {
                                achMetaId = this._ctrObjectiveMetaList[target.name];
                                if (achMetaId > 0)
                                {
                                    achMeta = this.dataApi.getAchievement(achMetaId);
                                    text = achMeta.description;
                                };
                            }
                            else
                            {
                                if (target.name.indexOf("ctr_progress") != -1)
                                {
                                    text = ((this._catProgressBarList[target.name].value + "/") + this._catProgressBarList[target.name].total);
                                }
                                else
                                {
                                    if (target.name.indexOf("tx_successBySomeoneElse") != -1)
                                    {
                                        text = this.uiApi.getText("ui.achievement.achievedBySomeoneElse");
                                    }
                                    else
                                    {
                                        if (target.name.indexOf("tx_warningReward") != -1)
                                        {
                                            text = this.uiApi.getText("ui.achievement.partialRewards");
                                        }
                                        else
                                        {
                                            if (target.name.indexOf("btn_accept") != -1)
                                            {
                                                if (target.softDisabled)
                                                {
                                                    text = this.uiApi.getText("ui.achievement.rewardsToGetWaiting");
                                                }
                                                else
                                                {
                                                    text = this.uiApi.getText("ui.achievement.rewardsGet");
                                                    myMountXp = this.getMountPercentXp();
                                                    if (myMountXp)
                                                    {
                                                        text = (text + ("\n" + this.uiApi.getText("ui.achievement.mountXpPercent", myMountXp)));
                                                    };
                                                    if (this._myGuildXp)
                                                    {
                                                        text = (text + ("\n" + this.uiApi.getText("ui.achievement.guildXpPercent", this._myGuildXp)));
                                                    };
                                                };
                                            }
                                            else
                                            {
                                                if (target.name.indexOf("tx_incompatibleIdols") != -1)
                                                {
                                                    monster = this._ctrTxList[target.name];
                                                    incompatibleIdols = "";
                                                    for each (id in monster.incompatibleIdols)
                                                    {
                                                        idol = this.dataApi.getIdol(id);
                                                        if (idol)
                                                        {
                                                            incompatibleIdols = (incompatibleIdols + ("\n" + idol.item.name));
                                                        };
                                                    };
                                                    text = this.uiApi.getText("ui.idol.incompatibleIdols", incompatibleIdols);
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onFocusChange(pTarget:Object):void
        {
            if ((((pTarget) && (!(pTarget == this.inp_search))) && (this._focusOnSearch)))
            {
                this.onRelease(null);
            };
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
                if (this._openCatIndex == 0)
                {
                    this.ctr_achievements.visible = true;
                    this.ctr_summary.visible = false;
                };
                this.updateAchievementGrid(this._currentSelectedCatId);
            }
            else
            {
                if (this._searchCriteria)
                {
                    this._searchCriteria = null;
                };
                if (this.inp_search.text.length == 0)
                {
                    this.updateAchievementGrid(this.gd_categories.selectedItem.id);
                };
            };
        }

        public function onParseObjectives(i:int=0):void
        {
            Grimoire.getInstance().objectivesTextByAchievement = this._objectivesTextByAchievementId;
            this.updateAchievementGrid(this.gd_categories.selectedItem.id);
            this.onCancelSearch();
        }

        private function onCancelSearch():void
        {
            clearTimeout(this._searchSettimoutId);
            if (this._progressPopupName)
            {
                this.uiApi.unloadUi(this._progressPopupName);
                this._progressPopupName = null;
            };
        }

        private function onAchievementList():void
        {
            var totalNb:int;
            var cat:AchievementCategory;
            var ach:Achievement;
            var finishedId:int;
            var finishedAch:Achievement;
            var total:int;
            this._successPointsByDisplayMode = new Array();
            this._progressCategoriesByDisplayMode[ACCOUNT_DISPLAY] = new Array();
            this._progressCategoriesByDisplayMode[CHARACTER_DISPLAY] = new Array();
            this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY] = new Array();
            this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY] = new Array();
            var currentCountByDisplayMode:Array = new Array();
            var tempCatArray:Array = new Array();
            this._successPointsByDisplayMode[ACCOUNT_DISPLAY] = 0;
            this._successPointsByDisplayMode[CHARACTER_DISPLAY] = 0;
            this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY] = this.questApi.getFinishedAccountAchievementIds();
            this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY] = this.questApi.getFinishedCharacterAchievementIds();
            for each (finishedId in this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY])
            {
                finishedAch = this.dataApi.getAchievement(finishedId);
                if (finishedAch)
                {
                    this._successPointsByDisplayMode[ACCOUNT_DISPLAY] = (this._successPointsByDisplayMode[ACCOUNT_DISPLAY] + finishedAch.points);
                };
            };
            for each (finishedId in this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY])
            {
                finishedAch = this.dataApi.getAchievement(finishedId);
                if (finishedAch)
                {
                    this._successPointsByDisplayMode[CHARACTER_DISPLAY] = (this._successPointsByDisplayMode[CHARACTER_DISPLAY] + finishedAch.points);
                };
            };
            for each (cat in this._dataCategories)
            {
                if (cat.parentId > 0)
                {
                    if (!tempCatArray[cat.parentId])
                    {
                        tempCatArray[cat.parentId] = {
                            "valueAccount":0,
                            "valueCharacter":0,
                            "total":0
                        };
                    };
                    totalNb = 0;
                    currentCountByDisplayMode[ACCOUNT_DISPLAY] = 0;
                    currentCountByDisplayMode[CHARACTER_DISPLAY] = 0;
                    for each (ach in cat.achievements)
                    {
                        if (ach)
                        {
                            if (this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY].indexOf(ach.id) != -1)
                            {
                                currentCountByDisplayMode[ACCOUNT_DISPLAY]++;
                            };
                            if (this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY].indexOf(ach.id) != -1)
                            {
                                currentCountByDisplayMode[CHARACTER_DISPLAY]++;
                            };
                            totalNb++;
                        };
                    };
                    tempCatArray[cat.parentId] = {
                        "valueAccount":(tempCatArray[cat.parentId].valueAccount + currentCountByDisplayMode[ACCOUNT_DISPLAY]),
                        "valueCharacter":(tempCatArray[cat.parentId].valueCharacter + currentCountByDisplayMode[CHARACTER_DISPLAY]),
                        "total":(tempCatArray[cat.parentId].total + totalNb)
                    };
                };
            };
            for each (cat in this._dataCategories)
            {
                if (cat.parentId == 0)
                {
                    if (!tempCatArray[cat.id])
                    {
                        tempCatArray[cat.id] = {
                            "valueAccount":0,
                            "valueCharacter":0,
                            "total":0
                        };
                    };
                    total = 0;
                    totalNb = 0;
                    currentCountByDisplayMode[ACCOUNT_DISPLAY] = 0;
                    currentCountByDisplayMode[CHARACTER_DISPLAY] = 0;
                    for each (ach in cat.achievements)
                    {
                        if (ach)
                        {
                            if (this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY].indexOf(ach.id) != -1)
                            {
                                currentCountByDisplayMode[ACCOUNT_DISPLAY]++;
                            };
                            if (this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY].indexOf(ach.id) != -1)
                            {
                                currentCountByDisplayMode[CHARACTER_DISPLAY]++;
                            };
                            totalNb++;
                        };
                    };
                    if (tempCatArray[cat.id])
                    {
                        currentCountByDisplayMode[ACCOUNT_DISPLAY] = (currentCountByDisplayMode[ACCOUNT_DISPLAY] + tempCatArray[cat.id].valueAccount);
                        currentCountByDisplayMode[CHARACTER_DISPLAY] = (currentCountByDisplayMode[CHARACTER_DISPLAY] + tempCatArray[cat.id].valueCharacter);
                        total = (totalNb + tempCatArray[cat.id].total);
                    };
                    this._progressCategoriesByDisplayMode[ACCOUNT_DISPLAY].push({
                        "id":cat.id,
                        "name":cat.name,
                        "value":currentCountByDisplayMode[ACCOUNT_DISPLAY],
                        "total":total,
                        "color":cat.color,
                        "icon":cat.icon,
                        "order":cat.order
                    });
                    this._progressCategoriesByDisplayMode[CHARACTER_DISPLAY].push({
                        "id":cat.id,
                        "name":cat.name,
                        "value":currentCountByDisplayMode[CHARACTER_DISPLAY],
                        "total":total,
                        "color":cat.color,
                        "icon":cat.icon,
                        "order":cat.order
                    });
                };
            };
            this._progressCategoriesByDisplayMode[ACCOUNT_DISPLAY].sortOn("order", Array.NUMERIC);
            this._progressCategoriesByDisplayMode[CHARACTER_DISPLAY].sortOn("order", Array.NUMERIC);
            this.gd_summary.dataProvider = this._progressCategoriesByDisplayMode[this._displayMode];
            this.updateGeneralInfo();
            if (this._forceOpenAchievement)
            {
                this.onOpenAchievement("achievementTab", {
                    "forceOpen":true,
                    "achievementId":this._selectedAchievementId
                });
            };
        }

        private function onAchievementFinished(finishedAchievement:AchievementAchieved):void
        {
            var cat:Object;
            var achievedByCurrentCharacter:* = (finishedAchievement.achievedBy == this.playerApi.id());
            var finishedAch:Achievement = this.dataApi.getAchievement(finishedAchievement.id);
            if (!finishedAch)
            {
                return;
            };
            this._successPointsByDisplayMode[ACCOUNT_DISPLAY] = (this._successPointsByDisplayMode[ACCOUNT_DISPLAY] + finishedAch.points);
            var catFrom:AchievementCategory = this.dataApi.getAchievementCategory(finishedAch.categoryId);
            for each (cat in this._progressCategoriesByDisplayMode[ACCOUNT_DISPLAY])
            {
                if (((cat.id == catFrom.id) || (cat.id == catFrom.parentId)))
                {
                    cat.value = (cat.value + 1);
                };
            };
            if (achievedByCurrentCharacter)
            {
                this._successPointsByDisplayMode[CHARACTER_DISPLAY] = (this._successPointsByDisplayMode[CHARACTER_DISPLAY] + finishedAch.points);
                for each (cat in this._progressCategoriesByDisplayMode[CHARACTER_DISPLAY])
                {
                    if (((cat.id == catFrom.id) || (cat.id == catFrom.parentId)))
                    {
                        cat.value = (cat.value + 1);
                    };
                };
            };
            this.gd_summary.dataProvider = this._progressCategoriesByDisplayMode[this._displayMode];
            this.updateGeneralInfo();
        }

        private function onAchievementDetailedList(finishedAchievements:Object, startedAchievements:Object):void
        {
            var ach:Object;
            for each (ach in finishedAchievements)
            {
                this._catFinishedAchievements[ach.id] = ach;
                ach.id = null;
            };
            for each (ach in startedAchievements)
            {
                this._catProgressingAchievements[ach.id] = ach;
                ach.id = null;
            };
            this.updateAchievementGrid(this._currentSelectedCatId);
        }

        private function onAchievementDetails(achievement:Object):void
        {
            var category:AchievementCategory;
            if (achievement == null)
            {
                return;
            };
            var achievementId:uint = achievement.id;
            if (this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(achievementId) == -1)
            {
                this._catProgressingAchievements[achievementId] = achievement;
            }
            else
            {
                this._catFinishedAchievements[achievementId] = achievement;
            };
            achievement.id = null;
            this.updateAchievementGrid(this._currentSelectedCatId);
            var achievementData:Achievement = this.dataApi.getAchievement(achievementId);
            if (achievementData != null)
            {
                category = this.dataApi.getAchievementCategory(achievementData.categoryId);
                if (category != null)
                {
                    this.updateCategories(category, true, true);
                };
            };
        }

        private function onAchievementRewardSuccess(achievementId:int):void
        {
            this.updateAchievementGrid(this._currentSelectedCatId);
        }

        public function onGuildInformationsMemberUpdate(member:Object):void
        {
            if (member.id == this.playerApi.id())
            {
                this._myGuildXp = member.experienceGivenPercent;
            };
        }

        private function onOpenAchievement(tab:String=null, param:Object=null):void
        {
            var achievement:Achievement;
            var category:AchievementCategory;
            if ((((tab == "achievementTab") && (param)) && (param.forceOpen)))
            {
                this._selectedAchievementId = param.achievementId;
                this.ctr_achievements.visible = true;
                this.ctr_summary.visible = false;
                this._forceOpenAchievement = true;
                this._searchCriteria = null;
                this.inp_search.text = "";
                if (((!(this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(this._selectedAchievementId) == -1)) && (this._hideAchievedAchievement == true)))
                {
                    this._hideAchievedAchievement = false;
                    this.btn_hideCompletedAchievements.selected = false;
                };
                achievement = this.dataApi.getAchievement(this._selectedAchievementId);
                category = this.dataApi.getAchievementCategory(achievement.categoryId);
                this.updateCategories(category, true);
            };
        }


    }
} Ankama_Grimoire.ui

