package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ExchangeBidPriceForSellerMessage extends ExchangeBidPriceMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6464;

        private var _isInitialized:Boolean = false;
        public var allIdentical:Boolean = false;
        public var minimalPrices:Vector.<Number> = new Vector.<Number>();
        private var _minimalPricestree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (6464);
        }

        public function initExchangeBidPriceForSellerMessage(genericId:uint=0, averagePrice:Number=0, allIdentical:Boolean=false, minimalPrices:Vector.<Number>=null):ExchangeBidPriceForSellerMessage
        {
            super.initExchangeBidPriceMessage(genericId, averagePrice);
            this.allIdentical = allIdentical;
            this.minimalPrices = minimalPrices;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.allIdentical = false;
            this.minimalPrices = new Vector.<Number>();
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
            this.serializeAs_ExchangeBidPriceForSellerMessage(output);
        }

        public function serializeAs_ExchangeBidPriceForSellerMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeBidPriceMessage(output);
            output.writeBoolean(this.allIdentical);
            output.writeShort(this.minimalPrices.length);
            var _i2:uint;
            while (_i2 < this.minimalPrices.length)
            {
                if (((this.minimalPrices[_i2] < 0) || (this.minimalPrices[_i2] > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + this.minimalPrices[_i2]) + ") on element 2 (starting at 1) of minimalPrices.")));
                };
                output.writeVarLong(this.minimalPrices[_i2]);
                _i2++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeBidPriceForSellerMessage(input);
        }

        public function deserializeAs_ExchangeBidPriceForSellerMessage(input:ICustomDataInput):void
        {
            var _val2:Number;
            super.deserialize(input);
            this._allIdenticalFunc(input);
            var _minimalPricesLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _minimalPricesLen)
            {
                _val2 = input.readVarUhLong();
                if (((_val2 < 0) || (_val2 > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of minimalPrices.")));
                };
                this.minimalPrices.push(_val2);
                _i2++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExchangeBidPriceForSellerMessage(tree);
        }

        public function deserializeAsyncAs_ExchangeBidPriceForSellerMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            tree.addChild(this._allIdenticalFunc);
            this._minimalPricestree = tree.addChild(this._minimalPricestreeFunc);
        }

        private function _allIdenticalFunc(input:ICustomDataInput):void
        {
            this.allIdentical = input.readBoolean();
        }

        private function _minimalPricestreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._minimalPricestree.addChild(this._minimalPricesFunc);
                i++;
            };
        }

        private function _minimalPricesFunc(input:ICustomDataInput):void
        {
            var _val:Number = input.readVarUhLong();
            if (((_val < 0) || (_val > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of minimalPrices.")));
            };
            this.minimalPrices.push(_val);
        }


    }
}

