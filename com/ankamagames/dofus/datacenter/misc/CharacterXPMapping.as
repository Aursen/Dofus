package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class CharacterXPMapping implements IDataCenter 
    {

        public static const MODULE:String = "CharacterXPMappings";
        public static var idAccessors:IdAccessors = new IdAccessors(getCharacterXPMappingById, getCharacterXPMappings);

        public var level:int;
        public var experiencePoints:Number;


        public static function getCharacterXPMappingById(level:int):CharacterXPMapping
        {
            return (GameData.getObject(MODULE, level) as CharacterXPMapping);
        }

        public static function getCharacterXPMappings():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
} com.ankamagames.dofus.datacenter.misc

