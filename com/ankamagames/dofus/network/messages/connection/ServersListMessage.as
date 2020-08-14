package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.connection.GameServerInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ServersListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 30;

        private var _isInitialized:Boolean = false;
        public var servers:Vector.<GameServerInformations> = new Vector.<GameServerInformations>();
        public var alreadyConnectedToServerId:uint = 0;
        public var canCreateNewCharacter:Boolean = false;
        private var _serverstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (30);
        }

        public function initServersListMessage(servers:Vector.<GameServerInformations>=null, alreadyConnectedToServerId:uint=0, canCreateNewCharacter:Boolean=false):ServersListMessage
        {
            this.servers = servers;
            this.alreadyConnectedToServerId = alreadyConnectedToServerId;
            this.canCreateNewCharacter = canCreateNewCharacter;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.servers = new Vector.<GameServerInformations>();
            this.alreadyConnectedToServerId = 0;
            this.canCreateNewCharacter = false;
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
            this.serializeAs_ServersListMessage(output);
        }

        public function serializeAs_ServersListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.servers.length);
            var _i1:uint;
            while (_i1 < this.servers.length)
            {
                (this.servers[_i1] as GameServerInformations).serializeAs_GameServerInformations(output);
                _i1++;
            };
            if (this.alreadyConnectedToServerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.alreadyConnectedToServerId) + ") on element alreadyConnectedToServerId.")));
            };
            output.writeVarShort(this.alreadyConnectedToServerId);
            output.writeBoolean(this.canCreateNewCharacter);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ServersListMessage(input);
        }

        public function deserializeAs_ServersListMessage(input:ICustomDataInput):void
        {
            var _item1:GameServerInformations;
            var _serversLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _serversLen)
            {
                _item1 = new GameServerInformations();
                _item1.deserialize(input);
                this.servers.push(_item1);
                _i1++;
            };
            this._alreadyConnectedToServerIdFunc(input);
            this._canCreateNewCharacterFunc(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ServersListMessage(tree);
        }

        public function deserializeAsyncAs_ServersListMessage(tree:FuncTree):void
        {
            this._serverstree = tree.addChild(this._serverstreeFunc);
            tree.addChild(this._alreadyConnectedToServerIdFunc);
            tree.addChild(this._canCreateNewCharacterFunc);
        }

        private function _serverstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._serverstree.addChild(this._serversFunc);
                i++;
            };
        }

        private function _serversFunc(input:ICustomDataInput):void
        {
            var _item:GameServerInformations = new GameServerInformations();
            _item.deserialize(input);
            this.servers.push(_item);
        }

        private function _alreadyConnectedToServerIdFunc(input:ICustomDataInput):void
        {
            this.alreadyConnectedToServerId = input.readVarUhShort();
            if (this.alreadyConnectedToServerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.alreadyConnectedToServerId) + ") on element of ServersListMessage.alreadyConnectedToServerId.")));
            };
        }

        private function _canCreateNewCharacterFunc(input:ICustomDataInput):void
        {
            this.canCreateNewCharacter = input.readBoolean();
        }


    }
} com.ankamagames.dofus.network.messages.connection

