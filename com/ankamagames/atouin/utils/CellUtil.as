package com.ankamagames.atouin.utils
{
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import flash.display.Sprite;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import flash.geom.Point;
    import com.ankamagames.atouin.managers.MapDisplayManager;

    public class CellUtil 
    {

        public static const MAX_CELL_ID:int = 559;
        public static const MIN_CELL_ID:int = 0;


        public static function getPixelXFromMapPoint(p:MapPoint):int
        {
            var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(p.cellId);
            return (cellSprite.x + (cellSprite.width / 2));
        }

        public static function getPixelYFromMapPoint(p:MapPoint):int
        {
            var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(p.cellId);
            return (cellSprite.y + (cellSprite.height / 2));
        }

        public static function getPixelsPointFromMapPoint(p:MapPoint, pivotInCenter:Boolean=true):Point
        {
            var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(p.cellId);
            var point:Point = new Point(((pivotInCenter) ? (cellSprite.x + (cellSprite.width / 2)) : cellSprite.x), ((pivotInCenter) ? (cellSprite.y + (cellSprite.height / 2)) : cellSprite.y));
            return (point);
        }

        public static function isLeftCol(cellId:int):Boolean
        {
            return ((cellId % 14) == 0);
        }

        public static function isRightCol(cellId:int):Boolean
        {
            return (isLeftCol((cellId + 1)));
        }

        public static function isTopRow(cellId:int):Boolean
        {
            return (cellId < 28);
        }

        public static function isBottomRow(cellId:int):Boolean
        {
            return (cellId > 531);
        }

        public static function isEvenRow(cellId:int):Boolean
        {
            return ((Math.floor((cellId / 14)) % 2) == 0);
        }

        public static function isValidCellIndex(cellId:int):Boolean
        {
            var b:Boolean = ((cellId >= 0) && (cellId < MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells.length));
            return (b);
        }


    }
} com.ankamagames.atouin.utils

