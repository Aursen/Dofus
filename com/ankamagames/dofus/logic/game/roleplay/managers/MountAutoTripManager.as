package com.ankamagames.dofus.logic.game.roleplay.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.modules.utils.pathfinding.world.Edge;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayWorldFrame;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.dofus.modules.utils.pathfinding.world.WorldPathFinder;
    import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
    import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.dofus.modules.utils.pathfinding.world.Transition;
    import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
    import com.ankamagames.atouin.messages.CellClickMessage;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
    import com.ankamagames.dofus.modules.utils.pathfinding.world.TransitionTypeEnum;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.atouin.data.map.Map;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.atouin.data.map.Cell;
    import flash.geom.Point;
    import com.ankamagames.atouin.managers.FrustumManager;
    import com.ankamagames.atouin.utils.CellUtil;
    import com.ankamagames.atouin.data.map.CellData;
    import com.ankamagames.berilia.components.MapViewer;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.berilia.types.data.MapElement;
    import __AS3__.vec.*;

    public final class MountAutoTripManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MountAutoTripManager));
        public static const ANIM_FUN_TIMER_MIN:int = 40000;
        private static var _self:MountAutoTripManager;

        private var _travelling:Boolean;
        private var _routeCalculating:Boolean;
        private var _destinationMapPosition:MapPosition;
        private var _currentRoute:Vector.<Edge>;
        private var _nextRouteStageIndex:int = 0;
        private var _nextRouteStageMessage:Message;
        private var _roleplayWorldFrame:RoleplayWorldFrame;
        private var _roleplayEntitiesFrame:RoleplayEntitiesFrame;
        private var _popupName:String;

        public function MountAutoTripManager()
        {
            if (_self)
            {
                throw (new SingletonError());
            };
            this._roleplayWorldFrame = (Kernel.getWorker().getFrame(RoleplayWorldFrame) as RoleplayWorldFrame);
            this._roleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
        }

        public static function getInstance():MountAutoTripManager
        {
            if (!_self)
            {
                _self = new (MountAutoTripManager)();
            };
            return (_self);
        }


        public function get isTravelling():Boolean
        {
            return (this._travelling);
        }

        public function initNewTrip(mapId:Number):void
        {
            if (this._routeCalculating)
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.error.alreadySearchingRoute"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                _log.debug("Une recherche d'itinéraire est deja en cours");
                return;
            };
            if (this._travelling)
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.error.alreadyTraveling"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                _log.debug("Un voyage est deja en cours, il faut le stopper pour pouvoir en lancer un autre");
                return;
            };
            if (((PlayedCharacterManager.getInstance().isSpectator) || (PlayedCharacterManager.getInstance().isFighting)))
            {
                _log.debug("Impossible de voyager en étant en combat");
                return;
            };
            if (((PlayedCharacterManager.getInstance().isInHouse) || (PlayedCharacterManager.getInstance().isInHavenbag)))
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.fight.wrongMap"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                _log.debug("Impossible de voyager depuis un intérieur");
                return;
            };
            if (!mapId)
            {
                return;
            };
            this._destinationMapPosition = MapPosition.getMapPositionById(mapId);
            if (((!(this._destinationMapPosition)) || (!(this._destinationMapPosition.subArea))))
            {
                _log.debug(("La sous-zone est introuvable pour la map " + mapId));
                return;
            };
            var destinationSubArea:SubArea = this._destinationMapPosition.subArea;
            if (((!(destinationSubArea.mountAutoTripAllowed)) && (!(PlayerManager.getInstance().hasRights))))
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.error.forbiddenDestinationSubarea", [destinationSubArea.name]), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                _log.debug(("Le voyage automatique de monture est interdit vers la zone " + destinationSubArea.name));
                return;
            };
            var currentSubArea:SubArea = PlayedCharacterManager.getInstance().currentSubArea;
            if (((!(currentSubArea.mountAutoTripAllowed)) && (!(PlayerManager.getInstance().hasRights))))
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.error.forbiddenStartSubarea", [currentSubArea.name]), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                _log.debug(("Le voyage automatique de monture est interdit depuis la zone " + currentSubArea.name));
                return;
            };
            this._routeCalculating = true;
            var destMapName:* = (((((((("{map," + this._destinationMapPosition.posX) + ",") + this._destinationMapPosition.posY) + ",") + this._destinationMapPosition.worldMap) + "} (") + this._destinationMapPosition.subArea.name) + ")");
            var commonMod:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            this._popupName = commonMod.openPopup(I18n.getUiText("ui.mountTrip.trip"), I18n.getUiText("ui.mountTrip.searchingRoute", [destMapName]), [I18n.getUiText("ui.common.ok"), I18n.getUiText("ui.common.cancel")], [null, this.onAbortTripByPopup], null, null, null, false, true);
            _log.debug((("Calcul de l'itinéraire vers " + mapId) + " en cours..."));
            WorldPathFinder.findPath(mapId, this.onRouteFound);
        }

        public function stopCurrentTrip():void
        {
            if (!this._travelling)
            {
                return;
            };
            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.tripManuallyStopped"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
            _log.debug("Le voyage de monture a été stoppé");
            this.endTrip(false);
        }

        public function startNextTripStage(mapId:Number):void
        {
            if (!this._travelling)
            {
                return;
            };
            if (this._nextRouteStageIndex >= this._currentRoute.length)
            {
                this.endTrip();
                return;
            };
            if (((PlayedCharacterManager.getInstance().isSpectator) || (PlayedCharacterManager.getInstance().isFighting)))
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.error.fight"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                _log.debug("Impossible de voyager en étant en combat");
                this.endTrip(false);
                return;
            };
            var nextEdge:Edge = this._currentRoute[this._nextRouteStageIndex];
            if (mapId != nextEdge.from.mapId)
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.error.wrongMap"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                _log.debug((((((("La map actuelle (map id actuelle : " + mapId) + ") n'est pas celle prévue (map id prévue : ") + nextEdge.from.mapId) + " à l'étape ") + this._nextRouteStageIndex) + "), annulation du voyage"));
                this.endTrip(false);
                return;
            };
            this.createNextMessage();
            if (this._travelling)
            {
                this._nextRouteStageIndex++;
                this.updateRouteDrawing();
                if (!this._nextRouteStageMessage)
                {
                    this.endTrip(false);
                    return;
                };
                this._roleplayWorldFrame.process(this._nextRouteStageMessage);
            };
        }

        private function endTrip(success:Boolean=true):void
        {
            if (success)
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.tripSuccess"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                if (ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.RIDE_TRAVEL_END))
                {
                    KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.RIDE_TRAVEL_END);
                };
                _log.debug("Vous êtes arrivé à destination !");
            };
            this._travelling = false;
            this._routeCalculating = false;
            this._destinationMapPosition = null;
            this._currentRoute = null;
            this._nextRouteStageIndex = 0;
            this._nextRouteStageMessage = null;
            this.eraseRoute();
            Berilia.getInstance().unloadUi(this._popupName, true);
        }

        private function onRouteFound(path:Vector.<Edge>):void
        {
            var e:Edge;
            var destMapName:String;
            var currentRouteText:String;
            Berilia.getInstance().unloadUi(this._popupName, true);
            if (!this._routeCalculating)
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.routeSearchStopped"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                _log.debug("Le calcul d'itinéraire a été stoppé !");
                return;
            };
            this._routeCalculating = false;
            this._currentRoute = path;
            var commonMod:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            if (((!(path)) || (!(path.length))))
            {
                _log.debug("Aucun itinéraire n'a été trouvé ! Des obstacles (océans, map interdites, montagnes, cours d'eau...) doivent empecher votre monture de se rendre à la map voulue.");
                this._popupName = commonMod.openPopup(I18n.getUiText("ui.mountTrip.trip"), I18n.getUiText("ui.mountTrip.error.noRoute"), [I18n.getUiText("ui.common.ok")], [null]);
                return;
            };
            _log.debug("Un itinéraire a été trouvé !");
            for each (e in path)
            {
                _log.warn((" - " + e.toString()));
            };
            destMapName = (((((((("{map," + this._destinationMapPosition.posX) + ",") + this._destinationMapPosition.posY) + ",") + this._destinationMapPosition.worldMap) + "} (") + this._destinationMapPosition.subArea.name) + ")");
            currentRouteText = I18n.getUiText("ui.mountTrip.routeFound", [destMapName, path.length]);
            currentRouteText = (currentRouteText + this.getPotentialLackOfEnergyText());
            currentRouteText = (currentRouteText + ("\n\n" + I18n.getUiText("ui.mountTrip.confirmTripStart")));
            this._popupName = commonMod.openPopup(I18n.getUiText("ui.mountTrip.trip"), currentRouteText, [I18n.getUiText("ui.common.ok"), I18n.getUiText("ui.common.cancel")], [this.onStartTripByPopup, this.onAbortTripByPopup], this.onStartTripByPopup, this.onAbortTripByPopup, null, false, true);
        }

        private function onAbortTripByPopup():void
        {
            if (this._routeCalculating)
            {
                WorldPathFinder.abortPathSearch();
                this._routeCalculating = false;
            };
            this.endTrip(false);
        }

        private function onStartTripByPopup():void
        {
            this.drawRoute();
            this._travelling = true;
            this.startNextTripStage(PlayedCharacterManager.getInstance().currentMap.mapId);
        }

        private function createNextMessage():void
        {
            var transitionToUse:Transition;
            var transitionCellId:int;
            var adjacentMapClickMessage:AdjacentMapClickMessage;
            var cellClickMessage:CellClickMessage;
            var interactiveElementToActivate:InteractiveElement;
            var elementPosition:MapPoint;
            var elementSkillInstanceId:int;
            var interactiveElementActivationMessage:InteractiveElementActivationMessage;
            var found:Boolean;
            var elementId:String;
            var cie:InteractiveElement;
            var skill:InteractiveElementSkill;
            var nextEdge:Edge = this._currentRoute[this._nextRouteStageIndex];
            transitionToUse = nextEdge.transitions[0];
            switch (transitionToUse.type)
            {
                case TransitionTypeEnum.SCROLL:
                case TransitionTypeEnum.SCROLL_ACTION:
                    transitionCellId = -1;
                    if (transitionToUse.cell == -1)
                    {
                        transitionCellId = this.getClosestTransitionCellId(transitionToUse.direction);
                    }
                    else
                    {
                        transitionCellId = transitionToUse.cell;
                    };
                    if (transitionCellId == -1)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.error.noChangeMapCell"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        _log.error("Aucune cellule de transition utilisable");
                        this.endTrip(false);
                        return;
                    };
                    adjacentMapClickMessage = new AdjacentMapClickMessage();
                    adjacentMapClickMessage.adjacentMapId = transitionToUse.transitionMapId;
                    adjacentMapClickMessage.cellId = transitionCellId;
                    adjacentMapClickMessage.fromAutotrip = true;
                    this._nextRouteStageMessage = adjacentMapClickMessage;
                    break;
                case TransitionTypeEnum.MAP_ACTION:
                    cellClickMessage = new CellClickMessage();
                    cellClickMessage.cellId = transitionToUse.cell;
                    cellClickMessage.id = PlayedCharacterManager.getInstance().currentMap.mapId;
                    cellClickMessage.fromAutotrip = true;
                    this._nextRouteStageMessage = cellClickMessage;
                    break;
                case TransitionTypeEnum.INTERACTIVE:
                    this._roleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                    if (this._roleplayEntitiesFrame)
                    {
                        found = false;
                        for (elementId in this._roleplayEntitiesFrame.interactiveElements)
                        {
                            cie = this._roleplayEntitiesFrame.interactiveElements[int(elementId)];
                            if (cie.elementId == transitionToUse.id)
                            {
                                found = true;
                                interactiveElementToActivate = cie;
                                break;
                            };
                        };
                    };
                    if (!interactiveElementToActivate)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.mountTrip.error.noChangeMapInteractiveElement"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        _log.error((("L'élément interactif " + transitionToUse.id) + " à activer est introuvable."));
                        this.endTrip(false);
                        return;
                    };
                    elementPosition = MapPoint.fromCellId(transitionToUse.cell);
                    if (((interactiveElementToActivate.enabledSkills) && (interactiveElementToActivate.enabledSkills.length == 1)))
                    {
                        elementSkillInstanceId = interactiveElementToActivate.enabledSkills[0].skillInstanceUid;
                    }
                    else
                    {
                        for each (skill in interactiveElementToActivate.enabledSkills)
                        {
                            if (skill.skillId == transitionToUse.skillId)
                            {
                                elementSkillInstanceId = skill.skillInstanceUid;
                            };
                        };
                    };
                    interactiveElementActivationMessage = new InteractiveElementActivationMessage(interactiveElementToActivate, elementPosition, elementSkillInstanceId);
                    interactiveElementActivationMessage.fromAutotrip = true;
                    this._nextRouteStageMessage = interactiveElementActivationMessage;
                    break;
            };
        }

        private function getClosestTransitionCellId(direction:int):int
        {
            var cellId:int;
            var dataMap:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
            var playedEntity:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            var playedEntityCellId:uint = playedEntity.position.cellId;
            var myMapLinkedZone:int = dataMap.cells[playedEntityCellId].linkedZoneRP;
            var staticPoint:Point = Cell.cellPixelCoords(playedEntityCellId);
            var playedEntityCellPoint:Point = new Point(staticPoint.x, staticPoint.y);
            var closestCellForMapChange:Object = FrustumManager.getInstance().findNearestBorderCellFromPoint(direction, playedEntityCellPoint);
            cellId = closestCellForMapChange.cell;
            if (!CellUtil.isValidCellIndex(cellId))
            {
                _log.error(("Erreur avec la cellule " + cellId));
                return (-1);
            };
            var cell:CellData = dataMap.cells[cellId];
            if ((((!(cell)) || (!(cell.mov))) || (!(cell.linkedZoneRP == myMapLinkedZone))))
            {
                _log.error(("Erreur avec la cellule " + cellId));
                return (-1);
            };
            return (cellId);
        }

        private function getPotentialLackOfEnergyText():String
        {
            var mount:Object = PlayedCharacterManager.getInstance().mount;
            if (mount.energy >= this._currentRoute.length)
            {
                return ("");
            };
            var text:String = ("\n\n" + I18n.getUiText("ui.mountTrip.warning.notEnoughEnergy"));
            return (text);
        }

        private function drawRoute():void
        {
            var mapViewerBig:MapViewer;
            var from:MapPosition;
            var _local_6:MapPosition;
            var edge:Edge;
            var destinationMapId:Number;
            var destinationPosition:MapPosition;
            var iconUri:String;
            var destinationLabel:String;
            var worldMapBanner:UiRootContainer = Berilia.getInstance().getUi("bannerMap");
            var worldMap:UiRootContainer = Berilia.getInstance().getUi("cartographyUi");
            if (((worldMap == null) && (worldMapBanner == null)))
            {
                return;
            };
            var mapViewer:MapViewer = worldMapBanner.uiClass.mapViewer;
            if (worldMap)
            {
                mapViewerBig = worldMap.uiClass.mapViewer;
            };
            this.removeMountTripMapElements(mapViewer);
            if (mapViewerBig)
            {
                this.removeMountTripMapElements(mapViewerBig);
            };
            var coordList:Vector.<int> = new Vector.<int>();
            for each (edge in this._currentRoute)
            {
                if (coordList.length == 0)
                {
                    from = MapPosition.getMapPositionById(edge.from.mapId);
                    coordList.push(from.posX);
                    coordList.push(from.posY);
                };
                _local_6 = MapPosition.getMapPositionById(edge.to.mapId);
                coordList.push(_local_6.posX);
                coordList.push(_local_6.posY);
            };
            destinationMapId = this._currentRoute[(this._currentRoute.length - 1)].to.mapId;
            destinationPosition = MapPosition.getMapPositionById(destinationMapId);
            mapViewer.addRouteShape("mountTripLayer", ("mountTrip" + destinationMapId), coordList, 6750207, 0.9, 10, 6750207, 0.3);
            iconUri = (worldMapBanner.getConstant("hintIcons") + "destination.png");
            destinationLabel = I18n.getUiText("ui.zaap.destination");
            mapViewer.addIcon("mountTripLayer", ("mountTripEnd" + destinationMapId), iconUri, destinationPosition.posX, destinationPosition.posY, 1, destinationLabel);
            mapViewer.updateMapElements();
            if (mapViewerBig)
            {
                mapViewerBig.updateMapElements();
            };
        }

        private function updateRouteDrawing():void
        {
            var worldMapBanner:UiRootContainer = Berilia.getInstance().getUi("bannerMap");
            if (worldMapBanner == null)
            {
                return;
            };
            var mapViewer:MapViewer = worldMapBanner.uiClass.mapViewer;
            var currentMap:WorldPointWrapper = PlayedCharacterManager.getInstance().currentMap;
            mapViewer.updateRouteShapeCompletion(("mountTrip" + this._currentRoute[(this._currentRoute.length - 1)].to.mapId), currentMap.outdoorX, currentMap.outdoorY);
        }

        private function eraseRoute():void
        {
            var mapViewerBig:MapViewer;
            var worldMapBanner:UiRootContainer = Berilia.getInstance().getUi("bannerMap");
            var worldMap:UiRootContainer = Berilia.getInstance().getUi("cartographyUi");
            if (((worldMap == null) && (worldMapBanner == null)))
            {
                return;
            };
            var mapViewer:MapViewer = worldMapBanner.uiClass.mapViewer;
            if (worldMap)
            {
                mapViewerBig = worldMap.uiClass.mapViewer;
            };
            this.removeMountTripMapElements(mapViewer);
            mapViewer.updateMapElements();
            if (mapViewerBig)
            {
                this.removeMountTripMapElements(mapViewerBig);
                mapViewerBig.updateMapElements();
            };
        }

        private function removeMountTripMapElements(mapViewer:MapViewer):void
        {
            var oldRouteElement:MapElement;
            var oldRouteElements:Array = mapViewer.getMapElementsByLayer("mountTripLayer");
            for each (oldRouteElement in oldRouteElements)
            {
                mapViewer.removeMapElement(oldRouteElement);
            };
        }


    }
}

