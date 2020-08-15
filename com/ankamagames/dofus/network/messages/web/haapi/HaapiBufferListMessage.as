package com.ankamagames.dofus.network.messages.web.haapi
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.web.haapi.BufferInformation;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class HaapiBufferListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6845;

        private var _isInitialized:Boolean = false;
        public var buffers:Vector.<BufferInformation> = new Vector.<BufferInformation>();
        private var _bufferstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6845);
        }

        public function initHaapiBufferListMessage(buffers:Vector.<BufferInformation>=null):HaapiBufferListMessage
        {
            this.buffers = buffers;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.buffers = new Vector.<BufferInformation>();
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
            this.serializeAs_HaapiBufferListMessage(output);
        }

        public function serializeAs_HaapiBufferListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.buffers.length);
            var _i1:uint;
            while (_i1 < this.buffers.length)
            {
                (this.buffers[_i1] as BufferInformation).serializeAs_BufferInformation(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HaapiBufferListMessage(input);
        }

        public function deserializeAs_HaapiBufferListMessage(input:ICustomDataInput):void
        {
            var _item1:BufferInformation;
            var _buffersLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _buffersLen)
            {
                _item1 = new BufferInformation();
                _item1.deserialize(input);
                this.buffers.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_HaapiBufferListMessage(tree);
        }

        public function deserializeAsyncAs_HaapiBufferListMessage(tree:FuncTree):void
        {
            this._bufferstree = tree.addChild(this._bufferstreeFunc);
        }

        private function _bufferstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._bufferstree.addChild(this._buffersFunc);
                i++;
            };
        }

        private function _buffersFunc(input:ICustomDataInput):void
        {
            var _item:BufferInformation = new BufferInformation();
            _item.deserialize(input);
            this.buffers.push(_item);
        }


    }
}

