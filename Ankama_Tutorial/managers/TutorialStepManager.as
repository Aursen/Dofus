package Ankama_Tutorial.managers
{
    import flash.utils.Timer;
    import Ankama_Tutorial.Api;
    import d2hooks.EquipmentObjectMove;
    import d2hooks.GameFightStarting;
    import d2hooks.GameFightStart;
    import d2hooks.GameEntityDisposition;
    import d2hooks.PlayerFightMove;
    import d2hooks.FightSpellCast;
    import d2hooks.GameFightTurnEnd;
    import d2hooks.PlayerMove;
    import d2hooks.UiLoaded;
    import d2hooks.UiUnloaded;
    import d2hooks.StorageFilterUpdated;
    import d2hooks.MapComplementaryInformationsData;
    import d2hooks.DropStart;
    import d2hooks.DropEnd;
    import d2hooks.CastSpellMode;
    import d2hooks.CancelCastSpell;
    import d2hooks.GameFightEnd;
    import d2hooks.StopableSoundEnded;
    import d2hooks.NpcDialogRepliesVisible;
    import d2hooks.FightResultClosed;
    import Ankama_Tutorial.TutorialConstants;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import flash.utils.Dictionary;
    import flash.events.TimerEvent;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import d2hooks.TutorialStep;
    import d2actions.QuestObjectiveValidation;
    import com.ankamagames.berilia.types.shortcut.Bind;
    import com.ankamagames.dofus.datacenter.items.ItemType;
    import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
    import d2hooks.*;
    import d2actions.*;

    public class TutorialStepManager 
    {

        private static var _self:TutorialStepManager;
        private static var _watchedComponents:Object = null;
        private static var _fightWatchedComponents:Object = null;
        private static var _disabledShortcuts:Object = {
            "cac":false,
            "s1":false,
            "s2":false,
            "s3":false,
            "s4":false,
            "s5":false,
            "s6":false,
            "s7":false,
            "s8":false,
            "s9":false,
            "s10":false,
            "s11":false,
            "s12":false,
            "s13":false,
            "s14":false,
            "s15":false,
            "s16":false,
            "s17":false,
            "s18":false,
            "s19":false,
            "s20":false,
            "skipTurn":false,
            "bannerSpellsTab":false,
            "bannerItemsTab":false,
            "bannerEmotesTab":false,
            "bannerPreviousTab":false,
            "bannerNextTab":false,
            "flagCurrentMap":false,
            "openInventory":false,
            "openBookSpell":false,
            "openBookQuest":false,
            "openBookAlignment":false,
            "openBookJob":false,
            "openWorldMap":false,
            "openSocialFriends":false,
            "openSocialGuild":false,
            "openSocialAlliance":false,
            "openSocialSpouse":false,
            "openCharacterSheet":false,
            "openMount":false,
            "openWebBrowser":false,
            "openTeamSearch":false,
            "openPvpArena":false,
            "openSell":false,
            "openAlmanax":false,
            "openAchievement":false,
            "openTitle":false,
            "openBestiary":false,
            "openHavenbag":false,
            "showAllNames":false,
            "showEntitiesTooltips":false,
            "toggleRide":false,
            "pageItem1":false,
            "pageItem2":false,
            "pageItem3":false,
            "pageItem4":false,
            "pageItem5":false,
            "pageItemDown":false,
            "pageItemUp":false,
            "openIdols":false,
            "openBuild":false,
            "openTemporisQuestTab":false
        };
        private static var _dropItem:Object;
        private static const DELAY_BEFORE_HIGHLIGHT_SHORT:uint = 5000;
        private static const DELAY_BEFORE_HIGHLIGHT_LONG:uint = 10000;

        private const INTRO_DIALOGUE_DURATION:int = 3000;

        private var _bannerMenuUiClass:Object;
        private var _actionBarUiClass:Object;
        private var _currentStepNumber:int = -1;
        private var _introStepTimer:Timer;
        private var _quest:Object;
        private var _disabled:Boolean = false;
        public var doneIntroStep:Boolean = false;

        public function TutorialStepManager()
        {
            Api.system.addHook(EquipmentObjectMove, this.onEquipmentObjectMove);
            Api.system.addHook(GameFightStarting, this.onGameFightStarting);
            Api.system.addHook(GameFightStart, this.onGameFightStart);
            Api.system.addHook(GameEntityDisposition, this.onGameEntityDisposition);
            Api.system.addHook(PlayerFightMove, this.onPlayerFightMove);
            Api.system.addHook(FightSpellCast, this.onFightSpellCast);
            Api.system.addHook(GameFightTurnEnd, this.onGameFightTurnEnd);
            Api.system.addHook(PlayerMove, this.onPlayerMove);
            Api.system.addHook(UiLoaded, this.onUiLoaded);
            Api.system.addHook(UiUnloaded, this.onUiUnloaded);
            Api.system.addHook(StorageFilterUpdated, this.onStorageFilterUpdated);
            Api.system.addHook(MapComplementaryInformationsData, this.onMapComplementaryInformationsData);
            Api.system.addHook(DropStart, this.onDropStart);
            Api.system.addHook(DropEnd, this.onDropEnd);
            Api.system.addHook(CastSpellMode, this.onCastSpellMode);
            Api.system.addHook(CancelCastSpell, this.onCancelCastSpell);
            Api.system.addHook(GameFightEnd, this.onGameFightEnd);
            Api.system.addHook(StopableSoundEnded, this.onSoundEnded);
            Api.system.addHook(NpcDialogRepliesVisible, this.onNpcDialogRepliesVisible);
            Api.system.addHook(FightResultClosed, this.onFightResultClosed);
            this._quest = Api.data.getQuest(TutorialConstants.QUEST_TUTORIAL_ID);
            var doneIntroData:* = Api.system.getData((Api.player.getPlayedCharacterInfo().id + "doneIntroStep"));
            if (doneIntroData)
            {
                this.doneIntroStep = doneIntroData;
            };
            this._disabled = true;
        }

        public static function initStepManager():void
        {
            _self = new (TutorialStepManager)();
        }

        public static function getInstance():TutorialStepManager
        {
            if (_self == null)
            {
                initStepManager();
            };
            return (_self);
        }


        public function get preloaded():Boolean
        {
            return ((!(_watchedComponents == null)) && (!(_fightWatchedComponents == null)));
        }

        public function set disabled(b:Boolean):void
        {
            this._disabled = b;
            if (b)
            {
                this.unsetAllDisabled();
            }
            else
            {
                this.redoSteps();
            };
        }

        public function unload():void
        {
            _watchedComponents = null;
            _fightWatchedComponents = null;
        }

        public function get disabled():Boolean
        {
            return (this._disabled);
        }

        public function get bannerMenuUiClass():Object
        {
            return (this._bannerMenuUiClass);
        }

        public function set bannerMenuUiClass(uiClass:Object):void
        {
            this._bannerMenuUiClass = uiClass;
        }

        public function removeHooks():void
        {
            Api.system.removeHook(EquipmentObjectMove);
            Api.system.removeHook(GameFightStarting);
            Api.system.removeHook(GameFightStart);
            Api.system.removeHook(GameEntityDisposition);
            Api.system.removeHook(PlayerFightMove);
            Api.system.removeHook(FightSpellCast);
            Api.system.removeHook(GameFightTurnEnd);
            Api.system.removeHook(PlayerMove);
            Api.system.removeHook(UiLoaded);
            Api.system.removeHook(UiUnloaded);
            Api.system.removeHook(StorageFilterUpdated);
            Api.system.removeHook(MapComplementaryInformationsData);
            Api.system.removeHook(DropStart);
            Api.system.removeHook(DropEnd);
            Api.system.removeHook(CastSpellMode);
            Api.system.removeHook(CancelCastSpell);
            Api.system.removeHook(GameFightEnd);
            Api.system.removeHook(StopableSoundEnded);
            Api.system.removeHook(NpcDialogRepliesVisible);
            Api.system.removeHook(FightResultClosed);
        }

        private function onPlayerMove():void
        {
            if (!this.disabled)
            {
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_ROLEPLAY_MOVE)
                {
                    this.validateCurrentStep();
                };
            };
        }

        private function onGameFightEnd(params:Object):void
        {
            if (!this.disabled)
            {
                Api.highlight.stop();
            };
        }

        private function onEquipmentObjectMove(item:Object, oldPosition:uint):void
        {
            var nbItems:int;
            var hasRing:Boolean;
            var i:Object;
            if (!this.disabled)
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        if (item)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__CLOSE_INTERFACE);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        nbItems = 0;
                        hasRing = false;
                        for each (i in Api.storage.getViewContent("equipment"))
                        {
                            if (!i)
                            {
                            }
                            else
                            {
                                if (TutorialConstants.TUTORIAL_RINGS_POSITIONS.indexOf(i.position) != -1)
                                {
                                    hasRing = true;
                                }
                                else
                                {
                                    if (TutorialConstants.TUTORIAL_ITEMS_POSITIONS.indexOf(i.position) != -1)
                                    {
                                        nbItems++;
                                    };
                                };
                            };
                        };
                        if (((nbItems == TutorialConstants.TUTORIAL_ITEMS_POSITIONS.length) && (hasRing)))
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__CLOSE_CHARACTER_SHEET);
                        };
                        break;
                };
            };
        }

        private function onGameFightStarting(fightType:uint):void
        {
            if (!this.disabled)
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_STARTING_A_FIGHT:
                        this.validateCurrentStep();
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                        this.validateCurrentStep();
                        break;
                };
            };
        }

        private function onGameEntityDisposition(dispositionInformation:Object, cellId:uint, direction:uint):void
        {
            if (!this.disabled)
            {
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_LOCATION)
                {
                    this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_LOCATION__START_FIGHT);
                };
            };
        }

        private function onGameFightStart():void
        {
            if (!this.disabled)
            {
                if (this._currentStepNumber < TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL)
                {
                    _watchedComponents["SpellsBanner"].disabled = true;
                };
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_LOCATION)
                {
                    this.validateCurrentStep();
                };
            };
        }

        private function onPlayerFightMove():void
        {
            if (!this.disabled)
            {
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_MOVE)
                {
                    this.validateCurrentStep();
                };
            };
        }

        private function onFightSpellCast():void
        {
            if (!this.disabled)
            {
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL)
                {
                    this.validateCurrentStep();
                };
            };
        }

        private function onGameFightTurnEnd(entityId:Number):void
        {
            if (!this.disabled)
            {
                if (this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_SKIP_TURN)
                {
                    if (entityId == Api.player.id())
                    {
                        this.validateCurrentStep();
                    };
                };
            };
        }

        private function onUiLoaded(name:String):void
        {
            var ui:Object;
            if (!this.disabled)
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_TALK:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_RESPONSE);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_RESPONSE);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_RESPONSE);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            ui = Api.ui.getUi(name);
                            if (((ui) && (!(ui.uiClass.categoryFilter == 0))))
                            {
                                this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TAB);
                            }
                            else
                            {
                                this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT);
                            };
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_CHANGE_MAP:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            ui = Api.ui.getUi(name);
                            if (ui)
                            {
                                ui.uiClass.categoryFilter = 0;
                            };
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT);
                        };
                        break;
                };
            };
        }

        private function onUiUnloaded(name:String):void
        {
            var nbItems:int;
            var hasRing:Boolean;
            var i:Object;
            if (!this.disabled)
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_TALK:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_NPC);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_NPC);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                        if (name == "npcDialog")
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            if (Api.player.getEquipment().length > 0)
                            {
                                this.validateCurrentStep();
                            }
                            else
                            {
                                this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__OPEN_CHARACTER_SHEET);
                            };
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            nbItems = 0;
                            hasRing = false;
                            for each (i in Api.storage.getViewContent("equipment"))
                            {
                                if (!i)
                                {
                                }
                                else
                                {
                                    if (TutorialConstants.TUTORIAL_RINGS_POSITIONS.indexOf(i.position) != -1)
                                    {
                                        hasRing = true;
                                    }
                                    else
                                    {
                                        if (TutorialConstants.TUTORIAL_ITEMS_POSITIONS.indexOf(i.position) != -1)
                                        {
                                            nbItems++;
                                        };
                                    };
                                };
                            };
                            if (((nbItems == TutorialConstants.TUTORIAL_ITEMS_POSITIONS.length) && (hasRing)))
                            {
                                this.validateCurrentStep();
                            }
                            else
                            {
                                this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_CHARACTER_SHEET);
                            };
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_CHANGE_MAP:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                        if (name == UIEnum.STORAGE_UI)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_INTRO_DIALOGUE:
                        if (name == UIEnum.CINEMATIC)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_INTRO_DIALOGUE);
                        };
                        break;
                };
            };
        }

        public function onFightResultClosed():void
        {
            if (!this.disabled)
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC);
                        break;
                    case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_NPC);
                        break;
                };
            };
        }

        public function onMapComplementaryInformationsData(map:Object, subAreaId:uint, show:Boolean):void
        {
            if (!this.disabled)
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_TALK:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_NPC);
                        break;
                    case TutorialConstants.TUTORIAL_STEP_STARTING_A_FIGHT:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_STARTING_A_FIGHT__SHOW_MONSTER);
                        break;
                    case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__CLOSE_FIGHT_RESULT);
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                        if (map.mapId == TutorialConstants.TUTORIAL_MAP_ID_THIRD_BEFORE_FIGHT)
                        {
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_BOSS);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__CLOSE_FIGHT_RESULT);
                        break;
                };
            };
        }

        public function onDropStart(src:Object):void
        {
            if (((!(this.disabled)) && (src.data)))
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        if ((src.data is ItemWrapper))
                        {
                            _dropItem = src.data;
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TARGET);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        if ((src.data is ItemWrapper))
                        {
                            _dropItem = src.data;
                            this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT_TARGET);
                        };
                        break;
                };
            };
        }

        public function onDropEnd(src:Object, target:Object):void
        {
            if (!this.disabled)
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT);
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT);
                        break;
                };
            };
        }

        public function onCastSpellMode(spell:Object):void
        {
            if (!this.disabled)
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_TARGET);
                        break;
                };
            };
        }

        public function onCancelCastSpell(spell:Object):void
        {
            if (!this.disabled)
            {
                switch (this._currentStepNumber)
                {
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL:
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_SPELL);
                        break;
                };
            };
        }

        public function onStorageFilterUpdated(items:Object, category:int):void
        {
            switch (this._currentStepNumber)
            {
                case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                    if (category == ItemCategoryEnum.EQUIPMENT_CATEGORY)
                    {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT);
                    }
                    else
                    {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TAB);
                    };
                    break;
                case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                    if (category == ItemCategoryEnum.EQUIPMENT_CATEGORY)
                    {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT);
                    }
                    else
                    {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_TAB);
                    };
                    break;
            };
        }

        private function onSoundEnded(fileName:String):void
        {
            if (fileName == TutorialConstants.TUTORIAL_AUDIO_DIALOG_INTRO)
            {
                this.jumpToStep(TutorialConstants.TUTORIAL_STEP_ROLEPLAY_MOVE);
                if (this._introStepTimer)
                {
                    this._introStepTimer.stop();
                };
            };
        }

        private function onNpcDialogRepliesVisible(pVisible:Boolean):void
        {
            if (!this.disabled)
            {
                Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_LONG);
                Api.highlight.highlightUi("npcDialog", "btn_rep0", 7, 1, 5, true);
            };
        }

        public function preload():void
        {
            this.loadWatchedComponents();
            this.loadFightWatchedComponents();
        }

        public function loadWatchedComponents():void
        {
            var bannerMenuUi:* = Api.ui.getUi("bannerMenu");
            var actionBarUi:* = Api.ui.getUi("bannerActionBar");
            if (((!(bannerMenuUi)) || (!(actionBarUi))))
            {
                return;
            };
            this._bannerMenuUiClass = bannerMenuUi.uiClass;
            this._actionBarUiClass = actionBarUi.uiClass;
            _watchedComponents = new Dictionary();
            _watchedComponents["SpellsBanner"] = this._actionBarUiClass.gd_spellitemotes;
            _watchedComponents["InventoryButton"] = this._bannerMenuUiClass.ID_BTN_BAG;
            _watchedComponents["GrimoireButton"] = this._bannerMenuUiClass.ID_BTN_SPELL;
            _watchedComponents["QuestButton"] = this._bannerMenuUiClass.ID_BTN_BOOK;
            _watchedComponents["SpellTab"] = this._actionBarUiClass.btn_tabSpells;
            _watchedComponents["InventoryTab"] = this._actionBarUiClass.btn_tabItems;
            this.checkComponents(_watchedComponents);
        }

        public function loadFightWatchedComponents():void
        {
            var bannerUi:* = Api.ui.getUi(UIEnum.BANNER);
            if (!bannerUi)
            {
                return;
            };
            var bannerUiClass:Object = bannerUi.uiClass;
            _fightWatchedComponents = new Dictionary();
            _fightWatchedComponents["SkipTurnButton"] = bannerUiClass.btn_readyOrSkip;
            _fightWatchedComponents["ReadyButton"] = bannerUiClass.btn_readyOrSkip;
            _fightWatchedComponents["LeaveButton"] = bannerUiClass.btn_leave;
            _fightWatchedComponents["HelpButton"] = bannerUiClass.btn_requestHelp;
            _fightWatchedComponents["AllowJoinFightButton"] = bannerUiClass.btn_lockFight;
            _fightWatchedComponents["AllowJoinFightPartyButton"] = bannerUiClass.btn_lockParty;
            _fightWatchedComponents["InvisibleModeButton"] = bannerUiClass.btn_tacticMode;
            _fightWatchedComponents["AllowSpectatorButton"] = bannerUiClass.btn_noSpectator;
            _fightWatchedComponents["ShowCellButton"] = bannerUiClass.btn_pointCell;
            this.checkComponents(_fightWatchedComponents);
        }

        public function unsetAllDisabled():void
        {
            this.setWatchedElementsDisabled(false);
            this.setFightWatchedElementsDisabled(false);
            this._bannerMenuUiClass.checkAllBtnActivationState(false);
            Api.modMenu.setBehavior(null);
        }

        public function onFakeStepTimerEnd(e:TimerEvent):void
        {
            this.jumpToStep(TutorialConstants.TUTORIAL_STEP_ROLEPLAY_MOVE);
            e.target.removeEventListener(TimerEvent.TIMER, this.onFakeStepTimerEnd);
        }

        public function prepareStep(stepNumber:uint, subStep:uint=0, displayArrow:Boolean=false):void
        {
            var btnPosition:uint;
            var cinematicUi:Object;
            var wp:Object;
            var storageUi:Object;
            var cellId:int;
            var fighter:Object;
            var superTypeId:uint;
            var positions:Object;
            this._currentStepNumber = stepNumber;
            var tutorialUi:Object = Api.ui.getUi(UIEnum.TUTORIAL_UI);
            this.moveTutorialUiDefault();
            Api.highlight.stop();
            if (!this.disabled)
            {
                switch (stepNumber)
                {
                    case TutorialConstants.TUTORIAL_INTRO_DIALOGUE:
                        this.setWatchedElementsDisabled(true);
                        cinematicUi = Api.ui.getUi(UIEnum.CINEMATIC);
                        if (((displayArrow) && (!(cinematicUi))))
                        {
                            this.doneIntroStep = true;
                            Api.system.setData((Api.player.getPlayedCharacterInfo().id + "doneIntroStep"), true);
                            tutorialUi.visible = false;
                            Api.roleplay.showNpcBubble(TutorialConstants.TUTORIAL_PNJ_ID, Api.ui.getText("ui.tutorial.dialog.jorisBubble"));
                            this._introStepTimer = new Timer(this.INTRO_DIALOGUE_DURATION);
                            this._introStepTimer.addEventListener(TimerEvent.TIMER, this.onFakeStepTimerEnd);
                            this._introStepTimer.start();
                            Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimAttaque2");
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_ROLEPLAY_MOVE:
                        tutorialUi.visible = true;
                        this.setWatchedElementsDisabled(true);
                        if (displayArrow)
                        {
                            Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                            Api.highlight.highlightAbsolute(new Rectangle(TutorialConstants.ROLEPLAY_MOVE_DESTINATION_X, TutorialConstants.ROLEPLAY_MOVE_DESTINATION_Y), 0, 0, 0, true);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_TALK:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_TALK__LOADING_MAP:
                                Api.modMenu.getMenuMaker("npc").maker.disabled = false;
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_NPC:
                                if (displayArrow)
                                {
                                    Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                                    Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimAttaque1");
                                    Api.highlight.highlightNpc(TutorialConstants.TUTORIAL_PNJ_ID, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__OPEN_CHARACTER_SHEET:
                                btnPosition = this._bannerMenuUiClass.getBtnById(this._bannerMenuUiClass.ID_BTN_BAG).position;
                                if (displayArrow)
                                {
                                    Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimAttaque6");
                                    if (((btnPosition > this._bannerMenuUiClass.totalNumberOfVisibleButtons) && (!(this._bannerMenuUiClass.ctr_moreBtn.visible))))
                                    {
                                        this._bannerMenuUiClass.toggleAllButtonsVisibility();
                                        Api.highlight.highlightUi(UIEnum.BANNER_MENU, ("gd_additionalBtns|id|" + this._bannerMenuUiClass.ID_BTN_BAG), 3, 0, 5, true);
                                    }
                                    else
                                    {
                                        Api.highlight.highlightUi(UIEnum.BANNER_MENU, ("gd_btnUis|id|" + this._bannerMenuUiClass.ID_BTN_BAG), 0, 0, 5, true);
                                    };
                                };
                                this._bannerMenuUiClass.setDisabledBtn(this._bannerMenuUiClass.ID_BTN_BAG, false);
                                this.setShortcutDisabled("openInventory", false);
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TAB:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "btnEquipable", 0, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT:
                                this.moveTutorialUiLeft();
                                storageUi = Api.ui.getUi(UIEnum.STORAGE_UI);
                                if (displayArrow)
                                {
                                    Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "grid|objectGID|10785|", 0, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TARGET:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "slot_2", 5, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__CLOSE_INTERFACE:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "btn_close", 7, 0, 5, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_CHANGE_MAP:
                        if (!Api.ui.getUi(UIEnum.STORAGE_UI))
                        {
                            subStep = TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION;
                        };
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION:
                                if (displayArrow)
                                {
                                    Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimAttaque8");
                                    Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_LONG);
                                    Api.highlight.highlightMapTransition(TutorialConstants.TUTORIAL_MAP_ID_FIRST, TutorialConstants.CHANGE_MAP_TRANSITION_ORIENTATION, TutorialConstants.CHANGE_MAP_TRANSITION_POSITION, false, 0, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_STARTING_A_FIGHT:
                        this.setFightWatchedElementsDisabled(true);
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_STARTING_A_FIGHT__LOADING_MAP:
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_STARTING_A_FIGHT__SHOW_MONSTER:
                                if (displayArrow)
                                {
                                    Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimAttaque4");
                                    Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                                    Api.highlight.highlightMonster(TutorialConstants.TUTORIAL_MONSTER_ID_POUTCH, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_LOCATION:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_LOCATION__SHOW_CELL:
                                if (displayArrow)
                                {
                                    Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_LONG);
                                    Api.highlight.highlightCell(TutorialConstants.FIGHT_LOCATION_TARGET_CELLS, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_LOCATION__START_FIGHT:
                                this.setShortcutDisabled("skipTurn", false);
                                _fightWatchedComponents["ReadyButton"].disabled = false;
                                Api.modMenu.getMenuMaker("player").maker.disabled = false;
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_MOVE:
                        _fightWatchedComponents["ReadyButton"].disabled = false;
                        if (((Api.player.isInFight()) && (displayArrow)))
                        {
                            cellId = -1;
                            fighter = Api.fight.getFighterInformations(Api.player.id());
                            if (fighter)
                            {
                                cellId = TutorialConstants.FIGHT_MOVE_TARGET_CELLS[fighter.currentCell];
                                Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                                Api.highlight.highlightCell([cellId], true);
                            };
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_SPELL:
                                if (((Api.player.isInFight()) && (displayArrow)))
                                {
                                    Api.highlight.highlightUi("bannerActionBar", "gd_spellitemotes|slot|1");
                                };
                                _fightWatchedComponents["SkipTurnButton"].disabled = false;
                                this.setShortcutDisabled("skipTurn", false);
                                _watchedComponents["SpellsBanner"].disabled = false;
                                this.setShortcutDisabled("cac", false);
                                this.setShortcutDisabled("s1", false);
                                this.setShortcutDisabled("s2", false);
                                this.setShortcutDisabled("s3", false);
                                this.setShortcutDisabled("s4", false);
                                this.setShortcutDisabled("s5", false);
                                this.setShortcutDisabled("s6", false);
                                this.setShortcutDisabled("s7", false);
                                this.setShortcutDisabled("s8", false);
                                this.setShortcutDisabled("s9", false);
                                this.setShortcutDisabled("s10", false);
                                this.setShortcutDisabled("s11", false);
                                this.setShortcutDisabled("s12", false);
                                this.setShortcutDisabled("s13", false);
                                this.setShortcutDisabled("s14", false);
                                this.setShortcutDisabled("s15", false);
                                this.setShortcutDisabled("s16", false);
                                this.setShortcutDisabled("s17", false);
                                this.setShortcutDisabled("s18", false);
                                this.setShortcutDisabled("s19", false);
                                this.setShortcutDisabled("s20", false);
                                this.setShortcutDisabled("pageItem1", false);
                                this.setShortcutDisabled("pageItem2", false);
                                this.setShortcutDisabled("pageItem3", false);
                                this.setShortcutDisabled("pageItem4", false);
                                this.setShortcutDisabled("pageItem5", false);
                                this.setShortcutDisabled("pageItemDown", false);
                                this.setShortcutDisabled("pageItemUp", false);
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_TARGET:
                                if (displayArrow)
                                {
                                    Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                                    Api.highlight.highlightMonster(TutorialConstants.TUTORIAL_MONSTER_ID_POUTCH, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIGHT_SKIP_TURN:
                        if (((Api.player.isInFight()) && (displayArrow)))
                        {
                            Api.highlight.highlightUi(UIEnum.BANNER, "btn_readyOrSkip", 0, 0, 5, true);
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                        if (((subStep == TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__CLOSE_FIGHT_RESULT) && (!(Api.ui.getUi(UIEnum.FIGHT_RESULT_SIMPLE)))))
                        {
                            subStep = TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC;
                        };
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__LOADING_MAP:
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__CLOSE_FIGHT_RESULT:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.FIGHT_RESULT_SIMPLE, "btn_close", 7, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimAttaque5");
                                    Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                                    Api.highlight.highlightNpc(TutorialConstants.TUTORIAL_PNJ_ID, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_RESPONSE:
                                this.moveTutorialUiLeft();
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_CHARACTER_SHEET:
                                this._bannerMenuUiClass.setDisabledBtn(_watchedComponents["GrimoireButton"], false);
                                this._bannerMenuUiClass.setDisabledBtn(_watchedComponents["QuestButton"], false);
                                this.setShortcutDisabled("openBook", false);
                                this.setShortcutDisabled("openBookSpell", false);
                                this.setShortcutDisabled("openBookQuest", false);
                                btnPosition = this._bannerMenuUiClass.getBtnById(this._bannerMenuUiClass.ID_BTN_BAG).position;
                                if (displayArrow)
                                {
                                    Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimStatique");
                                    Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                                    if (((btnPosition > this._bannerMenuUiClass.totalNumberOfVisibleButtons) && (!(this._bannerMenuUiClass.ctr_moreBtn.visible))))
                                    {
                                        this._bannerMenuUiClass.toggleAllButtonsVisibility();
                                        Api.highlight.highlightUi(UIEnum.BANNER_MENU, ("gd_additionalBtns|id|" + this._bannerMenuUiClass.ID_BTN_BAG), 3, 0, 5, true);
                                    }
                                    else
                                    {
                                        Api.highlight.highlightUi(UIEnum.BANNER_MENU, ("gd_btnUis|id|" + this._bannerMenuUiClass.ID_BTN_BAG), 0, 0, 5, true);
                                    };
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_TAB:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "btnEquipable", 0, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "grid", 0, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT_TARGET:
                                this.moveTutorialUiLeft();
                                if (((displayArrow) && (_dropItem)))
                                {
                                    superTypeId = this.getItemSuperType(_dropItem);
                                    positions = Api.storage.itemSuperTypeToServerPosition(superTypeId);
                                    if (positions[0] != null)
                                    {
                                        Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                                        Api.highlight.highlightUi(UIEnum.STORAGE_UI, ("slot_" + positions[0]), 5, 0, 5, true);
                                    };
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__CLOSE_CHARACTER_SHEET:
                                this.moveTutorialUiLeft();
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.STORAGE_UI, "btn_close", 7, 0, 5, true);
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                        wp = Api.player.currentMap();
                        if (((subStep == TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION) && (wp.mapId == TutorialConstants.TUTORIAL_MAP_ID_THIRD_BEFORE_FIGHT)))
                        {
                            subStep = TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_BOSS;
                        };
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION:
                                if (wp.mapId == TutorialConstants.TUTORIAL_MAP_ID_SECOND_AFTER_FIGHT)
                                {
                                    if (displayArrow)
                                    {
                                        Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimAttaque8");
                                        Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_LONG);
                                        Api.highlight.highlightMapTransition(TutorialConstants.TUTORIAL_MAP_ID_SECOND_AFTER_FIGHT, TutorialConstants.FIND_BOSS_TRANSITION_ORIENTATION, TutorialConstants.FIND_BOSS_TRANSITION_POSITION, false, 0, true);
                                    };
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__LOADING_MAP:
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_BOSS:
                                if (wp.mapId == TutorialConstants.TUTORIAL_MAP_ID_THIRD_BEFORE_FIGHT)
                                {
                                    if (displayArrow)
                                    {
                                        Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimAttaque7");
                                        Api.highlight.highlightMonster(TutorialConstants.TUTORIAL_MONSTER_ID_BOSS, true);
                                    };
                                };
                                break;
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_KILL_BOSS:
                        if (displayArrow)
                        {
                            Api.highlight.forceArrowPosition("banner", "tx_timeFrame", new Point(640, 880));
                        };
                        break;
                    case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                        switch (subStep)
                        {
                            case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__LOADING_MAP:
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__CLOSE_FIGHT_RESULT:
                                if (displayArrow)
                                {
                                    Api.highlight.highlightUi(UIEnum.FIGHT_RESULT_SIMPLE, "btn_close", 7, 0, 5, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_NPC:
                                if (displayArrow)
                                {
                                    Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimAttaque5");
                                    Api.highlight.highlightNpc(TutorialConstants.TUTORIAL_PNJ_ID, true);
                                };
                                break;
                            case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_RESPONSE:
                                if (displayArrow)
                                {
                                    Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID, "AnimAttaque7");
                                };
                                break;
                        };
                        break;
                };
            };
            Api.system.dispatchHook(TutorialStep, this._currentStepNumber);
        }

        public function redoSteps():void
        {
            var max:uint;
            Api.modMenu.setBehavior("tutorial");
            if (this._currentStepNumber != -1)
            {
                max = this._currentStepNumber;
                this._currentStepNumber = 0;
                this.jumpToStep(max);
            };
        }

        public function jumpToStep(stepNumber:uint):void
        {
            if (this._currentStepNumber == -1)
            {
                this._currentStepNumber = 0;
            };
            var i:uint = this._currentStepNumber;
            while (i <= stepNumber)
            {
                this.prepareStep(i, 0, (i == stepNumber));
                i++;
            };
        }

        private function moveTutorialUiDefault():void
        {
            var tutorialUi:Object = Api.ui.getUi(UIEnum.TUTORIAL_UI);
            if (tutorialUi)
            {
                tutorialUi.uiClass.moveDefault();
            };
        }

        private function moveTutorialUiLeft():void
        {
            var tutorialUi:Object = Api.ui.getUi(UIEnum.TUTORIAL_UI);
            if (tutorialUi)
            {
                tutorialUi.uiClass.moveLeft();
            };
        }

        private function validateCurrentStep():void
        {
            var obj:uint;
            if (this._currentStepNumber != -1)
            {
                for each (obj in this._quest.steps[(this._currentStepNumber - 1)].objectiveIds)
                {
                    Api.system.sendAction(new QuestObjectiveValidation(this._quest.id, obj));
                };
            };
        }

        private function refreshStep(subStep:uint):void
        {
            if (this._currentStepNumber != -1)
            {
                this.prepareStep(this._currentStepNumber, subStep, true);
            };
        }

        private function setComponentsDisabled(components:Object, disabled:Boolean):void
        {
            var component:Object;
            for each (component in components)
            {
                if (((component) && (component.hasOwnProperty("disabled"))))
                {
                    component.disabled = disabled;
                };
            };
            if (components === _watchedComponents)
            {
                this._bannerMenuUiClass.setDisabledBtns(disabled);
            };
        }

        private function checkComponents(components:Object):void
        {
            var component:Object;
            for (component in components)
            {
                if (components[component] == null)
                {
                    throw (new Error(("Unable to find component : " + component)));
                };
            };
        }

        private function setWatchedElementsDisabled(disabled:Boolean):void
        {
            Api.modMenu.getMenuMaker("world").maker.disabled = disabled;
            Api.modMenu.getMenuMaker("player").maker.disabled = disabled;
            Api.modMenu.getMenuMaker("npc").maker.disabled = disabled;
            this.setComponentsDisabled(_watchedComponents, disabled);
            this.setShortcutsDisabled(disabled);
        }

        private function setFightWatchedElementsDisabled(disabled:Boolean):void
        {
            this.setComponentsDisabled(_fightWatchedComponents, disabled);
        }

        private function setShortcutsDisabled(disabled:Boolean):void
        {
            var s:String;
            for (s in _disabledShortcuts)
            {
                this.setShortcutDisabled(s, disabled);
            };
        }

        private function setShortcutDisabled(s:String, disabled:Boolean):void
        {
            var bind:Bind = Api.binds.getShortcutBind(s, true);
            if (bind)
            {
                Api.binds.setBindDisabled(bind, disabled);
                _disabledShortcuts[s] = disabled;
            };
        }

        private function getItemSuperType(item:Object):uint
        {
            var cat:int;
            var _local_3:ItemType;
            if (((item.isLivingObject) || (item.isWrapperObject)))
            {
                cat = 0;
                if (item.isLivingObject)
                {
                    cat = item.livingObjectCategory;
                }
                else
                {
                    cat = item.wrapperObjectCategory;
                };
                _local_3 = Api.data.getItemType(cat);
                if (_local_3)
                {
                    return (_local_3.superTypeId);
                };
                return (0);
            };
            if ((item is ItemWrapper))
            {
                return ((item as ItemWrapper).type.superTypeId);
            };
            if ((item is ShortcutWrapper))
            {
                if ((item as ShortcutWrapper).type == 0)
                {
                    return (((item as ShortcutWrapper).realItem as ItemWrapper).type.superTypeId);
                };
            };
            return (0);
        }


    }
} Ankama_Tutorial.managers

