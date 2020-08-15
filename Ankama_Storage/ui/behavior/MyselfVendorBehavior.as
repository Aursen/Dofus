package Ankama_Storage.ui.behavior
{
    import Ankama_Storage.Api;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import Ankama_Storage.ui.enum.StorageState;

    public class MyselfVendorBehavior extends HumanVendorBehavior 
    {


        override public function detach():void
        {
            Api.ui.unloadUi(UIEnum.MYSELF_VENDOR_STOCK);
            super.detach();
        }

        override public function getName():String
        {
            return (StorageState.MYSELF_VENDOR_MOD);
        }


    }
}

