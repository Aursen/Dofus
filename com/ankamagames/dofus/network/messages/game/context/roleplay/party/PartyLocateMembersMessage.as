package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberGeoPosition;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class PartyLocateMembersMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5595;

        private var _isInitialized:Boolean = false;
        public var geopositions:Vector.<PartyMemberGeoPosition> = new Vector.<PartyMemberGeoPosition>();
        private var _geopositionstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (5595);
        }

        public function initPartyLocateMembersMessage(partyId:uint=0, geopositions:Vector.<PartyMemberGeoPosition>=null):PartyLocateMembersMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.geopositions = geopositions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.geopositions = new Vector.<PartyMemberGeoPosition>();
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
            this.serializeAs_PartyLocateMembersMessage(output);
        }

        public function serializeAs_PartyLocateMembersMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            output.writeShort(this.geopositions.length);
            var _i1:uint;
            while (_i1 < this.geopositions.length)
            {
                (this.geopositions[_i1] as PartyMemberGeoPosition).serializeAs_PartyMemberGeoPosition(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyLocateMembersMessage(input);
        }

        public function deserializeAs_PartyLocateMembersMessage(input:ICustomDataInput):void
        {
            var _item1:PartyMemberGeoPosition;
            super.deserialize(input);
            var _geopositionsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _geopositionsLen)
            {
                _item1 = new PartyMemberGeoPosition();
                _item1.deserialize(input);
                this.geopositions.push(_item1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_PartyLocateMembersMessage(tree);
        }

        public function deserializeAsyncAs_PartyLocateMembersMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._geopositionstree = tree.addChild(this._geopositionstreeFunc);
        }

        private function _geopositionstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._geopositionstree.addChild(this._geopositionsFunc);
                i++;
            };
        }

        private function _geopositionsFunc(input:ICustomDataInput):void
        {
            var _item:PartyMemberGeoPosition = new PartyMemberGeoPosition();
            _item.deserialize(input);
            this.geopositions.push(_item);
        }


    }
}

