package com.ankamagames.dofus.network.messages.game.dare
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

    public class DareWonListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 0x1A1A;

        private var _isInitialized:Boolean = false;
        public var dareId:Vector.<Number> = new Vector.<Number>();
        private var _dareIdtree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (0x1A1A);
        }

        public function initDareWonListMessage(dareId:Vector.<Number>=null):DareWonListMessage
        {
            this.dareId = dareId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dareId = new Vector.<Number>();
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
            this.serializeAs_DareWonListMessage(output);
        }

        public function serializeAs_DareWonListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.dareId.length);
            var _i1:uint;
            while (_i1 < this.dareId.length)
            {
                if (((this.dareId[_i1] < 0) || (this.dareId[_i1] > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + this.dareId[_i1]) + ") on element 1 (starting at 1) of dareId.")));
                };
                output.writeDouble(this.dareId[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DareWonListMessage(input);
        }

        public function deserializeAs_DareWonListMessage(input:ICustomDataInput):void
        {
            var _val1:Number;
            var _dareIdLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _dareIdLen)
            {
                _val1 = input.readDouble();
                if (((_val1 < 0) || (_val1 > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of dareId.")));
                };
                this.dareId.push(_val1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_DareWonListMessage(tree);
        }

        public function deserializeAsyncAs_DareWonListMessage(tree:FuncTree):void
        {
            this._dareIdtree = tree.addChild(this._dareIdtreeFunc);
        }

        private function _dareIdtreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._dareIdtree.addChild(this._dareIdFunc);
                i++;
            };
        }

        private function _dareIdFunc(input:ICustomDataInput):void
        {
            var _val:Number = input.readDouble();
            if (((_val < 0) || (_val > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of dareId.")));
            };
            this.dareId.push(_val);
        }


    }
}

