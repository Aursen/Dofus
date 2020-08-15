package Ankama_Grimoire.ui.temporis
{
    import mapTools.Point;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.InventoryApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.FightApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.StorageApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import d2hooks.DropEnd;
    import d2hooks.DropStart;
    import d2hooks.SpellMovementAllowed;
    import d2hooks.KeyDown;
    import d2hooks.KeyUp;
    import d2hooks.ShortcutBarViewContent;
    import d2hooks.ForgettableSpellListUpdate;
    import d2hooks.ForgettableSpellDelete;
    import d2hooks.ForgettableSpellEquipmentSlots;
    import d2hooks.UiLoaded;
    import d2hooks.PresetsUpdate;
    import d2hooks.PresetError;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
    import d2actions.OpenInventory;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.berilia.types.graphic.GraphicElement;
    import d2actions.CloseInventory;
    import com.ankamagames.berilia.enums.StatesEnum;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.presets.SpellForPreset;
    import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import d2actions.ShortcutBarRemoveRequest;
    import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
    import d2actions.ForgettableSpellClientAction;
    import com.ankamagames.dofus.network.enums.ForgettableSpellClientActionEnum;
    import d2actions.ChatTextOutput;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import d2actions.GameFightSpellCast;
    import com.ankamagames.dofus.network.types.game.data.items.ForgettableSpellItem;
    import com.ankamagames.dofus.datacenter.temporis.ForgettableSpell;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import Ankama_Grimoire.Grimoire;
    import com.ankamagames.dofus.datacenter.temporis.CustomModeBreedSpell;
    import com.ankamagames.berilia.types.LocationEnum;
    import d2hooks.TextInformation;
    import d2actions.ShortcutBarAddRequest;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.berilia.components.Slot;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import Ankama_Grimoire.ui.EncyclopediaList;
    import d2hooks.OpenRecipe;
    import d2hooks.OpenEncyclopedia;
    import Ankama_Grimoire.enum.EnumTab;
    import d2hooks.SearchTemporisSpellScroll;
    import d2actions.ShortcutBarSwapRequest;
    import flash.ui.Keyboard;
    import flash.events.Event;
    import __AS3__.vec.*;

    public class TemporisSpellsUi 
    {

        public static const MAX_ACTIVE_SPELLS_PAGES:uint = 5;
        public static const ACTIVE_SPELLS_BY_PAGE_NUMBER:uint = 20;
        public static const TOOLTIP_UI_NAME:String = "TemporisSpellsUITooltip";
        public static const SPELL_TOOLTIP_UI_NAME:String = "spellBanner";
        private static const OBTAINING_ICONS_MAP:Object = {
            "spellIsDroppable":"icon_monster",
            "spellIsCraftable":"icon_hammer",
            "spellIsInQuest":"icon_exclamation",
            "spellIsUnknown":"icon_interrogation"
        };
        private static const BTN_HELP_OFFSET:int = -30;
        private static const STORAGE_STATE_MOD:String = "temporisSpellsUi";
        private static const STORAGE_MIN_SPELL_LEVEL_FILTER:String = "temporisSpellsUiMinSpellLevelFilter";
        private static const STORAGE_MAX_SPELL_LEVEL_FILTER:String = "temporisSpellsUiMaxSpellLevelFilter";
        private static const STORAGE_LEARNED_SPELLS_LEVEL_FILTER:String = "temporisSpellsUiLearnedSpellsLevelFilter";
        private static const STORAGE_IS_SPELL_NAME_SORT_ASCENDING_TYPE:String = "temporisSpellsUiIsSpellNameSortAscendingType";
        private static const STORAGE_IS_SPELL_LEVEL_SORT_ASCENDING_TYPE:String = "temporisSpellsUiIsSpellLevelSortAscendingType";
        private static const STORAGE_SPELL_SORT:String = "temporisSpellsUiSpellSort";
        private static const STORAGE_IS_FIRST_TIME:String = "temporisSpellsUiIsFirstTime";
        private static const STORAGE_HAS_COMMON_SPELLS_TAB_BEEN_OPENED_ONCE:String = "temporisSpellsUiHasCommonSpellsTabBeenOpenedOnce";
        private static const TEMPORIS_SPELLS_TAB_NAME:String = "btn_temporisSpells";
        private static const COMMON_SPELLS_TAB_NAME:String = "btn_commonSpells";
        private static const FATAL_BLOWS_TAB_NAME:String = "btn_fatalBlows";
        private static const FATAL_BLOWS_UI_NAME:String = "TemporisSpellsUIFatalBlows";
        private static const OBTAINING_ICONS_NUMBER:uint = 4;
        private static const STORAGE_CONSUMABLES_VIEW:String = "storageConsumables";
        private static const DISABLED_SHARE_TEMPORIS_SPELLS_CONTAINER_ALPHA:Number = 0.2;
        private static const MAX_OBTAINING_LEVELS:int = 6;
        private static const SCROLL_MAGIC_WORKSHOP_POSITION:Point = new Point(-4, -24);
        private static const DEFAULT_MIN_SPELL_LEVEL_FILTER:uint = 0;
        private static const DEFAULT_MAX_SPELL_LEVEL_FILTER:uint = 200;
        private static const DEFAULT_SPELL_NAME_SORT_TYPE:Boolean = true;
        private static const DEFAULT_SPELL_LEVEL_SORT_TYPE:Boolean = true;
        private static const SPELL_NAME_SORT_TYPE:String = "sortSpellsByName";
        private static const SPELL_LEVEL_SORT_TYPE:String = "sortSpellsByLevel";
        private static const DEFAULT_SPELL_SORT:String = SPELL_LEVEL_SORT_TYPE;//"sortSpellsByLevel"
        private static const LEARNED_SPELLS_FILTER_ALL:uint = 0;
        private static const LEARNED_SPELLS_FILTER_LEARNED:uint = 1;
        private static const LEARNED_SPELLS_FILTER_UNLEARNED:uint = 2;
        private static const DEFAULT_LEARNED_SPELLS_FILTER:uint = LEARNED_SPELLS_FILTER_ALL;//0
        private static const SPELL_FAMILY_TEMPORIS:String = "temporisSpell";
        private static const SPELL_FAMILY_COMMON:String = "commonSpell";
        private static const PASSIVE_SPELL_PRIORITY:int = 0;
        private static const ACTIVE_SPELL_PRIORITY:int = 1;
        private static const WEAPON_SPELL_PRIORITY:int = 2;
        private static const SPECIAL_SPELL_PRIORITY:int = 3;
        private static const FROM_ACTIVE_SPELLS:uint = 0;
        private static const FROM_TEMPORIS_SPELLS:uint = 1;
        private static const FROM_COMMON_SPELLS:uint = 2;
        private static const UNKNOWN_OBTAINING:uint = 1000;
        private static const OBTAINING_SPELL_IS_DROPPABLE:String = "spellIsDroppable";
        private static const OBTAINING_SPELL_IS_CRAFTABLE:String = "spellIsCraftable";
        private static const OBTAINING_SPELL_IS_IN_QUEST:String = "spellIsInQuest";
        private static const OBTAINING_SPELL_IS_UNKNOWN:String = "spellIsUnknown";

        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="InventoryApi")]
        public var inventoryApi:InventoryApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="FightApi")]
        public var fightApi:FightApi;
        [Api(name="PlayedCharacterApi")]
        public var playedCharacterApi:PlayedCharacterApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="StorageApi")]
        public var storageApi:StorageApi;
        [Api(name="SystemApi")]
        public var systemApi:SystemApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Module(name="Ankama_Cartography")]
        public var ankamaCartography:Object;
        [Module(name="Ankama_ContextMenu")]
        public var ankamaContextMenu:Object;
        private var _currentTabName:String = null;
        private var _currentActiveSpellsIndex:Number = 0;
        private var _fatalBlowsUi:UiRootContainer = null;
        private var _cartographyPopup:String;
        private var _isFirstTime:Boolean = true;
        private var _hasCommonSpellsTabBeenOpenedOnce:Boolean = false;
        private var _playerLevel:int;
        private var _activeSpellIds:Array = [];
        private var _activeSpells:Array = null;
        private var _temporisSpells:Array;
        private var _filteredTemporisSpells:Array = null;
        private var _equippedTemporisSpells:Array = null;
        private var _commonSpells:Array;
        private var _filteredCommonSpells:Array = null;
        private var _commonSpellPriorities:Object = null;
        private var _obtainingFiltersDescr:Object = {};
        private var _currentSearchText:String = "";
        private var _currentSpellLevelFilterMinLevel:uint = 0;
        private var _currentSpellLevelFilterMaxLevel:uint = 200;
        private var _isSpellLevelFilterReady:Boolean = true;
        private var _searchSpellText:String = null;
        private var _isSearchInputFilled:Boolean = false;
        private var _isSearchInputReady:Boolean = false;
        private var _isSearchPlaceholderReset:Boolean = false;
        private var _isSpellNameSortAscendingType:Boolean = true;
        private var _isSpellLevelSortAscendingType:Boolean = true;
        private var _currentLearnedSpellsFilter:uint = 0;
        private var _currentSort:String = "sortSpellsByLevel";
        private var _areActiveSpellsAlterable:Boolean = true;
        private var _isAltDown:Boolean = false;
        private var _hasProcessedDrop:Boolean = false;
        private var _componentsDictionary:Dictionary = new Dictionary(true);
        private var _weaponSpellType:String = null;
        private var _specialSpellType:String = null;
        private var _passiveSpellType:String = null;
        private var _activeSpellType:String = null;
        private var _learnedTemporisSpellsNumber:uint = 0;
        private var _temporisSpellsNumber:uint = 0;
        public var btn_help:ButtonContainer;
        public var btn_temporisSpells:ButtonContainer;
        public var btn_commonSpells:ButtonContainer;
        public var btn_shareTemporisSpells:ButtonContainer;
        public var btn_fatalBlows:ButtonContainer;
        public var btn_previousActiveSpells:ButtonContainer;
        public var btn_nextActiveSpells:ButtonContainer;
        public var btn_clearSearchText:ButtonContainer;
        public var btn_spellIsDroppable:ButtonContainer;
        public var btn_spellIsCraftable:ButtonContainer;
        public var btn_spellIsUnknown:ButtonContainer;
        public var btn_sortTemporisSpellsByName:ButtonContainer;
        public var btn_sortCommonSpellsByName:ButtonContainer;
        public var btn_sortTemporisSpellsByLevel:ButtonContainer;
        public var btn_saveAsASpellSet:ButtonContainer;
        public var btn_seeMySpellSets:ButtonContainer;
        public var cbx_learningSpellsFilter:ComboBox;
        public var mainCtr:GraphicContainer;
        public var ctr_activeSpellsButtons:GraphicContainer;
        public var ctr_temporisSpells:GraphicContainer;
        public var ctr_commonSpells:GraphicContainer;
        public var ctr_fatalBlows:GraphicContainer;
        public var ctr_obtainingFilters:GraphicContainer;
        public var ctr_topFilters:GraphicContainer;
        public var ctr_shareTemporisSpells:GraphicContainer;
        public var inp_spellLevelSearch:Input;
        public var inp_minSpellLevel:Input;
        public var inp_maxSpellLevel:Input;
        public var gd_activeSpells:Grid;
        public var gd_temporisSpells:Grid;
        public var gd_commonSpells:Grid;
        public var lbl_currentActiveSpellsIndex:Label;
        public var lbl_temporisSpellsNameHeader:Label;
        public var lbl_commonSpellsNameHeader:Label;
        public var lbl_temporisSpellsLevelHeader:Label;
        public var lbl_commonSpellsLevelHeader:Label;
        public var lbl_shareTemporisSpells:Label;
        public var lbl_spellLevelFilterFrom:Label;
        public var lbl_spellLevelFilterTo:Label;
        public var lbl_temporisIsSpellEquippedHeader:Label;
        public var lbl_learnedSpells:Label;
        public var tx_spellIsDroppable:Texture;
        public var tx_spellIsCraftable:Texture;
        public var tx_spellIsUnknown:Texture;
        public var tx_sortTemporisSpellsByNameAscending:Texture;
        public var tx_sortTemporisSpellsByNameDescending:Texture;
        public var tx_sortCommonSpellsByNameDescending:Texture;
        public var tx_sortCommonSpellsByNameAscending:Texture;
        public var tx_sortTemporisSpellsByLevelAscending:Texture;
        public var tx_sortTemporisSpellsByLevelDescending:Texture;
        public var tx_commonSpellsWarning:Texture;
        public var tx_shareTemporisSpells:Texture;


        private static function fitCenteredSortableLabelHeader(label:Label):void
        {
            var currentWidth:Number = label.width;
            label.fullWidth();
            label.x = (label.x + ((currentWidth - label.width) / 2));
        }


        public function set currentTabName(currentTabName:String):void
        {
            this._currentTabName = currentTabName;
            this.updateCurrentTab();
        }

        public function get currentTabName():String
        {
            return (this._currentTabName);
        }

        public function set currentActiveSpellsIndex(currentActiveSpellsIndex:Number):void
        {
            this._currentActiveSpellsIndex = (currentActiveSpellsIndex % MAX_ACTIVE_SPELLS_PAGES);
            if (this._currentActiveSpellsIndex < 0)
            {
                this._currentActiveSpellsIndex = (this._currentActiveSpellsIndex + MAX_ACTIVE_SPELLS_PAGES);
            };
            this.updateCurrentActiveSpells();
        }

        private function canTemporisSpellsBeAdded():Boolean
        {
            var maxTemporisSpellsNumber:int = this.playedCharacterApi.getPlayerMaxTemporisSpellsNumber();
            return ((maxTemporisSpellsNumber < 0) || (this._equippedTemporisSpells.length < maxTemporisSpellsNumber));
        }

        private function set currentFilteredSpells(filteredSpells:Array):void
        {
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                this._filteredTemporisSpells = filteredSpells;
            }
            else
            {
                if (this._currentTabName === COMMON_SPELLS_TAB_NAME)
                {
                    this._filteredCommonSpells = filteredSpells;
                };
            };
        }

        private function get currentFilteredSpells():Array
        {
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                if (this._filteredTemporisSpells === null)
                {
                    this._filteredTemporisSpells = this._temporisSpells.concat();
                };
                return (this._filteredTemporisSpells);
            };
            if (this._currentTabName === COMMON_SPELLS_TAB_NAME)
            {
                if (this._filteredCommonSpells === null)
                {
                    this._filteredCommonSpells = this._commonSpells.concat();
                };
                return (this._filteredCommonSpells);
            };
            return (null);
        }

        private function set currentSpells(currentSpells:Array):void
        {
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                this._temporisSpells = currentSpells;
            }
            else
            {
                if (this._currentTabName === COMMON_SPELLS_TAB_NAME)
                {
                    this._commonSpells = currentSpells;
                };
            };
        }

        private function get currentSpells():Array
        {
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                return (this._temporisSpells);
            };
            if (this._currentTabName === COMMON_SPELLS_TAB_NAME)
            {
                return (this._commonSpells);
            };
            return (null);
        }

        private function get currentSpellGrid():Grid
        {
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                return (this.gd_temporisSpells);
            };
            if (this._currentTabName === COMMON_SPELLS_TAB_NAME)
            {
                return (this.gd_commonSpells);
            };
            return (null);
        }

        private function get defaultMinSpellLevelFilter():uint
        {
            var toReturn:Number = Number(this.systemApi.getData(STORAGE_MIN_SPELL_LEVEL_FILTER));
            if ((((isNaN(toReturn)) || (toReturn < uint.MIN_VALUE)) || (toReturn > uint.MAX_VALUE)))
            {
                return (DEFAULT_MIN_SPELL_LEVEL_FILTER);
            };
            return (toReturn);
        }

        private function get defaultMaxSpellLevelFilter():uint
        {
            var toReturn:Number = Number(this.systemApi.getData(STORAGE_MAX_SPELL_LEVEL_FILTER));
            if ((((isNaN(toReturn)) || (toReturn < uint.MIN_VALUE)) || (toReturn > uint.MAX_VALUE)))
            {
                return (DEFAULT_MAX_SPELL_LEVEL_FILTER);
            };
            return (toReturn);
        }

        private function get defaultIsSpellNameSortAscendingType():Boolean
        {
            var rawValue:* = this.systemApi.getData(STORAGE_IS_SPELL_NAME_SORT_ASCENDING_TYPE);
            if (((rawValue === null) || (!(rawValue is Boolean))))
            {
                return (DEFAULT_SPELL_NAME_SORT_TYPE);
            };
            return (Boolean(rawValue));
        }

        private function get defaultIsSpellLevelSortAscendingType():Boolean
        {
            var rawValue:* = this.systemApi.getData(STORAGE_IS_SPELL_LEVEL_SORT_ASCENDING_TYPE);
            if (((rawValue === null) || (!(rawValue is Boolean))))
            {
                return (DEFAULT_SPELL_LEVEL_SORT_TYPE);
            };
            return (Boolean(rawValue));
        }

        private function get defaultSpellSort():String
        {
            var spellSort:String = this.systemApi.getData(STORAGE_SPELL_SORT);
            if (spellSort === null)
            {
                return (DEFAULT_SPELL_SORT);
            };
            return (spellSort);
        }

        private function get defaultLearnedSpellFilter():uint
        {
            var toReturn:Number = Number(this.systemApi.getData(STORAGE_LEARNED_SPELLS_LEVEL_FILTER));
            if (((isNaN(toReturn)) || (((!(toReturn === LEARNED_SPELLS_FILTER_ALL)) && (!(toReturn === LEARNED_SPELLS_FILTER_LEARNED))) && (!(toReturn === LEARNED_SPELLS_FILTER_UNLEARNED)))))
            {
                return (DEFAULT_LEARNED_SPELLS_FILTER);
            };
            return (toReturn);
        }

        public function main(paramsObject:Object=null):void
        {
            this.systemApi.addHook(DropEnd, this.onActiveSpellDropEnd);
            this.systemApi.addHook(DropStart, this.onActiveSpellDropStart);
            this.systemApi.addHook(SpellMovementAllowed, this.onAreActiveSpellsAlterable);
            this.systemApi.addHook(KeyDown, this.onKeyDown);
            this.systemApi.addHook(KeyUp, this.onKeyUp);
            this.systemApi.addHook(ShortcutBarViewContent, this.onShortcutBarViewContent);
            this.systemApi.addHook(ForgettableSpellListUpdate, this.onTemporisSpells);
            this.systemApi.addHook(ForgettableSpellDelete, this.onTemporisSpells);
            this.systemApi.addHook(ForgettableSpellEquipmentSlots, this.onTemporisSpells);
            this.systemApi.addHook(UiLoaded, this.onUiLoaded);
            this.systemApi.addHook(PresetsUpdate, this.onPresetsUpdate);
            this.systemApi.addHook(PresetError, this.onPresetError);
            this.uiApi.addComponentHook(this.mainCtr, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.gd_activeSpells, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(this.gd_activeSpells, ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(this.gd_activeSpells, ComponentHookList.ON_WHEEL);
            this.uiApi.addComponentHook(this.gd_activeSpells, ComponentHookList.ON_PRESS);
            this.uiApi.addComponentHook(this.ctr_activeSpellsButtons, ComponentHookList.ON_WHEEL);
            this.uiApi.addComponentHook(this.gd_temporisSpells, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.inp_spellLevelSearch, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.inp_spellLevelSearch, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.btn_clearSearchText, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_spellIsDroppable, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_spellIsCraftable, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_spellIsDroppable, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_spellIsDroppable, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_spellIsCraftable, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_spellIsCraftable, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_spellIsUnknown, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_spellIsUnknown, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.cbx_learningSpellsFilter, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.inp_minSpellLevel, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.inp_maxSpellLevel, ComponentHookList.ON_CHANGE);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut);
            this.uiApi.addComponentHook(this.btn_help, ComponentHookList.ON_RELEASE);
            this.btn_temporisSpells.soundId = SoundEnum.TAB;
            this.btn_commonSpells.soundId = SoundEnum.TAB;
            this.btn_fatalBlows.soundId = SoundEnum.TAB;
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
            this._playerLevel = this.playedCharacterApi.getPlayedCharacterInfo().level;
            this._weaponSpellType = this.uiApi.getText("ui.temporis.weaponSpell");
            this._specialSpellType = this.uiApi.getText("ui.temporis.specialSpell");
            this._passiveSpellType = this.uiApi.getText("ui.temporis.passiveSpell");
            this._activeSpellType = this.uiApi.getText("ui.temporis.activeSpell");
            this._commonSpellPriorities = {};
            this._commonSpellPriorities[this._weaponSpellType] = WEAPON_SPELL_PRIORITY;
            this._commonSpellPriorities[this._specialSpellType] = SPECIAL_SPELL_PRIORITY;
            this._commonSpellPriorities[this._passiveSpellType] = PASSIVE_SPELL_PRIORITY;
            this._commonSpellPriorities[this._activeSpellType] = ACTIVE_SPELL_PRIORITY;
            this.lbl_shareTemporisSpells.fullWidth();
            this.lbl_spellLevelFilterFrom.fullWidth();
            this.lbl_spellLevelFilterTo.fullWidth();
            this.fitSortableLabelHeaders();
            this._searchSpellText = this.uiApi.getText("ui.temporis.searchSpell");
            this.inp_spellLevelSearch.text = this._searchSpellText;
            this.gd_activeSpells.autoSelectMode = 0;
            (this.gd_activeSpells.renderer as SlotGridRenderer).processDropFunction = this.processActiveSpellDrop;
            (this.gd_activeSpells.renderer as SlotGridRenderer).dropValidatorFunction = this.activeSpellDropValidator;
            (this.gd_activeSpells.renderer as SlotGridRenderer).allowDrop = this._areActiveSpellsAlterable;
            this.cbx_learningSpellsFilter.dataProvider = [this.uiApi.getText("ui.temporis.displayAllSpells"), this.uiApi.getText("ui.temporis.displayLearnedSpells"), this.uiApi.getText("ui.temporis.displayUnlearnedSpells")];
            this._currentLearnedSpellsFilter = this.defaultLearnedSpellFilter;
            this.cbx_learningSpellsFilter.selectedIndex = this._currentLearnedSpellsFilter;
            (this.gd_activeSpells.renderer as SlotGridRenderer).removeDropSourceFunction = function (target:Object):void
            {
            };
            this._currentSpellLevelFilterMinLevel = this.defaultMinSpellLevelFilter;
            this._currentSpellLevelFilterMaxLevel = this.defaultMaxSpellLevelFilter;
            this._isSpellNameSortAscendingType = this.defaultIsSpellNameSortAscendingType;
            this._isSpellLevelSortAscendingType = this.defaultIsSpellLevelSortAscendingType;
            this._currentSort = this.defaultSpellSort;
            this.currentActiveSpellsIndex = 0;
            this.loadActiveSpells();
            this.resetFilters();
            this.currentTabName = TEMPORIS_SPELLS_TAB_NAME;
            this.gd_temporisSpells.mouseClickEnabled = false;
            this.gd_commonSpells.mouseClickEnabled = false;
            this.systemApi.sendAction(new OpenInventory(STORAGE_STATE_MOD, UIEnum.INVENTORY_UI));
            var isFirstTimeTmp:* = this.systemApi.getData(STORAGE_IS_FIRST_TIME);
            if (((!(isFirstTimeTmp === null)) && (isFirstTimeTmp is Boolean)))
            {
                this._isFirstTime = Boolean(isFirstTimeTmp);
            }
            else
            {
                this.systemApi.setData(STORAGE_IS_FIRST_TIME, this._isFirstTime);
            };
            if (this._isFirstTime)
            {
                this.uiApi.loadUi(UIEnum.TEMPORIS_INTRO_POP_UP, UIEnum.TEMPORIS_INTRO_POP_UP, [this.validateFirstTime]);
            };
            var hasCommonSpellsTabBeenOpenedOnceTmp:* = this.systemApi.getData(STORAGE_HAS_COMMON_SPELLS_TAB_BEEN_OPENED_ONCE);
            if (((!(hasCommonSpellsTabBeenOpenedOnceTmp === null)) && (hasCommonSpellsTabBeenOpenedOnceTmp is Boolean)))
            {
                this._hasCommonSpellsTabBeenOpenedOnce = Boolean(hasCommonSpellsTabBeenOpenedOnceTmp);
            }
            else
            {
                this.systemApi.setData(STORAGE_HAS_COMMON_SPELLS_TAB_BEEN_OPENED_ONCE, this._hasCommonSpellsTabBeenOpenedOnce);
            };
            this.tx_commonSpellsWarning.visible = (!(this._hasCommonSpellsTabBeenOpenedOnce));
            var btn_helpGraphicElement:GraphicElement = this.uiApi.me().getElementById(this.btn_help.name);
            if (((!(btn_helpGraphicElement === null)) && (!(btn_helpGraphicElement.location === null))))
            {
                btn_helpGraphicElement.location.setOffsetX(BTN_HELP_OFFSET);
            };
            if (((!(paramsObject === null)) && (paramsObject.hasOwnProperty("isSpellSetsUi"))))
            {
                this.getSpellSets();
            };
            this.setSaveSpellSetButton();
        }

        public function unload():void
        {
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
            this.uiApi.unloadUi(FATAL_BLOWS_UI_NAME);
            this.uiApi.unloadUi(UIEnum.TEMPORIS_INTRO_POP_UP);
            this.uiApi.unloadUi(this._cartographyPopup);
            this.uiApi.unloadUi(UIEnum.TEMPORIS_SPELL_SETS_UI);
            this.uiApi.unloadUi(UIEnum.TEMPORIS_SPELL_SET_POP_UP);
            this.systemApi.sendAction(new CloseInventory(UIEnum.INVENTORY_UI));
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
        }

        public function updateTemporisSpellLine(spellDescr:Object, components:*, isSelected:Boolean):void
        {
            var obtainingKey:String;
            this.uiApi.removeComponentHook(components.btn_temporisSpellLine, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_temporisSpellLine, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_temporisSpellLine, ComponentHookList.ON_DOUBLE_CLICK);
            this.uiApi.removeComponentHook(components.tx_obtaining_0, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_obtaining_0, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.tx_obtaining_1, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_obtaining_1, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.tx_obtaining_2, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_obtaining_2, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.tx_obtaining_3, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_obtaining_3, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.tx_findTemporisSpellScroll, ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.btn_getTemporisSpellScroll, ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.btn_getTemporisSpellScroll, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_getTemporisSpellScroll, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.slot_temporisSpell, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.slot_temporisSpell, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.slot_temporisSpell, ComponentHookList.ON_DOUBLE_CLICK);
            if (spellDescr === null)
            {
                components.slot_temporisSpell.visible = false;
                components.tx_isSelectedTemporisSpell.visible = false;
                components.ctr_obtaining.visible = false;
                components.lbl_temporisSpellName.visible = false;
                components.lbl_temporisSpellLevel.visible = false;
                components.tx_findTemporisSpellScroll.visible = false;
                components.btn_getTemporisSpellScroll.visible = false;
                components.slot_temporisSpell.allowDrag = false;
                components.tx_findTemporisSpellScroll.visible = false;
                components.btn_temporisSpellLine.state = StatesEnum.STATE_NORMAL;
                components.btn_temporisSpellLine.handCursor = false;
                return;
            };
            this.uiApi.addComponentHook(components.btn_temporisSpellLine, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_temporisSpellLine, ComponentHookList.ON_ROLL_OUT);
            this._componentsDictionary[components.slot_temporisSpell.name] = spellDescr.isSpellActive;
            this._componentsDictionary[components.btn_temporisSpellLine.name] = spellDescr;
            components.btn_temporisSpellLine.state = StatesEnum.STATE_NORMAL;
            components.tx_isSelectedTemporisSpell.visible = spellDescr.isSpellActive;
            components.slot_temporisSpell.visible = true;
            components.slot_temporisSpell.allowDrag = spellDescr.isKnown;
            components.slot_temporisSpell.data = spellDescr.spellWrapper;
            components.slot_temporisSpell.greyedOut = (!(spellDescr.isKnown));
            this._componentsDictionary[components.slot_temporisSpell.name] = spellDescr;
            this.uiApi.addComponentHook(components.slot_temporisSpell, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.slot_temporisSpell, ComponentHookList.ON_ROLL_OUT);
            var currentObtainingIconName:String;
            var currentObtainingTexture:Texture;
            var currentObtainingIconDescr:Object;
            var obtainingDescr:Object = spellDescr.obtainingDescr;
            var index:uint;
            components.ctr_obtaining.visible = true;
            for (obtainingKey in obtainingDescr)
            {
                if (!obtainingDescr.hasOwnProperty(obtainingKey))
                {
                }
                else
                {
                    currentObtainingIconDescr = obtainingDescr[obtainingKey];
                    currentObtainingIconName = ("tx_obtaining_" + index);
                    currentObtainingTexture = null;
                    if (((components.hasOwnProperty(currentObtainingIconName)) && (components[currentObtainingIconName] is Texture)))
                    {
                        currentObtainingTexture = (components[currentObtainingIconName] as Texture);
                    };
                    if (((currentObtainingTexture === null) || (!(currentObtainingIconDescr.hasOwnProperty("iconGreyPath")))))
                    {
                    }
                    else
                    {
                        currentObtainingTexture.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + currentObtainingIconDescr.iconGreyPath));
                        currentObtainingTexture.visible = true;
                        if (((obtainingKey === OBTAINING_SPELL_IS_DROPPABLE) || (obtainingKey === OBTAINING_SPELL_IS_CRAFTABLE)))
                        {
                            this.uiApi.addComponentHook(currentObtainingTexture, ComponentHookList.ON_RELEASE);
                            currentObtainingTexture.handCursor = true;
                        }
                        else
                        {
                            currentObtainingTexture.handCursor = false;
                        };
                        this._componentsDictionary[components[currentObtainingIconName].name] = currentObtainingIconDescr;
                        this.uiApi.addComponentHook(currentObtainingTexture, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(currentObtainingTexture, ComponentHookList.ON_ROLL_OUT);
                        index++;
                    };
                };
            };
            if (index > 0)
            {
                while (index < OBTAINING_ICONS_NUMBER)
                {
                    currentObtainingIconName = ("tx_obtaining_" + index);
                    currentObtainingTexture = null;
                    if (((components.hasOwnProperty(currentObtainingIconName)) && (components[currentObtainingIconName] is Texture)))
                    {
                        currentObtainingTexture = (components[currentObtainingIconName] as Texture);
                    };
                    if (currentObtainingTexture === null)
                    {
                    }
                    else
                    {
                        currentObtainingTexture.visible = false;
                        index++;
                    };
                };
            }
            else
            {
                components.ctr_obtaining.visible = false;
            };
            components.lbl_temporisSpellName.visible = true;
            components.lbl_temporisSpellName.text = spellDescr.spellName;
            components.lbl_temporisSpellLevel.visible = true;
            components.lbl_temporisSpellLevel.text = spellDescr.spellLevel;
            if (spellDescr.isKnown)
            {
                components.btn_getTemporisSpellScroll.visible = true;
                components.tx_findTemporisSpellScroll.visible = false;
                this.uiApi.addComponentHook(components.btn_getTemporisSpellScroll, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(components.btn_getTemporisSpellScroll, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_getTemporisSpellScroll, ComponentHookList.ON_ROLL_OUT);
                this.uiApi.addComponentHook(components.btn_getTemporisSpellScroll, ComponentHookList.ON_RELEASE);
                this._componentsDictionary[components.btn_getTemporisSpellScroll.name] = spellDescr;
                this.uiApi.addComponentHook(components.slot_temporisSpell, ComponentHookList.ON_DOUBLE_CLICK);
                this._componentsDictionary[components.slot_temporisSpell.name] = spellDescr;
                this.uiApi.addComponentHook(components.btn_temporisSpellLine, ComponentHookList.ON_DOUBLE_CLICK);
            }
            else
            {
                components.btn_getTemporisSpellScroll.visible = false;
                if (this.isSpellScrollAvailable(spellDescr.scrollId))
                {
                    components.tx_findTemporisSpellScroll.visible = true;
                    this.uiApi.addComponentHook(components.tx_findTemporisSpellScroll, ComponentHookList.ON_RELEASE);
                    this._componentsDictionary[components.tx_findTemporisSpellScroll.name] = spellDescr;
                }
                else
                {
                    components.tx_findTemporisSpellScroll.visible = false;
                };
            };
        }

        public function updateCommonSpellLine(spellDescr:Object, components:*, isSelected:Boolean):void
        {
            var currentObtainingLevelDescr:Object;
            var index:uint;
            var currentObtainingButtonIndex:uint;
            var minX:uint;
            var currentObtainingButton:ButtonContainer;
            var currentObtainingLabel:Label;
            var currentObtainingTexture:Texture;
            var maxX:uint;
            var containerWidth:int;
            var tooltipTarget:Texture;
            this.uiApi.removeComponentHook(components.btn_commonSpellLine, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_commonSpellLine, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_commonSpellLine, ComponentHookList.ON_DOUBLE_CLICK);
            this.uiApi.removeComponentHook(components.slot_commonSpell, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.slot_commonSpell, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.slot_commonSpell, ComponentHookList.ON_DOUBLE_CLICK);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_1, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_1, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_2, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_2, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_3, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_3, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_4, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_4, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_5, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_5, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_6, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_obtainingLevel_6, ComponentHookList.ON_ROLL_OUT);
            if (spellDescr === null)
            {
                components.slot_commonSpell.visible = false;
                components.tx_isSelectedCommonSpell.visible = false;
                components.lbl_commonSpellName.visible = false;
                components.slot_commonSpell.allowDrag = false;
                components.tx_commonSpellNotKnown.visible = false;
                components.lbl_commonSpellType.visible = false;
                components.btn_commonSpellLine.state = StatesEnum.STATE_NORMAL;
                components.ctr_obtainingLevels.visible = false;
                components.tx_passiveCommonSpellBackground.visible = false;
                components.btn_commonSpellLine.handCursor = false;
                return;
            };
            this.uiApi.addComponentHook(components.btn_commonSpellLine, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_commonSpellLine, ComponentHookList.ON_ROLL_OUT);
            this._componentsDictionary[components.btn_commonSpellLine.name] = spellDescr.isSpellActive;
            components.tx_commonSpellNotKnown.visible = (!(spellDescr.isKnown));
            if (spellDescr.isKnown)
            {
                this.uiApi.addComponentHook(components.btn_commonSpellLine, ComponentHookList.ON_DOUBLE_CLICK);
                this._componentsDictionary[components.btn_commonSpellLine.name] = spellDescr;
                this.uiApi.addComponentHook(components.slot_commonSpell, ComponentHookList.ON_DOUBLE_CLICK);
                this._componentsDictionary[components.slot_commonSpell.name] = spellDescr;
            };
            if (((!(spellDescr.obtainingLevels === null)) && (spellDescr.obtainingLevels.length > 0)))
            {
                currentObtainingLevelDescr = null;
                currentObtainingButtonIndex = 0;
                minX = components.tx_obtainingLevel_0.x;
                currentObtainingButton = null;
                currentObtainingLabel = null;
                currentObtainingTexture = null;
                index = 0;
                while (index < spellDescr.obtainingLevels.length)
                {
                    currentObtainingLevelDescr = spellDescr.obtainingLevels[index];
                    if (currentObtainingLevelDescr === null)
                    {
                    }
                    else
                    {
                        if (currentObtainingLevelDescr !== null)
                        {
                            currentObtainingButton = components[("btn_obtainingLevel_" + currentObtainingButtonIndex)];
                            currentObtainingLabel = components[("lbl_obtainingLevel_" + currentObtainingButtonIndex)];
                            currentObtainingTexture = components[("tx_obtainingLevel_" + currentObtainingButtonIndex)];
                            if ((((!(currentObtainingButton === null)) && (!(currentObtainingLabel === null))) && (!(currentObtainingTexture === null))))
                            {
                                this.uiApi.addComponentHook(currentObtainingButton, ComponentHookList.ON_ROLL_OVER);
                                this.uiApi.addComponentHook(currentObtainingButton, ComponentHookList.ON_ROLL_OUT);
                                this._componentsDictionary[currentObtainingButton.name] = {"data":currentObtainingLevelDescr};
                                currentObtainingButton.visible = true;
                                if (currentObtainingLevelDescr.spellLevel > 0)
                                {
                                    currentObtainingLabel.text = currentObtainingLevelDescr.spellLevel;
                                }
                                else
                                {
                                    currentObtainingLabel.text = "-";
                                };
                                if (currentObtainingLevelDescr.isKnown)
                                {
                                    currentObtainingLabel.cssClass = "orangecenterbold";
                                }
                                else
                                {
                                    currentObtainingLabel.cssClass = "center";
                                };
                                currentObtainingButtonIndex++;
                            };
                        };
                    };
                    index++;
                };
                maxX = (currentObtainingTexture.x + currentObtainingTexture.width);
                containerWidth = (maxX - minX);
                components.ctr_obtainingLevels.x = ((this.lbl_commonSpellsLevelHeader.x + (this.lbl_commonSpellsLevelHeader.width / 2)) - (containerWidth / 2));
                tooltipTarget = currentObtainingTexture;
                index = 0;
                while (index < MAX_OBTAINING_LEVELS)
                {
                    currentObtainingButton = components[("btn_obtainingLevel_" + index)];
                    if (currentObtainingButton === null)
                    {
                    }
                    else
                    {
                        if (index < currentObtainingButtonIndex)
                        {
                            this._componentsDictionary[currentObtainingButton.name].target = tooltipTarget;
                        }
                        else
                        {
                            currentObtainingButton.visible = false;
                        };
                    };
                    index++;
                };
            }
            else
            {
                components.ctr_obtainingLevels.visible = false;
            };
            var isCommonSpellPassive:* = (spellDescr.spellType === this._passiveSpellType);
            components.btn_commonSpellLine.state = StatesEnum.STATE_NORMAL;
            components.btn_commonSpellLine.handCursor = (!(isCommonSpellPassive));
            components.slot_commonSpell.handCursor = (!(isCommonSpellPassive));
            components.tx_isSelectedCommonSpell.visible = spellDescr.isSpellActive;
            components.slot_commonSpell.visible = true;
            components.slot_commonSpell.allowDrag = ((spellDescr.isKnown) && (!(isCommonSpellPassive)));
            components.slot_commonSpell.data = spellDescr.spellWrapper;
            components.slot_commonSpell.greyedOut = (!(spellDescr.isKnown));
            components.tx_passiveCommonSpellBackground.visible = isCommonSpellPassive;
            this._componentsDictionary[components.slot_commonSpell.name] = spellDescr;
            this.uiApi.addComponentHook(components.slot_commonSpell, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.slot_commonSpell, ComponentHookList.ON_ROLL_OUT);
            components.lbl_commonSpellName.visible = true;
            components.lbl_commonSpellName.text = spellDescr.spellName;
            components.lbl_commonSpellType.visible = true;
            components.lbl_commonSpellType.text = spellDescr.spellType;
        }

        private function setSaveSpellSetButton():void
        {
            this.btn_saveAsASpellSet.disabled = (this.inventoryApi.getBuildNumber(2) >= ProtocolConstantsEnum.MAX_PRESET_COUNT);
        }

        private function getSpellSetsWithSpell(spellId:int):Array
        {
            var item:Object;
            var index:uint;
            var builds:Array = this.inventoryApi.getBuilds(2);
            var currentBuildWrapper:BuildWrapper;
            var currentSpellsForPreset:Vector.<SpellForPreset>;
            var spellSets:Array = [];
            for each (item in builds)
            {
                if ((item is BuildWrapper))
                {
                    currentBuildWrapper = (item as BuildWrapper);
                    currentSpellsForPreset = currentBuildWrapper.forgettableSpellsPreset.forgettableSpells;
                    if (currentSpellsForPreset === null)
                    {
                    }
                    else
                    {
                        index = 0;
                        while (index < currentSpellsForPreset.length)
                        {
                            if (currentSpellsForPreset[index].spellId === spellId)
                            {
                                spellSets.push({
                                    "label":currentBuildWrapper.buildName,
                                    "icon":currentBuildWrapper.iconUri,
                                    "id":currentBuildWrapper.id
                                });
                                break;
                            };
                            index++;
                        };
                    };
                };
            };
            return (spellSets);
        }

        private function removeSpellFromActiveSpells(index:int):void
        {
            if (((index < 0) || (index > this._activeSpells.length)))
            {
                return;
            };
            var item:Object = this._activeSpells[index];
            var shortcutWrapper:ShortcutWrapper;
            var spellWrapper:SpellWrapper;
            if ((item is ShortcutWrapper))
            {
                shortcutWrapper = (item as ShortcutWrapper);
                if ((shortcutWrapper.realItem is SpellWrapper))
                {
                    spellWrapper = (shortcutWrapper.realItem as SpellWrapper);
                };
            }
            else
            {
                if ((item is SpellWrapper))
                {
                    spellWrapper = (item as SpellWrapper);
                };
            };
            if (spellWrapper === null)
            {
                return;
            };
            var spellId:int = spellWrapper.id;
            var currentIndex:int;
            var currentIndexStr:String;
            var currentSpell:Object;
            var areDuplicates:Boolean;
            var isTemporisSpell:Boolean = this.playedCharacterApi.isForgettableSpell(spellId);
            if (isTemporisSpell)
            {
                for (currentIndexStr in this._activeSpells)
                {
                    currentSpell = this._activeSpells[currentIndexStr];
                    currentIndex = Number(currentIndexStr);
                    if ((((!(currentSpell === null)) && (!(currentIndex === index))) && (currentSpell.id === spellId)))
                    {
                        areDuplicates = true;
                        break;
                    };
                };
            };
            if (((!(isTemporisSpell)) || (areDuplicates)))
            {
                this.systemApi.sendAction(new ShortcutBarRemoveRequest(ShortcutBarEnum.SPELL_SHORTCUT_BAR, index));
            }
            else
            {
                this.unequipTemporisSpell(spellId);
            };
        }

        private function validateFirstTime():void
        {
            this._isFirstTime = false;
            this.systemApi.setData(STORAGE_IS_FIRST_TIME, this._isFirstTime);
        }

        private function isSpellActive(spellId:uint):Boolean
        {
            return (!(this._activeSpellIds.indexOf(spellId) === -1));
        }

        private function saveActiveSpell(spellId:uint):void
        {
            if (!this.isSpellActive(spellId))
            {
                this._activeSpellIds.push(spellId);
            };
        }

        private function removeActiveSpell(spellId:uint):void
        {
            var index:uint;
            while (index < this._activeSpellIds.length)
            {
                if (spellId === this._activeSpellIds[index])
                {
                    this._activeSpellIds.removeAt(index);
                    break;
                };
                index++;
            };
        }

        private function isTemporisSpellEquipped(spellId:uint):Boolean
        {
            return (!(this._equippedTemporisSpells.indexOf(spellId) === -1));
        }

        private function equipTemporisSpell(spellId:uint, isSendAction:Boolean=true):void
        {
            if (!this.isTemporisSpellEquipped(spellId))
            {
                if (isSendAction)
                {
                    this.systemApi.sendAction(new ForgettableSpellClientAction(spellId, ForgettableSpellClientActionEnum.FORGETTABLE_SPELL_EQUIP));
                }
                else
                {
                    this._equippedTemporisSpells.push(spellId);
                };
            };
        }

        private function unequipTemporisSpell(spellId:uint):void
        {
            var index:uint;
            while (index < this._equippedTemporisSpells.length)
            {
                if (spellId === this._equippedTemporisSpells[index])
                {
                    this.systemApi.sendAction(new ForgettableSpellClientAction(spellId, ForgettableSpellClientActionEnum.FORGETTABLE_SPELL_UNEQUIP));
                    return;
                };
                index++;
            };
        }

        private function shareCurrentTemporisSpells():void
        {
            var sortedActiveTemporisSpells:Array = this._equippedTemporisSpells.sort(Array.NUMERIC);
            this.systemApi.goToUrl((this.uiApi.getText("ui.link.shareTemporisSpells") + sortedActiveTemporisSpells.toString()));
        }

        private function handleSearchInput():void
        {
            if (((!(this._isSearchInputReady)) || (this._isSearchPlaceholderReset)))
            {
                this._isSearchPlaceholderReset = false;
                return;
            };
            var searchText:String = this.inp_spellLevelSearch.lastTextOnInput;
            if (this._isSearchInputFilled)
            {
                this.updateSearchFilter(searchText);
            }
            else
            {
                if (searchText)
                {
                    this._isSearchInputFilled = true;
                    this.updateSearchFilter(searchText);
                };
            };
        }

        private function fitSortableLabelHeaders():void
        {
            this.lbl_temporisSpellsNameHeader.fullWidth();
            this.lbl_commonSpellsNameHeader.fullWidth();
            fitCenteredSortableLabelHeader(this.lbl_temporisSpellsLevelHeader);
            fitCenteredSortableLabelHeader(this.lbl_commonSpellsLevelHeader);
        }

        private function resetFilters():void
        {
            this._filteredTemporisSpells = (this._filteredCommonSpells = null);
            this.resetSearchBar(false);
            this._currentSpellLevelFilterMinLevel = this.defaultMinSpellLevelFilter;
            this._currentSpellLevelFilterMaxLevel = this.defaultMaxSpellLevelFilter;
            this.updateSpellLevelInputs();
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                this.resetObtainingFilters();
            };
        }

        private function sortBySpellName(firstSpell:Object, secondSpell:Object):Number
        {
            var firstSpellPriority:int;
            var secondSpellPriority:int;
            if (((firstSpell.spellFamily === SPELL_FAMILY_TEMPORIS) && (!(firstSpell.isKnown === secondSpell.isKnown))))
            {
                if (firstSpell.isKnown)
                {
                    return (-1);
                };
                return (1);
            };
            if ((((((firstSpell.spellFamily === SPELL_FAMILY_COMMON) && (!(this._commonSpellPriorities === null))) && (!(firstSpell.spellType === secondSpell.spellType))) && (firstSpell.spellType in this._commonSpellPriorities)) && (secondSpell.spellType in this._commonSpellPriorities)))
            {
                firstSpellPriority = this._commonSpellPriorities[firstSpell.spellType];
                secondSpellPriority = this._commonSpellPriorities[secondSpell.spellType];
                if (firstSpellPriority < secondSpellPriority)
                {
                    return (-1);
                };
                return (1);
            };
            if (firstSpell.spellName > secondSpell.spellName)
            {
                return ((this._isSpellNameSortAscendingType) ? 1 : -1);
            };
            if (firstSpell.spellName < secondSpell.spellName)
            {
                return ((this._isSpellNameSortAscendingType) ? -1 : 1);
            };
            return (0);
        }

        private function sortBySpellLevel(firstSpell:Object, secondSpell:Object):Number
        {
            var firstSpellPriority:int;
            var secondSpellPriority:int;
            var firstLevel:uint = firstSpell.spellLevel;
            var secondLevel:uint = secondSpell.spellLevel;
            if (((firstSpell.spellFamily === SPELL_FAMILY_TEMPORIS) && (!(firstSpell.isKnown === secondSpell.isKnown))))
            {
                if (firstSpell.isKnown)
                {
                    return (-1);
                };
                return (1);
            };
            if ((((((firstSpell.spellFamily === SPELL_FAMILY_COMMON) && (!(this._commonSpellPriorities === null))) && (!(firstSpell.spellType === secondSpell.spellType))) && (firstSpell.spellType in this._commonSpellPriorities)) && (secondSpell.spellType in this._commonSpellPriorities)))
            {
                firstSpellPriority = this._commonSpellPriorities[firstSpell.spellType];
                secondSpellPriority = this._commonSpellPriorities[secondSpell.spellType];
                if (firstSpellPriority < secondSpellPriority)
                {
                    return (-1);
                };
                return (1);
            };
            if (firstLevel > secondLevel)
            {
                return ((this._isSpellLevelSortAscendingType) ? 1 : -1);
            };
            if (firstLevel < secondLevel)
            {
                return ((this._isSpellLevelSortAscendingType) ? -1 : 1);
            };
            if (firstSpell.spellName > secondSpell.spellName)
            {
                return (1);
            };
            if (firstSpell.spellName < secondSpell.spellName)
            {
                return (-1);
            };
            return (0);
        }

        private function resetObtainingFilters():void
        {
            this._obtainingFiltersDescr = {
                "spellIsDroppable":true,
                "spellIsCraftable":true,
                "spellIsInQuest":true,
                "spellIsUnknown":true
            };
            this.tx_spellIsDroppable.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("texture") + OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_DROPPABLE]) + "_over.png"));
            this.tx_spellIsCraftable.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("texture") + OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_CRAFTABLE]) + "_over.png"));
            this.tx_spellIsUnknown.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("texture") + OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_UNKNOWN]) + "_over.png"));
        }

        private function resetSortButtons():void
        {
            this.tx_sortTemporisSpellsByNameDescending.visible = false;
            this.tx_sortTemporisSpellsByNameAscending.visible = false;
            this.tx_sortCommonSpellsByNameDescending.visible = false;
            this.tx_sortCommonSpellsByNameAscending.visible = false;
            this.tx_sortTemporisSpellsByLevelDescending.visible = false;
            this.tx_sortTemporisSpellsByLevelAscending.visible = false;
        }

        private function applySpellNameSort():void
        {
            this.resetSortButtons();
            var spellsToProvide:Array;
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                if (this._isSpellNameSortAscendingType)
                {
                    this.tx_sortTemporisSpellsByNameAscending.visible = true;
                }
                else
                {
                    this.tx_sortTemporisSpellsByNameDescending.visible = true;
                };
                if (this._filteredTemporisSpells !== null)
                {
                    this._filteredTemporisSpells.sort(this.sortBySpellName);
                    spellsToProvide = this._filteredTemporisSpells;
                }
                else
                {
                    spellsToProvide = this._temporisSpells;
                };
            }
            else
            {
                if (this._isSpellNameSortAscendingType)
                {
                    this.tx_sortCommonSpellsByNameAscending.visible = true;
                }
                else
                {
                    this.tx_sortCommonSpellsByNameDescending.visible = true;
                };
                if (this._filteredCommonSpells !== null)
                {
                    this._filteredCommonSpells.sort(this.sortBySpellName);
                    spellsToProvide = this._filteredCommonSpells;
                }
                else
                {
                    spellsToProvide = this._commonSpells;
                };
            };
            this.currentSpells.sort(this.sortBySpellName);
            this.currentSpellGrid.dataProvider = spellsToProvide;
        }

        private function applySpellLevelSort():void
        {
            if (this._currentTabName !== TEMPORIS_SPELLS_TAB_NAME)
            {
                return;
            };
            this.resetSortButtons();
            var spellsToProvide:Array;
            if (this._isSpellLevelSortAscendingType)
            {
                this.tx_sortTemporisSpellsByLevelAscending.visible = true;
            }
            else
            {
                this.tx_sortTemporisSpellsByLevelDescending.visible = true;
            };
            if (this._filteredTemporisSpells !== null)
            {
                this._filteredTemporisSpells.sort(this.sortBySpellLevel);
                spellsToProvide = this._filteredTemporisSpells;
            }
            else
            {
                spellsToProvide = this._temporisSpells;
            };
            this.currentSpells.sort(this.sortBySpellLevel);
            this.currentSpellGrid.dataProvider = spellsToProvide;
        }

        private function applySort():void
        {
            if (((this._currentTabName === COMMON_SPELLS_TAB_NAME) || (this._currentSort === SPELL_NAME_SORT_TYPE)))
            {
                this.applySpellNameSort();
            }
            else
            {
                if (this._currentSort === SPELL_LEVEL_SORT_TYPE)
                {
                    this.applySpellLevelSort();
                };
            };
        }

        private function applyFilterPipeline():void
        {
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                this._filteredTemporisSpells = this._temporisSpells.concat();
            }
            else
            {
                if (this._currentTabName === COMMON_SPELLS_TAB_NAME)
                {
                    this._filteredCommonSpells = this._commonSpells.concat();
                }
                else
                {
                    return;
                };
            };
            this.applySearchFilter(false);
            this.applyLearnedSpellsFilter();
            this.applySpellLevelFilter();
            this.applyObtainingFilter();
            this.currentSpellGrid.dataProvider = this.currentFilteredSpells;
        }

        private function applyLearnedSpellsFilter(isUpdateDataProvider:Boolean=false):void
        {
            if ((((!(this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)) && (!(this._currentTabName === COMMON_SPELLS_TAB_NAME))) || (this._currentLearnedSpellsFilter === LEARNED_SPELLS_FILTER_ALL)))
            {
                return;
            };
            var filterCondition:* = (this._currentLearnedSpellsFilter === LEARNED_SPELLS_FILTER_LEARNED);
            var filteredSpells:Array = this.currentFilteredSpells;
            if (filteredSpells === null)
            {
                return;
            };
            var index:uint;
            while (index < filteredSpells.length)
            {
                if (filteredSpells[index].isKnown !== filterCondition)
                {
                    filteredSpells.removeAt(index);
                }
                else
                {
                    index++;
                };
            };
            this.currentFilteredSpells = filteredSpells;
            if (isUpdateDataProvider)
            {
                this.currentSpellGrid.dataProvider = this.currentFilteredSpells;
            };
        }

        private function applySpellLevelFilter(isUpdateDataProvider:Boolean=false):void
        {
            var currentSpellLevel:uint;
            var filteredSpells:Object = this.currentFilteredSpells;
            if (filteredSpells === null)
            {
                return;
            };
            var index:uint;
            while (index < filteredSpells.length)
            {
                currentSpellLevel = filteredSpells[index].spellLevel;
                if (((currentSpellLevel < this._currentSpellLevelFilterMinLevel) || (currentSpellLevel > this._currentSpellLevelFilterMaxLevel)))
                {
                    filteredSpells.removeAt(index);
                }
                else
                {
                    index++;
                };
            };
            if (isUpdateDataProvider)
            {
                this.currentSpellGrid.dataProvider = filteredSpells;
            };
        }

        private function applyObtainingFilter(isUpdateDataProvider:Boolean=false):void
        {
            var index:uint;
            var obtainingKey:String;
            if (this._currentTabName !== TEMPORIS_SPELLS_TAB_NAME)
            {
                return;
            };
            var filteredSpells:Object = this.currentFilteredSpells;
            if (filteredSpells === null)
            {
                return;
            };
            for (obtainingKey in this._obtainingFiltersDescr)
            {
                if (((!(this._obtainingFiltersDescr.hasOwnProperty(obtainingKey))) || (this._obtainingFiltersDescr[obtainingKey])))
                {
                }
                else
                {
                    index = 0;
                    while (index < filteredSpells.length)
                    {
                        if (filteredSpells[index].obtainingDescr.hasOwnProperty(obtainingKey))
                        {
                            filteredSpells.removeAt(index);
                        }
                        else
                        {
                            index++;
                        };
                    };
                };
            };
            if (isUpdateDataProvider)
            {
                this.currentSpellGrid.dataProvider = filteredSpells;
            };
        }

        private function applySearchFilter(isUpdateDataProvider:Boolean=false):void
        {
            var filteredSpells:Array = this.currentFilteredSpells;
            if (((filteredSpells === null) || (!(this._currentSearchText))))
            {
                return;
            };
            if (filteredSpells === null)
            {
                filteredSpells = this._temporisSpells.concat();
            };
            filteredSpells = this.utilApi.filter(filteredSpells, this._currentSearchText, "spellName");
            this.currentFilteredSpells = filteredSpells;
            if (isUpdateDataProvider)
            {
                this.currentSpellGrid.dataProvider = this.currentFilteredSpells;
            };
        }

        private function updateSpellNameSort():void
        {
            this._currentSort = SPELL_NAME_SORT_TYPE;
            this.systemApi.setData(STORAGE_SPELL_SORT, this._currentSort);
            this._isSpellNameSortAscendingType = (!(this._isSpellNameSortAscendingType));
            this.systemApi.setData(STORAGE_IS_SPELL_NAME_SORT_ASCENDING_TYPE, this._isSpellNameSortAscendingType);
            this.applySort();
        }

        private function updateSpellLevelSort():void
        {
            this._isSpellLevelSortAscendingType = (!(this._isSpellLevelSortAscendingType));
            this.systemApi.setData(STORAGE_IS_SPELL_LEVEL_SORT_ASCENDING_TYPE, this._isSpellLevelSortAscendingType);
            this._currentSort = SPELL_LEVEL_SORT_TYPE;
            this.systemApi.setData(STORAGE_SPELL_SORT, this._currentSort);
            this.applySort();
        }

        private function updateLearnedSpellsFilter(learnedSpellsValue:uint):void
        {
            var oldValue:uint = this._currentLearnedSpellsFilter;
            this._currentLearnedSpellsFilter = learnedSpellsValue;
            if (oldValue === this._currentLearnedSpellsFilter)
            {
                return;
            };
            this.systemApi.setData(STORAGE_LEARNED_SPELLS_LEVEL_FILTER, this._currentLearnedSpellsFilter);
            if (((oldValue === LEARNED_SPELLS_FILTER_ALL) && (!(this._currentLearnedSpellsFilter === LEARNED_SPELLS_FILTER_ALL))))
            {
                this.applyLearnedSpellsFilter(true);
            }
            else
            {
                this.applyFilterPipeline();
            };
        }

        private function updateSpellLevelFilter():void
        {
            var newMinLevel:Number = Number(this.inp_minSpellLevel.lastTextOnInput);
            var newMaxLevel:Number = Number(this.inp_maxSpellLevel.lastTextOnInput);
            if (((!(this._isSpellLevelFilterReady)) || ((this._currentSpellLevelFilterMinLevel === newMinLevel) && (this._currentSpellLevelFilterMaxLevel === newMaxLevel))))
            {
                return;
            };
            var oldMinLevel:uint = this._currentSpellLevelFilterMinLevel;
            var oldMaxLevel:uint = this._currentSpellLevelFilterMaxLevel;
            if ((((isNaN(newMinLevel)) || (newMinLevel < uint.MIN_VALUE)) || (newMinLevel > uint.MAX_VALUE)))
            {
                newMinLevel = this.defaultMinSpellLevelFilter;
            };
            if ((((isNaN(newMaxLevel)) || (newMaxLevel < uint.MIN_VALUE)) || (newMaxLevel > uint.MAX_VALUE)))
            {
                newMaxLevel = this.defaultMaxSpellLevelFilter;
            };
            if (newMinLevel > newMaxLevel)
            {
                newMinLevel = this.defaultMinSpellLevelFilter;
            };
            this._currentSpellLevelFilterMinLevel = newMinLevel;
            this._currentSpellLevelFilterMaxLevel = newMaxLevel;
            this.systemApi.setData(STORAGE_MIN_SPELL_LEVEL_FILTER, this._currentSpellLevelFilterMinLevel);
            this.systemApi.setData(STORAGE_MAX_SPELL_LEVEL_FILTER, this._currentSpellLevelFilterMaxLevel);
            if (((this._currentSpellLevelFilterMinLevel < oldMinLevel) || (this._currentSpellLevelFilterMaxLevel > oldMaxLevel)))
            {
                this.applyFilterPipeline();
            }
            else
            {
                this.applySpellLevelFilter(true);
            };
        }

        private function updateObtainingFilter(clickedButton:ButtonContainer):void
        {
            var obtainingKey:String = clickedButton.name.substr(4);
            if (!this._obtainingFiltersDescr.hasOwnProperty(obtainingKey))
            {
                return;
            };
            var isFilterActive:Boolean = (this._obtainingFiltersDescr[obtainingKey] = (!(this._obtainingFiltersDescr[obtainingKey])));
            var iconPrefix:String = OBTAINING_ICONS_MAP[obtainingKey];
            if (isFilterActive)
            {
                this[("tx_" + obtainingKey)].uri = this.uiApi.createUri(((this.uiApi.me().getConstant("texture") + iconPrefix) + "_over.png"));
                this.applyFilterPipeline();
            }
            else
            {
                this[("tx_" + obtainingKey)].uri = this.uiApi.createUri(((this.uiApi.me().getConstant("texture") + iconPrefix) + "_grey.png"));
                this.applyObtainingFilter(true);
            };
        }

        private function updateSearchFilter(searchText:String):void
        {
            var oldSearchText:String = ((this._currentSearchText === null) ? "" : this._currentSearchText);
            this._currentSearchText = searchText;
            if (oldSearchText === this._currentSearchText)
            {
                return;
            };
            if (this._currentSearchText.indexOf(oldSearchText) >= 0)
            {
                this.applySearchFilter(true);
            }
            else
            {
                this.applyFilterPipeline();
            };
        }

        private function updateSpellLevelInputs():void
        {
            this._isSpellLevelFilterReady = false;
            this.inp_minSpellLevel.text = this._currentSpellLevelFilterMinLevel.toString();
            this.inp_maxSpellLevel.text = this._currentSpellLevelFilterMaxLevel.toString();
            this._isSpellLevelFilterReady = true;
        }

        private function updateSearchBar():void
        {
            this._isSearchInputReady = true;
            if (!this.inp_spellLevelSearch.text)
            {
                this._isSearchInputFilled = false;
            };
            if (((this._isSearchInputFilled) || (this.inp_spellLevelSearch.text === this._searchSpellText)))
            {
                return;
            };
            this.updateSearchPlaceholder();
        }

        private function updateSearchPlaceholder(isPlaceholder:Boolean=true):void
        {
            this._isSearchPlaceholderReset = true;
            if (isPlaceholder)
            {
                this._currentSearchText = null;
                this.inp_spellLevelSearch.text = this._searchSpellText;
            }
            else
            {
                this.inp_spellLevelSearch.text = "";
            };
        }

        private function handleSearchClick():void
        {
            if (!this._isSearchInputFilled)
            {
                this.updateSearchPlaceholder(false);
            };
        }

        private function resetSearchBar(isReapplyFilterPipeline:Boolean=true):void
        {
            this._isSearchInputReady = false;
            this._isSearchInputFilled = false;
            this.updateSearchPlaceholder();
            if (isReapplyFilterPipeline)
            {
                this.applyFilterPipeline();
            };
        }

        private function loadActiveSpells():void
        {
            this._activeSpellIds = [];
            this._activeSpells = this.storageApi.getShortcutBarContent(ShortcutBarEnum.SPELL_SHORTCUT_BAR);
            this.updateCurrentActiveSpells();
        }

        private function createSpellSet():void
        {
            if (!this.uiApi.getUi(UIEnum.TEMPORIS_SPELL_SET_POP_UP))
            {
                this.uiApi.loadUi(UIEnum.TEMPORIS_SPELL_SET_POP_UP, UIEnum.TEMPORIS_SPELL_SET_POP_UP, [TemporisSpellSetPopUp.ACTION_CREATE_SPELL_SET]);
            };
        }

        public function getSpellSets():void
        {
            var temporisSpellSetUi:UiRootContainer = this.uiApi.getUi(UIEnum.TEMPORIS_SPELL_SETS_UI);
            if (temporisSpellSetUi === null)
            {
                this.uiApi.loadUi(UIEnum.TEMPORIS_SPELL_SETS_UI, UIEnum.TEMPORIS_SPELL_SETS_UI, []);
            }
            else
            {
                temporisSpellSetUi.setOnTop();
            };
        }

        private function handleActiveSpellsSelect(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var currentSpellWrapper:SpellWrapper;
            var spellCastResult:String;
            var currentSpellShortcut:ShortcutWrapper = target.selectedItem;
            if (currentSpellShortcut !== null)
            {
                if ((((this.systemApi.isFightContext()) && (this._isAltDown)) && (currentSpellShortcut.realItem is SpellWrapper)))
                {
                    currentSpellWrapper = (currentSpellShortcut.realItem as SpellWrapper);
                    spellCastResult = this.playedCharacterApi.canCastThisSpellWithResult(currentSpellWrapper.spellId, currentSpellWrapper.spellLevel);
                    this.systemApi.sendAction(new ChatTextOutput(spellCastResult, ChatActivableChannelsEnum.CHANNEL_TEAM, null, null));
                }
                else
                {
                    if (target.selectedItem.active)
                    {
                        this.systemApi.sendAction(new GameFightSpellCast(currentSpellShortcut.id, (this.gd_activeSpells.selectedIndex + 1)));
                    };
                };
            };
        }

        private function updateCurrentActiveSpells():void
        {
            var spell:Object;
            var index:uint;
            this.lbl_currentActiveSpellsIndex.text = String((this._currentActiveSpellsIndex + 1));
            var activeSpellsDataProvider:Array = [];
            for each (spell in this._activeSpells)
            {
                if (spell !== null)
                {
                    activeSpellsDataProvider[(spell.slot - (this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER))] = spell;
                    this.saveActiveSpell(spell.id);
                };
            };
            index = 0;
            while (index < (MAX_ACTIVE_SPELLS_PAGES * ACTIVE_SPELLS_BY_PAGE_NUMBER))
            {
                if (!activeSpellsDataProvider[index])
                {
                    activeSpellsDataProvider[index] = null;
                };
                index++;
            };
            this.gd_activeSpells.dataProvider = activeSpellsDataProvider;
        }

        private function updateCurrentTab():void
        {
            this.btn_temporisSpells.selected = false;
            this.btn_commonSpells.selected = false;
            this.btn_fatalBlows.selected = false;
            this.ctr_temporisSpells.visible = false;
            this.ctr_commonSpells.visible = false;
            this.ctr_fatalBlows.visible = false;
            this.ctr_obtainingFilters.visible = false;
            this.ctr_topFilters.visible = false;
            if (this._currentTabName === FATAL_BLOWS_TAB_NAME)
            {
                this.openFatalBlowsTab();
                return;
            };
            this.resetFilters();
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                this.openTemporisSpellsTab();
            }
            else
            {
                if (this._currentTabName === COMMON_SPELLS_TAB_NAME)
                {
                    this.openCommonSpellsTab();
                };
            };
            this.applySort();
        }

        private function openTemporisSpellsTab():void
        {
            this.btn_temporisSpells.selected = true;
            this.ctr_temporisSpells.visible = true;
            this.ctr_obtainingFilters.visible = true;
            this.ctr_topFilters.visible = true;
            this.refreshTemporisSpellsList();
        }

        private function openCommonSpellsTab():void
        {
            this.btn_commonSpells.selected = true;
            this.ctr_commonSpells.visible = true;
            if (!this._hasCommonSpellsTabBeenOpenedOnce)
            {
                this._hasCommonSpellsTabBeenOpenedOnce = true;
                this.systemApi.setData(STORAGE_HAS_COMMON_SPELLS_TAB_BEEN_OPENED_ONCE, this._hasCommonSpellsTabBeenOpenedOnce);
                this.tx_commonSpellsWarning.visible = false;
            };
            this.refreshCommonSpellsList();
        }

        private function openFatalBlowsTab():void
        {
            this.btn_fatalBlows.selected = true;
            this.ctr_fatalBlows.visible = true;
            if (this.uiApi.getUi(FATAL_BLOWS_UI_NAME) === null)
            {
                this._fatalBlowsUi = (this.uiApi.loadUiInside(UIEnum.FINISH_MOVES_UI, this.ctr_fatalBlows, FATAL_BLOWS_UI_NAME, null) as UiRootContainer);
                if (this._fatalBlowsUi === null)
                {
                    return;
                };
                this._fatalBlowsUi.addEventListener("UIRenderComplete", this.onFatalBlowsLoaded);
            };
        }

        private function refreshTemporisSpellsList():void
        {
            var forgettableSpellItem:ForgettableSpellItem;
            var spellId:int;
            var index:uint;
            var temporisSpellDictionary:Dictionary = (this.playedCharacterApi.getPlayerForgettableSpells() as Dictionary);
            if (temporisSpellDictionary === null)
            {
                temporisSpellDictionary = new Dictionary();
            };
            var learnableSpellList:Array = this.playedCharacterApi.getForgettableSpells();
            this._temporisSpells = [];
            this._filteredTemporisSpells = null;
            this._equippedTemporisSpells = [];
            var processedTemporisSpells:Array = [];
            var forgettableSpell:ForgettableSpell;
            this._learnedTemporisSpellsNumber = 0;
            this._temporisSpellsNumber = 0;
            for each (forgettableSpell in learnableSpellList)
            {
                if (forgettableSpell !== null)
                {
                    this.addTemporisSpell(forgettableSpell.id, forgettableSpell.itemId, temporisSpellDictionary);
                    processedTemporisSpells.push(forgettableSpell.id);
                };
            };
            for each (forgettableSpellItem in temporisSpellDictionary)
            {
                if (processedTemporisSpells.indexOf(forgettableSpellItem.spellId) !== -1)
                {
                }
                else
                {
                    forgettableSpell = this.playedCharacterApi.getForgettableSpellById(forgettableSpellItem.spellId);
                    if (forgettableSpell !== null)
                    {
                        this.addTemporisSpell(forgettableSpellItem.spellId, forgettableSpell.itemId, temporisSpellDictionary);
                    };
                };
            };
            spellId = -1;
            index = 0;
            while (index < this._temporisSpells.length)
            {
                spellId = this._temporisSpells[index].spellId;
                if (this.isSpellActive(spellId))
                {
                    this.equipTemporisSpell(spellId, false);
                };
                index++;
            };
            var maxTemporisSpellsNumber:int = this.playedCharacterApi.getPlayerMaxTemporisSpellsNumber();
            var isMaxTemporisSpellsNumberHeaderVisible:* = (maxTemporisSpellsNumber >= 0);
            if (isMaxTemporisSpellsNumberHeaderVisible)
            {
                this.lbl_temporisIsSpellEquippedHeader.text = ((this._equippedTemporisSpells.length + "/") + maxTemporisSpellsNumber);
            };
            this.lbl_temporisIsSpellEquippedHeader.visible = isMaxTemporisSpellsNumberHeaderVisible;
            this.lbl_learnedSpells.text = this.uiApi.getText("ui.temporis.learnedSpellsRatio", this._learnedTemporisSpellsNumber, this._temporisSpellsNumber);
            var toMoveIndex:Number = ((this.gd_temporisSpells.scrollBarV !== null) ? this.gd_temporisSpells.scrollBarV.value : -1);
            this.gd_temporisSpells.dataProvider = this._temporisSpells;
            this.applyFilterPipeline();
            this.applySort();
            this.updateShareSpellsButton();
            if (toMoveIndex > 0)
            {
                this.gd_temporisSpells.moveTo(toMoveIndex, true);
            };
        }

        private function addTemporisSpell(spellId:uint, itemId:uint, temporisSpellDictionary:Dictionary):void
        {
            var spell:Spell = this.dataApi.getSpell(spellId);
            var spellWrapper:SpellWrapper = this.dataApi.getSpellWrapper(spellId);
            var itemWrapper:ItemWrapper = this.dataApi.getItemWrapper(itemId);
            if ((((spell === null) || (spellWrapper === null)) || (itemWrapper === null)))
            {
                return;
            };
            var obtainingDescr:Object = {};
            var isObtainingAMystery:Boolean = true;
            if (((itemWrapper.dropMonsterIds.length > 0) || ((itemWrapper.dropTemporisMonsterIds) && (itemWrapper.dropTemporisMonsterIds.length > 0))))
            {
                obtainingDescr[OBTAINING_SPELL_IS_DROPPABLE] = {
                    "iconGreyPath":(OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_DROPPABLE] + "_grey.png"),
                    "iconOverPath":(OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_DROPPABLE] + "_over.png"),
                    "id":2,
                    "item":itemWrapper
                };
                isObtainingAMystery = false;
            };
            if (((!(itemWrapper.recipeSlots == 0)) && (!(itemWrapper.secretRecipe))))
            {
                obtainingDescr[OBTAINING_SPELL_IS_CRAFTABLE] = {
                    "iconGreyPath":(OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_CRAFTABLE] + "_grey.png"),
                    "iconOverPath":(OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_CRAFTABLE] + "_over.png"),
                    "id":1,
                    "item":itemWrapper
                };
                isObtainingAMystery = false;
            };
            if (isObtainingAMystery)
            {
                obtainingDescr[OBTAINING_SPELL_IS_UNKNOWN] = {
                    "iconGreyPath":(OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_UNKNOWN] + "_grey.png"),
                    "iconOverPath":(OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_UNKNOWN] + "_over.png"),
                    "id":UNKNOWN_OBTAINING,
                    "item":itemWrapper
                };
            };
            var data:* = spellWrapper;
            var spellName:String = ((data.name !== null) ? data.name : spell.name);
            var isSpellKnown:* = (spellId in temporisSpellDictionary);
            var forgettableSpellItem:ForgettableSpellItem;
            if (isSpellKnown)
            {
                this._learnedTemporisSpellsNumber++;
                forgettableSpellItem = temporisSpellDictionary[spellId];
                if (((!(forgettableSpellItem === null)) && (forgettableSpellItem.available)))
                {
                    this.equipTemporisSpell(forgettableSpellItem.spellId, false);
                };
            };
            if (this.systemApi.getPlayerManager().hasRights)
            {
                spellName = (spellName + ((" (" + data.id) + ")"));
            };
            this._temporisSpells.push({
                "spellId":spellId,
                "scrollId":itemId,
                "isKnown":isSpellKnown,
                "spellName":spellName,
                "spellLevel":spell.spellLevelsInfo[(spellWrapper.spellLevel - 1)].minPlayerLevel,
                "obtainingDescr":obtainingDescr,
                "spellWrapper":spellWrapper,
                "spellFamily":SPELL_FAMILY_TEMPORIS,
                "isSpellActive":this.isSpellActive(spellId)
            });
            this._temporisSpellsNumber++;
        }

        private function refreshCommonSpellsList():void
        {
            var obtainingLevels:Array;
            var spellLevels:Array;
            var jndex:uint;
            var kndex:uint;
            this._commonSpells = [];
            this._filteredCommonSpells = null;
            var spellList:Array = Grimoire.getInstance().currentSpecialSpells.concat(Grimoire.getInstance().currentBreedSpells);
            var spellListSize:uint = spellList.length;
            var currentSpellWrapper:SpellWrapper;
            var currentSpellLevelWrapper:SpellWrapper;
            var currentSpell:Spell;
            var currentSpellName:String;
            var currentSpellType:String;
            var currentCustomModeBreedSpell:CustomModeBreedSpell;
            var data:* = null;
            var index:uint;
            while (index < spellListSize)
            {
                if (spellList[index] === null)
                {
                }
                else
                {
                    jndex = 0;
                    while (jndex < spellList[index].length)
                    {
                        currentSpellWrapper = spellList[index][jndex];
                        currentSpell = currentSpellWrapper.spell;
                        currentCustomModeBreedSpell = this.playedCharacterApi.getCustomModeBreedSpellById(currentSpell.id);
                        if (((!(currentCustomModeBreedSpell === null)) && (currentCustomModeBreedSpell.isHidden)))
                        {
                        }
                        else
                        {
                            if (currentSpell.id === 0)
                            {
                                currentSpellType = this._weaponSpellType;
                            }
                            else
                            {
                                if (currentCustomModeBreedSpell === null)
                                {
                                    currentSpellType = this._specialSpellType;
                                }
                                else
                                {
                                    if (currentCustomModeBreedSpell.isInitialSpell)
                                    {
                                        currentSpellType = this._passiveSpellType;
                                    }
                                    else
                                    {
                                        currentSpellType = this._activeSpellType;
                                    };
                                };
                            };
                            data = currentSpellWrapper;
                            currentSpellName = ((data.name !== null) ? data.name : currentSpell.name);
                            if (this.systemApi.getPlayerManager().hasRights)
                            {
                                currentSpellName = (currentSpellName + ((" (" + currentSpellWrapper.id) + ")"));
                            };
                            spellLevels = currentSpell.spellLevelsInfo;
                            obtainingLevels = [];
                            kndex = 0;
                            while (kndex < spellLevels.length)
                            {
                                currentSpellLevelWrapper = this.dataApi.getSpellWrapper(currentSpell.id, spellLevels[kndex].grade);
                                if (currentSpellLevelWrapper === null)
                                {
                                }
                                else
                                {
                                    obtainingLevels.push({
                                        "spellLevel":spellLevels[kndex].minPlayerLevel,
                                        "isFirstLevel":((this._playerLevel < spellLevels[kndex].minPlayerLevel) && (kndex === 0)),
                                        "grade":spellLevels[kndex].grade,
                                        "spellWrapper":currentSpellLevelWrapper,
                                        "isKnown":((currentSpellWrapper.variantActivated) && (currentSpellWrapper.spellLevel === currentSpellLevelWrapper.spellLevel))
                                    });
                                };
                                kndex++;
                            };
                            this._commonSpells.push({
                                "spellId":currentSpell.id,
                                "spellName":currentSpellName,
                                "spellLevel":spellLevels[(currentSpellWrapper.spellLevel - 1)].minPlayerLevel,
                                "obtainingLevels":obtainingLevels,
                                "isKnown":currentSpellWrapper.variantActivated,
                                "spellWrapper":currentSpellWrapper,
                                "spellType":currentSpellType,
                                "spellFamily":SPELL_FAMILY_COMMON,
                                "isSpellActive":this.isSpellActive(currentSpell.id)
                            });
                        };
                        jndex++;
                    };
                };
                index++;
            };
            var toMoveIndex:Number = ((this.gd_commonSpells.scrollBarV !== null) ? this.gd_commonSpells.scrollBarV.value : -1);
            this.gd_commonSpells.dataProvider = this._commonSpells;
            this.applySort();
            if (toMoveIndex !== -1)
            {
                this.gd_commonSpells.moveTo(toMoveIndex, true);
            };
        }

        private function updateShareSpellsButton():void
        {
            if (this._equippedTemporisSpells.length > 0)
            {
                this.uiApi.addComponentHook(this.btn_shareTemporisSpells, ComponentHookList.ON_RELEASE);
                this.ctr_shareTemporisSpells.alpha = 1;
                this.btn_shareTemporisSpells.handCursor = true;
                this.uiApi.removeComponentHook(this.ctr_shareTemporisSpells, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.removeComponentHook(this.ctr_shareTemporisSpells, ComponentHookList.ON_ROLL_OUT);
                this.btn_shareTemporisSpells.x = this.lbl_shareTemporisSpells.x;
                this.btn_shareTemporisSpells.width = (((this.tx_shareTemporisSpells.x - this.lbl_shareTemporisSpells.x) + this.lbl_shareTemporisSpells.width) + this.tx_shareTemporisSpells.width);
            }
            else
            {
                this.uiApi.removeComponentHook(this.btn_shareTemporisSpells, ComponentHookList.ON_RELEASE);
                this.ctr_shareTemporisSpells.alpha = DISABLED_SHARE_TEMPORIS_SPELLS_CONTAINER_ALPHA;
                this.btn_shareTemporisSpells.handCursor = false;
                this.uiApi.addComponentHook(this.ctr_shareTemporisSpells, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(this.ctr_shareTemporisSpells, ComponentHookList.ON_ROLL_OUT);
            };
        }

        private function showSpellTooltip(data:Object, target:Object, fromUI:uint):void
        {
            var point:uint;
            var relativePoint:uint;
            var offset:uint;
            if (((data === null) || (target === null)))
            {
                return;
            };
            var spellWrapper:SpellWrapper;
            if (fromUI === FROM_ACTIVE_SPELLS)
            {
                if (!(data.realItem is SpellWrapper))
                {
                    return;
                };
                point = LocationEnum.POINT_TOP;
                relativePoint = LocationEnum.POINT_BOTTOM;
                offset = 3;
                spellWrapper = this.dataApi.getSpellWrapper(data.id, data.realItem.spellLevel, true);
            }
            else
            {
                if (((fromUI === FROM_TEMPORIS_SPELLS) || (fromUI === FROM_COMMON_SPELLS)))
                {
                    point = LocationEnum.POINT_LEFT;
                    relativePoint = LocationEnum.POINT_RIGHT;
                    offset = 3;
                    spellWrapper = data.spellWrapper;
                }
                else
                {
                    return;
                };
            };
            if (spellWrapper === null)
            {
                return;
            };
            this.uiApi.showTooltip(spellWrapper, target, false, TOOLTIP_UI_NAME, point, relativePoint, offset, null, null, {
                "alwaysAdvanced":true,
                "footer":false
            }, null, false);
        }

        private function showRemoveSpellMenu(data:Object):void
        {
            this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            if (data === null)
            {
                return;
            };
            var spellContextMenu:Object = this.menuApi.create(data.realItem, "spell", []);
            spellContextMenu.content.push(this.ankamaContextMenu.createContextMenuSeparatorObject(), this.ankamaContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.remove"), this.removeSpellFromActiveSpells, [data.slot], false));
            this.ankamaContextMenu.createContextMenu(spellContextMenu);
        }

        private function addSpellToActiveSpells(spellId:int, index:int):void
        {
            var isTemporisSpell:Boolean = this.playedCharacterApi.isForgettableSpell(spellId);
            if (isTemporisSpell)
            {
                if (((!(this.canTemporisSpellsBeAdded())) && (!(this.isTemporisSpellEquipped(spellId)))))
                {
                    this.systemApi.dispatchHook(TextInformation, this.uiApi.getText("ui.temporis.warningTemporisSpellsLimit", this.playedCharacterApi.getPlayerMaxTemporisSpellsNumber()), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, this.timeApi.getTimestamp());
                    return;
                };
                if (!this.isTemporisSpellEquipped(spellId))
                {
                    this.equipTemporisSpell(spellId);
                };
            };
            this.systemApi.sendAction(new ShortcutBarAddRequest(DataEnum.SHORTCUT_TYPE_SPELL, spellId, (index + (this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER))));
        }

        private function getFirstActiveSpellIndexAvailable():int
        {
            var shortcutWrapper:ShortcutWrapper;
            var firstEntryAvailableIndex:int = -1;
            var currentIndex:uint;
            for each (shortcutWrapper in this.gd_activeSpells.dataProvider)
            {
                if (shortcutWrapper === null)
                {
                    firstEntryAvailableIndex = currentIndex;
                    break;
                };
                currentIndex++;
            };
            return (firstEntryAvailableIndex);
        }

        private function showAddSpellMenu(slot:Slot):void
        {
            var firstEntryAvailableIndex:int;
            this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            if (((slot === null) || (!(slot.data is SpellWrapper))))
            {
                return;
            };
            var spellContextMenu:Object = this.menuApi.create(slot.data, "spell", []);
            var playerTemporisSpellsDictionary:Dictionary = (this.playedCharacterApi.getPlayerForgettableSpells() as Dictionary);
            var isSpellKnown:Boolean = ((!(slot.greyedOut)) && ((slot.data.variantActivated) || (slot.data.id in playerTemporisSpellsDictionary)));
            if (isSpellKnown)
            {
                firstEntryAvailableIndex = this.getFirstActiveSpellIndexAvailable();
                if (firstEntryAvailableIndex >= 0)
                {
                    spellContextMenu.content.push(this.ankamaContextMenu.createContextMenuSeparatorObject(), this.ankamaContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.add"), function ():void
                    {
                        addSpellToActiveSpells(slot.data.id, firstEntryAvailableIndex);
                    }, [slot]));
                };
            };
            this.ankamaContextMenu.createContextMenu(spellContextMenu);
        }

        private function handleObtainingClick(data:Object):void
        {
            var itemData:Object;
            var subAreaWithMaxItem:uint;
            var subAreaMaxItemCount:uint;
            var text:String;
            var itemSubAreas:Vector.<uint>;
            var subArea:SubArea;
            var subAreaId:Object;
            if (((data === null) || (data.id === UNKNOWN_OBTAINING)))
            {
                return;
            };
            if (((data.id === EncyclopediaList.ITEM_COMPONENT_CAT_ID) || (data.id === EncyclopediaList.ITEM_CRAFTABLE_CAT_ID)))
            {
                this.systemApi.dispatchHook(OpenRecipe, data.item);
            }
            else
            {
                if (data.id === EncyclopediaList.ITEM_DROPABLE_CAT_ID)
                {
                    itemData = {};
                    itemData.monsterId = 0;
                    itemData.monsterSearch = data.item.name;
                    if (data.item.dropTemporisMonsterIds)
                    {
                        itemData.monsterIdsList = data.item.dropMonsterIds.concat(data.item.dropTemporisMonsterIds);
                    }
                    else
                    {
                        itemData.monsterIdsList = data.item.dropMonsterIds;
                    };
                    itemData.forceOpen = true;
                    this.systemApi.dispatchHook(OpenEncyclopedia, EnumTab.BESTIARY_TAB, itemData);
                }
                else
                {
                    if (data.id == EncyclopediaList.ITEM_HARVESTABLE_CAT_ID)
                    {
                        subAreaWithMaxItem = 0;
                        subAreaMaxItemCount = 0;
                        text = this.uiApi.processText(this.uiApi.getText("ui.monster.presentInAreas", data.item.resourcesBySubarea.length), "m", (data.item.resourcesBySubarea.length == 1), (data.item.resourcesBySubarea.length == 0));
                        itemSubAreas = new Vector.<uint>(0);
                        for each (subAreaId in data.item.resourcesBySubarea)
                        {
                            subArea = this.dataApi.getSubArea(subAreaId[0]);
                            if (((subArea.hasCustomWorldMap) || (subArea.area.superArea.hasWorldMap)))
                            {
                                itemSubAreas.push(subAreaId[0]);
                                if (subAreaId[1] > subAreaMaxItemCount)
                                {
                                    subAreaWithMaxItem = subAreaId[0];
                                };
                            };
                        };
                        this._cartographyPopup = this.ankamaCartography.openCartographyPopup(data.item.name, subAreaWithMaxItem, itemSubAreas, text);
                    };
                };
            };
        }

        private function getScrollFromTemporisSpell(spellDescr:Object, isForce:Boolean=false):void
        {
            var spellSetsUsed:Array;
            var isSpellUsed:Boolean;
            if (!isForce)
            {
                spellSetsUsed = this.getSpellSetsWithSpell(spellDescr.spellId);
                isSpellUsed = (spellSetsUsed.length > 0);
            };
            if (((isSpellUsed) && (!(isForce))))
            {
                if (!this.uiApi.getUi(UIEnum.TEMPORIS_GET_SCROLL_WARNING_POP_UP))
                {
                    this.uiApi.loadUi(UIEnum.TEMPORIS_GET_SCROLL_WARNING_POP_UP, UIEnum.TEMPORIS_GET_SCROLL_WARNING_POP_UP, [spellDescr, spellSetsUsed, this.getScrollFromTemporisSpell]);
                };
            }
            else
            {
                this.systemApi.sendAction(new ForgettableSpellClientAction(spellDescr.spellId, ForgettableSpellClientActionEnum.FORGETTABLE_SPELL_FORGET));
            };
        }

        private function isSpellScrollAvailable(scrollId:int):Boolean
        {
            var inventoryContent:Vector.<ItemWrapper> = (this.dataApi.getInventoryViewContent(STORAGE_CONSUMABLES_VIEW) as Vector.<ItemWrapper>);
            if (inventoryContent === null)
            {
                return (false);
            };
            var index:uint;
            while (index < inventoryContent.length)
            {
                if (inventoryContent[index].id === scrollId)
                {
                    return (true);
                };
                index++;
            };
            return (false);
        }

        private function searchScrollFromTemporisSpell(spellDescr:Object):void
        {
            var forgettableSpell:ForgettableSpell = this.playedCharacterApi.getForgettableSpellById(spellDescr.spellId);
            if (forgettableSpell === null)
            {
                return;
            };
            var scrollWrapped:ItemWrapper = this.dataApi.getItemWrapper(forgettableSpell.itemId);
            if (scrollWrapped === null)
            {
                return;
            };
            if (this.isSpellScrollAvailable(scrollWrapped.id))
            {
                this.systemApi.dispatchHook(SearchTemporisSpellScroll, scrollWrapped.name);
            };
        }

        private function activeSpellDropValidator(target:Object, data:Object, source:Object):Boolean
        {
            var isValid:Boolean;
            var shortcutWrapper:ShortcutWrapper;
            if ((((data === null) || (!(source is Slot))) || (!(target is Slot))))
            {
                return (false);
            };
            var sourceSlot:Slot = (source as Slot);
            var targetSlot:Slot = (target as Slot);
            var sourceGrid:Grid = (sourceSlot.getParent() as Grid);
            if ((((!(sourceGrid === null)) && (sourceGrid === (targetSlot.getParent() as Grid))) && (data is ShortcutWrapper)))
            {
                isValid = false;
                for each (shortcutWrapper in this.gd_activeSpells.dataProvider)
                {
                    if (((!(shortcutWrapper === null)) && (shortcutWrapper.id === data.id)))
                    {
                        isValid = true;
                        break;
                    };
                };
                if (!isValid)
                {
                    return (false);
                };
            };
            return ((data is SpellWrapper) || ((data is ShortcutWrapper) && (data.realItem is SpellWrapper)));
        }

        private function processActiveSpellDrop(target:Object, data:Object, source:Object):void
        {
            var isTemporisSpellRemoved:Boolean;
            var currentSpell:SpellWrapper;
            if ((data is ShortcutWrapper))
            {
                if (!(data.realItem is SpellWrapper))
                {
                    return;
                };
                this.systemApi.sendAction(new ShortcutBarSwapRequest(ShortcutBarEnum.SPELL_SHORTCUT_BAR, data.slot, (this.gd_activeSpells.getItemIndex(target) + (this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER))));
                this._hasProcessedDrop = true;
            }
            else
            {
                isTemporisSpellRemoved = false;
                if ((((!(target.data === null)) && (target.data is ShortcutWrapper)) && (target.data.realItem is SpellWrapper)))
                {
                    currentSpell = (target.data.realItem as SpellWrapper);
                    if (currentSpell.id === data.id)
                    {
                        return;
                    };
                    if (this.playedCharacterApi.isForgettableSpell(currentSpell.id))
                    {
                        this.unequipTemporisSpell(currentSpell.id);
                        isTemporisSpellRemoved = true;
                    };
                };
                if (((this.playedCharacterApi.isForgettableSpell(data.id)) && (!(this.isTemporisSpellEquipped(data.id)))))
                {
                    if (((!(this.canTemporisSpellsBeAdded())) && (!(isTemporisSpellRemoved))))
                    {
                        this.systemApi.dispatchHook(TextInformation, this.uiApi.getText("ui.temporis.warningTemporisSpellsLimit", this.playedCharacterApi.getPlayerMaxTemporisSpellsNumber()), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, this.timeApi.getTimestamp());
                        return;
                    };
                    this.equipTemporisSpell(data.id);
                };
                this.systemApi.sendAction(new ShortcutBarAddRequest(DataEnum.SHORTCUT_TYPE_SPELL, data.id, (this.gd_activeSpells.getItemIndex(target) + (this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER))));
                this._hasProcessedDrop = true;
            };
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                this.refreshTemporisSpellsList();
            }
            else
            {
                if (this._currentTabName === COMMON_SPELLS_TAB_NAME)
                {
                    this.refreshCommonSpellsList();
                };
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            switch (target)
            {
                case this.gd_activeSpells:
                    this.handleActiveSpellsSelect(target, selectMethod, isNewSelection);
                    break;
                case this.cbx_learningSpellsFilter:
                    this.updateLearnedSpellsFilter(this.cbx_learningSpellsFilter.selectedIndex);
                    break;
            };
        }

        public function onRelease(target:Object):void
        {
            var temporisSpellSetUi:UiRootContainer;
            this.updateSearchBar();
            this.updateSpellLevelInputs();
            switch (target)
            {
                case this.mainCtr:
                    temporisSpellSetUi = this.uiApi.getUi(UIEnum.TEMPORIS_SPELL_SETS_UI);
                    if (temporisSpellSetUi !== null)
                    {
                        temporisSpellSetUi.setOnTop();
                    };
                    return;
                case this.btn_help:
                    this.hintsApi.showSubHints(this._currentTabName);
                    break;
                case this.btn_previousActiveSpells:
                    this.currentActiveSpellsIndex = (this._currentActiveSpellsIndex - 1);
                    break;
                case this.btn_nextActiveSpells:
                    this.currentActiveSpellsIndex = (this._currentActiveSpellsIndex + 1);
                    break;
                case this.btn_saveAsASpellSet:
                    this.createSpellSet();
                    break;
                case this.btn_seeMySpellSets:
                    this.getSpellSets();
                    break;
                case this.btn_temporisSpells:
                    this.currentTabName = TEMPORIS_SPELLS_TAB_NAME;
                    this.hintsApi.uiTutoTabLaunch();
                    break;
                case this.btn_commonSpells:
                    this.currentTabName = COMMON_SPELLS_TAB_NAME;
                    this.hintsApi.uiTutoTabLaunch();
                    break;
                case this.btn_fatalBlows:
                    this.currentTabName = FATAL_BLOWS_TAB_NAME;
                    this.hintsApi.uiTutoTabLaunch();
                    break;
                case this.inp_spellLevelSearch:
                    this.handleSearchClick();
                    break;
                case this.btn_clearSearchText:
                    this.resetSearchBar();
                    break;
                case this.btn_spellIsCraftable:
                case this.btn_spellIsDroppable:
                case this.btn_spellIsUnknown:
                    this.updateObtainingFilter((target as ButtonContainer));
                    break;
                case this.btn_sortTemporisSpellsByName:
                case this.btn_sortCommonSpellsByName:
                    this.updateSpellNameSort();
                    break;
                case this.btn_sortTemporisSpellsByLevel:
                    this.updateSpellLevelSort();
                    break;
                case this.btn_shareTemporisSpells:
                    this.shareCurrentTemporisSpells();
                    break;
                default:
                    switch (true)
                    {
                        case (!(target.name.indexOf("tx_findTemporisSpellScroll") === -1)):
                            this.searchScrollFromTemporisSpell(this._componentsDictionary[target.name]);
                            break;
                        case (!(target.name.indexOf("btn_getTemporisSpellScroll") === -1)):
                            this.getScrollFromTemporisSpell(this._componentsDictionary[target.name]);
                            break;
                        case (!(target.name.indexOf("tx_obtaining_") === -1)):
                            this.handleObtainingClick(this._componentsDictionary[target.name]);
                            break;
                    };
            };
        }

        public function onDoubleClick(target:Object):void
        {
            var firstEntryAvailableIndex:int;
            if (target === this.gd_activeSpells)
            {
                this.removeSpellFromActiveSpells((this.gd_activeSpells.selectedIndex + (this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER)));
            }
            else
            {
                if ((((((target.name in this._componentsDictionary) && (!(target.name.indexOf("btn_temporisSpellLine") === -1))) || (!(target.name.indexOf("btn_commonSpellLine") === -1))) || (!(target.name.indexOf("slot_temporisSpell") === -1))) || (!(target.name.indexOf("slot_commonSpell") === -1))))
                {
                    firstEntryAvailableIndex = this.getFirstActiveSpellIndexAvailable();
                    if (firstEntryAvailableIndex >= 0)
                    {
                        this.addSpellToActiveSpells(this._componentsDictionary[target.name].spellId, firstEntryAvailableIndex);
                    };
                };
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var scrollMagicWorkshopPosition:Point;
            var data:Object;
            if (((!(target.name.indexOf("tx_obtaining_") === -1)) && (this._componentsDictionary.hasOwnProperty(target.name))))
            {
                data = this._componentsDictionary[target.name];
                if (data === null)
                {
                    return;
                };
                tooltipText = null;
                switch (data.id)
                {
                    case EncyclopediaList.ITEM_COMPONENT_CAT_ID:
                        target.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + data.iconOverPath));
                        tooltipText = this.uiApi.getText("ui.encyclopedia.filterComponent");
                        break;
                    case EncyclopediaList.ITEM_CRAFTABLE_CAT_ID:
                        target.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + data.iconOverPath));
                        scrollMagicWorkshopPosition = null;
                        if (SCROLL_MAGIC_WORKSHOP_POSITION !== null)
                        {
                            scrollMagicWorkshopPosition = SCROLL_MAGIC_WORKSHOP_POSITION;
                        }
                        else
                        {
                            scrollMagicWorkshopPosition = new Point(0, 0);
                        };
                        tooltipText = this.uiApi.getText("ui.temporis.craftableAt", (((("[" + scrollMagicWorkshopPosition.x) + ",") + scrollMagicWorkshopPosition.y) + "]"));
                        break;
                    case EncyclopediaList.ITEM_DROPABLE_CAT_ID:
                        target.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + data.iconOverPath));
                        tooltipText = this.uiApi.getText("ui.encyclopedia.filterDropable");
                        break;
                    case EncyclopediaList.ITEM_HARVESTABLE_CAT_ID:
                        target.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + data.iconOverPath));
                        tooltipText = this.uiApi.getText("ui.encyclopedia.filterHarvestable");
                        break;
                    case UNKNOWN_OBTAINING:
                        tooltipText = this.uiApi.getText("ui.temporis.unknownObtaining");
                        break;
                };
                if (tooltipText === null)
                {
                    return;
                };
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, TOOLTIP_UI_NAME, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 3, null, null, null, "TextInfo");
            }
            else
            {
                if (target === this.ctr_shareTemporisSpells)
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.temporis.disabledShareTemporisSpellsButtonHelp")), target, false, TOOLTIP_UI_NAME, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 3, null, null, null, "TextInfo");
                }
                else
                {
                    if (target.name.indexOf("slot") !== -1)
                    {
                        if (!(target.name in this._componentsDictionary))
                        {
                            return;
                        };
                        data = this._componentsDictionary[target.name];
                        if (target.name.indexOf("slot_commonSpell_m_gd_commonSpells") !== -1)
                        {
                            this.showSpellTooltip(data, target, FROM_COMMON_SPELLS);
                        }
                        else
                        {
                            if (target.name.indexOf("slot_temporisSpell_m_gd_temporisSpells") !== -1)
                            {
                                this.showSpellTooltip(data, target, FROM_TEMPORIS_SPELLS);
                            };
                        };
                    }
                    else
                    {
                        if (target === this.btn_spellIsCraftable)
                        {
                            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.encyclopedia.filterCraftable")), target, false, TOOLTIP_UI_NAME, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 3, null, null, null, "TextInfo");
                        }
                        else
                        {
                            if (target === this.btn_spellIsDroppable)
                            {
                                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.encyclopedia.filterDropable")), target, false, TOOLTIP_UI_NAME, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 3, null, null, null, "TextInfo");
                            }
                            else
                            {
                                if (target === this.btn_spellIsUnknown)
                                {
                                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.temporis.unknownObtaining")), target, false, TOOLTIP_UI_NAME, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 3, null, null, null, "TextInfo");
                                }
                                else
                                {
                                    if (((!(target.name.indexOf("btn_") === -1)) && (!(target.name.indexOf("SpellLine") === -1))))
                                    {
                                        target.state = StatesEnum.STATE_SELECTED_OVER;
                                    }
                                    else
                                    {
                                        if (target.name.indexOf("btn_obtainingLevel") !== -1)
                                        {
                                            data = this._componentsDictionary[target.name];
                                            if (data !== null)
                                            {
                                                this.showSpellTooltip(data.data, data.target, FROM_COMMON_SPELLS);
                                            };
                                        }
                                        else
                                        {
                                            if (target.name.indexOf("btn_getTemporisSpellScroll") !== -1)
                                            {
                                                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.temporis.getScrollFromTemporisSpell")), target, false, TOOLTIP_UI_NAME, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 3, null, null, null, "TextInfo");
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

        public function onRollOut(target:Object):void
        {
            var data:Object;
            this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
            if (target.name.indexOf("tx_obtaining_") !== -1)
            {
                data = this._componentsDictionary[target.name];
                if (data === null)
                {
                    return;
                };
                target.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + data.iconGreyPath));
            }
            else
            {
                if (((!(target.name.indexOf("btn_") === -1)) && (!(target.name.indexOf("SpellLine") === -1))))
                {
                    target.state = StatesEnum.STATE_NORMAL;
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (target === this.gd_activeSpells)
            {
                this.showSpellTooltip(item.data, item.container, FROM_ACTIVE_SPELLS);
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            this.showRemoveSpellMenu(item.data);
        }

        public function onShortcut(shortcutLabel:String):Boolean
        {
            var me:UiRootContainer;
            if (shortcutLabel === ShortcutHookListEnum.CLOSE_UI)
            {
                me = this.uiApi.me();
                if (me === null)
                {
                    this.systemApi.log(16, "TemporisSpellsUi: the current UI is null!");
                    return (false);
                };
                this.uiApi.unloadUi(me.name);
                return (true);
            };
            return (false);
        }

        private function onActiveSpellDropStart(source:Object):void
        {
            if (source.getUi() === this.uiApi.me())
            {
                this.systemApi.disableWorldInteraction();
            };
        }

        private function onActiveSpellDropEnd(source:Object, target:Object):void
        {
            var targetSlot:Slot;
            var parentUi:UiRootContainer;
            var currentIndex:uint;
            var currentSpellSlot:Slot;
            if (this._hasProcessedDrop)
            {
                this._hasProcessedDrop = false;
                return;
            };
            if (source.getUi() === this.uiApi.me())
            {
                this.systemApi.enableWorldInteraction();
            };
            if ((((!(source.parent === this.gd_activeSpells)) || ((source.data === null) && (source.data.objectGID === null))) || (((source === null) || (source.data === null)) || (!(source.data is ShortcutWrapper)))))
            {
                return;
            };
            if (target === source)
            {
                return;
            };
            if ((target is Slot))
            {
                targetSlot = (target as Slot);
                parentUi = targetSlot.getUi();
                if ((((((!(parentUi === null)) && (!(parentUi.name === null))) && ((parentUi.name === "bannerActionBar") || (!(parentUi.name.indexOf("externalActionBar") === -1)))) && (!(target.parent === null))) && (target.parent.name === "gd_spellitemotes")))
                {
                    return;
                };
            };
            var spellSlot:Slot = (source as Slot);
            var activeSpellsGrid:Grid = (spellSlot.parent as Grid);
            if (activeSpellsGrid !== null)
            {
                currentIndex = 0;
                for each (currentSpellSlot in activeSpellsGrid.slots)
                {
                    if (currentSpellSlot === spellSlot)
                    {
                        this.removeSpellFromActiveSpells((currentIndex + (this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER)));
                        break;
                    };
                    currentIndex++;
                };
            };
        }

        public function onChange(target:GraphicContainer):void
        {
            switch (target)
            {
                case this.inp_spellLevelSearch:
                    this.handleSearchInput();
                    break;
                case this.inp_minSpellLevel:
                case this.inp_maxSpellLevel:
                    this.updateSpellLevelFilter();
                    break;
            };
        }

        private function onKeyDown(target:Object, keyCode:uint):void
        {
            if (keyCode == Keyboard.ALTERNATE)
            {
                this._isAltDown = true;
            };
        }

        private function onKeyUp(target:Object, keyCode:uint):void
        {
            if (keyCode == Keyboard.ALTERNATE)
            {
                this._isAltDown = false;
            };
        }

        private function onAreActiveSpellsAlterable(areActiveSpellsAlterable:Boolean):void
        {
            this._areActiveSpellsAlterable = areActiveSpellsAlterable;
            if (!areActiveSpellsAlterable)
            {
                this._isAltDown = false;
            };
            (this.gd_activeSpells.renderer as SlotGridRenderer).allowDrop = ((this._areActiveSpellsAlterable) || (this._isAltDown));
        }

        public function onWheel(target:Object, delta:int):void
        {
            if (((target === this.gd_activeSpells) || (target === this.ctr_activeSpellsButtons)))
            {
                if (delta > 0)
                {
                    this.currentActiveSpellsIndex = (this._currentActiveSpellsIndex - 1);
                }
                else
                {
                    this.currentActiveSpellsIndex = (this._currentActiveSpellsIndex + 1);
                };
            };
        }

        public function onPress(target:Object):void
        {
            this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
            this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
        }

        private function onShortcutBarViewContent(barType:int):void
        {
            if (barType === ShortcutBarEnum.SPELL_SHORTCUT_BAR)
            {
                this.loadActiveSpells();
                if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
                {
                    this.refreshTemporisSpellsList();
                }
                else
                {
                    if (this._currentTabName === COMMON_SPELLS_TAB_NAME)
                    {
                        this.refreshCommonSpellsList();
                    };
                };
            };
        }

        private function onFatalBlowsLoaded(event:Event):void
        {
            if (this._fatalBlowsUi === null)
            {
                return;
            };
            this._fatalBlowsUi.removeEventListener("UIRenderComplete", this.onFatalBlowsLoaded);
            this._fatalBlowsUi.uiClass.ctr_finishMoveList.x = 50;
            this._fatalBlowsUi.uiClass.ctr_finishMoveList.y = 160;
            this._fatalBlowsUi.uiClass.ctr_illu.height = 360;
            this._fatalBlowsUi.uiClass.tx_illu.height = 330;
        }

        public function onRightClick(target:Object):void
        {
            if ((target is Slot))
            {
                this.showAddSpellMenu((target as Slot));
            };
        }

        private function onTemporisSpells():void
        {
            if (this._currentTabName === TEMPORIS_SPELLS_TAB_NAME)
            {
                this.refreshTemporisSpellsList();
            };
        }

        public function onUiLoaded(name:String):void
        {
            var temporisSpellSetUi:UiRootContainer;
            if (name === UIEnum.STORAGE_UI)
            {
                temporisSpellSetUi = this.uiApi.getUi(UIEnum.TEMPORIS_SPELL_SETS_UI);
                if (temporisSpellSetUi !== null)
                {
                    temporisSpellSetUi.setOnTop();
                };
            };
        }

        public function onPresetsUpdate(buildId:int=-1):void
        {
            this.setSaveSpellSetButton();
        }

        public function onPresetError(reasonText:String):void
        {
            this.setSaveSpellSetButton();
        }


    }
}

