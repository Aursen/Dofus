package com.ankamagames.atouin.data.map
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.atouin.AtouinConstants;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class TacticalModeTemplate 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(TacticalModeTemplate));

        public var id:int;
        public var backgroundColor:int;
        public var groundCells:Vector.<TacticalModeCell>;
        public var lineOfSightCells:Vector.<TacticalModeCell>;


        public function fromRaw(raw:IDataInput):void
        {
            var i:int;
            var cell:TacticalModeCell;
            var numGroundCells:uint;
            var numLineOfSightCells:uint;
            try
            {
                this.id = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (TacticalModeTemplate) id : " + this.id));
                };
                this.backgroundColor = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (TacticalModeTemplate) backgroundColor : " + this.backgroundColor));
                };
                numGroundCells = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (TacticalModeTemplate) numGroundCells : " + numGroundCells));
                };
                this.groundCells = new Vector.<TacticalModeCell>(0);
                i = 0;
                while (i < numGroundCells)
                {
                    cell = new TacticalModeCell();
                    cell.fromRaw(raw, 11);
                    this.groundCells.push(cell);
                    i = (i + 1);
                };
                numLineOfSightCells = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (TacticalModeTemplate) numLineOfSightCells : " + numLineOfSightCells));
                };
                this.lineOfSightCells = new Vector.<TacticalModeCell>(0);
                i = 0;
                while (i < numLineOfSightCells)
                {
                    cell = new TacticalModeCell();
                    cell.fromRaw(raw, 11);
                    this.lineOfSightCells.push(cell);
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

