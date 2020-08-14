package Ankama_Storage.ui
{
    import flash.utils.Timer;
    import com.ankamagames.berilia.components.Slot;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import d2hooks.MountSet;
    import d2enums.ComponentHookList;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
    import d2actions.MountToggleRidingRequest;
    import d2actions.ObjectSetPosition;
    import com.ankamagames.dofus.datacenter.items.EvolutiveItemType;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import Ankama_Storage.Api;
    import Ankama_Storage.ui.behavior.IStorageBehavior;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import d2actions.ObjectUse;
    import com.ankamagames.dofus.datacenter.items.ItemType;
    import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
    import d2actions.DeleteObject;
    import d2hooks.*;
    import d2actions.*;

    public class InventoryUi extends StorageUi 
    {

        private var _slotCollection:Array;
        private var _currentEquipmentItemsByPos:Array;
        private var _delayUseObject:Boolean = false;
        private var _delayUseObjectTimer:Timer;
        private var _delayDoubleClickTimer:Timer;
        private var _itemWaitingForPopupDisplay:Object;
        private var _itemWaitingForPopupDisplayQty:uint;
        private var _itemWaitingForPopupDisplayPosition:Number;
        private var _slotClickedNoDragAllowed:Slot;
        private var _popupName:String;
        private var _draggedItem:ItemWrapper;
        public var equipmentUi:GraphicContainer;


        override public function main(params:Object):void
        {
            super.main(params);
            this._currentEquipmentItemsByPos = [];
            soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_OPEN);
            sysApi.addHook(MountSet, this.onMountSet);
            uiApi.addComponentHook(this.equipmentUi, ComponentHookList.ON_RELEASE);
            uiApi.addShortcutHook("closeUi", onShortCut);
            var characterInfos:Object = playerApi.getPlayedCharacterInfo();
            var equipmentItems:Object = storageApi.getViewContent("equipment");
            this.fillEquipement(equipmentItems);
            this._delayUseObjectTimer = new Timer(500, 1);
            this._delayUseObjectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayUseObjectTimer);
            this._delayDoubleClickTimer = new Timer(500, 1);
            this._delayDoubleClickTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayDoubleClickTimer);
        }

        override public function unload():void
        {
            this._delayDoubleClickTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayDoubleClickTimer);
            this._delayDoubleClickTimer = null;
            uiApi.unloadUi("itemBox");
            uiApi.unloadUi("itemsList");
            uiApi.unloadUi(this._popupName);
            uiApi.unloadUi("quantityPopup");
            uiApi.unloadUi("preset");
            super.unload();
        }

        private function blockDragDropOnSlot(slot:Slot):void
        {
            this._slotClickedNoDragAllowed = slot;
            if (this._slotClickedNoDragAllowed != null)
            {
                this._slotClickedNoDragAllowed.allowDrag = false;
                this._delayDoubleClickTimer.start();
            };
        }

        public function onDoubleClick(target:Object):void
        {
            var position:uint;
            if ((((target is Slot) && (target.data)) && (!(this._delayDoubleClickTimer.running))))
            {
                uiApi.unloadUi("itemsList");
                this.blockDragDropOnSlot((target as Slot));
                position = (target.name.split("slot_")[1] as uint);
                if ((((position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS) && (target.data.objectUID == 0)) && (target.data.hasOwnProperty("mountId"))))
                {
                    sysApi.sendAction(new MountToggleRidingRequest());
                }
                else
                {
                    sysApi.sendAction(new ObjectSetPosition(target.data.objectUID, 63, 1));
                };
            };
        }

        private function getExperienceFromItem(foodItem:ItemWrapper, quantity:int, evolutiveTypeToFeed:EvolutiveItemType):Number
        {
            var experience:Number = 0;
            if (foodItem.givenExperienceAsSuperFood > 0)
            {
                experience = (quantity * foodItem.givenExperienceAsSuperFood);
            }
            else
            {
                if (foodItem.basicExperienceAsFood > 0)
                {
                    experience = ((quantity * foodItem.basicExperienceAsFood) * evolutiveTypeToFeed.experienceBoost);
                };
            };
            return (experience);
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case btnAll:
                case btnEquipable:
                case btnConsumables:
                case btnRessources:
                case btnQuest:
                    ctr_storageContent.visible = true;
                    break;
                case btn_help:
                    hintsApi.showSubHints();
                    btnHelpClickAlreadyTreated = true;
                    break;
            };
            uiApi.unloadUi("itemsList");
            super.onRelease(target);
        }

        override public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (selectMethod != SelectMethodEnum.AUTO)
            {
                switch (target)
                {
                    case cb_category:
                        super.onSelectItem(target, selectMethod, isNewSelection);
                        break;
                    default:
                        if (selectMethod == SelectMethodEnum.DOUBLE_CLICK)
                        {
                            if (_storageBehavior)
                            {
                                Api.ui.hideTooltip();
                                if (!this._delayDoubleClickTimer.running)
                                {
                                    (_storageBehavior as IStorageBehavior).doubleClickGridItem(grid.selectedItem);
                                    if (grid != null)
                                    {
                                        this.blockDragDropOnSlot((grid.selectedSlot as Slot));
                                    };
                                };
                            };
                        };
                        return;
                };
            };
        }

        override protected function displayItemTooltip(target:Object, item:Object, settings:Object=null):void
        {
            if (!settings)
            {
                settings = {};
            };
            super.displayItemTooltip(target, item, settings);
        }

        override public function onRollOver(target:Object):void
        {
            var text:String;
            var evolutiveType:EvolutiveItemType;
            var targetIsMaxLevel:Boolean;
            var effect:EffectInstance;
            var xp:Number;
            var roundXp:int;
            var experienceToReachMaxLevel:int;
            var xpText:String;
            var itemToFeed:ItemWrapper;
            var futurItemExperience:int;
            var futurLevel:int;
            var effects:Array;
            var levelsCount:int;
            var color:String;
            var ei:EffectInstance;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            if (((target is Slot) && (target.data)))
            {
                if ((target.data is MountWrapper))
                {
                    uiApi.showTooltip(target.data, target, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPLEFT, 0, "itemName", null, {
                        "noBg":false,
                        "uiName":uiApi.me().name
                    }, "ItemInfo");
                    return;
                };
                if ((((this._draggedItem) && (target.data)) && (target.data.type.superTypeId == DataEnum.ITEM_SUPERTYPE_PET)))
                {
                    evolutiveType = target.data.type.evolutiveType;
                    if (!evolutiveType)
                    {
                        return;
                    };
                    if (!target.data.isEvolutive())
                    {
                        return;
                    };
                    if (this._draggedItem.category != ItemCategoryEnum.RESOURCES_CATEGORY)
                    {
                        return;
                    };
                    targetIsMaxLevel = (target.data.evolutiveLevel == evolutiveType.maxLevel);
                    if (((targetIsMaxLevel) && (target.data.itemHasLockedLegendarySpell)))
                    {
                        text = uiApi.getText("ui.evolutive.pet.errorCantEatAnythingAnymore");
                    }
                    else
                    {
                        if (((!(targetIsMaxLevel == this._draggedItem.itemHasLegendaryEffect)) || ((targetIsMaxLevel) && (target.data.itemHoldsLegendaryStatus == this._draggedItem.itemHoldsLegendaryStatus))))
                        {
                            text = uiApi.getText("ui.evolutive.pet.errorCantEatRightNow");
                        }
                        else
                        {
                            if (((targetIsMaxLevel) && (this._draggedItem.itemHasLegendaryEffect)))
                            {
                                for each (effect in this._draggedItem.effects)
                                {
                                    if ((((text) && (!(text == ""))) && (!(effect.description == ""))))
                                    {
                                        text = (text + "\n");
                                    };
                                    text = ("+ " + effect.description);
                                };
                            }
                            else
                            {
                                if (targetIsMaxLevel)
                                {
                                    text = uiApi.getText("ui.mount.maxLevel");
                                }
                                else
                                {
                                    xp = 0;
                                    if (this._draggedItem.givenExperienceAsSuperFood > 0)
                                    {
                                        xp = (this._draggedItem.givenExperienceAsSuperFood * this._draggedItem.quantity);
                                    }
                                    else
                                    {
                                        if (this._draggedItem.basicExperienceAsFood > 0)
                                        {
                                            xp = ((this._draggedItem.basicExperienceAsFood * this._draggedItem.quantity) * evolutiveType.experienceBoost);
                                        };
                                    };
                                    roundXp = Math.floor(xp);
                                    experienceToReachMaxLevel = (evolutiveType.experienceByLevel[evolutiveType.maxLevel] - target.data.experiencePoints);
                                    if (experienceToReachMaxLevel < roundXp)
                                    {
                                        roundXp = experienceToReachMaxLevel;
                                    };
                                    xpText = utilApi.kamasToString(roundXp, "");
                                    itemToFeed = target.data;
                                    text = uiApi.getText("ui.tooltip.monsterXpAlone", ("+ " + xpText));
                                    futurItemExperience = (roundXp + itemToFeed.experiencePoints);
                                    futurLevel = dataApi.getEvolutiveItemLevelByExperiencePoints(itemToFeed, futurItemExperience);
                                    if (futurLevel > itemToFeed.evolutiveLevel)
                                    {
                                        levelsCount = (futurLevel - itemToFeed.evolutiveLevel);
                                        text = (text + ("\n+ " + uiApi.processText(uiApi.getText("ui.evolutive.levelsCount", levelsCount), "m", (levelsCount == 1), (levelsCount == 0))));
                                    };
                                    effects = dataApi.getEvolutiveEffectInstancesByExperienceBoost(itemToFeed, roundXp);
                                    if (effects.length)
                                    {
                                        color = (sysApi.getConfigEntry("colors.tooltip.bonus") as String).replace("0x", "#");
                                        text = (text + (("<font color='" + color) + "'>"));
                                        for each (ei in effects)
                                        {
                                            if (ei)
                                            {
                                                text = (text + ("\n+ " + ei.description));
                                            };
                                        };
                                        text = (text + "</font>");
                                    };
                                };
                            };
                        };
                    };
                    uiApi.showTooltip(uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, {"displayWhenMouseDown":true}, "TextInfo");
                    return;
                };
                this.displayItemTooltip(target, target.data);
                return;
            };
            if (!text)
            {
                super.onRollOver(target);
                return;
            };
            if (text)
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        override protected function fillContextMenu(contextMenu:Array, data:Object, disabled:Boolean):void
        {
            var behavior:* = modContextMenu.getBehavior();
            if (data)
            {
                if ((((data.usable) && (data.quantity > 1)) && (data.isOkForMultiUse)))
                {
                    contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.multipleUse"), this.useItemQuantity, [data], disabled));
                };
                if (data.usable)
                {
                    contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.use"), this.useItem, [data], disabled));
                };
                if (((data.targetable) && (!(data.nonUsableOnAnother))))
                {
                    contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.target"), this.useItemOnCell, [data], disabled));
                };
                if (data.isEquipment)
                {
                    contextMenu.unshift(modContextMenu.createContextMenuItemObject((((data.isWrapperObject) || (data.isLivingObject)) ? uiApi.getText("ui.common.associate") : uiApi.getText("ui.common.equip")), this.equipItem, [data], disabled));
                };
            };
            super.fillContextMenu(contextMenu, data, disabled);
            if (data)
            {
                contextMenu.push(modContextMenu.createContextMenuSeparatorObject());
                contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.destroyThisItem"), this.askDeleteItem, [data], (((disabled) || (!(data.isDestructible))) || ((behavior) && (!(behavior.canDestroyItem(data)))))));
            };
        }

        public function onRightClick(target:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            var position:Number;
            if (((target is Slot) && (target.data)))
            {
                data = target.data;
                position = Number(target.name.split("slot_")[1]);
                if ((((position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS) && (data.objectUID == 0)) && (data.hasOwnProperty("mountId"))))
                {
                    contextMenu = menuApi.create(data, "mount");
                }
                else
                {
                    contextMenu = menuApi.create(data, "item", [{"ownedItem":true}]);
                };
                if (contextMenu.content.length > 0)
                {
                    modContextMenu.createContextMenu(contextMenu);
                };
            };
        }

        public function onMountSet():void
        {
            var mount:MountWrapper = storageApi.getFakeItemMount();
            this._slotCollection[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].data = mount;
            this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = mount;
        }

        public function useItem(item:Object):void
        {
            if (((!(item.usable)) && (item.targetable)))
            {
                sysApi.sendAction(new ObjectUse(item.objectUID, 1, true));
                uiApi.unloadUi(uiApi.me().name);
            }
            else
            {
                if (!this._delayUseObject)
                {
                    this._delayUseObjectTimer.start();
                    sysApi.sendAction(new ObjectUse(item.objectUID, 1, false));
                };
            };
        }

        public function useItemQuantity(item:Object):void
        {
            if (!this._delayUseObject)
            {
                this._itemWaitingForPopupDisplay = item;
                modCommon.openQuantityPopup(1, item.quantity, 1, this.onValidItemQuantityUse);
            };
        }

        public function onValidItemQuantityUse(qty:Number):void
        {
            sysApi.sendAction(new ObjectUse(this._itemWaitingForPopupDisplay.objectUID, qty, false));
            this._itemWaitingForPopupDisplay = null;
        }

        public function onValidItemQuantitySetPosition(qty:Number):void
        {
            sysApi.sendAction(new ObjectSetPosition(this._itemWaitingForPopupDisplay.objectUID, this._itemWaitingForPopupDisplayPosition, qty));
            this._itemWaitingForPopupDisplay = null;
            this._itemWaitingForPopupDisplayPosition = 0;
        }

        public function equipItem(item:ItemWrapper):void
        {
            var freeSlot:int;
            var equipement:Object;
            var pos:int;
            var possiblePosition:Object = storageApi.itemSuperTypeToServerPosition(item.type.superTypeId);
            if (((possiblePosition) && (possiblePosition.length)))
            {
                equipement = storageApi.getViewContent("equipment");
                freeSlot = -1;
                for each (pos in possiblePosition)
                {
                    if (!equipement[pos])
                    {
                        freeSlot = pos;
                        break;
                    };
                };
                if (freeSlot == -1)
                {
                    freeSlot = possiblePosition[0];
                };
                sysApi.sendAction(new ObjectSetPosition(item.objectUID, freeSlot, 1));
            }
            else
            {
                if (((item) && ((item.isWrapperObject) || (item.isLivingObject))))
                {
                    if (item.category == 0)
                    {
                        freeSlot = storageApi.getBestEquipablePosition(item);
                        if (freeSlot > -1)
                        {
                            Api.system.sendAction(new ObjectSetPosition(item.objectUID, freeSlot, 1));
                        };
                    };
                };
            };
        }

        public function useItemOnCell(item:Object):void
        {
            sysApi.sendAction(new ObjectUse(item.objectUID, 1, true));
            uiApi.unloadUi(uiApi.me().name);
        }

        public function askDeleteItem(item:Object):void
        {
            this._itemWaitingForPopupDisplay = item;
            if (item.quantity == 1)
            {
                this.askDeleteConfirm(1);
            }
            else
            {
                modCommon.openQuantityPopup(1, item.quantity, item.quantity, this.askDeleteConfirm);
            };
        }

        private function getItemSuperType(item:Object):int
        {
            var cat:int;
            var itemType:ItemType;
            if (((item) && ((item.isLivingObject) || (item.isWrapperObject))))
            {
                cat = 0;
                if (item.isLivingObject)
                {
                    cat = item.livingObjectCategory;
                }
                else
                {
                    cat = item.wrapperObjectCategory;
                };
                itemType = dataApi.getItemType(cat);
                if (itemType)
                {
                    return (itemType.superTypeId);
                };
                return (0);
            };
            if (((item is ItemWrapper) && (item.type)))
            {
                return ((item as ItemWrapper).type.superTypeId);
            };
            if ((item is ShortcutWrapper))
            {
                if ((item as ShortcutWrapper).type == 0)
                {
                    return (((item as ShortcutWrapper).realItem as ItemWrapper).type.superTypeId);
                };
            };
            return (0);
        }

        private function fillEquipement(equipment:Object):void
        {
            var item:Object;
            var slot:Slot;
            var pos:uint;
            this._currentEquipmentItemsByPos = [];
            for each (item in equipment)
            {
                if (item)
                {
                    this._currentEquipmentItemsByPos[item.position] = item;
                };
            };
            if ((((!(this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS])) || (this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] == null)) && (playerApi.isRidding())))
            {
                this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = storageApi.getFakeItemMount();
            };
            for each (slot in this._slotCollection)
            {
                pos = uint(slot.name.split("_")[1]);
                slot.data = this._currentEquipmentItemsByPos[pos];
            };
        }

        private function onDelayUseObjectTimer(e:TimerEvent):void
        {
            this._delayUseObject = false;
        }

        private function askDeleteConfirm(qty:uint):void
        {
            if (this._popupName)
            {
                return;
            };
            this._itemWaitingForPopupDisplayQty = qty;
            this._popupName = modCommon.openPopup(uiApi.getText("ui.common.delete.item"), uiApi.getText("ui.common.doYouDestroy", qty, this._itemWaitingForPopupDisplay.name), [uiApi.getText("ui.common.ok"), uiApi.getText("ui.common.cancel")], [this.deleteItem, this.emptyFct], this.deleteItem, this.emptyFct);
        }

        private function onDelayDoubleClickTimer(pEvt:TimerEvent):void
        {
            this._delayDoubleClickTimer.stop();
            if (this._slotClickedNoDragAllowed != null)
            {
                this._slotClickedNoDragAllowed.allowDrag = true;
                this._slotClickedNoDragAllowed = null;
            };
        }

        private function deleteItem():void
        {
            sysApi.sendAction(new DeleteObject(this._itemWaitingForPopupDisplay.objectUID, this._itemWaitingForPopupDisplayQty));
            this._popupName = null;
        }

        private function emptyFct(... args):void
        {
            this._popupName = null;
        }


    }
} Ankama_Storage.ui

