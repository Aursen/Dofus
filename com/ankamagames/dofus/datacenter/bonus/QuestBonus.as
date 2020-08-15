package com.ankamagames.dofus.datacenter.bonus
{
    import com.ankamagames.dofus.datacenter.bonus.criterion.BonusCriterion;
    import com.ankamagames.dofus.datacenter.bonus.criterion.BonusQuestCategoryCriterion;

    public class QuestBonus extends Bonus 
    {


        override public function isRespected(... pArgs):Boolean
        {
            var criterionId:int;
            var criterion:BonusCriterion;
            for each (criterionId in criterionsIds)
            {
                criterion = BonusCriterion.getBonusCriterionById(criterionId);
                if ((((pArgs.length > 0) && (criterion is BonusQuestCategoryCriterion)) && (criterion.value == pArgs[0])))
                {
                    return (true);
                };
            };
            return (false);
        }


    }
}

