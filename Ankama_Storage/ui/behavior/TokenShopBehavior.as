package Ankama_Storage.ui.behavior
{
    import Ankama_Storage.ui.StorageUi;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import Ankama_Storage.ui.AbstractStorageUi;
    import Ankama_Storage.Api;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import Ankama_Storage.ui.enum.StorageState;

    public class TokenShopBehavior implements IStorageBehavior 
    {

        private var _storage:StorageUi;


        public function filterStatus(enabled:Boolean):void
        {
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
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
        }

        public function attach(storageUi:AbstractStorageUi):void
        {
            if (!(storageUi is StorageUi))
            {
                throw (new Error("Can't attach a BidHouseBehavior to a non StorageUi storage"));
            };
            this._storage = (storageUi as StorageUi);
            this._storage.setDropAllowed(false, "behavior");
            this._storage.btn_moveAllToRight.visible = false;
            this._storage.ignoreSubFilterInMain = true;
            this._storage.saveCategory = false;
            this._storage.categoryFilter = ItemCategoryEnum.QUEST_CATEGORY;
            this._storage.subFilter = AbstractStorageUi.SUBFILTER_ID_TOKEN;
            this._storage.saveCategory = true;
        }

        public function detach():void
        {
            this._storage.setDropAllowed(true, "behavior");
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
            return (StorageState.TOKEN_SHOP_MOD);
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

