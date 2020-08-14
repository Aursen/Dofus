package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class AccountHouseMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6315;

        private var _isInitialized:Boolean = false;
        public var houses:Vector.<AccountHouseInformations> = new Vector.<AccountHouseInformations>();
        private var _housestree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6315);
        }

        public function initAccountHouseMessage(houses:Vector.<AccountHouseInformations>=null):AccountHouseMessage
        {
            this.houses = houses;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.houses = new Vector.<AccountHouseInformations>();
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
            this.serializeAs_AccountHouseMessage(output);
        }

        public function serializeAs_AccountHouseMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.houses.length);
            var _i1:uint;
            while (_i1 < this.houses.length)
            {
                (this.houses[_i1] as AccountHouseInformations).serializeAs_AccountHouseInformations(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AccountHouseMessage(input);
        }

        public function deserializeAs_AccountHouseMessage(input:ICustomDataInput):void
        {
            var _item1:AccountHouseInformations;
            var _housesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _housesLen)
            {
                _item1 = new AccountHouseInformations();
                _item1.deserialize(input);
                this.houses.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_AccountHouseMessage(tree);
        }

        public function deserializeAsyncAs_AccountHouseMessage(tree:FuncTree):void
        {
            this._housestree = tree.addChild(this._housestreeFunc);
        }

        private function _housestreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._housestree.addChild(this._housesFunc);
                i++;
            };
        }

        private function _housesFunc(input:ICustomDataInput):void
        {
            var _item:AccountHouseInformations = new AccountHouseInformations();
            _item.deserialize(input);
            this.houses.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.houses

