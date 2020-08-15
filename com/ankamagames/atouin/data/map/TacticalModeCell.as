package com.ankamagames.atouin.data.map
{
    import com.ankamagames.atouin.data.map.elements.GraphicalElement;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.atouin.data.map.elements.BasicElement;
    import com.ankamagames.jerakine.types.ColorMultiplicator;
    import flash.geom.Point;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class TacticalModeCell extends Cell 
    {

        public function TacticalModeCell(layer:Layer=null)
        {
            super(layer);
        }

        override public function fromRaw(raw:IDataInput, mapVersion:int):void
        {
            var ge:GraphicalElement;
            var i:int;
            elementsCount = raw.readShort();
            if (AtouinConstants.DEBUG_FILES_PARSING)
            {
                _log.debug(("    (Cell) Elements count : " + elementsCount));
            };
            elements = new Vector.<BasicElement>(elementsCount, true);
            i = 0;
            while (i < elementsCount)
            {
                ge = new GraphicalElement(this);
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug((("    (Cell) Element at index " + i) + " :"));
                };
                ge.elementId = raw.readUnsignedInt();
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug(("      (GraphicalElement) Element id : " + ge.elementId));
                };
                ge.hue = new ColorMultiplicator(raw.readByte(), raw.readByte(), raw.readByte());
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug(("      (GraphicalElement) Hue : " + ge.hue));
                };
                ge.shadow = new ColorMultiplicator(raw.readByte(), raw.readByte(), raw.readByte());
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug(("      (GraphicalElement) Shadow : " + ge.shadow));
                };
                ge.offset = new Point();
                ge.pixelOffset = new Point();
                if (mapVersion <= 4)
                {
                    ge.offset.x = raw.readByte();
                    ge.offset.y = raw.readByte();
                    ge.pixelOffset.x = (ge.offset.x * AtouinConstants.CELL_HALF_WIDTH);
                    ge.pixelOffset.y = (ge.offset.y * AtouinConstants.CELL_HALF_HEIGHT);
                }
                else
                {
                    ge.pixelOffset.x = raw.readShort();
                    ge.pixelOffset.y = raw.readShort();
                    ge.offset.x = (ge.pixelOffset.x / AtouinConstants.CELL_HALF_WIDTH);
                    ge.offset.y = (ge.pixelOffset.y / AtouinConstants.CELL_HALF_HEIGHT);
                };
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug((((("      (GraphicalElement) Offset : (" + ge.offset.x) + ";") + ge.offset.y) + ")"));
                };
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug((((("      (GraphicalElement) Pixel Offset : (" + ge.pixelOffset.x) + ";") + ge.pixelOffset.y) + ")"));
                };
                ge.altitude = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug(("      (GraphicalElement) Altitude : " + ge.altitude));
                };
                elements[i] = ge;
                i++;
            };
        }


    }
}

