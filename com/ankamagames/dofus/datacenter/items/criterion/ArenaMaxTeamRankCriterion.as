package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;

    public class ArenaMaxTeamRankCriterion extends ItemCriterion implements IDataCenter 
    {

        public function ArenaMaxTeamRankCriterion(pCriterion:String)
        {
            super(pCriterion);
        }

        override public function get text():String
        {
            var readableCriterionValue:String = String(_criterionValue);
            var readableCriterionRef:String = I18n.getUiText("ui.common.pvpMaxTeamRank");
            var readableOperator:String = ">";
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                readableOperator = (I18n.getUiText("ui.common.differentFrom") + " >");
            };
            return ((((readableCriterionRef + " ") + readableOperator) + " ") + readableCriterionValue);
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:ArenaMaxTeamRankCriterion = new ArenaMaxTeamRankCriterion(this.basicText);
            return (clonedCriterion);
        }

        override protected function getCriterion():int
        {
            var frame:PartyManagementFrame = (Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame);
            var maxRank:int;
            if (((frame.arenaRankGroupInfos) && (frame.arenaRankGroupInfos.maxRank > maxRank)))
            {
                maxRank = frame.arenaRankGroupInfos.maxRank;
            };
            return (maxRank);
        }


    }
}

