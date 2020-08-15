package com.ankamagames.dofus.network.types.game.prism
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.fight.ProtectedEntityWaitingForHelpInfo;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class PrismFightersInformation implements INetworkType 
    {

        public static const protocolId:uint = 443;

        public var subAreaId:uint = 0;
        public var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
        public var allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = new Vector.<CharacterMinimalPlusLookInformations>();
        public var enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = new Vector.<CharacterMinimalPlusLookInformations>();
        private var _waitingForHelpInfotree:FuncTree;
        private var _allyCharactersInformationstree:FuncTree;
        private var _enemyCharactersInformationstree:FuncTree;


        public function getTypeId():uint
        {
            return (443);
        }

        public function initPrismFightersInformation(subAreaId:uint=0, waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo=null, allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>=null, enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>=null):PrismFightersInformation
        {
            this.subAreaId = subAreaId;
            this.waitingForHelpInfo = waitingForHelpInfo;
            this.allyCharactersInformations = allyCharactersInformations;
            this.enemyCharactersInformations = enemyCharactersInformations;
            return (this);
        }

        public function reset():void
        {
            this.subAreaId = 0;
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PrismFightersInformation(output);
        }

        public function serializeAs_PrismFightersInformation(output:ICustomDataOutput):void
        {
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeVarShort(this.subAreaId);
            this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(output);
            output.writeShort(this.allyCharactersInformations.length);
            var _i3:uint;
            while (_i3 < this.allyCharactersInformations.length)
            {
                output.writeShort((this.allyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).getTypeId());
                (this.allyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).serialize(output);
                _i3++;
            };
            output.writeShort(this.enemyCharactersInformations.length);
            var _i4:uint;
            while (_i4 < this.enemyCharactersInformations.length)
            {
                output.writeShort((this.enemyCharactersInformations[_i4] as CharacterMinimalPlusLookInformations).getTypeId());
                (this.enemyCharactersInformations[_i4] as CharacterMinimalPlusLookInformations).serialize(output);
                _i4++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismFightersInformation(input);
        }

        public function deserializeAs_PrismFightersInformation(input:ICustomDataInput):void
        {
            var _id3:uint;
            var _item3:CharacterMinimalPlusLookInformations;
            var _id4:uint;
            var _item4:CharacterMinimalPlusLookInformations;
            this._subAreaIdFunc(input);
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            this.waitingForHelpInfo.deserialize(input);
            var _allyCharactersInformationsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _allyCharactersInformationsLen)
            {
                _id3 = input.readUnsignedShort();
                _item3 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations, _id3);
                _item3.deserialize(input);
                this.allyCharactersInformations.push(_item3);
                _i3++;
            };
            var _enemyCharactersInformationsLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _enemyCharactersInformationsLen)
            {
                _id4 = input.readUnsignedShort();
                _item4 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations, _id4);
                _item4.deserialize(input);
                this.enemyCharactersInformations.push(_item4);
                _i4++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_PrismFightersInformation(tree);
        }

        public function deserializeAsyncAs_PrismFightersInformation(tree:FuncTree):void
        {
            tree.addChild(this._subAreaIdFunc);
            this._waitingForHelpInfotree = tree.addChild(this._waitingForHelpInfotreeFunc);
            this._allyCharactersInformationstree = tree.addChild(this._allyCharactersInformationstreeFunc);
            this._enemyCharactersInformationstree = tree.addChild(this._enemyCharactersInformationstreeFunc);
        }

        private function _subAreaIdFunc(input:ICustomDataInput):void
        {
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PrismFightersInformation.subAreaId.")));
            };
        }

        private function _waitingForHelpInfotreeFunc(input:ICustomDataInput):void
        {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            this.waitingForHelpInfo.deserializeAsync(this._waitingForHelpInfotree);
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
}

