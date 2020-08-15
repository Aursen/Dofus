package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ExchangeShopStockMultiMovementRemovedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6037;

        private var _isInitialized:Boolean = false;
        public var objectIdList:Vector.<uint> = new Vector.<uint>();
        private var _objectIdListtree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6037);
        }

        public function initExchangeShopStockMultiMovementRemovedMessage(objectIdList:Vector.<uint>=null):ExchangeShopStockMultiMovementRemovedMessage
        {
            this.objectIdList = objectIdList;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectIdList = new Vector.<uint>();
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
            this.serializeAs_ExchangeShopStockMultiMovementRemovedMessage(output);
        }

        public function serializeAs_ExchangeShopStockMultiMovementRemovedMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.objectIdList.length);
            var _i1:uint;
            while (_i1 < this.objectIdList.length)
            {
                if (this.objectIdList[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.objectIdList[_i1]) + ") on element 1 (starting at 1) of objectIdList.")));
                };
                output.writeVarInt(this.objectIdList[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeShopStockMultiMovementRemovedMessage(input);
        }

        public function deserializeAs_ExchangeShopStockMultiMovementRemovedMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _objectIdListLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectIdListLen)
            {
                _val1 = input.readVarUhInt();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of objectIdList.")));
                };
                this.objectIdList.push(_val1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExchangeShopStockMultiMovementRemovedMessage(tree);
        }

        public function deserializeAsyncAs_ExchangeShopStockMultiMovementRemovedMessage(tree:FuncTree):void
        {
            this._objectIdListtree = tree.addChild(this._objectIdListtreeFunc);
        }

        private function _objectIdListtreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._objectIdListtree.addChild(this._objectIdListFunc);
                i++;
            };
        }

        private function _objectIdListFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhInt();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of objectIdList.")));
            };
            this.objectIdList.push(_val);
        }


    }
}

