package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GuildHousesInformationMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5919;

        private var _isInitialized:Boolean = false;
        public var housesInformations:Vector.<HouseInformationsForGuild> = new Vector.<HouseInformationsForGuild>();
        private var _housesInformationstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5919);
        }

        public function initGuildHousesInformationMessage(housesInformations:Vector.<HouseInformationsForGuild>=null):GuildHousesInformationMessage
        {
            this.housesInformations = housesInformations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.housesInformations = new Vector.<HouseInformationsForGuild>();
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
            this.serializeAs_GuildHousesInformationMessage(output);
        }

        public function serializeAs_GuildHousesInformationMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.housesInformations.length);
            var _i1:uint;
            while (_i1 < this.housesInformations.length)
            {
                (this.housesInformations[_i1] as HouseInformationsForGuild).serializeAs_HouseInformationsForGuild(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildHousesInformationMessage(input);
        }

        public function deserializeAs_GuildHousesInformationMessage(input:ICustomDataInput):void
        {
            var _item1:HouseInformationsForGuild;
            var _housesInformationsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _housesInformationsLen)
            {
                _item1 = new HouseInformationsForGuild();
                _item1.deserialize(input);
                this.housesInformations.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GuildHousesInformationMessage(tree);
        }

        public function deserializeAsyncAs_GuildHousesInformationMessage(tree:FuncTree):void
        {
            this._housesInformationstree = tree.addChild(this._housesInformationstreeFunc);
        }

        private function _housesInformationstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._housesInformationstree.addChild(this._housesInformationsFunc);
                i++;
            };
        }

        private function _housesInformationsFunc(input:ICustomDataInput):void
        {
            var _item:HouseInformationsForGuild = new HouseInformationsForGuild();
            _item.deserialize(input);
            this.housesInformations.push(_item);
        }


    }
}

