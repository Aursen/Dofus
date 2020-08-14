package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;

    public class LevelItemCriterion extends ItemCriterion implements IDataCenter 
    {

        public function LevelItemCriterion(pCriterion:String)
        {
            super(pCriterion);
        }

        override public function get text():String
        {
            var readableCriterionValue:String = _criterionValue.toString();
            var readableCriterionRef:String = I18n.getUiText("ui.common.level");
            if (_operator.text === ItemCriterionOperator.SUPERIOR)
            {
                return (I18n.getUiText("ui.common.minimumLevelCondition", [(_criterionValue + 1).toString()]));
            };
            if (_operator.text === ItemCriterionOperator.INFERIOR)
            {
                return (I18n.getUiText("ui.common.maximumLevelCondition", [(_criterionValue - 1).toString()]));
            };
            return ((((readableCriterionRef + " ") + _operator.text) + " ") + readableCriterionValue);
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:LevelItemCriterion = new LevelItemCriterion(this.basicText);
            return (clonedCriterion);
        }

        override protected function getCriterion():int
        {
            return (PlayedCharacterManager.getInstance().limitedLevel);
        }


    }
} com.ankamagames.dofus.datacenter.items.criterion

