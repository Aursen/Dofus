package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
    import com.ankamagames.dofus.datacenter.quest.Achievement;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;

    public class AchievementAccountItemCriterion extends ItemCriterion implements IDataCenter 
    {

        public function AchievementAccountItemCriterion(pCriterion:String)
        {
            super(pCriterion);
        }

        override public function get isRespected():Boolean
        {
            var serverType:int = PlayerManager.getInstance().server.gameTypeId;
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                if (((this.getCriterion() == 0) || (serverType == GameServerTypeEnum.SERVER_TYPE_EPIC)))
                {
                    return (true);
                };
                return (false);
            };
            if (this.getCriterion() == 1)
            {
                return (true);
            };
            return (false);
        }

        override public function get text():String
        {
            var readableValue:* = ((" '" + Achievement.getAchievementById(_criterionValue).name) + "'");
            var readableCriterion:String = I18n.getUiText("ui.tooltip.unlockAchievement", [readableValue]);
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                readableCriterion = I18n.getUiText("ui.tooltip.dontUnlockAchievement", [readableValue]);
            };
            return (readableCriterion);
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:AchievementAccountItemCriterion = new AchievementAccountItemCriterion(this.basicText);
            return (clonedCriterion);
        }

        override protected function getCriterion():int
        {
            var ach:AchievementAchieved;
            var achievementFinishedList:Vector.<AchievementAchieved> = (Kernel.getWorker().getFrame(QuestFrame) as QuestFrame).finishedAchievements;
            var characterId:Number = PlayedCharacterManager.getInstance().id;
            for each (ach in achievementFinishedList)
            {
                if (((ach.id == _criterionValue) && (!(ach.achievedBy == characterId))))
                {
                    return (1);
                };
            };
            return (0);
        }


    }
}
