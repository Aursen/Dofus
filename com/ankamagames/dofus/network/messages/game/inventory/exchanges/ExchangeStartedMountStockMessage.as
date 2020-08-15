package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ExchangeStartedMountStockMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5984;

        private var _isInitialized:Boolean = false;
        public var objectsInfos:Vector.<ObjectItem> = new Vector.<ObjectItem>();
        private var _objectsInfostree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5984);
        }

        public function initExchangeStartedMountStockMessage(objectsInfos:Vector.<ObjectItem>=null):ExchangeStartedMountStockMessage
        {
            this.objectsInfos = objectsInfos;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectsInfos = new Vector.<ObjectItem>();
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
            this.serializeAs_ExchangeStartedMountStockMessage(output);
        }

        public function serializeAs_ExchangeStartedMountStockMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.objectsInfos.length);
            var _i1:uint;
            while (_i1 < this.objectsInfos.length)
            {
                (this.objectsInfos[_i1] as ObjectItem).serializeAs_ObjectItem(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeStartedMountStockMessage(input);
        }

        public function deserializeAs_ExchangeStartedMountStockMessage(input:ICustomDataInput):void
        {
            var _item1:ObjectItem;
            var _objectsInfosLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectsInfosLen)
            {
                _item1 = new ObjectItem();
                _item1.deserialize(input);
                this.objectsInfos.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExchangeStartedMountStockMessage(tree);
        }

        public function deserializeAsyncAs_ExchangeStartedMountStockMessage(tree:FuncTree):void
        {
            this._objectsInfostree = tree.addChild(this._objectsInfostreeFunc);
        }

        private function _objectsInfostreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._objectsInfostree.addChild(this._objectsInfosFunc);
                i++;
            };
        }

        private function _objectsInfosFunc(input:ICustomDataInput):void
        {
            var _item:ObjectItem = new ObjectItem();
            _item.deserialize(input);
            this.objectsInfos.push(_item);
        }


    }
}

