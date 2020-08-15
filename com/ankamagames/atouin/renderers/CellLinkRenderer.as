package com.ankamagames.atouin.renderers
{
    import com.ankamagames.atouin.utils.IZoneRenderer;
    import __AS3__.vec.Vector;
    import com.ankamagames.atouin.data.map.Cell;
    import com.ankamagames.atouin.types.CellLink;
    import flash.geom.Point;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.utils.CellUtil;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.atouin.types.DataMapContainer;
    import __AS3__.vec.*;

    public class CellLinkRenderer implements IZoneRenderer 
    {

        public var strata:uint;
        public var cells:Vector.<Cell>;
        private var _cellLinks:Vector.<CellLink>;
        private var _useThicknessMalus:Boolean;
        private var _thickness:Number;
        private var _alpha:Number;

        public function CellLinkRenderer(thickness:Number=10, alpha:Number=1, useThicknessMalus:Boolean=false, nStrata:uint=160)
        {
            this.strata = nStrata;
            this._thickness = thickness;
            this._alpha = alpha;
            this._useThicknessMalus = useThicknessMalus;
        }

        public function getCellLinks():Vector.<CellLink>
        {
            return (this._cellLinks);
        }

        public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, alpha:Boolean=false, updateStrata:Boolean=false):void
        {
            var cellLink:CellLink;
            var p1:Point;
            var p2:Point;
            var lineToPoint:Point;
            var start:MapPoint;
            var end:MapPoint;
            var i:int;
            this._cellLinks = new Vector.<CellLink>();
            var orderedCheckPoints:Vector.<MapPoint> = new Vector.<MapPoint>();
            while (cells.length)
            {
                orderedCheckPoints.push(MapPoint.fromCellId(cells.shift()));
            };
            var thickness:Number = this._thickness;
            var l:int = (orderedCheckPoints.length - 1);
            i = 0;
            while (i < l)
            {
                p1 = CellUtil.getPixelsPointFromMapPoint(orderedCheckPoints[i], false);
                p2 = CellUtil.getPixelsPointFromMapPoint(orderedCheckPoints[(i + 1)], false);
                if (((p1.y > p2.y) || ((p1.y == p2.y) && (p1.x > p2.x))))
                {
                    start = orderedCheckPoints[i];
                    end = orderedCheckPoints[(i + 1)];
                    lineToPoint = new Point((p2.x - p1.x), (p2.y - p1.y));
                }
                else
                {
                    start = orderedCheckPoints[(i + 1)];
                    end = orderedCheckPoints[i];
                    lineToPoint = new Point((p1.x - p2.x), (p1.y - p2.y));
                };
                cellLink = new CellLink();
                cellLink.graphics.lineStyle(thickness, oColor.color, this._alpha);
                cellLink.graphics.moveTo(0, 0);
                cellLink.graphics.lineTo(lineToPoint.x, lineToPoint.y);
                cellLink.orderedCheckpoints = new <MapPoint>[start, end];
                cellLink.display(this.strata);
                this._cellLinks.push(cellLink);
                thickness = (thickness - 2);
                if (thickness < 1)
                {
                    thickness = 1;
                };
                i++;
            };
        }

        public function remove(cells:Vector.<uint>, mapContainer:DataMapContainer):void
        {
            if (this._cellLinks)
            {
                while (this._cellLinks.length)
                {
                    this._cellLinks.pop().remove();
                };
            };
            this._cellLinks = null;
        }


    }
}

