package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class EmotePlayMassiveMessage extends EmotePlayAbstractMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5691;

        private var _isInitialized:Boolean = false;
        public var actorIds:Vector.<Number> = new Vector.<Number>();
        private var _actorIdstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (5691);
        }

        public function initEmotePlayMassiveMessage(emoteId:uint=0, emoteStartTime:Number=0, actorIds:Vector.<Number>=null):EmotePlayMassiveMessage
        {
            super.initEmotePlayAbstractMessage(emoteId, emoteStartTime);
            this.actorIds = actorIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.actorIds = new Vector.<Number>();
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
            this.serializeAs_EmotePlayMassiveMessage(output);
        }

        public function serializeAs_EmotePlayMassiveMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_EmotePlayAbstractMessage(output);
            output.writeShort(this.actorIds.length);
            var _i1:uint;
            while (_i1 < this.actorIds.length)
            {
                if (((this.actorIds[_i1] < -9007199254740992) || (this.actorIds[_i1] > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + this.actorIds[_i1]) + ") on element 1 (starting at 1) of actorIds.")));
                };
                output.writeDouble(this.actorIds[_i1]);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_EmotePlayMassiveMessage(input);
        }

        public function deserializeAs_EmotePlayMassiveMessage(input:ICustomDataInput):void
        {
            var _val1:Number;
            super.deserialize(input);
            var _actorIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _actorIdsLen)
            {
                _val1 = input.readDouble();
                if (((_val1 < -9007199254740992) || (_val1 > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of actorIds.")));
                };
                this.actorIds.push(_val1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_EmotePlayMassiveMessage(tree);
        }

        public function deserializeAsyncAs_EmotePlayMassiveMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._actorIdstree = tree.addChild(this._actorIdstreeFunc);
        }

        private function _actorIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._actorIdstree.addChild(this._actorIdsFunc);
                i++;
            };
        }

        private function _actorIdsFunc(input:ICustomDataInput):void
        {
            var _val:Number = input.readDouble();
            if (((_val < -9007199254740992) || (_val > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of actorIds.")));
            };
            this.actorIds.push(_val);
        }


    }
}

