package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class MapReference implements IDataCenter 
    {

        public static const MODULE:String = "MapReferences";
        public static var idAccessors:IdAccessors = new IdAccessors(getMapReferenceById, getAllMapReference);

        public var id:int;
        public var mapId:Number;
        public var cellId:int;


        public static function getMapReferenceById(id:Number):MapReference
        {
            return (GameData.getObject(MODULE, id) as MapReference);
        }

        public static function getAllMapReference():Array
        {
            return (GameData.getObjects(MODULE) as Array);
        }


    }
}

