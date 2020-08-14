package com.ankamagames.dofus.modules.utils.pathfinding.astar
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.modules.utils.pathfinding.world.Node;
    import com.ankamagames.dofus.modules.utils.pathfinding.world.WorldGraph;
    import com.ankamagames.dofus.modules.utils.pathfinding.world.Vertex;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.Event;
    import com.ankamagames.dofus.misc.utils.GameDataQuery;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.modules.utils.pathfinding.world.Edge;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
    import com.ankamagames.dofus.modules.utils.pathfinding.world.Transition;
    import __AS3__.vec.*;

    public class AStar 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(AStar));
        private static var dest:MapPosition;
        private static var closedDic:Dictionary;
        private static var openList:Vector.<Node>;
        private static var openDic:Dictionary;
        private static var iterations:int;
        private static var worldGraph:WorldGraph;
        private static var to:Vertex;
        private static var callback:Function;
        private static var _forbiddenSubareaIds:Vector.<uint>;
        private static const HEURISTIC_SCALE:int = 1;
        private static const INDOOR_WEIGHT:int = 0;
        private static const MAX_ITERATION:int = 10000;


        public static function search(worldGraph:WorldGraph, from:Vertex, _arg_3:Vertex, callback:Function):void
        {
            if (AStar.callback != null)
            {
                throw (new Error("Pathfinding already in progress"));
            };
            if (from == _arg_3)
            {
                (callback(null));
                return;
            };
            initForbiddenSubareaList();
            AStar.worldGraph = worldGraph;
            AStar.to = _arg_3;
            AStar.callback = callback;
            dest = MapPosition.getMapPositionById(_arg_3.mapId);
            closedDic = new Dictionary();
            openList = new Vector.<Node>();
            openDic = new Dictionary();
            iterations = 0;
            openList.push(new Node(from, MapPosition.getMapPositionById(from.mapId)));
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME, compute);
        }

        private static function initForbiddenSubareaList():void
        {
            _forbiddenSubareaIds = GameDataQuery.queryEquals(SubArea, "mountAutoTripAllowed", false);
        }

        public static function stopSearch():void
        {
            if (callback != null)
            {
                callbackWithResult(null);
            };
        }

        private static function compute(e:Event):void
        {
            var current:Node;
            var edges:Vector.<Edge>;
            var oldLength:int;
            var cost:int;
            var edge:Edge;
            var existing:Node;
            var map:MapPosition;
            var manhattanDistance:int;
            var node:Node;
            var start:int = getTimer();
            while (openList.length > 0)
            {
                if (iterations++ > MAX_ITERATION)
                {
                    callbackWithResult(null);
                    _log.error("Too many iterations, aborting A*");
                    return;
                };
                current = openList.shift();
                openDic[current.vertex] = null;
                if (current.vertex == to)
                {
                    _log.debug((("Goal reached with " + iterations.toString()) + " iterations"));
                    callbackWithResult(buildResultPath(worldGraph, current));
                    return;
                };
                edges = worldGraph.getOutgoingEdgesFromVertex(current.vertex);
                oldLength = openList.length;
                cost = (current.cost + 1);
                for each (edge in edges)
                {
                    if (!hasValidTransition(edge))
                    {
                    }
                    else
                    {
                        if (!hasValidDestinationSubarea(edge))
                        {
                        }
                        else
                        {
                            existing = closedDic[edge.to];
                            if (((!(existing == null)) && (cost >= existing.cost)))
                            {
                            }
                            else
                            {
                                existing = openDic[edge.to];
                                if (((!(existing == null)) && (cost >= existing.cost)))
                                {
                                }
                                else
                                {
                                    map = MapPosition.getMapPositionById(edge.to.mapId);
                                    if (map == null)
                                    {
                                        _log.info((("La map " + edge.to.mapId) + " ne semble pas exister"));
                                    }
                                    else
                                    {
                                        manhattanDistance = (Math.abs((map.posX - dest.posX)) + Math.abs((map.posY - dest.posY)));
                                        node = new Node(edge.to, map, cost, ((cost + (HEURISTIC_SCALE * manhattanDistance)) + (((current.map.outdoor) && (!(map.outdoor))) ? INDOOR_WEIGHT : 0)), current);
                                        openList.push(node);
                                        openDic[node.vertex] = node;
                                    };
                                };
                            };
                        };
                    };
                };
                closedDic[current.vertex] = current;
                if (oldLength < openList.length)
                {
                    openList.sort(orderNodes);
                };
                if ((getTimer() - start) > (1000 / StageShareManager.stage.frameRate))
                {
                    return;
                };
            };
            callbackWithResult(null);
        }

        private static function hasValidTransition(edge:Edge):Boolean
        {
            var criterion:GroupItemCriterion;
            var transition:Transition;
            var criterionWhiteList:Array = ["Ad", "DM", "MI", "Mk", "Oc", "Pc", "QF", "Qo", "Qs", "Sv"];
            var valid:Boolean;
            for each (transition in edge.transitions)
            {
                if (transition.criterion.length == 0)
                {
                    valid = true;
                    break;
                };
                if ((((transition.criterion.indexOf("&") == -1) && (transition.criterion.indexOf("|") == -1)) && (!(criterionWhiteList.indexOf(transition.criterion.substr(0, 2)) == -1))))
                {
                    return (false);
                };
                criterion = new GroupItemCriterion(transition.criterion);
                return (criterion.isRespected);
            };
            return (valid);
        }

        private static function hasValidDestinationSubarea(edge:Edge):Boolean
        {
            var fromMapId:Number = edge.from.mapId;
            var fromSubareaId:int = MapPosition.getMapPositionById(fromMapId).subAreaId;
            var toMapId:Number = edge.to.mapId;
            var toSubareaId:int = MapPosition.getMapPositionById(toMapId).subAreaId;
            if (fromSubareaId == toSubareaId)
            {
                return (true);
            };
            if (_forbiddenSubareaIds.indexOf(toSubareaId) != -1)
            {
                return (false);
            };
            return (true);
        }

        private static function callbackWithResult(result:Vector.<Edge>):void
        {
            var cb:Function = callback;
            callback = null;
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, compute);
            (cb(result));
        }

        private static function orderNodes(a:Node, b:Node):int
        {
            return ((a.heuristic == b.heuristic) ? 0 : ((a.heuristic > b.heuristic) ? 1 : -1));
        }

        private static function buildResultPath(worldGraph:WorldGraph, node:Node):Vector.<Edge>
        {
            var result:Vector.<Edge> = new Vector.<Edge>();
            while (node.parent != null)
            {
                result.push(worldGraph.getEdge(node.parent.vertex, node.vertex));
                node = node.parent;
            };
            result.reverse();
            return (result);
        }


    }
} com.ankamagames.dofus.modules.utils.pathfinding.astar

