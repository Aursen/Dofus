package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class KohUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6439;

        private var _isInitialized:Boolean = false;
        public var alliances:Vector.<AllianceInformations> = new Vector.<AllianceInformations>();
        public var allianceNbMembers:Vector.<uint> = new Vector.<uint>();
        public var allianceRoundWeigth:Vector.<uint> = new Vector.<uint>();
        public var allianceMatchScore:Vector.<uint> = new Vector.<uint>();
        public var allianceMapWinners:Vector.<BasicAllianceInformations> = new Vector.<BasicAllianceInformations>();
        public var allianceMapWinnerScore:uint = 0;
        public var allianceMapMyAllianceScore:uint = 0;
        public var nextTickTime:Number = 0;
        private var _alliancestree:FuncTree;
        private var _allianceNbMemberstree:FuncTree;
        private var _allianceRoundWeigthtree:FuncTree;
        private var _allianceMatchScoretree:FuncTree;
        private var _allianceMapWinnerstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6439);
        }

        public function initKohUpdateMessage(alliances:Vector.<AllianceInformations>=null, allianceNbMembers:Vector.<uint>=null, allianceRoundWeigth:Vector.<uint>=null, allianceMatchScore:Vector.<uint>=null, allianceMapWinners:Vector.<BasicAllianceInformations>=null, allianceMapWinnerScore:uint=0, allianceMapMyAllianceScore:uint=0, nextTickTime:Number=0):KohUpdateMessage
        {
            this.alliances = alliances;
            this.allianceNbMembers = allianceNbMembers;
            this.allianceRoundWeigth = allianceRoundWeigth;
            this.allianceMatchScore = allianceMatchScore;
            this.allianceMapWinners = allianceMapWinners;
            this.allianceMapWinnerScore = allianceMapWinnerScore;
            this.allianceMapMyAllianceScore = allianceMapMyAllianceScore;
            this.nextTickTime = nextTickTime;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.alliances = new Vector.<AllianceInformations>();
            this.allianceNbMembers = new Vector.<uint>();
            this.allianceRoundWeigth = new Vector.<uint>();
            this.allianceMatchScore = new Vector.<uint>();
            this.allianceMapWinners = new Vector.<BasicAllianceInformations>();
            this.allianceMapWinnerScore = 0;
            this.allianceMapMyAllianceScore = 0;
            this.nextTickTime = 0;
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
            this.serializeAs_KohUpdateMessage(output);
        }

        public function serializeAs_KohUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.alliances.length);
            var _i1:uint;
            while (_i1 < this.alliances.length)
            {
                (this.alliances[_i1] as AllianceInformations).serializeAs_AllianceInformations(output);
                _i1++;
            };
            output.writeShort(this.allianceNbMembers.length);
            var _i2:uint;
            while (_i2 < this.allianceNbMembers.length)
            {
                if (this.allianceNbMembers[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.allianceNbMembers[_i2]) + ") on element 2 (starting at 1) of allianceNbMembers.")));
                };
                output.writeVarShort(this.allianceNbMembers[_i2]);
                _i2++;
            };
            output.writeShort(this.allianceRoundWeigth.length);
            var _i3:uint;
            while (_i3 < this.allianceRoundWeigth.length)
            {
                if (this.allianceRoundWeigth[_i3] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.allianceRoundWeigth[_i3]) + ") on element 3 (starting at 1) of allianceRoundWeigth.")));
                };
                output.writeVarInt(this.allianceRoundWeigth[_i3]);
                _i3++;
            };
            output.writeShort(this.allianceMatchScore.length);
            var _i4:uint;
            while (_i4 < this.allianceMatchScore.length)
            {
                if (this.allianceMatchScore[_i4] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.allianceMatchScore[_i4]) + ") on element 4 (starting at 1) of allianceMatchScore.")));
                };
                output.writeByte(this.allianceMatchScore[_i4]);
                _i4++;
            };
            output.writeShort(this.allianceMapWinners.length);
            var _i5:uint;
            while (_i5 < this.allianceMapWinners.length)
            {
                (this.allianceMapWinners[_i5] as BasicAllianceInformations).serializeAs_BasicAllianceInformations(output);
                _i5++;
            };
            if (this.allianceMapWinnerScore < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceMapWinnerScore) + ") on element allianceMapWinnerScore.")));
            };
            output.writeVarInt(this.allianceMapWinnerScore);
            if (this.allianceMapMyAllianceScore < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceMapMyAllianceScore) + ") on element allianceMapMyAllianceScore.")));
            };
            output.writeVarInt(this.allianceMapMyAllianceScore);
            if (((this.nextTickTime < 0) || (this.nextTickTime > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.nextTickTime) + ") on element nextTickTime.")));
            };
            output.writeDouble(this.nextTickTime);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_KohUpdateMessage(input);
        }

        public function deserializeAs_KohUpdateMessage(input:ICustomDataInput):void
        {
            var _item1:AllianceInformations;
            var _val2:uint;
            var _val3:uint;
            var _val4:uint;
            var _item5:BasicAllianceInformations;
            var _alliancesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _alliancesLen)
            {
                _item1 = new AllianceInformations();
                _item1.deserialize(input);
                this.alliances.push(_item1);
                _i1++;
            };
            var _allianceNbMembersLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _allianceNbMembersLen)
            {
                _val2 = input.readVarUhShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of allianceNbMembers.")));
                };
                this.allianceNbMembers.push(_val2);
                _i2++;
            };
            var _allianceRoundWeigthLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _allianceRoundWeigthLen)
            {
                _val3 = input.readVarUhInt();
                if (_val3 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val3) + ") on elements of allianceRoundWeigth.")));
                };
                this.allianceRoundWeigth.push(_val3);
                _i3++;
            };
            var _allianceMatchScoreLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _allianceMatchScoreLen)
            {
                _val4 = input.readByte();
                if (_val4 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val4) + ") on elements of allianceMatchScore.")));
                };
                this.allianceMatchScore.push(_val4);
                _i4++;
            };
            var _allianceMapWinnersLen:uint = input.readUnsignedShort();
            var _i5:uint;
            while (_i5 < _allianceMapWinnersLen)
            {
                _item5 = new BasicAllianceInformations();
                _item5.deserialize(input);
                this.allianceMapWinners.push(_item5);
                _i5++;
            };
            this._allianceMapWinnerScoreFunc(input);
            this._allianceMapMyAllianceScoreFunc(input);
            this._nextTickTimeFunc(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_KohUpdateMessage(tree);
        }

        public function deserializeAsyncAs_KohUpdateMessage(tree:FuncTree):void
        {
            this._alliancestree = tree.addChild(this._alliancestreeFunc);
            this._allianceNbMemberstree = tree.addChild(this._allianceNbMemberstreeFunc);
            this._allianceRoundWeigthtree = tree.addChild(this._allianceRoundWeigthtreeFunc);
            this._allianceMatchScoretree = tree.addChild(this._allianceMatchScoretreeFunc);
            this._allianceMapWinnerstree = tree.addChild(this._allianceMapWinnerstreeFunc);
            tree.addChild(this._allianceMapWinnerScoreFunc);
            tree.addChild(this._allianceMapMyAllianceScoreFunc);
            tree.addChild(this._nextTickTimeFunc);
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
            var _item:AllianceInformations = new AllianceInformations();
            _item.deserialize(input);
            this.alliances.push(_item);
        }

        private function _allianceNbMemberstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._allianceNbMemberstree.addChild(this._allianceNbMembersFunc);
                i++;
            };
        }

        private function _allianceNbMembersFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of allianceNbMembers.")));
            };
            this.allianceNbMembers.push(_val);
        }

        private function _allianceRoundWeigthtreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._allianceRoundWeigthtree.addChild(this._allianceRoundWeigthFunc);
                i++;
            };
        }

        private function _allianceRoundWeigthFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhInt();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of allianceRoundWeigth.")));
            };
            this.allianceRoundWeigth.push(_val);
        }

        private function _allianceMatchScoretreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._allianceMatchScoretree.addChild(this._allianceMatchScoreFunc);
                i++;
            };
        }

        private function _allianceMatchScoreFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readByte();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of allianceMatchScore.")));
            };
            this.allianceMatchScore.push(_val);
        }

        private function _allianceMapWinnerstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._allianceMapWinnerstree.addChild(this._allianceMapWinnersFunc);
                i++;
            };
        }

        private function _allianceMapWinnersFunc(input:ICustomDataInput):void
        {
            var _item:BasicAllianceInformations = new BasicAllianceInformations();
            _item.deserialize(input);
            this.allianceMapWinners.push(_item);
        }

        private function _allianceMapWinnerScoreFunc(input:ICustomDataInput):void
        {
            this.allianceMapWinnerScore = input.readVarUhInt();
            if (this.allianceMapWinnerScore < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceMapWinnerScore) + ") on element of KohUpdateMessage.allianceMapWinnerScore.")));
            };
        }

        private function _allianceMapMyAllianceScoreFunc(input:ICustomDataInput):void
        {
            this.allianceMapMyAllianceScore = input.readVarUhInt();
            if (this.allianceMapMyAllianceScore < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceMapMyAllianceScore) + ") on element of KohUpdateMessage.allianceMapMyAllianceScore.")));
            };
        }

        private function _nextTickTimeFunc(input:ICustomDataInput):void
        {
            this.nextTickTime = input.readDouble();
            if (((this.nextTickTime < 0) || (this.nextTickTime > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.nextTickTime) + ") on element of KohUpdateMessage.nextTickTime.")));
            };
        }


    }
} com.ankamagames.dofus.network.messages.game.alliance

