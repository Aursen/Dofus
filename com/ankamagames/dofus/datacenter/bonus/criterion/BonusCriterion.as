package com.ankamagames.dofus.datacenter.bonus.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class BonusCriterion implements IDataCenter 
    {

        public static const MODULE:String = "BonusesCriterions";
        public static var idAccessors:IdAccessors = new IdAccessors(getBonusCriterionById, null);

        public var id:int;
        public var type:uint;
        public var value:int;


        public static function getBonusCriterionById(id:int):BonusCriterion
        {
            return (GameData.getObject(MODULE, id) as BonusCriterion);
        }


    }
} com.ankamagames.dofus.datacenter.bonus.criterion

