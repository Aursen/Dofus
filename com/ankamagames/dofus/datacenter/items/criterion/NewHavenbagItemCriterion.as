package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.datacenter.houses.HavenbagTheme;
    import com.ankamagames.jerakine.data.I18n;

    public class NewHavenbagItemCriterion extends ItemCriterion implements IDataCenter 
    {

        public function NewHavenbagItemCriterion(pCriterion:String)
        {
            super(pCriterion);
        }

        override public function get text():String
        {
            var readableCriterionRef:String;
            var havenbagTheme:String = HavenbagTheme.getTheme(_criterionValue).name;
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                readableCriterionRef = I18n.getUiText("ui.criterion.notHavenbagTheme", [havenbagTheme]);
            }
            else
            {
                readableCriterionRef = I18n.getUiText("ui.criterion.hasHavenbagTheme", [havenbagTheme]);
            };
            return (readableCriterionRef);
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:NewHavenbagItemCriterion = new NewHavenbagItemCriterion(this.basicText);
            return (clonedCriterion);
        }


    }
}

