package com.ankamagames.atouin.data.map
{
    import __AS3__.vec.Vector;
    import com.ankamagames.atouin.data.map.elements.BasicElement;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.geom.Point;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.atouin.utils.CellIdConverter;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class Cell 
    {

        public static const EMPTY_ELEMENTS_LIST:Vector.<BasicElement> = new Vector.<BasicElement>(0, true);
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Cell));
        private static var _cellCoords:Point;

        public var cellId:int;
        public var elementsCount:int;
        public var elements:Vector.<BasicElement>;
        private var _layer:Layer;

        public function Cell(layer:Layer)
        {
            this._layer = layer;
        }

        public static function cellCoords(cellId:uint):Point
        {
            if (_cellCoords == null)
            {
                _cellCoords = new Point();
            };
            _cellCoords.x = (cellId % AtouinConstants.MAP_WIDTH);
            _cellCoords.y = Math.floor((cellId / AtouinConstants.MAP_WIDTH));
            return (_cellCoords);
        }

        public static function cellId(p:Point):uint
        {
            return (CellIdConverter.coordToCellId(p.x, p.y));
        }

        public static function cellIdByXY(x:int, y:int):uint
        {
            return (CellIdConverter.coordToCellId(x, y));
        }

        public static function cellPixelCoords(cellId:uint):Point
        {
            var p:Point = cellCoords(cellId);
            p.x = ((p.x * AtouinConstants.CELL_WIDTH) + (((p.y % 2) == 1) ? AtouinConstants.CELL_HALF_WIDTH : 0));
            p.y = (p.y * AtouinConstants.CELL_HALF_HEIGHT);
            return (p);
        }

        public static function createEmptyCell(layer:Layer, cellId:int):Cell
        {
            var cell:Cell = new Cell(layer);
            cell.cellId = cellId;
            cell.elementsCount = 0;
            cell.elements = EMPTY_ELEMENTS_LIST;
            return (cell);
        }


        public function get layer():Layer
        {
            return (this._layer);
        }

        public function get coords():Point
        {
            return (CellIdConverter.cellIdToCoord(this.cellId));
        }

        public function get pixelCoords():Point
        {
            return (cellPixelCoords(this.cellId));
        }

        public function fromRaw(raw:IDataInput, mapVersion:int):void
        {
            var be:BasicElement;
            var i:int;
            try
            {
                this.cellId = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("    (Cell) Id : " + this.cellId));
                };
                this.elementsCount = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("    (Cell) Elements count : " + this.elementsCount));
                };
                this.elements = new Vector.<BasicElement>(this.elementsCount, true);
                i = 0;
                while (i < this.elementsCount)
                {
                    be = BasicElement.getElementFromType(raw.readByte(), this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug((("    (Cell) Element at index " + i) + " :"));
                    };
                    be.fromRaw(raw, mapVersion);
                    this.elements[i] = be;
                    i = (i + 1);
                };
            }
            catch(e)
            {
                throw (e);
            };
        }


    }
}

