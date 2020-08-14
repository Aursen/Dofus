package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
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

    public class GameDataPlayFarmObjectAnimationMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6026;

        private var _isInitialized:Boolean = false;
        public var cellId:Vector.<uint> = new Vector.<uint>();
        private var _cellIdtree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6026);
        }

        public function initGameDataPlayFarmObjectAnimationMessage(cellId:Vector.<uint>=null):GameDataPlayFarmObjectAnimationMessage
        {
            this.cellId = cellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.cellId = new Vector.<uint>();
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
            this.serializeAs_GameDataPlayFarmObjectAnimationMessage(output);
        }

        public function serializeAs_GameDataPlayFarmObjectAnimationMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.cellId.length);
            var _i1:uint;
            while (_i1 < this.cellId.length)
            {
                if (((this.cellId[_i1] < 0) || (this.cellId[_i1] > 559)))
                {
                    throw (new Error((("Forbidden value (" + this.cellId[_i1]) + ") on element 1 (starting at 1) of cellId.")));
                };
                output.writeVarShort(this.cellId[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameDataPlayFarmObjectAnimationMessage(input);
        }

        public function deserializeAs_GameDataPlayFarmObjectAnimationMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _cellIdLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _cellIdLen)
            {
                _val1 = input.readVarUhShort();
                if (((_val1 < 0) || (_val1 > 559)))
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of cellId.")));
                };
                this.cellId.push(_val1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameDataPlayFarmObjectAnimationMessage(tree);
        }

        public function deserializeAsyncAs_GameDataPlayFarmObjectAnimationMessage(tree:FuncTree):void
        {
            this._cellIdtree = tree.addChild(this._cellIdtreeFunc);
        }

        private function _cellIdtreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._cellIdtree.addChild(this._cellIdFunc);
                i++;
            };
        }

        private function _cellIdFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (((_val < 0) || (_val > 559)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of cellId.")));
            };
            this.cellId.push(_val);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.paddock

