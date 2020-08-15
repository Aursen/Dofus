package org.audiofx.mp3
{
    import flash.events.EventDispatcher;
    import com.ankamagames.jerakine.pools.Poolable;
    import flash.utils.ByteArray;
    import flash.net.URLLoader;
    import org.audiofx.mp3.MP3FileReferenceLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;
    import flash.net.FileReference;
    import org.audiofx.mp3.*;

    [Event(name="complete", type="flash.events.Event")]
    internal class MP3Parser extends EventDispatcher implements Poolable 
    {

        private static var bitRates:Array = [-1, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 0x0100, 320, -1, -1, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, -1];
        private static var versions:Array = [2.5, -1, 2, 1];
        private static var samplingRates:Array = [44100, 48000, 0x7D00];

        private var mp3Data:ByteArray;
        private var loader:URLLoader;
        private var currentPosition:uint;
        private var sampleRate:uint;
        public var channels:uint;
        private var version:uint;
        private var m_parent:MP3FileReferenceLoader;

        public function MP3Parser(parent:MP3FileReferenceLoader)
        {
            this.m_parent = parent;
        }

        public function loadMP3ByteArray(bytes:ByteArray):void
        {
            this.mp3Data = bytes;
            this.currentPosition = this.getFirstHeaderPosition();
            this.m_parent.parsingDone(this);
        }

        public function free():void
        {
            this.mp3Data.clear();
            this.mp3Data = null;
            this.loader = null;
            this.currentPosition = 0;
        }

        internal function load(url:String):void
        {
            this.loader = new URLLoader();
            this.loader.dataFormat = URLLoaderDataFormat.BINARY;
            this.loader.addEventListener(Event.COMPLETE, this.loaderCompleteHandler);
            var req:URLRequest = new URLRequest(url);
            this.loader.load(req);
        }

        internal function loadFileRef(fileRef:FileReference):void
        {
            fileRef.addEventListener(Event.COMPLETE, this.loaderCompleteHandler);
            fileRef.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            fileRef.load();
        }

        private function errorHandler(ev:IOErrorEvent):void
        {
        }

        private function loaderCompleteHandler(ev:Event):void
        {
            ev.target.removeEventListener(Event.COMPLETE, this.loaderCompleteHandler);
            this.mp3Data = (ev.currentTarget.data as ByteArray);
            this.currentPosition = this.getFirstHeaderPosition();
            dispatchEvent(ev);
        }

        private function getFirstHeaderPosition():uint
        {
            var readPosition:uint;
            var str:String;
            var val:uint;
            var b3:int;
            var b2:int;
            var b1:int;
            var b0:int;
            var headerLength:int;
            var newPosition:int;
            this.mp3Data.position = 0;
            while (this.mp3Data.position < this.mp3Data.length)
            {
                readPosition = this.mp3Data.position;
                str = this.mp3Data.readUTFBytes(3);
                if (str == "ID3")
                {
                    this.mp3Data.position = (this.mp3Data.position + 3);
                    b3 = ((this.mp3Data.readByte() & 0x7F) << 21);
                    b2 = ((this.mp3Data.readByte() & 0x7F) << 14);
                    b1 = ((this.mp3Data.readByte() & 0x7F) << 7);
                    b0 = (this.mp3Data.readByte() & 0x7F);
                    headerLength = (((b0 + b1) + b2) + b3);
                    newPosition = (this.mp3Data.position + headerLength);
                    this.mp3Data.position = newPosition;
                    readPosition = newPosition;
                }
                else
                {
                    this.mp3Data.position = readPosition;
                };
                val = this.mp3Data.readInt();
                if (this.isValidHeader(val))
                {
                    this.parseHeader(val);
                    this.mp3Data.position = (readPosition + this.getFrameSize(val));
                    if (this.isValidHeader(this.mp3Data.readInt()))
                    {
                        return (readPosition);
                    };
                };
            };
            throw (new Error("Could not locate first header. This isn't an MP3 file"));
        }

        internal function getNextFrame():ByteArraySegment
        {
            var headerByte:uint;
            var frameSize:uint;
            this.mp3Data.position = this.currentPosition;
            while (true)
            {
                if (this.currentPosition > (this.mp3Data.length - 4))
                {
                    return (null);
                };
                headerByte = this.mp3Data.readInt();
                if (this.isValidHeader(headerByte))
                {
                    frameSize = this.getFrameSize(headerByte);
                    if (frameSize != 0xFFFFFFFF)
                    {
                        break;
                    };
                };
                this.currentPosition = this.mp3Data.position;
            };
            this.mp3Data.position = this.currentPosition;
            if ((this.currentPosition + frameSize) > this.mp3Data.length)
            {
                return (null);
            };
            this.currentPosition = (this.currentPosition + frameSize);
            return (new ByteArraySegment(this.mp3Data, this.mp3Data.position, frameSize));
        }

        internal function writeSwfFormatByte(byteArray:ByteArray):void
        {
            var sampleRateIndex:uint = uint((4 - (44100 / this.sampleRate)));
            byteArray.writeByte(((((2 << 4) + (sampleRateIndex << 2)) + (1 << 1)) + (this.channels - 1)));
        }

        private function parseHeader(headerBytes:uint):void
        {
            var channelMode:uint = this.getModeIndex(headerBytes);
            this.version = this.getVersionIndex(headerBytes);
            var samplingRate:uint = this.getFrequencyIndex(headerBytes);
            this.channels = ((channelMode > 2) ? 1 : 2);
            var actualVersion:Number = versions[this.version];
            var samplingRates:Array = [44100, 48000, 0x7D00];
            this.sampleRate = samplingRates[samplingRate];
            switch (actualVersion)
            {
                case 2:
                    this.sampleRate = (this.sampleRate / 2);
                    break;
                case 2.5:
                    this.sampleRate = (this.sampleRate / 4);
            };
        }

        private function getFrameSize(headerBytes:uint):uint
        {
            var version:uint = this.getVersionIndex(headerBytes);
            var bitRate:uint = this.getBitrateIndex(headerBytes);
            var samplingRate:uint = this.getFrequencyIndex(headerBytes);
            var padding:uint = this.getPaddingBit(headerBytes);
            var channelMode:uint = this.getModeIndex(headerBytes);
            var actualVersion:Number = versions[version];
            var sampleRate:uint = samplingRates[samplingRate];
            if (this.version != version)
            {
                return (0xFFFFFFFF);
            };
            switch (actualVersion)
            {
                case 2:
                    sampleRate = uint((sampleRate / 2));
                    break;
                case 2.5:
                    sampleRate = uint((sampleRate / 4));
            };
            var bitRatesYIndex:uint = uint(((((actualVersion == 1) ? 0 : 1) * bitRates.length) / 2));
            var actualBitRate:uint = (bitRates[(bitRatesYIndex + bitRate)] * 1000);
            var frameLength:uint = uint((((((actualVersion == 1) ? 144 : 72) * actualBitRate) / sampleRate) + padding));
            return (frameLength);
        }

        private function isValidHeader(headerBits:uint):Boolean
        {
            return ((((((((this.getFrameSync(headerBits) & 0x07FF) == 2047) && (!((this.getVersionIndex(headerBits) & 0x03) == 1))) && (!((this.getLayerIndex(headerBits) & 0x03) == 0))) && (!((this.getBitrateIndex(headerBits) & 0x0F) == 0))) && (!((this.getBitrateIndex(headerBits) & 0x0F) == 15))) && (!((this.getFrequencyIndex(headerBits) & 0x03) == 3))) && (!((this.getEmphasisIndex(headerBits) & 0x03) == 2)));
        }

        private function getFrameSync(headerBits:uint):uint
        {
            return (uint(((headerBits >> 21) & 0x07FF)));
        }

        private function getVersionIndex(headerBits:uint):uint
        {
            return (uint(((headerBits >> 19) & 0x03)));
        }

        private function getLayerIndex(headerBits:uint):uint
        {
            return (uint(((headerBits >> 17) & 0x03)));
        }

        private function getBitrateIndex(headerBits:uint):uint
        {
            return (uint(((headerBits >> 12) & 0x0F)));
        }

        private function getFrequencyIndex(headerBits:uint):uint
        {
            return (uint(((headerBits >> 10) & 0x03)));
        }

        private function getPaddingBit(headerBits:uint):uint
        {
            return (uint(((headerBits >> 9) & 0x01)));
        }

        private function getModeIndex(headerBits:uint):uint
        {
            return (uint(((headerBits >> 6) & 0x03)));
        }

        private function getEmphasisIndex(headerBits:uint):uint
        {
            return (uint((headerBits & 0x03)));
        }


    }
}

