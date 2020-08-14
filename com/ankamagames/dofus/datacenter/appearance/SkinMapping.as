package com.ankamagames.dofus.datacenter.appearance
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class SkinMapping implements IDataCenter 
    {

        public static const MODULE:String = "SkinMappings";
        public static var idAccessors:IdAccessors = new IdAccessors(getSkinMappingById, getSkinMappings);

        public var id:int;
        public var lowDefId:int;


        public static function getSkinMappingById(id:int):SkinMapping
        {
            return (GameData.getObject(MODULE, id) as SkinMapping);
        }

        public static function getSkinMappings():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
} com.ankamagames.dofus.datacenter.appearance

