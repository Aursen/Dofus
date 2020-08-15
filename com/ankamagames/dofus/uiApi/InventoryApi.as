package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.items.QuantifiedItemWrapper;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.internalDatacenter.items.SimpleTextureWrapper;
    import com.ankamagames.dofus.misc.enum.CharacterBuildType;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.PointCellFrame;
    import __AS3__.vec.*;

    [InstanciedApi]
    public class InventoryApi implements IApi 
    {

        protected var _log:Logger = Log.getLogger(getQualifiedClassName(InventoryApi));
        private var _module:UiModule;


        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        public function destroy():void
        {
            this._module = null;
        }

        public function getStorageObjectGID(pObjectGID:uint, quantity:uint=1):Object
        {
            var iw:ItemWrapper;
            var returnItems:Array = new Array();
            var numberReturn:uint;
            var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
            for each (iw in inventory)
            {
                if ((((!(iw.objectGID == pObjectGID)) || (iw.position < 63)) || (iw.linked)))
                {
                }
                else
                {
                    if (iw.quantity >= (quantity - numberReturn))
                    {
                        returnItems.push({
                            "objectUID":iw.objectUID,
                            "quantity":(quantity - numberReturn)
                        });
                        numberReturn = quantity;
                        return (returnItems);
                    };
                    returnItems.push({
                        "objectUID":iw.objectUID,
                        "quantity":iw.quantity
                    });
                    numberReturn = (numberReturn + iw.quantity);
                };
            };
            return (null);
        }

        public function getStorageObjectsByType(objectType:uint):Array
        {
            var iw:ItemWrapper;
            var returnItems:Array = new Array();
            var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
            for each (iw in inventory)
            {
                if (((!(iw.typeId == objectType)) || (iw.position < 63)))
                {
                }
                else
                {
                    returnItems.push(iw);
                };
            };
            return (returnItems);
        }

        public function getItemQty(pObjectGID:uint, pObjectUID:uint=0):uint
        {
            var item:ItemWrapper;
            var quantity:uint;
            var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
            for each (item in inventory)
            {
                if ((((item.position < 63) || (!(item.objectGID == pObjectGID))) || ((pObjectUID > 0) && (!(item.objectUID == pObjectUID)))))
                {
                }
                else
                {
                    quantity = (quantity + item.quantity);
                };
            };
            return (quantity);
        }

        public function getItemByGID(objectGID:uint):ItemWrapper
        {
            var item:ItemWrapper;
            var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
            for each (item in inventory)
            {
                if (((item.position < 63) || (!(item.objectGID == objectGID))))
                {
                }
                else
                {
                    return (item);
                };
            };
            return (null);
        }

        public function getItemFromInventoryByUID(objectUID:uint):ItemWrapper
        {
            var item:ItemWrapper;
            var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
            for each (item in inventory)
            {
                if (item.objectUID == objectUID)
                {
                    return (item);
                };
            };
            return (null);
        }

        public function getQuantifiedItemByGIDInInventoryOrMakeUpOne(objectGID:uint):QuantifiedItemWrapper
        {
            var qiw:QuantifiedItemWrapper;
            var item:ItemWrapper;
            var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
            var iw:ItemWrapper;
            for each (item in inventory)
            {
                if (((item.position < 63) || (!(item.objectGID == objectGID))))
                {
                }
                else
                {
                    iw = item;
                    break;
                };
            };
            if (iw)
            {
                qiw = QuantifiedItemWrapper.create(iw.position, iw.objectUID, objectGID, iw.quantity, iw.effectsList, false);
            }
            else
            {
                qiw = QuantifiedItemWrapper.create(0, 0, objectGID, 0, new Vector.<ObjectEffect>(), false);
            };
            return (qiw);
        }

        public function getItem(objectUID:uint):ItemWrapper
        {
            return (InventoryManager.getInstance().inventory.getItem(objectUID));
        }

        public function getEquipementItemByPosition(pPosition:uint):ItemWrapper
        {
            if ((((pPosition > CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD) && (!(pPosition == CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY))) && (!(pPosition == CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME))))
            {
                return (null);
            };
            var equipementList:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
            return (equipementList[pPosition]);
        }

        public function getEquipement():Vector.<ItemWrapper>
        {
            var equipementList:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
            return (equipementList);
        }

        public function getEquipementForPreset():Array
        {
            var emptyUri:Uri;
            var pos:int;
            var objExists:Boolean;
            var item:ItemWrapper;
            var mountFakeItemWrapper:MountWrapper;
            var itemsCount:int = InventoryManager.getInstance().getMaxItemsCountForPreset();
            var equipmentList:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
            var equipmentPreset:Array = new Array(itemsCount);
            var i:int;
            while (i < itemsCount)
            {
                pos = InventoryManager.getInstance().getPositionForPresetItemIndex(i);
                objExists = false;
                for each (item in equipmentList)
                {
                    if (((item) && (item.position == pos)))
                    {
                        equipmentPreset[i] = item;
                        objExists = true;
                    }
                    else
                    {
                        if (((pos == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS) && (PlayedCharacterManager.getInstance().isRidding)))
                        {
                            mountFakeItemWrapper = MountWrapper.create();
                            equipmentPreset[i] = mountFakeItemWrapper;
                            objExists = true;
                        };
                    };
                };
                if (!objExists)
                {
                    emptyUri = new Uri((((XmlConfig.getInstance().getEntry("config.ui.skin") + "texture/slot/tx_slot_") + this.getSlotNameByPositionId(i)) + ".png"));
                    equipmentPreset[i] = SimpleTextureWrapper.create(emptyUri);
                };
                i++;
            };
            return (equipmentPreset);
        }

        private function getSlotNameByPositionId(i:int):String
        {
            var pos:int = InventoryManager.getInstance().getPositionForPresetItemIndex(i);
            switch (pos)
            {
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_AMULET:
                    return ("collar");
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON:
                    return ("weapon");
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_LEFT:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_RIGHT:
                    return ("ring");
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BELT:
                    return ("belt");
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BOOTS:
                    return ("shoe");
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_HAT:
                    return ("helmet");
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_CAPE:
                    return ("cape");
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS:
                    return ("pet");
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_1:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_2:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_3:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_4:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_5:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_6:
                    return ("dofus");
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD:
                    return ("shield");
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY:
                    return ("companon");
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME:
                    return ("costume");
                default:
                    return ("companon");
            };
        }

        public function getVoidItemForPreset(index:int):SimpleTextureWrapper
        {
            var emptyUri:Uri;
            emptyUri = new Uri((((XmlConfig.getInstance().getEntry("config.ui.skin") + "texture/slot/tx_slot_") + this.getSlotNameByPositionId(index)) + ".png"));
            return (SimpleTextureWrapper.create(emptyUri));
        }

        public function getMaxItemsCountForPreset():int
        {
            return (InventoryManager.getInstance().getMaxItemsCountForPreset());
        }

        public function getPositionForPresetItemIndex(index:int):int
        {
            return (InventoryManager.getInstance().getPositionForPresetItemIndex(index));
        }

        public function getInvisibleEquipmentPositions():Array
        {
            var invisiblePositions:Array = new Array();
            invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_MUTATION);
            invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_BOOST_FOOD);
            invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_BONUS);
            invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_BONUS);
            invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_MALUS);
            invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_MALUS);
            invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_ROLEPLAY_BUFFER);
            invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_FOLLOWER);
            invisiblePositions.push(CharacterInventoryPositionEnum.ACCESSORY_POSITION_RIDE_HARNESS);
            invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_NOT_EQUIPED);
            return (invisiblePositions);
        }

        public function getCurrentWeapon():ItemWrapper
        {
            return (this.getEquipementItemByPosition(CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON) as ItemWrapper);
        }

        public function getBuilds(buildType:int=-1):Array
        {
            var maxBuildCount:int;
            var index:uint;
            if (buildType === -1)
            {
                buildType = CharacterBuildType.CHARACTER_TYPE;
            };
            var builds:Array = InventoryManager.getInstance().builds;
            maxBuildCount = builds.length;
            var emptyUri:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/slot/emptySlot.png"));
            var displayablesBuilds:Array = new Array();
            index = 0;
            while (index < maxBuildCount)
            {
                if (builds[index])
                {
                    if (builds[index].buildType === buildType)
                    {
                        displayablesBuilds.push(builds[index]);
                    };
                }
                else
                {
                    displayablesBuilds.push(SimpleTextureWrapper.create(emptyUri));
                };
                index++;
            };
            if (buildType === CharacterBuildType.CHARACTER_TYPE)
            {
                index = displayablesBuilds.length;
                while (index < ProtocolConstantsEnum.MAX_PRESET_COUNT)
                {
                    displayablesBuilds.push(SimpleTextureWrapper.create(emptyUri));
                    index++;
                };
            };
            return (displayablesBuilds);
        }

        public function getBuildNumber(buildType:int=-1):uint
        {
            var index:uint;
            var count:uint;
            var currentBuild:BuildWrapper;
            var builds:Array = InventoryManager.getInstance().builds;
            if (builds !== null)
            {
                index = 0;
                while (index < builds.length)
                {
                    currentBuild = builds[index];
                    if (((!(currentBuild === null)) && (currentBuild.buildType === buildType)))
                    {
                        count++;
                    };
                    index++;
                };
            };
            return (count);
        }

        public function setBuildId(id:int):void
        {
            InventoryManager.getInstance().currentBuildId = id;
        }

        public function getBuildId():int
        {
            return (InventoryManager.getInstance().currentBuildId);
        }

        public function removeSelectedItem():Boolean
        {
            if (!Kernel.getWorker().contains(PointCellFrame))
            {
                return (false);
            };
            PointCellFrame.getInstance().cancelShow();
            return (true);
        }


    }
}

