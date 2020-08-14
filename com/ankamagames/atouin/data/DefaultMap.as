package com.ankamagames.atouin.data
{
    import com.ankamagames.atouin.data.map.Map;
    import com.ankamagames.atouin.data.map.CellData;
    import com.ankamagames.atouin.data.map.Fixture;
    import __AS3__.vec.Vector;
    import com.ankamagames.atouin.data.map.Layer;
    import com.ankamagames.atouin.AtouinConstants;
    import flash.utils.IDataInput;
    import flash.utils.ByteArray;
    import com.ankamagames.atouin.data.map.Cell;
    import __AS3__.vec.*;

    public class DefaultMap extends Map 
    {

        public function DefaultMap(id:uint=0)
        {
            var i:int;
            var cd:CellData;
            super();
            this.id = id;
            mapVersion = 7;
            var emptyFixtureList:Vector.<Fixture> = new Vector.<Fixture>(0, true);
            backgroundFixtures = emptyFixtureList;
            foregroundFixtures = emptyFixtureList;
            layers = new Vector.<Layer>(2, true);
            layers[0] = this.createLayer(Layer.LAYER_GROUND);
            layers[1] = this.createLayer(Layer.LAYER_DECOR);
            cellsCount = AtouinConstants.MAP_CELLS_COUNT;
            cells = new Vector.<CellData>(cellsCount, true);
            i = 0;
            while (i < cellsCount)
            {
                cd = new CellData(this, i);
                cells[i] = cd;
                i++;
            };
        }

        override public function fromRaw(raw:IDataInput, decryptionKey:ByteArray=null):void
        {
        }

        private function createLayer(id:uint):Layer
        {
            var bgLayer:Layer = new Layer(this);
            bgLayer.layerId = id;
            bgLayer.cellsCount = 1;
            bgLayer.cells = new Vector.<Cell>();
            var firstCell:Cell = Cell.createEmptyCell(bgLayer, 0);
            bgLayer.cells.push(firstCell);
            bgLayer.cells.fixed = true;
            return (bgLayer);
        }


    }
} com.ankamagames.atouin.data

