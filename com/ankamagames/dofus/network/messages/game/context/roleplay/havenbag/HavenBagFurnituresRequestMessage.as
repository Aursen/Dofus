package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag
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

    public class HavenBagFurnituresRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6637;

        private var _isInitialized:Boolean = false;
        public var cellIds:Vector.<uint> = new Vector.<uint>();
        public var funitureIds:Vector.<int> = new Vector.<int>();
        public var orientations:Vector.<uint> = new Vector.<uint>();
        private var _cellIdstree:FuncTree;
        private var _funitureIdstree:FuncTree;
        private var _orientationstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6637);
        }

        public function initHavenBagFurnituresRequestMessage(cellIds:Vector.<uint>=null, funitureIds:Vector.<int>=null, orientations:Vector.<uint>=null):HavenBagFurnituresRequestMessage
        {
            this.cellIds = cellIds;
            this.funitureIds = funitureIds;
            this.orientations = orientations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.cellIds = new Vector.<uint>();
            this.funitureIds = new Vector.<int>();
            this.orientations = new Vector.<uint>();
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
            this.serializeAs_HavenBagFurnituresRequestMessage(output);
        }

        public function serializeAs_HavenBagFurnituresRequestMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.cellIds.length);
            var _i1:uint;
            while (_i1 < this.cellIds.length)
            {
                if (this.cellIds[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.cellIds[_i1]) + ") on element 1 (starting at 1) of cellIds.")));
                };
                output.writeVarShort(this.cellIds[_i1]);
                _i1++;
            };
            output.writeShort(this.funitureIds.length);
            var _i2:uint;
            while (_i2 < this.funitureIds.length)
            {
                output.writeInt(this.funitureIds[_i2]);
                _i2++;
            };
            output.writeShort(this.orientations.length);
            var _i3:uint;
            while (_i3 < this.orientations.length)
            {
                if (this.orientations[_i3] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.orientations[_i3]) + ") on element 3 (starting at 1) of orientations.")));
                };
                output.writeByte(this.orientations[_i3]);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HavenBagFurnituresRequestMessage(input);
        }

        public function deserializeAs_HavenBagFurnituresRequestMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _val2:int;
            var _val3:uint;
            var _cellIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _cellIdsLen)
            {
                _val1 = input.readVarUhShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of cellIds.")));
                };
                this.cellIds.push(_val1);
                _i1++;
            };
            var _funitureIdsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _funitureIdsLen)
            {
                _val2 = input.readInt();
                this.funitureIds.push(_val2);
                _i2++;
            };
            var _orientationsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _orientationsLen)
            {
                _val3 = input.readByte();
                if (_val3 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val3) + ") on elements of orientations.")));
                };
                this.orientations.push(_val3);
                _i3++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_HavenBagFurnituresRequestMessage(tree);
        }

        public function deserializeAsyncAs_HavenBagFurnituresRequestMessage(tree:FuncTree):void
        {
            this._cellIdstree = tree.addChild(this._cellIdstreeFunc);
            this._funitureIdstree = tree.addChild(this._funitureIdstreeFunc);
            this._orientationstree = tree.addChild(this._orientationstreeFunc);
        }

        private function _cellIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._cellIdstree.addChild(this._cellIdsFunc);
                i++;
            };
        }

        private function _cellIdsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of cellIds.")));
            };
            this.cellIds.push(_val);
        }

        private function _funitureIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._funitureIdstree.addChild(this._funitureIdsFunc);
                i++;
            };
        }

        private function _funitureIdsFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readInt();
            this.funitureIds.push(_val);
        }

        private function _orientationstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._orientationstree.addChild(this._orientationsFunc);
                i++;
            };
        }

        private function _orientationsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readByte();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of orientations.")));
            };
            this.orientations.push(_val);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag

