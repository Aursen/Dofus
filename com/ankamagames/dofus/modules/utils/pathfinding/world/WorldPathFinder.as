package com.ankamagames.dofus.modules.utils.pathfinding.world
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.modules.utils.pathfinding.tools.FileLoader;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.dofus.modules.utils.pathfinding.tools.TimeDebug;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.atouin.data.map.CellData;
    import com.ankamagames.dofus.modules.utils.pathfinding.astar.AStar;
    import __AS3__.vec.Vector;

    public class WorldPathFinder 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WorldPathFinder));
        private static var playedCharacterManager:PlayedCharacterManager;
        private static var worldGraph:WorldGraph;
        private static var callback:Function;
        private static var from:Vertex;
        private static var to:Number;
        private static var linkedZone:int;


        public static function init():void
        {
            if (WorldPathFinder.isInitialized())
            {
                return;
            };
            playedCharacterManager = PlayedCharacterManager.getInstance();
            FileLoader.loadExternalFile(XmlConfig.getInstance().getEntry("config.data.pathFinding"), WorldPathFinder.setData);
        }

        public static function getWorldGraph():WorldGraph
        {
            return (worldGraph);
        }

        public static function isInitialized():Boolean
        {
            return (!(worldGraph == null));
        }

        private static function setData(e:ResourceLoadedEvent):void
        {
            worldGraph = new WorldGraph(e.resource);
        }

        public static function findPath(destinationMapId:Number, callback:Function):void
        {
            if (!WorldPathFinder.isInitialized())
            {
                (callback(null));
                return;
            };
            playedCharacterManager = PlayedCharacterManager.getInstance();
            _log.info(("Start searching path to " + destinationMapId.toString()));
            TimeDebug.reset();
            var playedEntity:IEntity = DofusEntities.getEntity(playedCharacterManager.id);
            var playedEntityCellId:uint = playedEntity.position.cellId;
            var playerCell:CellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[playedEntityCellId];
            from = worldGraph.getVertex(playedCharacterManager.currentMap.mapId, playerCell.linkedZoneRP);
            if (from == null)
            {
                (callback(null));
                return;
            };
            linkedZone = 1;
            WorldPathFinder.callback = callback;
            to = destinationMapId;
            next();
        }

        public static function abortPathSearch():void
        {
            AStar.stopSearch();
        }

        private static function onAStarComplete(path:Vector.<Edge>):void
        {
            var cb:Function;
            if (path == null)
            {
                next();
            }
            else
            {
                _log.info((((("path to map " + to.toString()) + " found in ") + TimeDebug.getElapsedTimeInSeconds().toString()) + "s"));
                cb = callback;
                callback = null;
                (cb(path));
            };
        }

        private static function next():void
        {
            var cb:Function;
            var dest:Vertex = worldGraph.getVertex(to, linkedZone++);
            if (dest == null)
            {
                _log.info(("no path found to go to map " + to.toString()));
                cb = callback;
                callback = null;
                (cb(null));
                return;
            };
            AStar.search(worldGraph, from, dest, onAStarComplete);
        }


    }
}

