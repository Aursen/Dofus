package com.ankamagames.dofus.datacenter.interactives
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class StealthBones implements IDataCenter 
    {

        public static const MODULE:String = "StealthBones";
        public static var idAccessors:IdAccessors = new IdAccessors(getStealthBonesById, null);

        public var id:uint;


        public static function getStealthBonesById(id:int):StealthBones
        {
            return (GameData.getObject(MODULE, id) as StealthBones);
        }


    }
}

