package Ankama_GameUiCore.ui
{
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.uiApi.BindsApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.InventoryApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.StorageApi;
    import com.ankamagames.dofus.uiApi.FightApi;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Label;
    import flash.utils.Timer;
    import Ankama_GameUiCore.ui.params.ActionBarParameters;
    import d2hooks.OpenInventory;
    import d2hooks.SwitchBannerTab;
    import d2hooks.WeaponUpdate;
    import d2hooks.SpellMovementAllowed;
    import d2hooks.ShortcutsMovementAllowed;
    import d2hooks.PresetsUpdate;
    import d2hooks.PreviewBuildSpellBar;
    import d2hooks.IdolsPresetDelete;
    import d2hooks.SlaveStatsList;
    import d2hooks.ShortcutBarViewContent;
    import d2hooks.DropStart;
    import d2hooks.DropEnd;
    import d2hooks.CancelCastSpell;
    import d2hooks.CastSpellMode;
    import d2hooks.SpellUpdate;
    import d2hooks.KeyDown;
    import d2hooks.KeyUp;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import flash.events.TimerEvent;
    import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
    import d2hooks.UiLoaded;
    import d2hooks.UiUnloaded;
    import Ankama_GameUiCore.ui.enums.ContextEnum;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
    import Ankama_GameUiCore.Api;
    import d2actions.ObjectUse;
    import d2actions.PresetUseRequest;
    import d2actions.ChatSmileyRequest;
    import d2actions.EmotePlayRequest;
    import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
    import d2actions.ShortcutBarRemoveRequest;
    import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
    import d2actions.ForgettableSpellClientAction;
    import com.ankamagames.dofus.network.enums.ForgettableSpellClientActionEnum;
    import flash.ui.Keyboard;
    import d2actions.GameFightSpellCast;
    import com.ankamagames.berilia.components.Slot;
    import com.ankamagames.dofus.internalDatacenter.communication.SmileyWrapper;
    import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.IdolsPresetWrapper;
    import d2actions.ShortcutBarSwapRequest;
    import d2actions.ShortcutBarAddRequest;
    import d2actions.ObjectSetPosition;
    import d2actions.ChatTextOutput;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
    import d2actions.OpenTemporisSpellsUi;
    import d2hooks.OpenSpellInterface;
    import d2actions.BannerEmptySlotClick;
    import d2actions.MountInfoRequest;
    import d2hooks.ObjectSelected;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import d2actions.OpenIdols;
    import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
    import __AS3__.vec.*;
    import d2hooks.*;
    import d2actions.*;

    public class ActionBar extends ContextAwareUi 
    {

        protected static var externalActionBars:Vector.<ActionBar> = new Vector.<ActionBar>(4, true);
        protected static var mainBar:ActionBar;
        private static const TYPE_ITEM_WRAPPER:int = 0;
        private static const TYPE_BUILD_WRAPPER:int = 1;
        private static const TYPE_SMILEY_WRAPPER:int = 3;
        private static const TYPE_EMOTE_WRAPPER:int = 4;
        private static const TYPE_IDOLS_PRESET_WRAPPER:int = 5;
        protected static const NUM_PAGES:uint = 5;
        private static const NUM_ITEMS_PER_PAGE:uint = 20;
        protected static const EXTERNAL_UI_BASE_NAME:String = "externalActionBar";
        private static const EXTERNAL_UI_VERTICAL_NAME:String = "externalActionBarVertical";
        private static var _shortcutColor:String;
        protected static var ITEMS_TAB:String = "items";
        protected static var SPELLS_TAB:String = "spells";

        [Api(name="BindsApi")]
        public var bindsApi:BindsApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="InventoryApi")]
        public var inventoryApi:InventoryApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="StorageApi")]
        public var storageApi:StorageApi;
        [Api(name="FightApi")]
        public var fightApi:FightApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var gd_spellitemotes:Grid;
        public var btn_tabSpells:ButtonContainer;
        public var btn_tabItems:ButtonContainer;
        public var ctr_changeNumber:GraphicContainer;
        public var btn_upArrow:ButtonContainer;
        public var btn_downArrow:ButtonContainer;
        public var btn_addActionBar:ButtonContainer;
        public var lbl_itemsNumber:Label;
        protected var _nPageItems:uint = 0;
        protected var _nPageSpells:uint = 0;
        protected var _sTabGrid:String;
        protected var _aSpells:*;
        private var _aItems:*;
        private var _itemToUseId:uint;
        private var _waitingObjectUID:uint;
        private var _waitingObjectPosition:uint;
        private var _buildSpellPreview:Boolean;
        private var _spellMovementAllowed:Boolean = false;
        private var _shortcutsMovementAllowed:Boolean = false;
        private var _altDown:Boolean = false;
        private var _isDragging:Boolean = false;
        private var _delayUseObject:Boolean = false;
        private var _delayUseObjectTimer:Timer;
        protected var isMainBar:Boolean = true;
        protected var isTemporisSpellsUi:Boolean = false;


        public function get nPageItems():uint
        {
            return (this._nPageItems);
        }

        public function get nPageSpells():uint
        {
            return (this._nPageSpells);
        }

        public function get sTabGrid():String
        {
            return (this._sTabGrid);
        }

        override public function main(args:Array):void
        {
            var i:int;
            super.main(args);
            this.isTemporisSpellsUi = this.dataApi.isTemporisSpellsUi();
            if ((((args) && (args.length)) && ((args[0] as ActionBarParameters).context)))
            {
                currentContext = (args[0] as ActionBarParameters).context;
            };
            sysApi.addHook(OpenInventory, this.onOpenInventory);
            sysApi.addHook(SwitchBannerTab, this.onSwitchBannerTab);
            sysApi.addHook(WeaponUpdate, this.onWeaponUpdate);
            sysApi.addHook(SpellMovementAllowed, this.onSpellMovementAllowed);
            sysApi.addHook(ShortcutsMovementAllowed, this.onShortcutsMovementAllowed);
            sysApi.addHook(PresetsUpdate, this.onPresetsUpdate);
            sysApi.addHook(PreviewBuildSpellBar, this.previewBuildShortcuts);
            sysApi.addHook(IdolsPresetDelete, this.onIdolsPresetDelete);
            sysApi.addHook(SlaveStatsList, this.onSlaveStatsList);
            sysApi.addHook(ShortcutBarViewContent, this.onShortcutBarViewContent);
            sysApi.addHook(DropStart, this.onDropStart);
            sysApi.addHook(DropEnd, this.onDropEnd);
            sysApi.addHook(CancelCastSpell, this.onCancelCastSpell);
            sysApi.addHook(CastSpellMode, this.onCastSpellMode);
            sysApi.addHook(SpellUpdate, this.onSpellUpdate);
            sysApi.addHook(KeyDown, this.onKeyDown);
            sysApi.addHook(KeyUp, this.onKeyUp);
            this.btn_upArrow.soundId = SoundEnum.SCROLL_DOWN;
            this.btn_downArrow.soundId = SoundEnum.SCROLL_UP;
            this.btn_tabSpells.soundId = SoundEnum.BANNER_SPELL_TAB;
            this.btn_tabItems.soundId = SoundEnum.BANNER_OBJECT_TAB;
            this.uiApi.addShortcutHook("cac", this.onShortcut);
            this.uiApi.addShortcutHook("s1", this.onShortcut);
            this.uiApi.addShortcutHook("s2", this.onShortcut);
            this.uiApi.addShortcutHook("s3", this.onShortcut);
            this.uiApi.addShortcutHook("s4", this.onShortcut);
            this.uiApi.addShortcutHook("s5", this.onShortcut);
            this.uiApi.addShortcutHook("s6", this.onShortcut);
            this.uiApi.addShortcutHook("s7", this.onShortcut);
            this.uiApi.addShortcutHook("s8", this.onShortcut);
            this.uiApi.addShortcutHook("s9", this.onShortcut);
            this.uiApi.addShortcutHook("s10", this.onShortcut);
            this.uiApi.addShortcutHook("s11", this.onShortcut);
            this.uiApi.addShortcutHook("s12", this.onShortcut);
            this.uiApi.addShortcutHook("s13", this.onShortcut);
            this.uiApi.addShortcutHook("s14", this.onShortcut);
            this.uiApi.addShortcutHook("s15", this.onShortcut);
            this.uiApi.addShortcutHook("s16", this.onShortcut);
            this.uiApi.addShortcutHook("s17", this.onShortcut);
            this.uiApi.addShortcutHook("s18", this.onShortcut);
            this.uiApi.addShortcutHook("s19", this.onShortcut);
            this.uiApi.addShortcutHook("s20", this.onShortcut);
            this.uiApi.addShortcutHook("bannerSpellsTab", this.onShortcut);
            this.uiApi.addShortcutHook("bannerItemsTab", this.onShortcut);
            this.uiApi.addShortcutHook("bannerPreviousTab", this.onShortcut);
            this.uiApi.addShortcutHook("bannerNextTab", this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_1, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_2, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_3, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_4, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_5, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_DOWN, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_UP, this.onShortcut);
            this.uiApi.addComponentHook(this.gd_spellitemotes, "onWheel");
            this.uiApi.addComponentHook(this.gd_spellitemotes, "onPress");
            this.uiApi.addComponentHook(this.btn_downArrow, "onRollOver");
            this.uiApi.addComponentHook(this.btn_downArrow, "onRollOut");
            this.uiApi.addComponentHook(this.btn_upArrow, "onRollOver");
            this.uiApi.addComponentHook(this.btn_upArrow, "onRollOut");
            this.uiApi.addComponentHook(this.btn_tabItems, "onRollOver");
            this.uiApi.addComponentHook(this.btn_tabItems, "onRollOut");
            this.uiApi.addComponentHook(this.btn_tabSpells, "onRollOver");
            this.uiApi.addComponentHook(this.btn_tabSpells, "onRollOut");
            this.uiApi.addComponentHook(this.btn_addActionBar, "onRollOver");
            this.uiApi.addComponentHook(this.btn_addActionBar, "onRollOut");
            this.uiApi.addComponentHook(this.ctr_changeNumber, "onWheel");
            this._aSpells = [];
            this._aItems = [];
            this.btn_upArrow.disabled = true;
            this._delayUseObjectTimer = new Timer(500, 1);
            this._delayUseObjectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayUseObjectTimer);
            this.gd_spellitemotes.autoSelectMode = 0;
            (this.gd_spellitemotes.renderer as SlotGridRenderer).dropValidatorFunction = this.dropValidator;
            (this.gd_spellitemotes.renderer as SlotGridRenderer).processDropFunction = this.processDrop;
            (this.gd_spellitemotes.renderer as SlotGridRenderer).removeDropSourceFunction = this.emptyFct;
            this.gd_spellitemotes.keyboardIndexHandler = this.onGridKeyDown;
            if (this.isMainBar)
            {
                mainBar = this;
                i = 0;
                while (i < externalActionBars.length)
                {
                    this.loadExternalActionBar(i);
                    i++;
                };
                sysApi.addHook(UiLoaded, this.onUiLoaded);
                sysApi.addHook(UiUnloaded, this.onUiUnloaded);
                this._nPageItems = sysApi.getData("bannerItemsPageIndex");
                if (this.getPlayerId() >= 0)
                {
                    this._nPageSpells = sysApi.getData(("bannerSpellsPageIndex" + this.getPlayerId()));
                }
                else
                {
                    this._nPageSpells = 0;
                };
                this.onShortcutBarViewContent(0);
                this.onShortcutBarViewContent(1);
                this.onContextChanged(currentContext);
            };
        }

        override protected function onContextChanged(context:String, previousContext:String="", contextChanged:Boolean=false):void
        {
            switch (context)
            {
                case ContextEnum.SPECTATOR:
                    this.gd_spellitemotes.disabled = true;
                    break;
                case ContextEnum.PREFIGHT:
                    this.gridDisplay(ITEMS_TAB, true);
                    break;
                case ContextEnum.FIGHT:
                    this.gridDisplay(SPELLS_TAB, true);
                    break;
                case ContextEnum.ROLEPLAY:
                    this.gridDisplay(ITEMS_TAB, true);
                    this.gd_spellitemotes.disabled = false;
                    break;
            };
        }

        private function loadExternalActionBar(pActionBarId:uint, pOrientationChanged:Boolean=false, pContext:String=null):void
        {
            var uiName:String = EXTERNAL_UI_BASE_NAME;
            var orientation:uint = ExternalActionBar.ORIENTATION_HORIZONTAL;
            var externalActionBarsState:* = sysApi.getData(this.dataKey, DataStoreEnum.BIND_CHARACTER);
            if ((((externalActionBarsState) && (externalActionBarsState[pActionBarId])) && (externalActionBarsState[pActionBarId].orientation == ExternalActionBar.ORIENTATION_VERTICAL)))
            {
                uiName = EXTERNAL_UI_VERTICAL_NAME;
                orientation = ExternalActionBar.ORIENTATION_VERTICAL;
            };
            this.uiApi.loadUi(uiName, ((EXTERNAL_UI_BASE_NAME + "_") + pActionBarId), [new ActionBarParameters(pActionBarId, orientation, pOrientationChanged, pContext)], StrataEnum.STRATA_TOP, null, true);
        }

        private function onUiLoaded(uiName:String):void
        {
            if (((uiName) && (uiName.indexOf(EXTERNAL_UI_BASE_NAME) == 0)))
            {
                this.btn_addActionBar.disabled = (!(this.canAddExternalActionBar()));
            };
        }

        private function onUiUnloaded(uiName:String):void
        {
            if (((uiName) && (uiName.indexOf(EXTERNAL_UI_BASE_NAME) == 0)))
            {
                this.btn_addActionBar.disabled = (!(this.canAddExternalActionBar()));
            };
        }

        public function reloadExternalActionBar(pActionBarId:uint, pContext:String):void
        {
            this.loadExternalActionBar(pActionBarId, true, pContext);
        }

        public function gridDisplay(tabStyle:String, forceRefresh:Boolean=false):void
        {
            var index:int;
            var dropAllEnabled:Boolean;
            if (currentContext == ContextEnum.ROLEPLAY)
            {
                dropAllEnabled = true;
            };
            if (((tabStyle == this._sTabGrid) && (!(forceRefresh))))
            {
                return;
            };
            var autoselect:* = (tabStyle == this._sTabGrid);
            this._sTabGrid = tabStyle;
            switch (tabStyle)
            {
                case SPELLS_TAB:
                    this.btn_tabSpells.visible = false;
                    this.btn_tabItems.visible = true;
                    (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = this._spellMovementAllowed;
                    this.updateGrid(this._aSpells, this._nPageSpells, autoselect);
                    this.lbl_itemsNumber.text = (this._nPageSpells + 1).toString();
                    index = this._nPageSpells;
                    break;
                case ITEMS_TAB:
                    this.btn_tabSpells.visible = true;
                    this.btn_tabItems.visible = false;
                    (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = ((dropAllEnabled) ? dropAllEnabled : this._shortcutsMovementAllowed);
                    this.updateGrid(this._aItems, this._nPageItems, autoselect);
                    this.lbl_itemsNumber.text = (this._nPageItems + 1).toString();
                    index = this._nPageItems;
                    break;
            };
            this.btn_upArrow.disabled = (index == 0);
            this.btn_downArrow.disabled = (index == (NUM_PAGES - 1));
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var data:Object;
            var tooltipMaker:String;
            var settings:Object;
            var setting:String;
            var itemTooltipSettings:ItemTooltipSettings;
            var cacheName:String;
            var text:String;
            var itemWrapper:ItemWrapper;
            var spellWrapper:SpellWrapper;
            var isWeapon:Boolean;
            var build:BuildWrapper;
            var iw:ItemWrapper;
            var ref:Object = this.uiApi.getUi(UIEnum.BANNER).getElement(((sysApi.isFightContext()) ? "tooltipFightPlacer" : "tooltipRoleplayPlacer"));
            var cte:String = "bannerActionBar::gd_spellitemotes::item";
            var nSlot:int = (int(item.container.name.substr(cte.length)) + 1);
            var shortcutKey:String = this.bindsApi.getShortcutBindStr(("s" + nSlot));
            if (!item.data)
            {
                return;
            };
            if (!_shortcutColor)
            {
                _shortcutColor = sysApi.getConfigEntry("colors.shortcut");
                _shortcutColor = _shortcutColor.replace("0x", "#");
            };
            if (target == this.gd_spellitemotes)
            {
                if (this._sTabGrid == ITEMS_TAB)
                {
                    cacheName = "TextInfo";
                    switch (item.data.type)
                    {
                        case TYPE_ITEM_WRAPPER:
                            itemWrapper = this.inventoryApi.getItem(item.data.id);
                            if (!itemWrapper)
                            {
                                itemWrapper = this.dataApi.getItemWrapper(item.data.gid);
                            };
                            data = this.tooltipApi.getItemTooltipInfo(itemWrapper, shortcutKey);
                            tooltipMaker = "itemName";
                            settings = {};
                            itemTooltipSettings = this.getItemTooltipSettings();
                            for each (setting in sysApi.getObjectVariables(itemTooltipSettings))
                            {
                                settings[setting] = itemTooltipSettings[setting];
                            };
                            settings.ref = ref;
                            cacheName = "ItemInfo";
                            break;
                        case TYPE_BUILD_WRAPPER:
                            if (!item.data.realItem)
                            {
                                return;
                            };
                            text = item.data.realItem.buildName;
                            if (((shortcutKey) && (!(shortcutKey == ""))))
                            {
                                text = (text + ((((" <font color='" + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
                            };
                            data = this.uiApi.textTooltipInfo(text);
                            break;
                        case TYPE_SMILEY_WRAPPER:
                            text = this.uiApi.getText("ui.banner.emote.tooltip");
                            if (((shortcutKey) && (!(shortcutKey == ""))))
                            {
                                text = (text + ((((" <font color='" + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
                            };
                            data = this.uiApi.textTooltipInfo(text);
                            break;
                        case TYPE_EMOTE_WRAPPER:
                            text = item.data.name;
                            if (((shortcutKey) && (!(shortcutKey == ""))))
                            {
                                text = (text + ((((" <font color='" + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
                            };
                            data = this.uiApi.textTooltipInfo(text);
                            tooltipMaker = "emoteName";
                            break;
                        case TYPE_IDOLS_PRESET_WRAPPER:
                            text = this.uiApi.getText("ui.idol.preset.tooltip", (item.data.id + 1));
                            if (((shortcutKey) && (!(shortcutKey == ""))))
                            {
                                text = (text + ((((" <font color='" + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
                            };
                            data = this.uiApi.textTooltipInfo(text);
                            break;
                        default:
                            if (((shortcutKey) && (!(shortcutKey == ""))))
                            {
                                text = ((((" <font color='" + _shortcutColor) + "'>(") + shortcutKey) + ")</font>");
                            }
                            else
                            {
                                return;
                            };
                            data = this.uiApi.textTooltipInfo(text);
                    };
                    this.uiApi.showTooltip(data, item.container, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPRIGHT, 0, tooltipMaker, null, settings, cacheName);
                }
                else
                {
                    if (this._sTabGrid == SPELLS_TAB)
                    {
                        if (!item.data.realItem)
                        {
                            return;
                        };
                        spellWrapper = this.dataApi.getSpellWrapper(item.data.id, item.data.realItem.spellLevel, true);
                        if (spellWrapper == null)
                        {
                            return;
                        };
                        if (this._buildSpellPreview)
                        {
                            for each (build in this.inventoryApi.getBuilds())
                            {
                                if (build.id == this.inventoryApi.getBuildId())
                                {
                                    break;
                                };
                            };
                            for each (iw in build.equipment)
                            {
                                if ((iw is WeaponWrapper))
                                {
                                    break;
                                };
                            };
                            if ((((item.data.realItem is WeaponWrapper) || ((item.data.realItem is SpellWrapper) && (item.data.realItem.isSpellWeapon))) && (iw is WeaponWrapper)))
                            {
                                settings = {};
                                itemTooltipSettings = this.getItemTooltipSettings();
                                for each (setting in sysApi.getObjectVariables(itemTooltipSettings))
                                {
                                    settings[setting] = itemTooltipSettings[setting];
                                };
                                settings.ref = ref;
                                data = this.tooltipApi.getWeaponTooltipInfo(spellWrapper, shortcutKey, settings, (iw as WeaponWrapper));
                                cacheName = "TtemInfo";
                            }
                            else
                            {
                                data = this.tooltipApi.getSpellTooltipInfo(spellWrapper, shortcutKey);
                                cacheName = "SpellBanner";
                            };
                        }
                        else
                        {
                            isWeapon = (((item.data.realItem is WeaponWrapper) || ((item.data.realItem is SpellWrapper) && (item.data.realItem.isSpellWeapon))) && (this.inventoryApi.getCurrentWeapon()));
                            if (isWeapon)
                            {
                                settings = {};
                                itemTooltipSettings = this.getItemTooltipSettings();
                                for each (setting in sysApi.getObjectVariables(itemTooltipSettings))
                                {
                                    settings[setting] = itemTooltipSettings[setting];
                                };
                                settings.ref = ref;
                                data = this.tooltipApi.getWeaponTooltipInfo(spellWrapper, shortcutKey, settings);
                                cacheName = "TtemInfo";
                            }
                            else
                            {
                                data = this.tooltipApi.getSpellTooltipInfo(spellWrapper, shortcutKey);
                                cacheName = "SpellBanner";
                            };
                        };
                        this.uiApi.showTooltip(data, item.container, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPRIGHT, 3, null, null, null, cacheName);
                    };
                };
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            var trueData:Object;
            var makercontentLength:uint;
            var disabled:Boolean;
            var spellContextMenu:Object;
            var itemTooltipSettings:Object;
            switch (this._sTabGrid)
            {
                case ITEMS_TAB:
                    data = item.data;
                    if (((data == null) || (data.realItem == null)))
                    {
                        return;
                    };
                    trueData = data.realItem;
                    contextMenu = this.menuApi.create(trueData, "item", [{"ownedItem":true}]);
                    makercontentLength = contextMenu.content.length;
                    disabled = false;
                    if ((((contextMenu) && (contextMenu.content)) && (contextMenu.content[0])))
                    {
                        disabled = contextMenu.content[0].disabled;
                    };
                    if ((((data.type == TYPE_ITEM_WRAPPER) && (data.targetable)) && (!(data.nonUsableOnAnother))))
                    {
                        contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.target"), this.onItemUseOnCell, [data.id], disabled));
                    };
                    if (((((data.usable) || (data.type == TYPE_BUILD_WRAPPER)) || (data.type == TYPE_SMILEY_WRAPPER)) || (data.type == TYPE_EMOTE_WRAPPER)))
                    {
                        if (((data.quantity > 1) && (data.isOkForMultiUse)))
                        {
                            contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.multipleUse"), this.useItemQuantity, [data.id, data.quantity], disabled));
                        };
                        contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.use"), this.useItem, [data.id, data.type], ((disabled) ? disabled : (!(data.active)))));
                    };
                    if (((data.type == TYPE_ITEM_WRAPPER) && (data.category == 0)))
                    {
                        contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.equip"), this.equipItem, [trueData], ((disabled) ? disabled : (!(data.active)))));
                    };
                    contextMenu.content.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.remove"), this.onRemoveItem, [data.slot], false));
                    if (((contextMenu.content.length) && (makercontentLength > 0)))
                    {
                        contextMenu.content.push(this.modContextMenu.createContextMenuSeparatorObject());
                    };
                    if ((((Api.system.getOption("displayTooltips", "dofus")) && (!(data.type == TYPE_BUILD_WRAPPER))) && (!(data.type == TYPE_IDOLS_PRESET_WRAPPER))))
                    {
                        itemTooltipSettings = this.getItemTooltipSettings();
                        contextMenu.content.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.tooltip"), null, null, false, [this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.name"), this.onItemTooltipDisplayOption, ["header"], disabled, null, itemTooltipSettings.header, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.processText(this.uiApi.getText("ui.common.effects"), "", false), this.onItemTooltipDisplayOption, ["effects"], disabled, null, itemTooltipSettings.effects, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.conditions"), this.onItemTooltipDisplayOption, ["conditions"], disabled, null, itemTooltipSettings.conditions, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.description"), this.onItemTooltipDisplayOption, ["description"], disabled, null, itemTooltipSettings.description, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.item.averageprice"), this.onItemTooltipDisplayOption, ["averagePrice"], disabled, null, itemTooltipSettings.averagePrice, false)], disabled));
                    };
                    if (contextMenu.content.length > 0)
                    {
                        this.modContextMenu.createContextMenu(contextMenu);
                    };
                    break;
                case SPELLS_TAB:
                    this.uiApi.hideTooltip();
                    this.uiApi.hideTooltip("spellBanner");
                    data = item.data;
                    if (data == null)
                    {
                        return;
                    };
                    spellContextMenu = this.menuApi.create(data.realItem, "spell", [{"replaceByOtherSpell":true}]);
                    spellContextMenu.content.push(this.modContextMenu.createContextMenuSeparatorObject(), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.remove"), this.onRemoveSpell, [data.slot], false));
                    this.modContextMenu.createContextMenu(spellContextMenu);
                    break;
            };
        }

        public function onItemUseOnCell(id:uint):void
        {
            if (((!(this._delayUseObject)) && (id)))
            {
                sysApi.sendAction(new ObjectUse(id, 1, true));
            };
        }

        public function useItem(id:uint, shortcutType:uint=0):void
        {
            if (!this._delayUseObject)
            {
                if (shortcutType == TYPE_BUILD_WRAPPER)
                {
                    sysApi.sendAction(new PresetUseRequest(id));
                }
                else
                {
                    if (shortcutType == TYPE_SMILEY_WRAPPER)
                    {
                        sysApi.sendAction(new ChatSmileyRequest(id));
                    }
                    else
                    {
                        if (shortcutType == TYPE_EMOTE_WRAPPER)
                        {
                            sysApi.sendAction(new EmotePlayRequest(id));
                        }
                        else
                        {
                            if (shortcutType == TYPE_IDOLS_PRESET_WRAPPER)
                            {
                                sysApi.sendAction(new PresetUseRequest(id));
                            }
                            else
                            {
                                this._delayUseObjectTimer.start();
                                sysApi.sendAction(new ObjectUse(id, 1, false));
                            };
                        };
                    };
                };
            };
        }

        public function useItemQuantity(id:uint, qtyMax:uint=1):void
        {
            if (!this._delayUseObject)
            {
                this._itemToUseId = id;
                this.modCommon.openQuantityPopup(1, qtyMax, 1, this.onValidItemQuantityUse);
            };
        }

        public function onValidItemQuantityUse(qty:Number):void
        {
            this._delayUseObjectTimer.start();
            sysApi.sendAction(new ObjectUse(this._itemToUseId, qty, false));
            this._itemToUseId = 0;
        }

        public function onDelayUseObjectTimer(e:TimerEvent):void
        {
            this._delayUseObjectTimer.reset();
            this._delayUseObject = false;
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
            this.uiApi.hideTooltip("spellBanner");
        }

        public function onWheel(target:Object, delta:int):void
        {
            if (delta > 0)
            {
                this.pageItemUp();
            }
            else
            {
                this.pageItemDown();
            };
        }

        protected function getPlayerId():Number
        {
            if (this.playerApi.isInFight())
            {
                return (this.fightApi.getCurrentPlayedFighterId());
            };
            return (this.playerApi.id());
        }

        private function onGridKeyDown(oldIndex:int, newIndex:int):int
        {
            var numPage:uint = ((this._sTabGrid == ITEMS_TAB) ? this._nPageItems : this._nPageSpells);
            var index:int = newIndex;
            if (newIndex < 0)
            {
                if (numPage > 0)
                {
                    this.pageItemUp();
                    index = ((newIndex == -1) ? (NUM_ITEMS_PER_PAGE - 1) : (oldIndex + this.gd_spellitemotes.slotByRow));
                };
            }
            else
            {
                if (newIndex > (NUM_ITEMS_PER_PAGE - 1))
                {
                    this.pageItemDown();
                    if (numPage < (NUM_PAGES - 1))
                    {
                        index = ((newIndex == NUM_ITEMS_PER_PAGE) ? 0 : (oldIndex - this.gd_spellitemotes.slotByRow));
                    }
                    else
                    {
                        index = oldIndex;
                    };
                };
            };
            return (index);
        }

        private function getItemTooltipSettings():ItemTooltipSettings
        {
            var itemTooltipSettings:ItemTooltipSettings = (sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
            if (itemTooltipSettings == null)
            {
                itemTooltipSettings = this.tooltipApi.createItemSettings();
                this.setItemTooltipSettings(itemTooltipSettings);
            };
            return (itemTooltipSettings);
        }

        private function setItemTooltipSettings(val:ItemTooltipSettings):Boolean
        {
            return (sysApi.setData("itemTooltipSettings", val, DataStoreEnum.BIND_ACCOUNT));
        }

        private function onIdolsPresetDelete(pPresetId:uint):void
        {
            var shortcut:Object;
            for each (shortcut in this._aItems)
            {
                if ((((shortcut) && (shortcut.type == TYPE_IDOLS_PRESET_WRAPPER)) && (shortcut.id == pPresetId)))
                {
                    this.onRemoveItem(shortcut.slot);
                    break;
                };
            };
        }

        public function unselectSpell():void
        {
            if (this.fightApi.isCastingSpell())
            {
                this.fightApi.cancelSpell();
            };
        }

        protected function displayPage():void
        {
            var index:int;
            if (this._sTabGrid == ITEMS_TAB)
            {
                index = this._nPageItems;
                sysApi.setData("bannerItemsPageIndex", this._nPageItems);
            }
            else
            {
                if (this._sTabGrid == SPELLS_TAB)
                {
                    index = this._nPageSpells;
                    if (((this.getPlayerId() >= 0) && (!(this.fightApi.isSlaveContext()))))
                    {
                        sysApi.setData(("bannerSpellsPageIndex" + this.getPlayerId()), this._nPageSpells);
                    };
                };
            };
            this.lbl_itemsNumber.text = (index + 1).toString();
            this.btn_upArrow.disabled = (index == 0);
            this.btn_downArrow.disabled = (index == (NUM_PAGES - 1));
        }

        private function pageItem(page:int):void
        {
            if (((page < NUM_PAGES) && (page >= 0)))
            {
                switch (this._sTabGrid)
                {
                    case ITEMS_TAB:
                        this._nPageItems = page;
                        this.updateGrid(this._aItems, this._nPageItems, false);
                        break;
                    case SPELLS_TAB:
                        this._nPageSpells = page;
                        this.updateGrid(this._aSpells, this._nPageSpells, false);
                        break;
                };
                this.displayPage();
            };
        }

        private function pageItemDown():void
        {
            switch (this._sTabGrid)
            {
                case ITEMS_TAB:
                    if (this._nPageItems < (NUM_PAGES - 1))
                    {
                        this._nPageItems++;
                        this.updateGrid(this._aItems, this._nPageItems, false);
                        this.displayPage();
                    };
                    break;
                case SPELLS_TAB:
                    if (this._nPageSpells < (NUM_PAGES - 1))
                    {
                        this._nPageSpells++;
                        this.updateGrid(this._aSpells, this._nPageSpells, false);
                        this.displayPage();
                    };
                    break;
            };
        }

        private function pageItemUp():void
        {
            switch (this._sTabGrid)
            {
                case ITEMS_TAB:
                    if (this._nPageItems > 0)
                    {
                        this._nPageItems--;
                        this.updateGrid(this._aItems, this._nPageItems, false);
                        this.displayPage();
                    };
                    break;
                case SPELLS_TAB:
                    if (this._nPageSpells > 0)
                    {
                        this._nPageSpells--;
                        this.updateGrid(this._aSpells, this._nPageSpells, false);
                        this.displayPage();
                    };
                    break;
            };
        }

        protected function removeTemporisSpell(spellId:int, index:int):void
        {
            var currentIndex:uint;
            var areDuplicates:Boolean;
            var currentShortcutWrapper:ShortcutWrapper;
            var currentSpellWrapper:SpellWrapper;
            currentIndex = 0;
            while (currentIndex < this._aSpells.length)
            {
                currentShortcutWrapper = this._aSpells[currentIndex];
                if (currentShortcutWrapper === null)
                {
                }
                else
                {
                    currentSpellWrapper = (currentShortcutWrapper.realItem as SpellWrapper);
                    if (currentSpellWrapper === null)
                    {
                    }
                    else
                    {
                        if (((!(currentIndex === index)) && (currentSpellWrapper.spellId === spellId)))
                        {
                            areDuplicates = true;
                            break;
                        };
                    };
                };
                currentIndex++;
            };
            if (areDuplicates)
            {
                sysApi.sendAction(new ShortcutBarRemoveRequest(ShortcutBarEnum.SPELL_SHORTCUT_BAR, index));
            }
            else
            {
                sysApi.sendAction(new ForgettableSpellClientAction(spellId, ForgettableSpellClientActionEnum.FORGETTABLE_SPELL_UNEQUIP));
            };
        }

        private function onRemoveSpell(index:int):void
        {
            var spellId:int;
            var isTemporisSpell:Boolean;
            if (((this.isTemporisSpellsUi) && (this._sTabGrid === SPELLS_TAB)))
            {
                spellId = this._aSpells[index].realItem.spellId;
                isTemporisSpell = this.playerApi.isForgettableSpell(spellId);
                if (isTemporisSpell)
                {
                    this.removeTemporisSpell(spellId, index);
                    return;
                };
            };
            sysApi.sendAction(new ShortcutBarRemoveRequest(1, index));
        }

        private function onRemoveItem(index:int):void
        {
            var shortcutWrapper:ShortcutWrapper;
            var spellWrapper:SpellWrapper;
            var spellId:int;
            var isTemporisSpell:Boolean;
            if ((((this.isTemporisSpellsUi) && (this._aSpells[index] is ShortcutWrapper)) && (this._sTabGrid === SPELLS_TAB)))
            {
                shortcutWrapper = this._aSpells[index];
                if ((shortcutWrapper.realItem is SpellWrapper))
                {
                    spellWrapper = (shortcutWrapper.realItem as SpellWrapper);
                    spellId = spellWrapper.spellId;
                    isTemporisSpell = this.playerApi.isForgettableSpell(spellId);
                    if (isTemporisSpell)
                    {
                        this.removeTemporisSpell(spellId, index);
                        return;
                    };
                };
            };
            sysApi.sendAction(new ShortcutBarRemoveRequest(0, index));
        }

        private function onKeyDown(target:Object, keyCode:uint):void
        {
            if (keyCode == Keyboard.ALTERNATE)
            {
                this._altDown = true;
            };
            if ((((!(this._isDragging)) && (keyCode == Keyboard.ALTERNATE)) && ((!(sysApi.isFightContext())) || (this.fightApi.getCurrentPlayedFighterId() == this.playerApi.id()))))
            {
                if (this._sTabGrid == SPELLS_TAB)
                {
                    this._isDragging = true;
                    (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = ((this._spellMovementAllowed) || (this._altDown));
                    if (!this._buildSpellPreview)
                    {
                        this.updateGrid(this._aSpells, this._nPageSpells);
                    };
                };
            };
        }

        private function onKeyUp(target:Object, keyCode:uint):void
        {
            if (keyCode == Keyboard.ALTERNATE)
            {
                this._altDown = false;
            };
            if (((keyCode == Keyboard.ALTERNATE) && ((!(sysApi.isFightContext())) || (this.fightApi.getCurrentPlayedFighterId() == this.playerApi.id()))))
            {
                if (this._sTabGrid == SPELLS_TAB)
                {
                    this._isDragging = false;
                    (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = ((this._spellMovementAllowed) || (this._altDown));
                    if (!this._buildSpellPreview)
                    {
                        this.updateGrid(this._aSpells, this._nPageSpells);
                    };
                };
            };
        }

        private function onSpellMovementAllowed(state:Boolean):void
        {
            this._spellMovementAllowed = state;
            if (!state)
            {
                this._altDown = false;
            };
            if (this._sTabGrid == SPELLS_TAB)
            {
                (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = ((this._spellMovementAllowed) || (this._altDown));
                if (!this._buildSpellPreview)
                {
                    this.updateGrid(this._aSpells, this._nPageSpells);
                };
            };
        }

        private function onShortcutsMovementAllowed(state:Boolean):void
        {
            this._shortcutsMovementAllowed = state;
            if (this._sTabGrid == ITEMS_TAB)
            {
                (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = state;
                this.updateGrid(this._aItems, this._nPageItems);
            };
        }

        private function onPresetsUpdate(buildId:int=-1):void
        {
            if (this._sTabGrid == ITEMS_TAB)
            {
                this._aItems = this.storageApi.getShortcutBarContent(0);
                this.updateGrid(this._aItems, this._nPageItems);
            };
        }

        private function onWeaponUpdate():void
        {
            if (this._sTabGrid == SPELLS_TAB)
            {
                this.gridDisplay(this._sTabGrid, true);
            };
        }

        protected function onSwitchBannerTab(tabName:String):void
        {
            this.gridDisplay(tabName);
        }

        public function onOpenSpellBook():void
        {
            this.gridDisplay(SPELLS_TAB);
        }

        public function onOpenInventory(... args):void
        {
            if (!this.playerApi.isInFight())
            {
                this.gridDisplay(ITEMS_TAB);
            };
        }

        public function onShortcut(s:String):Boolean
        {
            var spellIndex:uint;
            switch (s)
            {
                case "cac":
                    if (((sysApi.isFightContext()) && (this.playerApi.canCastThisSpell(0, 1))))
                    {
                        sysApi.sendAction(new GameFightSpellCast(0, -1));
                    };
                    return (true);
                case "s1":
                case "s2":
                case "s3":
                case "s4":
                case "s5":
                case "s6":
                case "s7":
                case "s8":
                case "s9":
                case "s10":
                case "s11":
                case "s12":
                case "s13":
                case "s14":
                case "s15":
                case "s16":
                case "s17":
                case "s18":
                case "s19":
                case "s20":
                    if (((!(this.uiApi.getUi("passwordMenu"))) && (!(this.inventoryApi.removeSelectedItem()))))
                    {
                        spellIndex = (parseInt(s.substr(1)) - 1);
                        this.gd_spellitemotes.selectedIndex = spellIndex;
                    };
                    return (true);
                case "bannerSpellsTab":
                    this.gridDisplay(SPELLS_TAB);
                    return (true);
                case "bannerItemsTab":
                    this.gridDisplay(ITEMS_TAB);
                    return (true);
                case "bannerNextTab":
                    this.pageItemDown();
                    return (true);
                case "bannerPreviousTab":
                    this.pageItemUp();
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_1:
                    this.pageItem(0);
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_2:
                    this.pageItem(1);
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_3:
                    this.pageItem(2);
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_4:
                    this.pageItem(3);
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_5:
                    this.pageItem(4);
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_DOWN:
                    this.pageItemDown();
                    return (true);
                case ShortcutHookListEnum.PAGE_ITEM_UP:
                    this.pageItemUp();
                    return (true);
            };
            return (false);
        }

        private function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            var isValid:Boolean;
            var shortcutWrapper:ShortcutWrapper;
            if (!data)
            {
                return (false);
            };
            var sourceSlot:Slot = (source as Slot);
            var targetSlot:Slot = (target as Slot);
            var sourceGrid:Grid = (sourceSlot.getParent() as Grid);
            if (((sourceGrid) && (sourceGrid === (targetSlot.getParent() as Grid))))
            {
                if ((data is ShortcutWrapper))
                {
                    isValid = false;
                    for each (shortcutWrapper in this.gd_spellitemotes.dataProvider)
                    {
                        if (((shortcutWrapper) && (shortcutWrapper.id === data.id)))
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
            };
            switch (this._sTabGrid)
            {
                case SPELLS_TAB:
                    return ((data is SpellWrapper) || (data is ShortcutWrapper));
                case ITEMS_TAB:
                    return ((((((data is ItemWrapper) || (data is BuildWrapper)) || (data is IdolsPresetWrapper)) || (data is EmoteWrapper)) || (data is SmileyWrapper)) || (data is ShortcutWrapper));
            };
            return (false);
        }

        private function processDrop(target:Object, data:Object, source:Object):void
        {
            var currentSpell:SpellWrapper;
            if (this.dropValidator(target, data, source))
            {
                switch (this._sTabGrid)
                {
                    case SPELLS_TAB:
                        if ((data is ShortcutWrapper))
                        {
                            sysApi.sendAction(new ShortcutBarSwapRequest(1, data.slot, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageSpells * NUM_ITEMS_PER_PAGE))));
                        }
                        else
                        {
                            if ((((target.data) && (target.data is ShortcutWrapper)) && (target.data.realItem is SpellWrapper)))
                            {
                                currentSpell = (target.data.realItem as SpellWrapper);
                                if (currentSpell.id == data.id)
                                {
                                    break;
                                };
                            };
                            if (!this.playerApi.isForgettableSpellAvailable(data.id))
                            {
                                sysApi.sendAction(new ForgettableSpellClientAction(data.id, ForgettableSpellClientActionEnum.FORGETTABLE_SPELL_EQUIP));
                            };
                            sysApi.sendAction(new ShortcutBarAddRequest(2, data.id, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageSpells * NUM_ITEMS_PER_PAGE))));
                        };
                        break;
                    case ITEMS_TAB:
                        if ((data is ShortcutWrapper))
                        {
                            sysApi.sendAction(new ShortcutBarSwapRequest(0, data.slot, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                        }
                        else
                        {
                            if ((data is IdolsPresetWrapper))
                            {
                                sysApi.sendAction(new ShortcutBarAddRequest(5, data.id, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                            }
                            else
                            {
                                if ((data is BuildWrapper))
                                {
                                    sysApi.sendAction(new ShortcutBarAddRequest(1, data.id, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                                }
                                else
                                {
                                    if ((data is EmoteWrapper))
                                    {
                                        sysApi.sendAction(new ShortcutBarAddRequest(4, data.id, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                                    }
                                    else
                                    {
                                        if ((data is SmileyWrapper))
                                        {
                                            sysApi.sendAction(new ShortcutBarAddRequest(3, data.id, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                                        }
                                        else
                                        {
                                            sysApi.sendAction(new ShortcutBarAddRequest(0, data.objectUID, (this.gd_spellitemotes.getItemIndex(target) + (this._nPageItems * NUM_ITEMS_PER_PAGE))));
                                        };
                                    };
                                };
                            };
                        };
                        break;
                };
            };
        }

        private function onValidQty(qty:Number):void
        {
            if (qty <= 0)
            {
                return;
            };
            sysApi.sendAction(new ObjectSetPosition(this._waitingObjectUID, this._waitingObjectPosition, qty));
        }

        protected function updateGrid(items:*, page:uint, autoSelect:Boolean=true):void
        {
            var item:Object;
            var i:uint;
            var dp:Array = [];
            for each (item in items)
            {
                if (item)
                {
                    dp[(item.slot - (page * NUM_ITEMS_PER_PAGE))] = item;
                };
            };
            i = 0;
            while (i < (NUM_PAGES * NUM_ITEMS_PER_PAGE))
            {
                if (!dp[i])
                {
                    dp[i] = null;
                };
                i++;
            };
            this.gd_spellitemotes.dataProvider = dp;
            if (!autoSelect)
            {
                this.unselectSpell();
            };
        }

        protected function onSpellUpdate(spell:Object):void
        {
            var dp:Array;
            var spel:Object;
            if (this._sTabGrid == SPELLS_TAB)
            {
                dp = [];
                for each (spel in this._aSpells)
                {
                    if (spel)
                    {
                        dp[(spel.slot - (this._nPageSpells * NUM_ITEMS_PER_PAGE))] = spel;
                        if (spel.id == spell.id)
                        {
                            dp[(spel.slot - (this._nPageSpells * NUM_ITEMS_PER_PAGE))].active = spell.active;
                        };
                    };
                };
                this.gd_spellitemotes.dataProvider = dp;
            };
        }

        private function emptyFct(... args):void
        {
        }

        protected function onShortcutBarViewContent(barType:int):void
        {
            if (barType == 0)
            {
                this._aItems = this.storageApi.getShortcutBarContent(barType);
                if (this._sTabGrid == ITEMS_TAB)
                {
                    this.updateGrid(this._aItems, this._nPageItems);
                };
            }
            else
            {
                if (((barType == 1) && ((!(this.fightApi.isSlaveContext())) || (this.isMainBar))))
                {
                    this.updateSpellShortcuts();
                };
            };
        }

        protected function updateSpellShortcuts():void
        {
            if (this._buildSpellPreview)
            {
                return;
            };
            this._aSpells = this.storageApi.getShortcutBarContent(1);
            var olNPage:int = this._nPageSpells;
            if (this.fightApi.isSlaveContext())
            {
                this._nPageSpells = 0;
            }
            else
            {
                this._nPageSpells = sysApi.getData(("bannerSpellsPageIndex" + this.getPlayerId()));
            };
            if (olNPage != this._nPageSpells)
            {
                this.displayPage();
            };
            if (this._sTabGrid == SPELLS_TAB)
            {
                this.updateGrid(this._aSpells, this._nPageSpells);
            };
        }

        public function previewBuildShortcuts(spells:*, preview:Boolean):void
        {
            this._buildSpellPreview = preview;
            this._aSpells = spells;
            var olNPage:int = this._nPageSpells;
            if (this.fightApi.isSlaveContext())
            {
                this._nPageSpells = 0;
            }
            else
            {
                this._nPageSpells = sysApi.getData(("bannerSpellsPageIndex" + this.getPlayerId()));
            };
            if (olNPage != this._nPageSpells)
            {
                this.displayPage();
            };
            this.gridDisplay(SPELLS_TAB, true);
            this.gd_spellitemotes.softDisabled = preview;
        }

        public function onSlaveStatsList(charac:Object):void
        {
            if (this.isMainBar)
            {
                this.gridDisplay(SPELLS_TAB);
                if (!this._buildSpellPreview)
                {
                    this.updateGrid(this._aSpells, this._nPageSpells);
                };
            };
        }

        public function unload():void
        {
            sysApi.removeHook(UiUnloaded);
            this._delayUseObjectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayUseObjectTimer);
            this._delayUseObjectTimer.stop();
            this.uiApi.setFollowCursorUri(null);
        }

        public function onCancelCastSpell(spellWrapper:Object):void
        {
            this.uiApi.setFollowCursorUri(null);
        }

        public function onCastSpellMode(spellWrapper:Object):void
        {
            this.uiApi.setFollowCursorUri(spellWrapper.iconUri, false, false, 15, 15, 0.75);
        }

        private function onItemTooltipDisplayOption(field:String):void
        {
            var itemTooltipSettings:ItemTooltipSettings = this.getItemTooltipSettings();
            itemTooltipSettings[field] = (!(itemTooltipSettings[field]));
            this.setItemTooltipSettings(itemTooltipSettings);
        }

        private function onDropStart(src:Object):void
        {
            if (src.getUi() == this.uiApi.me())
            {
                sysApi.disableWorldInteraction();
            };
        }

        private function onDropEnd(src:Object, target:Object):void
        {
            if (((src.getUi() == this.uiApi.me()) && (!(this.uiApi.getUi(UIEnum.GRIMOIRE)))))
            {
                sysApi.enableWorldInteraction();
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _spellShortcut:ShortcutWrapper;
            var spellCastResult:String;
            var item:Object;
            switch (target)
            {
                case this.gd_spellitemotes:
                    switch (this._sTabGrid)
                    {
                        case SPELLS_TAB:
                            _spellShortcut = target.selectedItem;
                            if (_spellShortcut)
                            {
                                if ((((sysApi.isFightContext()) && (this.uiApi.keyIsDown(Keyboard.ALTERNATE))) && (_spellShortcut.realItem)))
                                {
                                    spellCastResult = this.playerApi.canCastThisSpellWithResult((_spellShortcut.realItem as SpellWrapper).spellId, (_spellShortcut.realItem as SpellWrapper).spellLevel);
                                    sysApi.sendAction(new ChatTextOutput(spellCastResult, ChatActivableChannelsEnum.CHANNEL_TEAM, null, null));
                                }
                                else
                                {
                                    if (selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
                                    {
                                        if (this.dataApi.isTemporisSpellsUi())
                                        {
                                            sysApi.sendAction(new OpenTemporisSpellsUi());
                                        }
                                        else
                                        {
                                            sysApi.dispatchHook(OpenSpellInterface, _spellShortcut.id);
                                        };
                                    }
                                    else
                                    {
                                        if (target.selectedItem.active)
                                        {
                                            sysApi.sendAction(new GameFightSpellCast(_spellShortcut.id, (this.gd_spellitemotes.selectedIndex + 1)));
                                        };
                                    };
                                };
                            }
                            else
                            {
                                if (sysApi.isFightContext())
                                {
                                    sysApi.sendAction(new BannerEmptySlotClick());
                                };
                            };
                            break;
                        case ITEMS_TAB:
                            if (((!(target.selectedItem)) || (!(target.selectedItem.active))))
                            {
                                break;
                            };
                            if (((((target.selectedItem.type == TYPE_BUILD_WRAPPER) || (target.selectedItem.type == TYPE_SMILEY_WRAPPER)) || (target.selectedItem.type == TYPE_EMOTE_WRAPPER)) || (target.selectedItem.type == TYPE_IDOLS_PRESET_WRAPPER)))
                            {
                                if (((selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK) || (selectMethod == GridItemSelectMethodEnum.MANUAL)))
                                {
                                    this.useItem(target.selectedItem.id, target.selectedItem.type);
                                };
                            }
                            else
                            {
                                item = this.inventoryApi.getItem(target.selectedItem.id);
                                if (!item)
                                {
                                    break;
                                };
                                if (selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
                                {
                                    if (item.usable)
                                    {
                                        this.useItem(target.selectedItem.id);
                                    }
                                    else
                                    {
                                        if (((item.hasOwnProperty("isCertificate")) && (item.isCertificate)))
                                        {
                                            sysApi.sendAction(new MountInfoRequest(item));
                                        };
                                    };
                                }
                                else
                                {
                                    if (selectMethod == GridItemSelectMethodEnum.CLICK)
                                    {
                                        if (((item.targetable) && (!(this.uiApi.keyIsDown(Keyboard.SHIFT)))))
                                        {
                                            this.onItemUseOnCell(target.selectedItem.id);
                                        };
                                        sysApi.dispatchHook(ObjectSelected, item);
                                    }
                                    else
                                    {
                                        if (selectMethod == GridItemSelectMethodEnum.MANUAL)
                                        {
                                            if (item.targetable)
                                            {
                                                this.onItemUseOnCell(target.selectedItem.id);
                                            }
                                            else
                                            {
                                                if (item.usable)
                                                {
                                                    this.useItem(target.selectedItem.id);
                                                };
                                            };
                                        };
                                    };
                                };
                                if (((item.category == 0) && ((selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK) || (selectMethod == GridItemSelectMethodEnum.MANUAL))))
                                {
                                    this.equipItem(item);
                                };
                                if (((((!(item.category == 0)) && (!(item.usable))) && (!(item.targetable))) && (item.typeId == DataEnum.ITEM_TYPE_IDOLS)))
                                {
                                    sysApi.sendAction(new OpenIdols());
                                };
                            };
                            break;
                    };
                    break;
            };
        }

        public function equipItem(item:Object):void
        {
            var freeSlot:int;
            var equipment:Object;
            var itemEquiped:Object;
            var uid:int = item.objectUID;
            if ((((item.position <= CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD) || (item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY)) || (item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME)))
            {
                freeSlot = CharacterInventoryPositionEnum.INVENTORY_POSITION_NOT_EQUIPED;
            }
            else
            {
                freeSlot = this.storageApi.getBestEquipablePosition(item);
                if (item.quantity > 1)
                {
                    equipment = this.storageApi.getViewContent("equipment");
                    for each (itemEquiped in equipment)
                    {
                        if ((((itemEquiped) && (itemEquiped.position == freeSlot)) && (itemEquiped.objectGID == item.objectGID)))
                        {
                            freeSlot = CharacterInventoryPositionEnum.INVENTORY_POSITION_NOT_EQUIPED;
                            uid = itemEquiped.objectUID;
                        };
                    };
                };
            };
            if (freeSlot > -1)
            {
                sysApi.sendAction(new ObjectSetPosition(uid, freeSlot, 1));
            };
        }

        public function onPress(target:Object):void
        {
            switch (target)
            {
                case this.gd_spellitemotes:
                    this.uiApi.hideTooltip();
                    break;
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_tabItems:
                    this.gridDisplay(ITEMS_TAB);
                    break;
                case this.btn_tabSpells:
                    this.gridDisplay(SPELLS_TAB);
                    break;
                case this.btn_upArrow:
                    this.pageItemUp();
                    break;
                case this.btn_downArrow:
                    this.pageItemDown();
                    break;
                case this.btn_addActionBar:
                    this.addNewActionBar();
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var textKey:String;
            var data:Object;
            var point:uint = 7;
            var relPoint:uint = 1;
            var shortcutKey:String;
            switch (target)
            {
                case this.btn_tabSpells:
                    tooltipText = this.uiApi.getText("ui.charcrea.spells");
                    shortcutKey = this.bindsApi.getShortcutBindStr("bannerSpellsTab");
                    break;
                case this.btn_tabItems:
                    tooltipText = this.uiApi.getText("ui.common.objects");
                    shortcutKey = this.bindsApi.getShortcutBindStr("bannerItemsTab");
                    break;
                case this.btn_upArrow:
                    tooltipText = this.uiApi.getText("ui.common.prevPage");
                    shortcutKey = this.bindsApi.getShortcutBindStr("pageItemUp");
                    break;
                case this.btn_downArrow:
                    point = 1;
                    relPoint = 7;
                    tooltipText = this.uiApi.getText("ui.common.nextPage");
                    shortcutKey = this.bindsApi.getShortcutBindStr("pageItemDown");
                    break;
                case this.btn_addActionBar:
                    tooltipText = this.uiApi.getText("ui.banner.addActionBar");
                    break;
            };
            if (shortcutKey)
            {
                if (!_shortcutColor)
                {
                    _shortcutColor = sysApi.getConfigEntry("colors.shortcut");
                    _shortcutColor = _shortcutColor.replace("0x", "#");
                };
                if (tooltipText)
                {
                    data = this.uiApi.textTooltipInfo((((((tooltipText + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"));
                }
                else
                {
                    if (textKey)
                    {
                        data = this.uiApi.textTooltipInfo(this.uiApi.getText(textKey, (((("<font color='" + _shortcutColor) + "'>(") + shortcutKey) + ")</font>")));
                    };
                };
            }
            else
            {
                data = this.uiApi.textTooltipInfo(tooltipText);
            };
            this.uiApi.showTooltip(data, target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        protected function addNewActionBar(id:int=-1):void
        {
            var bar:*;
            var barToDisplay:* = null;
            var totalAvailableBars:uint;
            for each (bar in externalActionBars)
            {
                if (!bar.mainCtr.visible)
                {
                    totalAvailableBars++;
                    if (!barToDisplay)
                    {
                        barToDisplay = bar;
                    };
                };
            };
            if (barToDisplay)
            {
                if (barToDisplay.orientation == ExternalActionBar.ORIENTATION_VERTICAL)
                {
                    this.reloadExternalActionBar(barToDisplay.actionBarId, currentContext);
                    return;
                };
                barToDisplay.show();
            };
            this.btn_addActionBar.disabled = (totalAvailableBars < 2);
        }

        protected function canAddExternalActionBar():Boolean
        {
            var bar:*;
            for each (bar in externalActionBars)
            {
                if (((!(bar)) || (!(bar.mainCtr.visible))))
                {
                    return (true);
                };
            };
            return (false);
        }

        protected function get dataKey():String
        {
            var contextKey:String = ((currentContext == ContextEnum.ROLEPLAY) ? "rp" : "fight");
            return ((((EXTERNAL_UI_BASE_NAME + "StateData_") + contextKey) + "_") + this.playerApi.id());
        }


    }
} Ankama_GameUiCore.ui

