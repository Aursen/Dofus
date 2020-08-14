package com.ankamagames.dofus.network.messages.game.character.spell.forgettable
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ForgettableSpellItem;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ForgettableSpellListUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6868;

        private var _isInitialized:Boolean = false;
        public var action:uint = 0;
        public var spells:Vector.<ForgettableSpellItem> = new Vector.<ForgettableSpellItem>();
        private var _spellstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6868);
        }

        public function initForgettableSpellListUpdateMessage(action:uint=0, spells:Vector.<ForgettableSpellItem>=null):ForgettableSpellListUpdateMessage
        {
            this.action = action;
            this.spells = spells;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.action = 0;
            this.spells = new Vector.<ForgettableSpellItem>();
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
            this.serializeAs_ForgettableSpellListUpdateMessage(output);
        }

        public function serializeAs_ForgettableSpellListUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.action);
            output.writeShort(this.spells.length);
            var _i2:uint;
            while (_i2 < this.spells.length)
            {
                (this.spells[_i2] as ForgettableSpellItem).serializeAs_ForgettableSpellItem(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ForgettableSpellListUpdateMessage(input);
        }

        public function deserializeAs_ForgettableSpellListUpdateMessage(input:ICustomDataInput):void
        {
            var _item2:ForgettableSpellItem;
            this._actionFunc(input);
            var _spellsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _spellsLen)
            {
                _item2 = new ForgettableSpellItem();
                _item2.deserialize(input);
                this.spells.push(_item2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ForgettableSpellListUpdateMessage(tree);
        }

        public function deserializeAsyncAs_ForgettableSpellListUpdateMessage(tree:FuncTree):void
        {
            tree.addChild(this._actionFunc);
            this._spellstree = tree.addChild(this._spellstreeFunc);
        }

        private function _actionFunc(input:ICustomDataInput):void
        {
            this.action = input.readByte();
            if (this.action < 0)
            {
                throw (new Error((("Forbidden value (" + this.action) + ") on element of ForgettableSpellListUpdateMessage.action.")));
            };
        }

        private function _spellstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._spellstree.addChild(this._spellsFunc);
                i++;
            };
        }

        private function _spellsFunc(input:ICustomDataInput):void
        {
            var _item:ForgettableSpellItem = new ForgettableSpellItem();
            _item.deserialize(input);
            this.spells.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.character.spell.forgettable

