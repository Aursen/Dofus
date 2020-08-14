package com.adobe.net
{
    import flash.utils.ByteArray;

    public class URIEncodingBitmap extends ByteArray 
    {

        public function URIEncodingBitmap(charsToEscape:String):void
        {
            var i:int;
            var c:int;
            var enc:int;
            super();
            var data:ByteArray = new ByteArray();
            i = 0;
            while (i < 16)
            {
                this.writeByte(0);
                i++;
            };
            data.writeUTFBytes(charsToEscape);
            data.position = 0;
            while (data.bytesAvailable)
            {
                c = data.readByte();
                if (c > 127)
                {
                }
                else
                {
                    this.position = (c >> 3);
                    enc = this.readByte();
                    enc = (enc | (1 << (c & 0x07)));
                    this.position = (c >> 3);
                    this.writeByte(enc);
                };
            };
        }

        public function ShouldEscape(_arg_1:String):int
        {
            var c:int;
            var mask:int;
            var data:ByteArray = new ByteArray();
            data.writeUTFBytes(_arg_1);
            data.position = 0;
            c = data.readByte();
            if ((c & 0x80))
            {
                return (0);
            };
            if (((c < 31) || (c == 127)))
            {
                return (c);
            };
            this.position = (c >> 3);
            mask = this.readByte();
            if ((mask & (1 << (c & 0x07))))
            {
                return (c);
            };
            return (0);
        }


    }
} com.adobe.net

