package com.ankamagames.jerakine.network.utils.types
{
    public class Binary64 
    {

        internal static const CHAR_CODE_0:uint = "0".charCodeAt();
        internal static const CHAR_CODE_9:uint = "9".charCodeAt();
        internal static const CHAR_CODE_A:uint = "a".charCodeAt();
        internal static const CHAR_CODE_Z:uint = "z".charCodeAt();

        public var low:uint;
        internal var internalHigh:uint;

        public function Binary64(low:uint=0, high:uint=0)
        {
            this.low = low;
            this.internalHigh = high;
        }

        final internal function div(n:uint):uint
        {
            var modHigh:uint;
            modHigh = (this.internalHigh % n);
            var mod:uint = (((this.low % n) + (modHigh * 6)) % n);
            this.internalHigh = (this.internalHigh / n);
            var newLow:Number = (((modHigh * 4294967296) + this.low) / n);
            this.internalHigh = (this.internalHigh + uint((newLow / 4294967296)));
            this.low = newLow;
            return (mod);
        }

        final internal function mul(n:uint):void
        {
            var newLow:Number = (Number(this.low) * n);
            this.internalHigh = (this.internalHigh * n);
            this.internalHigh = (this.internalHigh + uint((newLow / 4294967296)));
            this.low = (this.low * n);
        }

        final internal function add(n:uint):void
        {
            var newLow:Number = (Number(this.low) + n);
            this.internalHigh = (this.internalHigh + uint((newLow / 4294967296)));
            this.low = newLow;
        }

        final internal function bitwiseNot():void
        {
            this.low = (~(this.low));
            this.internalHigh = (~(this.internalHigh));
        }


    }
} com.ankamagames.jerakine.network.utils.types

