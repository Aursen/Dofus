package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
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

    public class GameRolePlayArenaSwitchToGameServerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6574;

        private var _isInitialized:Boolean = false;
        public var validToken:Boolean = false;
        public var ticket:Vector.<int> = new Vector.<int>();
        public var homeServerId:int = 0;
        private var _tickettree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6574);
        }

        public function initGameRolePlayArenaSwitchToGameServerMessage(validToken:Boolean=false, ticket:Vector.<int>=null, homeServerId:int=0):GameRolePlayArenaSwitchToGameServerMessage
        {
            this.validToken = validToken;
            this.ticket = ticket;
            this.homeServerId = homeServerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.validToken = false;
            this.ticket = new Vector.<int>();
            this.homeServerId = 0;
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
            this.serializeAs_GameRolePlayArenaSwitchToGameServerMessage(output);
        }

        public function serializeAs_GameRolePlayArenaSwitchToGameServerMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.validToken);
            output.writeVarInt(this.ticket.length);
            var _i2:uint;
            while (_i2 < this.ticket.length)
            {
                output.writeByte(this.ticket[_i2]);
                _i2++;
            };
            output.writeShort(this.homeServerId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayArenaSwitchToGameServerMessage(input);
        }

        public function deserializeAs_GameRolePlayArenaSwitchToGameServerMessage(input:ICustomDataInput):void
        {
            var _val2:int;
            this._validTokenFunc(input);
            var _ticketLen:uint = input.readVarInt();
            var _i2:uint;
            while (_i2 < _ticketLen)
            {
                _val2 = input.readByte();
                this.ticket.push(_val2);
                _i2++;
            };
            this._homeServerIdFunc(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameRolePlayArenaSwitchToGameServerMessage(tree);
        }

        public function deserializeAsyncAs_GameRolePlayArenaSwitchToGameServerMessage(tree:FuncTree):void
        {
            tree.addChild(this._validTokenFunc);
            this._tickettree = tree.addChild(this._tickettreeFunc);
            tree.addChild(this._homeServerIdFunc);
        }

        private function _validTokenFunc(input:ICustomDataInput):void
        {
            this.validToken = input.readBoolean();
        }

        private function _tickettreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readVarInt();
            var i:uint;
            while (i < length)
            {
                this._tickettree.addChild(this._ticketFunc);
                i++;
            };
        }

        private function _ticketFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readByte();
            this.ticket.push(_val);
        }

        private function _homeServerIdFunc(input:ICustomDataInput):void
        {
            this.homeServerId = input.readShort();
        }


    }
}

