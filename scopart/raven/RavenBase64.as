package scopart.raven
{
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import __AS3__.vec.*;

    public class RavenBase64 
    {

        private static const _encodeChars:Vector.<int> = InitEncodeChar();
        private static const _decodeChars:Vector.<int> = InitDecodeChar();


        public static function encode(data:ByteArray):String
        {
            var c:uint;
            var out:ByteArray = new ByteArray();
            out.length = ((((2 + data.length) - ((data.length + 2) % 3)) * 4) / 3);
            var i:int;
            var r:int = (data.length % 3);
            var len:int = (data.length - r);
            var outPos:int;
            while (i < len)
            {
                c = (((data[int(i++)] << 16) | (data[int(i++)] << 8)) | data[int(i++)]);
                out[int(outPos++)] = _encodeChars[int((c >>> 18))];
                out[int(outPos++)] = _encodeChars[int(((c >>> 12) & 0x3F))];
                out[int(outPos++)] = _encodeChars[int(((c >>> 6) & 0x3F))];
                out[int(outPos++)] = _encodeChars[int((c & 0x3F))];
            };
            if (r == 1)
            {
                c = data[int(i)];
                out[int(outPos++)] = _encodeChars[int((c >>> 2))];
                out[int(outPos++)] = _encodeChars[int(((c & 0x03) << 4))];
                out[int(outPos++)] = 61;
                out[int(outPos)] = 61;
            }
            else
            {
                if (r == 2)
                {
                    c = ((data[int(i++)] << 8) | data[int(i)]);
                    out[int(outPos++)] = _encodeChars[int((c >>> 10))];
                    out[int(outPos++)] = _encodeChars[int(((c >>> 4) & 0x3F))];
                    out[int(outPos++)] = _encodeChars[int(((c & 0x0F) << 2))];
                    out[int(outPos)] = 61;
                };
            };
            return (out.readUTFBytes(out.length));
        }

        public static function decode(str:String):ByteArray
        {
            var c1:int;
            var c2:int;
            var c3:int;
            var c4:int;
            var i:int;
            var len:int = str.length;
            var byteString:ByteArray = new ByteArray();
            byteString.writeUTFBytes(str);
            var outPos:int;
            while (i < len)
            {
                c1 = _decodeChars[int(byteString[i++])];
                if (c1 == -1)
                {
                    break;
                };
                c2 = _decodeChars[int(byteString[i++])];
                if (c2 == -1)
                {
                    break;
                };
                byteString[int(outPos++)] = ((c1 << 2) | ((c2 & 0x30) >> 4));
                c3 = byteString[int(i++)];
                if (c3 == 61)
                {
                    byteString.length = outPos;
                    return (byteString);
                };
                c3 = _decodeChars[int(c3)];
                if (c3 == -1)
                {
                    break;
                };
                byteString[int(outPos++)] = (((c2 & 0x0F) << 4) | ((c3 & 0x3C) >> 2));
                c4 = byteString[int(i++)];
                if (c4 == 61)
                {
                    byteString.length = outPos;
                    return (byteString);
                };
                c4 = _decodeChars[int(c4)];
                if (c4 == -1)
                {
                    break;
                };
                byteString[int(outPos++)] = (((c3 & 0x03) << 6) | c4);
            };
            byteString.length = outPos;
            return (byteString);
        }

        public static function InitEncodeChar():Vector.<int>
        {
            var encodeChars:Vector.<int> = new Vector.<int>(64, true);
            var chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            var i:int;
            while (i < 64)
            {
                encodeChars[i] = chars.charCodeAt(i);
                i++;
            };
            return (encodeChars);
        }

        public static function InitDecodeChar():Vector.<int>
        {
            var decodeChars:Vector.<int> = new <int>[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
            return (decodeChars);
        }


    }
}

