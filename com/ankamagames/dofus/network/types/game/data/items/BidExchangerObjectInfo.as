package com.ankamagames.dofus.network.types.game.data.items
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class BidExchangerObjectInfo implements INetworkType 
    {

        public static const protocolId:uint = 122;

        public var objectUID:uint = 0;
        public var objectGID:uint = 0;
        public var objectType:uint = 0;
        public var effects:Vector.<ObjectEffect> = new Vector.<ObjectEffect>();
        public var prices:Vector.<Number> = new Vector.<Number>();
        private var _effectstree:FuncTree;
        private var _pricestree:FuncTree;


        public function getTypeId():uint
        {
            return (122);
        }

        public function initBidExchangerObjectInfo(objectUID:uint=0, objectGID:uint=0, objectType:uint=0, effects:Vector.<ObjectEffect>=null, prices:Vector.<Number>=null):BidExchangerObjectInfo
        {
            this.objectUID = objectUID;
            this.objectGID = objectGID;
            this.objectType = objectType;
            this.effects = effects;
            this.prices = prices;
            return (this);
        }

        public function reset():void
        {
            this.objectUID = 0;
            this.objectGID = 0;
            this.objectType = 0;
            this.effects = new Vector.<ObjectEffect>();
            this.prices = new Vector.<Number>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_BidExchangerObjectInfo(output);
        }

        public function serializeAs_BidExchangerObjectInfo(output:ICustomDataOutput):void
        {
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element objectUID.")));
            };
            output.writeVarInt(this.objectUID);
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element objectGID.")));
            };
            output.writeVarShort(this.objectGID);
            if (this.objectType < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectType) + ") on element objectType.")));
            };
            output.writeInt(this.objectType);
            output.writeShort(this.effects.length);
            var _i4:uint;
            while (_i4 < this.effects.length)
            {
                output.writeShort((this.effects[_i4] as ObjectEffect).getTypeId());
                (this.effects[_i4] as ObjectEffect).serialize(output);
                _i4++;
            };
            output.writeShort(this.prices.length);
            var _i5:uint;
            while (_i5 < this.prices.length)
            {
                if (((this.prices[_i5] < 0) || (this.prices[_i5] > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + this.prices[_i5]) + ") on element 5 (starting at 1) of prices.")));
                };
                output.writeVarLong(this.prices[_i5]);
                _i5++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BidExchangerObjectInfo(input);
        }

        public function deserializeAs_BidExchangerObjectInfo(input:ICustomDataInput):void
        {
            var _id4:uint;
            var _item4:ObjectEffect;
            var _val5:Number;
            this._objectUIDFunc(input);
            this._objectGIDFunc(input);
            this._objectTypeFunc(input);
            var _effectsLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _effectsLen)
            {
                _id4 = input.readUnsignedShort();
                _item4 = ProtocolTypeManager.getInstance(ObjectEffect, _id4);
                _item4.deserialize(input);
                this.effects.push(_item4);
                _i4++;
            };
            var _pricesLen:uint = input.readUnsignedShort();
            var _i5:uint;
            while (_i5 < _pricesLen)
            {
                _val5 = input.readVarUhLong();
                if (((_val5 < 0) || (_val5 > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + _val5) + ") on elements of prices.")));
                };
                this.prices.push(_val5);
                _i5++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_BidExchangerObjectInfo(tree);
        }

        public function deserializeAsyncAs_BidExchangerObjectInfo(tree:FuncTree):void
        {
            tree.addChild(this._objectUIDFunc);
            tree.addChild(this._objectGIDFunc);
            tree.addChild(this._objectTypeFunc);
            this._effectstree = tree.addChild(this._effectstreeFunc);
            this._pricestree = tree.addChild(this._pricestreeFunc);
        }

        private function _objectUIDFunc(input:ICustomDataInput):void
        {
            this.objectUID = input.readVarUhInt();
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element of BidExchangerObjectInfo.objectUID.")));
            };
        }

        private function _objectGIDFunc(input:ICustomDataInput):void
        {
            this.objectGID = input.readVarUhShort();
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element of BidExchangerObjectInfo.objectGID.")));
            };
        }

        private function _objectTypeFunc(input:ICustomDataInput):void
        {
            this.objectType = input.readInt();
            if (this.objectType < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectType) + ") on element of BidExchangerObjectInfo.objectType.")));
            };
        }

        private function _effectstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._effectstree.addChild(this._effectsFunc);
                i++;
            };
        }

        private function _effectsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:ObjectEffect = ProtocolTypeManager.getInstance(ObjectEffect, _id);
            _item.deserialize(input);
            this.effects.push(_item);
        }

        private function _pricestreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._pricestree.addChild(this._pricesFunc);
                i++;
            };
        }

        private function _pricesFunc(input:ICustomDataInput):void
        {
            var _val:Number = input.readVarUhLong();
            if (((_val < 0) || (_val > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of prices.")));
            };
            this.prices.push(_val);
        }


    }
}

