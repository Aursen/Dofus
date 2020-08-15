package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class Phoenix implements IDataCenter 
    {

        public static const MODULE:String = "Phoenixes";
        public static var idAccessors:IdAccessors = new IdAccessors(null, getAllPhoenixes);

        public var mapId:Number;


        public static function getAllPhoenixes():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}

