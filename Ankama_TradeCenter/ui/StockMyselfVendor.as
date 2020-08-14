package Ankama_TradeCenter.ui
{
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import d2hooks.ExchangeShopStockUpdate;
    import d2hooks.ExchangeLeave;
    import d2hooks.ExchangeShopStockMovementRemoved;
    import d2hooks.ClickItemInventory;
    import d2hooks.ClickItemShopHV;
    import d2hooks.ExchangeShopStockAddQuantity;
    import d2hooks.ExchangeShopStockRemoveQuantity;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import d2actions.ExchangeObjectModifyPriced;
    import d2actions.MountInfoRequest;
    import d2actions.ExchangeShowVendorTax;

    public class StockMyselfVendor extends Stock 
    {

        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        public var btn_center:ButtonContainer;
        public var btn_lbl_btn_center:Label;
        private var _item:Object;
        private var _objectToRemove:Object;


        override public function main(params:Object=null):void
        {
            super.main({
                "objects":params.objects,
                "look":params.look
            });
            sysApi.addHook(ExchangeShopStockUpdate, this.onExchangeShopStockUpdate);
            sysApi.addHook(ExchangeLeave, this.onExchangeLeave);
            sysApi.addHook(ExchangeShopStockMovementRemoved, this.onExchangeShopStockMovementRemoved);
            sysApi.addHook(ClickItemInventory, this.onClickItemInventory);
            sysApi.addHook(ClickItemShopHV, this.onClickItemShopHV);
            sysApi.addHook(ExchangeShopStockAddQuantity, this.onExchangeShopStockAddQuantity);
            sysApi.addHook(ExchangeShopStockRemoveQuantity, this.onExchangeShopStockRemoveQuantity);
            sysApi.disableWorldInteraction();
            ctr_center.visible = true;
            lbl_title.text = uiApi.getText("ui.common.shop");
            this.btn_lbl_btn_center.text = uiApi.getText("ui.humanVendor.switchToMerchantMode");
            this.btn_center.softDisabled = this.playerApi.hasDebt();
            this.btn_center.handCursor = (!(this.btn_center.softDisabled));
        }

        override public function unload():void
        {
            uiApi.unloadUi(UIEnum.MYSELF_VENDOR);
            super.unload();
        }

        private function selectItem(pItem:Object):void
        {
            var itemDP:Object;
            var compt:uint;
            for each (itemDP in gd_shop.dataProvider)
            {
                if (pItem.objectUID == itemDP.itemWrapper.objectUID)
                {
                    gd_shop.selectedIndex = compt;
                    sysApi.dispatchHook(ClickItemShopHV, pItem.itemWrapper, pItem.price);
                    gd_shop.dataProvider[compt].select();
                    return;
                };
                compt++;
            };
        }

        private function selectTab(pItem:Object):void
        {
            var filter:int = _categoriesIdByBtnName[_currentCategoryBtn.name];
            var itemObject:Object = dataApi.getItem(pItem.objectGID);
            if (((!(itemObject.category == filter)) && (!(filter == ItemCategoryEnum.ALL_CATEGORY))))
            {
                switch (itemObject.category)
                {
                    case ItemCategoryEnum.EQUIPMENT_CATEGORY:
                        _currentCategoryBtn = btnEquipable;
                        btnEquipable.selected = true;
                        break;
                    case ItemCategoryEnum.CONSUMABLES_CATEGORY:
                        _currentCategoryBtn = btnConsumables;
                        btnConsumables.selected = true;
                        break;
                    case ItemCategoryEnum.RESOURCES_CATEGORY:
                        _currentCategoryBtn = btnRessources;
                        btnRessources.selected = true;
                        break;
                    default:
                        _currentCategoryBtn = btnAll;
                        btnAll.selected = true;
                };
            };
            updateStockInventory();
        }

        protected function onExchangeShopStockUpdate(itemList:Object, newItem:Object=null):void
        {
            var item:Object;
            _objectsInStock = new Array();
            for each (item in itemList)
            {
                _objectsInStock.push(item);
            };
            _objectsInStock.sort(shopStockSort);
            if (newItem != null)
            {
                this.selectTab(newItem);
                soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
            }
            else
            {
                showTransfertUI(false);
                updateStockInventory();
            };
        }

        public function onClickItemShopHV(pItem:Object, pPrice:Number=0, method:int=0):void
        {
            this._item = pItem;
        }

        public function onClickItemInventory(pItemWrapper:Object):void
        {
            this._item = pItemWrapper;
        }

        public function onExchangeShopStockMovementRemoved(pObjectId:uint):void
        {
            if (this._item.objectUID == pObjectId)
            {
                this._item = null;
                if (gd_shop.dataProvider.length > 0)
                {
                    showTransfertUI(true);
                    gd_shop.selectedIndex = 0;
                    sysApi.dispatchHook(ClickItemShopHV, gd_shop.selectedItem.itemWrapper, gd_shop.selectedItem.price, SelectMethodEnum.FIRST_ITEM);
                }
                else
                {
                    showTransfertUI(false);
                };
            };
        }

        public function onExchangeShopStockAddQuantity():void
        {
            soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
        }

        public function onExchangeShopStockRemoveQuantity():void
        {
            soundApi.playSound(SoundTypeEnum.SWITCH_LEFT_TO_RIGHT);
        }

        override public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var item:Object;
            switch (target)
            {
                case gd_shop:
                    item = gd_shop.selectedItem;
                    switch (selectMethod)
                    {
                        case SelectMethodEnum.CLICK:
                            sysApi.dispatchHook(ClickItemShopHV, item.itemWrapper, item.price);
                            showTransfertUI(true);
                            break;
                        case SelectMethodEnum.DOUBLE_CLICK:
                            sysApi.sendAction(new ExchangeObjectModifyPriced(item.itemWrapper.objectUID, -1, item.price));
                            if ((((((item) && (item.itemWrapper)) && (!(item.itemWrapper.category == 0))) && (item.itemWrapper.hasOwnProperty("isCertificate"))) && (item.itemWrapper.isCertificate)))
                            {
                                sysApi.sendAction(new MountInfoRequest(item.itemWrapper));
                            };
                            break;
                        case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                            sysApi.sendAction(new ExchangeObjectModifyPriced(item.itemWrapper.objectUID, -(item.itemWrapper.quantity), item.price));
                            break;
                        case SelectMethodEnum.ALT_DOUBLE_CLICK:
                            this._objectToRemove = item;
                            modCommon.openQuantityPopup(1, item.itemWrapper.quantity, item.itemWrapper.quantity, this.onValidQty);
                            break;
                    };
                    break;
                case cb_category:
                    super.onSelectItem(target, selectMethod, isNewSelection);
                    break;
            };
        }

        private function onValidQty(qty:Number):void
        {
            sysApi.sendAction(new ExchangeObjectModifyPriced(this._objectToRemove.itemWrapper.objectUID, -(qty), this._objectToRemove.price));
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case btn_close:
                    uiApi.unloadUi(uiApi.me().name);
                    break;
                case this.btn_center:
                    sysApi.sendAction(new ExchangeShowVendorTax());
                    break;
            };
            super.onRelease(target);
        }

        public function onDoubleClick(target:Object):void
        {
        }

        public function onExchangeLeave(success:Boolean):void
        {
            uiApi.unloadUi(uiApi.me().name);
        }


    }
} Ankama_TradeCenter.ui

