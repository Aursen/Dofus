package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class EntityMovementInformations implements INetworkType 
    {

        public static const protocolId:uint = 63;

        public var id:int = 0;
        public var steps:Vector.<int> = new Vector.<int>();
        private var _stepstree:FuncTree;


        public function getTypeId():uint
        {
            return (63);
        }

        public function initEntityMovementInformations(id:int=0, steps:Vector.<int>=null):EntityMovementInformations
        {
            this.id = id;
            this.steps = steps;
            return (this);
        }

        public function reset():void
        {
            this.id = 0;
            this.steps = new Vector.<int>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_EntityMovementInformations(output);
        }

        public function serializeAs_EntityMovementInformations(output:ICustomDataOutput):void
        {
            output.writeInt(this.id);
            output.writeShort(this.steps.length);
            var _i2:uint;
            while (_i2 < this.steps.length)
            {
                output.writeByte(this.steps[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_EntityMovementInformations(input);
        }

        public function deserializeAs_EntityMovementInformations(input:ICustomDataInput):void
        {
            var _val2:int;
            this._idFunc(input);
            var _stepsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _stepsLen)
            {
                _val2 = input.readByte();
                this.steps.push(_val2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_EntityMovementInformations(tree);
        }

        public function deserializeAsyncAs_EntityMovementInformations(tree:FuncTree):void
        {
            tree.addChild(this._idFunc);
            this._stepstree = tree.addChild(this._stepstreeFunc);
        }

        private function _idFunc(input:ICustomDataInput):void
        {
            this.id = input.readInt();
        }

        private function _stepstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._stepstree.addChild(this._stepsFunc);
                i++;
            };
        }

        private function _stepsFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readByte();
            this.steps.push(_val);
        }


    }
}

