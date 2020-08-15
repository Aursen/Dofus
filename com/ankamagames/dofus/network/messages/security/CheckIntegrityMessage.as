package com.ankamagames.dofus.network.messages.security
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

    public class CheckIntegrityMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6372;

        private var _isInitialized:Boolean = false;
        public var data:Vector.<int> = new Vector.<int>();
        private var _datatree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6372);
        }

        public function initCheckIntegrityMessage(data:Vector.<int>=null):CheckIntegrityMessage
        {
            this.data = data;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.data = new Vector.<int>();
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
            this.serializeAs_CheckIntegrityMessage(output);
        }

        public function serializeAs_CheckIntegrityMessage(output:ICustomDataOutput):void
        {
            output.writeVarInt(this.data.length);
            var _i1:uint;
            while (_i1 < this.data.length)
            {
                output.writeByte(this.data[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CheckIntegrityMessage(input);
        }

        public function deserializeAs_CheckIntegrityMessage(input:ICustomDataInput):void
        {
            var _val1:int;
            var _dataLen:uint = input.readVarInt();
            var _i1:uint;
            while (_i1 < _dataLen)
            {
                _val1 = input.readByte();
                this.data.push(_val1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_CheckIntegrityMessage(tree);
        }

        public function deserializeAsyncAs_CheckIntegrityMessage(tree:FuncTree):void
        {
            this._datatree = tree.addChild(this._datatreeFunc);
        }

        private function _datatreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readVarInt();
            var i:uint;
            while (i < length)
            {
                this._datatree.addChild(this._dataFunc);
                i++;
            };
        }

        private function _dataFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readByte();
            this.data.push(_val);
        }


    }
}

