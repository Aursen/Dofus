package com.ankamagames.dofus.network.types.game.presets
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class SpellForPreset implements INetworkType 
    {

        public static const protocolId:uint = 557;

        public var spellId:uint = 0;
        public var shortcuts:Vector.<int> = new Vector.<int>();
        private var _shortcutstree:FuncTree;


        public function getTypeId():uint
        {
            return (557);
        }

        public function initSpellForPreset(spellId:uint=0, shortcuts:Vector.<int>=null):SpellForPreset
        {
            this.spellId = spellId;
            this.shortcuts = shortcuts;
            return (this);
        }

        public function reset():void
        {
            this.spellId = 0;
            this.shortcuts = new Vector.<int>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_SpellForPreset(output);
        }

        public function serializeAs_SpellForPreset(output:ICustomDataOutput):void
        {
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element spellId.")));
            };
            output.writeVarShort(this.spellId);
            output.writeShort(this.shortcuts.length);
            var _i2:uint;
            while (_i2 < this.shortcuts.length)
            {
                output.writeShort(this.shortcuts[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SpellForPreset(input);
        }

        public function deserializeAs_SpellForPreset(input:ICustomDataInput):void
        {
            var _val2:int;
            this._spellIdFunc(input);
            var _shortcutsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _shortcutsLen)
            {
                _val2 = input.readShort();
                this.shortcuts.push(_val2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_SpellForPreset(tree);
        }

        public function deserializeAsyncAs_SpellForPreset(tree:FuncTree):void
        {
            tree.addChild(this._spellIdFunc);
            this._shortcutstree = tree.addChild(this._shortcutstreeFunc);
        }

        private function _spellIdFunc(input:ICustomDataInput):void
        {
            this.spellId = input.readVarUhShort();
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element of SpellForPreset.spellId.")));
            };
        }

        private function _shortcutstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._shortcutstree.addChild(this._shortcutsFunc);
                i++;
            };
        }

        private function _shortcutsFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readShort();
            this.shortcuts.push(_val);
        }


    }
}

