package Ankama_Storage.ui.behavior
{
    import Ankama_Storage.ui.StorageUi;
    import Ankama_Storage.Api;
    import d2hooks.ObjectSelected;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import Ankama_Storage.ui.AbstractStorageUi;
    import d2hooks.ExchangeLeave;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2actions.LeaveDialogRequest;
    import Ankama_Storage.ui.enum.StorageState;
    import com.ankamagames.dofus.datacenter.jobs.Skill;
    import d2hooks.*;
    import d2actions.*;

    public class CraftBehavior implements IStorageBehavior 
    {

        private var _storage:StorageUi;
        private var _waitingObject:Object;
        private var _craftUi:Object;
        protected var _showFilter:Boolean = true;


        public function filterStatus(enabled:Boolean):void
        {
            Api.system.setData("filterCraftStorage", this._storage.btn_itemsFilter.selected);
            this.refreshFilter();
        }

        public function get craftUi():Object
        {
            if (!this._craftUi)
            {
                this._craftUi = Api.ui.getUi("craft").uiClass;
            };
            return (this._craftUi);
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            return (true);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
            this.craftUi.processDropToInventory(target, data, source);
        }

        public function onValidQty(qty:Number):void
        {
            var craftUi2:Object = Api.ui.getUi("craft").uiClass;
            craftUi2.fillAutoSlot(this._waitingObject, qty);
        }

        public function onRelease(target:Object):void
        {
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var item:Object;
            var craftUi:Object;
            var craftUi2:Object;
            switch (target)
            {
                case this._storage.grid:
                    item = this._storage.grid.selectedItem;
                    switch (selectMethod)
                    {
                        case SelectMethodEnum.CLICK:
                            if (!Api.system.getOption("displayTooltips", "dofus"))
                            {
                                Api.system.dispatchHook(ObjectSelected, {"data":item});
                            };
                            break;
                        case SelectMethodEnum.DOUBLE_CLICK:
                            if (Api.inventory.getItem(item.objectUID))
                            {
                                Api.ui.hideTooltip();
                                craftUi = Api.ui.getUi("craft").uiClass;
                                craftUi.fillAutoSlot(item, 1);
                            };
                            break;
                        case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                            if (Api.inventory.getItem(item.objectUID))
                            {
                                craftUi2 = Api.ui.getUi("craft").uiClass;
                                craftUi2.fillAutoSlot(item, item.quantity);
                            };
                            break;
                        case SelectMethodEnum.ALT_DOUBLE_CLICK:
                            this._waitingObject = item;
                            Api.common.openQuantityPopup(1, item.quantity, item.quantity, this.onValidQty);
                            break;
                    };
                    break;
            };
        }

        public function attach(storageUi:AbstractStorageUi):void
        {
            if (!(storageUi is StorageUi))
            {
                throw (new Error("Can't attach a CraftBehavior to a non StorageUi storage"));
            };
            this._storage = (storageUi as StorageUi);
            Api.system.disableWorldInteraction();
            this._storage.btn_moveAllToLeft.visible = false;
            this._storage.questVisible = false;
            if (this._showFilter)
            {
                this._storage.showFilter(Api.ui.getText("ui.craft.craftFilter"), Api.system.getData("filterCraftStorage"));
            };
            this.refreshFilter();
        }

        public function detach():void
        {
            Api.system.enableWorldInteraction();
            this._storage.btn_moveAllToLeft.visible = true;
            this._storage.questVisible = true;
        }

        public function onUnload():void
        {
            Api.storage.disableCraftFilter();
            Api.system.removeHook(ExchangeLeave);
            if (Api.ui.getUi(UIEnum.CRAFT))
            {
                Api.ui.unloadUi(UIEnum.CRAFT);
            }
            else
            {
                if (Api.ui.getUi(UIEnum.CRAFT_COOP))
                {
                    Api.ui.unloadUi(UIEnum.CRAFT_COOP);
                };
            };
            Api.system.sendAction(new LeaveDialogRequest());
        }

        public function isDefaultBehavior():Boolean
        {
            return (false);
        }

        public function getStorageUiName():String
        {
            return (UIEnum.STORAGE_UI);
        }

        public function getName():String
        {
            return (StorageState.CRAFT_MOD);
        }

        public function get replacable():Boolean
        {
            return (false);
        }

        private function refreshFilter():void
        {
            var skill:Skill;
            var updatedJob:Object;
            var skillId:int = Api.jobs.getCurrentCraftSkillId();
            if (skillId == 209)
            {
                return;
            };
            if (this._showFilter)
            {
                if (this._storage.btn_itemsFilter.selected)
                {
                    skill = Api.jobs.getSkillFromId(skillId);
                    updatedJob = Api.jobs.getKnownJob(skill.parentJobId);
                    Api.storage.enableCraftFilter(skill, updatedJob.jobLevel);
                }
                else
                {
                    Api.storage.disableCraftFilter();
                };
                Api.storage.updateStorageView();
                Api.storage.releaseHooks();
            }
            else
            {
                Api.storage.disableCraftFilter();
            };
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

