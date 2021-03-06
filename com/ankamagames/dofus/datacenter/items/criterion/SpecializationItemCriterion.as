package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentRank;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.frames.AlignmentFrame;

    public class SpecializationItemCriterion extends ItemCriterion implements IDataCenter 
    {

        public function SpecializationItemCriterion(pCriterion:String)
        {
            super(pCriterion);
        }

        override public function get text():String
        {
            var readableCriterionValue:String = AlignmentRank.getAlignmentRankById(int(_criterionValue)).name;
            var readableCriterionRef:String = I18n.getUiText("ui.alignment.spécialization");
            var readableOperator:String = I18n.getUiText("ui.common.colon");
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                readableOperator = ((" " + I18n.getUiText("ui.common.differentFrom")) + I18n.getUiText("ui.common.colon"));
            };
            return ((readableCriterionRef + readableOperator) + readableCriterionValue);
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:SpecializationItemCriterion = new SpecializationItemCriterion(this.basicText);
            return (clonedCriterion);
        }

        override protected function getCriterion():int
        {
            return (AlignmentFrame.getInstance().playerRank);
        }


    }
}

