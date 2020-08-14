package com.ankamagames.dofus.network.messages.game.idol
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.idol.PartyIdol;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class IdolListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6585;

        private var _isInitialized:Boolean = false;
        public var chosenIdols:Vector.<uint> = new Vector.<uint>();
        public var partyChosenIdols:Vector.<uint> = new Vector.<uint>();
        public var partyIdols:Vector.<PartyIdol> = new Vector.<PartyIdol>();
        private var _chosenIdolstree:FuncTree;
        private var _partyChosenIdolstree:FuncTree;
        private var _partyIdolstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6585);
        }

        public function initIdolListMessage(chosenIdols:Vector.<uint>=null, partyChosenIdols:Vector.<uint>=null, partyIdols:Vector.<PartyIdol>=null):IdolListMessage
        {
            this.chosenIdols = chosenIdols;
            this.partyChosenIdols = partyChosenIdols;
            this.partyIdols = partyIdols;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.chosenIdols = new Vector.<uint>();
            this.partyChosenIdols = new Vector.<uint>();
            this.partyIdols = new Vector.<PartyIdol>();
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
            this.serializeAs_IdolListMessage(output);
        }

        public function serializeAs_IdolListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.chosenIdols.length);
            var _i1:uint;
            while (_i1 < this.chosenIdols.length)
            {
                if (this.chosenIdols[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.chosenIdols[_i1]) + ") on element 1 (starting at 1) of chosenIdols.")));
                };
                output.writeVarShort(this.chosenIdols[_i1]);
                _i1++;
            };
            output.writeShort(this.partyChosenIdols.length);
            var _i2:uint;
            while (_i2 < this.partyChosenIdols.length)
            {
                if (this.partyChosenIdols[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.partyChosenIdols[_i2]) + ") on element 2 (starting at 1) of partyChosenIdols.")));
                };
                output.writeVarShort(this.partyChosenIdols[_i2]);
                _i2++;
            };
            output.writeShort(this.partyIdols.length);
            var _i3:uint;
            while (_i3 < this.partyIdols.length)
            {
                output.writeShort((this.partyIdols[_i3] as PartyIdol).getTypeId());
                (this.partyIdols[_i3] as PartyIdol).serialize(output);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IdolListMessage(input);
        }

        public function deserializeAs_IdolListMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _val2:uint;
            var _id3:uint;
            var _item3:PartyIdol;
            var _chosenIdolsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _chosenIdolsLen)
            {
                _val1 = input.readVarUhShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of chosenIdols.")));
                };
                this.chosenIdols.push(_val1);
                _i1++;
            };
            var _partyChosenIdolsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _partyChosenIdolsLen)
            {
                _val2 = input.readVarUhShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of partyChosenIdols.")));
                };
                this.partyChosenIdols.push(_val2);
                _i2++;
            };
            var _partyIdolsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _partyIdolsLen)
            {
                _id3 = input.readUnsignedShort();
                _item3 = ProtocolTypeManager.getInstance(PartyIdol, _id3);
                _item3.deserialize(input);
                this.partyIdols.push(_item3);
                _i3++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_IdolListMessage(tree);
        }

        public function deserializeAsyncAs_IdolListMessage(tree:FuncTree):void
        {
            this._chosenIdolstree = tree.addChild(this._chosenIdolstreeFunc);
            this._partyChosenIdolstree = tree.addChild(this._partyChosenIdolstreeFunc);
            this._partyIdolstree = tree.addChild(this._partyIdolstreeFunc);
        }

        private function _chosenIdolstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._chosenIdolstree.addChild(this._chosenIdolsFunc);
                i++;
            };
        }

        private function _chosenIdolsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of chosenIdols.")));
            };
            this.chosenIdols.push(_val);
        }

        private function _partyChosenIdolstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._partyChosenIdolstree.addChild(this._partyChosenIdolsFunc);
                i++;
            };
        }

        private function _partyChosenIdolsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of partyChosenIdols.")));
            };
            this.partyChosenIdols.push(_val);
        }

        private function _partyIdolstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._partyIdolstree.addChild(this._partyIdolsFunc);
                i++;
            };
        }

        private function _partyIdolsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:PartyIdol = ProtocolTypeManager.getInstance(PartyIdol, _id);
            _item.deserialize(input);
            this.partyIdols.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.idol

