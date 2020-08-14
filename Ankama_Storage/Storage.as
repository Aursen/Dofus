package Ankama_Storage
{
    import flash.display.Sprite;
    import Ankama_Storage.ui.StorageUi;
    import Ankama_Storage.ui.BankUi;
    import Ankama_Storage.ui.EquipmentUi;
    import Ankama_Storage.ui.LivingObject;
    import Ankama_Storage.ui.Mimicry;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.StorageApi;
    import com.ankamagames.dofus.uiApi.InventoryApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.JobsApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import d2hooks.OpenInventory;
    import d2hooks.CloseInventory;
    import d2hooks.ExchangeStartedType;
    import d2hooks.ExchangeBankStarted;
    import d2hooks.ObjectAdded;
    import d2hooks.ObjectDeleted;
    import d2hooks.ObjectModified;
    import d2hooks.OpenLivingObject;
    import d2hooks.ExchangeBankStartedWithStorage;
    import d2hooks.EquipmentObjectMove;
    import d2hooks.MountRiding;
    import d2hooks.ClientUIOpened;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
    import Ankama_Storage.ui.enum.StorageState;
    import Ankama_Storage.util.StorageBehaviorManager;
    import Ankama_Storage.ui.InventoryUi;
    import com.ankamagames.dofus.network.enums.ClientUITypeEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
    import d2hooks.*;

    public class Storage extends Sprite 
    {

        public static var bidIsSwitching:Boolean = false;

        private var include_StorageUi:StorageUi = null;
        private var include_BankUi:BankUi = null;
        private var include_EquipmentUi:EquipmentUi = null;
        private var include_livingObject:LivingObject = null;
        private var include_mimicry:Mimicry = null;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="StorageApi")]
        public var storageApi:StorageApi;
        [Api(name="InventoryApi")]
        public var inventoryApi:InventoryApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="JobsApi")]
        public var jobsApi:JobsApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        private var _inventory:Object;
        private var _kamas:Number = 0;
        private var _weight:uint;
        private var _weightMax:uint;
        private var _waitingObject:Object;
        private var _waitingObjectName:String;
        private var _waitingObjectQuantity:int;
        private var _currentStorageMod:uint = 0;


        public function main():void
        {
            Api.common = this.modCommon;
            Api.menu = this.menuApi;
            Api.sound = this.soundApi;
            Api.storage = this.storageApi;
            Api.system = this.sysApi;
            Api.ui = this.uiApi;
            Api.data = this.dataApi;
            Api.player = this.playerApi;
            Api.inventory = this.inventoryApi;
            Api.jobs = this.jobsApi;
            this.sysApi.addHook(OpenInventory, this.onOpenInventory);
            this.sysApi.addHook(CloseInventory, this.onCloseInventory);
            this.sysApi.addHook(ExchangeStartedType, this.onExchangeStartedType);
            this.sysApi.addHook(ExchangeBankStarted, this.onExchangeBankStarted);
            this.sysApi.addHook(ObjectAdded, this.onObjectAdded);
            this.sysApi.addHook(ObjectDeleted, this.onObjectDeleted);
            this.sysApi.addHook(ObjectModified, this.onObjectModified);
            this.sysApi.addHook(OpenLivingObject, this.onOpenLivingObject);
            this.sysApi.addHook(ExchangeBankStartedWithStorage, this.onExchangeStartedWithStorage);
            this.sysApi.addHook(EquipmentObjectMove, this.onEquipmentObjectMove);
            this.sysApi.addHook(MountRiding, this.onMountRiding);
            this.sysApi.addHook(ClientUIOpened, this.onClientUIOpened);
        }

        private function onExchangeStartedType(exchangeType:int):void
        {
            var mountInfo:Object;
            switch (exchangeType)
            {
                case ExchangeTypeEnum.STORAGE:
                    if (!this.uiApi.getUi(UIEnum.BANK_UI))
                    {
                        this.uiApi.loadUi(UIEnum.BANK_UI, UIEnum.BANK_UI, {"exchangeType":exchangeType});
                    };
                    break;
                case ExchangeTypeEnum.MOUNT:
                    mountInfo = this.uiApi.getUi(UIEnum.MOUNT_INFO);
                    if (mountInfo)
                    {
                        mountInfo.visible = false;
                    };
                    break;
            };
        }

        private function onExchangeStartedWithStorage(exchangeType:int, maxSlots:uint):void
        {
            switch (exchangeType)
            {
                case ExchangeTypeEnum.STORAGE:
                case ExchangeTypeEnum.BANK:
                case ExchangeTypeEnum.TRASHBIN:
                case ExchangeTypeEnum.ALLIANCE_PRISM:
                case ExchangeTypeEnum.HAVENBAG:
                    if (!this.uiApi.getUi(UIEnum.BANK_UI))
                    {
                        this.uiApi.loadUi(UIEnum.BANK_UI, UIEnum.BANK_UI, {
                            "exchangeType":exchangeType,
                            "maxSlots":maxSlots
                        });
                    };
                    break;
            };
        }

        private function onExchangeBankStarted(exchangeType:int, objects:Object, kamas:Number):void
        {
            var mountInfo:Object;
            var behavior:String = StorageState.BANK_MOD;
            switch (exchangeType)
            {
                case ExchangeTypeEnum.MOUNT:
                    mountInfo = this.uiApi.getUi(UIEnum.MOUNT_INFO);
                    if (mountInfo)
                    {
                        mountInfo.visible = false;
                    };
                    behavior = StorageState.MOUNT_MOD;
                    break;
                case ExchangeTypeEnum.TAXCOLLECTOR:
                    behavior = StorageState.TAXCOLLECTOR_MOD;
                    break;
            };
            if (!this.uiApi.getUi(UIEnum.BANK_UI))
            {
                this.uiApi.loadUi(UIEnum.BANK_UI, UIEnum.BANK_UI, {
                    "inventory":objects,
                    "kamas":kamas,
                    "exchangeType":exchangeType
                });
            };
        }

        private function onOpenInventory(behaviorName:String, realUiName:String):void
        {
            if (!this.playerApi.characteristics())
            {
                return;
            };
            this._inventory = this.storageApi.getViewContent("storage");
            this._kamas = this.playerApi.characteristics().kamas;
            this._weight = this.playerApi.inventoryWeight();
            this._weightMax = this.playerApi.inventoryWeightMax();
            var load:Boolean;
            var unload:Boolean;
            var uiName:String = StorageBehaviorManager.makeBehavior(behaviorName).getStorageUiName();
            var storageUi:Object = this.uiApi.getUi(realUiName);
            if (storageUi)
            {
                if (((((storageUi.uiClass is EquipmentUi) && (uiName == UIEnum.EQUIPMENT_UI)) || ((storageUi.uiClass is InventoryUi) && (uiName == UIEnum.INVENTORY_UI))) || (((!(storageUi.uiClass is EquipmentUi)) && (!(storageUi.uiClass is InventoryUi))) && (uiName == UIEnum.STORAGE_UI))))
                {
                    load = false;
                }
                else
                {
                    unload = true;
                    load = true;
                };
            }
            else
            {
                load = true;
            };
            if (unload)
            {
                this.uiApi.unloadUi(realUiName);
            };
            if (load)
            {
                this.uiApi.loadUi(uiName, realUiName, {"storageMod":behaviorName}, 1);
            }
            else
            {
                if ((((storageUi.uiClass) && (storageUi.uiClass.currentStorageBehavior)) && (storageUi.uiClass.currentStorageBehavior.replacable)))
                {
                    storageUi.uiClass.switchBehavior(behaviorName);
                };
            };
        }

        private function onCloseInventory(uiName:String="storage"):void
        {
            if (this.uiApi.getUi(uiName))
            {
                this.uiApi.unloadUi(uiName);
            };
        }

        private function onOpenLivingObject(item:Object):void
        {
            this.uiApi.unloadUi("livingObject");
            if (item)
            {
                this.uiApi.loadUi("livingObject", "livingObject", {"item":item});
            };
        }

        private function onClientUIOpened(_arg_1:uint, uid:uint):void
        {
            if (_arg_1 == ClientUITypeEnum.CLIENT_UI_OBJECT_MIMICRY)
            {
                if (!this.uiApi.getUi("mimicry"))
                {
                    this.uiApi.loadUi("mimicry", "mimicry", uid);
                };
                this.sysApi.dispatchHook(OpenInventory, "mimicry", UIEnum.STORAGE_UI);
            };
        }

        private function playItemMovedSound():void
        {
            if (this.uiApi.getUi(UIEnum.STORAGE_UI))
            {
                this.soundApi.playSound(SoundTypeEnum.MOVE_ITEM_TO_BAG);
            };
        }

        private function onObjectAdded(pItem:Object):void
        {
            this.playItemMovedSound();
        }

        private function onObjectDeleted(pItem:Object):void
        {
            this.playItemMovedSound();
        }

        private function onObjectModified(pItem:Object):void
        {
            this.playItemMovedSound();
        }

        public function onEquipmentObjectMove(pItemWrapper:Object, oldPosition:int):void
        {
            if (((!(pItemWrapper)) || (pItemWrapper.position > CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD)))
            {
                return;
            };
            switch (pItemWrapper.position)
            {
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_AMULET:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_NECKLACE);
                    break;
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_BUCKLER);
                    break;
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_LEFT:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_RIGHT:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_CIRCLE);
                    break;
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BELT:
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_HAT:
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_CAPE:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_CLOTHES);
                    break;
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BOOTS:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_BOOT);
                    break;
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_WEAPON);
                    break;
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_PET);
                    break;
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_1:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_2:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_3:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_4:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_5:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_6:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_DOFUS);
                    break;
            };
        }

        public function onMountRiding(isRidding:Boolean):void
        {
            this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_PET);
        }


    }
} Ankama_Storage

