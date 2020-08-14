package Ankama_TradeCenter.ui
{
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2hooks.ObjectQuantity;
    import d2hooks.ObjectDeleted;
    import d2enums.ComponentHookList;
    import d2hooks.CloseStore;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;

    public class StockNpcStore extends Stock 
    {


        override public function main(params:Object=null):void
        {
            super.main(params);
            uiApi.loadUi(UIEnum.NPC_ITEM, UIEnum.NPC_ITEM);
            sysApi.addHook(ObjectQuantity, this.onObjectQuantity);
            sysApi.addHook(ObjectDeleted, this.onObjectDeleted);
            uiApi.addComponentHook(btn_itemsFilter, ComponentHookList.ON_RELEASE);
            lbl_title.text = uiApi.getText("ui.common.shop");
            ed_merchant.look = params.look;
            tx_bgEntity.visible = true;
        }

        override public function unload():void
        {
            uiApi.unloadUi(UIEnum.NPC_ITEM);
            super.unload();
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case btn_close:
                    sysApi.dispatchHook(CloseStore);
                    break;
            };
            super.onRelease(target);
        }

        override public function onRollOver(target:Object):void
        {
            var sellItem:Object;
            super.onRollOver(target);
            var pos:Object = {
                "point":LocationEnum.POINT_RIGHT,
                "relativePoint":LocationEnum.POINT_RIGHT
            };
            var offset:int = 9;
            switch (target)
            {
                default:
                    if (target.name.indexOf("btn_item") != -1)
                    {
                        sellItem = _componentsList[target.name];
                        if ((((sellItem) && (sellItem.criterion)) && (sellItem.criterion.inlineCriteria.length > 0)))
                        {
                            uiApi.showTooltip(sellItem.criterion, target, false, "standard", pos.point, pos.relativePoint, offset, "sellCriterion");
                        };
                    };
            };
        }

        override public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            super.onSelectItem(target, selectMethod, isNewSelection);
        }

        private function onObjectQuantity(item:ItemWrapper, quantity:int, oldQuantity:int):void
        {
            if (((item.objectGID == _tokenType) && (btn_itemsFilter.selected)))
            {
                updateStockInventory();
            };
        }

        private function onObjectDeleted(item:ItemWrapper):void
        {
            if (((item.objectGID == _tokenType) && (btn_itemsFilter.selected)))
            {
                updateStockInventory();
            };
        }


    }
} Ankama_TradeCenter.ui

