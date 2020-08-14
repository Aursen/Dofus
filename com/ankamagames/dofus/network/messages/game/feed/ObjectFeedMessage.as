package com.ankamagames.dofus.network.messages.game.feed
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

    public class ObjectFeedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6290;

        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;
        public var meal:Vector.<ObjectItemQuantity> = new Vector.<ObjectItemQuantity>();
        private var _mealtree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6290);
        }

        public function initObjectFeedMessage(objectUID:uint=0, meal:Vector.<ObjectItemQuantity>=null):ObjectFeedMessage
        {
            this.objectUID = objectUID;
            this.meal = meal;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectUID = 0;
            this.meal = new Vector.<ObjectItemQuantity>();
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
            this.serializeAs_ObjectFeedMessage(output);
        }

        public function serializeAs_ObjectFeedMessage(output:ICustomDataOutput):void
        {
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element objectUID.")));
            };
            output.writeVarInt(this.objectUID);
            output.writeShort(this.meal.length);
            var _i2:uint;
            while (_i2 < this.meal.length)
            {
                (this.meal[_i2] as ObjectItemQuantity).serializeAs_ObjectItemQuantity(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectFeedMessage(input);
        }

        public function deserializeAs_ObjectFeedMessage(input:ICustomDataInput):void
        {
            var _item2:ObjectItemQuantity;
            this._objectUIDFunc(input);
            var _mealLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _mealLen)
            {
                _item2 = new ObjectItemQuantity();
                _item2.deserialize(input);
                this.meal.push(_item2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ObjectFeedMessage(tree);
        }

        public function deserializeAsyncAs_ObjectFeedMessage(tree:FuncTree):void
        {
            tree.addChild(this._objectUIDFunc);
            this._mealtree = tree.addChild(this._mealtreeFunc);
        }

        private function _objectUIDFunc(input:ICustomDataInput):void
        {
            this.objectUID = input.readVarUhInt();
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element of ObjectFeedMessage.objectUID.")));
            };
        }

        private function _mealtreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._mealtree.addChild(this._mealFunc);
                i++;
            };
        }

        private function _mealFunc(input:ICustomDataInput):void
        {
            var _item:ObjectItemQuantity = new ObjectItemQuantity();
            _item.deserialize(input);
            this.meal.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.feed

