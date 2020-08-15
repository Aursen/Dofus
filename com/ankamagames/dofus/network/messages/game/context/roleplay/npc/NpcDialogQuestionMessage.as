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

    public class NpcDialogQuestionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5617;

        private var _isInitialized:Boolean = false;
        public var messageId:uint = 0;
        public var dialogParams:Vector.<String> = new Vector.<String>();
        public var visibleReplies:Vector.<uint> = new Vector.<uint>();
        private var _dialogParamstree:FuncTree;
        private var _visibleRepliestree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5617);
        }

        public function initNpcDialogQuestionMessage(messageId:uint=0, dialogParams:Vector.<String>=null, visibleReplies:Vector.<uint>=null):NpcDialogQuestionMessage
        {
            this.messageId = messageId;
            this.dialogParams = dialogParams;
            this.visibleReplies = visibleReplies;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.messageId = 0;
            this.dialogParams = new Vector.<String>();
            this.visibleReplies = new Vector.<uint>();
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
            this.serializeAs_NpcDialogQuestionMessage(output);
        }

        public function serializeAs_NpcDialogQuestionMessage(output:ICustomDataOutput):void
        {
            if (this.messageId < 0)
            {
                throw (new Error((("Forbidden value (" + this.messageId) + ") on element messageId.")));
            };
            output.writeVarInt(this.messageId);
            output.writeShort(this.dialogParams.length);
            var _i2:uint;
            while (_i2 < this.dialogParams.length)
            {
                output.writeUTF(this.dialogParams[_i2]);
                _i2++;
            };
            output.writeShort(this.visibleReplies.length);
            var _i3:uint;
            while (_i3 < this.visibleReplies.length)
            {
                if (this.visibleReplies[_i3] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.visibleReplies[_i3]) + ") on element 3 (starting at 1) of visibleReplies.")));
                };
                output.writeVarInt(this.visibleReplies[_i3]);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_NpcDialogQuestionMessage(input);
        }

        public function deserializeAs_NpcDialogQuestionMessage(input:ICustomDataInput):void
        {
            var _val2:String;
            var _val3:uint;
            this._messageIdFunc(input);
            var _dialogParamsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _dialogParamsLen)
            {
                _val2 = input.readUTF();
                this.dialogParams.push(_val2);
                _i2++;
            };
            var _visibleRepliesLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _visibleRepliesLen)
            {
                _val3 = input.readVarUhInt();
                if (_val3 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val3) + ") on elements of visibleReplies.")));
                };
                this.visibleReplies.push(_val3);
                _i3++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_NpcDialogQuestionMessage(tree);
        }

        public function deserializeAsyncAs_NpcDialogQuestionMessage(tree:FuncTree):void
        {
            tree.addChild(this._messageIdFunc);
            this._dialogParamstree = tree.addChild(this._dialogParamstreeFunc);
            this._visibleRepliestree = tree.addChild(this._visibleRepliestreeFunc);
        }

        private function _messageIdFunc(input:ICustomDataInput):void
        {
            this.messageId = input.readVarUhInt();
            if (this.messageId < 0)
            {
                throw (new Error((("Forbidden value (" + this.messageId) + ") on element of NpcDialogQuestionMessage.messageId.")));
            };
        }

        private function _dialogParamstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._dialogParamstree.addChild(this._dialogParamsFunc);
                i++;
            };
        }

        private function _dialogParamsFunc(input:ICustomDataInput):void
        {
            var _val:String = input.readUTF();
            this.dialogParams.push(_val);
        }

        private function _visibleRepliestreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._visibleRepliestree.addChild(this._visibleRepliesFunc);
                i++;
            };
        }

        private function _visibleRepliesFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhInt();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of visibleReplies.")));
            };
            this.visibleReplies.push(_val);
        }


    }
}

