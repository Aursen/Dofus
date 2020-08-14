package com.ankamagames.jerakine.pathfinding
{
    import __AS3__.vec.Vector;
    import mapTools.MapTools;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.jerakine.types.positions.PathElement;
    import com.ankamagames.jerakine.map.IDataMapProvider;
    import __AS3__.vec.*;

    public class Pathfinding 
    {

        private static const HV_COST:uint = 10;
        private static const DIAG_COST:uint = 15;
        private static const HEURISTIC_COST:uint = 10;
        private static const INFINITE_COST:int = 99999999;
        private static var _isInit:Boolean = false;
        private static var _parentOfCell:Vector.<int>;
        private static var _costOfCell:Vector.<int>;
        private static var _openListWeights:Vector.<int>;
        private static var _isCellClosed:Vector.<Boolean>;
        private static var _isEntityOnCell:Vector.<Boolean>;
        private static var _openList:FastIntArray;


        public static function findPath(map:IDataMapProvider, start:MapPoint, end:MapPoint, allowDiag:Boolean=true, bAllowTroughEntity:Boolean=true, avoidObstacles:Boolean=true):MovementPath
        {
            var i:uint;
            var minimum:Number;
            var smallestCostIndex:uint;
            var parentId:int;
            var parentX:int;
            var parentY:int;
            var y:int;
            var cost:Number;
            var x:int;
            var cellId:int;
            var pointWeight:Number;
            var movementCost:int;
            var speed:int;
            var cellOnEndColumn:Boolean;
            var cellOnStartColumn:Boolean;
            var cellOnEndLine:Boolean;
            var cellOnStartLine:Boolean;
            var distanceTmpToEnd:int;
            var heuristic:Number;
            var parent:int;
            var grandParent:int;
            var grandGrandParent:int;
            var kX:int;
            var kY:int;
            var nextX:int;
            var nextY:int;
            var interX:int;
            var interY:int;
            var endCellId:int = end.cellId;
            var startCellId:int = start.cellId;
            var endX:int = end.x;
            var endY:int = end.y;
            var endCellAuxId:int = startCellId;
            var distanceToEnd:int = MapTools.getDistance(startCellId, endCellId);
            if (!_isInit)
            {
                _costOfCell = new Vector.<int>(MapTools.mapCountCell, true);
                _openListWeights = new Vector.<int>(MapTools.mapCountCell, true);
                _parentOfCell = new Vector.<int>(MapTools.mapCountCell, true);
                _isCellClosed = new Vector.<Boolean>(MapTools.mapCountCell, true);
                _isEntityOnCell = new Vector.<Boolean>(MapTools.mapCountCell, true);
                _openList = new FastIntArray(40);
                _isInit = true;
            };
            i = 0;
            while (i < MapTools.mapCountCell)
            {
                _parentOfCell[i] = MapTools.INVALID_CELL_ID;
                _isCellClosed[i] = false;
                _isEntityOnCell[i] = false;
                i++;
            };
            _openList.clear();
            map.fillEntityOnCellArray(_isEntityOnCell, bAllowTroughEntity);
            _costOfCell[startCellId] = 0;
            _openList.push(startCellId);
            while (((_openList.length > 0) && (_isCellClosed[endCellId] == false)))
            {
                minimum = INFINITE_COST;
                smallestCostIndex = 0;
                i = 0;
                while (i < _openList.length)
                {
                    cost = _openListWeights[_openList.data[i]];
                    if (cost <= minimum)
                    {
                        minimum = cost;
                        smallestCostIndex = i;
                    };
                    i++;
                };
                parentId = _openList.data[smallestCostIndex];
                parentX = MapTools.getCellIdXCoord(parentId);
                parentY = MapTools.getCellIdYCoord(parentId);
                _openList.removeAt(smallestCostIndex);
                _isCellClosed[parentId] = true;
                y = (parentY - 1);
                while (y <= (parentY + 1))
                {
                    x = (parentX - 1);
                    while (x <= (parentX + 1))
                    {
                        cellId = MapTools.getCellIdByCoord(x, y);
                        if ((((((!(cellId == MapTools.INVALID_CELL_ID)) && (_isCellClosed[cellId] == false)) && (!(cellId == parentId))) && (map.pointMov(x, y, bAllowTroughEntity, parentId, endCellId, avoidObstacles))) && (((y == parentY) || (x == parentX)) || ((allowDiag) && ((map.pointMov(parentX, y, bAllowTroughEntity, parentId, endCellId, avoidObstacles)) || (map.pointMov(x, parentY, bAllowTroughEntity, parentId, endCellId, avoidObstacles)))))))
                        {
                            pointWeight = 0;
                            if (cellId == endCellId)
                            {
                                pointWeight = 1;
                            }
                            else
                            {
                                speed = map.getCellSpeed(cellId);
                                if (bAllowTroughEntity)
                                {
                                    if (_isEntityOnCell[cellId])
                                    {
                                        pointWeight = 20;
                                    }
                                    else
                                    {
                                        if (speed >= 0)
                                        {
                                            pointWeight = (6 - speed);
                                        }
                                        else
                                        {
                                            pointWeight = (12 + Math.abs(speed));
                                        };
                                    };
                                }
                                else
                                {
                                    pointWeight = 1;
                                    if (_isEntityOnCell[cellId])
                                    {
                                        pointWeight = (pointWeight + 0.3);
                                    };
                                    if (((MapTools.isValidCoord((x + 1), y)) && (_isEntityOnCell[MapTools.getCellIdByCoord((x + 1), y)])))
                                    {
                                        pointWeight = (pointWeight + 0.3);
                                    };
                                    if (((MapTools.isValidCoord(x, (y + 1))) && (_isEntityOnCell[MapTools.getCellIdByCoord(x, (y + 1))])))
                                    {
                                        pointWeight = (pointWeight + 0.3);
                                    };
                                    if (((MapTools.isValidCoord((x - 1), y)) && (_isEntityOnCell[MapTools.getCellIdByCoord((x - 1), y)])))
                                    {
                                        pointWeight = (pointWeight + 0.3);
                                    };
                                    if (((MapTools.isValidCoord(x, (y - 1))) && (_isEntityOnCell[MapTools.getCellIdByCoord(x, (y - 1))])))
                                    {
                                        pointWeight = (pointWeight + 0.3);
                                    };
                                    if ((map.pointSpecialEffects(x, y) & 0x02) == 2)
                                    {
                                        pointWeight = (pointWeight + 0.2);
                                    };
                                };
                            };
                            movementCost = (_costOfCell[parentId] + ((((y == parentY) || (x == parentX)) ? HV_COST : DIAG_COST) * pointWeight));
                            if (bAllowTroughEntity)
                            {
                                cellOnEndColumn = ((x + y) == (endX + endY));
                                cellOnStartColumn = ((x + y) == (start.x + start.y));
                                cellOnEndLine = ((x - y) == (endX - endY));
                                cellOnStartLine = ((x - y) == (start.x - start.y));
                                if ((((!(cellOnEndColumn)) && (!(cellOnEndLine))) || ((!(cellOnStartColumn)) && (!(cellOnStartLine)))))
                                {
                                    movementCost = (movementCost + MapTools.getDistance(cellId, endCellId));
                                    movementCost = (movementCost + MapTools.getDistance(cellId, startCellId));
                                };
                                if (((x == endX) || (y == endY)))
                                {
                                    movementCost = (movementCost - 3);
                                };
                                if (((((cellOnEndColumn) || (cellOnEndLine)) || ((x + y) == (parentX + parentY))) || ((x - y) == (parentX - parentY))))
                                {
                                    movementCost = (movementCost - 2);
                                };
                                if (((i == start.x) || (y == start.y)))
                                {
                                    movementCost = (movementCost - 3);
                                };
                                if (((cellOnStartColumn) || (cellOnStartLine)))
                                {
                                    movementCost = (movementCost - 2);
                                };
                                distanceTmpToEnd = MapTools.getDistance(cellId, endCellId);
                                if (distanceTmpToEnd < distanceToEnd)
                                {
                                    endCellAuxId = cellId;
                                    distanceToEnd = distanceTmpToEnd;
                                };
                            };
                            if (((_parentOfCell[cellId] == MapTools.INVALID_CELL_ID) || (movementCost < _costOfCell[cellId])))
                            {
                                _parentOfCell[cellId] = parentId;
                                _costOfCell[cellId] = movementCost;
                                heuristic = (HEURISTIC_COST * Math.sqrt((((endY - y) * (endY - y)) + ((endX - x) * (endX - x)))));
                                _openListWeights[cellId] = (heuristic + movementCost);
                                if (_openList.indexOf(cellId) == -1)
                                {
                                    _openList.push(cellId);
                                };
                            };
                        };
                        x++;
                    };
                    y++;
                };
            };
            var movPath:MovementPath = new MovementPath();
            movPath.start = start;
            if (_parentOfCell[endCellId] == MapTools.INVALID_CELL_ID)
            {
                endCellId = endCellAuxId;
                movPath.end = MapPoint.fromCellId(endCellId);
            }
            else
            {
                movPath.end = end;
            };
            var cursor:int = endCellId;
            while (cursor != startCellId)
            {
                if (allowDiag)
                {
                    parent = _parentOfCell[cursor];
                    grandParent = ((parent == MapTools.INVALID_CELL_ID) ? MapTools.INVALID_CELL_ID : _parentOfCell[parent]);
                    grandGrandParent = ((grandParent == MapTools.INVALID_CELL_ID) ? MapTools.INVALID_CELL_ID : _parentOfCell[grandParent]);
                    kX = MapTools.getCellIdXCoord(cursor);
                    kY = MapTools.getCellIdYCoord(cursor);
                    if (((!(grandParent == MapTools.INVALID_CELL_ID)) && (MapTools.getDistance(cursor, grandParent) == 1)))
                    {
                        if (map.pointMov(kX, kY, bAllowTroughEntity, grandParent, endCellId))
                        {
                            _parentOfCell[cursor] = grandParent;
                        };
                    }
                    else
                    {
                        if (((!(grandGrandParent == MapTools.INVALID_CELL_ID)) && (MapTools.getDistance(cursor, grandGrandParent) == 2)))
                        {
                            nextX = MapTools.getCellIdXCoord(grandGrandParent);
                            nextY = MapTools.getCellIdYCoord(grandGrandParent);
                            interX = int((kX + Math.round(((nextX - kX) / 2))));
                            interY = int((kY + Math.round(((nextY - kY) / 2))));
                            if (((map.pointMov(interX, interY, bAllowTroughEntity, cursor, endCellId)) && (map.pointWeight(interX, interY) < 2)))
                            {
                                _parentOfCell[cursor] = MapTools.getCellIdByCoord(interX, interY);
                            };
                        }
                        else
                        {
                            if (((!(grandParent == MapTools.INVALID_CELL_ID)) && (MapTools.getDistance(cursor, grandParent) == 2)))
                            {
                                nextX = MapTools.getCellIdXCoord(grandParent);
                                nextY = MapTools.getCellIdYCoord(grandParent);
                                interX = MapTools.getCellIdXCoord(parent);
                                interY = MapTools.getCellIdYCoord(parent);
                                if ((((((kX + kY) == (nextX + nextY)) && (!((kX - kY) == (interX - interY)))) && (!(map.isChangeZone(MapTools.getCellIdByCoord(kX, kY), MapTools.getCellIdByCoord(interX, interY))))) && (!(map.isChangeZone(MapTools.getCellIdByCoord(interX, interY), MapTools.getCellIdByCoord(nextX, nextY))))))
                                {
                                    _parentOfCell[cursor] = grandParent;
                                }
                                else
                                {
                                    if ((((((kX - kY) == (nextX - nextY)) && (!((kX - kY) == (interX - interY)))) && (!(map.isChangeZone(MapTools.getCellIdByCoord(kX, kY), MapTools.getCellIdByCoord(interX, interY))))) && (!(map.isChangeZone(MapTools.getCellIdByCoord(interX, interY), MapTools.getCellIdByCoord(nextX, nextY))))))
                                    {
                                        _parentOfCell[cursor] = grandParent;
                                    }
                                    else
                                    {
                                        if (((((kX == nextX) && (!(kX == interX))) && (map.pointWeight(kX, interY) < 2)) && (map.pointMov(kX, interY, bAllowTroughEntity, cursor, endCellId))))
                                        {
                                            _parentOfCell[cursor] = MapTools.getCellIdByCoord(kX, interY);
                                        }
                                        else
                                        {
                                            if (((((kY == nextY) && (!(kY == interY))) && (map.pointWeight(interX, kY) < 2)) && (map.pointMov(interX, kY, bAllowTroughEntity, cursor, endCellId))))
                                            {
                                                _parentOfCell[cursor] = MapTools.getCellIdByCoord(interX, kY);
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                movPath.addPoint(new PathElement(MapPoint.fromCellId(_parentOfCell[cursor]), MapTools.getLookDirection8Exact(_parentOfCell[cursor], cursor)));
                cursor = _parentOfCell[cursor];
            };
            movPath.path.reverse();
            return (movPath);
        }


    }
} com.ankamagames.jerakine.pathfinding

