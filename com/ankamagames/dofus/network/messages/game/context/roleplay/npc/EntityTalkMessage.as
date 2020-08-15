package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
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

    public class EntityTalkMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6110;

        private var _isInitialized:Boolean = false;
        public var entityId:Number = 0;
        public var textId:uint = 0;
        public var parameters:Vector.<String> = new Vector.<String>();
        private var _parameterstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6110);
        }

        public function initEntityTalkMessage(entityId:Number=0, textId:uint=0, parameters:Vector.<String>=null):EntityTalkMessage
        {
            this.entityId = entityId;
            this.textId = textId;
            this.parameters = parameters;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.entityId = 0;
            this.textId = 0;
            this.parameters = new Vector.<String>();
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
            this.serializeAs_EntityTalkMessage(output);
        }

        public function serializeAs_EntityTalkMessage(output:ICustomDataOutput):void
        {
            if (((this.entityId < -9007199254740992) || (this.entityId > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.entityId) + ") on element entityId.")));
            };
            output.writeDouble(this.entityId);
            if (this.textId < 0)
            {
                throw (new Error((("Forbidden value (" + this.textId) + ") on element textId.")));
            };
            output.writeVarShort(this.textId);
            output.writeShort(this.parameters.length);
            var _i3:uint;
            while (_i3 < this.parameters.length)
            {
                output.writeUTF(this.parameters[_i3]);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_EntityTalkMessage(input);
        }

        public function deserializeAs_EntityTalkMessage(input:ICustomDataInput):void
        {
            var _val3:String;
            this._entityIdFunc(input);
            this._textIdFunc(input);
            var _parametersLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _parametersLen)
            {
                _val3 = input.readUTF();
                this.parameters.push(_val3);
                _i3++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_EntityTalkMessage(tree);
        }

        public function deserializeAsyncAs_EntityTalkMessage(tree:FuncTree):void
        {
            tree.addChild(this._entityIdFunc);
            tree.addChild(this._textIdFunc);
            this._parameterstree = tree.addChild(this._parameterstreeFunc);
        }

        private function _entityIdFunc(input:ICustomDataInput):void
        {
            this.entityId = input.readDouble();
            if (((this.entityId < -9007199254740992) || (this.entityId > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.entityId) + ") on element of EntityTalkMessage.entityId.")));
            };
        }

        private function _textIdFunc(input:ICustomDataInput):void
        {
            this.textId = input.readVarUhShort();
            if (this.textId < 0)
            {
                throw (new Error((("Forbidden value (" + this.textId) + ") on element of EntityTalkMessage.textId.")));
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


    }
}

