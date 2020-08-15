package com.ankamagames.atouin.renderers
{
    import com.ankamagames.atouin.utils.IZoneRenderer;
    import __AS3__.vec.Vector;
    import com.ankamagames.atouin.types.FurnitureZoneTile;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.types.GraphicCell;
    import flash.geom.Point;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import flash.filters.ColorMatrixFilter;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.atouin.types.DataMapContainer;
    import __AS3__.vec.*;

    public class FurnitureZoneRenderer implements IZoneRenderer 
    {

        private var _aZoneTile:Vector.<FurnitureZoneTile>;
        private var _aCellTile:Vector.<uint>;
        private var _visible:Boolean;
        public var strata:uint;
        public var height:int = 0;

        public function FurnitureZoneRenderer(nStrata:uint=10, visible:Boolean=true)
        {
            this._aZoneTile = new Vector.<FurnitureZoneTile>();
            this._aCellTile = new Vector.<uint>();
            this._visible = visible;
            this.strata = nStrata;
        }

        public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, alpha:Boolean=false, updateStrata:Boolean=false):void
        {
            var fzt:FurnitureZoneTile;
            var cellId:int;
            var daCellId:uint;
            var daPoint:MapPoint;
            var zzTop:Boolean;
            var zzBottom:Boolean;
            var zzRight:Boolean;
            var zzLeft:Boolean;
            var cid:uint;
            var c1:GraphicCell;
            var c2:GraphicCell;
            var offset:Point;
            var mp:MapPoint;
            this._aZoneTile.length = cells.length;
            this._aCellTile.length = cells.length;
            var highestCellId:int = -1;
            if (((this.strata == (PlacementStrataEnums.STRATA_FURNITURE_ITEM - 1)) && (cells.length > 1)))
            {
                for each (cellId in cells)
                {
                    if (cellId > highestCellId)
                    {
                        highestCellId = cellId;
                    };
                };
            };
            var j:int;
            while (j < cells.length)
            {
                if (!this._aZoneTile[j])
                {
                    this._aZoneTile[j] = (fzt = new FurnitureZoneTile());
                    fzt.strata = this.strata;
                    fzt.visible = this._visible;
                    fzt.filters = [new ColorMatrixFilter([0, 0, 0, 0, oColor.red, 0, 0, 0, 0, oColor.green, 0, 0, 0, 0, oColor.blue, 0, 0, 0, 0.7, 0])];
                };
                this._aCellTile[j] = cells[j];
                daCellId = cells[j];
                daPoint = MapPoint.fromCellId(daCellId);
                this._aZoneTile[j].cellId = daCellId;
                this._aZoneTile[j].needFill = (!(this.height == 0));
                if (highestCellId != -1)
                {
                    this._aZoneTile[j].cellId = highestCellId;
                    if (daCellId != highestCellId)
                    {
                        c1 = InteractiveCellManager.getInstance().getCell(daCellId);
                        c2 = InteractiveCellManager.getInstance().getCell(highestCellId);
                        offset = new Point((c2.x - c1.x), (c2.y - c1.y));
                        this._aZoneTile[j].offset = offset;
                    };
                };
                zzTop = false;
                zzBottom = false;
                zzRight = false;
                zzLeft = false;
                for each (cid in cells)
                {
                    if (cid == daCellId)
                    {
                    }
                    else
                    {
                        mp = MapPoint.fromCellId(cid);
                        if (mp.x == daPoint.x)
                        {
                            if (mp.y == (daPoint.y - 1))
                            {
                                zzTop = true;
                            }
                            else
                            {
                                if (mp.y == (daPoint.y + 1))
                                {
                                    zzBottom = true;
                                };
                            };
                        }
                        else
                        {
                            if (mp.y == daPoint.y)
                            {
                                if (mp.x == (daPoint.x - 1))
                                {
                                    zzRight = true;
                                }
                                else
                                {
                                    if (mp.x == (daPoint.x + 1))
                                    {
                                        zzLeft = true;
                                    };
                                };
                            };
                        };
                    };
                };
                this._aZoneTile[j].draw(zzTop, zzRight, zzBottom, zzLeft, this.height);
                this._aZoneTile[j].display(this.strata);
                if (highestCellId != -1)
                {
                    this._aZoneTile[j].cellId = daCellId;
                };
                j++;
            };
            while (j < this._aZoneTile.length)
            {
                if (this._aZoneTile[j])
                {
                    this._aZoneTile[j].remove();
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
                        this._aZoneTile[j].remove();
                    };
                    delete this._aZoneTile[j];
                    delete this._aCellTile[j];
                };
                j++;
            };
        }


    }
}

