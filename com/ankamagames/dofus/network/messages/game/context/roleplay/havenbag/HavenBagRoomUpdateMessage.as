package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.havenbag.HavenBagRoomPreviewInformation;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class HavenBagRoomUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6860;

        private var _isInitialized:Boolean = false;
        public var action:uint = 0;
        public var roomsPreview:Vector.<HavenBagRoomPreviewInformation> = new Vector.<HavenBagRoomPreviewInformation>();
        private var _roomsPreviewtree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6860);
        }

        public function initHavenBagRoomUpdateMessage(action:uint=0, roomsPreview:Vector.<HavenBagRoomPreviewInformation>=null):HavenBagRoomUpdateMessage
        {
            this.action = action;
            this.roomsPreview = roomsPreview;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.action = 0;
            this.roomsPreview = new Vector.<HavenBagRoomPreviewInformation>();
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
            this.serializeAs_HavenBagRoomUpdateMessage(output);
        }

        public function serializeAs_HavenBagRoomUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.action);
            output.writeShort(this.roomsPreview.length);
            var _i2:uint;
            while (_i2 < this.roomsPreview.length)
            {
                (this.roomsPreview[_i2] as HavenBagRoomPreviewInformation).serializeAs_HavenBagRoomPreviewInformation(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HavenBagRoomUpdateMessage(input);
        }

        public function deserializeAs_HavenBagRoomUpdateMessage(input:ICustomDataInput):void
        {
            var _item2:HavenBagRoomPreviewInformation;
            this._actionFunc(input);
            var _roomsPreviewLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _roomsPreviewLen)
            {
                _item2 = new HavenBagRoomPreviewInformation();
                _item2.deserialize(input);
                this.roomsPreview.push(_item2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_HavenBagRoomUpdateMessage(tree);
        }

        public function deserializeAsyncAs_HavenBagRoomUpdateMessage(tree:FuncTree):void
        {
            tree.addChild(this._actionFunc);
            this._roomsPreviewtree = tree.addChild(this._roomsPreviewtreeFunc);
        }

        private function _actionFunc(input:ICustomDataInput):void
        {
            this.action = input.readByte();
            if (this.action < 0)
            {
                throw (new Error((("Forbidden value (" + this.action) + ") on element of HavenBagRoomUpdateMessage.action.")));
            };
        }

        private function _roomsPreviewtreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._roomsPreviewtree.addChild(this._roomsPreviewFunc);
                i++;
            };
        }

        private function _roomsPreviewFunc(input:ICustomDataInput):void
        {
            var _item:HavenBagRoomPreviewInformation = new HavenBagRoomPreviewInformation();
            _item.deserialize(input);
            this.roomsPreview.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag

