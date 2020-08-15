package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class QuestActiveDetailedInformations extends QuestActiveInformations implements INetworkType 
    {

        public static const protocolId:uint = 382;

        public var stepId:uint = 0;
        public var objectives:Vector.<QuestObjectiveInformations> = new Vector.<QuestObjectiveInformations>();
        private var _objectivestree:FuncTree;


        override public function getTypeId():uint
        {
            return (382);
        }

        public function initQuestActiveDetailedInformations(questId:uint=0, stepId:uint=0, objectives:Vector.<QuestObjectiveInformations>=null):QuestActiveDetailedInformations
        {
            super.initQuestActiveInformations(questId);
            this.stepId = stepId;
            this.objectives = objectives;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.stepId = 0;
            this.objectives = new Vector.<QuestObjectiveInformations>();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_QuestActiveDetailedInformations(output);
        }

        public function serializeAs_QuestActiveDetailedInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_QuestActiveInformations(output);
            if (this.stepId < 0)
            {
                throw (new Error((("Forbidden value (" + this.stepId) + ") on element stepId.")));
            };
            output.writeVarShort(this.stepId);
            output.writeShort(this.objectives.length);
            var _i2:uint;
            while (_i2 < this.objectives.length)
            {
                output.writeShort((this.objectives[_i2] as QuestObjectiveInformations).getTypeId());
                (this.objectives[_i2] as QuestObjectiveInformations).serialize(output);
                _i2++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_QuestActiveDetailedInformations(input);
        }

        public function deserializeAs_QuestActiveDetailedInformations(input:ICustomDataInput):void
        {
            var _id2:uint;
            var _item2:QuestObjectiveInformations;
            super.deserialize(input);
            this._stepIdFunc(input);
            var _objectivesLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _objectivesLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(QuestObjectiveInformations, _id2);
                _item2.deserialize(input);
                this.objectives.push(_item2);
                _i2++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_QuestActiveDetailedInformations(tree);
        }

        public function deserializeAsyncAs_QuestActiveDetailedInformations(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            tree.addChild(this._stepIdFunc);
            this._objectivestree = tree.addChild(this._objectivestreeFunc);
        }

        private function _stepIdFunc(input:ICustomDataInput):void
        {
            this.stepId = input.readVarUhShort();
            if (this.stepId < 0)
            {
                throw (new Error((("Forbidden value (" + this.stepId) + ") on element of QuestActiveDetailedInformations.stepId.")));
            };
        }

        private function _objectivestreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._objectivestree.addChild(this._objectivesFunc);
                i++;
            };
        }

        private function _objectivesFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:QuestObjectiveInformations = ProtocolTypeManager.getInstance(QuestObjectiveInformations, _id);
            _item.deserialize(input);
            this.objectives.push(_item);
        }


    }
}

