package com.ankamagames.atouin.data.map
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.atouin.AtouinConstants;
    import flash.utils.IDataInput;

    public class CellData 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CellData));

        public var id:uint;
        public var speed:int;
        public var mapChangeData:uint;
        public var moveZone:uint;
        private var _losmov:int = 3;
        private var _floor:int;
        private var _map:Map;
        private var _arrow:int = 0;
        private var _linkedZone:int;
        private var _mov:Boolean;
        private var _los:Boolean;
        private var _nonWalkableDuringFight:Boolean;
        private var _red:Boolean;
        private var _blue:Boolean;
        private var _farmCell:Boolean;
        private var _havenbagCell:Boolean;
        private var _visible:Boolean;
        private var _nonWalkableDuringRP:Boolean;

        public function CellData(map:Map, cellId:uint)
        {
            this.id = cellId;
            this._map = map;
        }

        public function get map():Map
        {
            return (this._map);
        }

        public function get mov():Boolean
        {
            return (this._mov);
        }

        public function get los():Boolean
        {
            return (this._los);
        }

        public function get nonWalkableDuringFight():Boolean
        {
            return (this._nonWalkableDuringFight);
        }

        public function get red():Boolean
        {
            return (this._red);
        }

        public function get blue():Boolean
        {
            return (this._blue);
        }

        public function get farmCell():Boolean
        {
            return (this._farmCell);
        }

        public function get havenbagCell():Boolean
        {
            return (this._havenbagCell);
        }

        public function get visible():Boolean
        {
            return (this._visible);
        }

        public function get nonWalkableDuringRP():Boolean
        {
            return (this._nonWalkableDuringRP);
        }

        public function get floor():int
        {
            return (this._floor);
        }

        public function get useTopArrow():Boolean
        {
            return (!((this._arrow & 0x01) == 0));
        }

        public function get useBottomArrow():Boolean
        {
            return (!((this._arrow & 0x02) == 0));
        }

        public function get useRightArrow():Boolean
        {
            return (!((this._arrow & 0x04) == 0));
        }

        public function get useLeftArrow():Boolean
        {
            return (!((this._arrow & 0x08) == 0));
        }

        public function hasLinkedZoneRP():Boolean
        {
            return ((this.mov) && (!(this.farmCell)));
        }

        public function get linkedZoneRP():int
        {
            return ((this._linkedZone & 0xF0) >> 4);
        }

        public function hasLinkedZoneFight():Boolean
        {
            return ((((this.mov) && (!(this.nonWalkableDuringFight))) && (!(this.farmCell))) && (!(this.havenbagCell)));
        }

        public function get linkedZoneFight():int
        {
            return (this._linkedZone & 0x0F);
        }

        public function fromRaw(raw:IDataInput):void
        {
            var tmpbytesv9:int;
            var topArrow:Boolean;
            var bottomArrow:Boolean;
            var rightArrow:Boolean;
            var leftArrow:Boolean;
            var tmpBits:int;
            try
            {
                this._floor = (raw.readByte() * 10);
                if (this._floor == -1280)
                {
                    return;
                };
                if (this._map.mapVersion >= 9)
                {
                    tmpbytesv9 = raw.readShort();
                    this._mov = ((tmpbytesv9 & 0x01) == 0);
                    this._nonWalkableDuringFight = (!((tmpbytesv9 & 0x02) == 0));
                    this._nonWalkableDuringRP = (!((tmpbytesv9 & 0x04) == 0));
                    this._los = ((tmpbytesv9 & 0x08) == 0);
                    this._blue = (!((tmpbytesv9 & 0x10) == 0));
                    this._red = (!((tmpbytesv9 & 0x20) == 0));
                    this._visible = (!((tmpbytesv9 & 0x40) == 0));
                    this._farmCell = (!((tmpbytesv9 & 0x80) == 0));
                    if (this.map.mapVersion >= 10)
                    {
                        this._havenbagCell = (!((tmpbytesv9 & 0x0100) == 0));
                        topArrow = (!((tmpbytesv9 & 0x0200) == 0));
                        bottomArrow = (!((tmpbytesv9 & 0x0400) == 0));
                        rightArrow = (!((tmpbytesv9 & 0x0800) == 0));
                        leftArrow = (!((tmpbytesv9 & 0x1000) == 0));
                    }
                    else
                    {
                        topArrow = (!((tmpbytesv9 & 0x0100) == 0));
                        bottomArrow = (!((tmpbytesv9 & 0x0200) == 0));
                        rightArrow = (!((tmpbytesv9 & 0x0400) == 0));
                        leftArrow = (!((tmpbytesv9 & 0x0800) == 0));
                    };
                    if (topArrow)
                    {
                        this._map.topArrowCell.push(this.id);
                    };
                    if (bottomArrow)
                    {
                        this._map.bottomArrowCell.push(this.id);
                    };
                    if (rightArrow)
                    {
                        this._map.rightArrowCell.push(this.id);
                    };
                    if (leftArrow)
                    {
                        this._map.leftArrowCell.push(this.id);
                    };
                }
                else
                {
                    this._losmov = raw.readUnsignedByte();
                    this._los = (((this._losmov & 0x02) >> 1) == 1);
                    this._mov = ((this._losmov & 0x01) == 1);
                    this._visible = (((this._losmov & 0x40) >> 6) == 1);
                    this._farmCell = (((this._losmov & 0x20) >> 5) == 1);
                    this._blue = (((this._losmov & 0x10) >> 4) == 1);
                    this._red = (((this._losmov & 0x08) >> 3) == 1);
                    this._nonWalkableDuringRP = (((this._losmov & 0x80) >> 7) == 1);
                    this._nonWalkableDuringFight = (((this._losmov & 0x04) >> 2) == 1);
                };
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (CellData) LOS : " + this._los));
                };
                this.speed = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (CellData) Speed : " + this.speed));
                };
                this.mapChangeData = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (CellData) MapChangeData : " + this.mapChangeData));
                };
                if (this._map.mapVersion > 5)
                {
                    this.moveZone = raw.readUnsignedByte();
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug(("  (CellData) moveZone : " + this.moveZone));
                    };
                };
                if (((this._map.mapVersion > 10) && ((this.hasLinkedZoneRP()) || (this.hasLinkedZoneFight()))))
                {
                    this._linkedZone = raw.readUnsignedByte();
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug(("  (CellData) linkedZoneRP : " + this.linkedZoneRP));
                        _log.debug(("  (CellData) linkedZoneFight : " + this.linkedZoneFight));
                    };
                };
                if (((this._map.mapVersion > 7) && (this.map.mapVersion < 9)))
                {
                    tmpBits = raw.readByte();
                    this._arrow = (0x0F & tmpBits);
                    if (this.useTopArrow)
                    {
                        this._map.topArrowCell.push(this.id);
                    };
                    if (this.useBottomArrow)
                    {
                        this._map.bottomArrowCell.push(this.id);
                    };
                    if (this.useLeftArrow)
                    {
                        this._map.leftArrowCell.push(this.id);
                    };
                    if (this.useRightArrow)
                    {
                        this._map.rightArrowCell.push(this.id);
                    };
                };
            }
            catch(e)
            {
                throw (e);
            };
        }

        public function toString():String
        {
            return ((((((((((((((((((((((("map : " + this._map.id) + " CellId : ") + this.id) + " mov : ") + this._mov) + " los : ") + this._los) + " nonWalkableDuringFight : ") + this._nonWalkableDuringFight) + " nonWalkableDuringRp : ") + this._nonWalkableDuringRP) + " farmCell : ") + this._farmCell) + " havenbagCell: ") + this._havenbagCell) + " visbile : ") + this._visible) + " speed: ") + this.speed) + " moveZone: ") + this.moveZone) + " linkedZoneId: ") + this._linkedZone);
        }


    }
}

