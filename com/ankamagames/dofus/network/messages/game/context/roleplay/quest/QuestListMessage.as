package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class QuestListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5626;

        private var _isInitialized:Boolean = false;
        public var finishedQuestsIds:Vector.<uint> = new Vector.<uint>();
        public var finishedQuestsCounts:Vector.<uint> = new Vector.<uint>();
        public var activeQuests:Vector.<QuestActiveInformations> = new Vector.<QuestActiveInformations>();
        public var reinitDoneQuestsIds:Vector.<uint> = new Vector.<uint>();
        private var _finishedQuestsIdstree:FuncTree;
        private var _finishedQuestsCountstree:FuncTree;
        private var _activeQueststree:FuncTree;
        private var _reinitDoneQuestsIdstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5626);
        }

        public function initQuestListMessage(finishedQuestsIds:Vector.<uint>=null, finishedQuestsCounts:Vector.<uint>=null, activeQuests:Vector.<QuestActiveInformations>=null, reinitDoneQuestsIds:Vector.<uint>=null):QuestListMessage
        {
            this.finishedQuestsIds = finishedQuestsIds;
            this.finishedQuestsCounts = finishedQuestsCounts;
            this.activeQuests = activeQuests;
            this.reinitDoneQuestsIds = reinitDoneQuestsIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.finishedQuestsIds = new Vector.<uint>();
            this.finishedQuestsCounts = new Vector.<uint>();
            this.activeQuests = new Vector.<QuestActiveInformations>();
            this.reinitDoneQuestsIds = new Vector.<uint>();
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
            this.serializeAs_QuestListMessage(output);
        }

        public function serializeAs_QuestListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.finishedQuestsIds.length);
            var _i1:uint;
            while (_i1 < this.finishedQuestsIds.length)
            {
                if (this.finishedQuestsIds[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.finishedQuestsIds[_i1]) + ") on element 1 (starting at 1) of finishedQuestsIds.")));
                };
                output.writeVarShort(this.finishedQuestsIds[_i1]);
                _i1++;
            };
            output.writeShort(this.finishedQuestsCounts.length);
            var _i2:uint;
            while (_i2 < this.finishedQuestsCounts.length)
            {
                if (this.finishedQuestsCounts[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.finishedQuestsCounts[_i2]) + ") on element 2 (starting at 1) of finishedQuestsCounts.")));
                };
                output.writeVarShort(this.finishedQuestsCounts[_i2]);
                _i2++;
            };
            output.writeShort(this.activeQuests.length);
            var _i3:uint;
            while (_i3 < this.activeQuests.length)
            {
                output.writeShort((this.activeQuests[_i3] as QuestActiveInformations).getTypeId());
                (this.activeQuests[_i3] as QuestActiveInformations).serialize(output);
                _i3++;
            };
            output.writeShort(this.reinitDoneQuestsIds.length);
            var _i4:uint;
            while (_i4 < this.reinitDoneQuestsIds.length)
            {
                if (this.reinitDoneQuestsIds[_i4] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.reinitDoneQuestsIds[_i4]) + ") on element 4 (starting at 1) of reinitDoneQuestsIds.")));
                };
                output.writeVarShort(this.reinitDoneQuestsIds[_i4]);
                _i4++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_QuestListMessage(input);
        }

        public function deserializeAs_QuestListMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _val2:uint;
            var _id3:uint;
            var _item3:QuestActiveInformations;
            var _val4:uint;
            var _finishedQuestsIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _finishedQuestsIdsLen)
            {
                _val1 = input.readVarUhShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of finishedQuestsIds.")));
                };
                this.finishedQuestsIds.push(_val1);
                _i1++;
            };
            var _finishedQuestsCountsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _finishedQuestsCountsLen)
            {
                _val2 = input.readVarUhShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of finishedQuestsCounts.")));
                };
                this.finishedQuestsCounts.push(_val2);
                _i2++;
            };
            var _activeQuestsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _activeQuestsLen)
            {
                _id3 = input.readUnsignedShort();
                _item3 = ProtocolTypeManager.getInstance(QuestActiveInformations, _id3);
                _item3.deserialize(input);
                this.activeQuests.push(_item3);
                _i3++;
            };
            var _reinitDoneQuestsIdsLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _reinitDoneQuestsIdsLen)
            {
                _val4 = input.readVarUhShort();
                if (_val4 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val4) + ") on elements of reinitDoneQuestsIds.")));
                };
                this.reinitDoneQuestsIds.push(_val4);
                _i4++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_QuestListMessage(tree);
        }

        public function deserializeAsyncAs_QuestListMessage(tree:FuncTree):void
        {
            this._finishedQuestsIdstree = tree.addChild(this._finishedQuestsIdstreeFunc);
            this._finishedQuestsCountstree = tree.addChild(this._finishedQuestsCountstreeFunc);
            this._activeQueststree = tree.addChild(this._activeQueststreeFunc);
            this._reinitDoneQuestsIdstree = tree.addChild(this._reinitDoneQuestsIdstreeFunc);
        }

        private function _finishedQuestsIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._finishedQuestsIdstree.addChild(this._finishedQuestsIdsFunc);
                i++;
            };
        }

        private function _finishedQuestsIdsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of finishedQuestsIds.")));
            };
            this.finishedQuestsIds.push(_val);
        }

        private function _finishedQuestsCountstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._finishedQuestsCountstree.addChild(this._finishedQuestsCountsFunc);
                i++;
            };
        }

        private function _finishedQuestsCountsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of finishedQuestsCounts.")));
            };
            this.finishedQuestsCounts.push(_val);
        }

        private function _activeQueststreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._activeQueststree.addChild(this._activeQuestsFunc);
                i++;
            };
        }

        private function _activeQuestsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:QuestActiveInformations = ProtocolTypeManager.getInstance(QuestActiveInformations, _id);
            _item.deserialize(input);
            this.activeQuests.push(_item);
        }

        private function _reinitDoneQuestsIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._reinitDoneQuestsIdstree.addChild(this._reinitDoneQuestsIdsFunc);
                i++;
            };
        }

        private function _reinitDoneQuestsIdsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of reinitDoneQuestsIds.")));
            };
            this.reinitDoneQuestsIds.push(_val);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.quest

