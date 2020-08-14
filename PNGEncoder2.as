package 
{
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;
    import _PNGEncoder2.PNGEncoder2Impl;
    import flash.display.BitmapData;
    import flash.system.ApplicationDomain;
    import flash.geom.Rectangle;
    import flash.display.Sprite;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public class PNGEncoder2 extends EventDispatcher 
    {

        public static var level:CompressionLevel;

        protected var png:ByteArray;
        public var __impl:PNGEncoder2Impl;

        public function PNGEncoder2(_arg_1:BitmapData, _arg_2:*):void
        {
            PNGEncoder2Impl.level = PNGEncoder2.level;
            __impl = new PNGEncoder2Impl(_arg_1, this, _arg_2);
        }

        public static function encode(_arg_1:BitmapData):ByteArray
        {
            var _local_4:Number;
            var _local_5:uint;
            var _local_6:int;
            var _local_7:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            PNGEncoder2Impl.level = PNGEncoder2.level;
            var _local_2:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            if (PNGEncoder2Impl.encoding)
            {
                throw (new Error("Only one PNG can be encoded at once (are you encoding asynchronously while attempting to encode another PNG synchronously?)"));
            };
            PNGEncoder2Impl.encoding = true;
            if (PNGEncoder2Impl.level == null)
            {
                PNGEncoder2Impl.level = CompressionLevel.FAST;
            };
            if (!PNGEncoder2Impl.crcComputed)
            {
                PNGEncoder2Impl.region = new Rectangle(0, 0, 1, 1);
                PNGEncoder2Impl.sprite = new Sprite();
                PNGEncoder2Impl.data = new ByteArray();
                _local_4 = Math.max(6600, ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
                PNGEncoder2Impl.data.length = _local_4;
            };
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            if (!PNGEncoder2Impl.crcComputed)
            {
                _local_6 = 0;
                while (_local_6 < 0x0100)
                {
                    _local_7 = _local_6++;
                    _local_5 = _local_7;
                    if ((_local_5 & 0x01) == 1)
                    {
                        _local_5 = (0xEDB88320 ^ (_local_5 >>> 1));
                    }
                    else
                    {
                        _local_5 = (_local_5 >>> 1);
                    };
                    if ((_local_5 & 0x01) == 1)
                    {
                        _local_5 = (0xEDB88320 ^ (_local_5 >>> 1));
                    }
                    else
                    {
                        _local_5 = (_local_5 >>> 1);
                    };
                    if ((_local_5 & 0x01) == 1)
                    {
                        _local_5 = (0xEDB88320 ^ (_local_5 >>> 1));
                    }
                    else
                    {
                        _local_5 = (_local_5 >>> 1);
                    };
                    if ((_local_5 & 0x01) == 1)
                    {
                        _local_5 = (0xEDB88320 ^ (_local_5 >>> 1));
                    }
                    else
                    {
                        _local_5 = (_local_5 >>> 1);
                    };
                    if ((_local_5 & 0x01) == 1)
                    {
                        _local_5 = (0xEDB88320 ^ (_local_5 >>> 1));
                    }
                    else
                    {
                        _local_5 = (_local_5 >>> 1);
                    };
                    if ((_local_5 & 0x01) == 1)
                    {
                        _local_5 = (0xEDB88320 ^ (_local_5 >>> 1));
                    }
                    else
                    {
                        _local_5 = (_local_5 >>> 1);
                    };
                    if ((_local_5 & 0x01) == 1)
                    {
                        _local_5 = (0xEDB88320 ^ (_local_5 >>> 1));
                    }
                    else
                    {
                        _local_5 = (_local_5 >>> 1);
                    };
                    if ((_local_5 & 0x01) == 1)
                    {
                        _local_5 = (0xEDB88320 ^ (_local_5 >>> 1));
                    }
                    else
                    {
                        _local_5 = (_local_5 >>> 1);
                    };
                    si32(_local_5, (_local_7 << 2));
                };
                PNGEncoder2Impl.crcComputed = true;
            };
            var _local_8:ByteArray = new ByteArray();
            _local_8.writeUnsignedInt(-1991225785);
            _local_8.writeUnsignedInt(218765834);
            _local_6 = 13;
            _local_4 = Math.max((6600 + _local_6), ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
            PNGEncoder2Impl.data.length = _local_4;
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            _local_5 = _arg_1.width;
            si8((_local_5 >>> 24), 6600);
            si8((_local_5 >>> 16), 6601);
            si8((_local_5 >>> 8), 6602);
            si8(_local_5, 6603);
            _local_5 = _arg_1.height;
            si8((_local_5 >>> 24), 6604);
            si8((_local_5 >>> 16), 6605);
            si8((_local_5 >>> 8), 6606);
            si8(_local_5, 6607);
            si8(8, 6608);
            if (_arg_1.transparent)
            {
                si8(6, 6609);
            }
            else
            {
                si8(2, 6609);
            };
            si8(0, 6610);
            si8(0, 6611);
            si8(0, 6612);
            _local_7 = _local_6;
            _local_8.writeUnsignedInt(_local_7);
            _local_8.writeUnsignedInt(1229472850);
            if (_local_7 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_local_8, _local_8.position, _local_6);
                _local_8.position = (_local_8.position + _local_7);
            };
            _local_9 = -1;
            _local_9 = (li32(((_local_9 ^ 0x49) & 0xFF) << 2) ^ (_local_9 >>> 8));
            _local_9 = (li32(((_local_9 ^ 0x48) & 0xFF) << 2) ^ (_local_9 >>> 8));
            _local_9 = (li32(((_local_9 ^ 0x44) & 0xFF) << 2) ^ (_local_9 >>> 8));
            _local_9 = (li32(((_local_9 ^ 0x52) & 0xFF) << 2) ^ (_local_9 >>> 8));
            if (_local_7 != 0)
            {
                _local_10 = 6600;
                _local_11 = (6600 + _local_7);
                _local_12 = (6600 + (_local_7 & 0xFFFFFFF0));
                while (_local_10 < _local_12)
                {
                    _local_13 = (_local_9 ^ li8(_local_10));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 1));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 2));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 3));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 4));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 5));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 6));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 7));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 8));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 9));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 10));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 11));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 12));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 13));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 14));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_13 = (_local_9 ^ li8(_local_10 + 15));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_10 = (_local_10 + 16);
                };
                while (_local_10 < _local_11)
                {
                    _local_13 = (_local_9 ^ li8(_local_10));
                    _local_9 = (li32((_local_13 & 0xFF) << 2) ^ (_local_9 >>> 8));
                    _local_10++;
                };
            };
            _local_9 = (_local_9 ^ 0xFFFFFFFF);
            _local_8.writeUnsignedInt(_local_9);
            PNGEncoder2Impl.writeMetadataChunks(null, _local_8);
            var _local_3:ByteArray = _local_8;
            var _local_14:DeflateStream = DeflateStream.createEx(PNGEncoder2Impl.level, 0x0400, 6600, true);
            PNGEncoder2Impl.writeIDATChunk(_arg_1, 0, _arg_1.height, _local_14, _local_3);
            _local_6 = 0;
            _local_3.writeUnsignedInt(_local_6);
            _local_3.writeUnsignedInt(1229278788);
            if (_local_6 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_local_3, _local_3.position, 0);
                _local_3.position = (_local_3.position + _local_6);
            };
            _local_7 = -1;
            _local_7 = (li32(((_local_7 ^ 0x49) & 0xFF) << 2) ^ (_local_7 >>> 8));
            _local_7 = (li32(((_local_7 ^ 0x45) & 0xFF) << 2) ^ (_local_7 >>> 8));
            _local_7 = (li32(((_local_7 ^ 0x4E) & 0xFF) << 2) ^ (_local_7 >>> 8));
            _local_7 = (li32(((_local_7 ^ 0x44) & 0xFF) << 2) ^ (_local_7 >>> 8));
            if (_local_6 != 0)
            {
                _local_9 = 6600;
                _local_10 = (6600 + _local_6);
                _local_11 = (6600 + (_local_6 & 0xFFFFFFF0));
                while (_local_9 < _local_11)
                {
                    _local_12 = (_local_7 ^ li8(_local_9));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 1));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 2));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 3));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 4));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 5));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 6));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 7));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 8));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 9));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 10));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 11));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 12));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 13));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 14));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_12 = (_local_7 ^ li8(_local_9 + 15));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_9 = (_local_9 + 16);
                };
                while (_local_9 < _local_10)
                {
                    _local_12 = (_local_7 ^ li8(_local_9));
                    _local_7 = (li32((_local_12 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_9++;
                };
            };
            _local_7 = (_local_7 ^ 0xFFFFFFFF);
            _local_3.writeUnsignedInt(_local_7);
            PNGEncoder2Impl.encoding = false;
            _local_3.position = 0;
            _local_14 = null;
            ApplicationDomain.currentDomain.domainMemory = _local_2;
            return (_local_3);
        }

        public static function encodeWithMetadata(_arg_1:BitmapData, _arg_2:*):ByteArray
        {
            var _local_5:Number;
            var _local_6:uint;
            var _local_7:int;
            var _local_8:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            PNGEncoder2Impl.level = PNGEncoder2.level;
            var _local_3:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            if (PNGEncoder2Impl.encoding)
            {
                throw (new Error("Only one PNG can be encoded at once (are you encoding asynchronously while attempting to encode another PNG synchronously?)"));
            };
            PNGEncoder2Impl.encoding = true;
            if (PNGEncoder2Impl.level == null)
            {
                PNGEncoder2Impl.level = CompressionLevel.FAST;
            };
            if (!PNGEncoder2Impl.crcComputed)
            {
                PNGEncoder2Impl.region = new Rectangle(0, 0, 1, 1);
                PNGEncoder2Impl.sprite = new Sprite();
                PNGEncoder2Impl.data = new ByteArray();
                _local_5 = Math.max(6600, ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
                PNGEncoder2Impl.data.length = _local_5;
            };
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            if (!PNGEncoder2Impl.crcComputed)
            {
                _local_7 = 0;
                while (_local_7 < 0x0100)
                {
                    _local_8 = _local_7++;
                    _local_6 = _local_8;
                    if ((_local_6 & 0x01) == 1)
                    {
                        _local_6 = (0xEDB88320 ^ (_local_6 >>> 1));
                    }
                    else
                    {
                        _local_6 = (_local_6 >>> 1);
                    };
                    if ((_local_6 & 0x01) == 1)
                    {
                        _local_6 = (0xEDB88320 ^ (_local_6 >>> 1));
                    }
                    else
                    {
                        _local_6 = (_local_6 >>> 1);
                    };
                    if ((_local_6 & 0x01) == 1)
                    {
                        _local_6 = (0xEDB88320 ^ (_local_6 >>> 1));
                    }
                    else
                    {
                        _local_6 = (_local_6 >>> 1);
                    };
                    if ((_local_6 & 0x01) == 1)
                    {
                        _local_6 = (0xEDB88320 ^ (_local_6 >>> 1));
                    }
                    else
                    {
                        _local_6 = (_local_6 >>> 1);
                    };
                    if ((_local_6 & 0x01) == 1)
                    {
                        _local_6 = (0xEDB88320 ^ (_local_6 >>> 1));
                    }
                    else
                    {
                        _local_6 = (_local_6 >>> 1);
                    };
                    if ((_local_6 & 0x01) == 1)
                    {
                        _local_6 = (0xEDB88320 ^ (_local_6 >>> 1));
                    }
                    else
                    {
                        _local_6 = (_local_6 >>> 1);
                    };
                    if ((_local_6 & 0x01) == 1)
                    {
                        _local_6 = (0xEDB88320 ^ (_local_6 >>> 1));
                    }
                    else
                    {
                        _local_6 = (_local_6 >>> 1);
                    };
                    if ((_local_6 & 0x01) == 1)
                    {
                        _local_6 = (0xEDB88320 ^ (_local_6 >>> 1));
                    }
                    else
                    {
                        _local_6 = (_local_6 >>> 1);
                    };
                    si32(_local_6, (_local_8 << 2));
                };
                PNGEncoder2Impl.crcComputed = true;
            };
            var _local_9:ByteArray = new ByteArray();
            _local_9.writeUnsignedInt(-1991225785);
            _local_9.writeUnsignedInt(218765834);
            _local_7 = 13;
            _local_5 = Math.max((6600 + _local_7), ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
            PNGEncoder2Impl.data.length = _local_5;
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            _local_6 = _arg_1.width;
            si8((_local_6 >>> 24), 6600);
            si8((_local_6 >>> 16), 6601);
            si8((_local_6 >>> 8), 6602);
            si8(_local_6, 6603);
            _local_6 = _arg_1.height;
            si8((_local_6 >>> 24), 6604);
            si8((_local_6 >>> 16), 6605);
            si8((_local_6 >>> 8), 6606);
            si8(_local_6, 6607);
            si8(8, 6608);
            if (_arg_1.transparent)
            {
                si8(6, 6609);
            }
            else
            {
                si8(2, 6609);
            };
            si8(0, 6610);
            si8(0, 6611);
            si8(0, 6612);
            _local_8 = _local_7;
            _local_9.writeUnsignedInt(_local_8);
            _local_9.writeUnsignedInt(1229472850);
            if (_local_8 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_local_9, _local_9.position, _local_7);
                _local_9.position = (_local_9.position + _local_8);
            };
            _local_10 = -1;
            _local_10 = (li32(((_local_10 ^ 0x49) & 0xFF) << 2) ^ (_local_10 >>> 8));
            _local_10 = (li32(((_local_10 ^ 0x48) & 0xFF) << 2) ^ (_local_10 >>> 8));
            _local_10 = (li32(((_local_10 ^ 0x44) & 0xFF) << 2) ^ (_local_10 >>> 8));
            _local_10 = (li32(((_local_10 ^ 0x52) & 0xFF) << 2) ^ (_local_10 >>> 8));
            if (_local_8 != 0)
            {
                _local_11 = 6600;
                _local_12 = (6600 + _local_8);
                _local_13 = (6600 + (_local_8 & 0xFFFFFFF0));
                while (_local_11 < _local_13)
                {
                    _local_14 = (_local_10 ^ li8(_local_11));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 1));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 2));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 3));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 4));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 5));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 6));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 7));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 8));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 9));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 10));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 11));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 12));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 13));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 14));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_14 = (_local_10 ^ li8(_local_11 + 15));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_11 = (_local_11 + 16);
                };
                while (_local_11 < _local_12)
                {
                    _local_14 = (_local_10 ^ li8(_local_11));
                    _local_10 = (li32((_local_14 & 0xFF) << 2) ^ (_local_10 >>> 8));
                    _local_11++;
                };
            };
            _local_10 = (_local_10 ^ 0xFFFFFFFF);
            _local_9.writeUnsignedInt(_local_10);
            PNGEncoder2Impl.writeMetadataChunks(_arg_2, _local_9);
            var _local_4:ByteArray = _local_9;
            var _local_15:DeflateStream = DeflateStream.createEx(PNGEncoder2Impl.level, 0x0400, 6600, true);
            PNGEncoder2Impl.writeIDATChunk(_arg_1, 0, _arg_1.height, _local_15, _local_4);
            _local_7 = 0;
            _local_4.writeUnsignedInt(_local_7);
            _local_4.writeUnsignedInt(1229278788);
            if (_local_7 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_local_4, _local_4.position, 0);
                _local_4.position = (_local_4.position + _local_7);
            };
            _local_8 = -1;
            _local_8 = (li32(((_local_8 ^ 0x49) & 0xFF) << 2) ^ (_local_8 >>> 8));
            _local_8 = (li32(((_local_8 ^ 0x45) & 0xFF) << 2) ^ (_local_8 >>> 8));
            _local_8 = (li32(((_local_8 ^ 0x4E) & 0xFF) << 2) ^ (_local_8 >>> 8));
            _local_8 = (li32(((_local_8 ^ 0x44) & 0xFF) << 2) ^ (_local_8 >>> 8));
            if (_local_7 != 0)
            {
                _local_10 = 6600;
                _local_11 = (6600 + _local_7);
                _local_12 = (6600 + (_local_7 & 0xFFFFFFF0));
                while (_local_10 < _local_12)
                {
                    _local_13 = (_local_8 ^ li8(_local_10));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 1));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 2));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 3));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 4));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 5));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 6));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 7));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 8));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 9));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 10));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 11));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 12));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 13));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 14));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_13 = (_local_8 ^ li8(_local_10 + 15));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_10 = (_local_10 + 16);
                };
                while (_local_10 < _local_11)
                {
                    _local_13 = (_local_8 ^ li8(_local_10));
                    _local_8 = (li32((_local_13 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_10++;
                };
            };
            _local_8 = (_local_8 ^ 0xFFFFFFFF);
            _local_4.writeUnsignedInt(_local_8);
            PNGEncoder2Impl.encoding = false;
            _local_4.position = 0;
            _local_15 = null;
            ApplicationDomain.currentDomain.domainMemory = _local_3;
            return (_local_4);
        }

        public static function encodeAsync(_arg_1:BitmapData):PNGEncoder2
        {
            return (new PNGEncoder2(_arg_1, null));
        }

        public static function encodeAsyncWithMetadata(_arg_1:BitmapData, _arg_2:*):PNGEncoder2
        {
            return (new PNGEncoder2(_arg_1, _arg_2));
        }

        public static function decode(_arg_1:ByteArray):BitmapData
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:Boolean;
            var _local_7:* = (null as ByteArray);
            var _local_8:uint;
            var _local_9:uint;
            var _local_10:* = (null as ByteArray);
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:uint;
            var _local_18:int;
            var _local_19:uint;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            var _local_25:int;
            var _local_26:int;
            var _local_27:int;
            var _local_28:int;
            var _local_29:int;
            var _local_30:int;
            var _local_31:uint;
            var _local_2:Boolean;
            if (_arg_1.length < 16)
            {
                _local_2 = true;
            };
            if (((_local_2) && ((_arg_1.readInt() != (-1991225785)) || (!(_arg_1.readInt() == 218765834)))))
            {
                _local_2 = true;
            };
            var _local_3:BitmapData;
            if (!_local_2)
            {
                _local_4 = -1;
                _local_5 = -1;
                _local_6 = false;
                _local_7 = new ByteArray();
                _local_8 = _arg_1.readUnsignedInt();
                _local_9 = _arg_1.readUnsignedInt();
                if (_local_9 != 1229472850)
                {
                    _local_2 = true;
                };
                while (_local_9 != 1229278788)
                {
                    if (_local_9 == 1229472850)
                    {
                        if (_local_8 != 13)
                        {
                            _local_2 = true;
                        };
                        _local_4 = _arg_1.readInt();
                        _local_5 = _arg_1.readInt();
                        _arg_1.position = (_arg_1.position + 1);
                        _local_6 = (_arg_1.readUnsignedByte() == 6);
                        _arg_1.position = (_arg_1.position + 3);
                        if (_local_6)
                        {
                            _local_7.length = (((_local_5 * _local_4) * 4) + _local_5);
                        }
                        else
                        {
                            _local_7.length = (((_local_5 * _local_4) * 3) + _local_5);
                        };
                    }
                    else
                    {
                        if (_local_9 == 1229209940)
                        {
                            _arg_1.readBytes(_local_7, _local_7.position, _local_8);
                            _local_7.position = (_local_7.position + _local_8);
                        }
                        else
                        {
                            _arg_1.position = (_arg_1.position + _local_8);
                        };
                    };
                    _arg_1.position = (_arg_1.position + 4);
                    _local_8 = _arg_1.readUnsignedInt();
                    _local_9 = _arg_1.readUnsignedInt();
                };
                if (((_local_4 == (0)) || (_local_5 == 0)))
                {
                    _local_3 = new BitmapData(_local_4, _local_5, _local_6, 0xFFFFFF);
                }
                else
                {
                    if (!_local_2)
                    {
                        _local_7.uncompress();
                        _local_10 = ApplicationDomain.currentDomain.domainMemory;
                        _local_11 = 0;
                        if (_local_6)
                        {
                            _local_12 = 0;
                            ApplicationDomain.currentDomain.domainMemory = _local_7;
                            _local_14 = li32(++_local_11);
                            _local_13 = ((_local_14 << 8) | (_local_14 >>> 24));
                            si32(_local_13, _local_12);
                            _local_13 = (_local_4 * 4);
                            _local_14 = (_local_12 + _local_13);
                            _local_11 = (_local_11 + 4);
                            _local_12 = (_local_12 + 4);
                            _local_15 = (_local_12 + ((_local_13 - 1) & 0xFFFFFFC0));
                            while (_local_12 != _local_15)
                            {
                                _local_18 = li32(_local_11);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 - 4);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, _local_12);
                                _local_18 = li32(_local_11 + 4);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 4));
                                _local_18 = li32(_local_11 + 8);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 4);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 8));
                                _local_18 = li32(_local_11 + 12);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 8);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 12));
                                _local_18 = li32(_local_11 + 16);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 12);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 16));
                                _local_18 = li32(_local_11 + 20);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 16);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 20));
                                _local_18 = li32(_local_11 + 24);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 20);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 24));
                                _local_18 = li32(_local_11 + 28);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 24);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 28));
                                _local_18 = li32(_local_11 + 32);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 28);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 32));
                                _local_18 = li32(_local_11 + 36);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 32);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 36));
                                _local_18 = li32(_local_11 + 40);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 36);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 40));
                                _local_18 = li32(_local_11 + 44);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 40);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 44));
                                _local_18 = li32(_local_11 + 48);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 44);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 48));
                                _local_18 = li32(_local_11 + 52);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 48);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 52));
                                _local_18 = li32(_local_11 + 56);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 52);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 56));
                                _local_18 = li32(_local_11 + 60);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 + 56);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 60));
                                _local_11 = (_local_11 + 64);
                                _local_12 = (_local_12 + 64);
                            };
                            while (_local_12 != _local_14)
                            {
                                _local_18 = li32(_local_11);
                                _local_17 = ((_local_18 << 8) | (_local_18 >>> 24));
                                _local_19 = li32(_local_12 - 4);
                                _local_16 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, _local_12);
                                _local_11 = (_local_11 + 4);
                                _local_12 = (_local_12 + 4);
                            };
                            _local_16 = 1;
                            while (_local_16 < _local_5)
                            {
                                _local_18 = _local_16++;
                                _local_21 = li32(++_local_11);
                                _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                _local_19 = li32(_local_12 - _local_13);
                                _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_20, _local_12);
                                _local_14 = (_local_12 + _local_13);
                                _local_11 = (_local_11 + 4);
                                _local_12 = (_local_12 + 4);
                                _local_15 = (_local_12 + ((_local_13 - 1) & 0xFFFFFFC0));
                                while (_local_12 != _local_15)
                                {
                                    _local_21 = li32(_local_11);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 - 4);
                                    _local_22 = li32(_local_12 - _local_13);
                                    _local_23 = li32((_local_12 - 4) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, _local_12);
                                    _local_21 = li32(_local_11 + 4);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12);
                                    _local_22 = li32((_local_12 + 4) - _local_13);
                                    _local_23 = li32(_local_12 - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 4));
                                    _local_21 = li32(_local_11 + 8);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 4);
                                    _local_22 = li32((_local_12 + 8) - _local_13);
                                    _local_23 = li32((_local_12 + 4) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 8));
                                    _local_21 = li32(_local_11 + 12);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 8);
                                    _local_22 = li32((_local_12 + 12) - _local_13);
                                    _local_23 = li32((_local_12 + 8) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 12));
                                    _local_21 = li32(_local_11 + 16);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 12);
                                    _local_22 = li32((_local_12 + 16) - _local_13);
                                    _local_23 = li32((_local_12 + 12) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 16));
                                    _local_21 = li32(_local_11 + 20);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 16);
                                    _local_22 = li32((_local_12 + 20) - _local_13);
                                    _local_23 = li32((_local_12 + 16) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 20));
                                    _local_21 = li32(_local_11 + 24);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 20);
                                    _local_22 = li32((_local_12 + 24) - _local_13);
                                    _local_23 = li32((_local_12 + 20) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 24));
                                    _local_21 = li32(_local_11 + 28);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 24);
                                    _local_22 = li32((_local_12 + 28) - _local_13);
                                    _local_23 = li32((_local_12 + 24) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 28));
                                    _local_21 = li32(_local_11 + 32);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 28);
                                    _local_22 = li32((_local_12 + 32) - _local_13);
                                    _local_23 = li32((_local_12 + 28) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 32));
                                    _local_21 = li32(_local_11 + 36);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 32);
                                    _local_22 = li32((_local_12 + 36) - _local_13);
                                    _local_23 = li32((_local_12 + 32) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 36));
                                    _local_21 = li32(_local_11 + 40);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 36);
                                    _local_22 = li32((_local_12 + 40) - _local_13);
                                    _local_23 = li32((_local_12 + 36) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 40));
                                    _local_21 = li32(_local_11 + 44);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 40);
                                    _local_22 = li32((_local_12 + 44) - _local_13);
                                    _local_23 = li32((_local_12 + 40) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 44));
                                    _local_21 = li32(_local_11 + 48);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 44);
                                    _local_22 = li32((_local_12 + 48) - _local_13);
                                    _local_23 = li32((_local_12 + 44) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 48));
                                    _local_21 = li32(_local_11 + 52);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 48);
                                    _local_22 = li32((_local_12 + 52) - _local_13);
                                    _local_23 = li32((_local_12 + 48) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 52));
                                    _local_21 = li32(_local_11 + 56);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 52);
                                    _local_22 = li32((_local_12 + 56) - _local_13);
                                    _local_23 = li32((_local_12 + 52) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 56));
                                    _local_21 = li32(_local_11 + 60);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 + 56);
                                    _local_22 = li32((_local_12 + 60) - _local_13);
                                    _local_23 = li32((_local_12 + 56) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 60));
                                    _local_11 = (_local_11 + 64);
                                    _local_12 = (_local_12 + 64);
                                };
                                while (_local_12 != _local_14)
                                {
                                    _local_21 = li32(_local_11);
                                    _local_17 = ((_local_21 << 8) | (_local_21 >>> 24));
                                    _local_21 = li32(_local_12 - 4);
                                    _local_22 = li32(_local_12 - _local_13);
                                    _local_23 = li32((_local_12 - 4) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF) - (_local_23 & 0xFF));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF) - (_local_23 & 0xFF));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF) + (_local_22 & 0xFF)) - ((_local_23 << 1) & 0x01FE));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF);
                                    _local_29 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF00));
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_19 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_17 & 0xFF00FF00) + (_local_19 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_17 & 0xFF00FF) + (_local_19 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, _local_12);
                                    _local_11 = (_local_11 + 4);
                                    _local_12 = (_local_12 + 4);
                                };
                            };
                            ApplicationDomain.currentDomain.domainMemory = _local_10;
                            _local_7.position = 0;
                            _local_3 = new BitmapData(_local_4, _local_5, _local_6, 0xFFFFFF);
                            _local_3.setPixels(new Rectangle(0, 0, _local_4, _local_5), _local_7);
                        }
                        else
                        {
                            _local_17 = _local_7.length;
                            _local_12 = _local_17;
                            _local_7.length = (_local_7.length + ((_local_4 * _local_5) * 4));
                            ApplicationDomain.currentDomain.domainMemory = _local_7;
                            _local_13 = (li8(++_local_11) << 8);
                            si16(_local_13, _local_12);
                            _local_13 = li8(_local_11 + 1);
                            si8(_local_13, (_local_12 + 2));
                            _local_13 = li8(_local_11 + 2);
                            si8(_local_13, (_local_12 + 3));
                            _local_13 = (_local_4 * 4);
                            _local_14 = (_local_12 + _local_13);
                            _local_11 = (_local_11 + 3);
                            _local_12 = (_local_12 + 4);
                            _local_15 = (_local_12 + ((_local_13 - 1) & 0xFFFFFFC0));
                            _local_11--;
                            while (_local_12 != _local_15)
                            {
                                _local_19 = li32(_local_11);
                                _local_31 = li32(_local_12 - 4);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, _local_12);
                                _local_19 = li32(_local_11 + 3);
                                _local_31 = li32(_local_12);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 4));
                                _local_19 = li32(_local_11 + 6);
                                _local_31 = li32(_local_12 + 4);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 8));
                                _local_19 = li32(_local_11 + 9);
                                _local_31 = li32(_local_12 + 8);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 12));
                                _local_19 = li32(_local_11 + 12);
                                _local_31 = li32(_local_12 + 12);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 16));
                                _local_19 = li32(_local_11 + 15);
                                _local_31 = li32(_local_12 + 16);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 20));
                                _local_19 = li32(_local_11 + 18);
                                _local_31 = li32(_local_12 + 20);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 24));
                                _local_19 = li32(_local_11 + 21);
                                _local_31 = li32(_local_12 + 24);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 28));
                                _local_19 = li32(_local_11 + 24);
                                _local_31 = li32(_local_12 + 28);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 32));
                                _local_19 = li32(_local_11 + 27);
                                _local_31 = li32(_local_12 + 32);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 36));
                                _local_19 = li32(_local_11 + 30);
                                _local_31 = li32(_local_12 + 36);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 40));
                                _local_19 = li32(_local_11 + 33);
                                _local_31 = li32(_local_12 + 40);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 44));
                                _local_19 = li32(_local_11 + 36);
                                _local_31 = li32(_local_12 + 44);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 48));
                                _local_19 = li32(_local_11 + 39);
                                _local_31 = li32(_local_12 + 48);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 52));
                                _local_19 = li32(_local_11 + 42);
                                _local_31 = li32(_local_12 + 52);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 56));
                                _local_19 = li32(_local_11 + 45);
                                _local_31 = li32(_local_12 + 56);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, (_local_12 + 60));
                                _local_11 = (_local_11 + 48);
                                _local_12 = (_local_12 + 64);
                            };
                            while (_local_12 != _local_14)
                            {
                                _local_19 = li32(_local_11);
                                _local_31 = li32(_local_12 - 4);
                                _local_16 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                si32(_local_16, _local_12);
                                _local_11 = (_local_11 + 3);
                                _local_12 = (_local_12 + 4);
                            };
                            _local_11++;
                            _local_16 = 1;
                            while (_local_16 < _local_5)
                            {
                                _local_18 = _local_16++;
                                _local_20 = ((li8(++_local_11) + li8((_local_12 + 1) - _local_13)) << 8);
                                si16(_local_20, _local_12);
                                _local_20 = (li8(_local_11 + 1) + li8((_local_12 + 2) - _local_13));
                                si8(_local_20, (_local_12 + 2));
                                _local_20 = (li8(_local_11 + 2) + li8((_local_12 + 3) - _local_13));
                                si8(_local_20, (_local_12 + 3));
                                _local_14 = (_local_12 + _local_13);
                                _local_11 = (_local_11 + 3);
                                _local_12 = (_local_12 + 4);
                                _local_15 = (_local_12 + ((_local_13 - 1) & 0xFFFFFFC0));
                                _local_11--;
                                while (_local_12 != _local_15)
                                {
                                    _local_19 = li32(_local_11);
                                    _local_21 = li32(_local_12 - 4);
                                    _local_22 = li32(_local_12 - _local_13);
                                    _local_23 = li32((_local_12 - 4) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, _local_12);
                                    _local_19 = li32(_local_11 + 3);
                                    _local_21 = li32(_local_12);
                                    _local_22 = li32((_local_12 + 4) - _local_13);
                                    _local_23 = li32(_local_12 - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 4));
                                    _local_19 = li32(_local_11 + 6);
                                    _local_21 = li32(_local_12 + 4);
                                    _local_22 = li32((_local_12 + 8) - _local_13);
                                    _local_23 = li32((_local_12 + 4) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 8));
                                    _local_19 = li32(_local_11 + 9);
                                    _local_21 = li32(_local_12 + 8);
                                    _local_22 = li32((_local_12 + 12) - _local_13);
                                    _local_23 = li32((_local_12 + 8) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 12));
                                    _local_19 = li32(_local_11 + 12);
                                    _local_21 = li32(_local_12 + 12);
                                    _local_22 = li32((_local_12 + 16) - _local_13);
                                    _local_23 = li32((_local_12 + 12) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 16));
                                    _local_19 = li32(_local_11 + 15);
                                    _local_21 = li32(_local_12 + 16);
                                    _local_22 = li32((_local_12 + 20) - _local_13);
                                    _local_23 = li32((_local_12 + 16) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 20));
                                    _local_19 = li32(_local_11 + 18);
                                    _local_21 = li32(_local_12 + 20);
                                    _local_22 = li32((_local_12 + 24) - _local_13);
                                    _local_23 = li32((_local_12 + 20) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 24));
                                    _local_19 = li32(_local_11 + 21);
                                    _local_21 = li32(_local_12 + 24);
                                    _local_22 = li32((_local_12 + 28) - _local_13);
                                    _local_23 = li32((_local_12 + 24) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 28));
                                    _local_19 = li32(_local_11 + 24);
                                    _local_21 = li32(_local_12 + 28);
                                    _local_22 = li32((_local_12 + 32) - _local_13);
                                    _local_23 = li32((_local_12 + 28) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 32));
                                    _local_19 = li32(_local_11 + 27);
                                    _local_21 = li32(_local_12 + 32);
                                    _local_22 = li32((_local_12 + 36) - _local_13);
                                    _local_23 = li32((_local_12 + 32) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 36));
                                    _local_19 = li32(_local_11 + 30);
                                    _local_21 = li32(_local_12 + 36);
                                    _local_22 = li32((_local_12 + 40) - _local_13);
                                    _local_23 = li32((_local_12 + 36) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 40));
                                    _local_19 = li32(_local_11 + 33);
                                    _local_21 = li32(_local_12 + 40);
                                    _local_22 = li32((_local_12 + 44) - _local_13);
                                    _local_23 = li32((_local_12 + 40) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 44));
                                    _local_19 = li32(_local_11 + 36);
                                    _local_21 = li32(_local_12 + 44);
                                    _local_22 = li32((_local_12 + 48) - _local_13);
                                    _local_23 = li32((_local_12 + 44) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 48));
                                    _local_19 = li32(_local_11 + 39);
                                    _local_21 = li32(_local_12 + 48);
                                    _local_22 = li32((_local_12 + 52) - _local_13);
                                    _local_23 = li32((_local_12 + 48) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 52));
                                    _local_19 = li32(_local_11 + 42);
                                    _local_21 = li32(_local_12 + 52);
                                    _local_22 = li32((_local_12 + 56) - _local_13);
                                    _local_23 = li32((_local_12 + 52) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 56));
                                    _local_19 = li32(_local_11 + 45);
                                    _local_21 = li32(_local_12 + 56);
                                    _local_22 = li32((_local_12 + 60) - _local_13);
                                    _local_23 = li32((_local_12 + 56) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, (_local_12 + 60));
                                    _local_11 = (_local_11 + 48);
                                    _local_12 = (_local_12 + 64);
                                };
                                while (_local_12 != _local_14)
                                {
                                    _local_19 = li32(_local_11);
                                    _local_21 = li32(_local_12 - 4);
                                    _local_22 = li32(_local_12 - _local_13);
                                    _local_23 = li32((_local_12 - 4) - _local_13);
                                    _local_25 = ((_local_22 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_26 = (_local_25 >> 31);
                                    _local_24 = ((_local_25 + _local_26) ^ _local_26);
                                    _local_26 = ((_local_21 & 0xFF00) - (_local_23 & 0xFF00));
                                    _local_27 = (_local_26 >> 31);
                                    _local_25 = ((_local_26 + _local_27) ^ _local_27);
                                    _local_27 = (((_local_21 & 0xFF00) + (_local_22 & 0xFF00)) - ((_local_23 << 1) & 0x01FE00));
                                    _local_28 = (_local_27 >> 31);
                                    _local_26 = ((_local_27 + _local_28) ^ _local_28);
                                    _local_27 = ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF00);
                                    _local_28 = (((_local_26 - _local_25) >> 31) & 0xFF00);
                                    _local_29 = ((_local_22 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((_local_21 & 0xFF0000) - (_local_23 & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 & 0xFF0000) + (_local_22 & 0xFF0000)) - ((_local_23 << 1) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF0000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF0000));
                                    _local_29 = (((_local_22 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_24 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = (((_local_21 >> 8) & 0xFF0000) - ((_local_23 >> 8) & 0xFF0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_25 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_29 = ((((_local_21 >> 8) & 0xFF0000) + ((_local_22 >> 8) & 0xFF0000)) - ((_local_23 >> 7) & 0x01FE0000));
                                    _local_30 = (_local_29 >> 31);
                                    _local_26 = ((_local_29 + _local_30) ^ _local_30);
                                    _local_27 = (_local_27 | ((((_local_25 - _local_24) | (_local_26 - _local_24)) >> 31) & 0xFF000000));
                                    _local_28 = (_local_28 | (((_local_26 - _local_25) >> 31) & 0xFF000000));
                                    _local_31 = (((_local_21 & (~(_local_27))) | ((_local_22 & _local_27) & (~(_local_28)))) | ((_local_23 & _local_27) & _local_28));
                                    _local_20 = ((((_local_19 & 0xFF00FF00) + (_local_31 & 0xFF00FF00)) & 0xFF00FF00) | (((_local_19 & 0xFF00FF) + (_local_31 & 0xFF00FF)) & 0xFF00FF));
                                    si32(_local_20, _local_12);
                                    _local_11 = (_local_11 + 3);
                                    _local_12 = (_local_12 + 4);
                                };
                                _local_11++;
                            };
                            ApplicationDomain.currentDomain.domainMemory = _local_10;
                            _local_7.position = _local_17;
                            _local_3 = new BitmapData(_local_4, _local_5, _local_6, 0xFFFFFF);
                            _local_3.setPixels(new Rectangle(0, 0, _local_4, _local_5), _local_7);
                        };
                    };
                };
            };
            return (_local_3);
        }

        public static function freeCachedMemory():void
        {
            if (PNGEncoder2Impl.encoding)
            {
                throw (new Error("Cached resources cannot be freed while an image is being encoded"));
            };
            if (PNGEncoder2Impl.crcComputed)
            {
                if (ApplicationDomain.currentDomain.domainMemory == PNGEncoder2Impl.data)
                {
                    ApplicationDomain.currentDomain.domainMemory = null;
                };
                PNGEncoder2Impl.region = null;
                PNGEncoder2Impl.sprite = null;
                PNGEncoder2Impl.data = null;
                PNGEncoder2Impl.crcComputed = false;
            };
        }


        protected function set_targetFPS(_arg_1:int):int
        {
            var _local_2:int = _arg_1;
            __impl.targetFPS = _local_2;
            return (_local_2);
        }

        protected function get_targetFPS():int
        {
            return (__impl.targetFPS);
        }

        protected function get_png():ByteArray
        {
            return (__impl.png);
        }

        public function set targetFPS(_arg_1:int):void
        {
            __impl.targetFPS = _arg_1;
        }

        public function get targetFPS():int
        {
            return (__impl.targetFPS);
        }

        public function get png():ByteArray
        {
            return (__impl.png);
        }


    }
} 

