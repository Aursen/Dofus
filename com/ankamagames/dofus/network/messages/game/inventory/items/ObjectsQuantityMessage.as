package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemQuantity;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ObjectsQuantityMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6206;

        private var _isInitialized:Boolean = false;
        public var objectsUIDAndQty:Vector.<ObjectItemQuantity> = new Vector.<ObjectItemQuantity>();
        private var _objectsUIDAndQtytree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6206);
        }

        public function initObjectsQuantityMessage(objectsUIDAndQty:Vector.<ObjectItemQuantity>=null):ObjectsQuantityMessage
        {
            this.objectsUIDAndQty = objectsUIDAndQty;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectsUIDAndQty = new Vector.<ObjectItemQuantity>();
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
            this.serializeAs_ObjectsQuantityMessage(output);
        }

        public function serializeAs_ObjectsQuantityMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.objectsUIDAndQty.length);
            var _i1:uint;
            while (_i1 < this.objectsUIDAndQty.length)
            {
                (this.objectsUIDAndQty[_i1] as ObjectItemQuantity).serializeAs_ObjectItemQuantity(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectsQuantityMessage(input);
        }

        public function deserializeAs_ObjectsQuantityMessage(input:ICustomDataInput):void
        {
            var _item1:ObjectItemQuantity;
            var _objectsUIDAndQtyLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectsUIDAndQtyLen)
            {
                _item1 = new ObjectItemQuantity();
                _item1.deserialize(input);
                this.objectsUIDAndQty.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ObjectsQuantityMessage(tree);
        }

        public function deserializeAsyncAs_ObjectsQuantityMessage(tree:FuncTree):void
        {
            this._objectsUIDAndQtytree = tree.addChild(this._objectsUIDAndQtytreeFunc);
        }

        private function _objectsUIDAndQtytreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._objectsUIDAndQtytree.addChild(this._objectsUIDAndQtyFunc);
                i++;
            };
        }

        private function _objectsUIDAndQtyFunc(input:ICustomDataInput):void
        {
            var _item:ObjectItemQuantity = new ObjectItemQuantity();
            _item.deserialize(input);
            this.objectsUIDAndQty.push(_item);
        }


    }
}

