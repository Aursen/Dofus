package com.ankamagames.dofus.network.types.game.presets
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ForgettableSpellsPreset extends Preset implements INetworkType 
    {

        public static const protocolId:uint = 584;

        public var baseSpellsPreset:SpellsPreset = new SpellsPreset();
        public var forgettableSpells:Vector.<SpellForPreset> = new Vector.<SpellForPreset>();
        private var _baseSpellsPresettree:FuncTree;
        private var _forgettableSpellstree:FuncTree;


        override public function getTypeId():uint
        {
            return (584);
        }

        public function initForgettableSpellsPreset(id:int=0, baseSpellsPreset:SpellsPreset=null, forgettableSpells:Vector.<SpellForPreset>=null):ForgettableSpellsPreset
        {
            super.initPreset(id);
            this.baseSpellsPreset = baseSpellsPreset;
            this.forgettableSpells = forgettableSpells;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.baseSpellsPreset = new SpellsPreset();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ForgettableSpellsPreset(output);
        }

        public function serializeAs_ForgettableSpellsPreset(output:ICustomDataOutput):void
        {
            super.serializeAs_Preset(output);
            this.baseSpellsPreset.serializeAs_SpellsPreset(output);
            output.writeShort(this.forgettableSpells.length);
            var _i2:uint;
            while (_i2 < this.forgettableSpells.length)
            {
                (this.forgettableSpells[_i2] as SpellForPreset).serializeAs_SpellForPreset(output);
                _i2++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ForgettableSpellsPreset(input);
        }

        public function deserializeAs_ForgettableSpellsPreset(input:ICustomDataInput):void
        {
            var _item2:SpellForPreset;
            super.deserialize(input);
            this.baseSpellsPreset = new SpellsPreset();
            this.baseSpellsPreset.deserialize(input);
            var _forgettableSpellsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _forgettableSpellsLen)
            {
                _item2 = new SpellForPreset();
                _item2.deserialize(input);
                this.forgettableSpells.push(_item2);
                _i2++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ForgettableSpellsPreset(tree);
        }

        public function deserializeAsyncAs_ForgettableSpellsPreset(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._baseSpellsPresettree = tree.addChild(this._baseSpellsPresettreeFunc);
            this._forgettableSpellstree = tree.addChild(this._forgettableSpellstreeFunc);
        }

        private function _baseSpellsPresettreeFunc(input:ICustomDataInput):void
        {
            this.baseSpellsPreset = new SpellsPreset();
            this.baseSpellsPreset.deserializeAsync(this._baseSpellsPresettree);
        }

        private function _forgettableSpellstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._forgettableSpellstree.addChild(this._forgettableSpellsFunc);
                i++;
            };
        }

        private function _forgettableSpellsFunc(input:ICustomDataInput):void
        {
            var _item:SpellForPreset = new SpellForPreset();
            _item.deserialize(input);
            this.forgettableSpells.push(_item);
        }


    }
} com.ankamagames.dofus.network.types.game.presets

