package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.GameRolePlayNpcQuestFlag;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class MapNpcsQuestStatusUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5642;

        private var _isInitialized:Boolean = false;
        public var mapId:Number = 0;
        public var npcsIdsWithQuest:Vector.<int> = new Vector.<int>();
        public var questFlags:Vector.<GameRolePlayNpcQuestFlag> = new Vector.<GameRolePlayNpcQuestFlag>();
        public var npcsIdsWithoutQuest:Vector.<int> = new Vector.<int>();
        private var _npcsIdsWithQuesttree:FuncTree;
        private var _questFlagstree:FuncTree;
        private var _npcsIdsWithoutQuesttree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5642);
        }

        public function initMapNpcsQuestStatusUpdateMessage(mapId:Number=0, npcsIdsWithQuest:Vector.<int>=null, questFlags:Vector.<GameRolePlayNpcQuestFlag>=null, npcsIdsWithoutQuest:Vector.<int>=null):MapNpcsQuestStatusUpdateMessage
        {
            this.mapId = mapId;
            this.npcsIdsWithQuest = npcsIdsWithQuest;
            this.questFlags = questFlags;
            this.npcsIdsWithoutQuest = npcsIdsWithoutQuest;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.mapId = 0;
            this.npcsIdsWithQuest = new Vector.<int>();
            this.questFlags = new Vector.<GameRolePlayNpcQuestFlag>();
            this.npcsIdsWithoutQuest = new Vector.<int>();
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
            this.serializeAs_MapNpcsQuestStatusUpdateMessage(output);
        }

        public function serializeAs_MapNpcsQuestStatusUpdateMessage(output:ICustomDataOutput):void
        {
            if (((this.mapId < 0) || (this.mapId > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.mapId) + ") on element mapId.")));
            };
            output.writeDouble(this.mapId);
            output.writeShort(this.npcsIdsWithQuest.length);
            var _i2:uint;
            while (_i2 < this.npcsIdsWithQuest.length)
            {
                output.writeInt(this.npcsIdsWithQuest[_i2]);
                _i2++;
            };
            output.writeShort(this.questFlags.length);
            var _i3:uint;
            while (_i3 < this.questFlags.length)
            {
                (this.questFlags[_i3] as GameRolePlayNpcQuestFlag).serializeAs_GameRolePlayNpcQuestFlag(output);
                _i3++;
            };
            output.writeShort(this.npcsIdsWithoutQuest.length);
            var _i4:uint;
            while (_i4 < this.npcsIdsWithoutQuest.length)
            {
                output.writeInt(this.npcsIdsWithoutQuest[_i4]);
                _i4++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapNpcsQuestStatusUpdateMessage(input);
        }

        public function deserializeAs_MapNpcsQuestStatusUpdateMessage(input:ICustomDataInput):void
        {
            var _val2:int;
            var _item3:GameRolePlayNpcQuestFlag;
            var _val4:int;
            this._mapIdFunc(input);
            var _npcsIdsWithQuestLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _npcsIdsWithQuestLen)
            {
                _val2 = input.readInt();
                this.npcsIdsWithQuest.push(_val2);
                _i2++;
            };
            var _questFlagsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _questFlagsLen)
            {
                _item3 = new GameRolePlayNpcQuestFlag();
                _item3.deserialize(input);
                this.questFlags.push(_item3);
                _i3++;
            };
            var _npcsIdsWithoutQuestLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _npcsIdsWithoutQuestLen)
            {
                _val4 = input.readInt();
                this.npcsIdsWithoutQuest.push(_val4);
                _i4++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_MapNpcsQuestStatusUpdateMessage(tree);
        }

        public function deserializeAsyncAs_MapNpcsQuestStatusUpdateMessage(tree:FuncTree):void
        {
            tree.addChild(this._mapIdFunc);
            this._npcsIdsWithQuesttree = tree.addChild(this._npcsIdsWithQuesttreeFunc);
            this._questFlagstree = tree.addChild(this._questFlagstreeFunc);
            this._npcsIdsWithoutQuesttree = tree.addChild(this._npcsIdsWithoutQuesttreeFunc);
        }

        private function _mapIdFunc(input:ICustomDataInput):void
        {
            this.mapId = input.readDouble();
            if (((this.mapId < 0) || (this.mapId > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.mapId) + ") on element of MapNpcsQuestStatusUpdateMessage.mapId.")));
            };
        }

        private function _npcsIdsWithQuesttreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._npcsIdsWithQuesttree.addChild(this._npcsIdsWithQuestFunc);
                i++;
            };
        }

        private function _npcsIdsWithQuestFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readInt();
            this.npcsIdsWithQuest.push(_val);
        }

        private function _questFlagstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._questFlagstree.addChild(this._questFlagsFunc);
                i++;
            };
        }

        private function _questFlagsFunc(input:ICustomDataInput):void
        {
            var _item:GameRolePlayNpcQuestFlag = new GameRolePlayNpcQuestFlag();
            _item.deserialize(input);
            this.questFlags.push(_item);
        }

        private function _npcsIdsWithoutQuesttreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._npcsIdsWithoutQuesttree.addChild(this._npcsIdsWithoutQuestFunc);
                i++;
            };
        }

        private function _npcsIdsWithoutQuestFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readInt();
            this.npcsIdsWithoutQuest.push(_val);
        }


    }
}

