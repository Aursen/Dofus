package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.interactive.zaap.TeleportDestination;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class TeleportDestinationsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6829;

        private var _isInitialized:Boolean = false;
        public var type:uint = 0;
        public var destinations:Vector.<TeleportDestination> = new Vector.<TeleportDestination>();
        private var _destinationstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6829);
        }

        public function initTeleportDestinationsMessage(_arg_1:uint=0, destinations:Vector.<TeleportDestination>=null):TeleportDestinationsMessage
        {
            this.type = _arg_1;
            this.destinations = destinations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.type = 0;
            this.destinations = new Vector.<TeleportDestination>();
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
            this.serializeAs_TeleportDestinationsMessage(output);
        }

        public function serializeAs_TeleportDestinationsMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.type);
            output.writeShort(this.destinations.length);
            var _i2:uint;
            while (_i2 < this.destinations.length)
            {
                (this.destinations[_i2] as TeleportDestination).serializeAs_TeleportDestination(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TeleportDestinationsMessage(input);
        }

        public function deserializeAs_TeleportDestinationsMessage(input:ICustomDataInput):void
        {
            var _item2:TeleportDestination;
            this._typeFunc(input);
            var _destinationsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _destinationsLen)
            {
                _item2 = new TeleportDestination();
                _item2.deserialize(input);
                this.destinations.push(_item2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_TeleportDestinationsMessage(tree);
        }

        public function deserializeAsyncAs_TeleportDestinationsMessage(tree:FuncTree):void
        {
            tree.addChild(this._typeFunc);
            this._destinationstree = tree.addChild(this._destinationstreeFunc);
        }

        private function _typeFunc(input:ICustomDataInput):void
        {
            this.type = input.readByte();
            if (this.type < 0)
            {
                throw (new Error((("Forbidden value (" + this.type) + ") on element of TeleportDestinationsMessage.type.")));
            };
        }

        private function _destinationstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._destinationstree.addChild(this._destinationsFunc);
                i++;
            };
        }

        private function _destinationsFunc(input:ICustomDataInput):void
        {
            var _item:TeleportDestination = new TeleportDestination();
            _item.deserialize(input);
            this.destinations.push(_item);
        }


    }
}

