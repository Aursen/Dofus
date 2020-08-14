package com.ankamagames.dofus.network.messages.game.context.fight.challenge
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

    public class ChallengeTargetsListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5613;

        private var _isInitialized:Boolean = false;
        public var targetIds:Vector.<Number> = new Vector.<Number>();
        public var targetCells:Vector.<int> = new Vector.<int>();
        private var _targetIdstree:FuncTree;
        private var _targetCellstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5613);
        }

        public function initChallengeTargetsListMessage(targetIds:Vector.<Number>=null, targetCells:Vector.<int>=null):ChallengeTargetsListMessage
        {
            this.targetIds = targetIds;
            this.targetCells = targetCells;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.targetIds = new Vector.<Number>();
            this.targetCells = new Vector.<int>();
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
            this.serializeAs_ChallengeTargetsListMessage(output);
        }

        public function serializeAs_ChallengeTargetsListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.targetIds.length);
            var _i1:uint;
            while (_i1 < this.targetIds.length)
            {
                if (((this.targetIds[_i1] < -9007199254740992) || (this.targetIds[_i1] > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + this.targetIds[_i1]) + ") on element 1 (starting at 1) of targetIds.")));
                };
                output.writeDouble(this.targetIds[_i1]);
                _i1++;
            };
            output.writeShort(this.targetCells.length);
            var _i2:uint;
            while (_i2 < this.targetCells.length)
            {
                if (((this.targetCells[_i2] < -1) || (this.targetCells[_i2] > 559)))
                {
                    throw (new Error((("Forbidden value (" + this.targetCells[_i2]) + ") on element 2 (starting at 1) of targetCells.")));
                };
                output.writeShort(this.targetCells[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ChallengeTargetsListMessage(input);
        }

        public function deserializeAs_ChallengeTargetsListMessage(input:ICustomDataInput):void
        {
            var _val1:Number;
            var _val2:int;
            var _targetIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _targetIdsLen)
            {
                _val1 = input.readDouble();
                if (((_val1 < -9007199254740992) || (_val1 > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of targetIds.")));
                };
                this.targetIds.push(_val1);
                _i1++;
            };
            var _targetCellsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _targetCellsLen)
            {
                _val2 = input.readShort();
                if (((_val2 < -1) || (_val2 > 559)))
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of targetCells.")));
                };
                this.targetCells.push(_val2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ChallengeTargetsListMessage(tree);
        }

        public function deserializeAsyncAs_ChallengeTargetsListMessage(tree:FuncTree):void
        {
            this._targetIdstree = tree.addChild(this._targetIdstreeFunc);
            this._targetCellstree = tree.addChild(this._targetCellstreeFunc);
        }

        private function _targetIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._targetIdstree.addChild(this._targetIdsFunc);
                i++;
            };
        }

        private function _targetIdsFunc(input:ICustomDataInput):void
        {
            var _val:Number = input.readDouble();
            if (((_val < -9007199254740992) || (_val > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of targetIds.")));
            };
            this.targetIds.push(_val);
        }

        private function _targetCellstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._targetCellstree.addChild(this._targetCellsFunc);
                i++;
            };
        }

        private function _targetCellsFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readShort();
            if (((_val < -1) || (_val > 559)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of targetCells.")));
            };
            this.targetCells.push(_val);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.fight.challenge

