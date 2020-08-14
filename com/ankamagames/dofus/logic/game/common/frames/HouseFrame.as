package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.AccountHouseMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseBuyAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseBuyRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseSellAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseSellRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseSellFromInsideAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseSellFromInsideRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.purchasable.PurchasableDialogMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildNoneMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildRightsMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseSellingUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseBuyResultMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseGuildRightsViewAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildRightsViewMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseGuildShareAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildShareRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseKickAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseKickRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseKickIndoorMerchantAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseKickIndoorMerchantRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableStateUpdateHouseDoorMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableShowCodeDialogMessage;
    import com.ankamagames.dofus.logic.game.common.actions.LockableChangeCodeAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableChangeCodeMessage;
    import com.ankamagames.dofus.logic.game.common.actions.HouseLockFromInsideAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseLockFromInsideRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableCodeResultMessage;
    import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import flash.utils.Dictionary;
    import __AS3__.vec.*;

    public class HouseFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HouseFrame));

        private var _houseDialogFrame:HouseDialogFrame;
        private var _accountHouses:Vector.<HouseWrapper>;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get accountHouses():Vector.<HouseWrapper>
        {
            return (this._accountHouses);
        }

        public function pushed():Boolean
        {
            this._houseDialogFrame = new HouseDialogFrame();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var i:int;
            var housesListSize:int;
            var house:HouseWrapper;
            var lda:LeaveDialogAction;
            var lsrmsg:LeaveDialogRequestMessage;
            var ahm:AccountHouseMessage;
            var hba:HouseBuyAction;
            var hbrm:HouseBuyRequestMessage;
            var hsa:HouseSellAction;
            var hsrm:HouseSellRequestMessage;
            var hsfia:HouseSellFromInsideAction;
            var hsfirmag:HouseSellFromInsideRequestMessage;
            var pdmsg:PurchasableDialogMessage;
            var houseWrapper:HouseWrapper;
            var hgnm:HouseGuildNoneMessage;
            var hgrm:HouseGuildRightsMessage;
            var hsum:HouseSellingUpdateMessage;
            var houseIndex:int;
            var nhbrm:HouseBuyResultMessage;
            var hgrva:HouseGuildRightsViewAction;
            var hgrvm:HouseGuildRightsViewMessage;
            var hsga:HouseGuildShareAction;
            var hgsrm:HouseGuildShareRequestMessage;
            var hka:HouseKickAction;
            var hkrm:HouseKickRequestMessage;
            var hkima:HouseKickIndoorMerchantAction;
            var hkimrm:HouseKickIndoorMerchantRequestMessage;
            var lsuhdmsg:LockableStateUpdateHouseDoorMessage;
            var lscdmsg:LockableShowCodeDialogMessage;
            var lcca:LockableChangeCodeAction;
            var lccmsg:LockableChangeCodeMessage;
            var hlfia:HouseLockFromInsideAction;
            var hlfimsg:HouseLockFromInsideRequestMessage;
            var lcrmsg:LockableCodeResultMessage;
            var accountHouse:AccountHouseInformations;
            switch (true)
            {
                case (msg is LeaveDialogAction):
                    lda = (msg as LeaveDialogAction);
                    lsrmsg = new LeaveDialogRequestMessage();
                    lsrmsg.initLeaveDialogRequestMessage();
                    ConnectionsHandler.getConnection().send(lsrmsg);
                    return (true);
                case (msg is AccountHouseMessage):
                    ahm = (msg as AccountHouseMessage);
                    this._accountHouses = new Vector.<HouseWrapper>();
                    for each (accountHouse in ahm.houses)
                    {
                        this._accountHouses.push(HouseWrapper.createOwned(accountHouse));
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.HouseInformations, this._accountHouses);
                    return (true);
                case (msg is HouseBuyAction):
                    hba = (msg as HouseBuyAction);
                    hbrm = new HouseBuyRequestMessage();
                    hbrm.initHouseBuyRequestMessage(hba.proposedPrice);
                    ConnectionsHandler.getConnection().send(hbrm);
                    return (true);
                case (msg is HouseSellAction):
                    hsa = (msg as HouseSellAction);
                    hsrm = new HouseSellRequestMessage();
                    hsrm.initHouseSellRequestMessage(hsa.instanceId, hsa.amount, hsa.forSale);
                    ConnectionsHandler.getConnection().send(hsrm);
                    return (true);
                case (msg is HouseSellFromInsideAction):
                    hsfia = (msg as HouseSellFromInsideAction);
                    hsfirmag = new HouseSellFromInsideRequestMessage();
                    hsfirmag.initHouseSellFromInsideRequestMessage(hsfia.instanceId, hsfia.amount, hsfia.forSale);
                    ConnectionsHandler.getConnection().send(hsfirmag);
                    return (true);
                case (msg is PurchasableDialogMessage):
                    pdmsg = (msg as PurchasableDialogMessage);
                    houseWrapper = this.getHouseInformations(pdmsg.purchasableId);
                    Kernel.getWorker().addFrame(this._houseDialogFrame);
                    KernelEventsManager.getInstance().processCallback(HookList.PurchasableDialog, pdmsg.buyOrSell, pdmsg.price, houseWrapper, pdmsg.purchasableInstanceId);
                    return (true);
                case (msg is HouseGuildNoneMessage):
                    hgnm = (msg as HouseGuildNoneMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.HouseGuildNone);
                    for each (house in this._accountHouses)
                    {
                        if ((((house.houseId == hgnm.houseId) && (house.houseInstances)) && (house.houseInstances[0].id == hgnm.instanceId)))
                        {
                            house.houseInstances[0].setGuildIdentity(null);
                            break;
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.HouseInformations, this._accountHouses);
                    return (true);
                case (msg is HouseGuildRightsMessage):
                    hgrm = (msg as HouseGuildRightsMessage);
                    for each (house in this._accountHouses)
                    {
                        if ((((house.houseId == hgrm.houseId) && (house.houseInstances)) && (house.houseInstances[0].id == hgrm.instanceId)))
                        {
                            house.houseInstances[0].setGuildIdentity(hgrm.guildInfo);
                            break;
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.HouseInformations, this._accountHouses);
                    KernelEventsManager.getInstance().processCallback(HookList.HouseGuildRights, hgrm.houseId, house.houseInstances[0].guildIdentity, hgrm.rights);
                    return (true);
                case (msg is HouseSellingUpdateMessage):
                    hsum = (msg as HouseSellingUpdateMessage);
                    houseIndex = 0;
                    for each (house in this._accountHouses)
                    {
                        if ((((house.houseId == hsum.houseId) && (house.houseInstances)) && (house.houseInstances[0].id == hsum.instanceId)))
                        {
                            house.houseInstances[0].price = hsum.realPrice;
                            break;
                        };
                        houseIndex++;
                    };
                    if (!house)
                    {
                        _log.error((((("Tentative d'update la maison " + hsum.houseId) + " ") + hsum.instanceId) + " qui n'existe pas."));
                        return (true);
                    };
                    if (hsum.buyerName == PlayerManager.getInstance().nickname)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.HouseSellingUpdate, hsum.houseId, hsum.instanceId, hsum.realPrice, hsum.buyerName);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.HouseSold, hsum.houseId, hsum.instanceId, hsum.realPrice, hsum.buyerName, house.subareaName, house.worldX, house.worldY);
                        this._accountHouses.splice(houseIndex, 1);
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.HouseInformations, this._accountHouses);
                    return (true);
                case (msg is HouseBuyResultMessage):
                    nhbrm = (msg as HouseBuyResultMessage);
                    return (true);
                case (msg is HouseGuildRightsViewAction):
                    hgrva = (msg as HouseGuildRightsViewAction);
                    hgrvm = new HouseGuildRightsViewMessage();
                    hgrvm.initHouseGuildRightsViewMessage(hgrva.houseId, hgrva.instanceId);
                    ConnectionsHandler.getConnection().send(hgrvm);
                    return (true);
                case (msg is HouseGuildShareAction):
                    hsga = (msg as HouseGuildShareAction);
                    hgsrm = new HouseGuildShareRequestMessage();
                    hgsrm.initHouseGuildShareRequestMessage(hsga.houseId, hsga.instanceId, hsga.enabled, hsga.rights);
                    ConnectionsHandler.getConnection().send(hgsrm);
                    return (true);
                case (msg is HouseKickAction):
                    hka = (msg as HouseKickAction);
                    hkrm = new HouseKickRequestMessage();
                    hkrm.initHouseKickRequestMessage(hka.id);
                    ConnectionsHandler.getConnection().send(hkrm);
                    return (true);
                case (msg is HouseKickIndoorMerchantAction):
                    hkima = (msg as HouseKickIndoorMerchantAction);
                    hkimrm = new HouseKickIndoorMerchantRequestMessage();
                    hkimrm.initHouseKickIndoorMerchantRequestMessage(hkima.cellId);
                    ConnectionsHandler.getConnection().send(hkimrm);
                    return (true);
                case (msg is LockableStateUpdateHouseDoorMessage):
                    lsuhdmsg = (msg as LockableStateUpdateHouseDoorMessage);
                    for each (house in this._accountHouses)
                    {
                        if ((((house.houseId == lsuhdmsg.houseId) && (house.houseInstances)) && (house.houseInstances[0].id == lsuhdmsg.instanceId)))
                        {
                            house.houseInstances[0].isLocked = lsuhdmsg.locked;
                            break;
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.HouseInformations, this._accountHouses);
                    KernelEventsManager.getInstance().processCallback(HookList.LockableStateUpdateHouseDoor, lsuhdmsg.houseId, lsuhdmsg.instanceId, lsuhdmsg.locked);
                    return (true);
                case (msg is LockableShowCodeDialogMessage):
                    lscdmsg = (msg as LockableShowCodeDialogMessage);
                    Kernel.getWorker().addFrame(this._houseDialogFrame);
                    KernelEventsManager.getInstance().processCallback(HookList.LockableShowCode, lscdmsg.changeOrUse, lscdmsg.codeSize);
                    return (true);
                case (msg is LockableChangeCodeAction):
                    lcca = (msg as LockableChangeCodeAction);
                    lccmsg = new LockableChangeCodeMessage();
                    lccmsg.initLockableChangeCodeMessage(lcca.code);
                    ConnectionsHandler.getConnection().send(lccmsg);
                    return (true);
                case (msg is HouseLockFromInsideAction):
                    hlfia = (msg as HouseLockFromInsideAction);
                    hlfimsg = new HouseLockFromInsideRequestMessage();
                    hlfimsg.initHouseLockFromInsideRequestMessage(hlfia.code);
                    ConnectionsHandler.getConnection().send(hlfimsg);
                    return (true);
                case (msg is LockableCodeResultMessage):
                    lcrmsg = (msg as LockableCodeResultMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.LockableCodeResult, lcrmsg.result);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        private function getHouseInformations(houseID:Number):HouseWrapper
        {
            var hi:HouseWrapper;
            var houseList:Dictionary = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).housesInformations;
            for each (hi in houseList)
            {
                if (hi.houseId == houseID)
                {
                    return (hi);
                };
            };
            return (null);
        }


    }
} com.ankamagames.dofus.logic.game.common.frames

