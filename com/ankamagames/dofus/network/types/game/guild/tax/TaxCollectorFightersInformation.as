package com.ankamagames.dofus.network.types.game.guild.tax
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class TaxCollectorFightersInformation implements INetworkType 
    {

        public static const protocolId:uint = 169;

        public var collectorId:Number = 0;
        public var allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = new Vector.<CharacterMinimalPlusLookInformations>();
        public var enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = new Vector.<CharacterMinimalPlusLookInformations>();
        private var _allyCharactersInformationstree:FuncTree;
        private var _enemyCharactersInformationstree:FuncTree;


        public function getTypeId():uint
        {
            return (169);
        }

        public function initTaxCollectorFightersInformation(collectorId:Number=0, allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>=null, enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>=null):TaxCollectorFightersInformation
        {
            this.collectorId = collectorId;
            this.allyCharactersInformations = allyCharactersInformations;
            this.enemyCharactersInformations = enemyCharactersInformations;
            return (this);
        }

        public function reset():void
        {
            this.collectorId = 0;
            this.allyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
            this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_TaxCollectorFightersInformation(output);
        }

        public function serializeAs_TaxCollectorFightersInformation(output:ICustomDataOutput):void
        {
            if (((this.collectorId < 0) || (this.collectorId > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.collectorId) + ") on element collectorId.")));
            };
            output.writeDouble(this.collectorId);
            output.writeShort(this.allyCharactersInformations.length);
            var _i2:uint;
            while (_i2 < this.allyCharactersInformations.length)
            {
                output.writeShort((this.allyCharactersInformations[_i2] as CharacterMinimalPlusLookInformations).getTypeId());
                (this.allyCharactersInformations[_i2] as CharacterMinimalPlusLookInformations).serialize(output);
                _i2++;
            };
            output.writeShort(this.enemyCharactersInformations.length);
            var _i3:uint;
            while (_i3 < this.enemyCharactersInformations.length)
            {
                output.writeShort((this.enemyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).getTypeId());
                (this.enemyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).serialize(output);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TaxCollectorFightersInformation(input);
        }

        public function deserializeAs_TaxCollectorFightersInformation(input:ICustomDataInput):void
        {
            var _id2:uint;
            var _item2:CharacterMinimalPlusLookInformations;
            var _id3:uint;
            var _item3:CharacterMinimalPlusLookInformations;
            this._collectorIdFunc(input);
            var _allyCharactersInformationsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _allyCharactersInformationsLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations, _id2);
                _item2.deserialize(input);
                this.allyCharactersInformations.push(_item2);
                _i2++;
            };
            var _enemyCharactersInformationsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _enemyCharactersInformationsLen)
            {
                _id3 = input.readUnsignedShort();
                _item3 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations, _id3);
                _item3.deserialize(input);
                this.enemyCharactersInformations.push(_item3);
                _i3++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_TaxCollectorFightersInformation(tree);
        }

        public function deserializeAsyncAs_TaxCollectorFightersInformation(tree:FuncTree):void
        {
            tree.addChild(this._collectorIdFunc);
            this._allyCharactersInformationstree = tree.addChild(this._allyCharactersInformationstreeFunc);
            this._enemyCharactersInformationstree = tree.addChild(this._enemyCharactersInformationstreeFunc);
        }

        private function _collectorIdFunc(input:ICustomDataInput):void
        {
            this.collectorId = input.readDouble();
            if (((this.collectorId < 0) || (this.collectorId > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.collectorId) + ") on element of TaxCollectorFightersInformation.collectorId.")));
            };
        }

        private function _allyCharactersInformationstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._allyCharactersInformationstree.addChild(this._allyCharactersInformationsFunc);
                i++;
            };
        }

        private function _allyCharactersInformationsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:CharacterMinimalPlusLookInformations = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations, _id);
            _item.deserialize(input);
            this.allyCharactersInformations.push(_item);
        }

        private function _enemyCharactersInformationstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._enemyCharactersInformationstree.addChild(this._enemyCharactersInformationsFunc);
                i++;
            };
        }

        private function _enemyCharactersInformationsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:CharacterMinimalPlusLookInformations = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations, _id);
            _item.deserialize(input);
            this.enemyCharactersInformations.push(_item);
        }


    }
} com.ankamagames.dofus.network.types.game.guild.tax

