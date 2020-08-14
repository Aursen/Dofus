package com.ankamagames.atouin.renderers
{
    import com.ankamagames.atouin.utils.IZoneRenderer;
    import com.ankamagames.atouin.types.TrapZoneTile;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import flash.filters.ColorMatrixFilter;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.atouin.types.DataMapContainer;

    public class TrapZoneRenderer implements IZoneRenderer 
    {

        private var _aZoneTile:Array;
        private var _aCellTile:Array;
        private var _visible:Boolean;
        private var _bigLine:Boolean;
        public var strata:uint;

        public function TrapZoneRenderer(nStrata:uint=10, visible:Boolean=true, bigLine:Boolean=false)
        {
            this._aZoneTile = new Array();
            this._aCellTile = new Array();
            this._visible = visible;
            this._bigLine = bigLine;
            this.strata = nStrata;
        }

        public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, alpha:Boolean=false, updateStrata:Boolean=false):void
        {
            var tzt:TrapZoneTile;
            var daPoint:MapPoint;
            var daCellId:uint;
            var mp:MapPoint;
            var hasATopNeighbor:Boolean;
            var hasABottomNeighbor:Boolean;
            var hasARightNeighbor:Boolean;
            var hasALeftNeighbor:Boolean;
            var colorMatrix:ColorMatrixFilter = new ColorMatrixFilter([0, 0, 0, 0, oColor.red, 0, 0, 0, 0, oColor.green, 0, 0, 0, 0, oColor.blue, 0, 0, 0, 0.7, 0]);
            var j:int;
            var cellsCount:int = cells.length;
            var i:int;
            var mapPointsByCellId:Dictionary = new Dictionary();
            while (j < cellsCount)
            {
                mapPointsByCellId[cells[j]] = MapPoint.fromCellId(cells[j]);
                j++;
            };
            j = 0;
            while (j < cellsCount)
            {
                if (!this._aZoneTile[j])
                {
                    this._aZoneTile[j] = (tzt = new TrapZoneTile());
                    tzt.mouseChildren = false;
                    tzt.mouseEnabled = false;
                    tzt.strata = this.strata;
                    tzt.visible = this._visible;
                    tzt.filters = [colorMatrix];
                };
                this._aCellTile[j] = cells[j];
                daCellId = cells[j];
                daPoint = mapPointsByCellId[daCellId];
                TrapZoneTile(this._aZoneTile[j]).cellId = daCellId;
                hasATopNeighbor = false;
                hasABottomNeighbor = false;
                hasARightNeighbor = false;
                hasALeftNeighbor = false;
                i = 0;
                while (i < cellsCount)
                {
                    if (cells[i] == daCellId)
                    {
                    }
                    else
                    {
                        mp = mapPointsByCellId[cells[i]];
                        if (mp.x == daPoint.x)
                        {
                            if (mp.y == (daPoint.y - 1))
                            {
                                hasATopNeighbor = true;
                            }
                            else
                            {
                                if (mp.y == (daPoint.y + 1))
                                {
                                    hasABottomNeighbor = true;
                                };
                            };
                        }
                        else
                        {
                            if (mp.y == daPoint.y)
                            {
                                if (mp.x == (daPoint.x - 1))
                                {
                                    hasARightNeighbor = true;
                                }
                                else
                                {
                                    if (mp.x == (daPoint.x + 1))
                                    {
                                        hasALeftNeighbor = true;
                                    };
                                };
                            };
                        };
                    };
                    i++;
                };
                if (((((!(hasATopNeighbor)) || (!(hasARightNeighbor))) || (!(hasABottomNeighbor))) || (!(hasALeftNeighbor))))
                {
                    TrapZoneTile(this._aZoneTile[j]).drawStroke(hasATopNeighbor, hasARightNeighbor, hasABottomNeighbor, hasALeftNeighbor, this._bigLine);
                };
                TrapZoneTile(this._aZoneTile[j]).display(this.strata);
                j++;
            };
            var tilesCount:int = this._aZoneTile.length;
            while (j < tilesCount)
            {
                if (this._aZoneTile[j])
                {
                    (this._aZoneTile[j] as TrapZoneTile).remove();
                };
                j++;
            };
        }

        public function updateDisplay():void
        {
            var j:int;
            while (j < this._aZoneTile.length)
            {
                if (this._aZoneTile[j])
                {
                    TrapZoneTile(this._aZoneTile[j]).display(this.strata);
                };
                j++;
            };
        }

        public function remove(cells:Vector.<uint>, mapContainer:DataMapContainer):void
        {
            if (!cells)
            {
                return;
            };
            var mapping:Array = new Array();
            var j:int;
            while (j < cells.length)
            {
                mapping[cells[j]] = true;
                j++;
            };
            j = 0;
            while (j < this._aCellTile.length)
            {
                if (mapping[this._aCellTile[j]])
                {
                    if (this._aZoneTile[j])
                    {
                        TrapZoneTile(this._aZoneTile[j]).remove();
                    };
                    delete this._aZoneTile[j];
                    delete this._aCellTile[j];
                };
                j++;
            };
        }


    }
} com.ankamagames.atouin.renderers

