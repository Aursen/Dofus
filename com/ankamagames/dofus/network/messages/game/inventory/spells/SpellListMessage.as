package com.ankamagames.dofus.network.messages.game.inventory.spells
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.SpellItem;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class SpellListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1200;

        private var _isInitialized:Boolean = false;
        public var spellPrevisualization:Boolean = false;
        public var spells:Vector.<SpellItem> = new Vector.<SpellItem>();
        private var _spellstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (1200);
        }

        public function initSpellListMessage(spellPrevisualization:Boolean=false, spells:Vector.<SpellItem>=null):SpellListMessage
        {
            this.spellPrevisualization = spellPrevisualization;
            this.spells = spells;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.spellPrevisualization = false;
            this.spells = new Vector.<SpellItem>();
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
            this.serializeAs_SpellListMessage(output);
        }

        public function serializeAs_SpellListMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.spellPrevisualization);
            output.writeShort(this.spells.length);
            var _i2:uint;
            while (_i2 < this.spells.length)
            {
                (this.spells[_i2] as SpellItem).serializeAs_SpellItem(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SpellListMessage(input);
        }

        public function deserializeAs_SpellListMessage(input:ICustomDataInput):void
        {
            var _item2:SpellItem;
            this._spellPrevisualizationFunc(input);
            var _spellsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _spellsLen)
            {
                _item2 = new SpellItem();
                _item2.deserialize(input);
                this.spells.push(_item2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_SpellListMessage(tree);
        }

        public function deserializeAsyncAs_SpellListMessage(tree:FuncTree):void
        {
            tree.addChild(this._spellPrevisualizationFunc);
            this._spellstree = tree.addChild(this._spellstreeFunc);
        }

        private function _spellPrevisualizationFunc(input:ICustomDataInput):void
        {
            this.spellPrevisualization = input.readBoolean();
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
            var _item:SpellItem = new SpellItem();
            _item.deserialize(input);
            this.spells.push(_item);
        }


    }
}

