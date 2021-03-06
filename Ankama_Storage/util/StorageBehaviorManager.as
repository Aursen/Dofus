package Ankama_Storage.util
{
    import Ankama_Storage.ui.behavior.BankBehavior;
    import Ankama_Storage.ui.enum.StorageState;
    import Ankama_Storage.ui.behavior.TaxCollectorBehavior;
    import Ankama_Storage.ui.behavior.BidHouseBehavior;
    import Ankama_Storage.ui.behavior.CraftBehavior;
    import Ankama_Storage.ui.behavior.DecraftBehavior;
    import Ankama_Storage.ui.behavior.ExchangeBehavior;
    import Ankama_Storage.ui.behavior.ExchangeNPCBehavior;
    import Ankama_Storage.ui.behavior.HumanVendorBehavior;
    import Ankama_Storage.ui.behavior.MyselfVendorBehavior;
    import Ankama_Storage.ui.behavior.ShopBehavior;
    import Ankama_Storage.ui.behavior.SmithMagicBehavior;
    import Ankama_Storage.ui.behavior.SmithMagicCoopBehavior;
    import Ankama_Storage.ui.behavior.StorageClassicBehavior;
    import Ankama_Storage.ui.behavior.BankUiBehavior;
    import Ankama_Storage.ui.behavior.MountBehavior;
    import Ankama_Storage.ui.behavior.TokenShopBehavior;
    import Ankama_Storage.ui.behavior.TokenStoneShopBehavior;
    import Ankama_Storage.ui.behavior.MimicryBehavior;
    import Ankama_Storage.ui.behavior.temporis.TemporisSpellsUiBehavior;
    import Ankama_Storage.ui.behavior.IStorageBehavior;

    public class StorageBehaviorManager 
    {


        public static function makeBehavior(behaviorName:String):IStorageBehavior
        {
            switch (behaviorName)
            {
                case StorageState.BANK_MOD:
                    return (new BankBehavior());
                case StorageState.TAXCOLLECTOR_MOD:
                    return (new TaxCollectorBehavior());
                case StorageState.BID_HOUSE_MOD:
                    return (new BidHouseBehavior());
                case StorageState.CRAFT_MOD:
                    return (new CraftBehavior());
                case StorageState.DECRAFT_MOD:
                    return (new DecraftBehavior());
                case StorageState.EXCHANGE_MOD:
                    return (new ExchangeBehavior());
                case StorageState.EXCHANGE_NPC_MOD:
                    return (new ExchangeNPCBehavior());
                case StorageState.HUMAN_VENDOR_MOD:
                    return (new HumanVendorBehavior());
                case StorageState.MYSELF_VENDOR_MOD:
                    return (new MyselfVendorBehavior());
                case StorageState.SHOP_MOD:
                    return (new ShopBehavior());
                case StorageState.SMITH_MAGIC_MOD:
                    return (new SmithMagicBehavior());
                case StorageState.SMITH_MAGIC_COOP_MOD:
                    return (new SmithMagicCoopBehavior());
                case StorageState.BAG_MOD:
                    return (new StorageClassicBehavior());
                case StorageState.BANK_UI_MOD:
                    return (new BankUiBehavior());
                case StorageState.MOUNT_MOD:
                    return (new MountBehavior());
                case StorageState.TOKEN_SHOP_MOD:
                    return (new TokenShopBehavior());
                case StorageState.TOKEN_STONE_SHOP_MOD:
                    return (new TokenStoneShopBehavior());
                case StorageState.MIMICRY_MOD:
                    return (new MimicryBehavior());
                case StorageState.TEMPORIS_SPELLS_UI_MOD:
                    return (new TemporisSpellsUiBehavior());
                default:
                    throw (new Error(("Invalid behavior : " + behaviorName)));
            };
        }


    }
}

