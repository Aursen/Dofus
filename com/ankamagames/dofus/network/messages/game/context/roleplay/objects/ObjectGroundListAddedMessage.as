package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
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

    public class ObjectGroundListAddedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5925;

        private var _isInitialized:Boolean = false;
        public var cells:Vector.<uint> = new Vector.<uint>();
        public var referenceIds:Vector.<uint> = new Vector.<uint>();
        private var _cellstree:FuncTree;
        private var _referenceIdstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5925);
        }

        public function initObjectGroundListAddedMessage(cells:Vector.<uint>=null, referenceIds:Vector.<uint>=null):ObjectGroundListAddedMessage
        {
            this.cells = cells;
            this.referenceIds = referenceIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.cells = new Vector.<uint>();
            this.referenceIds = new Vector.<uint>();
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
            this.serializeAs_ObjectGroundListAddedMessage(output);
        }

        public function serializeAs_ObjectGroundListAddedMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.cells.length);
            var _i1:uint;
            while (_i1 < this.cells.length)
            {
                if (((this.cells[_i1] < 0) || (this.cells[_i1] > 559)))
                {
                    throw (new Error((("Forbidden value (" + this.cells[_i1]) + ") on element 1 (starting at 1) of cells.")));
                };
                output.writeVarShort(this.cells[_i1]);
                _i1++;
            };
            output.writeShort(this.referenceIds.length);
            var _i2:uint;
            while (_i2 < this.referenceIds.length)
            {
                if (this.referenceIds[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.referenceIds[_i2]) + ") on element 2 (starting at 1) of referenceIds.")));
                };
                output.writeVarShort(this.referenceIds[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectGroundListAddedMessage(input);
        }

        public function deserializeAs_ObjectGroundListAddedMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _val2:uint;
            var _cellsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _cellsLen)
            {
                _val1 = input.readVarUhShort();
                if (((_val1 < 0) || (_val1 > 559)))
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of cells.")));
                };
                this.cells.push(_val1);
                _i1++;
            };
            var _referenceIdsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _referenceIdsLen)
            {
                _val2 = input.readVarUhShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of referenceIds.")));
                };
                this.referenceIds.push(_val2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ObjectGroundListAddedMessage(tree);
        }

        public function deserializeAsyncAs_ObjectGroundListAddedMessage(tree:FuncTree):void
        {
            this._cellstree = tree.addChild(this._cellstreeFunc);
            this._referenceIdstree = tree.addChild(this._referenceIdstreeFunc);
        }

        private function _cellstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._cellstree.addChild(this._cellsFunc);
                i++;
            };
        }

        private function _cellsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (((_val < 0) || (_val > 559)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of cells.")));
            };
            this.cells.push(_val);
        }

        private function _referenceIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._referenceIdstree.addChild(this._referenceIdsFunc);
                i++;
            };
        }

        private function _referenceIdsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of referenceIds.")));
            };
            this.referenceIds.push(_val);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.objects

