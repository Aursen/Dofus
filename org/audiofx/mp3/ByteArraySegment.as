package org.audiofx.mp3
{
    import flash.utils.ByteArray;

    internal class ByteArraySegment 
    {

        public var start:uint;
        public var length:uint;
        public var byteArray:ByteArray;

        public function ByteArraySegment(ba:ByteArray, start:uint, length:uint)
        {
            this.byteArray = ba;
            this.start = start;
            this.length = length;
        }

    }
}

