package com.ankamagames.dofus.network.messages.game.interactive
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class InteractiveMapUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5002;

        private var _isInitialized:Boolean = false;
        public var interactiveElements:Vector.<InteractiveElement> = new Vector.<InteractiveElement>();
        private var _interactiveElementstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5002);
        }

        public function initInteractiveMapUpdateMessage(interactiveElements:Vector.<InteractiveElement>=null):InteractiveMapUpdateMessage
        {
            this.interactiveElements = interactiveElements;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.interactiveElements = new Vector.<InteractiveElement>();
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
            this.serializeAs_InteractiveMapUpdateMessage(output);
        }

        public function serializeAs_InteractiveMapUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.interactiveElements.length);
            var _i1:uint;
            while (_i1 < this.interactiveElements.length)
            {
                output.writeShort((this.interactiveElements[_i1] as InteractiveElement).getTypeId());
                (this.interactiveElements[_i1] as InteractiveElement).serialize(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_InteractiveMapUpdateMessage(input);
        }

        public function deserializeAs_InteractiveMapUpdateMessage(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:InteractiveElement;
            var _interactiveElementsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _interactiveElementsLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(InteractiveElement, _id1);
                _item1.deserialize(input);
                this.interactiveElements.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_InteractiveMapUpdateMessage(tree);
        }

        public function deserializeAsyncAs_InteractiveMapUpdateMessage(tree:FuncTree):void
        {
            this._interactiveElementstree = tree.addChild(this._interactiveElementstreeFunc);
        }

        private function _interactiveElementstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._interactiveElementstree.addChild(this._interactiveElementsFunc);
                i++;
            };
        }

        private function _interactiveElementsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:InteractiveElement = ProtocolTypeManager.getInstance(InteractiveElement, _id);
            _item.deserialize(input);
            this.interactiveElements.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.interactive

