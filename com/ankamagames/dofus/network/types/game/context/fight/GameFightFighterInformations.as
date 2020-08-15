package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class GameFightFighterInformations extends GameContextActorInformations implements INetworkType 
    {

        public static const protocolId:uint = 143;

        public var spawnInfo:GameContextBasicSpawnInformation = new GameContextBasicSpawnInformation();
        public var wave:uint = 0;
        public var stats:GameFightMinimalStats = new GameFightMinimalStats();
        public var previousPositions:Vector.<uint> = new Vector.<uint>();
        private var _spawnInfotree:FuncTree;
        private var _statstree:FuncTree;
        private var _previousPositionstree:FuncTree;


        override public function getTypeId():uint
        {
            return (143);
        }

        public function initGameFightFighterInformations(contextualId:Number=0, disposition:EntityDispositionInformations=null, look:EntityLook=null, spawnInfo:GameContextBasicSpawnInformation=null, wave:uint=0, stats:GameFightMinimalStats=null, previousPositions:Vector.<uint>=null):GameFightFighterInformations
        {
            super.initGameContextActorInformations(contextualId, disposition, look);
            this.spawnInfo = spawnInfo;
            this.wave = wave;
            this.stats = stats;
            this.previousPositions = previousPositions;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.spawnInfo = new GameContextBasicSpawnInformation();
            this.stats = new GameFightMinimalStats();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightFighterInformations(output);
        }

        public function serializeAs_GameFightFighterInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameContextActorInformations(output);
            this.spawnInfo.serializeAs_GameContextBasicSpawnInformation(output);
            if (this.wave < 0)
            {
                throw (new Error((("Forbidden value (" + this.wave) + ") on element wave.")));
            };
            output.writeByte(this.wave);
            output.writeShort(this.stats.getTypeId());
            this.stats.serialize(output);
            output.writeShort(this.previousPositions.length);
            var _i4:uint;
            while (_i4 < this.previousPositions.length)
            {
                if (((this.previousPositions[_i4] < 0) || (this.previousPositions[_i4] > 559)))
                {
                    throw (new Error((("Forbidden value (" + this.previousPositions[_i4]) + ") on element 4 (starting at 1) of previousPositions.")));
                };
                output.writeVarShort(this.previousPositions[_i4]);
                _i4++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightFighterInformations(input);
        }

        public function deserializeAs_GameFightFighterInformations(input:ICustomDataInput):void
        {
            var _val4:uint;
            super.deserialize(input);
            this.spawnInfo = new GameContextBasicSpawnInformation();
            this.spawnInfo.deserialize(input);
            this._waveFunc(input);
            var _id3:uint = input.readUnsignedShort();
            this.stats = ProtocolTypeManager.getInstance(GameFightMinimalStats, _id3);
            this.stats.deserialize(input);
            var _previousPositionsLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _previousPositionsLen)
            {
                _val4 = input.readVarUhShort();
                if (((_val4 < 0) || (_val4 > 559)))
                {
                    throw (new Error((("Forbidden value (" + _val4) + ") on elements of previousPositions.")));
                };
                this.previousPositions.push(_val4);
                _i4++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameFightFighterInformations(tree);
        }

        public function deserializeAsyncAs_GameFightFighterInformations(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._spawnInfotree = tree.addChild(this._spawnInfotreeFunc);
            tree.addChild(this._waveFunc);
            this._statstree = tree.addChild(this._statstreeFunc);
            this._previousPositionstree = tree.addChild(this._previousPositionstreeFunc);
        }

        private function _spawnInfotreeFunc(input:ICustomDataInput):void
        {
            this.spawnInfo = new GameContextBasicSpawnInformation();
            this.spawnInfo.deserializeAsync(this._spawnInfotree);
        }

        private function _waveFunc(input:ICustomDataInput):void
        {
            this.wave = input.readByte();
            if (this.wave < 0)
            {
                throw (new Error((("Forbidden value (" + this.wave) + ") on element of GameFightFighterInformations.wave.")));
            };
        }

        private function _statstreeFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            this.stats = ProtocolTypeManager.getInstance(GameFightMinimalStats, _id);
            this.stats.deserializeAsync(this._statstree);
        }

        private function _previousPositionstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._previousPositionstree.addChild(this._previousPositionsFunc);
                i++;
            };
        }

        private function _previousPositionsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (((_val < 0) || (_val > 559)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of previousPositions.")));
            };
            this.previousPositions.push(_val);
        }


    }
}

