package Ankama_Storage.ui.behavior
{
    import Ankama_Storage.Api;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import Ankama_Storage.ui.AbstractStorageUi;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import Ankama_Storage.ui.enum.StorageState;
    import d2actions.ExchangeObjectTransfertAllFromInv;
    import d2actions.ExchangeObjectTransfertListFromInv;
    import d2actions.ExchangeObjectTransfertExistingFromInv;
    import d2actions.*;

    public class SmithMagicCoopBehavior extends SmithMagicBehavior 
    {


        override public function attach(storageUi:AbstractStorageUi):void
        {
            super.attach(storageUi);
            var uiObject:Object = Api.ui.getUi("smithMagic");
            if (!uiObject)
            {
                throw (new Error("On attach un SmithMagicCoopBehavior sur une UI pas chargé"));
            };
            if (uiObject.uiClass.isCrafter)
            {
                _storage.btnAll.disabled = true;
                _storage.btnEquipable.disabled = true;
                _storage.btnConsumables.disabled = true;
                _storage.categoryFilter = ItemCategoryEnum.RESOURCES_CATEGORY;
            }
            else
            {
                _storage.btn_moveAllToLeft.visible = true;
            };
        }

        override public function detach():void
        {
            super.detach();
            _storage.btnAll.disabled = false;
            _storage.btnEquipable.disabled = false;
            _storage.btnConsumables.disabled = false;
            _storage.btn_moveAllToLeft.visible = true;
        }

        override public function getMainUiName():String
        {
            return (UIEnum.SMITH_MAGIC);
        }

        override public function getName():String
        {
            return (StorageState.SMITH_MAGIC_COOP_MOD);
        }

        override public function transfertAll():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertAllFromInv());
        }

        override public function transfertList():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertListFromInv(_storage.itemsDisplayed));
        }

        override public function transfertExisting():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertExistingFromInv());
        }


    }
} Ankama_Storage.ui.behavior

