package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobBookSubscription;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class JobBookSubscriptionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6593;

        private var _isInitialized:Boolean = false;
        public var subscriptions:Vector.<JobBookSubscription> = new Vector.<JobBookSubscription>();
        private var _subscriptionstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6593);
        }

        public function initJobBookSubscriptionMessage(subscriptions:Vector.<JobBookSubscription>=null):JobBookSubscriptionMessage
        {
            this.subscriptions = subscriptions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.subscriptions = new Vector.<JobBookSubscription>();
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
            this.serializeAs_JobBookSubscriptionMessage(output);
        }

        public function serializeAs_JobBookSubscriptionMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.subscriptions.length);
            var _i1:uint;
            while (_i1 < this.subscriptions.length)
            {
                (this.subscriptions[_i1] as JobBookSubscription).serializeAs_JobBookSubscription(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobBookSubscriptionMessage(input);
        }

        public function deserializeAs_JobBookSubscriptionMessage(input:ICustomDataInput):void
        {
            var _item1:JobBookSubscription;
            var _subscriptionsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _subscriptionsLen)
            {
                _item1 = new JobBookSubscription();
                _item1.deserialize(input);
                this.subscriptions.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_JobBookSubscriptionMessage(tree);
        }

        public function deserializeAsyncAs_JobBookSubscriptionMessage(tree:FuncTree):void
        {
            this._subscriptionstree = tree.addChild(this._subscriptionstreeFunc);
        }

        private function _subscriptionstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._subscriptionstree.addChild(this._subscriptionsFunc);
                i++;
            };
        }

        private function _subscriptionsFunc(input:ICustomDataInput):void
        {
            var _item:JobBookSubscription = new JobBookSubscription();
            _item.deserialize(input);
            this.subscriptions.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.job

