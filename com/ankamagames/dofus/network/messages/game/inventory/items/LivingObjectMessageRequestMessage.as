package com.ankamagames.dofus.network.messages.game.inventory.items
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

    public class LivingObjectMessageRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6066;

        private var _isInitialized:Boolean = false;
        public var msgId:uint = 0;
        public var parameters:Vector.<String> = new Vector.<String>();
        public var livingObject:uint = 0;
        private var _parameterstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6066);
        }

        public function initLivingObjectMessageRequestMessage(msgId:uint=0, parameters:Vector.<String>=null, livingObject:uint=0):LivingObjectMessageRequestMessage
        {
            this.msgId = msgId;
            this.parameters = parameters;
            this.livingObject = livingObject;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.msgId = 0;
            this.parameters = new Vector.<String>();
            this.livingObject = 0;
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
            this.serializeAs_LivingObjectMessageRequestMessage(output);
        }

        public function serializeAs_LivingObjectMessageRequestMessage(output:ICustomDataOutput):void
        {
            if (this.msgId < 0)
            {
                throw (new Error((("Forbidden value (" + this.msgId) + ") on element msgId.")));
            };
            output.writeVarShort(this.msgId);
            output.writeShort(this.parameters.length);
            var _i2:uint;
            while (_i2 < this.parameters.length)
            {
                output.writeUTF(this.parameters[_i2]);
                _i2++;
            };
            if (this.livingObject < 0)
            {
                throw (new Error((("Forbidden value (" + this.livingObject) + ") on element livingObject.")));
            };
            output.writeVarInt(this.livingObject);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_LivingObjectMessageRequestMessage(input);
        }

        public function deserializeAs_LivingObjectMessageRequestMessage(input:ICustomDataInput):void
        {
            var _val2:String;
            this._msgIdFunc(input);
            var _parametersLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _parametersLen)
            {
                _val2 = input.readUTF();
                this.parameters.push(_val2);
                _i2++;
            };
            this._livingObjectFunc(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_LivingObjectMessageRequestMessage(tree);
        }

        public function deserializeAsyncAs_LivingObjectMessageRequestMessage(tree:FuncTree):void
        {
            tree.addChild(this._msgIdFunc);
            this._parameterstree = tree.addChild(this._parameterstreeFunc);
            tree.addChild(this._livingObjectFunc);
        }

        private function _msgIdFunc(input:ICustomDataInput):void
        {
            this.msgId = input.readVarUhShort();
            if (this.msgId < 0)
            {
                throw (new Error((("Forbidden value (" + this.msgId) + ") on element of LivingObjectMessageRequestMessage.msgId.")));
            };
        }

        private function _parameterstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._parameterstree.addChild(this._parametersFunc);
                i++;
            };
        }

        private function _parametersFunc(input:ICustomDataInput):void
        {
            var _val:String = input.readUTF();
            this.parameters.push(_val);
        }

        private function _livingObjectFunc(input:ICustomDataInput):void
        {
            this.livingObject = input.readVarUhInt();
            if (this.livingObject < 0)
            {
                throw (new Error((("Forbidden value (" + this.livingObject) + ") on element of LivingObjectMessageRequestMessage.livingObject.")));
            };
        }


    }
} com.ankamagames.dofus.network.messages.game.inventory.items

