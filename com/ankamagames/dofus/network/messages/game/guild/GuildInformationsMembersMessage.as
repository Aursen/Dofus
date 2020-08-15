package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.guild.GuildMember;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GuildInformationsMembersMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5558;

        private var _isInitialized:Boolean = false;
        public var members:Vector.<GuildMember> = new Vector.<GuildMember>();
        private var _memberstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5558);
        }

        public function initGuildInformationsMembersMessage(members:Vector.<GuildMember>=null):GuildInformationsMembersMessage
        {
            this.members = members;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.members = new Vector.<GuildMember>();
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
            this.serializeAs_GuildInformationsMembersMessage(output);
        }

        public function serializeAs_GuildInformationsMembersMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.members.length);
            var _i1:uint;
            while (_i1 < this.members.length)
            {
                (this.members[_i1] as GuildMember).serializeAs_GuildMember(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInformationsMembersMessage(input);
        }

        public function deserializeAs_GuildInformationsMembersMessage(input:ICustomDataInput):void
        {
            var _item1:GuildMember;
            var _membersLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _membersLen)
            {
                _item1 = new GuildMember();
                _item1.deserialize(input);
                this.members.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GuildInformationsMembersMessage(tree);
        }

        public function deserializeAsyncAs_GuildInformationsMembersMessage(tree:FuncTree):void
        {
            this._memberstree = tree.addChild(this._memberstreeFunc);
        }

        private function _memberstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._memberstree.addChild(this._membersFunc);
                i++;
            };
        }

        private function _membersFunc(input:ICustomDataInput):void
        {
            var _item:GuildMember = new GuildMember();
            _item.deserialize(input);
            this.members.push(_item);
        }


    }
}

