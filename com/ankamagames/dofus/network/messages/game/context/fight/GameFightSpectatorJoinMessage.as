package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeam;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GameFightSpectatorJoinMessage extends GameFightJoinMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6504;

        private var _isInitialized:Boolean = false;
        public var namedPartyTeams:Vector.<NamedPartyTeam> = new Vector.<NamedPartyTeam>();
        private var _namedPartyTeamstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (6504);
        }

        public function initGameFightSpectatorJoinMessage(isTeamPhase:Boolean=false, canBeCancelled:Boolean=false, canSayReady:Boolean=false, isFightStarted:Boolean=false, timeMaxBeforeFightStart:uint=0, fightType:uint=0, namedPartyTeams:Vector.<NamedPartyTeam>=null):GameFightSpectatorJoinMessage
        {
            super.initGameFightJoinMessage(isTeamPhase, canBeCancelled, canSayReady, isFightStarted, timeMaxBeforeFightStart, fightType);
            this.namedPartyTeams = namedPartyTeams;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.namedPartyTeams = new Vector.<NamedPartyTeam>();
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
            this.serializeAs_GameFightSpectatorJoinMessage(output);
        }

        public function serializeAs_GameFightSpectatorJoinMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightJoinMessage(output);
            output.writeShort(this.namedPartyTeams.length);
            var _i1:uint;
            while (_i1 < this.namedPartyTeams.length)
            {
                (this.namedPartyTeams[_i1] as NamedPartyTeam).serializeAs_NamedPartyTeam(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightSpectatorJoinMessage(input);
        }

        public function deserializeAs_GameFightSpectatorJoinMessage(input:ICustomDataInput):void
        {
            var _item1:NamedPartyTeam;
            super.deserialize(input);
            var _namedPartyTeamsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _namedPartyTeamsLen)
            {
                _item1 = new NamedPartyTeam();
                _item1.deserialize(input);
                this.namedPartyTeams.push(_item1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameFightSpectatorJoinMessage(tree);
        }

        public function deserializeAsyncAs_GameFightSpectatorJoinMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._namedPartyTeamstree = tree.addChild(this._namedPartyTeamstreeFunc);
        }

        private function _namedPartyTeamstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._namedPartyTeamstree.addChild(this._namedPartyTeamsFunc);
                i++;
            };
        }

        private function _namedPartyTeamsFunc(input:ICustomDataInput):void
        {
            var _item:NamedPartyTeam = new NamedPartyTeam();
            _item.deserialize(input);
            this.namedPartyTeams.push(_item);
        }


    }
}

