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

    public class ExchangeTypesExchangerDescriptionForUserMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5765;

        private var _isInitialized:Boolean = false;
        public var objectType:uint = 0;
        public var typeDescription:Vector.<uint> = new Vector.<uint>();
        private var _typeDescriptiontree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5765);
        }

        public function initExchangeTypesExchangerDescriptionForUserMessage(objectType:uint=0, typeDescription:Vector.<uint>=null):ExchangeTypesExchangerDescriptionForUserMessage
        {
            this.objectType = objectType;
            this.typeDescription = typeDescription;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectType = 0;
            this.typeDescription = new Vector.<uint>();
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
            this.serializeAs_ExchangeTypesExchangerDescriptionForUserMessage(output);
        }

        public function serializeAs_ExchangeTypesExchangerDescriptionForUserMessage(output:ICustomDataOutput):void
        {
            if (this.objectType < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectType) + ") on element objectType.")));
            };
            output.writeInt(this.objectType);
            output.writeShort(this.typeDescription.length);
            var _i2:uint;
            while (_i2 < this.typeDescription.length)
            {
                if (this.typeDescription[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.typeDescription[_i2]) + ") on element 2 (starting at 1) of typeDescription.")));
                };
                output.writeVarInt(this.typeDescription[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeTypesExchangerDescriptionForUserMessage(input);
        }

        public function deserializeAs_ExchangeTypesExchangerDescriptionForUserMessage(input:ICustomDataInput):void
        {
            var _val2:uint;
            this._objectTypeFunc(input);
            var _typeDescriptionLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _typeDescriptionLen)
            {
                _val2 = input.readVarUhInt();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of typeDescription.")));
                };
                this.typeDescription.push(_val2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExchangeTypesExchangerDescriptionForUserMessage(tree);
        }

        public function deserializeAsyncAs_ExchangeTypesExchangerDescriptionForUserMessage(tree:FuncTree):void
        {
            tree.addChild(this._objectTypeFunc);
            this._typeDescriptiontree = tree.addChild(this._typeDescriptiontreeFunc);
        }

        private function _objectTypeFunc(input:ICustomDataInput):void
        {
            this.objectType = input.readInt();
            if (this.objectType < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectType) + ") on element of ExchangeTypesExchangerDescriptionForUserMessage.objectType.")));
            };
        }

        private function _typeDescriptiontreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._typeDescriptiontree.addChild(this._typeDescriptionFunc);
                i++;
            };
        }

        private function _typeDescriptionFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhInt();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of typeDescription.")));
            };
            this.typeDescription.push(_val);
        }


    }
} com.ankamagames.dofus.network.messages.game.inventory.exchanges

