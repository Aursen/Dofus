package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag
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

    public class HavenBagPackListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6620;

        private var _isInitialized:Boolean = false;
        public var packIds:Vector.<int> = new Vector.<int>();
        private var _packIdstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6620);
        }

        public function initHavenBagPackListMessage(packIds:Vector.<int>=null):HavenBagPackListMessage
        {
            this.packIds = packIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.packIds = new Vector.<int>();
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
            this.serializeAs_HavenBagPackListMessage(output);
        }

        public function serializeAs_HavenBagPackListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.packIds.length);
            var _i1:uint;
            while (_i1 < this.packIds.length)
            {
                output.writeByte(this.packIds[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HavenBagPackListMessage(input);
        }

        public function deserializeAs_HavenBagPackListMessage(input:ICustomDataInput):void
        {
            var _val1:int;
            var _packIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _packIdsLen)
            {
                _val1 = input.readByte();
                this.packIds.push(_val1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_HavenBagPackListMessage(tree);
        }

        public function deserializeAsyncAs_HavenBagPackListMessage(tree:FuncTree):void
        {
            this._packIdstree = tree.addChild(this._packIdstreeFunc);
        }

        private function _packIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._packIdstree.addChild(this._packIdsFunc);
                i++;
            };
        }

        private function _packIdsFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readByte();
            this.packIds.push(_val);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag

