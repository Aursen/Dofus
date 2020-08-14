package com.ankamagames.dofus.internalDatacenter.house
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.Uri;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.types.game.house.HouseOnMapInformations;
    import com.ankamagames.dofus.network.types.game.house.HouseInstanceInformations;
    import com.ankamagames.dofus.datacenter.houses.House;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.network.types.game.house.HouseInformations;
    import com.ankamagames.dofus.network.types.game.house.HouseInformationsInside;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.datacenter.world.Area;
    import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;

    public class HouseWrapper implements IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HouseWrapper));

        public var houseId:Number;
        public var modelId:uint;
        public var name:String;
        public var description:String;
        public var iconUri:Uri;
        public var houseInstances:Array;
        public var defaultPrice:uint;
        public var worldX:int;
        public var worldY:int;
        public var mapId:Number;
        public var subAreaId:uint;
        public var subareaName:String;
        public var worldmapId:uint;


        public static function create(houseInformations:HouseInformations):HouseWrapper
        {
            var instancesIdByOwner:Dictionary;
            var houseInformationsOnMap:HouseOnMapInformations;
            var houseInstanceInfo:HouseInstanceInformations;
            var indexOfThisInstanceForTheOwner:int;
            var house:HouseWrapper = new (HouseWrapper)();
            house.houseId = houseInformations.houseId;
            house.modelId = houseInformations.modelId;
            var houseInfo:House = House.getGuildHouseById(houseInformations.modelId);
            house.name = houseInfo.name;
            house.description = houseInfo.description;
            house.defaultPrice = houseInfo.defaultPrice;
            house.iconUri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/houses/").concat(houseInfo.gfxId).concat(".png"));
            house.houseInstances = new Array();
            if ((houseInformations is HouseOnMapInformations))
            {
                instancesIdByOwner = new Dictionary();
                houseInformationsOnMap = (houseInformations as HouseOnMapInformations);
                for each (houseInstanceInfo in houseInformationsOnMap.houseInstances)
                {
                    if (houseInstanceInfo.ownerName == "?")
                    {
                    }
                    else
                    {
                        if (!instancesIdByOwner[houseInstanceInfo.ownerName])
                        {
                            instancesIdByOwner[houseInstanceInfo.ownerName] = new Array();
                        };
                        instancesIdByOwner[houseInstanceInfo.ownerName].push(houseInstanceInfo.instanceId);
                        instancesIdByOwner[houseInstanceInfo.ownerName].sort(Array.NUMERIC);
                    };
                };
                for each (houseInstanceInfo in houseInformationsOnMap.houseInstances)
                {
                    indexOfThisInstanceForTheOwner = -1;
                    if (((!(houseInstanceInfo.ownerName == "?")) && (instancesIdByOwner[houseInstanceInfo.ownerName].length > 1)))
                    {
                        indexOfThisInstanceForTheOwner = instancesIdByOwner[houseInstanceInfo.ownerName].indexOf(houseInstanceInfo.instanceId);
                    };
                    house.houseInstances.push(HouseInstanceWrapper.create(houseInstanceInfo, indexOfThisInstanceForTheOwner));
                };
            };
            house.houseInstances.sortOn(["isMine", "belongsToMyGuild", "label"], [Array.DESCENDING, Array.DESCENDING, Array.CASEINSENSITIVE]);
            return (house);
        }

        public static function createInside(houseInside:HouseInformationsInside):HouseWrapper
        {
            var house:HouseWrapper = new (HouseWrapper)();
            house.houseId = houseInside.houseId;
            house.modelId = houseInside.modelId;
            var houseInfo:House = House.getGuildHouseById(houseInside.modelId);
            house.name = houseInfo.name;
            house.description = houseInfo.description;
            house.defaultPrice = houseInfo.defaultPrice;
            house.iconUri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/houses/").concat(houseInfo.gfxId).concat(".png"));
            house.houseInstances = new Array();
            var houseInstance:HouseInstanceWrapper = HouseInstanceWrapper.createInside(houseInside);
            house.houseInstances.push(houseInstance);
            return (house);
        }

        public static function createOwned(houseOwned:AccountHouseInformations):HouseWrapper
        {
            var house:HouseWrapper = new (HouseWrapper)();
            house.houseId = houseOwned.houseId;
            house.modelId = houseOwned.modelId;
            house.worldX = houseOwned.worldX;
            house.worldY = houseOwned.worldY;
            house.mapId = houseOwned.mapId;
            house.subAreaId = houseOwned.subAreaId;
            var houseInfo:House = House.getGuildHouseById(houseOwned.modelId);
            house.name = houseInfo.name;
            house.description = houseInfo.description;
            house.defaultPrice = houseInfo.defaultPrice;
            house.iconUri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/houses/").concat(houseInfo.gfxId).concat(".png"));
            var subarea:SubArea = SubArea.getSubAreaById(houseOwned.subAreaId);
            var area:Area = Area.getAreaById(subarea.areaId);
            house.subareaName = (((area.name + " ( ") + subarea.name) + " )");
            house.worldmapId = area.worldmap.id;
            house.houseInstances = new Array();
            var houseInstance:HouseInstanceWrapper = HouseInstanceWrapper.createOwned(houseOwned);
            house.houseInstances.push(houseInstance);
            return (house);
        }


    }
} com.ankamagames.dofus.internalDatacenter.house

