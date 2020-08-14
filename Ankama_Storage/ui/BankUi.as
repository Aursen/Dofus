package Ankama_Storage.ui
{
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.EntityDisplayer;
    import d2hooks.BankViewContent;
    import d2hooks.StorageKamasUpdate;
    import d2hooks.ExchangeLeave;
    import d2hooks.AllianceMembershipUpdated;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import d2hooks.ExchangeWeight;
    import Ankama_Storage.ui.enum.StorageState;
    import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
    import d2actions.OpenInventory;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import Ankama_Storage.Api;
    import d2actions.LeaveDialogRequest;
    import d2actions.CloseInventory;
    import d2hooks.*;
    import d2actions.*;

    public class BankUi extends AbstractStorageUi 
    {

        public var filterCtr:GraphicContainer;
        public var entityDisplayer:EntityDisplayer;
        private var _objectToExchange:Object;
        private var _iconFrame:int;
        protected var _sortProperty2:int = -1;


        override public function main(param:Object):void
        {
            var behavior:String;
            var mount:Object;
            param.storageMod = "bankUi";
            super.main(param);
            sysApi.addHook(BankViewContent, onInventoryUpdate);
            sysApi.addHook(StorageKamasUpdate, onKamasUpdate);
            sysApi.addHook(ExchangeLeave, this.onExchangeLeave);
            sysApi.addHook(AllianceMembershipUpdated, this.onAllianceMembershipUpdated);
            this.categoryFilter = ItemCategoryEnum.ALL_CATEGORY;
            _hasSlot = false;
            _exchangeType = param.exchangeType;
            switch (_exchangeType)
            {
                case ExchangeTypeEnum.TAXCOLLECTOR:
                    lbl_title.text = uiApi.getText("ui.common.taxCollector");
                    this._iconFrame = 2;
                    sysApi.addHook(ExchangeWeight, onInventoryWeight);
                    behavior = StorageState.TAXCOLLECTOR_MOD;
                    break;
                case ExchangeTypeEnum.MOUNT:
                    mount = playerApi.getMount();
                    lbl_title.text = uiApi.getText("ui.common.inventory");
                    ctr_kamas.visible = false;
                    tx_weightBar.visible = true;
                    sysApi.addHook(ExchangeWeight, onInventoryWeight);
                    behavior = StorageState.MOUNT_MOD;
                    break;
                case ExchangeTypeEnum.STORAGE:
                case ExchangeTypeEnum.HAVENBAG:
                    this._iconFrame = 4;
                    lbl_title.text = uiApi.getText("ui.common.storage");
                    if (!playerApi.isInHavenbag())
                    {
                        _hasSlot = true;
                        _slotsMax = ((param.maxSlots) ? param.maxSlots : 0);
                        tx_weightBar.visible = (!(_slotsMax == 0));
                    }
                    else
                    {
                        sysApi.addHook(ExchangeWeight, onInventoryWeight);
                    };
                    lbl_kamas.handCursor = (!(playerApi.hasDebt()));
                    lbl_kamas.useHandCursor = (!(playerApi.hasDebt()));
                    if (_exchangeType == ExchangeTypeEnum.STORAGE)
                    {
                        ctr_kamas.visible = false;
                    };
                    behavior = StorageState.BANK_MOD;
                    break;
                case ExchangeTypeEnum.BANK:
                    this._iconFrame = 4;
                    lbl_title.text = uiApi.getText("ui.common.bank");
                    _hasSlot = true;
                    _slotsMax = ((param.maxSlots) ? param.maxSlots : 0);
                    tx_weightBar.visible = (!(_slotsMax == 0));
                    lbl_kamas.handCursor = (!(playerApi.hasDebt()));
                    behavior = StorageState.BANK_MOD;
                    break;
                case ExchangeTypeEnum.TRASHBIN:
                    this._iconFrame = 12;
                    lbl_title.text = uiApi.getText("ui.common.bin");
                    _hasSlot = true;
                    _slotsMax = ((param.maxSlots) ? param.maxSlots : 0);
                    ctr_kamas.visible = false;
                    tx_weightBar.visible = (!(_slotsMax == 0));
                    behavior = StorageState.BANK_MOD;
                    break;
                case ExchangeTypeEnum.ALLIANCE_PRISM:
                    this._iconFrame = 4;
                    lbl_title.text = uiApi.getText("ui.zaap.prism");
                    _hasSlot = true;
                    _slotsMax = ((param.maxSlots) ? param.maxSlots : 0);
                    tx_weightBar.visible = (!(_slotsMax == 0));
                    behavior = StorageState.BANK_MOD;
                    break;
                default:
                    lbl_title.text = uiApi.getText("ui.common.storage");
                    behavior = StorageState.BANK_MOD;
            };
            mainCtr.x = 16;
            mainCtr.y = (0x0400 - (mainCtr.height + 155));
            if (((param.inventory) && (param.kamas)))
            {
                onInventoryUpdate(param.inventory, param.kamas);
            };
            this.subFilter = -1;
            storageApi.releaseBankHooks();
            sysApi.sendAction(new OpenInventory(behavior));
        }

        public function isCtrKamaVisible():Boolean
        {
            return (ctr_kamas.visible);
        }

        override protected function getStorageTypes(categoryFilter:int):Object
        {
            return (storageApi.getBankStorageTypes(categoryFilter));
        }

        override public function set categoryFilter(category:int):void
        {
            super.categoryFilter = category;
            storageApi.setDisplayedBankCategory(categoryFilter);
        }

        override public function set subFilter(filter:int):void
        {
            var cb_category:Object;
            updateSubFilter(this.getStorageTypes(categoryFilter));
            var hasFilter:Boolean;
            for each (cb_category in super.cb_category.dataProvider)
            {
                if (cb_category.filterType == filter)
                {
                    hasFilter = true;
                    break;
                };
            };
            if (!hasFilter)
            {
                filter = -1;
            };
            storageApi.setBankStorageFilter(filter);
            super.subFilter = filter;
        }

        override public function onRollOver(target:Object):void
        {
            var text:String;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            switch (target)
            {
                case btn_moveAllToLeft:
                case btn_moveAllToRight:
                    text = uiApi.getText("ui.storage.advancedTransferts");
                    break;
                default:
                    super.onRollOver(target);
                    return;
            };
            if (text)
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            }
            else
            {
                super.onRollOver(target);
            };
        }

        override public function onRelease(target:Object):void
        {
            var contextMenu:Array;
            switch (target)
            {
                case btn_moveAllToLeft:
                case btn_moveAllToRight:
                    contextMenu = new Array();
                    contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getAll"), _storageBehavior.transfertAll, null, false, null, false, true));
                    contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getVisible"), _storageBehavior.transfertList, null, false, null, false, true));
                    contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getExisting"), _storageBehavior.transfertExisting, null, false, null, false, true));
                    modContextMenu.createContextMenu(contextMenu);
                    break;
            };
            super.onRelease(target);
        }

        override public function unload():void
        {
            super.unload();
            sysApi.removeHook(BankViewContent);
            sysApi.removeHook(StorageKamasUpdate);
            sysApi.removeHook(ExchangeLeave);
            var mountInfo:Object = uiApi.getUi(UIEnum.MOUNT_INFO);
            if (mountInfo)
            {
                mountInfo.visible = true;
            };
            Api.system.sendAction(new LeaveDialogRequest());
            sysApi.sendAction(new CloseInventory());
        }

        override protected function releaseHooks():void
        {
            storageApi.releaseBankHooks();
        }

        override protected function sortOn(property:int, numeric:Boolean=false):void
        {
            storageApi.resetBankSort();
            this.addSort(property);
        }

        override protected function addSort(property:int):void
        {
            storageApi.sortBank(property, false);
            this.releaseHooks();
        }

        override protected function getSortFields():Object
        {
            return (storageApi.getSortBankFields());
        }

        public function onExchangeLeave(success:Boolean):void
        {
            uiApi.unloadUi(uiApi.me().name);
        }

        private function onAllianceMembershipUpdated(hasAlliance:Boolean):void
        {
            if (((!(hasAlliance)) && (_exchangeType == ExchangeTypeEnum.ALLIANCE_PRISM)))
            {
                this.unload();
            };
        }


    }
} Ankama_Storage.ui

