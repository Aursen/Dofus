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

    public class ExchangeObjectTransfertListWithQuantityToInvMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6470;

        private var _isInitialized:Boolean = false;
        public var ids:Vector.<uint> = new Vector.<uint>();
        public var qtys:Vector.<uint> = new Vector.<uint>();
        private var _idstree:FuncTree;
        private var _qtystree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6470);
        }

        public function initExchangeObjectTransfertListWithQuantityToInvMessage(ids:Vector.<uint>=null, qtys:Vector.<uint>=null):ExchangeObjectTransfertListWithQuantityToInvMessage
        {
            this.ids = ids;
            this.qtys = qtys;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.ids = new Vector.<uint>();
            this.qtys = new Vector.<uint>();
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
            this.serializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(output);
        }

        public function serializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.ids.length);
            var _i1:uint;
            while (_i1 < this.ids.length)
            {
                if (this.ids[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.ids[_i1]) + ") on element 1 (starting at 1) of ids.")));
                };
                output.writeVarInt(this.ids[_i1]);
                _i1++;
            };
            output.writeShort(this.qtys.length);
            var _i2:uint;
            while (_i2 < this.qtys.length)
            {
                if (this.qtys[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.qtys[_i2]) + ") on element 2 (starting at 1) of qtys.")));
                };
                output.writeVarInt(this.qtys[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(input);
        }

        public function deserializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _val2:uint;
            var _idsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _idsLen)
            {
                _val1 = input.readVarUhInt();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of ids.")));
                };
                this.ids.push(_val1);
                _i1++;
            };
            var _qtysLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _qtysLen)
            {
                _val2 = input.readVarUhInt();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of qtys.")));
                };
                this.qtys.push(_val2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExchangeObjectTransfertListWithQuantityToInvMessage(tree);
        }

        public function deserializeAsyncAs_ExchangeObjectTransfertListWithQuantityToInvMessage(tree:FuncTree):void
        {
            this._idstree = tree.addChild(this._idstreeFunc);
            this._qtystree = tree.addChild(this._qtystreeFunc);
        }

        private function _idstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._idstree.addChild(this._idsFunc);
                i++;
            };
        }

        private function _idsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhInt();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of ids.")));
            };
            this.ids.push(_val);
        }

        private function _qtystreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._qtystree.addChild(this._qtysFunc);
                i++;
            };
        }

        private function _qtysFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhInt();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of qtys.")));
            };
            this.qtys.push(_val);
        }


    }
}

