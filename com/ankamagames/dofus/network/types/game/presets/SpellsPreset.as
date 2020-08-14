package com.ankamagames.dofus.network.types.game.presets
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class SpellsPreset extends Preset implements INetworkType 
    {

        public static const protocolId:uint = 519;

        public var spells:Vector.<SpellForPreset> = new Vector.<SpellForPreset>();
        private var _spellstree:FuncTree;


        override public function getTypeId():uint
        {
            return (519);
        }

        public function initSpellsPreset(id:int=0, spells:Vector.<SpellForPreset>=null):SpellsPreset
        {
            super.initPreset(id);
            this.spells = spells;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.spells = new Vector.<SpellForPreset>();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_SpellsPreset(output);
        }

        public function serializeAs_SpellsPreset(output:ICustomDataOutput):void
        {
            super.serializeAs_Preset(output);
            output.writeShort(this.spells.length);
            var _i1:uint;
            while (_i1 < this.spells.length)
            {
                (this.spells[_i1] as SpellForPreset).serializeAs_SpellForPreset(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SpellsPreset(input);
        }

        public function deserializeAs_SpellsPreset(input:ICustomDataInput):void
        {
            var _item1:SpellForPreset;
            super.deserialize(input);
            var _spellsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _spellsLen)
            {
                _item1 = new SpellForPreset();
                _item1.deserialize(input);
                this.spells.push(_item1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_SpellsPreset(tree);
        }

        public function deserializeAsyncAs_SpellsPreset(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._spellstree = tree.addChild(this._spellstreeFunc);
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
            var _item:SpellForPreset = new SpellForPreset();
            _item.deserialize(input);
            this.spells.push(_item);
        }


    }
} com.ankamagames.dofus.network.types.game.presets

