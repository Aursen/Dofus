package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyInvitationMemberInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class PartyInvitationDungeonDetailsMessage extends PartyInvitationDetailsMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6262;

        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var playersDungeonReady:Vector.<Boolean> = new Vector.<Boolean>();
        private var _playersDungeonReadytree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (6262);
        }

        public function initPartyInvitationDungeonDetailsMessage(partyId:uint=0, partyType:uint=0, partyName:String="", fromId:Number=0, fromName:String="", leaderId:Number=0, members:Vector.<PartyInvitationMemberInformations>=null, guests:Vector.<PartyGuestInformations>=null, dungeonId:uint=0, playersDungeonReady:Vector.<Boolean>=null):PartyInvitationDungeonDetailsMessage
        {
            super.initPartyInvitationDetailsMessage(partyId, partyType, partyName, fromId, fromName, leaderId, members, guests);
            this.dungeonId = dungeonId;
            this.playersDungeonReady = playersDungeonReady;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.dungeonId = 0;
            this.playersDungeonReady = new Vector.<Boolean>();
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
            this.serializeAs_PartyInvitationDungeonDetailsMessage(output);
        }

        public function serializeAs_PartyInvitationDungeonDetailsMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_PartyInvitationDetailsMessage(output);
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element dungeonId.")));
            };
            output.writeVarShort(this.dungeonId);
            output.writeShort(this.playersDungeonReady.length);
            var _i2:uint;
            while (_i2 < this.playersDungeonReady.length)
            {
                output.writeBoolean(this.playersDungeonReady[_i2]);
                _i2++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyInvitationDungeonDetailsMessage(input);
        }

        public function deserializeAs_PartyInvitationDungeonDetailsMessage(input:ICustomDataInput):void
        {
            var _val2:Boolean;
            super.deserialize(input);
            this._dungeonIdFunc(input);
            var _playersDungeonReadyLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _playersDungeonReadyLen)
            {
                _val2 = input.readBoolean();
                this.playersDungeonReady.push(_val2);
                _i2++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_PartyInvitationDungeonDetailsMessage(tree);
        }

        public function deserializeAsyncAs_PartyInvitationDungeonDetailsMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            tree.addChild(this._dungeonIdFunc);
            this._playersDungeonReadytree = tree.addChild(this._playersDungeonReadytreeFunc);
        }

        private function _dungeonIdFunc(input:ICustomDataInput):void
        {
            this.dungeonId = input.readVarUhShort();
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element of PartyInvitationDungeonDetailsMessage.dungeonId.")));
            };
        }

        private function _playersDungeonReadytreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._playersDungeonReadytree.addChild(this._playersDungeonReadyFunc);
                i++;
            };
        }

        private function _playersDungeonReadyFunc(input:ICustomDataInput):void
        {
            var _val:Boolean = input.readBoolean();
            this.playersDungeonReady.push(_val);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.party

