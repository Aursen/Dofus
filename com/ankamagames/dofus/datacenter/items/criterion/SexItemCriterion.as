package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;

    public class SexItemCriterion extends ItemCriterion implements IDataCenter 
    {

        public function SexItemCriterion(pCriterion:String)
        {
            super(pCriterion);
        }

        override public function get text():String
        {
            if (_criterionValue == 1)
            {
                return (I18n.getUiText("ui.tooltip.beFemale"));
            };
            return (I18n.getUiText("ui.tooltip.beMale"));
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:SexItemCriterion = new SexItemCriterion(this.basicText);
            return (clonedCriterion);
        }

        override protected function getCriterion():int
        {
            return (int(PlayedCharacterManager.getInstance().infos.sex));
        }


    }
}

