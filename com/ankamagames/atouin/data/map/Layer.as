package com.ankamagames.atouin.data.map
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.atouin.AtouinConstants;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class Layer 
    {

        public static const LAYER_GROUND:uint = 0;
        public static const LAYER_ADDITIONAL_GROUND:uint = 1;
        public static const LAYER_DECOR:uint = 2;
        public static const LAYER_ADDITIONAL_DECOR:uint = 3;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Layer));

        public var layerId:int;
        public var cellsCount:int;
        public var cells:Vector.<Cell>;
        private var _map:Map;

        public function Layer(map:Map)
        {
            this._map = map;
        }

        public function get map():Map
        {
            return (this._map);
        }

        public function fromRaw(raw:IDataInput, mapVersion:int):void
        {
            var i:int;
            var c:Cell;
            var maxMapCellId:int;
            var endCell:Cell;
            try
            {
                if (mapVersion >= 9)
                {
                    this.layerId = raw.readByte();
                }
                else
                {
                    this.layerId = raw.readInt();
                };
                this.cellsCount = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (Layer) Cells count : " + this.cellsCount));
                };
                this.cells = new Vector.<Cell>(this.cellsCount, true);
                if (this.cellsCount > 0)
                {
                    i = 0;
                    while (i < this.cellsCount)
                    {
                        c = new Cell(this);
                        if (AtouinConstants.DEBUG_FILES_PARSING)
                        {
                            _log.debug((("  (Layer) Cell at index " + i) + " :"));
                        };
                        c.fromRaw(raw, mapVersion);
                        this.cells[i] = c;
                        i = (i + 1);
                    };
                    maxMapCellId = (AtouinConstants.MAP_CELLS_COUNT - 1);
                    if (c.cellId < maxMapCellId)
                    {
                        endCell = Cell.createEmptyCell(this, maxMapCellId);
                        this.cells.fixed = false;
                        this.cells.push(endCell);
                        this.cells.fixed = true;
                    };
                };
            }
            catch(e)
            {
                throw (e);
            };
        }


    }
}

