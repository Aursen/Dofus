package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.datacenter.mounts.Mount;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.internalDatacenter.mount.MountData;

    public class RideItemCriterion extends ItemCriterion implements IDataCenter 
    {

        public function RideItemCriterion(pCriterion:String)
        {
            super(pCriterion);
        }

        override public function get text():String
        {
            var readableCriterion:String;
            var mountModel:Mount = Mount.getMountById(_criterionValue);
            if (((_criterionValue == 0) || (!(mountModel))))
            {
                return ("");
            };
            if (_operator.text == ItemCriterionOperator.EQUAL)
            {
                readableCriterion = I18n.getUiText("ui.tooltip.mountEquiped", [mountModel.name]);
            }
            else
            {
                if (_operator.text == ItemCriterionOperator.DIFFERENT)
                {
                    readableCriterion = I18n.getUiText("ui.tooltip.mountNonEquiped", [mountModel.name]);
                };
            };
            return (readableCriterion);
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:RideItemCriterion = new RideItemCriterion(this.basicText);
            return (clonedCriterion);
        }

        override protected function getCriterion():int
        {
            var mountId:int;
            var mount:MountData = PlayedCharacterManager.getInstance().mount;
            if (((mount) && (PlayedCharacterManager.getInstance().isRidding)))
            {
                mountId = mount.modelId;
            };
            return (mountId);
        }


    }
} com.ankamagames.dofus.datacenter.items.criterion

