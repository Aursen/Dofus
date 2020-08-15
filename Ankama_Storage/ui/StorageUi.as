package Ankama_Storage.ui
{
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.ProgressBar;
    import com.ankamagames.berilia.components.Texture;
    import d2hooks.StorageFilterUpdated;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import Ankama_Storage.ui.behavior.CraftBehavior;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2hooks.ShortcutsMovementAllowed;
    import d2hooks.StorageViewContent;
    import d2hooks.KamasUpdate;
    import d2hooks.InventoryWeight;
    import d2hooks.UiLoaded;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;

    public class StorageUi extends AbstractStorageUi 
    {

        public var btn_itemsFilter:ButtonContainer;
        public var btn_label_btn_itemsFilter:Label;
        public var ignoreSubFilterInMain:Boolean = false;
        private var _saveCategory:Boolean = true;
        public var pb_inventoryWeight:ProgressBar;
        public var pb_shopWeight:ProgressBar;
        public var pb_weightSeparator:ProgressBar;
        public var tx_notifHighWeight:Texture;
        public var tx_notifFullWeight:Texture;


        public function set saveCategory(c:Boolean):void
        {
            this._saveCategory = c;
        }

        public function get saveCategory():Boolean
        {
            return (this._saveCategory);
        }

        override public function set categoryFilter(category:int):void
        {
            var button:ButtonContainer = this.getButtonFromCategory(category);
            if (this._saveCategory)
            {
                sysApi.setData("lastStorageTab", button.name);
            };
            super.categoryFilter = category;
            storageApi.setDisplayedCategory(categoryFilter);
            sysApi.dispatchHook(StorageFilterUpdated, grid.dataProvider, categoryFilter);
        }

        override public function set subFilter(filter:int):void
        {
            var cb_category:Object;
            updateSubFilter(this.getStorageTypes(categoryFilter));
            var hasFilter:Boolean;
            for each (cb_category in super.cb_category.dataProvider)
            {
                if (cb_category.filterType == filter)
                {
                    hasFilter = true;
                    break;
                };
            };
            if (!hasFilter)
            {
                filter = -1;
            };
            storageApi.setStorageFilter(filter);
            if (this._saveCategory)
            {
                sysApi.setData("lastSubFilter", filter);
            };
            super.subFilter = filter;
        }

        override public function main(param:Object):void
        {
            var lowerCategory:int;
            var item:Object;
            var inventory:Object = storageApi.getViewContent("storage");
            var kamas:Number = playerApi.characteristics().kamas;
            var inventoryWeight:int = playerApi.inventoryWeight();
            var shopWeight:int = playerApi.shopWeight();
            var weightMax:int = playerApi.inventoryWeightMax();
            this.hideFilter();
            var lastSubFilter:int = sysApi.getData("lastSubFilter");
            var lastTab:String = sysApi.getData("lastStorageTab");
            if (lastTab)
            {
                this.categoryFilter = this.getCategoryFromButton(this[lastTab]);
            }
            else
            {
                lowerCategory = -1;
                for each (item in inventory)
                {
                    if ((((item.position == 63) && ((((item.category == ItemCategoryEnum.EQUIPMENT_CATEGORY) || (item.category == ItemCategoryEnum.CONSUMABLES_CATEGORY)) || (item.category == ItemCategoryEnum.RESOURCES_CATEGORY)) || (item.category == ItemCategoryEnum.QUEST_CATEGORY))) && ((item.category < lowerCategory) || (lowerCategory == -1))))
                    {
                        lowerCategory = item.category;
                        if (lowerCategory == 0)
                        {
                            break;
                        };
                    };
                };
                if (lowerCategory == -1)
                {
                    lowerCategory = ItemCategoryEnum.EQUIPMENT_CATEGORY;
                };
                this.categoryFilter = lowerCategory;
            };
            super.main(param);
            super.updateSubFilter(this.getStorageTypes(categoryFilter));
            if (!this.ignoreSubFilterInMain)
            {
                if (lastSubFilter != 0)
                {
                    this.subFilter = lastSubFilter;
                };
                _tabFilter[categoryFilter] = subFilter;
            };
            this.ignoreSubFilterInMain = false;
            if (((((param.storageMod == "craft") && ((_storageBehavior as CraftBehavior).craftUi)) && ((_storageBehavior as CraftBehavior).craftUi.skill)) && ((_storageBehavior as CraftBehavior).craftUi.skill.id == DataEnum.SKILL_WRAP_GIFT)))
            {
                this.btn_itemsFilter.selected = false;
                this.btn_itemsFilter.disabled = true;
            }
            else
            {
                uiApi.addComponentHook(this.btn_itemsFilter, "onRelease");
            };
            if (!uiApi.getUi(UIEnum.SMILEY_UI))
            {
                sysApi.dispatchHook(ShortcutsMovementAllowed, true);
            };
            sysApi.addHook(StorageViewContent, this.onInventoryUpdate);
            sysApi.addHook(KamasUpdate, onKamasUpdate);
            sysApi.addHook(InventoryWeight, this.onPlayerInventoryWeight);
            sysApi.addHook(UiLoaded, this.onUiLoaded);
            uiApi.addComponentHook(this.pb_inventoryWeight, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.pb_inventoryWeight, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.pb_shopWeight, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.pb_shopWeight, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.pb_weightSeparator, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.pb_weightSeparator, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.tx_notifFullWeight, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.tx_notifFullWeight, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(this.tx_notifHighWeight, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.tx_notifHighWeight, ComponentHookList.ON_ROLL_OUT);
            this.tx_notifFullWeight.visible = false;
            this.tx_notifHighWeight.visible = false;
            var bankUi:* = uiApi.getUi("bank");
            if (((bankUi) && ((!(bankUi.uiClass.isCtrKamaVisible())) || ((playerApi.hasDebt()) && (!(bankUi.uiClass.exchangeType == ExchangeTypeEnum.BANK))))))
            {
                lbl_kamas.handCursor = false;
                lbl_kamas.useHandCursor = false;
                uiApi.removeComponentHook(lbl_kamas, ComponentHookList.ON_RELEASE);
            };
            btn_moveAllToLeft.disabled = playerApi.hasDebt();
            this.onInventoryUpdate(inventory, kamas);
            this.onPlayerInventoryWeight(inventoryWeight, shopWeight, weightMax);
            this.releaseHooks();
        }

        protected function onPlayerInventoryWeight(inventoryWeight:uint, shopWeight:uint, maxWeight:uint):void
        {
            var value:Number;
            var valueInventory:Number;
            _weight = inventoryWeight;
            _shopWeight = shopWeight;
            _weightMax = maxWeight;
            if ((((tx_weightBar) && (this.pb_inventoryWeight)) && (this.pb_shopWeight)))
            {
                value = ((inventoryWeight + shopWeight) / maxWeight);
                valueInventory = (inventoryWeight / maxWeight);
                if (value >= 1)
                {
                    value = 1;
                    this.drawWeightNotif(false, true);
                }
                else
                {
                    if (value >= 0.75)
                    {
                        this.drawWeightNotif(true, false);
                    }
                    else
                    {
                        this.drawWeightNotif(false, false);
                    };
                };
                tx_weightBar.gotoAndStop = 0;
                this.pb_shopWeight.barBgAlpha = 0;
                this.pb_inventoryWeight.barBgAlpha = 0;
                this.pb_weightSeparator.barBgAlpha = 0;
                this.pb_shopWeight.value = value;
                this.pb_inventoryWeight.value = valueInventory;
                this.pb_weightSeparator.value = (((valueInventory < 0.99) || (valueInventory > 0.1)) ? (valueInventory + 0.01) : 0);
            };
        }

        override public function unload():void
        {
            sysApi.removeHook(StorageViewContent);
            sysApi.removeHook(KamasUpdate);
            sysApi.removeHook(InventoryWeight);
            if (((!(uiApi.getUi(UIEnum.SMILEY_UI))) && (sysApi.isFightContext())))
            {
                sysApi.dispatchHook(ShortcutsMovementAllowed, false);
            };
            super.unload();
        }

        override public function onUiLoaded(name:String):void
        {
            super.onUiLoaded(name);
            if (((name == uiApi.me().name) && (this.btn_itemsFilter)))
            {
                _storageBehavior.filterStatus(this.btn_itemsFilter.selected);
            };
        }

        override public function onRelease(target:Object):void
        {
            var contextMenu:Array;
            switch (target)
            {
                case btnAll:
                case btnEquipable:
                case btnConsumables:
                case btnRessources:
                    sysApi.setData("lastStorageTab", target.name);
                    break;
                case btnQuest:
                    sysApi.setData("lastStorageTab", target.name);
                    onReleaseCategoryFilter(btnQuest);
                    break;
                case btn_moveAllToLeft:
                case btn_moveAllToRight:
                    contextMenu = new Array();
                    contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getAll"), _storageBehavior.transfertAll, null, false, null, false, true));
                    contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getVisible"), _storageBehavior.transfertList, null, false, null, false, true));
                    contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getExisting"), _storageBehavior.transfertExisting, null, false, null, false, true));
                    modContextMenu.createContextMenu(contextMenu);
                    break;
                case this.btn_itemsFilter:
                    _storageBehavior.filterStatus(this.btn_itemsFilter.selected);
                    break;
                case btn_help:
                    if (!btnHelpClickAlreadyTreated)
                    {
                        hintsApi.showSubHints();
                        btnHelpClickAlreadyTreated = true;
                    };
                    break;
            };
            super.onRelease(target);
        }

        override public function onRollOver(target:Object):void
        {
            var text:String;
            var percentStorage:Number;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            switch (target)
            {
                case btnQuest:
                    text = uiApi.getText("ui.common.quest.objects");
                    break;
                case btn_moveAllToLeft:
                case btn_moveAllToRight:
                    text = uiApi.getText("ui.storage.advancedTransferts");
                    break;
                case tx_weightBar:
                case this.pb_inventoryWeight:
                case this.pb_shopWeight:
                case this.pb_weightSeparator:
                    if (!_hasSlot)
                    {
                        percentStorage = Math.floor((((_weight + _shopWeight) * 100) / _weightMax));
                        text = uiApi.getText("ui.common.player.inventoryWeight", utilApi.kamasToString((_weight + _shopWeight), ""), utilApi.kamasToString(_weightMax, ""), utilApi.kamasToString(_weight, ""), utilApi.kamasToString(_shopWeight, ""), ((percentStorage > 100) ? 100 : percentStorage));
                    };
                    break;
                case this.tx_notifHighWeight:
                    if (!_hasSlot)
                    {
                        text = uiApi.getText("ui.common.player.highWeight");
                    };
                    break;
                case this.tx_notifFullWeight:
                    if (!_hasSlot)
                    {
                        text = uiApi.getText("ui.common.player.fullWeight");
                    };
            };
            if (text)
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            }
            else
            {
                super.onRollOver(target);
            };
        }

        override public function getButtonFromCategory(category:int):ButtonContainer
        {
            switch (category)
            {
                case ItemCategoryEnum.QUEST_CATEGORY:
                    return (btnQuest);
                default:
                    return (super.getButtonFromCategory(category));
            };
        }

        override public function getCategoryFromButton(button:ButtonContainer):int
        {
            switch (button)
            {
                case btnQuest:
                    return (ItemCategoryEnum.QUEST_CATEGORY);
                default:
                    return (super.getCategoryFromButton(button));
            };
        }

        public function showFilter(buttonText:String, selected:Boolean):void
        {
            if (this.btn_itemsFilter)
            {
                this.btn_itemsFilter.visible = true;
                ctr_common.y = -26;
                ctr_window.height = 850;
                this.btn_label_btn_itemsFilter.text = buttonText;
                this.btn_itemsFilter.selected = selected;
                uiApi.me().render();
            };
        }

        public function hideFilter():void
        {
            if (this.btn_itemsFilter)
            {
                this.btn_itemsFilter.visible = false;
            };
        }

        override protected function onInventoryUpdate(pItems:Object, pKama:Number):void
        {
            _ignoreQuestItems = (!(questVisible));
            super.onInventoryUpdate(pItems, pKama);
        }

        override protected function getStorageTypes(categoryFilter:int):Object
        {
            return (storageApi.getStorageTypes(categoryFilter));
        }

        override protected function releaseHooks():void
        {
            storageApi.releaseHooks();
        }

        override protected function sortOn(property:int, numeric:Boolean=false):void
        {
            storageApi.resetSort();
            this.addSort(property);
        }

        override protected function addSort(property:int):void
        {
            storageApi.sort(property, false);
            this.releaseHooks();
        }

        override protected function getSortFields():Object
        {
            return (storageApi.getSortFields());
        }

        override protected function initSound():void
        {
            btnQuest.soundId = SoundEnum.TAB;
            super.initSound();
        }

        private function drawWeightNotif(high:Boolean, full:Boolean):void
        {
            this.tx_notifHighWeight.visible = high;
            this.tx_notifFullWeight.visible = full;
        }


    }
}

