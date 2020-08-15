package Ankama_Storage.ui.behavior
{
    import Ankama_Storage.ui.BankUi;
    import Ankama_Storage.Api;
    import d2actions.ExchangeObjectMove;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import d2hooks.ClickItemInventory;
    import d2hooks.ShowObjectLinked;
    import Ankama_Storage.ui.AbstractStorageUi;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import Ankama_Storage.ui.enum.StorageState;
    import d2actions.ExchangeObjectMoveKama;
    import d2actions.ExchangeObjectTransfertAllToInv;
    import d2actions.ExchangeObjectTransfertListToInv;
    import d2actions.ExchangeObjectTransfertExistingToInv;
    import d2hooks.*;
    import d2actions.*;

    public class BankUiBehavior implements IStorageBehavior 
    {

        protected var _bank:BankUi;
        private var _objectToExchange:Object;


        public function filterStatus(enabled:Boolean):void
        {
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            return (data.position == 63);
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
                    if (this._bank.getWeightMax() > 0)
                    {
                        weightLeft = (this._bank.getWeightMax() - this._bank.getWeight());
                        if ((data.realWeight * data.quantity) > weightLeft)
                        {
                            quantityMax = uint(Math.floor((weightLeft / data.realWeight)));
                        };
                    };
                    Api.common.openQuantityPopup(1, quantityMax, quantityMax, this.onValidQty);
                }
                else
                {
                    Api.system.sendAction(new ExchangeObjectMove(data.objectUID, 1));
                };
            };
        }

        private function onValidNegativeQty(qty:Number):void
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

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this._bank.lbl_kamas:
                    this._bank.uiApi.hideTooltip();
                    if (this._bank.kamas > 0)
                    {
                        Api.common.openQuantityPopup(1, this._bank.kamas, this._bank.kamas, this.onValidQtyKama);
                    };
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var selectedItem:Object;
            var weight:uint;
            var maxWeight:uint;
            var quantityMax:uint;
            var weightLeft:uint;
            switch (target)
            {
                case this._bank.grid:
                    selectedItem = this._bank.grid.selectedItem;
                    if (selectMethod == SelectMethodEnum.CLICK)
                    {
                        Api.system.dispatchHook(ClickItemInventory, selectedItem);
                        if (!Api.system.getOption("displayTooltips", "dofus"))
                        {
                            Api.system.dispatchHook(ShowObjectLinked, selectedItem);
                        };
                    }
                    else
                    {
                        if (selectMethod == SelectMethodEnum.DOUBLE_CLICK)
                        {
                            if (this.bankContainItem(selectedItem.objectUID))
                            {
                                Api.system.sendAction(new ExchangeObjectMove(selectedItem.objectUID, -1));
                            };
                        }
                        else
                        {
                            if (selectMethod == SelectMethodEnum.CTRL_DOUBLE_CLICK)
                            {
                                if (this.bankContainItem(selectedItem.objectUID))
                                {
                                    weight = Api.player.inventoryWeight();
                                    maxWeight = Api.player.inventoryWeightMax();
                                    quantityMax = selectedItem.quantity;
                                    weightLeft = (maxWeight - weight);
                                    if ((selectedItem.realWeight * selectedItem.quantity) > weightLeft)
                                    {
                                        quantityMax = uint(Math.floor((weightLeft / selectedItem.realWeight)));
                                    };
                                    Api.system.sendAction(new ExchangeObjectMove(selectedItem.objectUID, -(quantityMax)));
                                };
                            }
                            else
                            {
                                if (selectMethod == SelectMethodEnum.ALT_DOUBLE_CLICK)
                                {
                                    this._objectToExchange = target.selectedItem;
                                    Api.common.openQuantityPopup(1, target.selectedItem.quantity, target.selectedItem.quantity, this.onValidNegativeQty);
                                };
                            };
                        };
                    };
                    break;
            };
        }

        public function attach(bankUi:AbstractStorageUi):void
        {
            if (!(bankUi is BankUi))
            {
                throw (new Error("Can't attach a BankUiBehavior to a non BankUi storage"));
            };
            this._bank = (bankUi as BankUi);
            this._bank.questVisible = false;
            this._bank.btn_moveAllToRight.visible = true;
            this._bank.lbl_kamas.mouseEnabled = true;
            this._bank.lbl_kamas.handCursor = true;
        }

        public function detach():void
        {
            this._bank.questVisible = true;
            this._bank.btn_moveAllToRight.visible = false;
        }

        public function onUnload():void
        {
        }

        public function getStorageUiName():String
        {
            return (UIEnum.BANK_UI);
        }

        public function getName():String
        {
            return (StorageState.BANK_UI_MOD);
        }

        public function get replacable():Boolean
        {
            return (false);
        }

        private function onValidQtyKama(qty:Number):void
        {
            Api.system.sendAction(new ExchangeObjectMoveKama(-(qty)));
        }

        private function bankContainItem(uid:uint):Boolean
        {
            var i:int;
            var dataProvider:* = this._bank.grid.dataProvider;
            var len:int = dataProvider.length;
            i = 0;
            while (i < len)
            {
                if (dataProvider[i].objectUID == uid)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function transfertAll():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertAllToInv());
        }

        public function transfertList():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertListToInv(this._bank.itemsDisplayed));
        }

        public function transfertExisting():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertExistingToInv());
        }

        public function doubleClickGridItem(pItem:Object):void
        {
        }


    }
}

