package Ankama_Cartography.ui
{
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.dofus.uiApi.BreachApi;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.dofus.datacenter.world.WorldMap;
    import Ankama_Cartography.ui.type.AreaGroup;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import flash.geom.Point;
    import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
    import d2enums.ComponentHookList;
    import d2hooks.SubareaList;
    import d2hooks.GuildInformationsFarms;
    import d2hooks.GuildHousesUpdate;
    import d2hooks.TaxCollectorListUpdate;
    import d2hooks.MapHintsFilter;
    import d2hooks.GuildPaddockAdd;
    import d2hooks.GuildPaddockRemoved;
    import d2hooks.GuildTaxCollectorAdd;
    import d2hooks.GuildTaxCollectorRemoved;
    import d2hooks.GuildHouseAdd;
    import d2hooks.GuildHouseRemoved;
    import d2hooks.RemoveMapFlag;
    import d2hooks.PrismsList;
    import d2hooks.PrismsListUpdate;
    import d2hooks.FocusChange;
    import d2hooks.MouseShiftClick;
    import d2hooks.HouseInformations;
    import d2hooks.GuildMembershipUpdated;
    import d2hooks.AnomalyState;
    import d2actions.PlaySound;
    import com.ankamagames.dofus.types.enums.HintPriorityEnum;
    import d2actions.PrismsListRegister;
    import com.ankamagames.dofus.network.enums.PrismListenEnum;
    import com.ankamagames.dofus.datacenter.world.SuperArea;
    import com.ankamagames.dofus.datacenter.world.Hint;
    import Ankama_Cartography.ui.type.Flag;
    import flash.geom.Rectangle;
    import d2actions.GuildGetInformations;
    import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
    import Ankama_Cartography.ui.type.AreaInfo;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import com.ankamagames.dofus.network.enums.PrismStateEnum;
    import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
    import com.ankamagames.dofus.datacenter.world.HintCategory;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildHouseWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
    import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.types.game.context.roleplay.AnomalySubareaInformation;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import d2hooks.OpenDareSearch;
    import com.ankamagames.dofus.datacenter.breach.BreachWorldMapCoordinate;

    public class CartographyBase extends AbstractCartographyUi 
    {

        public static const MODE_MOVE:String = "move";
        public static const MODE_FLAG:String = "flag";
        public static const DEBUG_SHORTCUTS:Boolean = false;
        protected static const ALL_AREAS:String = "AllAreas";
        protected static const NO_PRISM_AREAS:String = "noPrismAreas";
        protected static const NORMAL_AREAS:String = "normalAreas";
        protected static const WEAKENED_AREAS:String = "weakenedAreas";
        protected static const VULNERABLE_AREAS:String = "vulnerableAreas";
        protected static const VILLAGES_AREAS:String = "villagesAreas";
        protected static const CAPTURABLE_AREAS:String = "capturableAreas";
        protected static const SABOTAGED_AREAS:String = "sabotagedAreas";
        protected static const BONUS_AREAS:String = "bonusAreas";
        protected static const MALUS_AREAS:String = "malusAreas";
        protected static const BONUS_DUNGEONS:String = "bonusDungeons";
        protected static const MALUS_DUNGEONS:String = "malusDungeons";
        protected static const ANOMALY_AREAS:String = "anomalyAreas";
        protected static const PLAYER_POSITION_LAYER:String = "playerPositionLayer";
        protected static const MOUNT_TRIP_LAYER:String = "mountTripLayer";
        protected static const MAP_LAYER_CLASS_TEMPLES:String = "layer_1";
        protected static const MAP_LAYER_BIDHOUSES:String = "layer_2";
        protected static const MAP_LAYER_CRAFT_HOUSES:String = "layer_3";
        protected static const MAP_LAYER_MISC:String = "layer_4";
        protected static const MAP_LAYER_PRISMS:String = "layer_5";
        protected static const MAP_LAYER_DUNGEONS:String = "layer_6";
        protected static const MAP_LAYER_PRIVATE:String = "layer_7";
        protected static const MAP_LAYER_FLAGS:String = "layer_8";
        protected static const MAP_LAYER_TRANSPORTS:String = "layer_9";
        protected static const MAP_LAYER_ANOMALIES:String = "layer_10";
        protected static const MAP_LAYER_BREACH:String = "layer_12";
        protected static const MAP_LAYER_BREACH_HIGHLIGHT:String = "layer_11";
        protected static const MAP_FILTERS:String = "mapFilters";
        private static const MAP_PRESET_DATA_NAME:String = "mapPresets";
        protected static const WORLD_MAP:int = 1;
        protected static const WORLD_OF_INCARNAM:int = 2;
        protected static const DEPTHS_OF_SUFOKIA:int = 17;
        public static const MAP_TYPE_SUPERAREA:uint = 0;
        public static const MAP_TYPE_SUBAREA:uint = 1;

        protected var gridDisplayed:Boolean = false;
        protected var breachMinStage:uint = 50;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="BreachApi")]
        public var breachApi:BreachApi;
        protected var __mapMode:String = "move";
        protected var __iconScale:Number;
        protected var __playerPos:WorldPointWrapper;
        protected var __startWorldMapInfo:WorldMap;
        protected var __worldMapInfo:Object;
        protected var __hintCategoryFiltersList:Array = [];
        protected var __layersToShow:Array;
        protected var __allAreas:AreaGroup;
        protected var __capturableAreas:AreaGroup;
        protected var __sabotagedAreas:AreaGroup;
        protected var __noPrismAreas:AreaGroup;
        protected var __normalAreas:AreaGroup;
        protected var __weakenedAreas:AreaGroup;
        protected var __vulnerableAreas:AreaGroup;
        protected var __allRewardAreas:AreaGroup;
        protected var __bonusDungeon:AreaGroup;
        protected var __malusDungeon:AreaGroup;
        protected var __bonusAreas:AreaGroup;
        protected var __malusAreas:AreaGroup;
        protected var __anomalyAreas:AreaGroup;
        protected var __subAreaList:Array;
        protected var __switchingMapUi:Boolean;
        protected var __lastSubArea:SubArea;
        protected var __subAreaTooltipPosition:Point = new Point();
        protected var __displaySubAreaToolTip:Boolean = true;
        protected var __animatedPlayerPosition:Boolean = true;
        private var _flags:Object;
        private var _currentSubarea:SubArea;
        protected var _textCss:String;
        private var _waitingForSocialUpdate:int;
        private var _mapChanged:Boolean;
        private var _myAlliance:AllianceWrapper;
        private var _lastWorldId:int = -1;
        private var _lastMapId:Number = -1;
        private var _mapPreset:Array = [];
        protected var __hintIconsRootPath:String;
        protected var __centerOnPlayer:Boolean;


        override public function main(params:Object=null):void
        {
            super.main(params);
            this.__hintIconsRootPath = (sysApi.getConfigEntry("config.gfx.path") + "icons/hintsShadow/");
            this.__switchingMapUi = params.switchingMapUi;
            uiApi.addComponentHook(mapViewer, ComponentHookList.ON_RELEASE);
            sysApi.addHook(SubareaList, this.onAreaListInformation);
            sysApi.addHook(GuildInformationsFarms, this.onGuildInformationsFarms);
            sysApi.addHook(GuildHousesUpdate, this.onGuildHousesUpdate);
            sysApi.addHook(TaxCollectorListUpdate, this.onTaxCollectorListUpdate);
            sysApi.addHook(MapHintsFilter, this.onMapHintsFilter);
            sysApi.addHook(GuildPaddockAdd, this.onGuildPaddockAdd);
            sysApi.addHook(GuildPaddockRemoved, this.onGuildPaddockRemoved);
            sysApi.addHook(GuildTaxCollectorAdd, this.onGuildTaxCollectorAdd);
            sysApi.addHook(GuildTaxCollectorRemoved, this.onGuildTaxCollectorRemoved);
            sysApi.addHook(GuildHouseAdd, this.onGuildHouseAdd);
            sysApi.addHook(GuildHouseRemoved, this.onGuildHouseRemoved);
            sysApi.addHook(RemoveMapFlag, this.onRemoveMapFlag);
            sysApi.addHook(PrismsList, this.onPrismsListInformation);
            sysApi.addHook(PrismsListUpdate, this.onPrismsInfoUpdate);
            sysApi.addHook(FocusChange, this.onFocusChange);
            sysApi.addHook(MouseShiftClick, this.onMouseShiftClick);
            sysApi.addHook(HouseInformations, this.onHouseInformations);
            sysApi.addHook(GuildMembershipUpdated, this.onGuildMembershipUpdated);
            sysApi.addHook(AnomalyState, this.onAnomalyState);
            this._textCss = (uiApi.me().getConstant("css") + "normal.css");
            this.__playerPos = params.currentMap;
            this._flags = params.flags;
            var subArea:SubArea = ((sysApi.getPlayerManager().isMapInHavenbag(this.playerApi.currentMap().mapId)) ? this.playerApi.previousSubArea() : this.playerApi.currentSubArea());
            if (!subArea.hasCustomWorldMap)
            {
                this.__startWorldMapInfo = subArea.area.superArea.worldmap;
            }
            else
            {
                this.__startWorldMapInfo = subArea.worldmap;
            };
            var mapPresets:Array = this.getMapPresetsData();
            if (mapPresets)
            {
                this.setMapPresets(mapPresets);
            };
            this.openPlayerCurrentMap();
        }

        public function addFlag(flagId:String, flagLegend:String, x:int, y:int, color:int=-1, playSound:Boolean=true, needMapUpdate:Boolean=true, canBeManuallyRemoved:Boolean=true, allowDuplicate:Boolean=false):void
        {
            var uri:String;
            var flag:Object;
            if (playSound)
            {
                sysApi.sendAction(new PlaySound("16039"));
            };
            var layer:String = MAP_LAYER_FLAGS;
            var priority:uint = HintPriorityEnum.FLAGS;
            switch (flagId)
            {
                case "flag_playerPosition":
                    uri = ((this.__animatedPlayerPosition) ? (sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|myPosition") : (this.__hintIconsRootPath + "character.png"));
                    layer = PLAYER_POSITION_LAYER;
                    priority = HintPriorityEnum.PLAYER;
                    break;
                case "Phoenix":
                    uri = (this.__hintIconsRootPath + "phoenix.png");
                    break;
                default:
                    uri = (this.__hintIconsRootPath + "flag.png");
            };
            if (((this.playerApi.isInBreach()) || ((this.playerApi.currentSubArea().id == 904) && (flagId == "flag_playerPosition"))))
            {
                flag = mapViewer.addBreachIcon(layer, flagId, uri, x, y, (this.__iconScale * 0.25), flagLegend, false, color, true, priority);
            }
            else
            {
                flag = mapViewer.addIcon(layer, flagId, uri, x, y, this.__iconScale, flagLegend, true, color, true, canBeManuallyRemoved, null, true, allowDuplicate, priority);
            };
            if (((flag) && (needMapUpdate)))
            {
                this.updateMap();
            };
        }

        public function updateFlag(flagId:String, x:int, y:int, legend:String):Boolean
        {
            return (mapViewer.updateOneMapElement(flagId, x, y, legend));
        }

        override public function unload():void
        {
            super.unload();
            if (!sysApi.getOption("cacheMapEnabled", "dofus"))
            {
                _currentWorldId = -1;
            };
            this.saveMapFilters(this.__hintCategoryFiltersList, MAP_FILTERS);
            this.saveCurrentMapPreset();
            sysApi.sendAction(new PrismsListRegister("cartography.Cartography", PrismListenEnum.PRISM_LISTEN_NONE));
        }

        public function openNewMap(worldmapInfo:Object, mode:uint, areaInfo:Object, forceReload:Boolean=false):Boolean
        {
            var zoom:String;
            var i:int;
            var nbZooms:int;
            var z:Number;
            if (((!(forceReload)) && (worldmapInfo.id == _currentWorldId)))
            {
                return (false);
            };
            switch (mode)
            {
                case MAP_TYPE_SUPERAREA:
                    this._currentSubarea = null;
                    _currentSuperarea = (areaInfo as SuperArea);
                    break;
                case MAP_TYPE_SUBAREA:
                    this._currentSubarea = (areaInfo as SubArea);
                    _currentSuperarea = areaInfo.area.superArea;
                    break;
            };
            var id:uint = (((!(this._currentSubarea == null)) && (this._currentSubarea.customWorldMap.length > 0)) ? this._currentSubarea.customWorldMap[0] : worldmapInfo.id);
            if (((!(_currentWorldId == 0)) && (!(id == _currentWorldId))))
            {
                this._flags = modCartography.getFlags(id);
            };
            this._mapChanged = ((!(this._lastWorldId == -1)) && (!(id == this._lastWorldId)));
            this._lastWorldId = (_currentWorldId = id);
            this.__worldMapInfo = worldmapInfo;
            mapViewer.origineX = worldmapInfo.origineX;
            mapViewer.origineY = worldmapInfo.origineY;
            mapViewer.mapWidth = worldmapInfo.mapWidth;
            mapViewer.mapHeight = worldmapInfo.mapHeight;
            mapViewer.minScale = worldmapInfo.minScale;
            mapViewer.maxScale = worldmapInfo.maxScale;
            if (this.getMapPresets()[_currentWorldId])
            {
                mapViewer.startScale = this.getPresetScale();
            }
            else
            {
                mapViewer.startScale = worldmapInfo.startScale;
            };
            var folder:* = ((sysApi.getConfigEntry("config.gfx.path.maps") + id) + "/");
            mapViewer.removeAllMap();
            for each (zoom in worldmapInfo.zoom)
            {
                z = parseFloat(zoom);
                mapViewer.addMap(z, ((folder + zoom) + "/"), worldmapInfo.totalWidth, worldmapInfo.totalHeight, 250, 250);
            };
            mapViewer.startScale = Number(mapViewer.startScale.toFixed(2));
            nbZooms = mapViewer.zoomLevels.length;
            if (mapViewer.zoomLevels.indexOf(mapViewer.startScale) == -1)
            {
                i = 0;
                while (i < nbZooms)
                {
                    if (mapViewer.startScale < mapViewer.zoomLevels[i])
                    {
                        if (i == 0)
                        {
                            mapViewer.startScale = mapViewer.zoomLevels[i];
                        }
                        else
                        {
                            mapViewer.startScale = mapViewer.zoomLevels[(i - 1)];
                        };
                        break;
                    };
                    i++;
                };
            };
            mapViewer.finalize();
            this.__iconScale = Math.min((worldmapInfo.mapWidth / 31.5), 3);
            this.initMap();
            return (true);
        }

        protected function getPresetScale():Number
        {
            return (this.getMapPresets()[_currentWorldId].zoomFactor);
        }

        protected function openPlayerCurrentMap():void
        {
            var subArea:SubArea = ((sysApi.getPlayerManager().isMapInHavenbag(this.playerApi.currentMap().mapId)) ? this.playerApi.previousSubArea() : this.playerApi.currentSubArea());
            if (((!(subArea.hasCustomWorldMap)) && (!(this.playerApi.isInBreach()))))
            {
                this.openNewMap(subArea.area.superArea.worldmap, MAP_TYPE_SUPERAREA, subArea.area.superArea);
            }
            else
            {
                if (this.playerApi.isInBreach())
                {
                    this.openNewMap(this.dataApi.getWorldMap(23), MAP_TYPE_SUBAREA, this.dataApi.getSubArea(904));
                }
                else
                {
                    this.openNewMap(subArea.worldmap, MAP_TYPE_SUBAREA, subArea);
                };
            };
        }

        protected function initMap():void
        {
            var layerName:String;
            var hint:Hint;
            var hintLegend:String;
            var layerId:String;
            var mapMoved:Boolean;
            var layerVisible:Boolean;
            var flag:Flag;
            var shortcuts:Array;
            var i:int;
            var shortcut:Object;
            var playerSubarea:SubArea;
            var playerPosition:Object;
            var mapBounds:Rectangle;
            _showMapCoords = true;
            mapViewer.showGrid = this.gridDisplayed;
            mapViewer.autoSizeIcon = true;
            minValue = mapViewer.maxScale;
            maxValue = mapViewer.minScale;
            zoom = mapViewer.startScale;
            mapViewer.addLayer(MOUNT_TRIP_LAYER);
            mapViewer.addLayer(PLAYER_POSITION_LAYER);
            mapViewer.addLayer(NO_PRISM_AREAS);
            mapViewer.addLayer(NORMAL_AREAS);
            mapViewer.addLayer(WEAKENED_AREAS);
            mapViewer.addLayer(VULNERABLE_AREAS);
            mapViewer.addLayer(VILLAGES_AREAS);
            mapViewer.addLayer(CAPTURABLE_AREAS);
            mapViewer.addLayer(SABOTAGED_AREAS);
            mapViewer.addLayer(BONUS_AREAS);
            mapViewer.addLayer(MALUS_AREAS);
            mapViewer.addLayer(BONUS_DUNGEONS);
            mapViewer.addLayer(MALUS_DUNGEONS);
            mapViewer.addLayer(ANOMALY_AREAS);
            this.__subAreaList = mapApi.getAllSubArea();
            var hints:Array = mapApi.getHints();
            this.__layersToShow = [];
            var hintLevelText:* = ((" (" + uiApi.getText("ui.common.short.level")) + " ");
            for each (hint in hints)
            {
                if (hint.worldMapId == _currentWorldId)
                {
                    layerName = ("layer_" + hint.categoryId);
                    if (!this.__layersToShow[layerName])
                    {
                        this.__layersToShow[layerName] = true;
                        mapViewer.addLayer(layerName);
                    };
                    hintLegend = hint.name;
                    if (hint.level)
                    {
                        hintLegend = (hintLegend + ((hintLevelText + hint.level) + ")"));
                    };
                    mapViewer.addIcon(layerName, ("hint_" + hint.id), ((this.__hintIconsRootPath + hint.gfx) + ".png"), hint.x, hint.y, this.__iconScale, hintLegend, false, -1, true, true, null, true, false, hint.priority);
                };
            };
            mapViewer.addLayer(MAP_LAYER_PRISMS);
            this.__layersToShow[MAP_LAYER_PRISMS] = true;
            mapViewer.addLayer(MAP_LAYER_PRIVATE);
            this.__layersToShow[MAP_LAYER_PRIVATE] = true;
            mapViewer.addLayer(MAP_LAYER_FLAGS);
            this.__layersToShow[MAP_LAYER_FLAGS] = true;
            mapViewer.addLayer(MAP_LAYER_ANOMALIES);
            this.__layersToShow[MAP_LAYER_ANOMALIES] = true;
            mapViewer.addLayer(MAP_LAYER_BREACH_HIGHLIGHT);
            this.__layersToShow[MAP_LAYER_BREACH_HIGHLIGHT] = true;
            mapViewer.addLayer(MAP_LAYER_BREACH);
            this.__layersToShow[MAP_LAYER_BREACH] = true;
            for (layerId in this.__hintCategoryFiltersList)
            {
                layerName = ("layer_" + layerId);
                layerVisible = ((this.__layersToShow[layerName]) ? this.__hintCategoryFiltersList[layerId] : false);
                mapViewer.showLayer(layerName, layerVisible);
            };
            mapMoved = (((!(this.__switchingMapUi)) && (!(this._mapChanged))) ? this.restoreCurrentMapPreset() : false);
            this._lastMapId = this.playerApi.currentMap().mapId;
            var flagsList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_FLAGS);
            var nFlag:int = flagsList.length;
            var p:int;
            while (p < nFlag)
            {
                mapViewer.removeMapElement(flagsList[p]);
                p++;
            };
            if (this._flags)
            {
                _nbCustomFlags[_currentWorldId] = 0;
                for each (flag in this._flags)
                {
                    this.addFlag(flag.id, flag.legend, flag.position.x, flag.position.y, flag.color, false, false, flag.canBeManuallyRemoved, flag.allowDuplicate);
                    _nbCustomFlags[_currentWorldId]++;
                };
            };
            this.onHouseInformations();
            if (((DEBUG_SHORTCUTS) && (this is CartographyUi)))
            {
                mapViewer.addLayer("shortcuts");
                this.__layersToShow["shortcuts"] = true;
                shortcuts = mapApi.getShortcuts(_currentWorldId);
                i = 0;
                for each (shortcut in shortcuts)
                {
                    mapViewer.addLine("shortcuts", i++.toString(), shortcut.from.posX, shortcut.from.posY, shortcut.to.posX, shortcut.to.posY, "\\\\bise\\dofus2-resources\\content\\gfx\\icons\\hintsShadow\\flag.png", ((((((((((((((((((("[" + shortcut.from.posX) + ",") + shortcut.from.posY) + "] > [") + shortcut.to.posX) + ",") + shortcut.to.posY) + "] | ") + shortcut.from.id) + "|") + shortcut.fromRp) + ((shortcut.from.outdoor) ? "" : "(indoor)")) + " > ") + shortcut.to.id) + "|") + shortcut.toRp) + ((shortcut.to.outdoor) ? "" : "(indoor)")) + " | ") + shortcut.transitionText));
                };
            };
            if (_currentWorldId == WORLD_OF_INCARNAM)
            {
                this.addSubAreasShapes();
            };
            if (this.__playerPos)
            {
                playerSubarea = ((sysApi.getPlayerManager().isMapInHavenbag(this.playerApi.currentMap().mapId)) ? this.playerApi.previousSubArea() : this.playerApi.currentSubArea());
                if (((playerSubarea.area.superArea.id == _currentSuperarea.id) || (this.playerApi.isInBreach())))
                {
                    playerPosition = this.getPlayerPosition();
                    if (((!(mapViewer.getMapElement("flag_playerPosition"))) && (((!(this._currentSubarea)) || (playerSubarea.id == this._currentSubarea.id)) || (this.playerApi.isInBreach()))))
                    {
                        this.addFlag("flag_playerPosition", uiApi.getText("ui.cartography.yourposition"), playerPosition.x, playerPosition.y, -1, this.playerApi.isInBreach(), false, false);
                    };
                    mapBounds = mapViewer.mapBounds;
                    if (((!((((mapBounds.left > playerPosition.x) || (mapBounds.right < playerPosition.x)) || (mapBounds.bottom < playerPosition.y)) || (mapBounds.top > playerPosition.y))) && (mapViewer.zoomFactor >= mapViewer.minScale)))
                    {
                        if (!mapMoved)
                        {
                            mapViewer.moveTo(playerPosition.x, playerPosition.y);
                        };
                    }
                    else
                    {
                        if (!mapMoved)
                        {
                            mapViewer.moveTo(0, 0);
                        };
                    };
                }
                else
                {
                    if (!mapMoved)
                    {
                        mapViewer.moveTo(0, 0);
                    };
                };
            }
            else
            {
                if (!mapMoved)
                {
                    mapViewer.moveTo(0, 0);
                };
            };
            if (socialApi.hasGuild())
            {
                this._waitingForSocialUpdate++;
                sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_GUILD_ONLY));
                if (((!(socialApi.guildHousesUpdateNeeded())) && ((!(socialApi.getGuildHouses())) || (socialApi.getGuildHouses().length == 0))))
                {
                    this._waitingForSocialUpdate++;
                    sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_HOUSES));
                }
                else
                {
                    this.onGuildHousesUpdate();
                };
                if (((!(socialApi.getGuildPaddocks())) || (socialApi.getGuildPaddocks().length == 0)))
                {
                    this._waitingForSocialUpdate++;
                    sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_PADDOCKS));
                }
                else
                {
                    this.onGuildInformationsFarms();
                };
            }
            else
            {
                this.updateMap();
            };
        }

        protected function addSubAreasShapes():void
        {
            var subArea:SubArea;
            this.__noPrismAreas = new AreaGroup("", "", "", "");
            for each (subArea in this.__subAreaList)
            {
                if ((((subArea.displayOnWorldMap) && (subArea.worldmap)) && (!(mapViewer.getMapElement(("shape" + subArea.id))))))
                {
                    if (subArea.worldmap.id == _currentWorldId)
                    {
                        mapViewer.addAreaShape(NO_PRISM_AREAS, ("shape" + subArea.id), mapApi.getSubAreaShape(subArea.id), 0x333333, 0.2, 1096297, 0.2);
                    };
                    this.__noPrismAreas.children.push(new AreaInfo("", "", "", null, subArea));
                };
            };
        }

        protected function saveCurrentMapPreset():void
        {
            if (this.__worldMapInfo)
            {
                this.getMapPresets()[_currentWorldId] = new MapPreset(mapViewer.mapPixelPosition, mapViewer.zoomFactor);
                sysApi.setData((MAP_PRESET_DATA_NAME + this.playerApi.id()), this.getMapPresets(), DataStoreEnum.BIND_CHARACTER);
            };
        }

        override protected function addCustomFlag(pX:int, pY:int):void
        {
            super.addCustomFlag(pX, pY);
            this.__mapMode = MODE_MOVE;
        }

        override protected function addCustomFlagWithRightClick(pX:Number, pY:Number):void
        {
            this.__mapMode = MODE_FLAG;
            super.addCustomFlagWithRightClick(pX, pY);
        }

        protected function updatePrismIcon(pPrismSubAreaInformation:PrismSubAreaWrapper):void
        {
            var prismStateInfo:Object;
            var prismDateText:String;
            var prismModulesText:String;
            var itemw:ItemWrapper;
            var mo:ObjectItem;
            var subArea:SubArea = this.dataApi.getSubArea(pPrismSubAreaInformation.subAreaId);
            var prismId:String = ("prism_" + pPrismSubAreaInformation.subAreaId);
            var me:* = mapViewer.getMapElement(prismId);
            if (((((!(pPrismSubAreaInformation.mapId == -1)) && (subArea.worldmap)) && (subArea.worldmap.id == _currentWorldId)) && ((pPrismSubAreaInformation.alliance) || (this._myAlliance))))
            {
                prismStateInfo = modCartography.getPrismStateInfo(pPrismSubAreaInformation.state);
                prismDateText = "";
                prismModulesText = "";
                switch (pPrismSubAreaInformation.state)
                {
                    case PrismStateEnum.PRISM_STATE_NORMAL:
                        prismDateText = (uiApi.getText("ui.prism.vulnerabilityHour") + " :");
                        break;
                    case PrismStateEnum.PRISM_STATE_WEAKENED:
                    case PrismStateEnum.PRISM_STATE_SABOTAGED:
                        prismDateText = ((uiApi.getText("ui.prism.startVulnerability") + uiApi.getText("ui.common.colon")) + this.timeApi.getDate((pPrismSubAreaInformation.nextVulnerabilityDate * 1000)));
                        break;
                };
                if ((((pPrismSubAreaInformation.state == PrismStateEnum.PRISM_STATE_NORMAL) || (pPrismSubAreaInformation.state == PrismStateEnum.PRISM_STATE_WEAKENED)) || (pPrismSubAreaInformation.state == PrismStateEnum.PRISM_STATE_SABOTAGED)))
                {
                    prismDateText = (prismDateText + (" " + pPrismSubAreaInformation.vulnerabilityHourString));
                };
                if (((((this._myAlliance) && (pPrismSubAreaInformation.alliance.allianceId == this._myAlliance.allianceId)) && (pPrismSubAreaInformation.modulesObjects)) && (pPrismSubAreaInformation.modulesObjects.length > 0)))
                {
                    for each (mo in pPrismSubAreaInformation.modulesObjects)
                    {
                        itemw = this.dataApi.getItemWrapper(mo.objectGID, 0, 0, 1);
                        prismModulesText = (prismModulesText + (itemw.name + "\n"));
                    };
                    prismModulesText = prismModulesText.substr(0, (prismModulesText.length - 1));
                };
                __hintCaptions[("prism_" + pPrismSubAreaInformation.subAreaId)] = prismStateInfo.text;
                if (prismDateText.length > 0)
                {
                    __hintCaptions[("prism_" + pPrismSubAreaInformation.subAreaId)] = (__hintCaptions[("prism_" + pPrismSubAreaInformation.subAreaId)] + ((" <i>( " + prismDateText) + " )</i>"));
                };
                if (prismModulesText.length > 0)
                {
                    __hintCaptions[("prism_" + pPrismSubAreaInformation.subAreaId)] = (__hintCaptions[("prism_" + pPrismSubAreaInformation.subAreaId)] + ((" <i>( " + prismModulesText) + " )</i>"));
                };
                if (me)
                {
                    mapViewer.removeMapElement(me);
                };
                mapViewer.addIcon(MAP_LAYER_PRISMS, prismId, ((this.__hintIconsRootPath + prismStateInfo.icon) + ".png"), pPrismSubAreaInformation.worldX, pPrismSubAreaInformation.worldY, this.__iconScale, null, false, -1, true, true, null, true, false, HintPriorityEnum.CONQUEST);
            }
            else
            {
                if (((pPrismSubAreaInformation.mapId == -1) && (me)))
                {
                    mapViewer.removeMapElement(me);
                };
            };
        }

        protected function updatePrismAndSubareaStatus(prismSubAreaInformation:PrismSubAreaWrapper, pUpdateConquestModeData:Boolean=true):void
        {
            var currentAreaItem:AreaInfo;
            var lineColor:uint;
            var fillColor:uint;
            var layer:String;
            var alliance:AllianceWrapper;
            var prismState:uint;
            var subArea:SubArea = mapApi.getSubArea(prismSubAreaInformation.subAreaId);
            if (((((!(subArea)) || (!(subArea.name))) || (!(subArea.worldmap))) || (!(subArea.worldmap.id == _currentWorldId))))
            {
                return;
            };
            if (pUpdateConquestModeData)
            {
                currentAreaItem = new AreaInfo(subArea.name, "subarea", "icon_simple_prism_uri", this.__allAreas, subArea);
                this.addAreaInfo(this.__allAreas, currentAreaItem);
            };
            var lineAlpha:Number = 0.6;
            var fillAlpha:Number = 0.4;
            if (((!(prismSubAreaInformation.mapId == -1)) || (prismSubAreaInformation.alliance)))
            {
                alliance = ((prismSubAreaInformation.alliance) ? prismSubAreaInformation.alliance : this._myAlliance);
                if ((((currentAreaItem) && (this._myAlliance)) && (this._myAlliance.allianceId == alliance.allianceId)))
                {
                    currentAreaItem.css = this._textCss;
                    currentAreaItem.cssClass = "bonus";
                };
                fillColor = (lineColor = alliance.backEmblem.color);
                prismState = ((prismSubAreaInformation.mapId != -1) ? prismSubAreaInformation.state : PrismStateEnum.PRISM_STATE_NORMAL);
                switch (prismState)
                {
                    case PrismStateEnum.PRISM_STATE_INVULNERABLE:
                    case PrismStateEnum.PRISM_STATE_NORMAL:
                        layer = NORMAL_AREAS;
                        if (currentAreaItem)
                        {
                            this.addAreaInfo(this.__normalAreas, currentAreaItem);
                        };
                        break;
                    case PrismStateEnum.PRISM_STATE_WEAKENED:
                        layer = WEAKENED_AREAS;
                        if (currentAreaItem)
                        {
                            currentAreaItem.vulnerabilityDate = prismSubAreaInformation.nextVulnerabilityDate;
                            currentAreaItem.label = (currentAreaItem.label + (" - " + prismSubAreaInformation.vulnerabilityHourString));
                            this.addAreaInfo(this.__weakenedAreas, currentAreaItem);
                        };
                        break;
                    case PrismStateEnum.PRISM_STATE_SABOTAGED:
                        layer = SABOTAGED_AREAS;
                        if (currentAreaItem)
                        {
                            currentAreaItem.vulnerabilityDate = prismSubAreaInformation.nextVulnerabilityDate;
                            currentAreaItem.label = (currentAreaItem.label + (" - " + prismSubAreaInformation.vulnerabilityHourString));
                            this.addAreaInfo(this.__sabotagedAreas, currentAreaItem);
                        };
                        break;
                    case PrismStateEnum.PRISM_STATE_VULNERABLE:
                        layer = VULNERABLE_AREAS;
                        if (currentAreaItem)
                        {
                            this.addAreaInfo(this.__vulnerableAreas, currentAreaItem);
                        };
                        break;
                };
            }
            else
            {
                layer = CAPTURABLE_AREAS;
                fillColor = (lineColor = 1096297);
                if (currentAreaItem)
                {
                    this.addAreaInfo(this.__capturableAreas, currentAreaItem);
                };
            };
            mapViewer.addAreaShape(layer, ("shape" + prismSubAreaInformation.subAreaId), mapApi.getSubAreaShape(prismSubAreaInformation.subAreaId), lineColor, lineAlpha, fillColor, fillAlpha, 4, false);
        }

        protected function addAreaInfo(pList:AreaGroup, pItem:AreaInfo):void
        {
            var item:AreaInfo;
            if (pList)
            {
                for each (item in pList.children)
                {
                    if (item.data.id == pItem.data.id)
                    {
                        pList.children[pList.children.indexOf(item)] = pItem;
                        return;
                    };
                };
                pList.children.push(pItem);
                pItem.parent = pList;
            };
        }

        protected function loadMapFilters(pFiltersList:Array, pMapFilterId:String):void
        {
            var hintCat:HintCategory;
            var filterValue:int = this.configApi.getConfigProperty("dofus", pMapFilterId);
            var hintCategories:Array = this.dataApi.getHintCategories();
            for each (hintCat in hintCategories)
            {
                pFiltersList[hintCat.id] = (filterValue & Math.pow(2, hintCat.id));
            };
        }

        protected function saveMapFilters(pFiltersList:Array, pMapFilterId:String):void
        {
            var hintCatId:String;
            var filterValue:int;
            for (hintCatId in pFiltersList)
            {
                if (pFiltersList[hintCatId])
                {
                    filterValue = (filterValue + Math.pow(2, int(hintCatId)));
                };
            };
            this.configApi.setConfigProperty("dofus", pMapFilterId, filterValue);
        }

        protected function getSubAreaTooltipPosition():Point
        {
            return (this.__subAreaTooltipPosition);
        }

        protected function getMapPresets():Array
        {
            return (this._mapPreset);
        }

        protected function setMapPresets(presets:Array):void
        {
            this._mapPreset = presets;
        }

        protected function getMapPresetsData():Array
        {
            return (sysApi.getData((MAP_PRESET_DATA_NAME + this.playerApi.id()), DataStoreEnum.BIND_CHARACTER));
        }

        public function onFocusChange(pTarget:Object):void
        {
            if (((((pTarget) && (!(pTarget == mapViewer))) && (!(pTarget == uiApi.getUi("cartographyCurrentMapTooltip")))) && (!((mapViewer as Object).contains(pTarget)))))
            {
                rollOutMapAreaShape(__lastHighlightElement);
            };
        }

        override public function onRelease(target:Object):void
        {
            super.onRelease(target);
            switch (target)
            {
                case mapViewer:
                    if (this.__mapMode == MODE_FLAG)
                    {
                        this.addCustomFlag(mapViewer.currentMouseMapX, mapViewer.currentMouseMapY);
                    };
                    break;
            };
        }

        override public function onMapRollOver(target:Object, x:int, y:int, searchSubArea:SubArea=null):void
        {
            var alliance:AllianceWrapper;
            var subAreaInfo:Array;
            var prismSubAreaInfo:PrismSubAreaWrapper;
            var tooltip:*;
            super.onMapRollOver(target, x, y, searchSubArea);
            var subArea:SubArea = searchSubArea;
            if (!subArea)
            {
                subAreaInfo = getSubAreaFromCoords(x, y);
                if (subAreaInfo)
                {
                    subArea = subAreaInfo[0];
                };
            };
            this.__lastSubArea = subArea;
            if (!subArea)
            {
                return;
            };
            if ((((subArea) && (subArea.worldmap)) && (subArea.worldmap.id == _currentWorldId)))
            {
                prismSubAreaInfo = (((__conquestSubAreasInfos) && (!(searchSubArea))) ? __conquestSubAreasInfos[subArea.id] : null);
                if (((prismSubAreaInfo) && ((!(prismSubAreaInfo.mapId == -1)) || (prismSubAreaInfo.alliance))))
                {
                    alliance = ((prismSubAreaInfo.alliance) ? prismSubAreaInfo.alliance : socialApi.getAlliance());
                };
            };
            if (this.__displaySubAreaToolTip)
            {
                tooltip = uiApi.getUi("tooltip_cartographyCurrentSubArea");
                if (!tooltip)
                {
                    uiApi.showTooltip({
                        "mapX":x,
                        "mapY":y,
                        "mapElementText":null,
                        "subArea":subArea,
                        "subAreaLevel":((subArea) ? subArea.level : 0),
                        "alliance":alliance,
                        "updatePositionFunction":this.updateSubAreaTooltipPosition
                    }, new Rectangle(), false, "cartographyCurrentSubArea", 0, 0, 0, "cartography", null, null, "cartographyCurrentSubArea");
                }
                else
                {
                    tooltipApi.update("cartographyCurrentSubArea", "subAreaInfo", x, y, null, subArea, ((subArea) ? subArea.level : 0), alliance);
                    this.updateSubAreaTooltipPosition();
                };
            };
        }

        override public function onMapRollOut(target:Object):void
        {
            super.onMapRollOut(target);
            rollOutMapAreaShape(__lastHighlightElement);
            if (this.__displaySubAreaToolTip)
            {
                uiApi.unloadUi("tooltip_cartographyCurrentSubArea");
            };
        }

        override public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            super.onRollOver(target);
            var point:uint = 7;
            var relPoint:uint = 1;
            switch (target)
            {
                case mapViewer:
                    if (this.__mapMode == MODE_FLAG)
                    {
                        if (!mapViewer.useFlagCursor)
                        {
                            mapViewer.useFlagCursor = true;
                        };
                    }
                    else
                    {
                        if (mapViewer.useFlagCursor)
                        {
                            mapViewer.useFlagCursor = false;
                        };
                    };
                    return;
            };
            if (tooltipText)
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        override public function onRollOut(target:Object):void
        {
            super.onRollOut(target);
            switch (target)
            {
                case mapViewer:
                    if (this.__mapMode == MODE_FLAG)
                    {
                        mapViewer.useFlagCursor = false;
                    };
                    return;
                default:
                    uiApi.hideTooltip();
            };
        }

        private function onGuildMembershipUpdated(hasGuild:Boolean):void
        {
            var mapElemList:Array;
            var nElems:int;
            var i:int;
            if (!hasGuild)
            {
                mapElemList = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
                nElems = mapElemList.length;
                i = 0;
                while (i < nElems)
                {
                    if (mapElemList[i].id.indexOf("guildPaddock_") == 0)
                    {
                        mapViewer.removeMapElement(mapElemList[i]);
                    };
                    i++;
                };
            };
        }

        private function onGuildInformationsFarms():void
        {
            var paddock:PaddockContentInformations;
            var subArea:SubArea;
            var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf("guildPaddock_") == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            var farmsList:Object = socialApi.getGuildPaddocks();
            for each (paddock in farmsList)
            {
                subArea = this.dataApi.getSubArea(paddock.subAreaId);
                if ((((subArea) && (subArea.area.superAreaId == superAreaId)) && (subArea.worldmap.id == _currentWorldId)))
                {
                    __hintCaptions[("guildPaddock_" + paddock.paddockId)] = uiApi.processText(uiApi.getText("ui.guild.paddock", paddock.maxOutdoorMount), "", (paddock.maxOutdoorMount == 1), (paddock.maxOutdoorMount == 0));
                    mapViewer.addIcon(MAP_LAYER_PRIVATE, ("guildPaddock_" + paddock.paddockId), (this.__hintIconsRootPath + "1002.png"), paddock.worldX, paddock.worldY, this.__iconScale, null, false, -1, true, true, null, true, false, HintPriorityEnum.PLAYER_POSSESSIONS);
                };
            };
            if (this._waitingForSocialUpdate <= 1)
            {
                this._waitingForSocialUpdate = 0;
                this.updateMap();
            }
            else
            {
                this._waitingForSocialUpdate--;
            };
        }

        private function onGuildPaddockAdd(paddockInfo:PaddockContentInformations):void
        {
            var subArea:SubArea = this.dataApi.getSubArea(paddockInfo.subAreaId);
            if (((subArea.area.superAreaId == superAreaId) && (subArea.worldmap.id == _currentWorldId)))
            {
                __hintCaptions[("guildPaddock_" + paddockInfo.paddockId)] = uiApi.processText(uiApi.getText("ui.guild.paddock", paddockInfo.maxOutdoorMount), "", (paddockInfo.maxOutdoorMount == 1), (paddockInfo.maxOutdoorMount == 0));
                mapViewer.addIcon(MAP_LAYER_PRIVATE, ("guildPaddock_" + paddockInfo.paddockId), (this.__hintIconsRootPath + "1002.png"), paddockInfo.worldX, paddockInfo.worldY, this.__iconScale, null, false, -1, true, true, null, true, false, HintPriorityEnum.PLAYER_POSSESSIONS);
                this.updateMap();
            };
        }

        private function onGuildPaddockRemoved(paddockId:Number):void
        {
            var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf(("guildPaddock_" + paddockId)) == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            this.updateMap();
        }

        private function onGuildHousesUpdate():void
        {
            var house:GuildHouseWrapper;
            var subArea:SubArea;
            var housesList:Object = socialApi.getGuildHouses();
            var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf("guildHouse_") == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            for each (house in housesList)
            {
                subArea = this.dataApi.getSubArea(house.subareaId);
                if (((subArea.area.superAreaId == superAreaId) && (subArea.worldmap.id == _currentWorldId)))
                {
                    __hintCaptions[("guildHouse_" + house.houseId)] = ((uiApi.getText("ui.common.guildHouse") + uiApi.getText("ui.common.colon")) + house.houseName);
                    mapViewer.addIcon(MAP_LAYER_PRIVATE, ("guildHouse_" + house.houseId), (this.__hintIconsRootPath + "1001.png"), house.worldX, house.worldY, this.__iconScale, null, false, -1, true, true, null, true, false, HintPriorityEnum.PLAYER_POSSESSIONS);
                };
            };
            if (this._waitingForSocialUpdate <= 1)
            {
                this._waitingForSocialUpdate = 0;
                this.updateMap();
            }
            else
            {
                this._waitingForSocialUpdate--;
            };
        }

        private function onGuildHouseAdd(house:GuildHouseWrapper):void
        {
            var subArea:SubArea = this.dataApi.getSubArea(house.subareaId);
            if (((subArea.area.superAreaId == superAreaId) && (subArea.worldmap.id == _currentWorldId)))
            {
                __hintCaptions[("guildHouse_" + house.houseId)] = ((uiApi.getText("ui.common.guildHouse") + uiApi.getText("ui.common.colon")) + house.houseName);
                mapViewer.addIcon(MAP_LAYER_PRIVATE, ("guildHouse_" + house.houseId), (this.__hintIconsRootPath + "1001.png"), house.worldX, house.worldY, this.__iconScale, null, false, -1, true, true, null, true, false, HintPriorityEnum.PLAYER_POSSESSIONS);
                this.updateMap();
            };
        }

        private function onGuildHouseRemoved(houseId:uint):void
        {
            var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf(("guildHouse_" + houseId)) == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            this.updateMap();
        }

        protected function onTaxCollectorListUpdate(infoType:uint=0):void
        {
            var taxCollector:TaxCollectorWrapper;
            var subArea:SubArea;
            if (infoType == GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_ALLIANCE)
            {
                return;
            };
            var sh:* = (sysApi.getCurrentServer().gameTypeId == GameServerTypeEnum.SERVER_TYPE_HARDCORE);
            var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf("guildPony_") == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            var taxCollectorsList:Object = socialApi.getTaxCollectors();
            for each (taxCollector in taxCollectorsList)
            {
                subArea = this.dataApi.getSubArea(taxCollector.subareaId);
                if (((subArea.area.superAreaId == superAreaId) && ((subArea.worldmap.id == _currentWorldId) || ((subArea.worldmap.id == DEPTHS_OF_SUFOKIA) && (_currentWorldId == WORLD_MAP)))))
                {
                    if (!sh)
                    {
                        __hintCaptions[("guildPony_" + taxCollector.uniqueId)] = uiApi.getText("ui.guild.taxCollectorFullInformations", taxCollector.firstName, taxCollector.lastName, taxCollector.additionalInformation.collectorCallerName, taxCollector.kamas, taxCollector.pods, this.utilApi.kamasToString(taxCollector.itemsValue, ""), taxCollector.experience);
                    }
                    else
                    {
                        if (taxCollector.pods > 0)
                        {
                            __hintCaptions[("guildPony_" + taxCollector.uniqueId)] = uiApi.getText("ui.guild.taxCollectorHardcoreInformations.full", taxCollector.firstName, taxCollector.lastName, taxCollector.additionalInformation.collectorCallerName, taxCollector.pods, this.utilApi.kamasToString(taxCollector.itemsValue, ""));
                        }
                        else
                        {
                            __hintCaptions[("guildPony_" + taxCollector.uniqueId)] = uiApi.getText("ui.guild.taxCollectorHardcoreInformations.empty", taxCollector.firstName, taxCollector.lastName, taxCollector.additionalInformation.collectorCallerName);
                        };
                    };
                    mapViewer.addIcon(MAP_LAYER_PRIVATE, ("guildPony_" + taxCollector.uniqueId), (this.__hintIconsRootPath + "1003.png"), taxCollector.mapWorldX, taxCollector.mapWorldY, this.__iconScale, null, false, -1, true, true, null, true, false, HintPriorityEnum.PLAYER_POSSESSIONS);
                };
            };
            if (this._waitingForSocialUpdate <= 1)
            {
                this._waitingForSocialUpdate = 0;
                this.updateMap();
            }
            else
            {
                this._waitingForSocialUpdate--;
            };
        }

        private function onGuildTaxCollectorAdd(taxCollector:TaxCollectorWrapper):void
        {
            var firstName:String;
            var lastName:String;
            if (this.dataApi.getSubArea(taxCollector.subareaId).area.superAreaId == superAreaId)
            {
                firstName = taxCollector.firstName;
                lastName = taxCollector.lastName;
                __hintCaptions[("guildPony_" + taxCollector.uniqueId)] = uiApi.getText("ui.guild.taxCollectorFullInformations", firstName, lastName, taxCollector.additionalInformation.collectorCallerName, taxCollector.kamas, taxCollector.pods, taxCollector.itemsValue, taxCollector.experience);
                mapViewer.addIcon(MAP_LAYER_PRIVATE, ("guildPony_" + taxCollector.uniqueId), (this.__hintIconsRootPath + "1003.png"), taxCollector.mapWorldX, taxCollector.mapWorldY, this.__iconScale, null, false, -1, true, true, null, true, false, HintPriorityEnum.PLAYER_POSSESSIONS);
                this.updateMap();
            };
        }

        private function onGuildTaxCollectorRemoved(taxCollectorId:Number):void
        {
            var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf(("guildPony_" + taxCollectorId)) == 0)
                {
                    mapViewer.removeMapElement(mapElemList[i]);
                };
                i++;
            };
            this.updateMap();
        }

        private function onRemoveMapFlag(flagId:String, worldMapId:int):void
        {
            if (flagId == "flag_playerPosition")
            {
                removeFlag(flagId);
            };
        }

        protected function onMapHintsFilter(layerId:int, displayed:Boolean, fromCartography:Boolean):void
        {
            if (!fromCartography)
            {
                this.__hintCategoryFiltersList[layerId] = displayed;
                mapViewer.showLayer(("layer_" + layerId), displayed);
                this.updateMap();
            };
        }

        protected function onPrismsListInformation(pPrismsInfo:Object):void
        {
            var prismSubAreaInformation:PrismSubAreaWrapper;
            this._myAlliance = socialApi.getAlliance();
            var prismList:Object = mapViewer.getMapElementsByLayer(MAP_LAYER_PRISMS);
            var nPrism:int = prismList.length;
            var p:int;
            while (p < nPrism)
            {
                mapViewer.removeMapElement(prismList[p]);
                p++;
            };
            __conquestSubAreasInfos = (pPrismsInfo as Dictionary);
            for each (prismSubAreaInformation in pPrismsInfo)
            {
                this.updatePrismIcon(prismSubAreaInformation);
                if (!this.__allAreas)
                {
                    this.updatePrismAndSubareaStatus(prismSubAreaInformation, false);
                };
            };
            this.__normalAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.normal"), "areaShape", "icon_simple_prism_uri", NORMAL_AREAS);
            this.__weakenedAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.weakened"), "areaShape", "icon_simple_prism_uri", WEAKENED_AREAS);
            this.__vulnerableAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.vulnerable"), "areaShape", "icon_simple_prism_uri", VULNERABLE_AREAS);
            this.__capturableAreas = new AreaGroup(uiApi.getText("ui.pvp.conquestCapturableAreas"), "areaShape", "icon_simple_prism_uri", CAPTURABLE_AREAS);
            this.__sabotagedAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.sabotaged"), "areaShape", "icon_simple_prism_uri", SABOTAGED_AREAS);
            this.addSubAreasShapes();
            this.updateMap();
            if (this.__allAreas)
            {
                this.__allAreas = null;
            };
        }

        protected function onPrismsInfoUpdate(pPrismSubAreaIds:Object):void
        {
            var prismSubAreaInfo:PrismSubAreaWrapper;
            var subAreaId:int;
            this._myAlliance = socialApi.getAlliance();
            for each (subAreaId in pPrismSubAreaIds)
            {
                prismSubAreaInfo = socialApi.getPrismSubAreaById(subAreaId);
                this.updatePrismIcon(prismSubAreaInfo);
                this.updatePrismAndSubareaStatus(prismSubAreaInfo);
            };
            this.updateMap();
        }

        private function onAreaListInformation(areasInfo:Vector.<AnomalySubareaInformation>):void
        {
            var subInfo:AnomalySubareaInformation;
            var subArea:SubArea;
            var mapPos:MapPosition;
            var iconUri:String;
            var legend:String;
            __subAreasInfos = areasInfo;
            for each (subInfo in __subAreasInfos)
            {
                if (((subInfo.hasAnomaly) && (!(this.playerApi.isInBreach()))))
                {
                    subArea = mapApi.getSubArea(subInfo.subAreaId);
                    if (((subArea) && (subArea.worldmap.id == mapApi.getCurrentWorldMap().id)))
                    {
                        mapPos = subArea.zaapMapPosition;
                        iconUri = (sysApi.getConfigEntry("config.ui.skin") + "texture/map/filterSpiral_On.png");
                        legend = ((uiApi.getText("ui.zaap.anomaly") + " - ") + subArea.name);
                        mapViewer.addIcon(MAP_LAYER_ANOMALIES, ("anomaly_" + subArea.id), iconUri, mapPos.posX, mapPos.posY, 1, legend, true, -1, true, true, null, true, false, HintPriorityEnum.FLAGS);
                    };
                };
            };
            this.addSubAreasShapes();
            mapViewer.updateMapElements();
            if (this.__allAreas)
            {
                this.__allAreas = null;
            };
        }

        protected function onAnomalyState(open:Boolean, closingTime:Number, subAreaId:int):void
        {
            var mapPos:MapPosition;
            var iconUri:String;
            var legend:String;
            var subArea:SubArea = mapApi.getSubArea(subAreaId);
            if ((((open) && (subArea)) && (subArea.worldmap.id == mapApi.getCurrentWorldMap().id)))
            {
                mapPos = subArea.zaapMapPosition;
                iconUri = (sysApi.getConfigEntry("config.ui.skin") + "texture/map/filterSpiral_On.png");
                legend = ((uiApi.getText("ui.zaap.anomaly") + " - ") + subArea.name);
                mapViewer.addIcon(MAP_LAYER_ANOMALIES, ("anomaly_" + subArea.id), iconUri, mapPos.posX, mapPos.posY, 1, legend, true, -1, true, true, null, true, false, HintPriorityEnum.FLAGS);
            }
            else
            {
                if (!open)
                {
                    mapViewer.removeMapElement(mapViewer.getMapElement(("anomaly_" + subAreaId)));
                };
            };
        }

        protected function onHouseInformations(pHouses:Object=null):void
        {
            var daHouse:HouseWrapper;
            var hasHouse:Boolean;
            var houseElementId:String;
            var subArea:SubArea;
            var houses:Object = ((pHouses) ? pHouses : this.playerApi.getPlayerHouses());
            var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
            var nElems:int = mapElemList.length;
            var i:int;
            while (i < nElems)
            {
                if (mapElemList[i].id.indexOf("myHouse") == 0)
                {
                    hasHouse = false;
                    for each (daHouse in houses)
                    {
                        if (daHouse.houseId == parseInt(mapElemList[i].id.substr((mapElemList[i].id.indexOf("_") + 1))))
                        {
                            hasHouse = true;
                        };
                    };
                    if (!hasHouse)
                    {
                        mapViewer.removeMapElement(mapElemList[i]);
                    };
                };
                i++;
            };
            this.updateMap();
            for each (daHouse in houses)
            {
                houseElementId = ("myHouse_" + daHouse.houseId);
                subArea = this.dataApi.getSubArea(daHouse.subAreaId);
                if ((((subArea.area.superAreaId == superAreaId) && (subArea.worldmap.id == _currentWorldId)) && (!(mapViewer.getMapElement(houseElementId)))))
                {
                    __hintCaptions[houseElementId] = uiApi.getText("ui.common.myHouse");
                    mapViewer.addIcon(MAP_LAYER_PRIVATE, houseElementId, (this.__hintIconsRootPath + "1000.png"), daHouse.worldX, daHouse.worldY, this.__iconScale, null, false, -1, true, true, null, true, false, HintPriorityEnum.PLAYER_POSSESSIONS);
                };
            };
        }

        public function onMouseShiftClick(target:Object):void
        {
            var elementName:String;
            var params:Object;
            if (target.data == mapViewer)
            {
                elementName = ((target.params.element) ? ((__hintCaptions[target.params.element.id]) ? __hintCaptions[target.params.element.id] : target.params.element.legend) : "");
                if (elementName.length)
                {
                    elementName = (elementName.split("\n").join(" ") + " ");
                };
                params = {
                    "x":target.params.x,
                    "y":target.params.y,
                    "worldMapId":this.playerApi.currentSubArea().worldmap.id,
                    "elementName":elementName
                };
                sysApi.dispatchHook(MouseShiftClick, {
                    "data":"Map",
                    "params":params
                });
            };
        }

        override public function onMapMove(target:Object):void
        {
            super.onMapMove(target);
            this.saveCurrentMapPreset();
        }

        protected function shouldRestorePosition():Boolean
        {
            return (true);
        }

        private function restoreCurrentMapPreset():Boolean
        {
            var mapPreset:Object = this.getMapPresets()[_currentWorldId];
            if (!mapPreset)
            {
                this.__centerOnPlayer = true;
                return (false);
            };
            if ((((!(this._lastMapId == -1)) && (!(this._lastMapId == this.playerApi.currentMap().mapId))) || (!(this.shouldRestorePosition()))))
            {
                zoom = (mapViewer.mapScale = this.getPresetScale());
                return (false);
            };
            mapViewer.moveToPixel(mapPreset.mapPixelPosition.x, mapPreset.mapPixelPosition.y, mapPreset.zoomFactor);
            this.__centerOnPlayer = false;
            zoom = mapViewer.zoomFactor;
            return (true);
        }

        private function updateSubAreaTooltipPosition():void
        {
            var pos:Point;
            if (!uiApi)
            {
                return;
            };
            var tooltip:Object = uiApi.getUi("tooltip_cartographyCurrentSubArea");
            if (tooltip)
            {
                tooltip.visible = (!(this.__lastSubArea == null));
                pos = this.getSubAreaTooltipPosition();
                tooltip.x = pos.x;
                tooltip.y = pos.y;
            };
        }

        protected function updateMap():void
        {
            mapViewer.updateMapElements();
        }

        protected function toggleHints():void
        {
            var layerId:String;
            var allLayersVisible:* = (!(mapViewer.allLayersVisible));
            for (layerId in this.__hintCategoryFiltersList)
            {
                this.__hintCategoryFiltersList[layerId] = allLayersVisible;
            };
            mapViewer.showAllLayers(allLayersVisible);
        }

        protected function insertMapCoordinates(pMapX:int, pMapY:int, pMapElement:Object):void
        {
            this.onMouseShiftClick({
                "data":mapViewer,
                "params":{
                    "x":pMapX,
                    "y":pMapY,
                    "element":pMapElement
                }
            });
        }

        protected function mountRunToThisPosition(pMapX:int, pMapY:int):void
        {
            mapApi.autoTravel(pMapX, pMapY);
        }

        override protected function createContextMenu(contextMenu:Array=null):void
        {
            var hasAutopilot:Boolean;
            var capacityCount:int;
            var i:int;
            var totalDaresInSubArea:uint;
            if (!contextMenu)
            {
                contextMenu = [];
            };
            var mountInfo:Object = this.playerApi.getMount();
            if (((this.playerApi.isRidding()) && (mountInfo)))
            {
                if (sysApi.getPlayerManager().hasFreeAutopilot)
                {
                    hasAutopilot = true;
                }
                else
                {
                    capacityCount = mountInfo.ability.length;
                    i = 0;
                    if (capacityCount)
                    {
                        i = 0;
                        while (i < capacityCount)
                        {
                            if (mountInfo.ability[i].id == DataEnum.MOUNT_CAPACITY_AUTOPILOT)
                            {
                                hasAutopilot = true;
                                break;
                            };
                            i++;
                        };
                    };
                };
                if (hasAutopilot)
                {
                    contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.mountTrip.travel"), this.mountRunToThisPosition, [mapViewer.currentMouseMapX, mapViewer.currentMouseMapY]));
                };
            };
            contextMenu.unshift(modContextMenu.createContextMenuSeparatorObject());
            contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.chat.insertCoordinates"), this.insertMapCoordinates, [mapViewer.currentMouseMapX, mapViewer.currentMouseMapY, __currentMapElement]));
            contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.cartography.centerOnPlayer"), this.centerOnPlayer));
            contextMenu.unshift(modContextMenu.createContextMenuSeparatorObject());
            var gridTextKey:String = ((mapViewer.showGrid) ? "ui.option.hideGrid" : "ui.option.displayGrid");
            contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText(gridTextKey), this.toggleDisplayGrid));
            contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.map.toggleAllHints"), this.toggleHints));
            var subAreaInfos:Array = getSubAreaFromCoords(mapViewer.currentMouseMapX, mapViewer.currentMouseMapY);
            if (((subAreaInfos) && (subAreaInfos[0])))
            {
                totalDaresInSubArea = socialApi.getTotalDaresInSubArea(subAreaInfos[0].id);
                if (totalDaresInSubArea)
                {
                    contextMenu.push(modContextMenu.createContextMenuSeparatorObject());
                    contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.processText(uiApi.getText("ui.social.dare.totalAvailable", totalDaresInSubArea), "", (totalDaresInSubArea == 1), (totalDaresInSubArea == 0)), this.listDaresInSubArea, [subAreaInfos[1]]));
                };
            };
            super.createContextMenu(contextMenu);
        }

        protected function showHints(pFiltersList:Array):void
        {
            var layerId:String;
            for (layerId in pFiltersList)
            {
                mapViewer.showLayer(("layer_" + layerId), pFiltersList[layerId]);
            };
        }

        private function listDaresInSubArea(subAreaName:String):void
        {
            sysApi.dispatchHook(OpenDareSearch, subAreaName, "searchFilterSubArea");
        }

        private function getPlayerPosition():Object
        {
            var outdoorCoordinateX:int;
            var outdoorCoordinateY:int;
            var breachWorldMapCoordinate:BreachWorldMapCoordinate = ((this.breachApi.breachFrame) ? this.dataApi.getBreachWorldMapCoordinate(Math.max(this.dataApi.getBreachMinStageWorldMapCoordinate().mapStage, Math.min(this.breachApi.getFloor(), this.dataApi.getBreachMaxStageWorldMapCoordinate().mapStage))) : null);
            if (((breachWorldMapCoordinate) && (this.playerApi.isInBreach())))
            {
                outdoorCoordinateX = breachWorldMapCoordinate.mapCoordinateX;
                outdoorCoordinateY = breachWorldMapCoordinate.mapCoordinateY;
            }
            else
            {
                outdoorCoordinateX = this.__playerPos.outdoorX;
                outdoorCoordinateY = this.__playerPos.outdoorY;
            };
            return ({
                "x":outdoorCoordinateX,
                "y":outdoorCoordinateY
            });
        }

        private function centerOnPlayer():void
        {
            var playerPos:Object = this.getPlayerPosition();
            mapViewer.moveTo(playerPos.x, playerPos.y);
        }

        private function toggleDisplayGrid():void
        {
            mapViewer.showGrid = (!(mapViewer.showGrid));
            this.configApi.setConfigProperty("dofus", ((this is BannerMap) ? "showMiniMapGrid" : "showMapGrid"), mapViewer.showGrid);
        }


    }
} Ankama_Cartography.ui

import flash.geom.Point;

class MapPreset 
{

    public var mapPixelPosition:Point;
    public var zoomFactor:Number;

    public function MapPreset(mapPixelPosition:Point, zoomFactor:Number)
    {
        this.mapPixelPosition = mapPixelPosition;
        this.zoomFactor = zoomFactor;
    }

}


