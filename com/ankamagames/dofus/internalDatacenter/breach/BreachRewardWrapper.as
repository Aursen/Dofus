package com.ankamagames.dofus.internalDatacenter.breach
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
    import com.ankamagames.dofus.network.types.game.context.roleplay.breach.BreachReward;
    import __AS3__.vec.*;

    public class BreachRewardWrapper implements IDataCenter 
    {

        public var id:uint = 0;
        public var remainingQty:int;
        public var buyLocks:Vector.<uint> = new Vector.<uint>();
        public var buyCriterion:GroupItemCriterion;
        public var price:uint = 0;

        public function BreachRewardWrapper(breachReward:BreachReward)
        {
            this.id = breachReward.id;
            this.remainingQty = breachReward.remainingQty;
            this.buyLocks = breachReward.buyLocks;
            this.price = breachReward.price;
            this.buyCriterion = new GroupItemCriterion(breachReward.buyCriterion);
        }

    }
}

