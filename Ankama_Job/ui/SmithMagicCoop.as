package Ankama_Job.ui
{
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.EntityDisplayer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import d2hooks.BagItemAdded;
    import d2hooks.BagItemModified;
    import d2hooks.BagItemDeleted;
    import d2hooks.PaymentCraftList;
    import d2hooks.ExchangeIsReady;
    import d2enums.ComponentHookList;
    import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import d2actions.ExchangeObjectMove;
    import d2actions.ExchangeObjectUseInWorkshop;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import d2actions.ExchangeCraftPaymentModification;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankama.dofus.enums.ActionIds;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import flash.ui.Keyboard;
    import com.ankamagames.berilia.components.Slot;
    import d2actions.LeaveDialogRequest;
    import d2actions.ExchangeReady;
    import d2actions.DisplayContextualMenu;
    import d2hooks.*;
    import d2actions.*;

    public class SmithMagicCoop extends SmithMagic 
    {

        public static const TOOLTIP_SMITH_MAGIC:String = "tooltipSmithMagic";
        public static const CRAFT_IMPOSSIBLE:int = 0;
        public static const CRAFT_FAILED:int = 1;
        public static const CRAFT_SUCCESS:int = 2;

        protected var _isCrafter:Boolean;
        protected var _isReady:Boolean;
        private var _altClickedItem:Object;
        protected var _waitingGrid:Object;
        protected var _crafterInfos:Object;
        protected var _customerInfos:Object;
        protected var _bagItems:Array = new Array();
        protected var _runesFromBagByEffectId:Array = new Array();
        protected var _slot_item_owner:Boolean = true;
        protected var _slot_rune_owner:Boolean = true;
        protected var _slot_sign_owner:Boolean = true;
        public var gd_bag:Grid;
        public var tx_bgPayment:TextureBitmap;
        public var lbl_payment:Label;
        public var btn_validBag:ButtonContainer;
        public var btn_lbl_btn_validBag:Label;
        public var lbl_bagStatus:Label;
        public var ed_leftCharacter:EntityDisplayer;
        public var ctr_slots:GraphicContainer;
        public var ctr_crafterButtons:GraphicContainer;
        public var tx_bagBorder:Object;
        public var tx_bagBackground:GraphicContainer;


        public function get isCrafter():Boolean
        {
            return (this._isCrafter);
        }

        override public function main(args:Object):void
        {
            var slot:Object;
            var characterInfos:Object = playerApi.getPlayedCharacterInfo();
            if (args.crafterInfos.id == characterInfos.id)
            {
                this._isCrafter = true;
            }
            else
            {
                this._isCrafter = false;
            };
            super.main(args);
            sysApi.addHook(BagItemAdded, this.onBagItemAdded);
            sysApi.addHook(BagItemModified, this.onBagItemModified);
            sysApi.addHook(BagItemDeleted, this.onBagItemDeleted);
            sysApi.addHook(PaymentCraftList, this.onPaymentCraftList);
            sysApi.addHook(ExchangeIsReady, this.onExchangeIsReady);
            uiApi.addComponentHook(this.gd_bag, ComponentHookList.ON_ITEM_RIGHT_CLICK);
            uiApi.addComponentHook(this.gd_bag, ComponentHookList.ON_ITEM_ROLL_OVER);
            uiApi.addComponentHook(this.gd_bag, ComponentHookList.ON_ITEM_ROLL_OUT);
            uiApi.addComponentHook(this.gd_bag, ComponentHookList.ON_SELECT_ITEM);
            uiApi.addComponentHook(this.lbl_payment, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.ed_leftCharacter, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.ed_leftCharacter, ComponentHookList.ON_RIGHT_CLICK);
            uiApi.addComponentHook(this.ed_leftCharacter, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.ed_leftCharacter, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(ed_rightCharacter, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(ed_rightCharacter, ComponentHookList.ON_ROLL_OUT);
            this.ed_leftCharacter.mouseEnabled = true;
            this.ed_leftCharacter.handCursor = true;
            ed_rightCharacter.mouseEnabled = true;
            ed_rightCharacter.handCursor = true;
            if (this._isCrafter)
            {
                this.btn_validBag.visible = false;
                this.lbl_bagStatus.visible = true;
                this.ctr_crafterButtons.visible = true;
                this.tx_bgPayment.disabled = true;
                this.lbl_payment.disabled = true;
                for each (slot in [slot_item, slot_rune, slot_sign])
                {
                    slot.allowDrag = true;
                    slot.dropValidator = (this.dropValidatorFunction as Function);
                    slot.processDrop = (this.processDropFunction as Function);
                };
                this.ctr_slots.y = uiApi.me().getConstant("y_slots_crafter");
                this.ctr_slots.x = uiApi.me().getConstant("x_slots");
                uiApi.me().render();
            }
            else
            {
                this.btn_validBag.visible = true;
                this.lbl_bagStatus.visible = false;
                this.btn_validBag.disabled = true;
                this.ctr_crafterButtons.visible = false;
                slot_item.allowDrag = false;
                slot_rune.allowDrag = false;
                slot_sign.allowDrag = false;
                slot_item.highlightTexture = (slot_rune.highlightTexture = (slot_sign.highlightTexture = null));
                slot_item.selectedTexture = (slot_rune.selectedTexture = (slot_sign.selectedTexture = null));
                slot_item.acceptDragTexture = (slot_rune.acceptDragTexture = (slot_sign.acceptDragTexture = null));
                slot_item.refuseDragTexture = (slot_rune.refuseDragTexture = (slot_sign.refuseDragTexture = null));
                this.ctr_slots.y = uiApi.me().getConstant("y_slots_customer");
                this.ctr_slots.x = uiApi.me().getConstant("x_slots");
                uiApi.me().render();
            };
            this.gd_bag.dataProvider = new Array();
            (this.gd_bag.renderer as SlotGridRenderer).dropValidatorFunction = this.bagDropValidatorFunction;
            (this.gd_bag.renderer as SlotGridRenderer).processDropFunction = this.bagProcessDropFunction;
            (this.gd_bag.renderer as SlotGridRenderer).removeDropSourceFunction = function (target:Object):void
            {
            };
            lbl_job.text = ((((_job.name + " ") + uiApi.getText("ui.common.short.level")) + " ") + _skillLevel);
            this._crafterInfos = args.crafterInfos;
            this._customerInfos = args.customerInfos;
            ed_rightCharacter.direction = 3;
            this.ed_leftCharacter.direction = 1;
            if (this._isCrafter)
            {
                ed_rightCharacter.look = this._crafterInfos.look;
                this.ed_leftCharacter.look = this._customerInfos.look;
            }
            else
            {
                ed_rightCharacter.look = this._customerInfos.look;
                this.ed_leftCharacter.look = this._crafterInfos.look;
            };
            this.setIsReady(false);
        }

        override public function unload():void
        {
            super.unload();
            storageApi.removeAllItemMasks("smithMagicBag");
            storageApi.releaseHooks();
        }

        override protected function getRunesFromInventory():void
        {
            if (((this._isCrafter) && (_runesFromInventoryByEffectId.length == 0)))
            {
                super.getRunesFromInventory();
            };
        }

        override protected function getRunesByEffectId(id:int, index:int=-1):Object
        {
            var runesArray:Array;
            if (index == -1)
            {
                runesArray = new Array();
                if (!this._runesFromBagByEffectId[id])
                {
                    this._runesFromBagByEffectId[id] = [{
                        "rune":null,
                        "fromBag":true
                    }, {
                        "rune":null,
                        "fromBag":true
                    }, {
                        "rune":null,
                        "fromBag":true
                    }];
                };
                if (((this._isCrafter) && (!(this._runesFromBagByEffectId[id][0].rune))))
                {
                    runesArray[0] = ((_runesFromInventoryByEffectId[id]) ? _runesFromInventoryByEffectId[id][0] : {
    "rune":null,
    "fromBag":false
});
                }
                else
                {
                    runesArray[0] = this._runesFromBagByEffectId[id][0];
                };
                if (((this._isCrafter) && (!(this._runesFromBagByEffectId[id][1].rune))))
                {
                    runesArray[1] = ((_runesFromInventoryByEffectId[id]) ? _runesFromInventoryByEffectId[id][1] : {
    "rune":null,
    "fromBag":false
});
                }
                else
                {
                    runesArray[1] = this._runesFromBagByEffectId[id][1];
                };
                if (((this._isCrafter) && (!(this._runesFromBagByEffectId[id][2].rune))))
                {
                    runesArray[2] = ((_runesFromInventoryByEffectId[id]) ? _runesFromInventoryByEffectId[id][2] : {
    "rune":null,
    "fromBag":false
});
                }
                else
                {
                    runesArray[2] = this._runesFromBagByEffectId[id][2];
                };
                return (runesArray);
            };
            if (((this._isCrafter) && ((!(this._runesFromBagByEffectId[id])) || (!(this._runesFromBagByEffectId[id][index].rune)))))
            {
                if (_runesFromInventoryByEffectId[id])
                {
                    return (_runesFromInventoryByEffectId[id][index]);
                };
                return (null);
            };
            if (this._runesFromBagByEffectId[id])
            {
                return (this._runesFromBagByEffectId[id][index]);
            };
            return (null);
        }

        override protected function getKnownRunes():Array
        {
            var runeObject:Object;
            var runeArrayIndex:String;
            var effectStr:String;
            var runeObjectIndex:String;
            var effectId:int;
            if (!this._isCrafter)
            {
                return (this._runesFromBagByEffectId);
            };
            var allRunes:Array = new Array();
            for (runeArrayIndex in this._runesFromBagByEffectId)
            {
                allRunes[runeArrayIndex] = [{
                    "rune":null,
                    "fromBag":true
                }, {
                    "rune":null,
                    "fromBag":true
                }, {
                    "rune":null,
                    "fromBag":true
                }];
                for (runeObjectIndex in this._runesFromBagByEffectId[runeArrayIndex])
                {
                    if (this._runesFromBagByEffectId[runeArrayIndex][runeObjectIndex].rune)
                    {
                        allRunes[runeArrayIndex][runeObjectIndex].rune = this._runesFromBagByEffectId[runeArrayIndex][runeObjectIndex].rune;
                    };
                };
            };
            for (effectStr in _runesFromInventoryByEffectId)
            {
                effectId = int(effectStr);
                if (!allRunes[effectId])
                {
                    allRunes[effectId] = _runesFromInventoryByEffectId[effectId];
                }
                else
                {
                    if (!allRunes[effectId][0].rune)
                    {
                        allRunes[effectId][0].rune = _runesFromInventoryByEffectId[effectId][0].rune;
                    };
                    if (!allRunes[effectId][1].rune)
                    {
                        allRunes[effectId][1].rune = _runesFromInventoryByEffectId[effectId][1].rune;
                    };
                    if (!allRunes[effectId][2].rune)
                    {
                        allRunes[effectId][2].rune = _runesFromInventoryByEffectId[effectId][2].rune;
                    };
                };
            };
            return (allRunes);
        }

        private function setIsReady(ready:Boolean):void
        {
            this._isReady = ready;
            if (this._isReady)
            {
                if (this._isCrafter)
                {
                    this.setBagDisabled(false);
                    this.lbl_bagStatus.text = uiApi.getText("ui.craft.bagShared");
                    this.setSlotsDisabled(false, false);
                }
                else
                {
                    this.setBagDisabled(true);
                    this.setSlotsDisabled(false, true);
                    this.btn_lbl_btn_validBag.text = uiApi.getText("ui.common.stop");
                    this.tx_bgPayment.disabled = true;
                    this.lbl_payment.disabled = true;
                };
            }
            else
            {
                if (this._isCrafter)
                {
                    this.setBagDisabled(true);
                    this.lbl_bagStatus.text = uiApi.getText("ui.craft.bagFilling");
                    this.setSlotsDisabled(true, false);
                    btn_mergeOnce.disabled = true;
                    btn_mergeAll.disabled = true;
                }
                else
                {
                    this.setBagDisabled(false);
                    this.setSlotsDisabled(true, false);
                    this.btn_lbl_btn_validBag.text = uiApi.getText("ui.craft.bagShare");
                    this.tx_bgPayment.disabled = false;
                    this.lbl_payment.disabled = false;
                };
            };
        }

        private function setBagDisabled(disabled:Boolean=true):void
        {
            this.gd_bag.softDisabled = disabled;
            this.tx_bagBackground.visible = disabled;
        }

        private function setSlotsDisabled(hardDisabled:Boolean, softDisabled:Boolean):void
        {
            slot_item.softDisabled = softDisabled;
            if (!softDisabled)
            {
                slot_item.iconColorTransform = ICON_CT;
            };
            slot_rune.softDisabled = softDisabled;
            if (!softDisabled)
            {
                slot_rune.iconColorTransform = ICON_CT;
            };
            slot_sign.softDisabled = softDisabled;
            if (!softDisabled)
            {
                slot_sign.iconColorTransform = ICON_CT;
            };
        }

        private function setItemOwner(item:Object, fromCrafter:Boolean):void
        {
            var slot:Object;
            for each (slot in [slot_item, slot_rune, slot_sign])
            {
                if (this.dropValidatorFunction(slot, item, null))
                {
                    switch (slot)
                    {
                        case slot_item:
                            this._slot_item_owner = fromCrafter;
                            break;
                        case slot_rune:
                            this._slot_rune_owner = fromCrafter;
                            break;
                        case slot_sign:
                            this._slot_sign_owner = fromCrafter;
                            break;
                    };
                };
            };
        }

        private function isItemOwner(slot:Object):Boolean
        {
            switch (slot)
            {
                case slot_item:
                    return (this._slot_item_owner);
                case slot_rune:
                    return (this._slot_rune_owner);
                case slot_sign:
                    return (this._slot_sign_owner);
            };
            return (false);
        }

        private function isItemFromBag(item:Object):ItemWrapper
        {
            var data:ItemWrapper;
            for each (data in this._bagItems)
            {
                if ((((data) && (item)) && (data.objectUID == item.objectUID)))
                {
                    return (data);
                };
            };
            return (null);
        }

        private function fillBag(item:Object, qty:int):void
        {
            var slot:Object;
            for each (slot in [slot_item, slot_rune, slot_sign])
            {
                if (this.bagDropValidatorFunction(slot, item, this.gd_bag))
                {
                    _moveRequestedItemUid = item.objectUID;
                    sysApi.sendAction(new ExchangeObjectMove(item.objectUID, qty));
                    return;
                };
            };
        }

        private function unfillBag(item:Object, qty:int):void
        {
            _moveRequestedItemUid = item.objectUID;
            sysApi.sendAction(new ExchangeObjectMove(item.objectUID, -(qty)));
        }

        private function refreshAcceptButton():void
        {
            if (this._isReady)
            {
                return;
            };
            if (this.gd_bag.dataProvider.length > 0)
            {
                this.btn_validBag.disabled = false;
            }
            else
            {
                this.btn_validBag.disabled = true;
            };
        }

        override protected function fillSlot(slot:Object, item:Object, qty:int):void
        {
            if (((!(slot.data == null)) && (((slot == slot_item) || (slot == slot_sign)) || (!(slot.data.objectGID == item.objectGID)))))
            {
                this.unfillSlot(slot, -1);
                _refill_item = item;
                _refill_qty = qty;
            }
            else
            {
                _moveRequestedItemUid = item.objectUID;
                if (this.isItemFromBag(item))
                {
                    sysApi.sendAction(new ExchangeObjectUseInWorkshop(item.objectUID, qty));
                }
                else
                {
                    sysApi.sendAction(new ExchangeObjectMove(item.objectUID, qty));
                };
            };
        }

        override protected function unfillSlot(slot:Object, qty:int=-1):void
        {
            if (!slot.data)
            {
                return;
            };
            if (qty == -1)
            {
                qty = slot.data.quantity;
            };
            _moveRequestedItemUid = slot.data.objectUID;
            if (this.isItemOwner(slot))
            {
                sysApi.sendAction(new ExchangeObjectMove(slot.data.objectUID, -(qty)));
            }
            else
            {
                sysApi.sendAction(new ExchangeObjectUseInWorkshop(slot.data.objectUID, -(qty)));
            };
        }

        override protected function dropValidatorFunction(target:Object, data:Object, source:Object):Boolean
        {
            var item:Object;
            if (!this._isCrafter)
            {
                return (false);
            };
            if (!this._isReady)
            {
                return (false);
            };
            if (!this.isItemFromBag(data))
            {
                item = dataApi.getItem(data.objectGID);
                if (((((!(item.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_POTION)) && (!(item.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_ORB))) && (_runesItemTypes.indexOf(item.typeId) == -1)) && (!(item.id == DataEnum.ITEM_GID_SIGNATURE_RUNE))))
                {
                    return (false);
                };
            };
            return (super.dropValidatorFunction(target, data, source));
        }

        override protected function processDropFunction(target:Object, data:Object, source:Object):void
        {
            this.setItemOwner(data, (this.isItemFromBag(data) == null));
            super.processDropFunction(target, data, source);
        }

        override public function processDropToInventory(target:Object, data:Object, source:Object):void
        {
            if (this._isCrafter)
            {
                super.processDropToInventory(target, data, source);
            }
            else
            {
                if (data.info1 > 1)
                {
                    _waitingObject = data;
                    modCommon.openQuantityPopup(1, data.quantity, data.quantity, this.onValidQtyDropToInventory);
                }
                else
                {
                    this.unfillBag(data, 1);
                };
            };
        }

        override protected function onValidQtyDropToInventory(qty:Number):void
        {
            if (this._isCrafter)
            {
                unfillSelectedSlot(qty);
            }
            else
            {
                this.unfillBag(_waitingObject, qty);
            };
        }

        override public function getMatchingSlot(item:Object):Object
        {
            var slot:Object;
            for each (slot in [slot_item, slot_rune, slot_sign])
            {
                if (super.isValidSlot(slot, item))
                {
                    return (slot);
                };
            };
            return (null);
        }

        public function bagDropValidatorFunction(target:Object, data:Object, source:Object):Boolean
        {
            var matchingSlot:Object;
            if (((((target) && (source)) && (!(target.name.indexOf("gd_bag") == -1))) && (!(source.name.indexOf("gd_bag") == -1))))
            {
                return (false);
            };
            if (this._isCrafter)
            {
                matchingSlot = this.getMatchingSlot(data);
                return ((!(matchingSlot == null)) && (!(this.isItemOwner(matchingSlot))));
            };
            return (((isValidSlot(slot_item, data)) || (isValidSlot(slot_rune, data))) || (isValidSlot(slot_sign, data)));
        }

        public function bagProcessDropFunction(target:Object, data:Object, source:Object):void
        {
            if (!this.bagDropValidatorFunction(target, data, source))
            {
                return;
            };
            if (this._isCrafter)
            {
                if (data.info1 > 1)
                {
                    _waitingObject = this.getMatchingSlot(data);
                    modCommon.openQuantityPopup(1, data.quantity, data.quantity, this.onValidQtySlotToBag);
                }
                else
                {
                    this.unfillSlot(this.getMatchingSlot(data), 1);
                };
            }
            else
            {
                if (data.info1 > 1)
                {
                    _waitingObject = data;
                    modCommon.openQuantityPopup(1, data.quantity, data.quantity, this.onValidQtyInventoryToBag);
                }
                else
                {
                    this.fillBag(data, 1);
                };
            };
        }

        public function onValidQtyInventoryToBag(qty:int):void
        {
            this.fillBag(_waitingObject, qty);
        }

        public function onValidQtySlotToBag(qty:int):void
        {
            this.unfillSlot(_waitingObject, qty);
        }

        public function onPaymentModifiedCallback(value:Number):void
        {
            sysApi.sendAction(new ExchangeCraftPaymentModification(value));
        }

        private function onValidQtyBag(qty:Number):void
        {
            fillDefaultSlot(this._altClickedItem, qty);
        }

        override protected function onExchangeObjectRemoved(itemUID:int, remote:Boolean):void
        {
            var oldIWFromSlot:ItemWrapper;
            var wasDisabled:Boolean;
            var bagItem:ItemWrapper;
            var fromInventory:Boolean;
            var item:ItemWrapper;
            var runesStack:ItemWrapper;
            storageApi.removeItemMask(itemUID, "smithMagic");
            storageApi.releaseHooks();
            var slot:Object = getMatchingSlotFromUID(itemUID);
            if (slot)
            {
                oldIWFromSlot = slot.data;
                wasDisabled = slot.softDisabled;
                slot.softDisabled = false;
                if (wasDisabled)
                {
                    slot.softDisabled = wasDisabled;
                };
                slot.iconColorTransform = ICON_CT;
                slot.data = null;
                bagItem = this.isItemFromBag(oldIWFromSlot);
                if (((oldIWFromSlot) && (bagItem)))
                {
                    onObjectQuantity(bagItem, bagItem.quantity, (bagItem.quantity + oldIWFromSlot.quantity));
                };
                if (slot == slot_item)
                {
                    displayItem(null, false);
                }
                else
                {
                    if (slot == slot_rune)
                    {
                        fromInventory = false;
                        if (this._isCrafter)
                        {
                            item = inventoryApi.getItem(oldIWFromSlot.objectUID);
                            if (((item) && (item.quantity > 0)))
                            {
                                fromInventory = true;
                            };
                        };
                        if (((!(bagItem)) && (!(fromInventory))))
                        {
                            runesStack = dataApi.getItemWrapper(oldIWFromSlot.objectGID, oldIWFromSlot.position, oldIWFromSlot.objectUID, 0, oldIWFromSlot.effectsList);
                            onObjectDeleted(runesStack);
                        };
                    };
                };
                soundApi.playSound(SoundTypeEnum.SWITCH_LEFT_TO_RIGHT);
                if (_refill_item != null)
                {
                    this.fillSlot(slot, _refill_item, _refill_qty);
                    _refill_item = null;
                };
                if (((slot_item.data == null) || (slot_rune.data == null)))
                {
                    setMergeButtonDisabled(true);
                };
            };
            _moveRequestedItemUid = 0;
        }

        override protected function onExchangeObjectModified(item:Object, remote:Object):void
        {
            var bagQuantity:int;
            var o:Object;
            var runesStack:ItemWrapper;
            super.onExchangeObjectModified(item, remote);
            var slot:Object = this.getMatchingSlot(item);
            if (((slot == slot_rune) && (!(this._slot_rune_owner))))
            {
                bagQuantity = 0;
                for each (o in this._bagItems)
                {
                    if (o.objectUID == item.objectUID)
                    {
                        bagQuantity = o.quantity;
                    };
                };
                runesStack = dataApi.getItemWrapper(item.objectGID, item.position, item.objectUID, (item.quantity + bagQuantity), item.effectsList);
                onObjectQuantity(runesStack, item.quantity, 0);
            };
        }

        public function onBagItemAdded(item:Object, remote:Boolean):void
        {
            var ei:EffectInstance;
            var valueBa:int;
            var valuePa:int;
            var valueRa:int;
            if (((!(this._isCrafter)) && (!(remote))))
            {
                storageApi.addItemMask(item.objectUID, "smithMagicBag", item.quantity);
                storageApi.releaseHooks();
            };
            this._bagItems.push(item);
            if (item.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)
            {
                for each (ei in item.effects)
                {
                    if (!this._runesFromBagByEffectId[ei.effectId])
                    {
                        this._runesFromBagByEffectId[ei.effectId] = [{
                            "rune":null,
                            "fromBag":true
                        }, {
                            "rune":null,
                            "fromBag":true
                        }, {
                            "rune":null,
                            "fromBag":true
                        }];
                    };
                    valueBa = 1;
                    valuePa = 3;
                    valueRa = 10;
                    if (((ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_INITIATIVE) || (ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_MAXIMUM_WEIGHT)))
                    {
                        valueBa = 10;
                        valuePa = 30;
                        valueRa = 100;
                    }
                    else
                    {
                        if (ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_VITALITY)
                        {
                            valueBa = 5;
                            valuePa = 15;
                            valueRa = 50;
                        };
                    };
                    if (int(ei.parameter0) == valueBa)
                    {
                        this._runesFromBagByEffectId[ei.effectId][0].rune = item;
                    }
                    else
                    {
                        if (int(ei.parameter0) == valuePa)
                        {
                            this._runesFromBagByEffectId[ei.effectId][1].rune = item;
                        }
                        else
                        {
                            if (int(ei.parameter0) == valueRa)
                            {
                                this._runesFromBagByEffectId[ei.effectId][2].rune = item;
                            };
                        };
                    };
                };
            };
            this.gd_bag.dataProvider = this._bagItems;
            this.refreshAcceptButton();
        }

        public function onBagItemModified(item:Object, remote:Boolean):void
        {
            var i:String;
            var ei:EffectInstance;
            var valueBa:int;
            var valuePa:int;
            var valueRa:int;
            if (((!(this._isCrafter)) && (!(remote))))
            {
                storageApi.addItemMask(item.objectUID, "smithMagicBag", item.quantity);
                storageApi.releaseHooks();
            };
            for (i in this._bagItems)
            {
                if (this._bagItems[i].objectUID == item.objectUID)
                {
                    this._bagItems.splice(i, 1, item);
                };
            };
            if (item.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)
            {
                for each (ei in item.effects)
                {
                    valueBa = 1;
                    valuePa = 3;
                    valueRa = 10;
                    if (((ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_INITIATIVE) || (ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_MAXIMUM_WEIGHT)))
                    {
                        valueBa = 10;
                        valuePa = 30;
                        valueRa = 100;
                    }
                    else
                    {
                        if (ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_VITALITY)
                        {
                            valueBa = 5;
                            valuePa = 15;
                            valueRa = 50;
                        };
                    };
                    if (int(ei.parameter0) == valueBa)
                    {
                        this._runesFromBagByEffectId[ei.effectId][0].rune = item;
                    }
                    else
                    {
                        if (int(ei.parameter0) == valuePa)
                        {
                            this._runesFromBagByEffectId[ei.effectId][1].rune = item;
                        }
                        else
                        {
                            if (int(ei.parameter0) == valueRa)
                            {
                                this._runesFromBagByEffectId[ei.effectId][2].rune = item;
                            };
                        };
                    };
                };
            };
            this.gd_bag.dataProvider = this._bagItems;
            this.refreshAcceptButton();
        }

        public function onBagItemDeleted(itemUID:int, remote:Boolean):void
        {
            var iw:ItemWrapper;
            var ei:EffectInstance;
            var valueBa:int;
            var valuePa:int;
            var valueRa:int;
            if (((!(this._isCrafter)) && (!(remote))))
            {
                storageApi.removeItemMask(itemUID, "smithMagicBag");
                storageApi.releaseHooks();
            };
            var compt:uint;
            for each (iw in this._bagItems)
            {
                if (iw.objectUID == itemUID)
                {
                    if ((((this._isCrafter) && (remote)) || ((!(this._isCrafter)) && (!(remote)))))
                    {
                        if (iw.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)
                        {
                            for each (ei in iw.effects)
                            {
                                valueBa = 1;
                                valuePa = 3;
                                valueRa = 10;
                                if (((ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_INITIATIVE) || (ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_MAXIMUM_WEIGHT)))
                                {
                                    valueBa = 10;
                                    valuePa = 30;
                                    valueRa = 100;
                                }
                                else
                                {
                                    if (ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_VITALITY)
                                    {
                                        valueBa = 5;
                                        valuePa = 15;
                                        valueRa = 50;
                                    };
                                };
                                if (int(ei.parameter0) == valueBa)
                                {
                                    this._runesFromBagByEffectId[ei.effectId][0].rune = null;
                                }
                                else
                                {
                                    if (int(ei.parameter0) == valuePa)
                                    {
                                        this._runesFromBagByEffectId[ei.effectId][1].rune = null;
                                    }
                                    else
                                    {
                                        if (int(ei.parameter0) == valueRa)
                                        {
                                            this._runesFromBagByEffectId[ei.effectId][2].rune = null;
                                        };
                                    };
                                };
                            };
                        };
                    };
                    this._bagItems.splice(compt, 1);
                    break;
                };
                compt++;
            };
            this.gd_bag.dataProvider = this._bagItems;
            this.refreshAcceptButton();
        }

        private function onPaymentCraftList(paymentData:Object, highlight:Boolean):void
        {
            this.lbl_payment.text = utilApi.kamasToString(paymentData.kamaPayment, "");
        }

        public function onExchangeIsReady(playerName:String, ready:Boolean):void
        {
            if (ready != this._isReady)
            {
                if (((!(ready)) && (this._isCrafter)))
                {
                    addLogLine(uiApi.getText("ui.craft.setNotReadyByClient"), "normal");
                };
                this.setIsReady(ready);
            };
        }

        public function onSelectItem(target:Object, selectedMethod:uint, isNewSelection:Boolean):void
        {
            var numberItem:int;
            switch (target)
            {
                case this.gd_bag:
                    numberItem = -1;
                    switch (selectedMethod)
                    {
                        case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                            numberItem = target.selectedItem.quantity;
                            break;
                        case SelectMethodEnum.DOUBLE_CLICK:
                            numberItem = 1;
                            break;
                        case SelectMethodEnum.ALT_DOUBLE_CLICK:
                            this._altClickedItem = target.selectedItem;
                            modCommon.openQuantityPopup(1, target.selectedItem.quantity, target.selectedItem.quantity, this.onValidQtyBag);
                            break;
                    };
                    if (numberItem != -1)
                    {
                        if (this._isCrafter)
                        {
                            fillDefaultSlot(target.selectedItem, numberItem);
                            this.setItemOwner(target.selectedItem, false);
                        }
                        else
                        {
                            this.unfillBag(target.selectedItem, numberItem);
                            this.setItemOwner(target.selectedItem, false);
                        };
                    };
            };
        }

        override public function onDoubleClickItemInventory(pItem:Object, qty:int=1):void
        {
            var iwFromBag:ItemWrapper = this.isItemFromBag(pItem);
            if (uiApi.keyIsDown(Keyboard.CONTROL))
            {
                if (!_doubleClick)
                {
                    return;
                };
                _doubleClick = false;
            };
            if (this._isCrafter)
            {
                if (((pItem.objectGID == DataEnum.ITEM_GID_SIGNATURE_RUNE) || (pItem.id == DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)))
                {
                    qty = 1;
                };
                fillDefaultSlot(pItem, qty);
                this.setItemOwner(pItem, (iwFromBag == null));
            }
            else
            {
                this.setItemOwner(pItem, (iwFromBag == null));
                this.fillBag(pItem, qty);
            };
        }

        override protected function getAlreadyInSlot(iw:ItemWrapper):uint
        {
            var s:Slot;
            if (this.gd_bag.slots)
            {
                for each (s in this.gd_bag.slots)
                {
                    if (((s.data) && ((s.data as ItemWrapper).objectGID == iw.objectGID)))
                    {
                        return ((s.data as ItemWrapper).quantity);
                    };
                };
            };
            return (0);
        }

        override public function onRelease(target:Object):void
        {
            super.onRelease(target);
            switch (target)
            {
                case btn_close:
                    sysApi.sendAction(new LeaveDialogRequest());
                    break;
                case this.lbl_payment:
                    modCommon.openQuantityPopup(0, playerApi.characteristics().kamas, 0, this.onPaymentModifiedCallback);
                    break;
                case this.btn_validBag:
                    if (!this._isReady)
                    {
                        sysApi.sendAction(new ExchangeReady(true));
                    }
                    else
                    {
                        sysApi.sendAction(new ExchangeReady(false));
                    };
                    break;
                case this.ed_leftCharacter:
                    if (this._isCrafter)
                    {
                        sysApi.sendAction(new DisplayContextualMenu(this._customerInfos.id));
                    }
                    else
                    {
                        sysApi.sendAction(new DisplayContextualMenu(this._crafterInfos.id));
                    };
                    break;
            };
        }

        override public function onRightClick(target:Object):void
        {
            if (target == this.ed_leftCharacter)
            {
                if (this._isCrafter)
                {
                    sysApi.sendAction(new DisplayContextualMenu(this._customerInfos.id));
                }
                else
                {
                    sysApi.sendAction(new DisplayContextualMenu(this._crafterInfos.id));
                };
            }
            else
            {
                super.onRightClick(target);
            };
        }

        override public function onRollOver(target:Object):void
        {
            var text:String;
            if (target == this.ed_leftCharacter)
            {
                if (this._isCrafter)
                {
                    text = this._customerInfos.name;
                }
                else
                {
                    text = this._crafterInfos.name;
                };
            }
            else
            {
                if (target == ed_rightCharacter)
                {
                    if (this._isCrafter)
                    {
                        text = this._crafterInfos.name;
                    }
                    else
                    {
                        text = this._customerInfos.name;
                    };
                };
            };
            if (text)
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(text), target, false, "standard", 1, 7, 3, null, null, null, "TextInfo");
            }
            else
            {
                super.onRollOver(target);
            };
        }

        override public function onRollOut(target:Object):void
        {
            uiApi.hideTooltip();
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (item.data)
            {
                uiApi.showTooltip(item.data, item.container, false, "standard", 8, 0, 0, "itemName", null, {
                    "showEffects":true,
                    "header":true
                }, "ItemInfo");
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            uiApi.hideTooltip();
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (item.data)
            {
                data = item.data;
                contextMenu = menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    modContextMenu.createContextMenu(contextMenu);
                };
            };
        }


    }
} Ankama_Job.ui

