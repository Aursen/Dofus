package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemGenericQuantity;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ExchangeBidHouseUnsoldItemsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6612;

        private var _isInitialized:Boolean = false;
        public var items:Vector.<ObjectItemGenericQuantity> = new Vector.<ObjectItemGenericQuantity>();
        private var _itemstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6612);
        }

        public function initExchangeBidHouseUnsoldItemsMessage(items:Vector.<ObjectItemGenericQuantity>=null):ExchangeBidHouseUnsoldItemsMessage
        {
            this.items = items;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.items = new Vector.<ObjectItemGenericQuantity>();
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
            this.serializeAs_ExchangeBidHouseUnsoldItemsMessage(output);
        }

        public function serializeAs_ExchangeBidHouseUnsoldItemsMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.items.length);
            var _i1:uint;
            while (_i1 < this.items.length)
            {
                (this.items[_i1] as ObjectItemGenericQuantity).serializeAs_ObjectItemGenericQuantity(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeBidHouseUnsoldItemsMessage(input);
        }

        public function deserializeAs_ExchangeBidHouseUnsoldItemsMessage(input:ICustomDataInput):void
        {
            var _item1:ObjectItemGenericQuantity;
            var _itemsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _itemsLen)
            {
                _item1 = new ObjectItemGenericQuantity();
                _item1.deserialize(input);
                this.items.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExchangeBidHouseUnsoldItemsMessage(tree);
        }

        public function deserializeAsyncAs_ExchangeBidHouseUnsoldItemsMessage(tree:FuncTree):void
        {
            this._itemstree = tree.addChild(this._itemstreeFunc);
        }

        private function _itemstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._itemstree.addChild(this._itemsFunc);
                i++;
            };
        }

        private function _itemsFunc(input:ICustomDataInput):void
        {
            var _item:ObjectItemGenericQuantity = new ObjectItemGenericQuantity();
            _item.deserialize(input);
            this.items.push(_item);
        }


    }
}

