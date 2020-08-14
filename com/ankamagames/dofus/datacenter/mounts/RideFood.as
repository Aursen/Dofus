package com.ankamagames.dofus.datacenter.mounts
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class RideFood implements IDataCenter 
    {

        public static var MODULE:String = "RideFood";
        public static var idAccessors:IdAccessors = new IdAccessors(null, getRideFoods);

        public var gid:uint;
        public var typeId:uint;
        public var familyId:uint;


        public static function getRideFoods():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
} com.ankamagames.dofus.datacenter.mounts

