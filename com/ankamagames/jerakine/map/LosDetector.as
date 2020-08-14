package com.ankamagames.jerakine.map
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.utils.display.Dofus2Line;
    import __AS3__.vec.*;

    public class LosDetector 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LosDetector));


        public static function getCell(mapData:IDataMapProvider, range:Vector.<uint>, refPosition:MapPoint):Vector.<uint>
        {
            var i:uint;
            var line:Array;
            var los:Boolean;
            var currentPoint:String;
            var p:MapPoint;
            var j:int;
            var orderedCell:Array = new Array();
            var mp:MapPoint;
            i = 0;
            while (i < range.length)
            {
                mp = MapPoint.fromCellId(range[i]);
                orderedCell.push({
                    "p":mp,
                    "dist":refPosition.distanceToCell(mp)
                });
                i++;
            };
            orderedCell.sortOn("dist", (Array.DESCENDING | Array.NUMERIC));
            var tested:Object = new Object();
            var result:Vector.<uint> = new Vector.<uint>();
            i = 0;
            while (i < orderedCell.length)
            {
                p = MapPoint(orderedCell[i].p);
                if ((((!(tested[((p.x + "_") + p.y)] == null)) && (!((refPosition.x + refPosition.y) == (p.x + p.y)))) && (!((refPosition.x - refPosition.y) == (p.x - p.y)))))
                {
                }
                else
                {
                    line = Dofus2Line.getLine(refPosition.cellId, p.cellId);
                    if (line.length == 0)
                    {
                        result.push(p.cellId);
                    }
                    else
                    {
                        los = true;
                        j = 0;
                        while (j < line.length)
                        {
                            currentPoint = ((Math.floor(line[j].x) + "_") + Math.floor(line[j].y));
                            if (!MapPoint.isInMap(line[j].x, line[j].y))
                            {
                            }
                            else
                            {
                                if (((j > 0) && (mapData.hasEntity(Math.floor(line[(j - 1)].x), Math.floor(line[(j - 1)].y), true))))
                                {
                                    los = false;
                                }
                                else
                                {
                                    if ((((line[j].x + line[j].y) == (refPosition.x + refPosition.y)) || ((line[j].x - line[j].y) == (refPosition.x - refPosition.y))))
                                    {
                                        los = ((los) && (mapData.pointLos(Math.floor(line[j].x), Math.floor(line[j].y), true)));
                                    }
                                    else
                                    {
                                        if (tested[currentPoint] == null)
                                        {
                                            los = ((los) && (mapData.pointLos(Math.floor(line[j].x), Math.floor(line[j].y), true)));
                                        }
                                        else
                                        {
                                            los = ((los) && (tested[currentPoint]));
                                        };
                                    };
                                };
                            };
                            j++;
                        };
                        tested[currentPoint] = los;
                    };
                };
                i++;
            };
            i = 0;
            while (i < range.length)
            {
                mp = MapPoint.fromCellId(range[i]);
                if (tested[((mp.x + "_") + mp.y)])
                {
                    result.push(mp.cellId);
                };
                i++;
            };
            return (result);
        }


    }
} com.ankamagames.jerakine.map

