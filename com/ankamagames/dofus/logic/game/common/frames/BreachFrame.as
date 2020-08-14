package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.types.game.context.roleplay.breach.BreachBranch;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.MapComplementaryInformationsBreachMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.branch.BreachBranchesMessage;
    import com.ankamagames.dofus.logic.game.common.actions.breach.BreachInvitationRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.meeting.BreachInvitationRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachCharactersMessage;
    import com.ankamagames.dofus.logic.game.common.actions.breach.BreachKickRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.meeting.BreachKickRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachStateMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachBonusMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachBudgetMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachSavedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.reward.BreachRewardsMessage;
    import com.ankamagames.dofus.logic.game.common.actions.breach.BreachRewardBuyAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.reward.BreachRewardBuyMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.reward.BreachRewardBoughtMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachExitRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachRoomUnlockRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachRoomUnlockResultMessage;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
    import com.ankamagames.dofus.network.types.game.context.roleplay.breach.BreachReward;
    import com.ankamagames.dofus.internalDatacenter.breach.BreachBranchWrapper;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.misc.lists.BreachHookList;
    import com.ankamagames.dofus.network.types.game.context.roleplay.breach.ExtendedBreachBranch;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachRoomLockedMessage;
    import com.ankamagames.dofus.internalDatacenter.breach.BreachRewardWrapper;
    import com.ankamagames.dofus.logic.game.common.actions.breach.BreachExitRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.breach.BreachRoomUnlockAction;
    import com.ankamagames.dofus.network.enums.BreachRoomUnlockEnum;
    import com.ankamagames.jerakine.messages.Message;
    import __AS3__.vec.*;

    public class BreachFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BreachFrame));

        private var _breachCharacterList:Vector.<Number> = new Vector.<Number>();
        private var _budget:uint;
        private var _floor:uint;
        private var _room:uint;
        private var _bonuses:Vector.<EffectInstanceInteger>;
        private var _branches:Dictionary = new Dictionary();
        private var _ownerId:Number;
        private var _wrappedBranches:Array = [];
        private var _infinityLevel:uint;


        public function get priority():int
        {
            return (Priority.LOW);
        }

        public function get budget():uint
        {
            return (this._budget);
        }

        public function get room():uint
        {
            return (this._room);
        }

        public function set room(value:uint):void
        {
            this._room = value;
        }

        public function get floor():uint
        {
            return (this._floor);
        }

        public function set floor(value:uint):void
        {
            this._floor = value;
        }

        public function get breachCharacterList():Vector.<Number>
        {
            return (this._breachCharacterList);
        }

        public function get branches():Dictionary
        {
            return (this._branches);
        }

        public function set branches(value:Dictionary):void
        {
            this._branches = value;
        }

        public function set ownerId(pOwnerId:Number):void
        {
            this._ownerId = pOwnerId;
        }

        public function get ownerId():Number
        {
            return (this._ownerId);
        }

        public function get infinityLevel():uint
        {
            return (this._infinityLevel);
        }

        public function set infinityLevel(value:uint):void
        {
            this._infinityLevel = value;
        }

        public function get wrappedBranches():Array
        {
            return (this._wrappedBranches);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var branch:BreachBranch;
            var mcibm:MapComplementaryInformationsBreachMessage;
            var bbrespmsg:BreachBranchesMessage;
            var bira:BreachInvitationRequestAction;
            var birm:BreachInvitationRequestMessage;
            var bcum:BreachCharactersMessage;
            var bkra:BreachKickRequestAction;
            var bkrm:BreachKickRequestMessage;
            var bsm:BreachStateMessage;
            var bbom:BreachBonusMessage;
            var bonusEffectInteger:EffectInstanceInteger;
            var bbum:BreachBudgetMessage;
            var bsam:BreachSavedMessage;
            var brrmsg:BreachRewardsMessage;
            var rewards:Array;
            var brba:BreachRewardBuyAction;
            var brbamsg:BreachRewardBuyMessage;
            var brbmsg:BreachRewardBoughtMessage;
            var berm:BreachExitRequestMessage;
            var buyRoomMsg:BreachRoomUnlockRequestMessage;
            var breachRoomUnlocked:BreachRoomUnlockResultMessage;
            var b:BreachBranch;
            var objectEffect:ObjectEffectInteger;
            var effectInteger:EffectInstanceInteger;
            var reward:BreachReward;
            var branchWrapped:BreachBranchWrapper;
            switch (true)
            {
                case (msg is MapComplementaryInformationsBreachMessage):
                    mcibm = (msg as MapComplementaryInformationsBreachMessage);
                    this._floor = mcibm.floor;
                    this._room = mcibm.room;
                    this._infinityLevel = mcibm.infinityMode;
                    this._branches = new Dictionary();
                    this._wrappedBranches = [];
                    for each (b in mcibm.branches)
                    {
                        this._branches[b.element] = {
                            "room":b.room,
                            "bosses":b.bosses,
                            "monsters":b.monsters,
                            "map":b.map
                        };
                        this._wrappedBranches.push(new BreachBranchWrapper(b));
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData, PlayedCharacterManager.getInstance().currentMap, PlayedCharacterManager.getInstance().currentSubArea.id, Dofus.getInstance().options.getOption("mapCoordinates"));
                    KernelEventsManager.getInstance().processCallback(HookList.BreachTeleport, true);
                    KernelEventsManager.getInstance().processCallback(BreachHookList.BreachMapInfos, ((mcibm.branches.length == 1) ? mcibm.branches[0].bosses : null));
                    return (true);
                case (msg is BreachBranchesMessage):
                    this._wrappedBranches = [];
                    bbrespmsg = (msg as BreachBranchesMessage);
                    for each (branch in bbrespmsg.branches)
                    {
                        this._branches[branch.element] = {
                            "room":branch.room,
                            "bosses":branch.bosses,
                            "monsters":ExtendedBreachBranch(branch).monsters,
                            "map":branch.map
                        };
                        this._wrappedBranches.push(new BreachBranchWrapper(branch));
                    };
                    KernelEventsManager.getInstance().processCallback(BreachHookList.BreachBranchesList, this._wrappedBranches);
                    return (true);
                case (msg is BreachInvitationRequestAction):
                    bira = (msg as BreachInvitationRequestAction);
                    birm = new BreachInvitationRequestMessage();
                    birm.initBreachInvitationRequestMessage(bira.guests);
                    ConnectionsHandler.getConnection().send(birm);
                    return (true);
                case (msg is BreachCharactersMessage):
                    bcum = (msg as BreachCharactersMessage);
                    this._breachCharacterList = bcum.characters;
                    KernelEventsManager.getInstance().processCallback(BreachHookList.BreachCharactersListUpdate);
                    return (true);
                case (msg is BreachKickRequestAction):
                    bkra = (msg as BreachKickRequestAction);
                    bkrm = new BreachKickRequestMessage();
                    bkrm.initBreachKickRequestMessage(bkra.guestId);
                    ConnectionsHandler.getConnection().send(bkrm);
                    return (true);
                case (msg is BreachStateMessage):
                    bsm = (msg as BreachStateMessage);
                    this._budget = bsm.bugdet;
                    this._bonuses = new Vector.<EffectInstanceInteger>();
                    for each (objectEffect in bsm.bonuses)
                    {
                        effectInteger = new EffectInstanceInteger();
                        effectInteger.effectId = objectEffect.actionId;
                        effectInteger.value = objectEffect.value;
                        this._bonuses.push(effectInteger);
                    };
                    KernelEventsManager.getInstance().processCallback(BreachHookList.BreachState, bsm.owner.name, this._bonuses, bsm.saved);
                    return (true);
                case (msg is BreachBonusMessage):
                    bbom = (msg as BreachBonusMessage);
                    bonusEffectInteger = new EffectInstanceInteger();
                    bonusEffectInteger.effectId = bbom.bonus.actionId;
                    bonusEffectInteger.value = bbom.bonus.value;
                    KernelEventsManager.getInstance().processCallback(BreachHookList.BreachBonus, bonusEffectInteger);
                    return (true);
                case (msg is BreachBudgetMessage):
                    bbum = (msg as BreachBudgetMessage);
                    this._budget = bbum.bugdet;
                    KernelEventsManager.getInstance().processCallback(BreachHookList.BreachBudget);
                    return (true);
                case (msg is BreachSavedMessage):
                    bsam = (msg as BreachSavedMessage);
                    KernelEventsManager.getInstance().processCallback(BreachHookList.BreachSaved, bsam.saved);
                    return (true);
                case (msg is BreachRoomLockedMessage):
                    KernelEventsManager.getInstance().processCallback(BreachHookList.BreachBranchesList, this._wrappedBranches);
                    return (true);
                case (msg is BreachRewardsMessage):
                    brrmsg = (msg as BreachRewardsMessage);
                    rewards = [];
                    for each (reward in brrmsg.rewards)
                    {
                        rewards.push(new BreachRewardWrapper(reward));
                    };
                    KernelEventsManager.getInstance().processCallback(BreachHookList.OpenBreachShop, rewards);
                    return (true);
                case (msg is BreachRewardBuyAction):
                    brba = (msg as BreachRewardBuyAction);
                    brbamsg = new BreachRewardBuyMessage();
                    brbamsg.initBreachRewardBuyMessage(brba.id);
                    ConnectionsHandler.getConnection().send(brbamsg);
                    return (true);
                case (msg is BreachRewardBoughtMessage):
                    brbmsg = (msg as BreachRewardBoughtMessage);
                    KernelEventsManager.getInstance().processCallback(BreachHookList.BreachRewardBought, brbmsg.id, brbmsg.bought);
                    return (true);
                case (msg is BreachExitRequestAction):
                    berm = new BreachExitRequestMessage();
                    berm.initBreachExitRequestMessage();
                    ConnectionsHandler.getConnection().send(berm);
                    return (true);
                case (msg is BreachRoomUnlockAction):
                    buyRoomMsg = new BreachRoomUnlockRequestMessage();
                    buyRoomMsg.initBreachRoomUnlockRequestMessage((msg as BreachRoomUnlockAction).roomId);
                    ConnectionsHandler.getConnection().send(buyRoomMsg);
                    return (true);
                case (msg is BreachRoomUnlockResultMessage):
                    breachRoomUnlocked = (msg as BreachRoomUnlockResultMessage);
                    if (breachRoomUnlocked.result === BreachRoomUnlockEnum.BREACH_UNLOCK_SUCCESS)
                    {
                        for each (branchWrapped in this._wrappedBranches)
                        {
                            if (branchWrapped.room == breachRoomUnlocked.roomId)
                            {
                                branchWrapped.isLocked = false;
                                break;
                            };
                        };
                        KernelEventsManager.getInstance().processCallback(BreachHookList.BreachBuyRoom, this._wrappedBranches);
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
} com.ankamagames.dofus.logic.game.common.frames

