package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.mount.MountClientData;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ExchangeMountsStableAddMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6555;

        private var _isInitialized:Boolean = false;
        public var mountDescription:Vector.<MountClientData> = new Vector.<MountClientData>();
        private var _mountDescriptiontree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6555);
        }

        public function initExchangeMountsStableAddMessage(mountDescription:Vector.<MountClientData>=null):ExchangeMountsStableAddMessage
        {
            this.mountDescription = mountDescription;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.mountDescription = new Vector.<MountClientData>();
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
            this.serializeAs_ExchangeMountsStableAddMessage(output);
        }

        public function serializeAs_ExchangeMountsStableAddMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.mountDescription.length);
            var _i1:uint;
            while (_i1 < this.mountDescription.length)
            {
                (this.mountDescription[_i1] as MountClientData).serializeAs_MountClientData(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeMountsStableAddMessage(input);
        }

        public function deserializeAs_ExchangeMountsStableAddMessage(input:ICustomDataInput):void
        {
            var _item1:MountClientData;
            var _mountDescriptionLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _mountDescriptionLen)
            {
                _item1 = new MountClientData();
                _item1.deserialize(input);
                this.mountDescription.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExchangeMountsStableAddMessage(tree);
        }

        public function deserializeAsyncAs_ExchangeMountsStableAddMessage(tree:FuncTree):void
        {
            this._mountDescriptiontree = tree.addChild(this._mountDescriptiontreeFunc);
        }

        private function _mountDescriptiontreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._mountDescriptiontree.addChild(this._mountDescriptionFunc);
                i++;
            };
        }

        private function _mountDescriptionFunc(input:ICustomDataInput):void
        {
            var _item:MountClientData = new MountClientData();
            _item.deserialize(input);
            this.mountDescription.push(_item);
        }


    }
}

