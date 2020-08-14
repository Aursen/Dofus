package Ankama_Cartography.ui
{
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import flash.utils.Timer;
    import d2hooks.MapComplementaryInformationsData;
    import d2hooks.ShowEntitiesTooltips;
    import d2hooks.HighlightInteractiveElements;
    import d2hooks.MapFightCount;
    import d2hooks.ConfigPropertyChange;
    import d2hooks.ShowFightPositions;
    import d2actions.PrismsListRegister;
    import com.ankamagames.dofus.network.enums.PrismListenEnum;
    import d2actions.AnomalySubareaInformationRequest;
    import flash.events.TimerEvent;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2actions.OpenCurrentFight;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import d2hooks.AddMapFlag;
    import d2actions.ShowEntitiesTooltips;
    import d2actions.HighlightInteractiveElements;
    import d2actions.ShowFightPositions;
    import d2actions.GuildGetInformations;
    import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.berilia.types.data.MapElement;
    import com.ankamagames.dofus.datacenter.breach.BreachWorldMapCoordinate;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.dofus.types.enums.HintPriorityEnum;

    public class BannerMap extends CartographyBase 
    {

        private static var _nFightCount:uint = 0;
        private static var _shortcutColor:String;
        private static var MAP_PRESET_DATA_NAME:String = "mapZoom_miniMap";

        public var tx_separator:TextureBitmap;
        public var btn_showEntitiesTooltips:ButtonContainer;
        public var btn_highlightInteractiveElements:ButtonContainer;
        public var btn_viewFights:ButtonContainer;
        public var btn_showFightPositions:ButtonContainer;
        public var mainCtr:GraphicContainer;
        private var _entitiesTooltipsVisible:Boolean;
        private var _interactiveElementsHighlighted:Boolean;
        private var _fightPositionsVisible:Boolean;
        private var _hintCategoryNames:Array;
        private var _refreshTimer:Timer = new Timer(2000, 1);
        private var _refreshLocked:Boolean;


        override public function main(params:Object=null):void
        {
            this._hintCategoryNames = [uiApi.getText("ui.map.temple"), uiApi.getText("ui.map.bidHouse"), uiApi.getText("ui.map.craftHouse"), uiApi.getText("ui.common.misc"), uiApi.getText("ui.map.conquest"), uiApi.getText("ui.map.dungeon"), uiApi.getText("ui.common.possessions"), uiApi.getText("ui.cartography.flags"), uiApi.getText("ui.cartography.transport"), uiApi.getText("ui.common.anomalies")];
            __animatedPlayerPosition = false;
            __displaySubAreaToolTip = false;
            mapViewer.finalized = false;
            mapViewer.gridLineThickness = 1;
            gridDisplayed = configApi.getConfigProperty("dofus", "showMiniMapGrid");
            loadMapFilters(__hintCategoryFiltersList, "mapFilters_miniMap");
            super.main(params);
            uiApi.addComponentHook(this.btn_showEntitiesTooltips, "onPress");
            uiApi.addComponentHook(this.btn_showEntitiesTooltips, "onMouseUp");
            uiApi.addComponentHook(this.btn_showEntitiesTooltips, "onRollOver");
            uiApi.addComponentHook(this.btn_showEntitiesTooltips, "onRollOut");
            uiApi.addComponentHook(this.btn_highlightInteractiveElements, "onPress");
            uiApi.addComponentHook(this.btn_highlightInteractiveElements, "onMouseUp");
            uiApi.addComponentHook(this.btn_highlightInteractiveElements, "onRollOver");
            uiApi.addComponentHook(this.btn_highlightInteractiveElements, "onRollOut");
            uiApi.addComponentHook(this.btn_viewFights, "onRollOver");
            uiApi.addComponentHook(this.btn_viewFights, "onRollOut");
            uiApi.addComponentHook(this.btn_showFightPositions, "onPress");
            uiApi.addComponentHook(this.btn_showFightPositions, "onMouseUp");
            uiApi.addComponentHook(this.btn_showFightPositions, "onRollOver");
            uiApi.addComponentHook(this.btn_showFightPositions, "onRollOut");
            sysApi.addHook(MapComplementaryInformationsData, this.onMapComplementaryInformationsData);
            sysApi.addHook(d2hooks.ShowEntitiesTooltips, this.onShowEntitiesTooltips);
            sysApi.addHook(d2hooks.HighlightInteractiveElements, this.onHighlightInteractiveElements);
            sysApi.addHook(MapFightCount, this.onMapFightCount);
            sysApi.addHook(ConfigPropertyChange, this.onConfigPropertyChange);
            sysApi.addHook(d2hooks.ShowFightPositions, this.onShowFightPositions);
            uiApi.addShortcutHook("flagCurrentMap", this.onShortcut);
            sysApi.sendAction(new PrismsListRegister("BannerMap", PrismListenEnum.PRISM_LISTEN_ALL));
            if (!__subAreasInfos)
            {
                sysApi.sendAction(new AnomalySubareaInformationRequest("cartography.Cartography"));
            };
            this.btn_viewFights.softDisabled = (_nFightCount == 0);
            this.btn_viewFights.mouseEnabled = (!(this.btn_viewFights.softDisabled));
            this._refreshTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onLockTimerComplete);
            this._refreshLocked = false;
        }

        public function hide():void
        {
            sysApi.sendAction(new PrismsListRegister("BannerMap", PrismListenEnum.PRISM_LISTEN_NONE));
            this.mainCtr.visible = false;
        }

        public function show():void
        {
            this.mainCtr.visible = true;
            sysApi.sendAction(new PrismsListRegister("BannerMap", PrismListenEnum.PRISM_LISTEN_ALL));
        }

        public function set activated(value:Boolean):void
        {
            if (value)
            {
                sysApi.sendAction(new PrismsListRegister("BannerMap", PrismListenEnum.PRISM_LISTEN_ALL));
            }
            else
            {
                sysApi.sendAction(new PrismsListRegister("BannerMap", PrismListenEnum.PRISM_LISTEN_NONE));
            };
            uiApi.me().visible = value;
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_viewFights:
                    if (!uiApi.getUi(UIEnum.SPECTATOR_UI))
                    {
                        if (_nFightCount > 0)
                        {
                            sysApi.sendAction(new OpenCurrentFight());
                        };
                    }
                    else
                    {
                        uiApi.unloadUi(UIEnum.SPECTATOR_UI);
                    };
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            var p:MapPosition;
            var flagId:String;
            switch (s)
            {
                case "flagCurrentMap":
                    p = dataApi.getMapInfo(playerApi.currentMap().mapId);
                    flagId = ((("flag_custom_" + p.posX) + "_") + p.posY);
                    sysApi.dispatchHook(AddMapFlag, flagId, (((((uiApi.getText("ui.cartography.customFlag") + " (") + p.posX) + ",") + p.posY) + ")"), p.worldMap, p.posX, p.posY, 0xFFDD00, true);
                    return (true);
            };
            return (false);
        }

        override public function onCloseUi(pShortCut:String):Boolean
        {
            return (false);
        }

        override public function onPress(target:Object):void
        {
            super.onPress(target);
            switch (target)
            {
                case this.btn_showEntitiesTooltips:
                    if (!this._entitiesTooltipsVisible)
                    {
                        sysApi.sendAction(new d2actions.ShowEntitiesTooltips(false));
                    };
                    break;
                case this.btn_highlightInteractiveElements:
                    if (!this._interactiveElementsHighlighted)
                    {
                        sysApi.sendAction(new d2actions.HighlightInteractiveElements(false));
                    };
                    break;
                case this.btn_showFightPositions:
                    if (!this._fightPositionsVisible)
                    {
                        sysApi.sendAction(new d2actions.ShowFightPositions(false));
                    };
                    break;
            };
        }

        public function onMouseUp(target:Object):void
        {
            switch (target)
            {
                case this.btn_showEntitiesTooltips:
                    if (this._entitiesTooltipsVisible)
                    {
                        sysApi.sendAction(new d2actions.ShowEntitiesTooltips(false));
                    };
                    break;
                case this.btn_highlightInteractiveElements:
                    if (this._interactiveElementsHighlighted)
                    {
                        sysApi.sendAction(new d2actions.HighlightInteractiveElements(false));
                    };
                    break;
                case this.btn_showFightPositions:
                    if (this._fightPositionsVisible)
                    {
                        sysApi.sendAction(new d2actions.ShowFightPositions(false));
                    };
            };
        }

        override public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var textKey:String;
            var data:Object;
            var text:String;
            var m:Array;
            if (!this.mainCtr.visible)
            {
                return;
            };
            super.onRollOver(target);
            var point:uint = 7;
            var relPoint:uint = 1;
            var shortcutKey:String;
            switch (target)
            {
                case this.btn_showEntitiesTooltips:
                    textKey = "ui.option.entitiesTooltips.hold";
                    shortcutKey = bindsApi.getShortcutBindStr("showEntitiesTooltips");
                    break;
                case this.btn_highlightInteractiveElements:
                    textKey = "ui.option.highlightInteractiveElements.hold";
                    shortcutKey = bindsApi.getShortcutBindStr("highlightInteractiveElements");
                    break;
                case this.btn_viewFights:
                    tooltipText = uiApi.getText("ui.fightsOnMap", _nFightCount);
                    tooltipText = uiApi.processText(tooltipText, "m", (_nFightCount < 2), (_nFightCount == 0));
                    break;
                case this.btn_showFightPositions:
                    textKey = "ui.option.fightPositions.hold";
                    shortcutKey = bindsApi.getShortcutBindStr("showFightPositions");
                    break;
            };
            if (((tooltipText) || (textKey)))
            {
                if (shortcutKey)
                {
                    if (!_shortcutColor)
                    {
                        _shortcutColor = sysApi.getConfigEntry("colors.shortcut");
                        _shortcutColor = _shortcutColor.replace("0x", "#");
                    };
                    shortcutKey = (((("<font color='" + _shortcutColor) + "'>(") + shortcutKey) + ")</font>");
                }
                else
                {
                    shortcutKey = "";
                };
                if (shortcutKey != null)
                {
                    if (tooltipText)
                    {
                        data = uiApi.textTooltipInfo((tooltipText + ((shortcutKey.length) ? (" " + shortcutKey) : "")));
                    }
                    else
                    {
                        if (textKey)
                        {
                            text = uiApi.getText(textKey, shortcutKey);
                            m = text.match(/(?:\s)\s/g);
                            if (m.length)
                            {
                                text = text.replace(m[0], " ");
                            };
                            data = uiApi.textTooltipInfo(text);
                        };
                    };
                }
                else
                {
                    data = uiApi.textTooltipInfo(tooltipText);
                };
                uiApi.showTooltip(data, target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        override public function onRollOut(target:Object):void
        {
            if (!this.mainCtr.visible)
            {
                return;
            };
            super.onRollOut(target);
        }

        override public function onMapRollOver(target:Object, x:int, y:int, searchSubArea:SubArea=null):void
        {
            if (!this.mainCtr.visible)
            {
                return;
            };
            if (!this._refreshLocked)
            {
                sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_GUILD_ONLY));
                this._refreshTimer.start();
                this._refreshLocked = true;
            };
            super.onMapRollOver(target, x, y, searchSubArea);
        }

        override public function onMapRollOut(target:Object):void
        {
            if (!this.mainCtr.visible)
            {
                return;
            };
            super.onMapRollOut(target);
        }

        override public function onMapElementRollOut(map:Object, target:Object):void
        {
            if (!this.mainCtr.visible)
            {
                return;
            };
            super.onMapElementRollOut(map, target);
        }

        override public function onMapElementRollOver(map:Object, target:Object):void
        {
            if (!this.mainCtr.visible)
            {
                return;
            };
            super.onMapElementRollOver(map, target);
        }

        override protected function createContextMenu(contextMenu:Array=null):void
        {
            if (!contextMenu)
            {
                contextMenu = new Array();
            };
            var hintsFilters:Array = new Array();
            var i:int;
            while (i < this._hintCategoryNames.length)
            {
                hintsFilters.push(modContextMenu.createContextMenuItemObject(this._hintCategoryNames[i], this.showFilter, [(i + 1)], false, null, __hintCategoryFiltersList[(i + 1)], false));
                i++;
            };
            contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.map.mapFilters"), null, null, false, hintsFilters));
            super.createContextMenu(contextMenu);
        }

        override protected function getMapPresetsData():Array
        {
            return (sysApi.getData(MAP_PRESET_DATA_NAME, DataStoreEnum.BIND_ACCOUNT));
        }

        override protected function saveCurrentMapPreset():void
        {
            if (__worldMapInfo)
            {
                getMapPresets()[_currentWorldId] = mapViewer.zoomFactor;
                sysApi.setData(MAP_PRESET_DATA_NAME, getMapPresets(), DataStoreEnum.BIND_ACCOUNT);
            };
        }

        override protected function getPresetScale():Number
        {
            return (getMapPresets()[_currentWorldId]);
        }

        override protected function shouldRestorePosition():Boolean
        {
            return (false);
        }

        override protected function onMapHintsFilter(layerId:int, displayed:Boolean, fromCartography:Boolean):void
        {
        }

        override protected function saveMapFilters(pFiltersList:Array, pMapFilterId:String):void
        {
            super.saveMapFilters(pFiltersList, "mapFilters_miniMap");
        }

        private function showFilter(pFilterId:uint):void
        {
            __hintCategoryFiltersList[pFilterId] = (!(__hintCategoryFiltersList[pFilterId]));
            showHints(__hintCategoryFiltersList);
            mapViewer.updateMapElements();
        }

        private function onMapComplementaryInformationsData(map:WorldPointWrapper, subAreaId:int, displayInfo:Boolean):void
        {
            var worldMap:*;
            var outdoorCoordinateX:int;
            var outdoorCoordinateY:int;
            var mapElement:MapElement;
            var hintUri:String;
            var coordinate:BreachWorldMapCoordinate;
            if (sysApi.getPlayerManager().isMapInHavenbag(map.mapId))
            {
                return;
            };
            var hasChangedWorldMap:Boolean;
            var subArea:* = dataApi.getSubArea(subAreaId);
            if (subArea)
            {
                worldMap = subArea.worldmap;
                if (((worldMap) && (!(worldMap.id == _currentWorldId))))
                {
                    __switchingMapUi = false;
                    if (((!(subArea.hasCustomWorldMap)) && (!(playerApi.isInBreach()))))
                    {
                        openNewMap(subArea.area.superArea.worldmap, MAP_TYPE_SUPERAREA, subArea.area.superArea);
                    }
                    else
                    {
                        if (playerApi.isInBreach())
                        {
                            openNewMap(dataApi.getWorldMap(23), MAP_TYPE_SUBAREA, dataApi.getSubArea(904));
                        }
                        else
                        {
                            openNewMap(subArea.worldmap, MAP_TYPE_SUBAREA, subArea);
                        };
                    };
                    hasChangedWorldMap = true;
                };
            };
            var newPlayerPos:WorldPointWrapper = playerApi.currentMap();
            var breachWorldMapCoordinate:BreachWorldMapCoordinate = ((breachApi.breachFrame) ? dataApi.getBreachWorldMapCoordinate(Math.max(dataApi.getBreachMinStageWorldMapCoordinate().mapStage, Math.min(breachApi.getFloor(), dataApi.getBreachMaxStageWorldMapCoordinate().mapStage))) : null);
            if ((((((((__centerOnPlayer) || (hasChangedWorldMap)) || ((!(newPlayerPos.outdoorX == __playerPos.outdoorX)) || (!(newPlayerPos.outdoorY == __playerPos.outdoorY)))) || (breachWorldMapCoordinate)) || (playerApi.isInHouse())) || (playerApi.isIndoor())) || (playerApi.isInBreachSubArea())))
            {
                __centerOnPlayer = false;
                __playerPos = playerApi.currentMap();
                removeFlag("flag_playerPosition");
                outdoorCoordinateX = __playerPos.outdoorX;
                outdoorCoordinateY = __playerPos.outdoorY;
                if (((breachWorldMapCoordinate) && (playerApi.isInBreach())))
                {
                    outdoorCoordinateX = breachWorldMapCoordinate.mapCoordinateX;
                    outdoorCoordinateY = breachWorldMapCoordinate.mapCoordinateY;
                };
                if (((playerApi.isInBreach()) || (playerApi.isInBreachSubArea())))
                {
                    _showMapCoords = false;
                    for each (mapElement in mapViewer.getMapElementsByLayer(MAP_LAYER_BREACH))
                    {
                        mapViewer.removeMapElement(mapElement);
                    };
                    hintUri = uiApi.me().getConstant("hintIcons");
                    for each (coordinate in dataApi.getAllBreachWorldMapCoordinate())
                    {
                        if (!mapViewer.getMapElement(("breachIcon_" + coordinate.mapStage)))
                        {
                            mapViewer.addBreachIcon(MAP_LAYER_BREACH, ("breachIcon_" + coordinate.mapStage), ((hintUri + this.getBreachIconByFloor(coordinate)) + ".png"), coordinate.mapCoordinateX, coordinate.mapCoordinateY, 1.5, ((coordinate.mapStage < 200) ? (uiApi.getText("ui.breach.floors", breachMinStage, coordinate.mapStage)) : (uiApi.getText("ui.breach.floor", coordinate.mapStage))), false, -1, false, HintPriorityEnum.FLAGS);
                        };
                    };
                };
                addFlag("flag_playerPosition", uiApi.getText("ui.cartography.yourposition"), outdoorCoordinateX, outdoorCoordinateY, 39423, false, true, false);
                mapViewer.moveTo(outdoorCoordinateX, outdoorCoordinateY);
            };
        }

        private function getBreachIconByFloor(coord:BreachWorldMapCoordinate):int
        {
            if ((((!(breachApi.breachFrame)) || (!(breachApi.getFloor()))) || (coord.mapStage > breachApi.getFloor())))
            {
                return (coord.unexploredMapIcon);
            };
            return (coord.exploredMapIcon);
        }

        private function onShowEntitiesTooltips(pVisible:Boolean):void
        {
            this._entitiesTooltipsVisible = (this.btn_showEntitiesTooltips.selected = pVisible);
        }

        private function onHighlightInteractiveElements(pVisible:Boolean):void
        {
            this._interactiveElementsHighlighted = (this.btn_highlightInteractiveElements.selected = pVisible);
        }

        private function onMapFightCount(fightCount:uint):void
        {
            _nFightCount = fightCount;
            this.btn_viewFights.softDisabled = (_nFightCount == 0);
            this.btn_viewFights.mouseEnabled = (!(this.btn_viewFights.softDisabled));
        }

        private function onConfigPropertyChange(target:String, name:String, value:*, oldValue:*):void
        {
            gridDisplayed = configApi.getConfigProperty("dofus", "showMiniMapGrid");
        }

        private function onShowFightPositions(pVisible:Boolean):void
        {
            this._fightPositionsVisible = pVisible;
        }

        private function onLockTimerComplete(e:TimerEvent):void
        {
            this._refreshLocked = false;
        }


    }
} Ankama_Cartography.ui

