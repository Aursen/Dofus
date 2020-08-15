package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GameFightPlacementPossiblePositionsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 703;

        private var _isInitialized:Boolean = false;
        public var positionsForChallengers:Vector.<uint> = new Vector.<uint>();
        public var positionsForDefenders:Vector.<uint> = new Vector.<uint>();
        public var teamNumber:uint = 2;
        private var _positionsForChallengerstree:FuncTree;
        private var _positionsForDefenderstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (703);
        }

        public function initGameFightPlacementPossiblePositionsMessage(positionsForChallengers:Vector.<uint>=null, positionsForDefenders:Vector.<uint>=null, teamNumber:uint=2):GameFightPlacementPossiblePositionsMessage
        {
            this.positionsForChallengers = positionsForChallengers;
            this.positionsForDefenders = positionsForDefenders;
            this.teamNumber = teamNumber;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.positionsForChallengers = new Vector.<uint>();
            this.positionsForDefenders = new Vector.<uint>();
            this.teamNumber = 2;
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
            this.serializeAs_GameFightPlacementPossiblePositionsMessage(output);
        }

        public function serializeAs_GameFightPlacementPossiblePositionsMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.positionsForChallengers.length);
            var _i1:uint;
            while (_i1 < this.positionsForChallengers.length)
            {
                if (((this.positionsForChallengers[_i1] < 0) || (this.positionsForChallengers[_i1] > 559)))
                {
                    throw (new Error((("Forbidden value (" + this.positionsForChallengers[_i1]) + ") on element 1 (starting at 1) of positionsForChallengers.")));
                };
                output.writeVarShort(this.positionsForChallengers[_i1]);
                _i1++;
            };
            output.writeShort(this.positionsForDefenders.length);
            var _i2:uint;
            while (_i2 < this.positionsForDefenders.length)
            {
                if (((this.positionsForDefenders[_i2] < 0) || (this.positionsForDefenders[_i2] > 559)))
                {
                    throw (new Error((("Forbidden value (" + this.positionsForDefenders[_i2]) + ") on element 2 (starting at 1) of positionsForDefenders.")));
                };
                output.writeVarShort(this.positionsForDefenders[_i2]);
                _i2++;
            };
            output.writeByte(this.teamNumber);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightPlacementPossiblePositionsMessage(input);
        }

        public function deserializeAs_GameFightPlacementPossiblePositionsMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _val2:uint;
            var _positionsForChallengersLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _positionsForChallengersLen)
            {
                _val1 = input.readVarUhShort();
                if (((_val1 < 0) || (_val1 > 559)))
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of positionsForChallengers.")));
                };
                this.positionsForChallengers.push(_val1);
                _i1++;
            };
            var _positionsForDefendersLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _positionsForDefendersLen)
            {
                _val2 = input.readVarUhShort();
                if (((_val2 < 0) || (_val2 > 559)))
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of positionsForDefenders.")));
                };
                this.positionsForDefenders.push(_val2);
                _i2++;
            };
            this._teamNumberFunc(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameFightPlacementPossiblePositionsMessage(tree);
        }

        public function deserializeAsyncAs_GameFightPlacementPossiblePositionsMessage(tree:FuncTree):void
        {
            this._positionsForChallengerstree = tree.addChild(this._positionsForChallengerstreeFunc);
            this._positionsForDefenderstree = tree.addChild(this._positionsForDefenderstreeFunc);
            tree.addChild(this._teamNumberFunc);
        }

        private function _positionsForChallengerstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._positionsForChallengerstree.addChild(this._positionsForChallengersFunc);
                i++;
            };
        }

        private function _positionsForChallengersFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (((_val < 0) || (_val > 559)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of positionsForChallengers.")));
            };
            this.positionsForChallengers.push(_val);
        }

        private function _positionsForDefenderstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._positionsForDefenderstree.addChild(this._positionsForDefendersFunc);
                i++;
            };
        }

        private function _positionsForDefendersFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (((_val < 0) || (_val > 559)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of positionsForDefenders.")));
            };
            this.positionsForDefenders.push(_val);
        }

        private function _teamNumberFunc(input:ICustomDataInput):void
        {
            this.teamNumber = input.readByte();
            if (this.teamNumber < 0)
            {
                throw (new Error((("Forbidden value (" + this.teamNumber) + ") on element of GameFightPlacementPossiblePositionsMessage.teamNumber.")));
            };
        }


    }
}

