package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class GameActionFightSummonMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5825;

        private var _isInitialized:Boolean = false;
        public var summons:Vector.<GameFightFighterInformations> = new Vector.<GameFightFighterInformations>();
        private var _summonstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (5825);
        }

        public function initGameActionFightSummonMessage(actionId:uint=0, sourceId:Number=0, summons:Vector.<GameFightFighterInformations>=null):GameActionFightSummonMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.summons = summons;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.summons = new Vector.<GameFightFighterInformations>();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameActionFightSummonMessage(output);
        }

        public function serializeAs_GameActionFightSummonMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeShort(this.summons.length);
            var _i1:uint;
            while (_i1 < this.summons.length)
            {
                output.writeShort((this.summons[_i1] as GameFightFighterInformations).getTypeId());
                (this.summons[_i1] as GameFightFighterInformations).serialize(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightSummonMessage(input);
        }

        public function deserializeAs_GameActionFightSummonMessage(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:GameFightFighterInformations;
            super.deserialize(input);
            var _summonsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _summonsLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(GameFightFighterInformations, _id1);
                _item1.deserialize(input);
                this.summons.push(_item1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameActionFightSummonMessage(tree);
        }

        public function deserializeAsyncAs_GameActionFightSummonMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._summonstree = tree.addChild(this._summonstreeFunc);
        }

        private function _summonstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._summonstree.addChild(this._summonsFunc);
                i++;
            };
        }

        private function _summonsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:GameFightFighterInformations = ProtocolTypeManager.getInstance(GameFightFighterInformations, _id);
            _item.deserialize(input);
            this.summons.push(_item);
        }


    }
}

