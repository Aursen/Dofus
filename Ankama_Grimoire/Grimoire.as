package Ankama_Grimoire
{
    import flash.display.Sprite;
    import Ankama_Grimoire.ui.Book;
    import Ankama_Grimoire.ui.AlignmentTab;
    import Ankama_Grimoire.ui.BestiaryTab;
    import Ankama_Grimoire.ui.QuestTab;
    import Ankama_Grimoire.ui.JobTab;
    import Ankama_Grimoire.ui.items.GiftXmlItem;
    import Ankama_Grimoire.ui.CalendarTab;
    import Ankama_Grimoire.ui.AchievementTab;
    import Ankama_Grimoire.ui.TitleTab;
    import Ankama_Grimoire.ui.CompanionTab;
    import Ankama_Grimoire.ui.IdolsTab;
    import Ankama_Grimoire.ui.QuestBase;
    import Ankama_Grimoire.ui.SpellBase;
    import Ankama_Grimoire.ui.SpellList;
    import Ankama_Grimoire.ui.FinishMoveList;
    import Ankama_Grimoire.ui.QuestList;
    import Ankama_Grimoire.ui.QuestListMinimized;
    import Ankama_Grimoire.ui.EncyclopediaBase;
    import Ankama_Grimoire.ui.EncyclopediaList;
    import Ankama_Grimoire.ui.GameplayClassWindow;
    import Ankama_Grimoire.ui.temporis.AlignmentWarEffortTab;
    import Ankama_Grimoire.ui.temporis.AlignmentGiftsTab;
    import Ankama_Grimoire.ui.temporis.TemporisSpellsUi;
    import Ankama_Grimoire.ui.temporis.TemporisSpellSetPopUp;
    import Ankama_Grimoire.ui.temporis.TemporisQuestTab;
    import Ankama_Grimoire.ui.temporis.TemporisGetScrollWarningPopUp;
    import Ankama_Grimoire.ui.temporis.TemporisIntroPopUp;
    import Ankama_Grimoire.ui.temporis.TemporisSpellSetsUi;
    import Ankama_Grimoire.ui.temporis.TemporisSpellSetDeletionPopUp;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.NotificationApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.QuestApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxMonth;
    import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxZodiac;
    import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxEvent;
    import com.ankamagames.dofus.datacenter.almanax.AlmanaxCalendar;
    import com.ankamagames.dofus.datacenter.npcs.Npc;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.datacenter.monsters.MonsterSuperRace;
    import com.ankamagames.dofus.datacenter.world.Area;
    import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import Ankama_Grimoire.ui.API;
    import d2hooks.OpenBook;
    import d2hooks.OpenEncyclopedia;
    import d2hooks.SpellListUpdate;
    import d2hooks.OpenSpellInterface;
    import d2hooks.CalendarDate;
    import d2hooks.QuestStarted;
    import d2hooks.QuestValidated;
    import d2hooks.CharacterLevelUp;
    import d2hooks.SpellsToHighlightUpdate;
    import Ankama_Grimoire.enum.EnumTab;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2hooks.CloseNotification;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.berilia.enums.StrataEnum;
    import d2hooks.*;

    public class Grimoire extends Sprite 
    {

        private static var _self:Grimoire;

        protected var grimoire:Book = null;
        protected var alignmentTab:AlignmentTab = null;
        protected var bestiaryTab:BestiaryTab = null;
        protected var questTab:QuestTab = null;
        protected var jobTab:JobTab = null;
        protected var giftXmlItem:GiftXmlItem = null;
        protected var calendarTab:CalendarTab = null;
        protected var achievementTab:AchievementTab = null;
        protected var titleTab:TitleTab = null;
        protected var companionTab:CompanionTab = null;
        protected var idolsTab:IdolsTab = null;
        protected var questsBook:QuestBase = null;
        protected var spellBase:SpellBase = null;
        protected var spellList:SpellList = null;
        protected var finishMoveList:FinishMoveList = null;
        protected var questList:QuestList = null;
        protected var questListMinimized:QuestListMinimized = null;
        protected var encyclopediaBase:EncyclopediaBase = null;
        protected var encyclopediaList:EncyclopediaList = null;
        protected var gameplayClassWindow:GameplayClassWindow = null;
        protected var alignmentWarEffortTab:AlignmentWarEffortTab = null;
        protected var alignmentGiftTab:AlignmentGiftsTab = null;
        protected var temporisSpellsUi:TemporisSpellsUi = null;
        protected var temporisSpellSetPopUp:TemporisSpellSetPopUp = null;
        protected var temporisQuestTab:TemporisQuestTab = null;
        protected var temporisGetScrollWarningPopUp:TemporisGetScrollWarningPopUp = null;
        protected var temporisIntroPopUp:TemporisIntroPopUp = null;
        protected var temporisSpellSetsUi:TemporisSpellSetsUi = null;
        protected var temporisSpellSetDeletionPopUp:TemporisSpellSetDeletionPopUp = null;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="NotificationApi")]
        public var notifApi:NotificationApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="QuestApi")]
        public var questApi:QuestApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        public var previousUi:String;
        public var currentUi:String;
        public var tabOpened:String = "";
        private var _recipeSlotsNumber:int;
        private var _dateId:int;
        private var _monthInfo:AlmanaxMonth;
        private var _zodiacInfo:AlmanaxZodiac;
        private var _eventInfo:AlmanaxEvent;
        private var _calendar:AlmanaxCalendar;
        private var _meryde:Npc;
        private var _objectivesTextByAchievement:Array;
        private var _lastAchievementOpenedId:int;
        private var _lastAchievementSearchCriteria:String = "";
        private var _lastAchievementCategoryOpenedId:int;
        private var _lastAchievementScrollValue:int;
        private var _monsterRaces:Array;
        private var _monsterAreas:Array;
        private var _titleCurrentTab:int;
        private var _bestiaryDisplayCriteriaDrop:Boolean = true;
        private var _bestiarySearchOnName:Boolean = true;
        private var _bestiarySearchOnDrop:Boolean = true;
        private var _achievementSearchOnName:Boolean = true;
        private var _achievementSearchOnObjective:Boolean = true;
        private var _achievementSearchOnReward:Boolean = true;
        private var _questSearchOnName:Boolean = true;
        private var _questSearchOnCategory:Boolean = true;
        private var _jobSearchOptions:Dictionary = new Dictionary();
        private var _lastJobOpenedId:int;
        private var _spellShowAllObtentionLevel:Boolean = false;
        private var _newSpellIdsToHighlight:Array = new Array();
        private var _currentSpellsList:Array = new Array();
        private var _playerLevelForCurrentSpellsList:Array = new Array();


        public static function getInstance():Grimoire
        {
            return (_self);
        }


        public function main():void
        {
            var mainCat:Object;
            var superRace:MonsterSuperRace;
            var areas:Object;
            var subAreas:Object;
            var area:Area;
            var race:MonsterRace;
            var subarea:SubArea;
            API.uiApi = this.uiApi;
            this.sysApi.addHook(OpenBook, this.onOpenGrimoire);
            this.sysApi.addHook(OpenEncyclopedia, this.onOpenEncyclopedia);
            this.sysApi.addHook(SpellListUpdate, this.onSpellsList);
            this.sysApi.addHook(OpenSpellInterface, this.onOpenSpellInterface);
            this.sysApi.addHook(CalendarDate, this.onCalendarDate);
            this.sysApi.addHook(QuestStarted, this.onQuestStarted);
            this.sysApi.addHook(QuestValidated, this.onQuestValidated);
            this.sysApi.addHook(CharacterLevelUp, this.onLevelUp);
            this._objectivesTextByAchievement = new Array();
            this._monsterRaces = new Array();
            this._monsterAreas = new Array();
            _self = this;
            var monsterSuperRaces:Object = this.dataApi.getMonsterSuperRaces();
            var monsterRaces:Object = this.dataApi.getMonsterRaces();
            var uniqId:int = 1;
            for each (superRace in monsterSuperRaces)
            {
                this._monsterRaces.push({
                    "id":uniqId,
                    "realId":superRace.id,
                    "name":superRace.name,
                    "parentId":0,
                    "subcats":new Array()
                });
                uniqId++;
            };
            this._monsterRaces.sortOn("name", Array.CASEINSENSITIVE);
            for each (mainCat in this._monsterRaces)
            {
                for each (race in monsterRaces)
                {
                    if (((((race.superRaceId == mainCat.realId) && (race.id > -1)) && (race.monsters)) && (race.monsters.length)))
                    {
                        mainCat.subcats.push({
                            "id":uniqId,
                            "realId":race.id,
                            "name":race.name,
                            "parentId":mainCat.id,
                            "monsters":race.monsters
                        });
                        uniqId++;
                    };
                };
                mainCat.subcats.sortOn("name", Array.CASEINSENSITIVE);
            };
            areas = this.dataApi.getAllArea(false, false);
            subAreas = this.dataApi.getAllSubAreas();
            for each (area in areas)
            {
                if (area.id != 66)
                {
                    this._monsterAreas.push({
                        "id":uniqId,
                        "realId":area.id,
                        "name":area.name,
                        "parentId":0,
                        "subcats":new Array()
                    });
                };
                uniqId++;
            };
            this._monsterAreas.sortOn("name", Array.CASEINSENSITIVE);
            for each (mainCat in this._monsterAreas)
            {
                for each (subarea in subAreas)
                {
                    if ((((subarea.areaId == mainCat.realId) && (subarea.monsters)) && (subarea.monsters.length)))
                    {
                        mainCat.subcats.push({
                            "id":uniqId,
                            "realId":subarea.id,
                            "name":subarea.name,
                            "parentId":mainCat.id,
                            "monsters":subarea.monsters
                        });
                        uniqId++;
                    };
                };
                mainCat.subcats.sortOn("name", Array.CASEINSENSITIVE);
            };
        }

        public function get recipeSlotsNumber():int
        {
            return (this._recipeSlotsNumber);
        }

        public function set recipeSlotsNumber(value:int):void
        {
            this._recipeSlotsNumber = value;
        }

        public function get calendarInfos():Object
        {
            var calendarObj:Object = {
                "month":this._monthInfo,
                "zodiac":this._zodiacInfo,
                "event":this._eventInfo,
                "calendar":this._calendar,
                "meryde":this._meryde
            };
            return (calendarObj);
        }

        public function isCalendarDisabled():Boolean
        {
            return (this._dateId == -1);
        }

        public function get objectivesTextByAchievement():Array
        {
            return (this._objectivesTextByAchievement);
        }

        public function set objectivesTextByAchievement(a:Array):void
        {
            this._objectivesTextByAchievement = a;
        }

        public function get monsterRaces():Array
        {
            return (this._monsterRaces);
        }

        public function set monsterRaces(a:Array):void
        {
            this._monsterRaces = a;
        }

        public function get monsterAreas():Array
        {
            return (this._monsterAreas);
        }

        public function set monsterAreas(a:Array):void
        {
            this._monsterAreas = a;
        }

        public function get lastAchievementOpenedId():int
        {
            return (this._lastAchievementOpenedId);
        }

        public function set lastAchievementOpenedId(id:int):void
        {
            this._lastAchievementOpenedId = id;
        }

        public function get lastAchievementCategoryOpenedId():int
        {
            return (this._lastAchievementCategoryOpenedId);
        }

        public function set lastAchievementCategoryOpenedId(id:int):void
        {
            this._lastAchievementCategoryOpenedId = id;
        }

        public function get lastAchievementScrollValue():int
        {
            return (this._lastAchievementScrollValue);
        }

        public function set lastAchievementScrollValue(v:int):void
        {
            this._lastAchievementScrollValue = v;
        }

        public function get lastAchievementSearchCriteria():String
        {
            return (this._lastAchievementSearchCriteria);
        }

        public function set lastAchievementSearchCriteria(s:String):void
        {
            this._lastAchievementSearchCriteria = s;
        }

        public function get titleCurrentTab():int
        {
            return (this._titleCurrentTab);
        }

        public function set titleCurrentTab(t:int):void
        {
            this._titleCurrentTab = t;
        }

        public function get bestiaryDisplayCriteriaDrop():Boolean
        {
            return (this._bestiaryDisplayCriteriaDrop);
        }

        public function set bestiaryDisplayCriteriaDrop(b:Boolean):void
        {
            this._bestiaryDisplayCriteriaDrop = b;
        }

        public function get bestiarySearchOnDrop():Boolean
        {
            return (this._bestiarySearchOnDrop);
        }

        public function set bestiarySearchOnDrop(b:Boolean):void
        {
            this._bestiarySearchOnDrop = b;
        }

        public function get bestiarySearchOnName():Boolean
        {
            return (this._bestiarySearchOnName);
        }

        public function set bestiarySearchOnName(b:Boolean):void
        {
            this._bestiarySearchOnName = b;
        }

        public function get achievementSearchOnName():Boolean
        {
            return (this._achievementSearchOnName);
        }

        public function set achievementSearchOnName(b:Boolean):void
        {
            this._achievementSearchOnName = b;
        }

        public function get achievementSearchOnObjective():Boolean
        {
            return (this._achievementSearchOnObjective);
        }

        public function set achievementSearchOnObjective(b:Boolean):void
        {
            this._achievementSearchOnObjective = b;
        }

        public function get achievementSearchOnReward():Boolean
        {
            return (this._achievementSearchOnReward);
        }

        public function set achievementSearchOnReward(b:Boolean):void
        {
            this._achievementSearchOnReward = b;
        }

        public function get questSearchOnName():Boolean
        {
            return (this._questSearchOnName);
        }

        public function set questSearchOnName(b:Boolean):void
        {
            this._questSearchOnName = b;
        }

        public function get questSearchOnCategory():Boolean
        {
            return (this._questSearchOnCategory);
        }

        public function set questSearchOnCategory(b:Boolean):void
        {
            this._questSearchOnCategory = b;
        }

        public function get lastJobOpenedId():int
        {
            return (this._lastJobOpenedId);
        }

        public function set lastJobOpenedId(id:int):void
        {
            this._lastJobOpenedId = id;
        }

        public function get spellShowAllObtentionLevel():Boolean
        {
            return (this._spellShowAllObtentionLevel);
        }

        public function set spellShowAllObtentionLevel(b:Boolean):void
        {
            this._spellShowAllObtentionLevel = b;
        }

        public function get newSpellIdsToHighlight():Array
        {
            return (this._newSpellIdsToHighlight);
        }

        public function removeSpellIdToHighlight(id:int):void
        {
            var index:int = this._newSpellIdsToHighlight.indexOf(id);
            if (index == -1)
            {
                return;
            };
            this.sysApi.log(2, ((("removeSpellIdToHighlight " + id) + "   à l'index ") + index));
            this._newSpellIdsToHighlight.splice(index, 1);
            this.sysApi.dispatchHook(SpellsToHighlightUpdate, this._newSpellIdsToHighlight);
        }

        public function get currentBreedSpells():Array
        {
            if (!this._currentSpellsList)
            {
                this._currentSpellsList = new Array();
            };
            var playerLevel:int = this.playerApi.getPlayedCharacterInfo().level;
            if (((!(this._currentSpellsList[0])) || (!(this._playerLevelForCurrentSpellsList[0] == playerLevel))))
            {
                this._currentSpellsList[0] = this.playerApi.getSpells(true);
                this._playerLevelForCurrentSpellsList[0] = playerLevel;
            };
            return (this._currentSpellsList[0]);
        }

        public function get currentSpecialSpells():Array
        {
            if (!this._currentSpellsList)
            {
                this._currentSpellsList = new Array();
            };
            var playerLevel:int = this.playerApi.getPlayedCharacterInfo().level;
            if (((!(this._currentSpellsList[1])) || (!(this._playerLevelForCurrentSpellsList[1] == playerLevel))))
            {
                this._currentSpellsList[1] = this.playerApi.getSpells(false);
                this._playerLevelForCurrentSpellsList[1] = playerLevel;
            };
            return (this._currentSpellsList[1]);
        }

        private function onOpenGrimoire(tab:String=null, param:Object=null, restoreSnapshot:Boolean=true, strata:int=1):void
        {
            var questBaseUi:*;
            var tabUi:*;
            switch (tab)
            {
                case EnumTab.SPELL_TAB:
                case EnumTab.ALIGNMENT_TAB:
                case EnumTab.TITLE_TAB:
                case EnumTab.COMPANION_TAB:
                case EnumTab.JOB_TAB:
                case EnumTab.IDOLS_TAB:
                case EnumTab.TEMPORIS_SPELLS_UI:
                case EnumTab.ENCYCLOPEDIA:
                    if (!this.uiApi.getUi(tab))
                    {
                        this.uiApi.loadUi(tab, tab, param, (((param) && (param.strata)) ? param.strata : strata), null, false, false, restoreSnapshot);
                    }
                    else
                    {
                        this.uiApi.unloadUi(tab);
                    };
                    return;
                case EnumTab.BESTIARY_TAB:
                    if (!this.uiApi.getUi(UIEnum.ENCYCLOPEDIA_BASE))
                    {
                        this.uiApi.loadUi(UIEnum.ENCYCLOPEDIA_BASE, UIEnum.ENCYCLOPEDIA_BASE, param, 1, null, false, false, false);
                    }
                    else
                    {
                        this.uiApi.unloadUi(UIEnum.ENCYCLOPEDIA_BASE);
                    };
                    return;
                case EnumTab.CALENDAR_TAB:
                case EnumTab.QUEST_TAB:
                case EnumTab.ACHIEVEMENT_TAB:
                case EnumTab.TEMPORIS_QUEST_TAB:
                    if (!this.uiApi.getUi(UIEnum.QUEST_BASE))
                    {
                        if (tab == EnumTab.TEMPORIS_QUEST_TAB)
                        {
                            this.sysApi.dispatchHook(CloseNotification, ["FirstTemporisIVRewardNotif"]);
                        };
                        this.uiApi.loadUi(UIEnum.QUEST_BASE, UIEnum.QUEST_BASE, [tab, param], 1, null, false, false, false);
                    }
                    else
                    {
                        questBaseUi = this.uiApi.getUi(UIEnum.QUEST_BASE);
                        if (((((questBaseUi.uiClass.getTab() == tab) && (tab == EnumTab.QUEST_TAB)) && (param)) && (param.quest)))
                        {
                            tabUi = this.uiApi.getUi("subQuestUi");
                            tabUi.uiClass.selectQuestById(param.quest.id);
                        }
                        else
                        {
                            questBaseUi.uiClass.openTab(tab, 0, param);
                        };
                    };
                    return;
            };
            if ((((((((this.tabOpened == EnumTab.QUEST_TAB) && (tab == EnumTab.QUEST_TAB)) || ((this.tabOpened == EnumTab.ACHIEVEMENT_TAB) && (tab == EnumTab.ACHIEVEMENT_TAB))) || ((this.tabOpened == EnumTab.TITLE_TAB) && (tab == EnumTab.TITLE_TAB))) || ((this.tabOpened == EnumTab.BESTIARY_TAB) && (tab == EnumTab.BESTIARY_TAB))) && (param)) && (param.forceOpen)))
            {
                return;
            };
            if (((tab == EnumTab.CALENDAR_TAB) && (!(this.questApi.getCompletedQuests()))))
            {
                return;
            };
            if (((tab == EnumTab.SPELL_TAB) && (!(this.playerApi.characteristics()))))
            {
                return;
            };
            if (this.tabOpened == "")
            {
                if (tab == EnumTab.CALENDAR_TAB)
                {
                    if (this._dateId == -1)
                    {
                        return;
                    };
                }
                else
                {
                    if (tab == EnumTab.TITLE_TAB)
                    {
                        if (this.playerApi.isInFight())
                        {
                            return;
                        };
                    };
                };
                this.tabOpened = tab;
                if (this.uiApi.getUi(UIEnum.CHARACTER_SHEET_UI))
                {
                    this.uiApi.unloadUi(UIEnum.CHARACTER_SHEET_UI);
                };
                this.uiApi.loadUi(UIEnum.GRIMOIRE, UIEnum.GRIMOIRE, [tab, param], 1, null, false, false, restoreSnapshot);
            }
            else
            {
                if (this.tabOpened == tab)
                {
                    this.uiApi.unloadUi(UIEnum.GRIMOIRE);
                }
                else
                {
                    if (tab == EnumTab.CALENDAR_TAB)
                    {
                        if (this._dateId == -1)
                        {
                            return;
                        };
                    }
                    else
                    {
                        if (tab == EnumTab.TITLE_TAB)
                        {
                            if (this.playerApi.isInFight())
                            {
                                return;
                            };
                        };
                    };
                    this.tabOpened = tab;
                    this.uiApi.getUi(UIEnum.GRIMOIRE).uiClass.openTab(tab, param);
                };
            };
        }

        private function onOpenEncyclopedia(tab:String=null, param:Object=null, restoreSnapshot:Boolean=true):void
        {
            switch (tab)
            {
                case EnumTab.BESTIARY_TAB:
                case EnumTab.ENCYCLOPEDIA_EQUIPMENT_TAB:
                case EnumTab.ENCYCLOPEDIA_CONSUMABLE_TAB:
                case EnumTab.ENCYCLOPEDIA_RESOURCE_TAB:
                    if (!this.uiApi.getUi(UIEnum.ENCYCLOPEDIA_BASE))
                    {
                        if (param != null)
                        {
                            this.uiApi.loadUi(UIEnum.ENCYCLOPEDIA_BASE, UIEnum.ENCYCLOPEDIA_BASE, [tab, param], 1, null, false, false, false);
                        }
                        else
                        {
                            this.uiApi.loadUi(UIEnum.ENCYCLOPEDIA_BASE);
                        };
                    }
                    else
                    {
                        if (param)
                        {
                            if (param.forceOpenResourceTab)
                            {
                                EncyclopediaBase.getInstance().openTab(EnumTab.ENCYCLOPEDIA_RESOURCE_TAB, param);
                            }
                            else
                            {
                                if (param.forceOpenConsumableTab)
                                {
                                    EncyclopediaBase.getInstance().openTab(EnumTab.ENCYCLOPEDIA_CONSUMABLE_TAB, param);
                                }
                                else
                                {
                                    if (param.forceOpenEquipmentTab)
                                    {
                                        EncyclopediaBase.getInstance().openTab(EnumTab.ENCYCLOPEDIA_EQUIPMENT_TAB, param);
                                    }
                                    else
                                    {
                                        if (param.forceOpen)
                                        {
                                            EncyclopediaBase.getInstance().openTab(EnumTab.BESTIARY_TAB, param);
                                        }
                                        else
                                        {
                                            this.uiApi.unloadUi(UIEnum.ENCYCLOPEDIA_BASE);
                                        };
                                    };
                                };
                            };
                        }
                        else
                        {
                            this.uiApi.unloadUi(UIEnum.ENCYCLOPEDIA_BASE);
                        };
                    };
                    break;
            };
        }

        private function onSpellsList(spellList:Object):void
        {
            var playerLevel:int = this.playerApi.getPlayedCharacterInfo().level;
            this._playerLevelForCurrentSpellsList[0] = playerLevel;
            this._playerLevelForCurrentSpellsList[1] = playerLevel;
            this._currentSpellsList[0] = this.playerApi.getSpells(true);
            this._currentSpellsList[1] = this.playerApi.getSpells(false);
        }

        private function onOpenSpellInterface(spellId:uint):void
        {
            var displayVariantsTab:Boolean;
            var spellsToSearch:Array = Grimoire.getInstance().currentBreedSpells;
            var spellIndexToShow:int = this.getSpellIndexInArray(spellsToSearch, spellId);
            if (spellIndexToShow > -1)
            {
                displayVariantsTab = true;
            }
            else
            {
                spellsToSearch = Grimoire.getInstance().currentSpecialSpells;
                spellIndexToShow = this.getSpellIndexInArray(spellsToSearch, spellId);
                if (spellIndexToShow > -1)
                {
                    displayVariantsTab = false;
                };
            };
            if (!this.uiApi.getUi(EnumTab.SPELL_TAB))
            {
                this.uiApi.loadUi(EnumTab.SPELL_TAB, EnumTab.SPELL_TAB, [EnumTab.SPELLSLIST_TAB, {
                    "variantsListTab":displayVariantsTab,
                    "spellId":spellId
                }]);
            }
            else
            {
                SpellBase.getInstance().openTab(EnumTab.SPELLSLIST_TAB, {
                    "variantsListTab":displayVariantsTab,
                    "spellId":spellId
                });
            };
        }

        private function getSpellIndexInArray(spellList:Array, spellId:int):int
        {
            var variants:Array;
            var spellWrapper:SpellWrapper;
            var currentIndex:int = -1;
            var variantsPairsCount:int = spellList.length;
            var i:int;
            i = 0;
            while (i < variantsPairsCount)
            {
                variants = spellList[i];
                for each (spellWrapper in variants)
                {
                    if (spellWrapper.id == spellId)
                    {
                        currentIndex = i;
                    };
                };
                i++;
            };
            return (currentIndex);
        }

        private function onCalendarDate(dateId:int):void
        {
            var calendarUi:Object;
            var lastNotif:int;
            var notifId:uint;
            if (dateId != this._dateId)
            {
                calendarUi = this.uiApi.getUi(EnumTab.CALENDAR_TAB);
                this._dateId = dateId;
                if (dateId > -1)
                {
                    this._calendar = this.dataApi.getAlmanaxCalendar(dateId);
                    this._monthInfo = this.dataApi.getAlmanaxMonth();
                    this._zodiacInfo = this.dataApi.getAlmanaxZodiac();
                    this._eventInfo = this.dataApi.getAlmanaxEvent();
                    this._meryde = this.dataApi.getNpc(this._calendar.npcId);
                    if (((calendarUi) && (calendarUi.uiClass)))
                    {
                        calendarUi.uiClass.updateCalendarInfos();
                    };
                }
                else
                {
                    if (calendarUi)
                    {
                        this.uiApi.unloadUi(UIEnum.GRIMOIRE);
                    };
                };
            };
            var hideAlmanaxDailyNotif:* = this.sysApi.getData("hideAlmanaxDailyNotif");
            if (((!(hideAlmanaxDailyNotif == undefined)) && (!(hideAlmanaxDailyNotif))))
            {
                lastNotif = this.sysApi.getData("lastAlmanaxNotif");
                if (lastNotif != this._dateId)
                {
                    notifId = this.notifApi.prepareNotification(this.timeApi.getDofusDate(), this.uiApi.getText("ui.almanax.offeringTo", this._meryde.name), 2, "notifAlmanax");
                    this.notifApi.addButtonToNotification(notifId, this.uiApi.getText("ui.almanax.almanax"), "OpenBook", ["calendarTab"], true, 130);
                    this.notifApi.sendNotification(notifId);
                    this.sysApi.setData("lastAlmanaxNotif", this._dateId);
                };
            };
        }

        private function onQuestStarted(questId:uint):void
        {
            var questListMinimized:Boolean;
            var questListUi:*;
            var followQuest:Boolean = this.configApi.getConfigProperty("dofus", "followQuestOnStarted");
            if (followQuest)
            {
                questListMinimized = this.sysApi.getData("questListMinimized", DataStoreEnum.BIND_ACCOUNT);
                if (questListMinimized)
                {
                    if (!this.uiApi.getUi(UIEnum.QUEST_LIST_MINIMIZED))
                    {
                        this.uiApi.loadUi(UIEnum.QUEST_LIST_MINIMIZED, UIEnum.QUEST_LIST_MINIMIZED, null, StrataEnum.STRATA_TOP);
                    };
                };
                questListUi = this.uiApi.getUi(UIEnum.QUEST_LIST);
                if (!questListUi)
                {
                    this.uiApi.loadUi(UIEnum.QUEST_LIST, UIEnum.QUEST_LIST, {
                        "visible":(!(questListMinimized)),
                        "quests":[{"questId":questId}]
                    }, StrataEnum.STRATA_TOP);
                };
            };
        }

        private function onQuestValidated(questId:uint):void
        {
            var lastSelectedQuest:uint = this.sysApi.getData("lastQuestSelected");
            if (lastSelectedQuest == questId)
            {
                this.sysApi.setData("lastQuestSelected", 0);
            };
        }

        private function onLevelUp(pOldLevel:uint, pNewLevel:uint, pCaracPointEarned:uint, pHealPointEarned:uint, newSpellWrappers:Array):void
        {
            var wrapper:SpellWrapper;
            if (newSpellWrappers.length == 0)
            {
                return;
            };
            if (this._playerLevelForCurrentSpellsList[0] != pNewLevel)
            {
                this._currentSpellsList[0] = this.playerApi.getSpells(true);
                this._playerLevelForCurrentSpellsList[0] = pNewLevel;
            };
            if (this._playerLevelForCurrentSpellsList[1] != pNewLevel)
            {
                this._currentSpellsList[1] = this.playerApi.getSpells(false);
                this._playerLevelForCurrentSpellsList[1] = pNewLevel;
            };
            for each (wrapper in newSpellWrappers)
            {
                if (this._newSpellIdsToHighlight.indexOf(wrapper.id) == -1)
                {
                    this._newSpellIdsToHighlight.push(wrapper.id);
                };
            };
            this.sysApi.dispatchHook(SpellsToHighlightUpdate, this._newSpellIdsToHighlight);
        }


    }
}

