package com.ankamagames.dofus.datacenter.feature.criterion
{
    import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.datacenter.items.criterion.IItemCriterion;
    import com.ankamagames.dofus.datacenter.items.criterion.ItemCriterion;
    import com.ankamagames.dofus.datacenter.items.criterion.*;

    public class GroupFeatureCriterion extends GroupItemCriterion 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GroupFeatureCriterion));

        public function GroupFeatureCriterion(criteria:String)
        {
            super(criteria);
        }

        override public function get isRespected():Boolean
        {
            var criterion:IItemCriterion;
            if (((!(_criteria)) || (_criteria.length == 0)))
            {
                return (true);
            };
            if ((((!(_criteria === null)) && (_criteria.length === 1)) && (_criteria[0] is ItemCriterion)))
            {
                return ((_criteria[0] as ItemCriterion).isRespected);
            };
            if (((_operators.length > 0) && (_operators[0] == "|")))
            {
                for each (criterion in _criteria)
                {
                    if (criterion.isRespected)
                    {
                        return (true);
                    };
                };
                return (false);
            };
            for each (criterion in _criteria)
            {
                if (!criterion.isRespected)
                {
                    return (false);
                };
            };
            return (true);
        }


    }
}

