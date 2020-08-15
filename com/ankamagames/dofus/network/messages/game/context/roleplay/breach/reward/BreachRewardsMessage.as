package com.ankamagames.dofus.network.messages.game.context.roleplay.breach.reward
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.breach.BreachReward;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class BreachRewardsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6813;

        private var _isInitialized:Boolean = false;
        public var rewards:Vector.<BreachReward> = new Vector.<BreachReward>();
        private var _rewardstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6813);
        }

        public function initBreachRewardsMessage(rewards:Vector.<BreachReward>=null):BreachRewardsMessage
        {
            this.rewards = rewards;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.rewards = new Vector.<BreachReward>();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function unpackAsync(input:ICustomDataInput, length:uint):FuncTree
        {
            var tree:FuncTree = new FuncTree();
            tree.setRoot(input);
            this.deserializeAsync(tree);
            return (tree);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_BreachRewardsMessage(output);
        }

        public function serializeAs_BreachRewardsMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.rewards.length);
            var _i1:uint;
            while (_i1 < this.rewards.length)
            {
                (this.rewards[_i1] as BreachReward).serializeAs_BreachReward(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BreachRewardsMessage(input);
        }

        public function deserializeAs_BreachRewardsMessage(input:ICustomDataInput):void
        {
            var _item1:BreachReward;
            var _rewardsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _rewardsLen)
            {
                _item1 = new BreachReward();
                _item1.deserialize(input);
                this.rewards.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_BreachRewardsMessage(tree);
        }

        public function deserializeAsyncAs_BreachRewardsMessage(tree:FuncTree):void
        {
            this._rewardstree = tree.addChild(this._rewardstreeFunc);
        }

        private function _rewardstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._rewardstree.addChild(this._rewardsFunc);
                i++;
            };
        }

        private function _rewardsFunc(input:ICustomDataInput):void
        {
            var _item:BreachReward = new BreachReward();
            _item.deserialize(input);
            this.rewards.push(_item);
        }


    }
}

