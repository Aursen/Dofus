package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class IgnoredListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5674;

        private var _isInitialized:Boolean = false;
        public var ignoredList:Vector.<IgnoredInformations> = new Vector.<IgnoredInformations>();
        private var _ignoredListtree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5674);
        }

        public function initIgnoredListMessage(ignoredList:Vector.<IgnoredInformations>=null):IgnoredListMessage
        {
            this.ignoredList = ignoredList;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.ignoredList = new Vector.<IgnoredInformations>();
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
            this.serializeAs_IgnoredListMessage(output);
        }

        public function serializeAs_IgnoredListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.ignoredList.length);
            var _i1:uint;
            while (_i1 < this.ignoredList.length)
            {
                output.writeShort((this.ignoredList[_i1] as IgnoredInformations).getTypeId());
                (this.ignoredList[_i1] as IgnoredInformations).serialize(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IgnoredListMessage(input);
        }

        public function deserializeAs_IgnoredListMessage(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:IgnoredInformations;
            var _ignoredListLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _ignoredListLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(IgnoredInformations, _id1);
                _item1.deserialize(input);
                this.ignoredList.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_IgnoredListMessage(tree);
        }

        public function deserializeAsyncAs_IgnoredListMessage(tree:FuncTree):void
        {
            this._ignoredListtree = tree.addChild(this._ignoredListtreeFunc);
        }

        private function _ignoredListtreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._ignoredListtree.addChild(this._ignoredListFunc);
                i++;
            };
        }

        private function _ignoredListFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:IgnoredInformations = ProtocolTypeManager.getInstance(IgnoredInformations, _id);
            _item.deserialize(input);
            this.ignoredList.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.friend

