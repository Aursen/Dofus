package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.social.GuildInsiderFactSheetInformations;
    import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class AllianceInsiderInfoMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6403;

        private var _isInitialized:Boolean = false;
        public var allianceInfos:AllianceFactSheetInformations = new AllianceFactSheetInformations();
        public var guilds:Vector.<GuildInsiderFactSheetInformations> = new Vector.<GuildInsiderFactSheetInformations>();
        public var prisms:Vector.<PrismSubareaEmptyInfo> = new Vector.<PrismSubareaEmptyInfo>();
        private var _allianceInfostree:FuncTree;
        private var _guildstree:FuncTree;
        private var _prismstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6403);
        }

        public function initAllianceInsiderInfoMessage(allianceInfos:AllianceFactSheetInformations=null, guilds:Vector.<GuildInsiderFactSheetInformations>=null, prisms:Vector.<PrismSubareaEmptyInfo>=null):AllianceInsiderInfoMessage
        {
            this.allianceInfos = allianceInfos;
            this.guilds = guilds;
            this.prisms = prisms;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.allianceInfos = new AllianceFactSheetInformations();
            this.prisms = new Vector.<PrismSubareaEmptyInfo>();
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
            this.serializeAs_AllianceInsiderInfoMessage(output);
        }

        public function serializeAs_AllianceInsiderInfoMessage(output:ICustomDataOutput):void
        {
            this.allianceInfos.serializeAs_AllianceFactSheetInformations(output);
            output.writeShort(this.guilds.length);
            var _i2:uint;
            while (_i2 < this.guilds.length)
            {
                (this.guilds[_i2] as GuildInsiderFactSheetInformations).serializeAs_GuildInsiderFactSheetInformations(output);
                _i2++;
            };
            output.writeShort(this.prisms.length);
            var _i3:uint;
            while (_i3 < this.prisms.length)
            {
                output.writeShort((this.prisms[_i3] as PrismSubareaEmptyInfo).getTypeId());
                (this.prisms[_i3] as PrismSubareaEmptyInfo).serialize(output);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceInsiderInfoMessage(input);
        }

        public function deserializeAs_AllianceInsiderInfoMessage(input:ICustomDataInput):void
        {
            var _item2:GuildInsiderFactSheetInformations;
            var _id3:uint;
            var _item3:PrismSubareaEmptyInfo;
            this.allianceInfos = new AllianceFactSheetInformations();
            this.allianceInfos.deserialize(input);
            var _guildsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _guildsLen)
            {
                _item2 = new GuildInsiderFactSheetInformations();
                _item2.deserialize(input);
                this.guilds.push(_item2);
                _i2++;
            };
            var _prismsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _prismsLen)
            {
                _id3 = input.readUnsignedShort();
                _item3 = ProtocolTypeManager.getInstance(PrismSubareaEmptyInfo, _id3);
                _item3.deserialize(input);
                this.prisms.push(_item3);
                _i3++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_AllianceInsiderInfoMessage(tree);
        }

        public function deserializeAsyncAs_AllianceInsiderInfoMessage(tree:FuncTree):void
        {
            this._allianceInfostree = tree.addChild(this._allianceInfostreeFunc);
            this._guildstree = tree.addChild(this._guildstreeFunc);
            this._prismstree = tree.addChild(this._prismstreeFunc);
        }

        private function _allianceInfostreeFunc(input:ICustomDataInput):void
        {
            this.allianceInfos = new AllianceFactSheetInformations();
            this.allianceInfos.deserializeAsync(this._allianceInfostree);
        }

        private function _guildstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._guildstree.addChild(this._guildsFunc);
                i++;
            };
        }

        private function _guildsFunc(input:ICustomDataInput):void
        {
            var _item:GuildInsiderFactSheetInformations = new GuildInsiderFactSheetInformations();
            _item.deserialize(input);
            this.guilds.push(_item);
        }

        private function _prismstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._prismstree.addChild(this._prismsFunc);
                i++;
            };
        }

        private function _prismsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:PrismSubareaEmptyInfo = ProtocolTypeManager.getInstance(PrismSubareaEmptyInfo, _id);
            _item.deserialize(input);
            this.prisms.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.alliance

