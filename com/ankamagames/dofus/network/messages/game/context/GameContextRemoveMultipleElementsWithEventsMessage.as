package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GameContextRemoveMultipleElementsWithEventsMessage extends GameContextRemoveMultipleElementsMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6416;

        private var _isInitialized:Boolean = false;
        public var elementEventIds:Vector.<uint> = new Vector.<uint>();
        private var _elementEventIdstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (6416);
        }

        public function initGameContextRemoveMultipleElementsWithEventsMessage(elementsIds:Vector.<Number>=null, elementEventIds:Vector.<uint>=null):GameContextRemoveMultipleElementsWithEventsMessage
        {
            super.initGameContextRemoveMultipleElementsMessage(elementsIds);
            this.elementEventIds = elementEventIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.elementEventIds = new Vector.<uint>();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameContextRemoveMultipleElementsWithEventsMessage(output);
        }

        public function serializeAs_GameContextRemoveMultipleElementsWithEventsMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GameContextRemoveMultipleElementsMessage(output);
            output.writeShort(this.elementEventIds.length);
            var _i1:uint;
            while (_i1 < this.elementEventIds.length)
            {
                if (this.elementEventIds[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.elementEventIds[_i1]) + ") on element 1 (starting at 1) of elementEventIds.")));
                };
                output.writeByte(this.elementEventIds[_i1]);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameContextRemoveMultipleElementsWithEventsMessage(input);
        }

        public function deserializeAs_GameContextRemoveMultipleElementsWithEventsMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            super.deserialize(input);
            var _elementEventIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _elementEventIdsLen)
            {
                _val1 = input.readByte();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of elementEventIds.")));
                };
                this.elementEventIds.push(_val1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameContextRemoveMultipleElementsWithEventsMessage(tree);
        }

        public function deserializeAsyncAs_GameContextRemoveMultipleElementsWithEventsMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._elementEventIdstree = tree.addChild(this._elementEventIdstreeFunc);
        }

        private function _elementEventIdstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._elementEventIdstree.addChild(this._elementEventIdsFunc);
                i++;
            };
        }

        private function _elementEventIdsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readByte();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of elementEventIds.")));
            };
            this.elementEventIds.push(_val);
        }


    }
} com.ankamagames.dofus.network.messages.game.context

