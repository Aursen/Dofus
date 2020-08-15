package Ankama_Storage.ui.behavior
{
    import Ankama_Storage.ui.StorageUi;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import Ankama_Storage.Api;
    import d2actions.ExchangeObjectMove;
    import d2hooks.ObjectSelected;
    import d2hooks.ClickItemInventory;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import d2hooks.DoubleClickItemInventory;
    import Ankama_Storage.ui.AbstractStorageUi;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import Ankama_Storage.ui.enum.StorageState;
    import d2actions.ExchangeObjectTransfertAllFromInv;
    import d2actions.ExchangeObjectTransfertListFromInv;
    import d2actions.ExchangeObjectTransfertExistingFromInv;
    import d2hooks.AskExchangeMoveObject;
    import d2hooks.*;
    import d2actions.*;

    public class ExchangeBehavior implements IStorageBehavior 
    {

        private var _storage:StorageUi;
        private var _objectToExchange:Object;


        public function filterStatus(enabled:Boolean):void
        {
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            if ((((data is ItemWrapper) && (!(this._storage.categoryFilter == ItemCategoryEnum.QUEST_CATEGORY))) && (!(target.getUi().name == source.getUi().name))))
            {
                return (true);
            };
            return (false);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
            if (data.quantity > 1)
            {
                this._objectToExchange = data;
                Api.common.openQuantityPopup(1, data.quantity, data.quantity, this.onValidQtyDrop);
            }
            else
            {
                Api.system.sendAction(new ExchangeObjectMove(data.objectUID, -(data.quantity)));
            };
        }

        public function onValidQtyDrop(qty:Number):void
        {
            Api.system.sendAction(new ExchangeObjectMove(this._objectToExchange.objectUID, -(qty)));
        }

        private function onValidQty(qty:Number):void
        {
            this.transfertObject(this._objectToExchange.objectUID, qty);
        }

        public function onRelease(target:Object):void
        {
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var item:Object;
            switch (target)
            {
                case this._storage.grid:
                    item = this._storage.grid.selectedItem;
                    switch (selectMethod)
                    {
                        case SelectMethodEnum.CLICK:
                            Api.system.dispatchHook(ObjectSelected, item);
                            Api.system.dispatchHook(ClickItemInventory, item);
                            break;
                        case SelectMethodEnum.DOUBLE_CLICK:
                            Api.ui.hideTooltip();
                            if (Api.inventory.getItem(item.objectUID))
                            {
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
                            this._objectToExchange = target.selectedItem;
                            Api.common.openQuantityPopup(1, target.selectedItem.quantity, target.selectedItem.quantity, this.onValidQty);
                            break;
                    };
                    break;
            };
        }

        public function main(params:Object):void
        {
        }

        public function attach(storageUi:AbstractStorageUi):void
        {
            if (!(storageUi is StorageUi))
            {
                throw (new Error("Can't attach a ExchangeBehavior to a non StorageUi storage"));
            };
            this._storage = (storageUi as StorageUi);
            this._storage.questVisible = false;
            this._storage.btn_moveAllToLeft.visible = true;
        }

        public function detach():void
        {
            this._storage.questVisible = true;
            Api.ui.unloadUi(UIEnum.EXCHANGE_UI);
        }

        public function onUnload():void
        {
        }

        public function getStorageUiName():String
        {
            return (UIEnum.STORAGE_UI);
        }

        public function getName():String
        {
            return (StorageState.EXCHANGE_MOD);
        }

        public function get replacable():Boolean
        {
            return (false);
        }

        public function transfertAll():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertAllFromInv());
        }

        public function transfertList():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertListFromInv(this._storage.itemsDisplayed));
        }

        public function transfertExisting():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertExistingFromInv());
        }

        public function doubleClickGridItem(pItem:Object):void
        {
        }

        private function transfertObject(pObjectUID:uint, pQuantity:int):void
        {
            Api.system.dispatchHook(AskExchangeMoveObject, pObjectUID, pQuantity);
            Api.system.sendAction(new ExchangeObjectMove(pObjectUID, pQuantity));
        }


    }
}

