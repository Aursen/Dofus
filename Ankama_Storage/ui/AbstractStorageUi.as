package Ankama_Storage.ui
{
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.StorageApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.AveragePricesApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.MapApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.dofus.uiApi.RoleplayApi;
    import flash.utils.Timer;
    import Ankama_Storage.ui.behavior.IStorageBehavior;
    import __AS3__.vec.Vector;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Input;
    import d2hooks.KeyUp;
    import d2hooks.DropStart;
    import d2hooks.DropEnd;
    import d2enums.ComponentHookList;
    import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import Ankama_Storage.Api;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
    import com.ankamagames.berilia.types.LocationEnum;
    import Ankama_Storage.ui.enum.StorageState;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
    import flash.geom.Point;
    import Ankama_Storage.util.StorageBehaviorManager;
    import d2hooks.UiLoaded;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import __AS3__.vec.*;

    public class AbstractStorageUi 
    {

        public static const SUBFILTER_ID_TOKEN:int = 148;
        public static const SUBFILTER_ID_PRECIOUS_STONE:int = 50;
        protected static const SORT_ON_NONE:int = -1;
        protected static const SORT_ON_DEFAULT:int = 0;
        protected static const SORT_ON_NAME:int = 1;
        protected static const SORT_ON_WEIGHT:int = 2;
        protected static const SORT_ON_QTY:int = 3;
        protected static const SORT_ON_LOT_WEIGHT:int = 4;
        protected static const SORT_ON_AVERAGEPRICE:int = 5;
        protected static const SORT_ON_LOT_AVERAGEPRICE:int = 6;
        protected static const SORT_ON_LEVEL:int = 7;
        protected static const SORT_ON_ITEM_TYPE:int = 8;
        protected static var _tabFilter:Dictionary = new Dictionary();

        private const CTR_KAMAS_ON_WARNING_X_POS:int = 100;
        private const CTR_KAMAS_X_POS:int = 126;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="StorageApi")]
        public var storageApi:StorageApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="AveragePricesApi")]
        public var averagePricesApi:AveragePricesApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="MapApi")]
        public var mapApi:MapApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Api(name="RoleplayApi")]
        public var rpApi:RoleplayApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var INPUT_SEARCH_DEFAULT_TEXT:String;
        private var _inventoryItems:Object;
        private var _currentCategoryFilter:int;
        private var _updateInventoryTimer:Timer;
        private var _delayUseObject:Boolean = false;
        private var _delayUseObjectTimer:Timer;
        private var _hasWorldInteraction:Boolean;
        private var _gridAllowDrop:Dictionary = new Dictionary();
        private var _sortLabels:Array;
        private var _currentSort:int = -1;
        private var _savedSearchByCategory:Dictionary = new Dictionary();
        private var _savedSortByCategory:Dictionary = new Dictionary();
        private var _maxKamasLimit_AlmostReached:Boolean = true;
        private var _maxKamasLimit_Reached:Boolean = false;
        private var _kamasRestricted:Boolean = false;
        private var _forceCategory:Boolean = false;
        protected var _storageBehavior:IStorageBehavior;
        protected var _storageBehaviorName:String;
        protected var _exchangeType:int;
        protected var _dataProvider:Object;
        protected var _searchCriteria:String;
        protected var _lastSearchCriteria:String;
        protected var _searchTimer:Timer;
        protected var _weight:uint;
        protected var _shopWeight:uint;
        protected var _weightMax:uint;
        protected var _currentEstimatedValue:String;
        protected var _hasSlot:Boolean = false;
        protected var _slotsMax:uint;
        protected var _ignoreQuestItems:Boolean = false;
        public var itemsDisplayed:Vector.<uint>;
        public var subFilterIndex:Object = new Object();
        public var mainCtr:GraphicContainer;
        public var ctr_common:GraphicContainer;
        public var ctr_kamas:GraphicContainer;
        public var ctr_window:GraphicContainer;
        public var ctr_storageContent:GraphicContainer;
        public var txBackground:Texture;
        public var tx_weightBar:Texture;
        public var tx_kamasOrangeWarning:Texture;
        public var tx_kamasRedWarning:Texture;
        public var tx_limitIconHelp:Texture;
        public var grid:Grid;
        public var cb_category:ComboBox;
        public var lbl_kamas:Label;
        public var lbl_title:Label;
        public var btn_close:ButtonContainer;
        public var btn_help:ButtonContainer;
        public var btnHelpClickAlreadyTreated:Boolean = false;
        public var btn_moveAllToLeft:ButtonContainer;
        public var btn_moveAllToRight:ButtonContainer;
        public var btnAll:ButtonContainer;
        public var btnEquipable:ButtonContainer;
        public var btnConsumables:ButtonContainer;
        public var btnRessources:ButtonContainer;
        public var btnQuest:ButtonContainer;
        public var btn_options:ButtonContainer;
        public var btn_checkCraft:ButtonContainer;
        public var btn_closeSearch:ButtonContainer;
        public var inp_search:Input;
        public var txKamaBackground:Texture;
        public var lbl_itemsEstimatedValue:Label;
        public var ctr_itemsEstimatedValue:GraphicContainer;


        public function get exchangeType():int
        {
            return (this._exchangeType);
        }

        public function main(param:Object):void
        {
            var value:int;
            this.initSound();
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.sysApi.addHook(DropStart, this.onDropStart);
            this.sysApi.addHook(DropEnd, this.onDropEnd);
            this.uiApi.addComponentHook(this.btnAll, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btnAll, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btnAll, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btnEquipable, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btnEquipable, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btnEquipable, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btnConsumables, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btnConsumables, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btnConsumables, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btnRessources, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btnRessources, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btnRessources, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btnQuest, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btnQuest, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btnQuest, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.inp_search, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_checkCraft, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_checkCraft, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_options, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_options, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.cb_category, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btn_close, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_help, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.lbl_kamas, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_kamas, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_kamas, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.tx_kamasOrangeWarning, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_kamasOrangeWarning, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_kamasRedWarning, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_kamasRedWarning, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_limitIconHelp, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_limitIconHelp, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_itemsEstimatedValue, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_itemsEstimatedValue, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_itemsEstimatedValue, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_itemsEstimatedValue, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_weightBar, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_weightBar, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_moveAllToLeft, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_moveAllToLeft, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_moveAllToLeft, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_moveAllToRight, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_moveAllToRight, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_moveAllToRight, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.grid, ComponentHookList.ON_ITEM_RIGHT_CLICK);
            this.uiApi.addComponentHook(this.grid, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(this.grid, ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(this.grid, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addShortcutHook("closeUi", this.onShortCut);
            (this.grid.renderer as SlotGridRenderer).dropValidatorFunction = this.dropValidator;
            (this.grid.renderer as SlotGridRenderer).processDropFunction = this.processDrop;
            (this.grid.renderer as SlotGridRenderer).removeDropSourceFunction = this.removeDropSourceFunction;
            (this.grid.renderer as SlotGridRenderer).allowDrop = true;
            this._sortLabels = new Array();
            this._sortLabels[SORT_ON_NAME] = this.uiApi.getText("ui.common.sortBy.name");
            this._sortLabels[SORT_ON_WEIGHT] = this.uiApi.getText("ui.common.sortBy.weight");
            this._sortLabels[SORT_ON_LOT_WEIGHT] = this.uiApi.getText("ui.common.sortBy.weight.lot");
            this._sortLabels[SORT_ON_QTY] = this.uiApi.getText("ui.common.sortBy.quantity");
            this._sortLabels[SORT_ON_AVERAGEPRICE] = this.uiApi.getText("ui.common.sortBy.averageprice");
            this._sortLabels[SORT_ON_LOT_AVERAGEPRICE] = this.uiApi.getText("ui.common.sortBy.averageprice.lot");
            this._sortLabels[SORT_ON_LEVEL] = this.uiApi.getText("ui.common.sortBy.level");
            this._sortLabels[SORT_ON_ITEM_TYPE] = this.uiApi.getText("ui.common.sortBy.category");
            if (!this._searchTimer)
            {
                this._searchTimer = new Timer(200, 1);
                this._searchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onSearchTimerComplete);
            };
            this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.search.inventory");
            this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
            this.questVisible = true;
            this.btn_moveAllToLeft.visible = false;
            this.btn_moveAllToRight.visible = false;
            this.btn_closeSearch.visible = false;
            if (((this._hasSlot) && (!(this._slotsMax == 0))))
            {
                value = int(Math.floor(((100 * this._inventoryItems.length) / this._slotsMax)));
                this.tx_weightBar.gotoAndStop = ((value > 100) ? 100 : value);
            };
            this.switchBehavior(param.storageMod);
            this._exchangeType = param.exchangeType;
            if (param.storageMod == "craft")
            {
                this.btn_checkCraft.visible = false;
            };
        }

        public function unload():void
        {
            this._searchCriteria = null;
            this._lastSearchCriteria = null;
            if (this._searchTimer)
            {
                this._searchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onSearchTimerComplete);
                this._searchTimer = null;
            };
            if (this._updateInventoryTimer)
            {
                this._updateInventoryTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onUpdateTimerComplete);
                this._updateInventoryTimer = null;
            };
            if (this.uiApi.getUi("quantityPopup"))
            {
                this.uiApi.unloadUi("quantityPopup");
            };
            if (this._storageBehavior)
            {
                this._storageBehavior.onUnload();
                this._storageBehavior.detach();
            };
            this._storageBehavior = null;
            this.soundApi.playSound(SoundTypeEnum.INVENTORY_CLOSE);
            this.uiApi.hideTooltip();
            this.uiApi.unloadUi("livingObject");
            if (this.uiApi.getUi("checkCraft"))
            {
                this.uiApi.unloadUi("checkCraft");
            };
            if (this._hasWorldInteraction)
            {
                Api.system.enableWorldInteraction();
            };
        }

        public function getWeightMax():uint
        {
            return (this._weightMax);
        }

        public function getWeight():uint
        {
            return (this._weight);
        }

        public function set categoryFilter(category:int):void
        {
            this.saveTabState();
            if (((!(this.questVisible)) && (category == ItemCategoryEnum.QUEST_CATEGORY)))
            {
                category = ItemCategoryEnum.EQUIPMENT_CATEGORY;
            };
            this._currentCategoryFilter = category;
            this.resumeTabState();
            var button:ButtonContainer = this.getButtonFromCategory(category);
            button.selected = true;
            if (this.subFilter != 0)
            {
                this.subFilter = this.subFilter;
            }
            else
            {
                if (_tabFilter[category])
                {
                    this.subFilter = _tabFilter[category];
                }
                else
                {
                    this.subFilter = -1;
                };
            };
        }

        private function resumeTabState():void
        {
            if (!this.INPUT_SEARCH_DEFAULT_TEXT)
            {
                this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.search.inventory");
            };
            var oldCategory:Object = this._savedSearchByCategory[this._currentCategoryFilter];
            if (((oldCategory) && (!(oldCategory == this._currentCategoryFilter))))
            {
                this.inp_search.text = this._savedSearchByCategory[this._currentCategoryFilter];
            }
            else
            {
                this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
            };
            this._searchCriteria = this._savedSearchByCategory[this._currentCategoryFilter];
            var oldSort:Object = this._savedSortByCategory[this._currentCategoryFilter];
            if (((oldSort) && (!(oldSort == this._currentSort))))
            {
                this._currentSort = int(oldSort);
                this.sortOn(int(oldSort));
            }
            else
            {
                if (((!(oldSort)) && (!(this._currentSort == SORT_ON_NONE))))
                {
                    this._currentSort = -1;
                    this.sortOn(SORT_ON_NONE);
                };
            };
        }

        private function saveTabState():void
        {
            this._savedSearchByCategory[this._currentCategoryFilter] = this._searchCriteria;
            this._savedSortByCategory[this._currentCategoryFilter] = this._currentSort;
        }

        public function get categoryFilter():int
        {
            return (this._currentCategoryFilter);
        }

        public function set subFilter(filter:int):void
        {
            var button:ButtonContainer = this.getButtonFromCategory(this.categoryFilter);
            this.subFilterIndex[button.name] = filter;
        }

        public function get subFilter():int
        {
            var button:ButtonContainer = this.getButtonFromCategory(this.categoryFilter);
            return (this.subFilterIndex[button.name]);
        }

        public function get currentStorageBehavior():IStorageBehavior
        {
            return (this._storageBehavior);
        }

        public function set questVisible(quest:Boolean):void
        {
            this.btnQuest.visible = quest;
            if (((!(this.btnQuest.visible)) && (this.categoryFilter == ItemCategoryEnum.QUEST_CATEGORY)))
            {
                this.categoryFilter = ItemCategoryEnum.EQUIPMENT_CATEGORY;
            };
            this.replaceCategoryButtons();
        }

        public function get questVisible():Boolean
        {
            return (this.btnQuest.visible);
        }

        public function get kamas():Number
        {
            return (this.utilApi.stringToKamas(this.lbl_kamas.text, ""));
        }

        protected function onInventoryUpdate(items:Object, kama:Number):void
        {
            this._inventoryItems = items;
            if (((((this.cb_category) && (this.cb_category.dataProvider)) && ((!(this._inventoryItems)) || (!(this._inventoryItems.length)))) && (!(this.subFilter == -1))))
            {
                this.cb_category.selectedItem = this.cb_category.dataProvider[0];
                this.onSelectItem(this.cb_category, SelectMethodEnum.CLICK, true);
                return;
            };
            this.onKamasUpdate(kama);
            if (!this._updateInventoryTimer)
            {
                this._updateInventoryTimer = new Timer(50, 1);
                this._updateInventoryTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onUpdateTimerComplete);
            };
            if (!this._updateInventoryTimer.running)
            {
                this._updateInventoryTimer.start();
            };
        }

        protected function onKamasUpdate(kama:Number):void
        {
            var kamaDebt:uint;
            this._maxKamasLimit_AlmostReached = ((this.playerApi.getKamasMaxLimit() > 0) && (kama >= (this.playerApi.getKamasMaxLimit() * 0.8)));
            this._maxKamasLimit_Reached = ((this.playerApi.getKamasMaxLimit() > 0) && (kama >= this.playerApi.getKamasMaxLimit()));
            this._kamasRestricted = ((this.playerApi.getKamasMaxLimit() > 0) && (this.playerApi.getKamasMaxLimit() < ProtocolConstantsEnum.MAX_KAMA));
            if (((this.playerApi.hasDebt()) && (this._exchangeType == ExchangeTypeEnum.BANK)))
            {
                kamaDebt = this.playerApi.getKamaDebt();
                kama = (kama - kamaDebt);
            };
            this.lbl_kamas.text = (((kama >= 0) ? "" : "- ") + this.utilApi.kamasToString(Math.abs(kama), ""));
            if ((((this.playerApi.hasDebt()) && (kama < 0)) && (this._exchangeType == ExchangeTypeEnum.BANK)))
            {
                this.ctr_kamas.x = this.CTR_KAMAS_ON_WARNING_X_POS;
                this.lbl_kamas.cssClass = "redright";
                this.tx_kamasOrangeWarning.visible = false;
                this.tx_kamasRedWarning.visible = false;
            }
            else
            {
                if (this._kamasRestricted)
                {
                    this.ctr_kamas.x = this.CTR_KAMAS_ON_WARNING_X_POS;
                    this.lbl_kamas.cssClass = "whiteboldright";
                    this.tx_limitIconHelp.visible = true;
                    this.tx_kamasOrangeWarning.visible = false;
                    this.tx_kamasRedWarning.visible = false;
                }
                else
                {
                    if (((this._maxKamasLimit_AlmostReached) && (!(this._maxKamasLimit_Reached))))
                    {
                        this.ctr_kamas.x = this.CTR_KAMAS_ON_WARNING_X_POS;
                        this.lbl_kamas.cssClass = "orangeright";
                        this.tx_limitIconHelp.visible = false;
                        this.tx_kamasOrangeWarning.visible = true;
                        this.tx_kamasRedWarning.visible = false;
                    }
                    else
                    {
                        if (this._maxKamasLimit_Reached)
                        {
                            this.ctr_kamas.x = this.CTR_KAMAS_ON_WARNING_X_POS;
                            this.lbl_kamas.cssClass = "redright";
                            this.tx_limitIconHelp.visible = false;
                            this.tx_kamasOrangeWarning.visible = false;
                            this.tx_kamasRedWarning.visible = true;
                        }
                        else
                        {
                            this.ctr_kamas.x = this.CTR_KAMAS_X_POS;
                            this.lbl_kamas.cssClass = "whiteboldright";
                            this.tx_limitIconHelp.visible = false;
                            this.tx_kamasOrangeWarning.visible = false;
                            this.tx_kamasRedWarning.visible = false;
                        };
                    };
                };
            };
        }

        protected function onInventoryWeight(currentWeight:uint, maxWeight:uint):void
        {
            var value:int;
            this._weight = currentWeight;
            this._weightMax = maxWeight;
            if (this.tx_weightBar)
            {
                value = int(Math.floor(((100 * currentWeight) / maxWeight)));
                if (value > 100)
                {
                    value = 100;
                };
                this.tx_weightBar.gotoAndStop = value;
            };
        }

        protected function onUpdateTimerComplete(e:TimerEvent):void
        {
            this._updateInventoryTimer.reset();
            this.updateInventory();
        }

        public function search(search:String):void
        {
            if (search)
            {
                if (search.length)
                {
                    this._searchCriteria = this.utilApi.noAccent(search).toLowerCase();
                    this.btn_closeSearch.visible = true;
                }
                else
                {
                    if (this._searchCriteria)
                    {
                        this._searchCriteria = null;
                        this._lastSearchCriteria = null;
                        this.btn_closeSearch.visible = false;
                    };
                };
                this._searchTimer.reset();
                this._searchTimer.start();
            };
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (((this.inp_search.haveFocus) && (!(this.inp_search.text == this.INPUT_SEARCH_DEFAULT_TEXT))))
            {
                this.search(this.inp_search.text);
            };
        }

        protected function onDropStart(src:Object):void
        {
            if (src.getUi() == this.uiApi.me())
            {
                this._hasWorldInteraction = Api.system.hasWorldInteraction();
                if (this._hasWorldInteraction)
                {
                    Api.system.disableWorldInteraction();
                };
            };
        }

        protected function onDropEnd(src:Object, target:Object):void
        {
            if (src.getUi() == this.uiApi.me())
            {
                if (this._hasWorldInteraction)
                {
                    Api.system.enableWorldInteraction();
                };
            };
        }

        protected function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            return (this._storageBehavior.dropValidator(target, data, source));
        }

        protected function processDrop(target:Object, data:Object, source:Object):void
        {
            return (this._storageBehavior.processDrop(target, data, source));
        }

        protected function removeDropSourceFunction(target:Object):void
        {
        }

        public function onRelease(target:Object):void
        {
            var contextMenu:Array;
            switch (target)
            {
                case this.btnAll:
                case this.btnEquipable:
                case this.btnConsumables:
                case this.btnRessources:
                    this.setDropAllowed(true, "filter");
                    this.onReleaseCategoryFilter((target as ButtonContainer));
                    break;
                case this.btn_checkCraft:
                    this.onReleaseCheckCraftBtn();
                    break;
                case this.btn_options:
                    contextMenu = new Array();
                    this.fillContextMenu(contextMenu, null, false);
                    contextMenu.unshift(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.common.options")));
                    this.modContextMenu.createContextMenu(contextMenu);
                    break;
                case this.btn_closeSearch:
                    if (this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
                    {
                        this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
                        this._searchCriteria = null;
                        this._lastSearchCriteria = null;
                        this.updateInventory();
                        this.btn_closeSearch.visible = false;
                    };
                    break;
                case this.btn_close:
                    this.onClose();
                    break;
                case this.btn_help:
                    if (this.btnHelpClickAlreadyTreated)
                    {
                        this.btnHelpClickAlreadyTreated = false;
                    }
                    else
                    {
                        this.hintsApi.showSubHints();
                    };
                    break;
                default:
                    this._storageBehavior.onRelease(target);
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            switch (target)
            {
                case this.btnAll:
                    text = this.uiApi.getText("ui.common.all");
                    break;
                case this.btnEquipable:
                    text = this.uiApi.getText("ui.common.equipement");
                    break;
                case this.btnConsumables:
                    text = this.uiApi.getText("ui.common.usableItems");
                    break;
                case this.btnRessources:
                    text = this.uiApi.getText("ui.common.ressources");
                    break;
                case this.btnQuest:
                    text = this.uiApi.getText("ui.common.quest.objects");
                    break;
                case this.btn_moveAllToLeft:
                case this.btn_moveAllToRight:
                    text = this.uiApi.getText("ui.storage.advancedTransferts");
                    break;
                case this.tx_weightBar:
                    if (this._hasSlot)
                    {
                        text = this.uiApi.getText("ui.common.player.slot", ((this._slotsMax <= 0) ? "0" : this.utilApi.kamasToString(this._inventoryItems.length, "")), this.utilApi.kamasToString(this._slotsMax, ""));
                    }
                    else
                    {
                        text = this.uiApi.getText("ui.common.player.weight", this.utilApi.kamasToString(this._weight, ""), this.utilApi.kamasToString(this._weightMax, ""));
                    };
                    break;
                case this.lbl_itemsEstimatedValue:
                case this.ctr_itemsEstimatedValue:
                    text = this.uiApi.getText("ui.storage.estimatedValue");
                    break;
                case this.lbl_kamas:
                case this.tx_kamasRedWarning:
                case this.tx_kamasOrangeWarning:
                case this.tx_limitIconHelp:
                    if (this._kamasRestricted)
                    {
                        text = this.uiApi.getText("ui.kamaLimitTooltip", this.utilApi.kamasToString(this.playerApi.getKamasMaxLimit(), ""));
                    }
                    else
                    {
                        if (((this._maxKamasLimit_AlmostReached) && (!(this._maxKamasLimit_Reached))))
                        {
                            text = this.uiApi.getText("ui.storage.ownedKamas.limitAlmostReached", this.utilApi.kamasToString(this.playerApi.getKamasMaxLimit()));
                        }
                        else
                        {
                            if (this._maxKamasLimit_Reached)
                            {
                                text = this.uiApi.getText("ui.storage.ownedKamas.limitReached", this.utilApi.kamasToString(this.playerApi.getKamasMaxLimit()));
                            }
                            else
                            {
                                if (((this.playerApi.hasDebt()) && (this._exchangeType == ExchangeTypeEnum.BANK)))
                                {
                                    text = this.uiApi.getText("ui.storage.kamaDebtTooltip");
                                }
                                else
                                {
                                    text = this.uiApi.getText("ui.storage.ownedKamas");
                                };
                            };
                        };
                    };
                    if (this.lbl_kamas.width < this.lbl_kamas.textWidth)
                    {
                        text = (text + (this.uiApi.getText("ui.common.colon") + this.lbl_kamas.text));
                    };
                    break;
                case this.btn_checkCraft:
                    text = this.uiApi.getText("ui.craft.possibleRecipesTitle");
                    break;
                case this.btn_options:
                    text = this.uiApi.getText("ui.common.options");
                    break;
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

        public function forceCategory(subCategoryType:int):void
        {
            var itemCategory:Object;
            this.btnAll.disabled = true;
            this.btnEquipable.disabled = true;
            this.btnConsumables.disabled = true;
            this.btnRessources.disabled = true;
            var index:int;
            for each (itemCategory in this.cb_category.dataProvider)
            {
                if (itemCategory.filterType === subCategoryType)
                {
                    this.cb_category.selectedIndex = index;
                    break;
                };
                index++;
            };
            this.cb_category.disabled = true;
            this._forceCategory = true;
        }

        public function unforceCategory():void
        {
            this.btnAll.disabled = false;
            this.btnEquipable.disabled = false;
            this.btnConsumables.disabled = false;
            this.btnRessources.disabled = false;
            this._forceCategory = false;
            this.cb_category.disabled = false;
            this.updateSubFilter(this.getStorageTypes(this.categoryFilter));
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var e:Object;
            switch (target)
            {
                case this.cb_category:
                    if ((((isNewSelection) && (!(selectMethod == SelectMethodEnum.AUTO))) && (!(selectMethod == SelectMethodEnum.MANUAL))))
                    {
                        e = target.value;
                        this.subFilter = e.filterType;
                        _tabFilter[this.categoryFilter] = e.filterType;
                        this.releaseHooks();
                    };
                    return;
                default:
                    this._storageBehavior.onSelectItem(target, selectMethod, isNewSelection);
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var contextMenu:Object;
            if (item.data == null)
            {
                return;
            };
            var data:Object = item.data;
            if (this._storageBehaviorName != StorageState.BAG_MOD)
            {
                contextMenu = this.menuApi.create(data);
            }
            else
            {
                contextMenu = this.menuApi.create(data, "item", [{"ownedItem":true}]);
            };
            var disabled:Boolean = contextMenu.content[0].disabled;
            this.fillContextMenu(contextMenu.content, data, disabled);
            this.modContextMenu.createContextMenu(contextMenu);
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (item.data)
            {
                this.displayItemTooltip(this.grid, item.data);
            };
        }

        protected function displayItemTooltip(target:Object, item:Object, settings:Object=null):void
        {
            var setting:String;
            var globalPosition:*;
            if (!settings)
            {
                settings = new Object();
            };
            var itemTooltipSettings:ItemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
            if (itemTooltipSettings == null)
            {
                itemTooltipSettings = this.tooltipApi.createItemSettings();
                this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, DataStoreEnum.BIND_ACCOUNT);
            };
            var objVariables:* = this.sysApi.getObjectVariables(itemTooltipSettings);
            for each (setting in objVariables)
            {
                settings[setting] = itemTooltipSettings[setting];
            };
            globalPosition = target["localToGlobal"](new Point(0, 0));
            this.uiApi.showTooltip(item, target, false, "standard", ((globalPosition.x > 500) ? LocationEnum.POINT_TOPRIGHT : LocationEnum.POINT_TOPLEFT), ((globalPosition.x > 500) ? LocationEnum.POINT_TOPLEFT : LocationEnum.POINT_TOPRIGHT), 20, null, null, settings);
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        protected function onShortCut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            return (false);
        }

        public function getButtonFromCategory(category:int):ButtonContainer
        {
            switch (category)
            {
                case ItemCategoryEnum.ALL_CATEGORY:
                    return (this.btnAll);
                case ItemCategoryEnum.EQUIPMENT_CATEGORY:
                    return (this.btnEquipable);
                case ItemCategoryEnum.CONSUMABLES_CATEGORY:
                    return (this.btnConsumables);
                case ItemCategoryEnum.RESOURCES_CATEGORY:
                    return (this.btnRessources);
                default:
                    throw (new Error(("Invalid category : " + category)));
            };
        }

        public function getCategoryFromButton(button:ButtonContainer):int
        {
            switch (button)
            {
                case this.btnAll:
                    return (ItemCategoryEnum.ALL_CATEGORY);
                case this.btnEquipable:
                    return (ItemCategoryEnum.EQUIPMENT_CATEGORY);
                case this.btnConsumables:
                    return (ItemCategoryEnum.CONSUMABLES_CATEGORY);
                case this.btnRessources:
                    return (ItemCategoryEnum.RESOURCES_CATEGORY);
                default:
                    throw (new Error(("Invalid button : " + button)));
            };
        }

        public function switchBehavior(behaviorName:String):void
        {
            if (this._storageBehavior)
            {
                this._storageBehavior.detach();
            };
            this._storageBehavior = StorageBehaviorManager.makeBehavior(behaviorName);
            this._storageBehaviorName = behaviorName;
            if (this._storageBehaviorName == "smithMagicCoop")
            {
                this.onRelease(this.btnRessources);
                this.sysApi.addHook(UiLoaded, this.onUiLoaded);
            }
            else
            {
                if (this._storageBehaviorName == StorageState.BID_HOUSE_MOD)
                {
                    this.associateUi();
                    this.sysApi.addHook(UiLoaded, this.onUiLoaded);
                }
                else
                {
                    this._storageBehavior.attach(this);
                };
            };
        }

        public function associateUi():void
        {
            if (this._storageBehaviorName == StorageState.BID_HOUSE_MOD)
            {
                this.uiApi.me().setOnTopAfterMe = [];
                if (this.uiApi.getUi(UIEnum.AUCTIONHOUSE))
                {
                    this.uiApi.me().setOnTopAfterMe.push(this.uiApi.getUi(UIEnum.AUCTIONHOUSE));
                };
            };
        }

        public function onUiLoaded(name:String):void
        {
            if (name == UIEnum.SMITH_MAGIC)
            {
                this.sysApi.removeHook(UiLoaded);
                this._storageBehavior.attach(this);
            }
            else
            {
                if (((name == UIEnum.STORAGE_UI) || (name == UIEnum.AUCTIONHOUSE)))
                {
                    this.sysApi.removeHook(UiLoaded);
                    this._storageBehavior.attach(this);
                };
            };
        }

        public function updateInventory():void
        {
            var item:Object;
            var l:int;
            var i:int;
            var filteredInventory:Array;
            var reusingDataProvider:Boolean;
            var inventory:*;
            var value:int;
            var scrollValue:int = this.grid.verticalScrollValue;
            if (this._inventoryItems)
            {
                filteredInventory = new Array();
                this.itemsDisplayed = new Vector.<uint>();
                this.updateSubFilter(this.getStorageTypes(this.categoryFilter));
                if (this._searchCriteria)
                {
                    reusingDataProvider = (((this._lastSearchCriteria) && (this._lastSearchCriteria.length < this._searchCriteria.length)) && (!(this._searchCriteria.indexOf(this._lastSearchCriteria) == -1)));
                    inventory = ((reusingDataProvider) ? this.grid.dataProvider : this._inventoryItems);
                    l = inventory.length;
                    i = 0;
                    for (;i < l;i++)
                    {
                        item = inventory[i];
                        if (((this._ignoreQuestItems) && (!(reusingDataProvider))))
                        {
                            if (item.category == ItemCategoryEnum.QUEST_CATEGORY)
                            {
                                continue;
                            };
                        };
                        if (((!(item.undiatricalName.indexOf(this._searchCriteria) == -1)) || ((item.searchContent.length > 0) && (!(item.searchContent.indexOf(this._searchCriteria) == -1)))))
                        {
                            filteredInventory.push(item);
                            this.itemsDisplayed.push(item.objectUID);
                        };
                    };
                    this.grid.dataProvider = filteredInventory;
                    this._lastSearchCriteria = this._searchCriteria;
                }
                else
                {
                    l = this._inventoryItems.length;
                    i = 0;
                    for (;i < l;i++)
                    {
                        item = this._inventoryItems[i];
                        if (this._ignoreQuestItems)
                        {
                            if (item.category == ItemCategoryEnum.QUEST_CATEGORY)
                            {
                                continue;
                            };
                            filteredInventory.push(item);
                        };
                        this.itemsDisplayed.push(item.objectUID);
                    };
                    if (this._ignoreQuestItems)
                    {
                        this._inventoryItems = filteredInventory;
                    };
                    this.grid.dataProvider = this._inventoryItems;
                    this._lastSearchCriteria = null;
                };
                this._ignoreQuestItems = false;
                if (((this._hasSlot) && (!(this._slotsMax == 0))))
                {
                    value = int(Math.floor(((100 * this._inventoryItems.length) / this._slotsMax)));
                    this.tx_weightBar.gotoAndStop = ((value > 100) ? 100 : value);
                };
                this.updateItemsEstimatedValue();
            };
            this.grid.verticalScrollValue = scrollValue;
        }

        public function name():String
        {
            return (this.uiApi.me().name);
        }

        protected function releaseHooks():void
        {
            throw (new Error("Error : releaseHooks is an abstract method. It's shouldn't be called"));
        }

        public function setDropAllowed(allow:Boolean, category:String):void
        {
            var eachAllow:Boolean;
            this._gridAllowDrop[category] = allow;
            for each (eachAllow in this._gridAllowDrop)
            {
                if (!eachAllow)
                {
                    (this.grid.renderer as SlotGridRenderer).allowDrop = false;
                    return;
                };
            };
            (this.grid.renderer as SlotGridRenderer).allowDrop = true;
        }

        protected function onReleaseCategoryFilter(target:ButtonContainer):void
        {
            this._lastSearchCriteria = null;
            this.categoryFilter = this.getCategoryFromButton(target);
            this.releaseHooks();
        }

        protected function onReleaseCheckCraftBtn():void
        {
            var checkCraftUi:Object = this.uiApi.getUi("checkCraft");
            if (!checkCraftUi)
            {
                this.uiApi.loadUi("Ankama_Job::checkCraft", "checkCraft", {"storage":this._storageBehaviorName});
            }
            else
            {
                if (checkCraftUi.uiClass.storage != this._storageBehaviorName)
                {
                    checkCraftUi.uiClass.main({"storage":this._storageBehaviorName});
                }
                else
                {
                    this.uiApi.unloadUi("checkCraft");
                };
            };
        }

        protected function onClose():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        protected function fillContextMenu(contextMenu:Array, data:Object, disabled:Boolean):void
        {
            var secondarySorts:Array;
            var sort:*;
            var itemTooltipSettings:ItemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
            if (!itemTooltipSettings)
            {
                itemTooltipSettings = this.tooltipApi.createItemSettings();
                this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, DataStoreEnum.BIND_ACCOUNT);
            };
            if (contextMenu.length)
            {
                contextMenu.push(this.modContextMenu.createContextMenuSeparatorObject());
            };
            if (Api.system.getOption("displayTooltips", "dofus"))
            {
                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.tooltip"), null, null, false, [this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.name"), this.onTooltipDisplayOption, ["header"], disabled, null, itemTooltipSettings.header, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.processText(this.uiApi.getText("ui.common.effects"), "", false), this.onTooltipDisplayOption, ["effects"], disabled, null, itemTooltipSettings.effects, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.conditions"), this.onTooltipDisplayOption, ["conditions"], disabled, null, itemTooltipSettings.conditions, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.description"), this.onTooltipDisplayOption, ["description"], disabled, null, itemTooltipSettings.description, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.item.averageprice"), this.onTooltipDisplayOption, ["averagePrice"], disabled, null, itemTooltipSettings.averagePrice, false)], disabled));
            };
            var sortField:int = this.getSortFields()[0];
            var sortMenu:Object = this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.sort"), null, null, false, null, disabled);
            var sortMenuChildren:Array = new Array();
            sortMenuChildren.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.sortBy.default"), this.updateSort, [SORT_ON_NONE], disabled, null, (sortField == SORT_ON_NONE), true));
            for (sort in this._sortLabels)
            {
                sortMenuChildren.push(this.modContextMenu.createContextMenuItemObject(this._sortLabels[sort], this.updateSort, [sort], disabled, null, (sortField == sort), true));
                if (((!(sortField == SORT_ON_NONE)) && (!(sort == sortField))))
                {
                    if (!secondarySorts)
                    {
                        secondarySorts = new Array();
                    };
                    secondarySorts.push(this.modContextMenu.createContextMenuItemObject(this._sortLabels[sort], this.addSort, [sort], false, null, (!(this.getSortFields().indexOf(sort) == -1)), true));
                };
            };
            sortMenuChildren.push(this.modContextMenu.createContextMenuSeparatorObject(), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.sort.secondary"), null, null, (sortField == SORT_ON_NONE), secondarySorts, false));
            sortMenu.child = sortMenuChildren;
            contextMenu.push(sortMenu);
        }

        protected function getSortFields():Object
        {
            throw (new Error("getSortField is abstract function, it must be implemented"));
        }

        protected function getStorageTypes(categoryFilter:int):Object
        {
            throw (new Error("Error : getStorageTypes is abstract function. It must be override"));
        }

        protected function initSound():void
        {
            this.btnAll.soundId = SoundEnum.TAB;
            this.btnEquipable.soundId = SoundEnum.TAB;
            this.btnConsumables.soundId = SoundEnum.TAB;
            this.btnRessources.soundId = SoundEnum.TAB;
            this.btn_close.isMute = true;
        }

        private function onTooltipDisplayOption(field:String):void
        {
            var itemTooltipSettings:ItemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
            itemTooltipSettings[field] = (!(itemTooltipSettings[field]));
            this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, DataStoreEnum.BIND_ACCOUNT);
        }

        protected function updateSubFilter(types:Object):void
        {
            var selectedItem:Object;
            var tmp:Object;
            var _local_5:Object;
            var cbProvider:Array = new Array();
            for each (_local_5 in types)
            {
                tmp = {
                    "label":_local_5.name,
                    "filterType":_local_5.id
                };
                if (_local_5.id == this.subFilterIndex[this.getButtonFromCategory(this.categoryFilter).name])
                {
                    selectedItem = tmp;
                };
                cbProvider.push(tmp);
            };
            tmp = {
                "label":this.uiApi.getText("ui.common.allTypesForObject"),
                "filterType":-1
            };
            if (!selectedItem)
            {
                selectedItem = tmp;
            };
            cbProvider.unshift(tmp);
            this.cb_category.dataProvider = cbProvider;
            if (((!(this.cb_category.value == selectedItem)) && (!(this._forceCategory))))
            {
                this.cb_category.value = selectedItem;
            };
        }

        private function updateItemsEstimatedValue():void
        {
            var item:Object;
            var averagePrice:Number;
            if (!this.ctr_itemsEstimatedValue)
            {
                return;
            };
            if (this.grid.dataProvider.length == 0)
            {
                if (this.ctr_itemsEstimatedValue)
                {
                    this.ctr_itemsEstimatedValue.visible = false;
                };
                return;
            };
            if (this.ctr_itemsEstimatedValue)
            {
                this.ctr_itemsEstimatedValue.visible = true;
            };
            var itemsValue:Number = 0;
            for each (item in this.grid.dataProvider)
            {
                averagePrice = this.averagePricesApi.getItemAveragePrice(item.objectGID);
                itemsValue = (itemsValue + (averagePrice * item.quantity));
            };
            this._currentEstimatedValue = this.utilApi.kamasToString(itemsValue);
            if (this.lbl_itemsEstimatedValue)
            {
                this.lbl_itemsEstimatedValue.text = this._currentEstimatedValue;
            };
        }

        private function updateSort(property:int, numeric:Boolean=false):void
        {
            this._currentSort = property;
            this.sortOn(property, numeric);
        }

        protected function sortOn(property:int, numeric:Boolean=false):void
        {
            throw (new Error("sortOn is an abstract method, it shouldn't be called"));
        }

        protected function addSort(property:int):void
        {
            throw (new Error("addSort is an abstract method, it shouldn't be called"));
        }

        private function replaceCategoryButtons():void
        {
            var btn:ButtonContainer;
            var buttons:Array = new Array();
            buttons.push(this.btnAll);
            buttons.push(this.btnEquipable);
            buttons.push(this.btnConsumables);
            buttons.push(this.btnRessources);
            if (this.questVisible)
            {
                buttons.push(this.btnQuest);
            };
            var currentTotalWidth:int = ((buttons.length * this.btnAll.width) + (buttons.length - 1));
            var allButtonsTotalWidth:int = ((6 * this.btnAll.width) + 5);
            var offsetToCenterButtons:int = int(int(((allButtonsTotalWidth - currentTotalWidth) / 2)));
            var xForCurrentButtonWithoutOffset:int;
            for each (btn in buttons)
            {
                btn.x = (offsetToCenterButtons + xForCurrentButtonWithoutOffset);
                xForCurrentButtonWithoutOffset = (xForCurrentButtonWithoutOffset + (btn.width + 1));
            };
        }

        private function onSearchTimerComplete(e:TimerEvent):void
        {
            this._searchTimer.reset();
            this.updateInventory();
        }


    }
} Ankama_Storage.ui

