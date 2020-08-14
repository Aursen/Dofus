package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightEffectTriggerCount;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GameActionUpdateEffectTriggerCountMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6838;

        private var _isInitialized:Boolean = false;
        public var targetIds:Vector.<GameFightEffectTriggerCount> = new Vector.<GameFightEffectTriggerCount>();
        private var _targetIdstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6838);
        }

        public function initGameActionUpdateEffectTriggerCountMessage(targetIds:Vector.<GameFightEffectTriggerCount>=null):GameActionUpdateEffectTriggerCountMessage
        {
            this.targetIds = targetIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.targetIds = new Vector.<GameFightEffectTriggerCount>();
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
            this.serializeAs_GameActionUpdateEffectTriggerCountMessage(output);
        }

        public function serializeAs_GameActionUpdateEffectTriggerCountMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.targetIds.length);
            var _i1:uint;
            while (_i1 < this.targetIds.length)
            {
                (this.targetIds[_i1] as GameFightEffectTriggerCount).serializeAs_GameFightEffectTriggerCount(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionUpdateEffectTriggerCountMessage(input);
        }

        public function deserializeAs_GameActionUpdateEffectTriggerCountMessage(input:ICustomDataInput):void
        {
            var _item1:GameFightEffectTriggerCount;
            var _targetIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _targetIdsLen)
            {
                _item1 = new GameFightEffectTriggerCount();
                _item1.deserialize(input);
                this.targetIds.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameActionUpdateEffectTriggerCountMessage(tree);
        }

        public function deserializeAsyncAs_GameActionUpdateEffectTriggerCountMessage(tree:FuncTree):void
        {
            this._targetIdstree = tree.addChild(this._targetIdstreeFunc);
        }

        private function _targetIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._targetIdstree.addChild(this._targetIdsFunc);
                i++;
            };
        }

        private function _targetIdsFunc(input:ICustomDataInput):void
        {
            var _item:GameFightEffectTriggerCount = new GameFightEffectTriggerCount();
            _item.deserialize(input);
            this.targetIds.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.actions.fight

