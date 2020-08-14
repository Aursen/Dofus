package com.ankamagames.dofus.network.types.game.presets
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class FullStatsPreset extends Preset implements INetworkType 
    {

        public static const protocolId:uint = 532;

        public var stats:Vector.<CharacterCharacteristicForPreset> = new Vector.<CharacterCharacteristicForPreset>();
        private var _statstree:FuncTree;


        override public function getTypeId():uint
        {
            return (532);
        }

        public function initFullStatsPreset(id:int=0, stats:Vector.<CharacterCharacteristicForPreset>=null):FullStatsPreset
        {
            super.initPreset(id);
            this.stats = stats;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.stats = new Vector.<CharacterCharacteristicForPreset>();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FullStatsPreset(output);
        }

        public function serializeAs_FullStatsPreset(output:ICustomDataOutput):void
        {
            super.serializeAs_Preset(output);
            output.writeShort(this.stats.length);
            var _i1:uint;
            while (_i1 < this.stats.length)
            {
                (this.stats[_i1] as CharacterCharacteristicForPreset).serializeAs_CharacterCharacteristicForPreset(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FullStatsPreset(input);
        }

        public function deserializeAs_FullStatsPreset(input:ICustomDataInput):void
        {
            var _item1:CharacterCharacteristicForPreset;
            super.deserialize(input);
            var _statsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _statsLen)
            {
                _item1 = new CharacterCharacteristicForPreset();
                _item1.deserialize(input);
                this.stats.push(_item1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_FullStatsPreset(tree);
        }

        public function deserializeAsyncAs_FullStatsPreset(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._statstree = tree.addChild(this._statstreeFunc);
        }

        private function _statstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._statstree.addChild(this._statsFunc);
                i++;
            };
        }

        private function _statsFunc(input:ICustomDataInput):void
        {
            var _item:CharacterCharacteristicForPreset = new CharacterCharacteristicForPreset();
            _item.deserialize(input);
            this.stats.push(_item);
        }


    }
} com.ankamagames.dofus.network.types.game.presets

