package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.mount.MountClientData;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ExchangeStartOkMountMessage extends ExchangeStartOkMountWithOutPaddockMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5979;

        private var _isInitialized:Boolean = false;
        public var paddockedMountsDescription:Vector.<MountClientData> = new Vector.<MountClientData>();
        private var _paddockedMountsDescriptiontree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (5979);
        }

        public function initExchangeStartOkMountMessage(stabledMountsDescription:Vector.<MountClientData>=null, paddockedMountsDescription:Vector.<MountClientData>=null):ExchangeStartOkMountMessage
        {
            super.initExchangeStartOkMountWithOutPaddockMessage(stabledMountsDescription);
            this.paddockedMountsDescription = paddockedMountsDescription;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.paddockedMountsDescription = new Vector.<MountClientData>();
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
            this.serializeAs_ExchangeStartOkMountMessage(output);
        }

        public function serializeAs_ExchangeStartOkMountMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeStartOkMountWithOutPaddockMessage(output);
            output.writeShort(this.paddockedMountsDescription.length);
            var _i1:uint;
            while (_i1 < this.paddockedMountsDescription.length)
            {
                (this.paddockedMountsDescription[_i1] as MountClientData).serializeAs_MountClientData(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeStartOkMountMessage(input);
        }

        public function deserializeAs_ExchangeStartOkMountMessage(input:ICustomDataInput):void
        {
            var _item1:MountClientData;
            super.deserialize(input);
            var _paddockedMountsDescriptionLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _paddockedMountsDescriptionLen)
            {
                _item1 = new MountClientData();
                _item1.deserialize(input);
                this.paddockedMountsDescription.push(_item1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExchangeStartOkMountMessage(tree);
        }

        public function deserializeAsyncAs_ExchangeStartOkMountMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._paddockedMountsDescriptiontree = tree.addChild(this._paddockedMountsDescriptiontreeFunc);
        }

        private function _paddockedMountsDescriptiontreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._paddockedMountsDescriptiontree.addChild(this._paddockedMountsDescriptionFunc);
                i++;
            };
        }

        private function _paddockedMountsDescriptionFunc(input:ICustomDataInput):void
        {
            var _item:MountClientData = new MountClientData();
            _item.deserialize(input);
            this.paddockedMountsDescription.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.inventory.exchanges

