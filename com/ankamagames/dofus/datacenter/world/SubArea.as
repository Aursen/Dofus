package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.IPostInit;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.ambientSounds.AmbientSound;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class SubArea implements IDataCenter, IPostInit 
    {

        public static const MODULE:String = "SubAreas";
        private static var _allSubAreas:Array;
        public static var idAccessors:IdAccessors = new IdAccessors(getSubAreaById, getAllSubArea);

        public var id:int;
        public var nameId:uint;
        public var areaId:int;
        public var ambientSounds:Vector.<AmbientSound>;
        public var playlists:Vector.<Vector.<int>>;
        public var mapIds:Vector.<Number>;
        public var bounds:Rectangle;
        public var shape:Vector.<int>;
        public var customWorldMap:Vector.<uint>;
        public var packId:int;
        public var level:uint;
        public var isConquestVillage:Boolean;
        public var basicAccountAllowed:Boolean;
        public var displayOnWorldMap:Boolean;
        public var mountAutoTripAllowed:Boolean;
        public var psiAllowed:Boolean;
        public var monsters:Vector.<uint>;
        public var entranceMapIds:Vector.<Number>;
        public var exitMapIds:Vector.<Number>;
        public var capturable:Boolean;
        public var achievements:Vector.<uint>;
        public var quests:Vector.<Vector.<Number>>;
        public var npcs:Vector.<Vector.<Number>>;
        public var exploreAchievementId:int;
        public var isDiscovered:Boolean;
        public var harvestables:Vector.<int>;
        public var associatedZaapMapId:int;
        private var _name:String;
        private var _undiatricalName:String;
        private var _area:Area;
        private var _worldMap:WorldMap;
        private var _center:Point;
        private var _zaapMapCoord:MapPosition;


        public static function getSubAreaById(id:int):SubArea
        {
            var subArea:SubArea = (GameData.getObject(MODULE, id) as SubArea);
            if (((!(subArea)) || (!(subArea.area))))
            {
                return (null);
            };
            return (subArea);
        }

        public static function getSubAreaByMapId(mapId:Number):SubArea
        {
            var mp:MapPosition = MapPosition.getMapPositionById(mapId);
            if (mp)
            {
                return (mp.subArea);
            };
            return (null);
        }

        public static function getAllSubArea():Array
        {
            if (_allSubAreas)
            {
                return (_allSubAreas);
            };
            _allSubAreas = (GameData.getObjects(MODULE) as Array);
            return (_allSubAreas);
        }


        public function get name():String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }

        public function get undiatricalName():String
        {
            if (!this._undiatricalName)
            {
                this._undiatricalName = I18n.getUnDiacriticalText(this.nameId);
            };
            return (this._undiatricalName);
        }

        public function get area():Area
        {
            if (!this._area)
            {
                this._area = Area.getAreaById(this.areaId);
            };
            return (this._area);
        }

        public function get worldmap():WorldMap
        {
            if (!this._worldMap)
            {
                if (this.hasCustomWorldMap)
                {
                    this._worldMap = WorldMap.getWorldMapById(this.customWorldMap[0]);
                }
                else
                {
                    this._worldMap = this.area.worldmap;
                };
            };
            return (this._worldMap);
        }

        public function get hasCustomWorldMap():Boolean
        {
            return ((this.customWorldMap) && (this.customWorldMap.length > 0));
        }

        public function get center():Point
        {
            var minX:int;
            var maxX:int;
            var minY:int;
            var maxY:int;
            var i:int;
            var posX:int;
            var posY:int;
            var nCoords:uint = this.shape.length;
            if (((!(this._center)) && (nCoords > 0)))
            {
                posX = this.shape[0];
                posY = this.shape[1];
                minX = (maxX = ((posX > 10000) ? (posX - 11000) : posX));
                minY = (maxY = ((posY > 10000) ? (posY - 11000) : posY));
                i = 2;
                while (i < nCoords)
                {
                    posX = this.shape[i];
                    posY = this.shape[(i + 1)];
                    if (posX > 10000)
                    {
                        posX = (posX - 11000);
                    };
                    if (posY > 10000)
                    {
                        posY = (posY - 11000);
                    };
                    minX = ((posX < minX) ? posX : minX);
                    maxX = ((posX > maxX) ? posX : maxX);
                    minY = ((posY < minY) ? posY : minY);
                    maxY = ((posY > maxY) ? posY : maxY);
                    i = (i + 2);
                };
                this._center = new Point(((minX + maxX) / 2), ((minY + maxY) / 2));
            };
            return (this._center);
        }

        public function get zaapMapPosition():MapPosition
        {
            if (!this._zaapMapCoord)
            {
                this._zaapMapCoord = MapPosition.getMapPositionById(this.associatedZaapMapId);
            };
            return (this._zaapMapCoord);
        }

        public function postInit():void
        {
            this.name;
            this.undiatricalName;
        }


    }
}

