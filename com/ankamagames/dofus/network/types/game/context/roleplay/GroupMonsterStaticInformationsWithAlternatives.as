package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GroupMonsterStaticInformationsWithAlternatives extends GroupMonsterStaticInformations implements INetworkType 
    {

        public static const protocolId:uint = 396;

        public var alternatives:Vector.<AlternativeMonstersInGroupLightInformations> = new Vector.<AlternativeMonstersInGroupLightInformations>();
        private var _alternativestree:FuncTree;


        override public function getTypeId():uint
        {
            return (396);
        }

        public function initGroupMonsterStaticInformationsWithAlternatives(mainCreatureLightInfos:MonsterInGroupLightInformations=null, underlings:Vector.<MonsterInGroupInformations>=null, alternatives:Vector.<AlternativeMonstersInGroupLightInformations>=null):GroupMonsterStaticInformationsWithAlternatives
        {
            super.initGroupMonsterStaticInformations(mainCreatureLightInfos, underlings);
            this.alternatives = alternatives;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.alternatives = new Vector.<AlternativeMonstersInGroupLightInformations>();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GroupMonsterStaticInformationsWithAlternatives(output);
        }

        public function serializeAs_GroupMonsterStaticInformationsWithAlternatives(output:ICustomDataOutput):void
        {
            super.serializeAs_GroupMonsterStaticInformations(output);
            output.writeShort(this.alternatives.length);
            var _i1:uint;
            while (_i1 < this.alternatives.length)
            {
                (this.alternatives[_i1] as AlternativeMonstersInGroupLightInformations).serializeAs_AlternativeMonstersInGroupLightInformations(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GroupMonsterStaticInformationsWithAlternatives(input);
        }

        public function deserializeAs_GroupMonsterStaticInformationsWithAlternatives(input:ICustomDataInput):void
        {
            var _item1:AlternativeMonstersInGroupLightInformations;
            super.deserialize(input);
            var _alternativesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _alternativesLen)
            {
                _item1 = new AlternativeMonstersInGroupLightInformations();
                _item1.deserialize(input);
                this.alternatives.push(_item1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GroupMonsterStaticInformationsWithAlternatives(tree);
        }

        public function deserializeAsyncAs_GroupMonsterStaticInformationsWithAlternatives(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._alternativestree = tree.addChild(this._alternativestreeFunc);
        }

        private function _alternativestreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._alternativestree.addChild(this._alternativesFunc);
                i++;
            };
        }

        private function _alternativesFunc(input:ICustomDataInput):void
        {
            var _item:AlternativeMonstersInGroupLightInformations = new AlternativeMonstersInGroupLightInformations();
            _item.deserialize(input);
            this.alternatives.push(_item);
        }


    }
}

