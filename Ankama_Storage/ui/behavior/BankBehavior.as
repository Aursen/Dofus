package Ankama_Storage.ui.behavior
{
    import Ankama_Storage.ui.AbstractStorageUi;
    import Ankama_Storage.Api;
    import d2actions.ExchangeObjectMove;
    import d2actions.ExchangeObjectMoveKama;
    import d2hooks.ClickItemInventory;
    import d2hooks.ShowObjectLinked;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import Ankama_Storage.ui.enum.StorageState;
    import d2actions.ExchangeObjectTransfertAllFromInv;
    import d2actions.ExchangeObjectTransfertListFromInv;
    import d2actions.ExchangeObjectTransfertExistingFromInv;
    import d2hooks.*;
    import d2actions.*;

    public class BankBehavior implements IStorageBehavior 
    {

        protected var _storage:AbstractStorageUi;
        private var _objectToExchange:Object;


        public function filterStatus(enabled:Boolean):void
        {
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            return (true);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
            var quantityMax:uint;
            var weightLeft:uint;
            if (this.dropValidator(target, data, source))
            {
                if (data.quantity > 1)
                {
                    this._objectToExchange = data;
                    quantityMax = data.quantity;
                    weightLeft = (this._storage.getWeightMax() - this._storage.getWeight());
                    if ((data.realWeight * data.quantity) > weightLeft)
                    {
                        quantityMax = uint(Math.floor((weightLeft / data.realWeight)));
                    };
                    Api.common.openQuantityPopup(1, quantityMax, quantityMax, this.onValidNegativQty);
                }
                else
                {
                    Api.system.sendAction(new ExchangeObjectMove(data.objectUID, -1));
                };
            };
        }

        private function onValidNegativQty(qty:Number):void
        {
            Api.system.sendAction(new ExchangeObjectMove(this._objectToExchange.objectUID, -(qty)));
        }

        public function onValidQtyDrop(qty:Number):void
        {
        }

        private function onValidQty(qty:Number):void
        {
            Api.system.sendAction(new ExchangeObjectMove(this._objectToExchange.objectUID, qty));
        }

        private function onValidQtyKama(qty:Number):void
        {
            Api.system.sendAction(new ExchangeObjectMoveKama(qty));
        }

        public function onRelease(target:Object):void
        {
            var kamas:Number;
            var bankUiKamaVisible:Boolean;
            switch (target)
            {
                case this._storage.lbl_kamas:
                    Api.ui.hideTooltip();
                    kamas = Api.player.characteristics().kamas;
                    bankUiKamaVisible = this._storage.uiApi.getUi("bank").uiClass.isCtrKamaVisible();
                    if (((kamas > 0) && (bankUiKamaVisible)))
                    {
                        Api.common.openQuantityPopup(1, kamas, kamas, this.onValidQtyKama);
                    };
                    break;
            };
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
                            Api.system.dispatchHook(ClickItemInventory, item);
                            if (!Api.system.getOption("displayTooltips", "dofus"))
                            {
                                Api.system.dispatchHook(ShowObjectLinked, item);
                            };
                            break;
                        case SelectMethodEnum.DOUBLE_CLICK:
                            Api.ui.hideTooltip();
                            if (Api.inventory.getItem(item.objectUID))
                            {
                                Api.system.sendAction(new ExchangeObjectMove(item.objectUID, 1));
                            };
                            break;
                        case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                            if (Api.inventory.getItem(item.objectUID))
                            {
                                Api.system.sendAction(new ExchangeObjectMove(item.objectUID, item.quantity));
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

        public function attach(storageUi:AbstractStorageUi):void
        {
            this._storage = storageUi;
            Api.system.disableWorldInteraction();
            this._storage.questVisible = false;
            this._storage.btn_moveAllToLeft.visible = true;
            var kamas:Number = Api.player.characteristics().kamas;
            if (kamas > 0)
            {
                this._storage.lbl_kamas.mouseEnabled = true;
                this._storage.lbl_kamas.handCursor = true;
            };
        }

        public function detach():void
        {
            Api.system.enableWorldInteraction();
            this._storage.questVisible = true;
            this._storage.btn_moveAllToLeft.visible = false;
        }

        public function onUnload():void
        {
            Api.ui.unloadUi(UIEnum.BANK_UI);
        }

        public function getStorageUiName():String
        {
            return (UIEnum.STORAGE_UI);
        }

        public function getName():String
        {
            return (StorageState.BANK_MOD);
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


    }
}

