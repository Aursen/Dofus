package com.ankamagames.dofus.datacenter.monsters
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class MonsterMiniBoss implements IDataCenter 
    {

        public static const MODULE:String = "MonsterMiniBoss";
        public static var idAccessors:IdAccessors = new IdAccessors(getMonsterById, getMonsters);

        public var id:int;
        public var monsterReplacingId:int;


        public static function getMonsterById(id:uint):MonsterMiniBoss
        {
            return (GameData.getObject(MODULE, id) as MonsterMiniBoss);
        }

        public static function getMonsters():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}

