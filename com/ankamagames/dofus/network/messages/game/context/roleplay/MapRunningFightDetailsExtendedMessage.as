package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeam;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterLightInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class MapRunningFightDetailsExtendedMessage extends MapRunningFightDetailsMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6500;

        private var _isInitialized:Boolean = false;
        public var namedPartyTeams:Vector.<NamedPartyTeam> = new Vector.<NamedPartyTeam>();
        private var _namedPartyTeamstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (6500);
        }

        public function initMapRunningFightDetailsExtendedMessage(fightId:uint=0, attackers:Vector.<GameFightFighterLightInformations>=null, defenders:Vector.<GameFightFighterLightInformations>=null, namedPartyTeams:Vector.<NamedPartyTeam>=null):MapRunningFightDetailsExtendedMessage
        {
            super.initMapRunningFightDetailsMessage(fightId, attackers, defenders);
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
            this.serializeAs_MapRunningFightDetailsExtendedMessage(output);
        }

        public function serializeAs_MapRunningFightDetailsExtendedMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_MapRunningFightDetailsMessage(output);
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
            this.deserializeAs_MapRunningFightDetailsExtendedMessage(input);
        }

        public function deserializeAs_MapRunningFightDetailsExtendedMessage(input:ICustomDataInput):void
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
            this.deserializeAsyncAs_MapRunningFightDetailsExtendedMessage(tree);
        }

        public function deserializeAsyncAs_MapRunningFightDetailsExtendedMessage(tree:FuncTree):void
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

