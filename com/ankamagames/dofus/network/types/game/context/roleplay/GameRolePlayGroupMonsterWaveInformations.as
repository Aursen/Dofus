package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class GameRolePlayGroupMonsterWaveInformations extends GameRolePlayGroupMonsterInformations implements INetworkType 
    {

        public static const protocolId:uint = 464;

        public var nbWaves:uint = 0;
        public var alternatives:Vector.<GroupMonsterStaticInformations> = new Vector.<GroupMonsterStaticInformations>();
        private var _alternativestree:FuncTree;


        override public function getTypeId():uint
        {
            return (464);
        }

        public function initGameRolePlayGroupMonsterWaveInformations(contextualId:Number=0, disposition:EntityDispositionInformations=null, look:EntityLook=null, staticInfos:GroupMonsterStaticInformations=null, lootShare:int=0, alignmentSide:int=0, keyRingBonus:Boolean=false, hasHardcoreDrop:Boolean=false, hasAVARewardToken:Boolean=false, nbWaves:uint=0, alternatives:Vector.<GroupMonsterStaticInformations>=null):GameRolePlayGroupMonsterWaveInformations
        {
            super.initGameRolePlayGroupMonsterInformations(contextualId, disposition, look, staticInfos, lootShare, alignmentSide, keyRingBonus, hasHardcoreDrop, hasAVARewardToken);
            this.nbWaves = nbWaves;
            this.alternatives = alternatives;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.nbWaves = 0;
            this.alternatives = new Vector.<GroupMonsterStaticInformations>();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayGroupMonsterWaveInformations(output);
        }

        public function serializeAs_GameRolePlayGroupMonsterWaveInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameRolePlayGroupMonsterInformations(output);
            if (this.nbWaves < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbWaves) + ") on element nbWaves.")));
            };
            output.writeByte(this.nbWaves);
            output.writeShort(this.alternatives.length);
            var _i2:uint;
            while (_i2 < this.alternatives.length)
            {
                output.writeShort((this.alternatives[_i2] as GroupMonsterStaticInformations).getTypeId());
                (this.alternatives[_i2] as GroupMonsterStaticInformations).serialize(output);
                _i2++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayGroupMonsterWaveInformations(input);
        }

        public function deserializeAs_GameRolePlayGroupMonsterWaveInformations(input:ICustomDataInput):void
        {
            var _id2:uint;
            var _item2:GroupMonsterStaticInformations;
            super.deserialize(input);
            this._nbWavesFunc(input);
            var _alternativesLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _alternativesLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(GroupMonsterStaticInformations, _id2);
                _item2.deserialize(input);
                this.alternatives.push(_item2);
                _i2++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameRolePlayGroupMonsterWaveInformations(tree);
        }

        public function deserializeAsyncAs_GameRolePlayGroupMonsterWaveInformations(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            tree.addChild(this._nbWavesFunc);
            this._alternativestree = tree.addChild(this._alternativestreeFunc);
        }

        private function _nbWavesFunc(input:ICustomDataInput):void
        {
            this.nbWaves = input.readByte();
            if (this.nbWaves < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbWaves) + ") on element of GameRolePlayGroupMonsterWaveInformations.nbWaves.")));
            };
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
            var _id:uint = input.readUnsignedShort();
            var _item:GroupMonsterStaticInformations = ProtocolTypeManager.getInstance(GroupMonsterStaticInformations, _id);
            _item.deserialize(input);
            this.alternatives.push(_item);
        }


    }
} com.ankamagames.dofus.network.types.game.context.roleplay

