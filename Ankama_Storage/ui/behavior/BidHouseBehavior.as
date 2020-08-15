package Ankama_Storage.ui.behavior
{
    import Ankama_Storage.ui.StorageUi;
    import Ankama_Storage.Api;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import d2actions.MountInfoRequest;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import Ankama_Storage.ui.AbstractStorageUi;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2actions.LeaveShopStock;
    import Ankama_Storage.ui.enum.StorageState;
    import d2actions.*;

    public class BidHouseBehavior implements IStorageBehavior 
    {

        private var _storage:StorageUi;


        public function filterStatus(enabled:Boolean):void
        {
            Api.system.setData("filterBidHouseStorage", enabled);
            this.refreshFilter();
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            return (false);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
        }

        public function onRelease(target:Object):void
        {
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var selectedItem:Object;
            switch (target)
            {
                case this._storage.grid:
                    selectedItem = this._storage.grid.selectedItem;
                    if (((selectMethod == SelectMethodEnum.CLICK) && (Api.ui.getUi("itemBidHouseSell"))))
                    {
                        Api.ui.getUi("itemBidHouseSell").uiClass.onSelectItemFromInventory(selectedItem);
                    }
                    else
                    {
                        if (((selectMethod == SelectMethodEnum.CLICK) && (Api.ui.getUi("auctionHouseSell"))))
                        {
                            Api.ui.getUi("auctionHouseSell").uiClass.onSelectItemFromInventory(selectedItem);
                        }
                        else
                        {
                            if (((selectMethod == SelectMethodEnum.CLICK) && (Api.ui.getUi("auctionHouseBuy"))))
                            {
                                Api.ui.getUi("auctionHouseBuy").uiClass.onSelectItemFromInventory(selectedItem, false, true);
                            }
                            else
                            {
                                if (selectMethod == SelectMethodEnum.DOUBLE_CLICK)
                                {
                                    Api.ui.hideTooltip();
                                    if (((((selectedItem) && (!(selectedItem.category == 0))) && (selectedItem.hasOwnProperty("isCertificate"))) && (selectedItem.isCertificate)))
                                    {
                                        Api.system.sendAction(new MountInfoRequest(selectedItem));
                                    };
                                };
                            };
                        };
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
            if (this._storage == storageUi)
            {
                return;
            };
            this._storage = (storageUi as StorageUi);
            Api.system.disableWorldInteraction();
            this._storage.questVisible = false;
            var uiroot:* = Api.ui.getUi("auctionHouseBuy").uiClass;
            if (uiroot)
            {
                switch (uiroot.currentType)
                {
                    case 1:
                    case 6:
                        this._storage.categoryFilter = ItemCategoryEnum.EQUIPMENT_CATEGORY;
                        break;
                    case 2:
                        this._storage.categoryFilter = ItemCategoryEnum.CONSUMABLES_CATEGORY;
                        break;
                    case 3:
                    case 4:
                        this._storage.categoryFilter = ItemCategoryEnum.RESOURCES_CATEGORY;
                        break;
                    case 5:
                        this._storage.categoryFilter = ItemCategoryEnum.ALL_CATEGORY;
                        break;
                };
            };
            this._storage.setDropAllowed(false, "behavior");
            this._storage.btn_moveAllToLeft.visible = false;
            this._storage.showFilter(Api.ui.getText("ui.bidhouse.bigStoreFilter"), Api.system.getData("filterBidHouseStorage"));
            this.refreshFilter();
        }

        public function detach():void
        {
            Api.system.enableWorldInteraction();
            Api.storage.disableBidHouseFilter();
            this._storage.questVisible = true;
            this._storage.setDropAllowed(true, "behavior");
            this._storage.hideFilter();
            this._storage.btn_moveAllToLeft.visible = true;
        }

        public function onUnload():void
        {
            if (((Api.ui.getUi(UIEnum.AUCTIONHOUSE)) && (!(Api.ui.getUi(UIEnum.AUCTIONHOUSE).uiClass.isSwitching()))))
            {
                Api.system.sendAction(new LeaveShopStock());
                Api.ui.unloadUi(UIEnum.AUCTIONHOUSE);
            };
        }

        private function refreshFilter():void
        {
            var uisell:Object;
            var uiclass:Object;
            var info:Object;
            if ((((this._storage.btn_itemsFilter.selected) && (Api.ui.getUi("itemBidHouseSell"))) && (Api.ui.getUi("itemBidHouseSell").uiClass)))
            {
                uisell = Api.ui.getUi("itemBidHouseSell");
                uiclass = uisell.uiClass;
                info = uiclass._sellerDescriptor;
                Api.storage.enableBidHouseFilter(info.types, info.maxItemLevel);
            }
            else
            {
                if ((((this._storage.btn_itemsFilter.selected) && (Api.ui.getUi("auctionHouse"))) && (Api.ui.getUi("auctionHouse").uiClass)))
                {
                    uisell = Api.ui.getUi("auctionHouse");
                    uiclass = uisell.uiClass;
                    info = uiclass._sellerDescriptor;
                    if (info == null)
                    {
                        Api.system.log(16, (("Class " + uiclass) + " doesn't have a sellerDescriptor"));
                        Api.storage.disableBidHouseFilter();
                    }
                    else
                    {
                        Api.storage.enableBidHouseFilter(info.types, info.maxItemLevel);
                    };
                }
                else
                {
                    Api.storage.disableBidHouseFilter();
                };
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
            return (StorageState.BID_HOUSE_MOD);
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

