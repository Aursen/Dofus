package com.ankamagames.atouin.data.map
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
    import flash.utils.ByteArray;
    import com.ankamagames.atouin.data.DataFormatError;
    import com.ankamagames.atouin.AtouinConstants;
    import flash.errors.IllegalOperationError;
    import flash.utils.IDataInput;
    import com.ankamagames.atouin.data.map.elements.BasicElement;
    import com.ankamagames.atouin.data.elements.GraphicalElementData;
    import com.ankamagames.atouin.data.elements.Elements;
    import com.ankamagames.atouin.enums.ElementTypesEnum;
    import com.ankamagames.atouin.data.map.elements.GraphicalElement;
    import __AS3__.vec.*;

    public class Map 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Map));

        public var mapVersion:int;
        public var encrypted:Boolean;
        public var encryptionVersion:uint;
        public var groundCRC:int;
        public var zoomScale:Number = 1;
        public var zoomOffsetX:int;
        public var zoomOffsetY:int;
        public var groundCacheCurrentlyUsed:int = 0;
        public var id:Number;
        public var relativeId:int;
        public var mapType:int;
        public var backgroundsCount:int;
        public var backgroundFixtures:Vector.<Fixture>;
        public var foregroundsCount:int;
        public var foregroundFixtures:Vector.<Fixture>;
        public var subareaId:int;
        public var shadowBonusOnEntities:int;
        public var gridColor:uint;
        public var backgroundColor:uint;
        public var backgroundRed:int;
        public var backgroundGreen:int;
        public var backgroundBlue:int;
        public var backgroundAlpha:int = 0;
        public var topNeighbourId:Number;
        public var bottomNeighbourId:Number;
        public var leftNeighbourId:Number;
        public var rightNeighbourId:Number;
        public var useLowPassFilter:Boolean;
        public var useReverb:Boolean;
        public var presetId:int;
        public var cellsCount:int;
        public var layersCount:int;
        public var isUsingNewMovementSystem:Boolean = false;
        public var layers:Vector.<Layer>;
        public var cells:Vector.<CellData>;
        public var topArrowCell:Vector.<uint> = new Vector.<uint>();
        public var leftArrowCell:Vector.<uint> = new Vector.<uint>();
        public var bottomArrowCell:Vector.<uint> = new Vector.<uint>();
        public var rightArrowCell:Vector.<uint> = new Vector.<uint>();
        private var _parsed:Boolean;
        private var _failed:Boolean;
        private var _gfxList:Vector.<NormalGraphicalElementData>;
        private var _gfxCount:Array;
        public var tacticalModeTemplateId:int;


        public function get parsed():Boolean
        {
            return (this._parsed);
        }

        public function get failed():Boolean
        {
            return (this._failed);
        }

        public function getGfxList(skipBackground:Boolean=false):Vector.<NormalGraphicalElementData>
        {
            if (!this._gfxList)
            {
                this.computeGfxList(skipBackground);
            };
            return (this._gfxList);
        }

        public function getGfxCount(gfxId:uint):uint
        {
            if (!this._gfxList)
            {
                this.computeGfxList();
            };
            return (this._gfxCount[gfxId]);
        }

        public function fromRaw(raw:IDataInput, decryptionKey:ByteArray=null):void
        {
            var i:int;
            var header:int;
            var bg:Fixture;
            var la:Layer;
            var _oldMvtSystem:uint;
            var cd:CellData;
            var dataLen:uint;
            var encryptedData:ByteArray;
            var readColor:int;
            var gridAlpha:int;
            var gridRed:int;
            var gridGreen:int;
            var gridBlue:int;
            var fg:Fixture;
            try
            {
                header = raw.readByte();
                if (header != 77)
                {
                    throw (new DataFormatError("Unknown file format"));
                };
                this.mapVersion = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("Map version : " + this.mapVersion));
                };
                this.id = raw.readUnsignedInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("Map id : " + this.id));
                };
                if (this.mapVersion >= 7)
                {
                    this.encrypted = raw.readBoolean();
                    this.encryptionVersion = raw.readByte();
                    dataLen = raw.readInt();
                    if (this.encrypted)
                    {
                        if (!decryptionKey)
                        {
                            throw (new IllegalOperationError("Map decryption key is empty"));
                        };
                        encryptedData = new ByteArray();
                        raw.readBytes(encryptedData, 0, dataLen);
                        i = 0;
                        while (i < encryptedData.length)
                        {
                            encryptedData[i] = (encryptedData[i] ^ decryptionKey[(i % decryptionKey.length)]);
                            i = (i + 1);
                        };
                        encryptedData.position = 0;
                        raw = encryptedData;
                    };
                };
                this.relativeId = raw.readUnsignedInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("Map relativeId: " + this.relativeId));
                };
                this.mapType = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("Map type : " + this.mapType));
                };
                this.subareaId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("Subarea id : " + this.subareaId));
                };
                this.topNeighbourId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("topNeighbourId : " + this.topNeighbourId));
                };
                this.bottomNeighbourId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("bottomNeighbourId : " + this.bottomNeighbourId));
                };
                this.leftNeighbourId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("leftNeighbourId : " + this.leftNeighbourId));
                };
                this.rightNeighbourId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("rightNeighbourId : " + this.rightNeighbourId));
                };
                this.shadowBonusOnEntities = raw.readUnsignedInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("ShadowBonusOnEntities : " + this.shadowBonusOnEntities));
                };
                if (this.mapVersion >= 9)
                {
                    readColor = raw.readInt();
                    this.backgroundAlpha = ((readColor & 0xFF000000) >> 32);
                    this.backgroundRed = ((readColor & 0xFF0000) >> 16);
                    this.backgroundGreen = ((readColor & 0xFF00) >> 8);
                    this.backgroundBlue = (readColor & 0xFF);
                    readColor = raw.readUnsignedInt();
                    gridAlpha = ((readColor & 0xFF000000) >> 32);
                    gridRed = ((readColor & 0xFF0000) >> 16);
                    gridGreen = ((readColor & 0xFF00) >> 8);
                    gridBlue = (readColor & 0xFF);
                    this.gridColor = (((((gridAlpha & 0xFF) << 32) | ((gridRed & 0xFF) << 16)) | ((gridGreen & 0xFF) << 8)) | (gridBlue & 0xFF));
                }
                else
                {
                    if (this.mapVersion >= 3)
                    {
                        this.backgroundRed = raw.readByte();
                        this.backgroundGreen = raw.readByte();
                        this.backgroundBlue = raw.readByte();
                    };
                };
                this.backgroundColor = (((((this.backgroundAlpha & 0xFF) << 32) | ((this.backgroundRed & 0xFF) << 16)) | ((this.backgroundGreen & 0xFF) << 8)) | (this.backgroundBlue & 0xFF));
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(((((("BackgroundColor : " + this.backgroundRed) + ",") + this.backgroundGreen) + ",") + this.backgroundBlue));
                };
                if (this.mapVersion >= 4)
                {
                    this.zoomScale = (raw.readUnsignedShort() / 100);
                    this.zoomOffsetX = raw.readShort();
                    this.zoomOffsetY = raw.readShort();
                    if (this.zoomScale < 1)
                    {
                        this.zoomScale = 1;
                        this.zoomOffsetX = (this.zoomOffsetY = 0);
                    };
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug(((((("Zoom auto : " + this.zoomScale) + ",") + this.zoomOffsetX) + ",") + this.zoomOffsetY));
                    };
                };
                if (this.mapVersion > 10)
                {
                    this.tacticalModeTemplateId = raw.readInt();
                };
                this.useLowPassFilter = (raw.readByte() == 1);
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("useLowPassFilter : " + this.useLowPassFilter));
                };
                this.useReverb = (raw.readByte() == 1);
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("useReverb : " + this.useReverb));
                };
                if (this.useReverb)
                {
                    this.presetId = raw.readInt();
                }
                else
                {
                    this.presetId = -1;
                };
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("presetId : " + this.presetId));
                };
                this.backgroundsCount = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("Backgrounds count : " + this.backgroundsCount));
                };
                this.backgroundFixtures = new Vector.<Fixture>(this.backgroundsCount, true);
                i = 0;
                while (i < this.backgroundsCount)
                {
                    bg = new Fixture(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug((("Background at index " + i) + " :"));
                    };
                    bg.fromRaw(raw);
                    this.backgroundFixtures[i] = bg;
                    i = (i + 1);
                };
                this.foregroundsCount = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("Foregrounds count : " + this.foregroundsCount));
                };
                this.foregroundFixtures = new Vector.<Fixture>(this.foregroundsCount, true);
                i = 0;
                while (i < this.foregroundsCount)
                {
                    fg = new Fixture(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug((("Foreground at index " + i) + " :"));
                    };
                    fg.fromRaw(raw);
                    this.foregroundFixtures[i] = fg;
                    i = (i + 1);
                };
                this.cellsCount = AtouinConstants.MAP_CELLS_COUNT;
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("Cells count : " + this.cellsCount));
                };
                raw.readInt();
                this.groundCRC = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("groundCRC : " + this.groundCRC));
                };
                this.layersCount = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("Layers count : " + this.layersCount));
                };
                this.layers = new Vector.<Layer>(this.layersCount, true);
                i = 0;
                while (i < this.layersCount)
                {
                    la = new Layer(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug((("Layer at index " + i) + " :"));
                    };
                    la.fromRaw(raw, this.mapVersion);
                    this.layers[i] = la;
                    i = (i + 1);
                };
                this.cells = new Vector.<CellData>(this.cellsCount, true);
                i = 0;
                while (i < this.cellsCount)
                {
                    cd = new CellData(this, i);
                    cd.fromRaw(raw);
                    if (!_oldMvtSystem)
                    {
                        _oldMvtSystem = cd.moveZone;
                    };
                    if (cd.moveZone != _oldMvtSystem)
                    {
                        this.isUsingNewMovementSystem = true;
                    };
                    this.cells[i] = cd;
                    i = (i + 1);
                };
                this.topArrowCell.fixed = true;
                this.leftArrowCell.fixed = true;
                this.bottomArrowCell.fixed = true;
                this.rightArrowCell.fixed = true;
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                };
                this._parsed = true;
            }
            catch(e)
            {
                _failed = true;
                throw (e);
            };
        }

        private function computeGfxList(skipBackground:Boolean=false):void
        {
            var l:int;
            var c:int;
            var e:int;
            var lsCell:Vector.<Cell>;
            var numCell:int;
            var lsElement:Vector.<BasicElement>;
            var numElement:int;
            var layer:Layer;
            var cell:Cell;
            var element:BasicElement;
            var elementId:int;
            var elementData:GraphicalElementData;
            var graphicalElementData:NormalGraphicalElementData;
            var gfx:NormalGraphicalElementData;
            var ele:Elements = Elements.getInstance();
            var gfxList:Array = new Array();
            this._gfxCount = new Array();
            var numLayer:int = this.layers.length;
            l = 0;
            while (l < numLayer)
            {
                layer = this.layers[l];
                if (((skipBackground) && (l == 0)))
                {
                }
                else
                {
                    lsCell = layer.cells;
                    numCell = lsCell.length;
                    c = 0;
                    while (c < numCell)
                    {
                        cell = lsCell[c];
                        lsElement = cell.elements;
                        numElement = lsElement.length;
                        e = 0;
                        while (e < numElement)
                        {
                            element = lsElement[e];
                            if (element.elementType == ElementTypesEnum.GRAPHICAL)
                            {
                                elementId = GraphicalElement(element).elementId;
                                elementData = ele.getElementData(elementId);
                                if (elementData == null)
                                {
                                    _log.error(("Unknown graphical element ID " + elementId));
                                }
                                else
                                {
                                    if ((elementData is NormalGraphicalElementData))
                                    {
                                        graphicalElementData = (elementData as NormalGraphicalElementData);
                                        gfxList[graphicalElementData.gfxId] = graphicalElementData;
                                        if (this._gfxCount[graphicalElementData.gfxId])
                                        {
                                            this._gfxCount[graphicalElementData.gfxId]++;
                                        }
                                        else
                                        {
                                            this._gfxCount[graphicalElementData.gfxId] = 1;
                                        };
                                    };
                                };
                            };
                            e++;
                        };
                        c++;
                    };
                };
                l++;
            };
            this._gfxList = new Vector.<NormalGraphicalElementData>();
            for each (gfx in gfxList)
            {
                this._gfxList.push(gfx);
            };
            this._gfxList.fixed = true;
        }


    }
} com.ankamagames.atouin.data.map

