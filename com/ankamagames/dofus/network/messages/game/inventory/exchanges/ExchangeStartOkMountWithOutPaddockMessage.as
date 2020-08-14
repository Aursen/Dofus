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

    public class ExchangeStartOkMountWithOutPaddockMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5991;

        private var _isInitialized:Boolean = false;
        public var stabledMountsDescription:Vector.<MountClientData> = new Vector.<MountClientData>();
        private var _stabledMountsDescriptiontree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5991);
        }

        public function initExchangeStartOkMountWithOutPaddockMessage(stabledMountsDescription:Vector.<MountClientData>=null):ExchangeStartOkMountWithOutPaddockMessage
        {
            this.stabledMountsDescription = stabledMountsDescription;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.stabledMountsDescription = new Vector.<MountClientData>();
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
            this.serializeAs_ExchangeStartOkMountWithOutPaddockMessage(output);
        }

        public function serializeAs_ExchangeStartOkMountWithOutPaddockMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.stabledMountsDescription.length);
            var _i1:uint;
            while (_i1 < this.stabledMountsDescription.length)
            {
                (this.stabledMountsDescription[_i1] as MountClientData).serializeAs_MountClientData(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeStartOkMountWithOutPaddockMessage(input);
        }

        public function deserializeAs_ExchangeStartOkMountWithOutPaddockMessage(input:ICustomDataInput):void
        {
            var _item1:MountClientData;
            var _stabledMountsDescriptionLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _stabledMountsDescriptionLen)
            {
                _item1 = new MountClientData();
                _item1.deserialize(input);
                this.stabledMountsDescription.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExchangeStartOkMountWithOutPaddockMessage(tree);
        }

        public function deserializeAsyncAs_ExchangeStartOkMountWithOutPaddockMessage(tree:FuncTree):void
        {
            this._stabledMountsDescriptiontree = tree.addChild(this._stabledMountsDescriptiontreeFunc);
        }

        private function _stabledMountsDescriptiontreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._stabledMountsDescriptiontree.addChild(this._stabledMountsDescriptionFunc);
                i++;
            };
        }

        private function _stabledMountsDescriptionFunc(input:ICustomDataInput):void
        {
            var _item:MountClientData = new MountClientData();
            _item.deserialize(input);
            this.stabledMountsDescription.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.inventory.exchanges

