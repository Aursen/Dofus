package com.ankamagames.dofus.datacenter.temporis
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class AchievementProgress implements IDataCenter 
    {

        public static const MODULE:String = "AchievementProgress";
        public static var idAccessors:IdAccessors = new IdAccessors(getAchievementProgressBySeasonId, getAchievementProgress);

        public var id:int;
        public var name:String;
        public var seasonId:int;


        public static function getAchievementProgressBySeasonId(id:int):AchievementProgress
        {
            return (GameData.getObject(MODULE, id) as AchievementProgress);
        }

        public static function getAchievementProgress():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
} com.ankamagames.dofus.datacenter.temporis

