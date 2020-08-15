package com.ankamagames.dofus.network.types.game.idol
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class PartyIdol extends Idol implements INetworkType 
    {

        public static const protocolId:uint = 490;

        public var ownersIds:Vector.<Number> = new Vector.<Number>();
        private var _ownersIdstree:FuncTree;


        override public function getTypeId():uint
        {
            return (490);
        }

        public function initPartyIdol(id:uint=0, xpBonusPercent:uint=0, dropBonusPercent:uint=0, ownersIds:Vector.<Number>=null):PartyIdol
        {
            super.initIdol(id, xpBonusPercent, dropBonusPercent);
            this.ownersIds = ownersIds;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.ownersIds = new Vector.<Number>();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PartyIdol(output);
        }

        public function serializeAs_PartyIdol(output:ICustomDataOutput):void
        {
            super.serializeAs_Idol(output);
            output.writeShort(this.ownersIds.length);
            var _i1:uint;
            while (_i1 < this.ownersIds.length)
            {
                if (((this.ownersIds[_i1] < 0) || (this.ownersIds[_i1] > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + this.ownersIds[_i1]) + ") on element 1 (starting at 1) of ownersIds.")));
                };
                output.writeVarLong(this.ownersIds[_i1]);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyIdol(input);
        }

        public function deserializeAs_PartyIdol(input:ICustomDataInput):void
        {
            var _val1:Number;
            super.deserialize(input);
            var _ownersIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _ownersIdsLen)
            {
                _val1 = input.readVarUhLong();
                if (((_val1 < 0) || (_val1 > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of ownersIds.")));
                };
                this.ownersIds.push(_val1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_PartyIdol(tree);
        }

        public function deserializeAsyncAs_PartyIdol(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._ownersIdstree = tree.addChild(this._ownersIdstreeFunc);
        }

        private function _ownersIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._ownersIdstree.addChild(this._ownersIdsFunc);
                i++;
            };
        }

        private function _ownersIdsFunc(input:ICustomDataInput):void
        {
            var _val:Number = input.readVarUhLong();
            if (((_val < 0) || (_val > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of ownersIds.")));
            };
            this.ownersIds.push(_val);
        }


    }
}

