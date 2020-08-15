package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.character.alignment.ActorAlignmentInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameFightMonsterWithAlignmentInformations extends GameFightMonsterInformations implements INetworkType 
    {

        public static const protocolId:uint = 203;

        public var alignmentInfos:ActorAlignmentInformations = new ActorAlignmentInformations();
        private var _alignmentInfostree:FuncTree;


        override public function getTypeId():uint
        {
            return (203);
        }

        public function initGameFightMonsterWithAlignmentInformations(contextualId:Number=0, disposition:EntityDispositionInformations=null, look:EntityLook=null, spawnInfo:GameContextBasicSpawnInformation=null, wave:uint=0, stats:GameFightMinimalStats=null, previousPositions:Vector.<uint>=null, creatureGenericId:uint=0, creatureGrade:uint=0, creatureLevel:uint=0, alignmentInfos:ActorAlignmentInformations=null):GameFightMonsterWithAlignmentInformations
        {
            super.initGameFightMonsterInformations(contextualId, disposition, look, spawnInfo, wave, stats, previousPositions, creatureGenericId, creatureGrade, creatureLevel);
            this.alignmentInfos = alignmentInfos;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.alignmentInfos = new ActorAlignmentInformations();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightMonsterWithAlignmentInformations(output);
        }

        public function serializeAs_GameFightMonsterWithAlignmentInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightMonsterInformations(output);
            this.alignmentInfos.serializeAs_ActorAlignmentInformations(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightMonsterWithAlignmentInformations(input);
        }

        public function deserializeAs_GameFightMonsterWithAlignmentInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.alignmentInfos = new ActorAlignmentInformations();
            this.alignmentInfos.deserialize(input);
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameFightMonsterWithAlignmentInformations(tree);
        }

        public function deserializeAsyncAs_GameFightMonsterWithAlignmentInformations(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._alignmentInfostree = tree.addChild(this._alignmentInfostreeFunc);
        }

        private function _alignmentInfostreeFunc(input:ICustomDataInput):void
        {
            this.alignmentInfos = new ActorAlignmentInformations();
            this.alignmentInfos.deserializeAsync(this._alignmentInfostree);
        }


    }
}

