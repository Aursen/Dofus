package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.data.items.SellerBuyerDescriptor;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInBid;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ExchangeStartedBidSellerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5905;

        private var _isInitialized:Boolean = false;
        public var sellerDescriptor:SellerBuyerDescriptor = new SellerBuyerDescriptor();
        public var objectsInfos:Vector.<ObjectItemToSellInBid> = new Vector.<ObjectItemToSellInBid>();
        private var _sellerDescriptortree:FuncTree;
        private var _objectsInfostree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5905);
        }

        public function initExchangeStartedBidSellerMessage(sellerDescriptor:SellerBuyerDescriptor=null, objectsInfos:Vector.<ObjectItemToSellInBid>=null):ExchangeStartedBidSellerMessage
        {
            this.sellerDescriptor = sellerDescriptor;
            this.objectsInfos = objectsInfos;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.sellerDescriptor = new SellerBuyerDescriptor();
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
            this.serializeAs_ExchangeStartedBidSellerMessage(output);
        }

        public function serializeAs_ExchangeStartedBidSellerMessage(output:ICustomDataOutput):void
        {
            this.sellerDescriptor.serializeAs_SellerBuyerDescriptor(output);
            output.writeShort(this.objectsInfos.length);
            var _i2:uint;
            while (_i2 < this.objectsInfos.length)
            {
                (this.objectsInfos[_i2] as ObjectItemToSellInBid).serializeAs_ObjectItemToSellInBid(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeStartedBidSellerMessage(input);
        }

        public function deserializeAs_ExchangeStartedBidSellerMessage(input:ICustomDataInput):void
        {
            var _item2:ObjectItemToSellInBid;
            this.sellerDescriptor = new SellerBuyerDescriptor();
            this.sellerDescriptor.deserialize(input);
            var _objectsInfosLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _objectsInfosLen)
            {
                _item2 = new ObjectItemToSellInBid();
                _item2.deserialize(input);
                this.objectsInfos.push(_item2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExchangeStartedBidSellerMessage(tree);
        }

        public function deserializeAsyncAs_ExchangeStartedBidSellerMessage(tree:FuncTree):void
        {
            this._sellerDescriptortree = tree.addChild(this._sellerDescriptortreeFunc);
            this._objectsInfostree = tree.addChild(this._objectsInfostreeFunc);
        }

        private function _sellerDescriptortreeFunc(input:ICustomDataInput):void
        {
            this.sellerDescriptor = new SellerBuyerDescriptor();
            this.sellerDescriptor.deserializeAsync(this._sellerDescriptortree);
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
            var _item:ObjectItemToSellInBid = new ObjectItemToSellInBid();
            _item.deserialize(input);
            this.objectsInfos.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.inventory.exchanges

