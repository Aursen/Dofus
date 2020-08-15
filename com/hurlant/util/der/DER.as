package com.hurlant.util.der
{
    import flash.utils.ByteArray;

    public class DER 
    {

        public static var indent:String = "";


        public static function parse(der:ByteArray, structure:*=null):IAsn1Type
        {
            var _local_3:int;
            var len:int;
            var b:ByteArray;
            var count:int;
            var p:int;
            var o:Sequence;
            var arrayStruct:Array;
            var s:Set;
            var bs:ByteString;
            var ps:PrintableString;
            var ut:UTCTime;
            var tmpStruct:Object;
            var wantConstructed:Boolean;
            var isConstructed:Boolean;
            var name:String;
            var value:*;
            var obj:IAsn1Type;
            var size:int;
            var ba:ByteArray;
            _local_3 = der.readUnsignedByte();
            var constructed:* = (!((_local_3 & 0x20) == 0));
            _local_3 = (_local_3 & 0x1F);
            len = der.readUnsignedByte();
            if (len >= 128)
            {
                count = (len & 0x7F);
                len = 0;
                while (count > 0)
                {
                    len = ((len << 8) | der.readUnsignedByte());
                    count--;
                };
            };
            switch (_local_3)
            {
                case 0:
                case 16:
                    p = der.position;
                    o = new Sequence(_local_3, len);
                    arrayStruct = (structure as Array);
                    if (arrayStruct != null)
                    {
                        arrayStruct = arrayStruct.concat();
                    };
                    while (der.position < (p + len))
                    {
                        tmpStruct = null;
                        if (arrayStruct != null)
                        {
                            tmpStruct = arrayStruct.shift();
                        };
                        if (tmpStruct != null)
                        {
                            while (((tmpStruct) && (tmpStruct.optional)))
                            {
                                wantConstructed = (tmpStruct.value is Array);
                                isConstructed = isConstructedType(der);
                                if (wantConstructed != isConstructed)
                                {
                                    o.push(tmpStruct.defaultValue);
                                    o[tmpStruct.name] = tmpStruct.defaultValue;
                                    tmpStruct = arrayStruct.shift();
                                }
                                else
                                {
                                    break;
                                };
                            };
                        };
                        if (tmpStruct != null)
                        {
                            name = tmpStruct.name;
                            value = tmpStruct.value;
                            if (tmpStruct.extract)
                            {
                                size = getLengthOfNextElement(der);
                                ba = new ByteArray();
                                ba.writeBytes(der, der.position, size);
                                o[(name + "_bin")] = ba;
                            };
                            obj = DER.parse(der, value);
                            o.push(obj);
                            o[name] = obj;
                        }
                        else
                        {
                            o.push(DER.parse(der));
                        };
                    };
                    return (o);
                case 17:
                    p = der.position;
                    s = new Set(_local_3, len);
                    while (der.position < (p + len))
                    {
                        s.push(DER.parse(der));
                    };
                    return (s);
                case 2:
                    b = new ByteArray();
                    der.readBytes(b, 0, len);
                    b.position = 0;
                    return (new Integer(_local_3, len, b));
                case 6:
                    b = new ByteArray();
                    der.readBytes(b, 0, len);
                    b.position = 0;
                    return (new ObjectIdentifier(_local_3, len, b));
                default:
                    trace(("I DONT KNOW HOW TO HANDLE DER stuff of TYPE " + _local_3));
                case 3:
                    if (der[der.position] == 0)
                    {
                        der.position++;
                        len--;
                    };
                case 4:
                    bs = new ByteString(_local_3, len);
                    der.readBytes(bs, 0, len);
                    return (bs);
                case 5:
                    return (null);
                case 19:
                    ps = new PrintableString(_local_3, len);
                    ps.setString(der.readMultiByte(len, "US-ASCII"));
                    return (ps);
                case 34:
                case 20:
                    ps = new PrintableString(_local_3, len);
                    ps.setString(der.readMultiByte(len, "latin1"));
                    return (ps);
                case 23:
                    ut = new UTCTime(_local_3, len);
                    ut.setUTCTime(der.readMultiByte(len, "US-ASCII"));
                    return (ut);
            };
        }

        private static function getLengthOfNextElement(b:ByteArray):int
        {
            var count:int;
            var p:uint = b.position;
            b.position++;
            var len:int = b.readUnsignedByte();
            if (len >= 128)
            {
                count = (len & 0x7F);
                len = 0;
                while (count > 0)
                {
                    len = ((len << 8) | b.readUnsignedByte());
                    count--;
                };
            };
            len = (len + (b.position - p));
            b.position = p;
            return (len);
        }

        private static function isConstructedType(b:ByteArray):Boolean
        {
            var _local_2:int = b[b.position];
            return (!((_local_2 & 0x20) == 0));
        }

        public static function wrapDER(_arg_1:int, data:ByteArray):ByteArray
        {
            var d:ByteArray = new ByteArray();
            d.writeByte(_arg_1);
            var len:int = data.length;
            if (len < 128)
            {
                d.writeByte(len);
            }
            else
            {
                if (len < 0x0100)
                {
                    d.writeByte((0x01 | 0x80));
                    d.writeByte(len);
                }
                else
                {
                    if (len < 0x10000)
                    {
                        d.writeByte((0x02 | 0x80));
                        d.writeByte((len >> 8));
                        d.writeByte(len);
                    }
                    else
                    {
                        if (len < (0x10000 * 0x0100))
                        {
                            d.writeByte((0x03 | 0x80));
                            d.writeByte((len >> 16));
                            d.writeByte((len >> 8));
                            d.writeByte(len);
                        }
                        else
                        {
                            d.writeByte((0x04 | 0x80));
                            d.writeByte((len >> 24));
                            d.writeByte((len >> 16));
                            d.writeByte((len >> 8));
                            d.writeByte(len);
                        };
                    };
                };
            };
            d.writeBytes(data);
            d.position = 0;
            return (d);
        }


    }
}

