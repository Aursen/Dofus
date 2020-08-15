package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class FightStartingPositions implements INetworkType 
    {

        public static const protocolId:uint = 513;

        public var positionsForChallengers:Vector.<uint> = new Vector.<uint>();
        public var positionsForDefenders:Vector.<uint> = new Vector.<uint>();
        private var _positionsForChallengerstree:FuncTree;
        private var _positionsForDefenderstree:FuncTree;


        public function getTypeId():uint
        {
            return (513);
        }

        public function initFightStartingPositions(positionsForChallengers:Vector.<uint>=null, positionsForDefenders:Vector.<uint>=null):FightStartingPositions
        {
            this.positionsForChallengers = positionsForChallengers;
            this.positionsForDefenders = positionsForDefenders;
            return (this);
        }

        public function reset():void
        {
            this.positionsForChallengers = new Vector.<uint>();
            this.positionsForDefenders = new Vector.<uint>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FightStartingPositions(output);
        }

        public function serializeAs_FightStartingPositions(output:ICustomDataOutput):void
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
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FightStartingPositions(input);
        }

        public function deserializeAs_FightStartingPositions(input:ICustomDataInput):void
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
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_FightStartingPositions(tree);
        }

        public function deserializeAsyncAs_FightStartingPositions(tree:FuncTree):void
        {
            this._positionsForChallengerstree = tree.addChild(this._positionsForChallengerstreeFunc);
            this._positionsForDefenderstree = tree.addChild(this._positionsForDefenderstreeFunc);
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


    }
}

