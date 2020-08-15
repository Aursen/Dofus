package Ankama_Storage.ui.behavior.temporis
{
    import Ankama_Storage.ui.behavior.IStorageBehavior;
    import Ankama_Storage.ui.InventoryUi;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import Ankama_Storage.Api;
    import d2hooks.SearchTemporisSpellScroll;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import Ankama_Storage.ui.AbstractStorageUi;
    import Ankama_Storage.ui.enum.StorageState;
    import Ankama_Storage.ui.behavior.*;

    public class TemporisSpellsUiBehavior implements IStorageBehavior 
    {

        private static const FILTER_STATUS_DATA_KEY:String = "filterTemporisSpellsUiStorage";

        private var _storage:InventoryUi;
        private var _inventoryUI:UiRootContainer;
        private var _defaultSetOnTopOnClick:Boolean;


        public function filterStatus(enabled:Boolean):void
        {
            Api.system.setData(FILTER_STATUS_DATA_KEY, enabled);
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
        }

        public function attach(storageUi:AbstractStorageUi):void
        {
            if (!(storageUi is InventoryUi))
            {
                throw (new Error("Can't attach a TemporisSpellsUiBehavior to a non-InventoryUi storage"));
            };
            if (this._storage === storageUi)
            {
                return;
            };
            this._storage = (storageUi as InventoryUi);
            Api.system.addHook(SearchTemporisSpellScroll, this.onSearchTemporisSpellScroll);
            Api.system.disableWorldInteraction();
            this._inventoryUI = Api.ui.getUi(UIEnum.STORAGE_UI);
            if (this._inventoryUI !== null)
            {
                this._defaultSetOnTopOnClick = this._inventoryUI.setOnTopOnClick;
                this._inventoryUI.setOnTopOnClick = false;
            };
            this._storage.questVisible = false;
            this._storage.ignoreSubFilterInMain = true;
            this._storage.saveCategory = true;
            this._storage.categoryFilter = ItemCategoryEnum.CONSUMABLES_CATEGORY;
            this._storage.setDropAllowed(false, "behavior");
            this._storage.btn_moveAllToLeft.visible = false;
            this._storage.forceCategory(DataEnum.ITEM_TYPE_TEMPORIS_SPELL_SCROLL);
            this._storage.btn_checkCraft.visible = false;
            this._storage.showFilter(Api.ui.getText("ui.temporis.hideLearnedSpells"), Api.system.getData(FILTER_STATUS_DATA_KEY));
            this.refreshFilter();
        }

        public function detach():void
        {
            Api.system.enableWorldInteraction();
            Api.storage.disableTemporisSpellsFilter();
            if (this._inventoryUI !== null)
            {
                this._inventoryUI.setOnTopOnClick = this._defaultSetOnTopOnClick;
            };
            this._storage.unforceCategory();
            this._storage.questVisible = true;
            this._storage.setDropAllowed(true, "behavior");
            this._storage.hideFilter();
            this._storage.btn_moveAllToLeft.visible = true;
        }

        public function onUnload():void
        {
            var temporisSpellsUi:* = Api.ui.getUi(UIEnum.TEMPORIS_SPELLS_UI);
            if (temporisSpellsUi !== null)
            {
                Api.ui.unloadUi(UIEnum.TEMPORIS_SPELLS_UI);
            };
        }

        private function refreshFilter():void
        {
            Api.storage.enableTemporisSpellsFilter([DataEnum.ITEM_TYPE_TEMPORIS_SPELL_SCROLL, DataEnum.ITEM_TYPE_TEMPORIS_HIDDEN_SPELL], this._storage.btn_itemsFilter.selected);
            Api.storage.updateStorageView();
            Api.storage.releaseHooks();
        }

        public function getStorageUiName():String
        {
            return (UIEnum.INVENTORY_UI);
        }

        public function getName():String
        {
            return (StorageState.TEMPORIS_SPELLS_UI_MOD);
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

        public function onSearchTemporisSpellScroll(scrollSearch:String):void
        {
            if (this._storage.inp_search === null)
            {
                return;
            };
            this._storage.inp_search.text = scrollSearch;
            this._storage.search(scrollSearch);
        }

        public function doubleClickGridItem(item:Object):void
        {
            if (((!(item === null)) && ((item.usable) || (item.targetable))))
            {
                this._storage.useItem(item);
            };
        }


    }
}

