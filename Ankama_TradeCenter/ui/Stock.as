package Ankama_TradeCenter.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.InventoryApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.EntityDisplayer;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Input;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import d2hooks.KeyUp;
    import d2enums.ComponentHookList;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import flash.display.Sprite;
    import __AS3__.vec.Vector;
    import flash.events.TimerEvent;
    import d2actions.LeaveDialogRequest;
    import d2actions.CloseInventory;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.datacenter.items.ItemType;
    import Ankama_TradeCenter.TradeCenter;
    import flash.ui.Keyboard;
    import d2actions.ExchangeShopStockMouvmentRemove;
    import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
    import com.ankamagames.berilia.types.LocationEnum;
    import d2hooks.ClickItemStore;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import d2hooks.CloseStore;
    import __AS3__.vec.*;

    public class Stock 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="InventoryApi")]
        public var inventoryApi:InventoryApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var ctr_common:GraphicContainer;
        public var lbl_title:Label;
        public var btn_close:ButtonContainer;
        public var tx_bgEntity:Texture;
        public var ed_merchant:EntityDisplayer;
        public var btn_help:ButtonContainer;
        public var btnEquipable:ButtonContainer;
        public var btnConsumables:ButtonContainer;
        public var btnRessources:ButtonContainer;
        public var btnAll:ButtonContainer;
        public var cb_category:ComboBox;
        public var gd_shop:Grid;
        public var ctr_search:GraphicContainer;
        public var inp_search:Input;
        public var btn_closeSearch:ButtonContainer;
        public var btn_itemsFilter:ButtonContainer;
        public var ctr_center:GraphicContainer;
        public var ctr_bottomInfos:GraphicContainer;
        public var btn_beta:ButtonContainer;
        public var ctr_btnBeta:GraphicContainer;
        public var tx_warningBetaMode:Texture;
        protected var _searchCriteria:String;
        protected var _searchTimer:Timer;
        protected var _categoriesIdByBtnName:Dictionary = new Dictionary();
        protected var _typeSelectedByCatBtnName:Dictionary = new Dictionary();
        protected var _objectsInStock:Array;
        protected var _categoryIdByItemUID:Dictionary = new Dictionary();
        protected var _currentCategoryBtn:Object;
        protected var _componentsList:Dictionary = new Dictionary(true);
        protected var _tokenType:int;
        public var btnHelpClickAlreadyTreated:Boolean = false;
        protected var INPUT_SEARCH_DEFAULT_TEXT:String;


        public function main(params:Object=null):void
        {
            var item:Object;
            this.btnEquipable.soundId = SoundEnum.TAB;
            this.btnConsumables.soundId = SoundEnum.TAB;
            this.btnRessources.soundId = SoundEnum.TAB;
            this.btnAll.soundId = SoundEnum.TAB;
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addComponentHook(this.btnAll, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btnAll, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btnEquipable, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btnEquipable, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btnConsumables, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btnConsumables, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btnRessources, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btnRessources, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.inp_search, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.cb_category, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btn_help, ComponentHookList.ON_RELEASE);
            var showWarningBetaMode:Boolean = this.sysApi.getData("BetaModeAuctionHouseAlreadyDisplayed", DataStoreEnum.BIND_ACCOUNT);
            this.tx_warningBetaMode.visible = (!(showWarningBetaMode));
            this.ctr_center.visible = false;
            this.ctr_bottomInfos.visible = false;
            this.btn_closeSearch.visible = false;
            this.ctr_btnBeta.visible = false;
            this.gd_shop.autoSelectMode = 0;
            this._currentCategoryBtn = this.btnAll;
            this.btnAll.selected = true;
            if (((!(params)) || (params.tokenId)))
            {
                this.ctr_search.y = 670;
                this.gd_shop.height = 595;
            };
            if (((params) && (params.tokenId)))
            {
                this._tokenType = params.tokenId;
                this.btn_itemsFilter.visible = true;
            };
            this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.search.list");
            this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
            this._categoriesIdByBtnName[this.btnEquipable.name] = ItemCategoryEnum.EQUIPMENT_CATEGORY;
            this._categoriesIdByBtnName[this.btnConsumables.name] = ItemCategoryEnum.CONSUMABLES_CATEGORY;
            this._categoriesIdByBtnName[this.btnRessources.name] = ItemCategoryEnum.RESOURCES_CATEGORY;
            this._categoriesIdByBtnName[this.btnAll.name] = ItemCategoryEnum.ALL_CATEGORY;
            var charMask:Sprite = new Sprite();
            charMask.graphics.beginFill(0xFF5500, 0.5);
            var points:Vector.<Number> = new Vector.<Number>();
            points.push(15, 2, 55, 38, 95, 2, 15, -40, 95, -40);
            var indices:Vector.<int> = new Vector.<int>();
            indices.push(0, 1, 2, 0, 3, 2, 3, 4, 2);
            charMask.graphics.drawTriangles(points, indices);
            charMask.graphics.endFill();
            this.ctr_common.addChild(charMask);
            this.ed_merchant.mask = charMask;
            this.ed_merchant.withoutMount = true;
            if (!this._searchTimer)
            {
                this._searchTimer = new Timer(200, 1);
                this._searchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onSearchTimerComplete);
            };
            this._objectsInStock = new Array();
            if (params)
            {
                for each (item in params.objects)
                {
                    this._objectsInStock.push(item);
                };
                this._objectsInStock.sort(this.shopStockSort);
                this.updateStockInventory();
            };
        }

        public function unload():void
        {
            if (this._searchTimer)
            {
                this._searchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onSearchTimerComplete);
                this._searchTimer = null;
            };
            this.sysApi.sendAction(new LeaveDialogRequest());
            this.sysApi.sendAction(new CloseInventory());
            this.sysApi.enableWorldInteraction();
            this.uiApi.hideTooltip();
        }

        public function updateItemLine(data:*, components:*, selected:Boolean):void
        {
            var itemWrapper:Object;
            var newWidthName:uint;
            var item:ItemWrapper;
            components.slot_item.allowDrag = false;
            if (!this._componentsList[components.slot_item.name])
            {
                this.uiApi.addComponentHook(components.slot_item, ComponentHookList.ON_RIGHT_CLICK);
                this.uiApi.addComponentHook(components.slot_item, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.slot_item, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[components.slot_item.name] = data;
            if (!this._componentsList[components.btn_item.name])
            {
                this.uiApi.addComponentHook(components.btn_item, ComponentHookList.ON_RIGHT_CLICK);
                this.uiApi.addComponentHook(components.btn_item, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_item, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[components.btn_item.name] = data;
            if (!this._componentsList[components.lbl_ItemName.name])
            {
                this.uiApi.addComponentHook(components.lbl_ItemName, ComponentHookList.ON_RELEASE);
            };
            this._componentsList[components.lbl_ItemName.name] = data;
            if (!this._componentsList[components.slot_TokenPrice.name])
            {
                this.uiApi.addComponentHook(components.slot_TokenPrice, ComponentHookList.ON_RIGHT_CLICK);
                this.uiApi.addComponentHook(components.slot_TokenPrice, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.slot_TokenPrice, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[components.slot_TokenPrice.name] = data;
            if (data)
            {
                components.btn_item.selected = selected;
                itemWrapper = data.itemWrapper;
                if (!this._tokenType)
                {
                    if (((((!(data.hasOwnProperty("price"))) || (isNaN(Number(data.price)))) || (data.price == null)) || (data.price == 0)))
                    {
                        components.lbl_ItemPrice.text = "";
                        components.tx_kama.visible = false;
                    }
                    else
                    {
                        components.lbl_ItemPrice.text = this.utilApi.kamasToString(data.price, "");
                        components.tx_kama.visible = true;
                    };
                    newWidthName = ((((components.lbl_ItemPrice.x + components.lbl_ItemPrice.width) - components.lbl_ItemName.x) - 10) - components.lbl_ItemPrice.textfield.textWidth);
                }
                else
                {
                    newWidthName = ((components.slot_TokenPrice.x - components.lbl_ItemName.x) - 5);
                    components.tx_kama.visible = false;
                };
                components.lbl_ItemName.width = newWidthName;
                components.lbl_ItemName.text = itemWrapper.shortName;
                if (itemWrapper.etheral)
                {
                    components.lbl_ItemName.cssClass = "itemetheral";
                }
                else
                {
                    if (itemWrapper.itemSetId != -1)
                    {
                        components.lbl_ItemName.cssClass = "itemset";
                    }
                    else
                    {
                        components.lbl_ItemName.cssClass = "p";
                    };
                };
                if ((((data.hasOwnProperty("criterion")) && (data.criterion)) && (!(data.criterion.isRespected))))
                {
                    components.lbl_ItemName.cssClass = "malus";
                };
                if (this._tokenType)
                {
                    components.lbl_ItemPrice.visible = false;
                    components.slot_TokenPrice.visible = true;
                    item = this.dataApi.getItemWrapper(this._tokenType, 0, 0, data.price);
                    components.slot_TokenPrice.data = item;
                }
                else
                {
                    components.slot_TokenPrice.visible = false;
                    if (data.hasOwnProperty("price"))
                    {
                        components.lbl_ItemPrice.visible = true;
                        components.lbl_ItemPrice.text = this.utilApi.kamasToString(data.price, "");
                    }
                    else
                    {
                        components.lbl_ItemPrice.visible = false;
                    };
                };
                components.slot_item.data = itemWrapper;
                components.tx_backgroundItem.visible = true;
            }
            else
            {
                components.lbl_ItemName.text = "";
                components.lbl_ItemPrice.text = "";
                components.slot_item.data = null;
                components.tx_backgroundItem.visible = false;
                components.btn_item.selected = false;
                components.slot_TokenPrice.data = null;
                components.tx_kama.visible = false;
            };
        }

        protected function updateStockInventory():void
        {
            var tokenCount:int;
            var it:Object;
            var currentCategoryId:int = this._categoriesIdByBtnName[this._currentCategoryBtn.name];
            this.updateCombobox();
            var result:Array = new Array();
            if (this._tokenType)
            {
                tokenCount = this.inventoryApi.getItemQty(this._tokenType);
            };
            for each (it in this._objectsInStock)
            {
                if ((((((currentCategoryId == ItemCategoryEnum.ALL_CATEGORY) || (it.itemWrapper.category == currentCategoryId)) && (((!(this.cb_category.value)) || (this.cb_category.value.typeId == -1)) || (this.cb_category.value.typeId == it.itemWrapper.typeId))) && ((!(this._searchCriteria)) || (!(it.itemWrapper.undiatricalName.indexOf(this._searchCriteria) == -1)))) && ((!(this.btn_itemsFilter.selected)) || (((it.criterion) && (it.criterion.isRespected)) && ((!(this._tokenType)) || (it.price <= tokenCount))))))
                {
                    result.push(it);
                };
            };
            this.gd_shop.dataProvider = result;
        }

        protected function updateCombobox():void
        {
            var it:Object;
            var cbProvider:Array;
            var selectedItem:Object;
            var tmp:Object;
            var _local_7:ItemType;
            var typesInThisCategory:Dictionary = new Dictionary();
            var categoryId:int = this._categoriesIdByBtnName[this._currentCategoryBtn.name];
            for each (it in this._objectsInStock)
            {
                if (((categoryId == ItemCategoryEnum.ALL_CATEGORY) || (it.itemWrapper.category == categoryId)))
                {
                    typesInThisCategory[it.itemWrapper.typeId] = it.itemWrapper.type;
                };
            };
            cbProvider = new Array();
            for each (_local_7 in typesInThisCategory)
            {
                tmp = {
                    "label":_local_7.name,
                    "typeId":_local_7.id
                };
                if (_local_7.id == this._typeSelectedByCatBtnName[this._currentCategoryBtn.name])
                {
                    selectedItem = tmp;
                };
                cbProvider.push(tmp);
            };
            cbProvider = cbProvider.sortOn("label", Array.CASEINSENSITIVE);
            tmp = {
                "label":this.uiApi.getText("ui.common.allTypesForObject"),
                "typeId":-1
            };
            if (!selectedItem)
            {
                selectedItem = tmp;
            };
            cbProvider.unshift(tmp);
            this.cb_category.dataProvider = cbProvider;
            this.cb_category.value = selectedItem;
        }

        public function onRelease(target:Object):void
        {
            var item:Object;
            var ctrlDown:Boolean;
            var shiftDown:Boolean;
            switch (target)
            {
                case this.btnEquipable:
                case this.btnConsumables:
                case this.btnRessources:
                case this.btnAll:
                    this._currentCategoryBtn = target;
                    this.updateStockInventory();
                    if (this.gd_shop.dataProvider.length > 0)
                    {
                        this.gd_shop.selectedIndex = -1;
                    };
                    break;
                case this.btn_closeSearch:
                    if (this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
                    {
                        this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
                        this._searchCriteria = null;
                        this.updateStockInventory();
                        this.btn_closeSearch.visible = false;
                        TradeCenter.SEARCH_MODE = false;
                    };
                    break;
                case this.btn_itemsFilter:
                    this.updateStockInventory();
                    break;
                case this.gd_shop:
                    item = this.gd_shop.selectedItem;
                    ctrlDown = this.uiApi.keyIsDown(Keyboard.CONTROL);
                    shiftDown = this.uiApi.keyIsDown(Keyboard.SHIFT);
                    if (((ctrlDown) && (shiftDown)))
                    {
                        this.sysApi.sendAction(new ExchangeShopStockMouvmentRemove(item.objectUID, item.quantity));
                    };
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
            };
        }

        public function onRollOver(target:Object):void
        {
            var info:String;
            var itemTooltipSettings:ItemTooltipSettings;
            var pos:Object = {
                "point":LocationEnum.POINT_RIGHT,
                "relativePoint":LocationEnum.POINT_RIGHT
            };
            var offset:int = 9;
            switch (target)
            {
                case this.btnEquipable:
                    info = this.uiApi.getText("ui.common.equipement");
                    break;
                case this.btnConsumables:
                    info = this.uiApi.getText("ui.common.usableItems");
                    break;
                case this.btnRessources:
                    info = this.uiApi.getText("ui.common.ressources");
                    break;
                case this.btnAll:
                    info = this.uiApi.getText("ui.common.all");
                    break;
                default:
                    if (target.name.indexOf("slot_") != -1)
                    {
                        itemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
                        if (itemTooltipSettings == null)
                        {
                            itemTooltipSettings = this.tooltipApi.createItemSettings();
                            this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, DataStoreEnum.BIND_ACCOUNT);
                        };
                        itemTooltipSettings.showEffects = true;
                        if (((!(TradeCenter.BID_HOUSE_BUY_MODE)) || (!(this.uiApi.me().name.toLowerCase().indexOf("myself") == -1))))
                        {
                            itemTooltipSettings.showEffects = false;
                        };
                        if (this.sysApi.getOption("displayTooltips", "dofus"))
                        {
                            this.uiApi.showTooltip(target.data, target, false, "standard", 3, 3, 0, null, null, itemTooltipSettings);
                        }
                        else
                        {
                            this.uiApi.showTooltip(target.data, target, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPRIGHT, 0, "itemName", null, itemTooltipSettings, "ItemInfo");
                        };
                    };
            };
            if (info)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info), target, false, "standard", pos.point, pos.relativePoint, offset, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var item:Object;
            switch (target)
            {
                case this.gd_shop:
                    item = this.gd_shop.selectedItem;
                    if (!item)
                    {
                        return;
                    };
                    switch (selectMethod)
                    {
                        case SelectMethodEnum.CLICK:
                            this.sysApi.dispatchHook(ClickItemStore, item, this._tokenType);
                            break;
                        case SelectMethodEnum.DOUBLE_CLICK:
                            break;
                    };
                    break;
                case this.cb_category:
                    if (((isNewSelection) && (!(selectMethod == 2))))
                    {
                        this._typeSelectedByCatBtnName[this._currentCategoryBtn.name] = target.value.typeId;
                        this.updateStockInventory();
                    };
                    break;
            };
        }

        public function onRightClick(target:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (target.name.indexOf("slot_") != -1)
            {
                data = target.data;
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            }
            else
            {
                if (target.name.indexOf("btn_item") != -1)
                {
                    data = this._componentsList[target.name];
                    if (!data)
                    {
                        return;
                    };
                    contextMenu = this.menuApi.create(data.itemWrapper);
                    if (contextMenu.content.length > 0)
                    {
                        this.modContextMenu.createContextMenu(contextMenu);
                    };
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (item.data)
            {
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (((this.inp_search.haveFocus) && (!(this.inp_search.text == this.INPUT_SEARCH_DEFAULT_TEXT))))
            {
                if (this.inp_search.text.length)
                {
                    this._searchCriteria = this.utilApi.noAccent(this.inp_search.text).toLowerCase();
                    this.btn_closeSearch.visible = true;
                    this._searchTimer.reset();
                    this._searchTimer.start();
                }
                else
                {
                    if (this._searchCriteria)
                    {
                        this._searchCriteria = null;
                        this.btn_closeSearch.visible = false;
                        this.inp_search.text = "";
                        this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
                        this.updateStockInventory();
                        TradeCenter.SEARCH_MODE = false;
                    };
                };
            };
        }

        protected function showTransfertUI(show:Boolean=true):void
        {
            if (show)
            {
                this.soundApi.playSound(SoundTypeEnum.MERCHANT_TRANSFERT_OPEN);
            }
            else
            {
                this.soundApi.playSound(SoundTypeEnum.MERCHANT_TRANSFERT_CLOSE);
            };
        }

        protected function onShortcut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.sysApi.dispatchHook(CloseStore);
                return (true);
            };
            if (s == "validUi")
            {
                this.inp_search.focus();
                return (true);
            };
            return (false);
        }

        protected function shopStockSort(a:Object, b:Object):int
        {
            if (a.price < b.price)
            {
                return (-1);
            };
            if (a.price > b.price)
            {
                return (1);
            };
            if (a.itemWrapper.typeId < b.itemWrapper.typeId)
            {
                return (-1);
            };
            if (a.itemWrapper.typeId > b.itemWrapper.typeId)
            {
                return (1);
            };
            if (a.itemWrapper.name < b.itemWrapper.name)
            {
                return (-1);
            };
            if (a.itemWrapper.name > b.itemWrapper.name)
            {
                return (1);
            };
            return (0);
        }

        protected function onSearchTimerComplete(e:TimerEvent):void
        {
            this._searchTimer.reset();
            TradeCenter.SEARCH_MODE = true;
            this.updateStockInventory();
        }


    }
}

