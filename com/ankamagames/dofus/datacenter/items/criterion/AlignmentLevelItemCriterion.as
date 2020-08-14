package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.types.game.character.alignment.ActorExtendedAlignmentInformations;

    public class AlignmentLevelItemCriterion extends ItemCriterion implements IDataCenter 
    {

        public function AlignmentLevelItemCriterion(pCriterion:String)
        {
            super(pCriterion);
        }

        override public function get text():String
        {
            var readableCriterionRef:String = I18n.getUiText("ui.tooltip.AlignmentLevel");
            return ((((readableCriterionRef + " ") + _operator.text) + " ") + _criterionValue);
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:AlignmentLevelItemCriterion = new AlignmentLevelItemCriterion(this.basicText);
            return (clonedCriterion);
        }

        override protected function getCriterion():int
        {
            var alignInfo:ActorExtendedAlignmentInformations = PlayedCharacterManager.getInstance().characteristics.alignmentInfos;
            return (alignInfo.alignmentValue);
        }


    }
} com.ankamagames.dofus.datacenter.items.criterion

