package com.ankamagames.jerakine.logger.targets
{
    import damageCalculation.tools.LinkedList;
    import com.ankamagames.jerakine.logger.Log;
    import com.ankamagames.jerakine.logger.LogEvent;

    public class FixedBufferTarget extends AbstractTarget 
    {

        private var _buffer:LinkedList;
        private var _limit:int;
        private var _callbackOnLogFull:Function;
        private var _currentAddedElement:int = 0;
        public var isFull:Boolean = false;

        public function FixedBufferTarget(pLimit:int=50)
        {
            this._limit = pLimit;
            this._buffer = new LinkedList();
        }

        public function setCallbackOnBufferFull(callback:Function):void
        {
            this._callbackOnLogFull = callback;
        }

        override public function logEvent(event:LogEvent):void
        {
            if (this.isFull)
            {
                return;
            };
            if (this._currentAddedElement >= this._limit)
            {
                if (this._callbackOnLogFull != null)
                {
                    this._callbackOnLogFull();
                };
                Log.removeTarget(this);
                this.isFull = true;
                return;
            };
            this._currentAddedElement++;
            this._buffer.add(event);
        }

        public function clearBuffer():void
        {
            this._buffer.clear();
            this._buffer = new LinkedList();
            this._currentAddedElement = 0;
        }

        public function getBuffer():LinkedList
        {
            return (this._buffer);
        }


    }
} com.ankamagames.jerakine.logger.targets

