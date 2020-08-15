package com.ankamagames.dofus.network.messages.connection
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

    public class HelloConnectMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 3;

        private var _isInitialized:Boolean = false;
        [Transient]
        public var salt:String = "";
        public var key:Vector.<int> = new Vector.<int>();
        private var _keytree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (3);
        }

        public function initHelloConnectMessage(salt:String="", key:Vector.<int>=null):HelloConnectMessage
        {
            this.salt = salt;
            this.key = key;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.salt = "";
            this.key = new Vector.<int>();
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
            this.serializeAs_HelloConnectMessage(output);
        }

        public function serializeAs_HelloConnectMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.salt);
            output.writeVarInt(this.key.length);
            var _i2:uint;
            while (_i2 < this.key.length)
            {
                output.writeByte(this.key[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HelloConnectMessage(input);
        }

        public function deserializeAs_HelloConnectMessage(input:ICustomDataInput):void
        {
            var _val2:int;
            this._saltFunc(input);
            var _keyLen:uint = input.readVarInt();
            var _i2:uint;
            while (_i2 < _keyLen)
            {
                _val2 = input.readByte();
                this.key.push(_val2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_HelloConnectMessage(tree);
        }

        public function deserializeAsyncAs_HelloConnectMessage(tree:FuncTree):void
        {
            tree.addChild(this._saltFunc);
            this._keytree = tree.addChild(this._keytreeFunc);
        }

        private function _saltFunc(input:ICustomDataInput):void
        {
            this.salt = input.readUTF();
        }

        private function _keytreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readVarInt();
            var i:uint;
            while (i < length)
            {
                this._keytree.addChild(this._keyFunc);
                i++;
            };
        }

        private function _keyFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readByte();
            this.key.push(_val);
        }


    }
}

