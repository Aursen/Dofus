package Ankama_Storage.ui.behavior
{
    import Ankama_Storage.ui.StorageUi;
    import flash.utils.getTimer;
    import Ankama_Storage.Api;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2hooks.DoubleClickItemInventory;
    import d2hooks.ObjectSelected;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import Ankama_Storage.ui.AbstractStorageUi;
    import d2actions.CloseInventory;
    import d2hooks.ExchangeLeave;
    import Ankama_Storage.ui.enum.StorageState;
    import d2hooks.*;

    public class SmithMagicBehavior implements IStorageBehavior 
    {

        protected var _storage:StorageUi;
        protected var _uiName:String;
        protected var _objectToExchange:Object;
        protected var _filter:Boolean = false;
        protected var _smithMagicUi:Object = null;
        public var timer:int = getTimer();


        public function get smithMagicUi():Object
        {
            var smUi:Object;
            if (!this._smithMagicUi)
            {
                smUi = Api.ui.getUi(this.getMainUiName());
                if (smUi)
                {
                    this._smithMagicUi = smUi.uiClass;
                };
            };
            return (this._smithMagicUi);
        }

        public function filterStatus(enabled:Boolean):void
        {
            Api.system.setData("filterSmithMagicStorage", this._storage.btn_itemsFilter.selected);
            this.refreshFilter();
        }

        public function get filterEnabled():Boolean
        {
            return (false);
        }

        public function getMainUiName():String
        {
            return (UIEnum.SMITH_MAGIC);
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            return (true);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
            Api.ui.getUi(this.getMainUiName()).uiClass.processDropToInventory(target, data, source);
        }

        private function onValidQtyDrop(qty:Number):void
        {
            Api.ui.getUi("smithMagic").uiClass.unfillSelectedSlot(qty);
        }

        private function onValidQty(qty:Number):void
        {
            Api.system.dispatchHook(DoubleClickItemInventory, this._objectToExchange, qty);
        }

        public function onRelease(target:Object):void
        {
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var item:Object;
            if (!this._storage)
            {
                return;
            };
            switch (target)
            {
                case this._storage.grid:
                    item = this._storage.grid.selectedItem;
                    switch (selectMethod)
                    {
                        case SelectMethodEnum.CLICK:
                            if (!Api.system.getOption("displayTooltips", "dofus"))
                            {
                                Api.system.dispatchHook(ObjectSelected, {"data":item});
                            };
                            break;
                        case SelectMethodEnum.DOUBLE_CLICK:
                            if (Api.inventory.getItem(item.objectUID))
                            {
                                Api.ui.hideTooltip();
                                Api.system.dispatchHook(DoubleClickItemInventory, item, 1);
                            };
                            break;
                        case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                            if (Api.inventory.getItem(item.objectUID))
                            {
                                Api.system.dispatchHook(DoubleClickItemInventory, item, item.quantity);
                            };
                            break;
                        case SelectMethodEnum.ALT_DOUBLE_CLICK:
                            this._objectToExchange = item;
                            Api.common.openQuantityPopup(1, item.quantity, item.quantity, this.onValidQty);
                            break;
                    };
                    break;
            };
        }

        public function attach(storageUi:AbstractStorageUi):void
        {
            if (!(storageUi is StorageUi))
            {
                throw (new Error("Can't attach a BidHouseBehavior to a non StorageUi storage"));
            };
            this._storage = (storageUi as StorageUi);
            Api.system.disableWorldInteraction();
            this._storage.btn_moveAllToLeft.visible = false;
            this._storage.questVisible = false;
            this._storage.showFilter(Api.ui.getText("ui.craft.smithMagicFilter"), Api.system.getData("filterSmithMagicStorage"));
            if (this.smithMagicUi)
            {
                this.refreshFilter();
            };
        }

        public function detach():void
        {
            this._storage.btn_moveAllToLeft.visible = true;
            this._storage.questVisible = true;
            this._storage.hideFilter();
            Api.system.sendAction(new CloseInventory());
        }

        public function onUnload():void
        {
            Api.storage.disableSmithMagicFilter();
            Api.system.removeHook(ExchangeLeave);
            Api.ui.unloadUi("smithMagic");
        }

        public function onUiLoaded(name:String):void
        {
            switch (name)
            {
                case "smithMagic":
                    this._storage.updateInventory();
                    this.refreshFilter();
                    break;
            };
        }

        private function refreshFilter():void
        {
            if (this._storage.btn_itemsFilter.selected)
            {
                Api.storage.enableSmithMagicFilter(this.smithMagicUi.skill);
            }
            else
            {
                Api.storage.disableSmithMagicFilter();
            };
            Api.storage.updateStorageView();
            Api.storage.releaseHooks();
        }

        public function getStorageUiName():String
        {
            return (UIEnum.STORAGE_UI);
        }

        public function getName():String
        {
            return (StorageState.SMITH_MAGIC_MOD);
        }

        public function get replacable():Boolean
        {
            return (false);
        }

        public function transfertAll():void
        {
        }

        public function transfertList():void
        {
        }

        public function transfertExisting():void
        {
        }

        public function doubleClickGridItem(pItem:Object):void
        {
        }


    }
}

