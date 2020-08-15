package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.social.AllianceVersatileInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class AllianceVersatileInfoListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6436;

        private var _isInitialized:Boolean = false;
        public var alliances:Vector.<AllianceVersatileInformations> = new Vector.<AllianceVersatileInformations>();
        private var _alliancestree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6436);
        }

        public function initAllianceVersatileInfoListMessage(alliances:Vector.<AllianceVersatileInformations>=null):AllianceVersatileInfoListMessage
        {
            this.alliances = alliances;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.alliances = new Vector.<AllianceVersatileInformations>();
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
            this.serializeAs_AllianceVersatileInfoListMessage(output);
        }

        public function serializeAs_AllianceVersatileInfoListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.alliances.length);
            var _i1:uint;
            while (_i1 < this.alliances.length)
            {
                (this.alliances[_i1] as AllianceVersatileInformations).serializeAs_AllianceVersatileInformations(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceVersatileInfoListMessage(input);
        }

        public function deserializeAs_AllianceVersatileInfoListMessage(input:ICustomDataInput):void
        {
            var _item1:AllianceVersatileInformations;
            var _alliancesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _alliancesLen)
            {
                _item1 = new AllianceVersatileInformations();
                _item1.deserialize(input);
                this.alliances.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_AllianceVersatileInfoListMessage(tree);
        }

        public function deserializeAsyncAs_AllianceVersatileInfoListMessage(tree:FuncTree):void
        {
            this._alliancestree = tree.addChild(this._alliancestreeFunc);
        }

        private function _alliancestreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._alliancestree.addChild(this._alliancesFunc);
                i++;
            };
        }

        private function _alliancesFunc(input:ICustomDataInput):void
        {
            var _item:AllianceVersatileInformations = new AllianceVersatileInformations();
            _item.deserialize(input);
            this.alliances.push(_item);
        }


    }
}

