package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;

    public class AchievementPointsItemCriterion extends ItemCriterion implements IDataCenter 
    {

        public function AchievementPointsItemCriterion(pCriterion:String)
        {
            super(pCriterion);
        }

        override public function get text():String
        {
            var readableCriterionValue:String = String(_criterionValue);
            var readableCriterionRef:String = I18n.getUiText("ui.achievement.successPointsText");
            var readableOperator:String = ">";
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                readableOperator = (I18n.getUiText("ui.common.differentFrom") + " >");
            };
            return ((((readableCriterionRef + " ") + readableOperator) + " ") + readableCriterionValue);
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:AchievementPointsItemCriterion = new AchievementPointsItemCriterion(this.basicText);
            return (clonedCriterion);
        }

        override protected function getCriterion():int
        {
            var achievementPoints:int = PlayedCharacterManager.getInstance().achievementPoints;
            return (achievementPoints);
        }


    }
} com.ankamagames.dofus.datacenter.items.criterion

