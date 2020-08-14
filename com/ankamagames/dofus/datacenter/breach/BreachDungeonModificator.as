package com.ankamagames.dofus.datacenter.breach
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class BreachDungeonModificator implements IDataCenter 
    {

        public static const MODULE:String = "BreachDungeonModificators";
        public static var idAccessors:IdAccessors = new IdAccessors(getBreachDungeonModificatorByModificatorId, getAllBreachDungeonModificators);

        public var id:uint;
        public var modificatorId:uint;
        public var criterion:String;
        public var additionalRewardPercent:Number;
        public var score:Number;
        public var isPositiveForPlayers:Boolean;
        public var tooltipBaseline:String;


        public static function getBreachDungeonModificatorByModificatorId(modificatorId:uint):BreachDungeonModificator
        {
            return (GameData.getObject(MODULE, modificatorId) as BreachDungeonModificator);
        }

        public static function getAllBreachDungeonModificators():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
} com.ankamagames.dofus.datacenter.breach

