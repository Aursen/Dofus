package Ankama_Storage.ui.behavior
{
    import Ankama_Storage.ui.StorageUi;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankama.dofus.enums.ActionIds;
    import Ankama_Storage.Api;
    import d2hooks.ClickItemInventory;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import Ankama_Storage.ui.AbstractStorageUi;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import Ankama_Storage.ui.enum.StorageState;
    import d2hooks.*;

    public class ShopBehavior implements IStorageBehavior 
    {

        private var _storage:StorageUi;


        public function filterStatus(enabled:Boolean):void
        {
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            if (((data is ItemWrapper) && (!(this._storage.categoryFilter == ItemCategoryEnum.QUEST_CATEGORY))))
            {
                if (data.position != 63)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
        }

        public function onValidQtyDrop(qty:Number):void
        {
        }

        public function onValidQty(qty:Number):void
        {
        }

        public function onRelease(target:Object):void
        {
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var item:Object;
            var exchangeOk:Boolean;
            var effect:*;
            switch (target)
            {
                case this._storage.grid:
                    item = this._storage.grid.selectedItem;
                    exchangeOk = true;
                    if ((item is ItemWrapper))
                    {
                        for each (effect in item.effects)
                        {
                            if (((effect.effectId == ActionIds.ACTION_MARK_NEVER_TRADABLE) || (effect.effectId == ActionIds.ACTION_MARK_NOT_TRADABLE)))
                            {
                                exchangeOk = false;
                            };
                        };
                    }
                    else
                    {
                        exchangeOk = false;
                    };
                    switch (selectMethod)
                    {
                        case SelectMethodEnum.CLICK:
                            if (exchangeOk)
                            {
                                Api.system.dispatchHook(ClickItemInventory, item);
                            }
                            else
                            {
                                Api.system.dispatchHook(ClickItemInventory, null);
                            };
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
            this._storage.setDropAllowed(false, "behavior");
            this._storage.questVisible = false;
            this._storage.btn_moveAllToRight.visible = false;
        }

        public function detach():void
        {
            this._storage.setDropAllowed(true, "behavior");
            this._storage.questVisible = true;
            this._storage.btn_moveAllToRight.visible = true;
            Api.ui.unloadUi(UIEnum.NPC_STOCK);
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
            return (StorageState.SHOP_MOD);
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
} Ankama_Storage.ui.behavior

