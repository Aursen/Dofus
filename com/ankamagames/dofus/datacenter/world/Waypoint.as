package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class Waypoint implements IDataCenter 
    {

        public static const MODULE:String = "Waypoints";

        public var id:uint;
        public var mapId:Number;
        public var subAreaId:uint;
        public var activated:Boolean;


        public static function getAllWaypoints():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
} com.ankamagames.dofus.datacenter.world

