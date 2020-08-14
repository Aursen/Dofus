package _PNGEncoder2
{
    import flash.utils.ByteArray;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import __AS3__.vec.Vector;
    import flash.display.BitmapData;
    import flash.events.IEventDispatcher;
    import flash.system.ApplicationDomain;
    import flash.utils.getTimer;
    import flash.events.ProgressEvent;
    import flash.events.Event;
    import flash.Lib;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public class PNGEncoder2Impl 
    {

        public static var CRC_TABLE_END:int = 0x0400;
        public static var DEFLATE_SCRATCH:int = 0x0400;
        public static var CHUNK_START:int = 6600;
        public static var FRAME_AVG_SMOOTH_COUNT:int = 4;
        public static var FIRST_UPDATE_PIXELS:int = 0x5000;
        public static var MIN_PIXELS_PER_UPDATE:int = 0x5000;
        public static var data:ByteArray;
        public static var sprite:Sprite;
        public static var encoding:Boolean = false;
        public static var region:Rectangle;
        public static var pendingAsyncEncodings:Vector.<PNGEncoder2Impl> = new __AS3__.vec.Vector.<PNGEncoder2Impl>();
        public static var level:CompressionLevel;
        public static var crcComputed:Boolean = false;

        public var updatesPerFrameIndex:int;
        public var updatesPerFrame:Vector.<int>;
        public var updates:int;
        public var targetFPS:int = 20;
        public var step:int;
        public var png:ByteArray;
        public var msPerLineIndex:int;
        public var msPerLine:Vector.<Number>;
        public var msPerFrameIndex:int;
        public var msPerFrame:Vector.<int>;
        public var metadata:*;
        public var lastFrameStart:int;
        public var img:BitmapData;
        public var frameCount:int;
        public var done:Boolean;
        public var dispatcher:IEventDispatcher;
        public var deflateStream:DeflateStream;
        public var currentY:int;

        public function PNGEncoder2Impl(_arg_1:BitmapData, _arg_2:IEventDispatcher, _arg_3:*):void
        {
            _new(_arg_1, _arg_2, _arg_3);
        }

        public static function encode(_arg_1:BitmapData, _arg_2:*):ByteArray
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

        public static function rotl8(_arg_1:int):int
        {
            return ((_arg_1 << 8) | (_arg_1 >>> 24));
        }

        public static function byteAdd4(_arg_1:uint, _arg_2:uint):int
        {
            return ((((_arg_1 & 0xFF00FF00) + (_arg_2 & 0xFF00FF00)) & 0xFF00FF00) | (((_arg_1 & 0xFF00FF) + (_arg_2 & 0xFF00FF)) & 0xFF00FF));
        }

        public static function paethPredictor3Hi(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_5:* = ((_arg_2 & 0xFF00) - (_arg_3 & 0xFF00));
            var _local_6:* = (_local_5 >> 31);
            var _local_4:* = ((_local_5 + _local_6) ^ _local_6);
            _local_6 = ((_arg_1 & 0xFF00) - (_arg_3 & 0xFF00));
            var _local_7:* = (_local_6 >> 31);
            _local_5 = ((_local_6 + _local_7) ^ _local_7);
            _local_7 = (((_arg_1 & 0xFF00) + (_arg_2 & 0xFF00)) - ((_arg_3 << 1) & 0x01FE00));
            var _local_8:* = (_local_7 >> 31);
            _local_6 = ((_local_7 + _local_8) ^ _local_8);
            _local_7 = ((((_local_5 - _local_4) | (_local_6 - _local_4)) >> 31) & 0xFF00);
            _local_8 = (((_local_6 - _local_5) >> 31) & 0xFF00);
            var _local_9:* = ((_arg_2 & 0xFF0000) - (_arg_3 & 0xFF0000));
            var _local_10:* = (_local_9 >> 31);
            _local_4 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = ((_arg_1 & 0xFF0000) - (_arg_3 & 0xFF0000));
            _local_10 = (_local_9 >> 31);
            _local_5 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = (((_arg_1 & 0xFF0000) + (_arg_2 & 0xFF0000)) - ((_arg_3 << 1) & 0x01FE0000));
            _local_10 = (_local_9 >> 31);
            _local_6 = ((_local_9 + _local_10) ^ _local_10);
            _local_7 = (_local_7 | ((((_local_5 - _local_4) | (_local_6 - _local_4)) >> 31) & 0xFF0000));
            _local_8 = (_local_8 | (((_local_6 - _local_5) >> 31) & 0xFF0000));
            _local_9 = (((_arg_2 >> 8) & 0xFF0000) - ((_arg_3 >> 8) & 0xFF0000));
            _local_10 = (_local_9 >> 31);
            _local_4 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = (((_arg_1 >> 8) & 0xFF0000) - ((_arg_3 >> 8) & 0xFF0000));
            _local_10 = (_local_9 >> 31);
            _local_5 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = ((((_arg_1 >> 8) & 0xFF0000) + ((_arg_2 >> 8) & 0xFF0000)) - ((_arg_3 >> 7) & 0x01FE0000));
            _local_10 = (_local_9 >> 31);
            _local_6 = ((_local_9 + _local_10) ^ _local_10);
            _local_7 = (_local_7 | ((((_local_5 - _local_4) | (_local_6 - _local_4)) >> 31) & 0xFF000000));
            _local_8 = (_local_8 | (((_local_6 - _local_5) >> 31) & 0xFF000000));
            return (((_arg_1 & (~(_local_7))) | ((_arg_2 & _local_7) & (~(_local_8)))) | ((_arg_3 & _local_7) & _local_8));
        }

        public static function beginEncoding(_arg_1:BitmapData, _arg_2:*):ByteArray
        {
            var _local_3:Number;
            var _local_4:uint;
            var _local_5:int;
            var _local_6:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
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
                _local_3 = Math.max(6600, ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
                PNGEncoder2Impl.data.length = _local_3;
            };
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            if (!PNGEncoder2Impl.crcComputed)
            {
                _local_5 = 0;
                while (_local_5 < 0x0100)
                {
                    _local_6 = _local_5++;
                    _local_4 = _local_6;
                    if ((_local_4 & 0x01) == 1)
                    {
                        _local_4 = (0xEDB88320 ^ (_local_4 >>> 1));
                    }
                    else
                    {
                        _local_4 = (_local_4 >>> 1);
                    };
                    if ((_local_4 & 0x01) == 1)
                    {
                        _local_4 = (0xEDB88320 ^ (_local_4 >>> 1));
                    }
                    else
                    {
                        _local_4 = (_local_4 >>> 1);
                    };
                    if ((_local_4 & 0x01) == 1)
                    {
                        _local_4 = (0xEDB88320 ^ (_local_4 >>> 1));
                    }
                    else
                    {
                        _local_4 = (_local_4 >>> 1);
                    };
                    if ((_local_4 & 0x01) == 1)
                    {
                        _local_4 = (0xEDB88320 ^ (_local_4 >>> 1));
                    }
                    else
                    {
                        _local_4 = (_local_4 >>> 1);
                    };
                    if ((_local_4 & 0x01) == 1)
                    {
                        _local_4 = (0xEDB88320 ^ (_local_4 >>> 1));
                    }
                    else
                    {
                        _local_4 = (_local_4 >>> 1);
                    };
                    if ((_local_4 & 0x01) == 1)
                    {
                        _local_4 = (0xEDB88320 ^ (_local_4 >>> 1));
                    }
                    else
                    {
                        _local_4 = (_local_4 >>> 1);
                    };
                    if ((_local_4 & 0x01) == 1)
                    {
                        _local_4 = (0xEDB88320 ^ (_local_4 >>> 1));
                    }
                    else
                    {
                        _local_4 = (_local_4 >>> 1);
                    };
                    if ((_local_4 & 0x01) == 1)
                    {
                        _local_4 = (0xEDB88320 ^ (_local_4 >>> 1));
                    }
                    else
                    {
                        _local_4 = (_local_4 >>> 1);
                    };
                    si32(_local_4, (_local_6 << 2));
                };
                PNGEncoder2Impl.crcComputed = true;
            };
            var _local_7:ByteArray = new ByteArray();
            _local_7.writeUnsignedInt(-1991225785);
            _local_7.writeUnsignedInt(218765834);
            _local_5 = 13;
            _local_3 = Math.max((6600 + _local_5), ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
            PNGEncoder2Impl.data.length = _local_3;
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            _local_4 = _arg_1.width;
            si8((_local_4 >>> 24), 6600);
            si8((_local_4 >>> 16), 6601);
            si8((_local_4 >>> 8), 6602);
            si8(_local_4, 6603);
            _local_4 = _arg_1.height;
            si8((_local_4 >>> 24), 6604);
            si8((_local_4 >>> 16), 6605);
            si8((_local_4 >>> 8), 6606);
            si8(_local_4, 6607);
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
            _local_6 = _local_5;
            _local_7.writeUnsignedInt(_local_6);
            _local_7.writeUnsignedInt(1229472850);
            if (_local_6 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_local_7, _local_7.position, _local_5);
                _local_7.position = (_local_7.position + _local_6);
            };
            var _local_8:int = -1;
            _local_8 = (li32(((_local_8 ^ 0x49) & 0xFF) << 2) ^ (_local_8 >>> 8));
            _local_8 = (li32(((_local_8 ^ 0x48) & 0xFF) << 2) ^ (_local_8 >>> 8));
            _local_8 = (li32(((_local_8 ^ 0x44) & 0xFF) << 2) ^ (_local_8 >>> 8));
            _local_8 = (li32(((_local_8 ^ 0x52) & 0xFF) << 2) ^ (_local_8 >>> 8));
            if (_local_6 != 0)
            {
                _local_9 = 6600;
                _local_10 = (6600 + _local_6);
                _local_11 = (6600 + (_local_6 & 0xFFFFFFF0));
                while (_local_9 < _local_11)
                {
                    _local_12 = (_local_8 ^ li8(_local_9));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 1));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 2));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 3));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 4));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 5));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 6));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 7));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 8));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 9));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 10));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 11));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 12));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 13));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 14));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_12 = (_local_8 ^ li8(_local_9 + 15));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_9 = (_local_9 + 16);
                };
                while (_local_9 < _local_10)
                {
                    _local_12 = (_local_8 ^ li8(_local_9));
                    _local_8 = (li32((_local_12 & 0xFF) << 2) ^ (_local_8 >>> 8));
                    _local_9++;
                };
            };
            _local_8 = (_local_8 ^ 0xFFFFFFFF);
            _local_7.writeUnsignedInt(_local_8);
            PNGEncoder2Impl.writeMetadataChunks(_arg_2, _local_7);
            return (_local_7);
        }

        public static function endEncoding(_arg_1:ByteArray):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_2:int;
            _arg_1.writeUnsignedInt(_local_2);
            _arg_1.writeUnsignedInt(1229278788);
            if (_local_2 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_arg_1, _arg_1.position, 0);
                _arg_1.position = (_arg_1.position + _local_2);
            };
            var _local_3:int = -1;
            _local_3 = (li32(((_local_3 ^ 0x49) & 0xFF) << 2) ^ (_local_3 >>> 8));
            _local_3 = (li32(((_local_3 ^ 0x45) & 0xFF) << 2) ^ (_local_3 >>> 8));
            _local_3 = (li32(((_local_3 ^ 0x4E) & 0xFF) << 2) ^ (_local_3 >>> 8));
            _local_3 = (li32(((_local_3 ^ 0x44) & 0xFF) << 2) ^ (_local_3 >>> 8));
            if (_local_2 != 0)
            {
                _local_4 = 6600;
                _local_5 = (6600 + _local_2);
                _local_6 = (6600 + (_local_2 & 0xFFFFFFF0));
                while (_local_4 < _local_6)
                {
                    _local_7 = (_local_3 ^ li8(_local_4));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 1));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 2));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 3));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 4));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 5));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 6));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 7));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 8));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 9));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 10));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 11));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 12));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 13));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 14));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 15));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_4 = (_local_4 + 16);
                };
                while (_local_4 < _local_5)
                {
                    _local_7 = (_local_3 ^ li8(_local_4));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_4++;
                };
            };
            _local_3 = (_local_3 ^ 0xFFFFFFFF);
            _arg_1.writeUnsignedInt(_local_3);
            PNGEncoder2Impl.encoding = false;
            _arg_1.position = 0;
        }

        public static function writePNGSignature(_arg_1:ByteArray):void
        {
            _arg_1.writeUnsignedInt(-1991225785);
            _arg_1.writeUnsignedInt(218765834);
        }

        public static function writeIHDRChunk(_arg_1:BitmapData, _arg_2:ByteArray):void
        {
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_3:int = 13;
            var _local_4:Number = Math.max((6600 + _local_3), ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
            PNGEncoder2Impl.data.length = _local_4;
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            var _local_5:uint = _arg_1.width;
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
            var _local_6:int = _local_3;
            _arg_2.writeUnsignedInt(_local_6);
            _arg_2.writeUnsignedInt(1229472850);
            if (_local_6 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_arg_2, _arg_2.position, _local_3);
                _arg_2.position = (_arg_2.position + _local_6);
            };
            var _local_7:int = -1;
            _local_7 = (li32(((_local_7 ^ 0x49) & 0xFF) << 2) ^ (_local_7 >>> 8));
            _local_7 = (li32(((_local_7 ^ 0x48) & 0xFF) << 2) ^ (_local_7 >>> 8));
            _local_7 = (li32(((_local_7 ^ 0x44) & 0xFF) << 2) ^ (_local_7 >>> 8));
            _local_7 = (li32(((_local_7 ^ 0x52) & 0xFF) << 2) ^ (_local_7 >>> 8));
            if (_local_6 != 0)
            {
                _local_8 = 6600;
                _local_9 = (6600 + _local_6);
                _local_10 = (6600 + (_local_6 & 0xFFFFFFF0));
                while (_local_8 < _local_10)
                {
                    _local_11 = (_local_7 ^ li8(_local_8));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 1));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 2));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 3));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 4));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 5));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 6));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 7));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 8));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 9));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 10));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 11));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 12));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 13));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 14));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_11 = (_local_7 ^ li8(_local_8 + 15));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_8 = (_local_8 + 16);
                };
                while (_local_8 < _local_9)
                {
                    _local_11 = (_local_7 ^ li8(_local_8));
                    _local_7 = (li32((_local_11 & 0xFF) << 2) ^ (_local_7 >>> 8));
                    _local_8++;
                };
            };
            _local_7 = (_local_7 ^ 0xFFFFFFFF);
            _arg_2.writeUnsignedInt(_local_7);
        }

        public static function writeMetadataChunks(_arg_1:*, _arg_2:ByteArray):void
        {
            var _local_3:* = (null as ByteArray);
            var _local_4:* = (null as Array);
            var _local_5:* = (null as Class);
            var _local_6:int;
            var _local_7:* = (null as String);
            var _local_8:Boolean;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:* = null;
            var _local_13:* = (null as String);
            var _local_14:Boolean;
            var _local_15:* = null;
            var _local_16:uint;
            var _local_17:Number;
            var _local_18:uint;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            if (_arg_1 != null)
            {
                _local_3 = new ByteArray();
                ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
                _local_4 = Reflect.fields(_arg_1);
                if (((_local_4 == (null)) || (_local_4.length == 0)))
                {
                    _local_5 = Type.getClass(_arg_1);
                    if (_local_5 != null)
                    {
                        _local_4 = Type.getInstanceFields(_local_5);
                    };
                };
                _local_6 = 0;
                while (_local_6 < _local_4.length)
                {
                    _local_7 = _local_4[_local_6];
                    _local_6++;
                    if (!((_local_7.length < (1)) || (_local_7.length > 79)))
                    {
                        _local_3.clear();
                        _local_3.position = 0;
                        _local_8 = true;
                        _local_9 = 0;
                        _local_10 = _local_7.length;
                        while (_local_9 < _local_10)
                        {
                            _local_11 = _local_9++;
                            _local_12 = _local_7.charCodeAt(_local_11);
                            if (!(((_local_12 >= (32)) && (_local_12 <= 126)) || ((_local_12 >= (161)) && (_local_12 <= 0xFF))))
                            {
                                _local_8 = false;
                                break;
                            };
                            _local_3.writeByte(_local_12);
                        };
                        if (_local_8)
                        {
                            _local_12 = Reflect.field(_arg_1, _local_7);
                            if (!((_local_12 == (null)) || (Reflect.isFunction(_local_12))))
                            {
                                _local_13 = Std.string(_local_12);
                                _local_13 = StringTools.replace(_local_13, "\r\n", "\n");
                                _local_13 = StringTools.replace(_local_13, "\r", "\n");
                                _local_14 = true;
                                _local_9 = 0;
                                _local_10 = _local_13.length;
                                while (_local_9 < _local_10)
                                {
                                    _local_11 = _local_9++;
                                    _local_15 = _local_13.charCodeAt(_local_11);
                                    if (((_local_15 < (0)) || (_local_15 > 0xFF)))
                                    {
                                        _local_14 = false;
                                        break;
                                    };
                                };
                                if (_local_14)
                                {
                                    _local_3.writeByte(0);
                                    _local_9 = 0;
                                    _local_10 = _local_13.length;
                                    while (_local_9 < _local_10)
                                    {
                                        _local_11 = _local_9++;
                                        _local_3.writeByte(_local_13.charCodeAt(_local_11));
                                    };
                                }
                                else
                                {
                                    _local_3.writeInt(0);
                                    _local_3.writeByte(0);
                                    _local_3.writeUTFBytes(_local_13);
                                };
                                _local_16 = (6600 + _local_3.length);
                                if (PNGEncoder2Impl.data.length < _local_16)
                                {
                                    _local_17 = Math.max((6600 + _local_3.length), ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
                                    PNGEncoder2Impl.data.length = _local_17;
                                    ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
                                };
                                _local_3.position = 0;
                                _local_18 = 0;
                                _local_3.readBytes(ApplicationDomain.currentDomain.domainMemory, 6600, _local_18);
                                if (_local_14)
                                {
                                    _local_9 = 1950701684;
                                }
                                else
                                {
                                    _local_9 = 1767135348;
                                };
                                _local_10 = _local_3.length;
                                _local_11 = _local_10;
                                _arg_2.writeUnsignedInt(_local_11);
                                _arg_2.writeUnsignedInt(_local_9);
                                if (_local_11 != 0)
                                {
                                    PNGEncoder2Impl.data.position = 6600;
                                    PNGEncoder2Impl.data.readBytes(_arg_2, _arg_2.position, _local_10);
                                    _arg_2.position = (_arg_2.position + _local_11);
                                };
                                _local_19 = -1;
                                _local_19 = (li32(((_local_19 ^ (_local_9 >>> 24)) & 0xFF) << 2) ^ (_local_19 >>> 8));
                                _local_19 = (li32(((_local_19 ^ ((_local_9 >>> 16) & 0xFF)) & 0xFF) << 2) ^ (_local_19 >>> 8));
                                _local_19 = (li32(((_local_19 ^ ((_local_9 >>> 8) & 0xFF)) & 0xFF) << 2) ^ (_local_19 >>> 8));
                                _local_19 = (li32(((_local_19 ^ (_local_9 & 0xFF)) & 0xFF) << 2) ^ (_local_19 >>> 8));
                                if (_local_11 != 0)
                                {
                                    _local_20 = 6600;
                                    _local_21 = (6600 + _local_11);
                                    _local_22 = (6600 + (_local_11 & 0xFFFFFFF0));
                                    while (_local_20 < _local_22)
                                    {
                                        _local_23 = (_local_19 ^ li8(_local_20));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 1));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 2));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 3));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 4));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 5));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 6));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 7));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 8));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 9));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 10));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 11));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 12));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 13));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 14));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_23 = (_local_19 ^ li8(_local_20 + 15));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_20 = (_local_20 + 16);
                                    };
                                    while (_local_20 < _local_21)
                                    {
                                        _local_23 = (_local_19 ^ li8(_local_20));
                                        _local_19 = (li32((_local_23 & 0xFF) << 2) ^ (_local_19 >>> 8));
                                        _local_20++;
                                    };
                                };
                                _local_19 = (_local_19 ^ 0xFFFFFFFF);
                                _arg_2.writeUnsignedInt(_local_19);
                            };
                        };
                    };
                };
            };
        }

        public static function memcpy(_arg_1:ByteArray, _arg_2:uint, _arg_3:uint=0):void
        {
            _arg_1.readBytes(ApplicationDomain.currentDomain.domainMemory, _arg_2, _arg_3);
        }

        public static function writeI32BE(_arg_1:uint, _arg_2:uint):void
        {
            si8((_arg_2 >>> 24), _arg_1);
            si8((_arg_2 >>> 16), (_arg_1 + 1));
            si8((_arg_2 >>> 8), (_arg_1 + 2));
            si8(_arg_2, (_arg_1 + 3));
        }

        public static function writeIDATChunk(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:DeflateStream, _arg_5:ByteArray):void
        {
            var _local_7:int;
            var _local_11:int;
            var _local_13:uint;
            var _local_20:uint;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            var _local_25:uint;
            var _local_26:int;
            var _local_27:int;
            var _local_28:int;
            var _local_29:int;
            var _local_30:int;
            var _local_31:int;
            var _local_32:int;
            var _local_33:int;
            var _local_34:int;
            var _local_35:int;
            var _local_36:int;
            var _local_37:int;
            var _local_39:* = (null as MemoryRange);
            var _local_6:int = _arg_1.width;
            if (_arg_2 == 0)
            {
                _local_7 = 0;
            }
            else
            {
                _local_7 = (_arg_2 - 1);
            };
            var _local_8:* = (_arg_3 - _arg_2);
            var _local_9:* = (_arg_3 - _local_7);
            PNGEncoder2Impl.region.y = _local_7;
            PNGEncoder2Impl.region.width = _local_6;
            PNGEncoder2Impl.region.height = _local_9;
            var _local_10:* = (_local_6 << 2);
            if (_arg_1.transparent)
            {
                _local_11 = 4;
            }
            else
            {
                _local_11 = 3;
            };
            var _local_12:uint = (((_local_6 * _local_8) * _local_11) + _local_8);
            if (_arg_1.transparent)
            {
                _local_13 = 0;
            }
            else
            {
                _local_13 = 1;
            };
            var _local_14:uint = ((_local_6 * _local_9) * 4);
            var _local_15:Number = Math.max(((((6600 + _arg_4.maxOutputBufferSize(_local_12)) + _local_14) + _local_12) + _local_13), ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
            PNGEncoder2Impl.data.length = _local_15;
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            var _local_16:* = (6600 + _arg_4.maxOutputBufferSize(_local_12));
            var _local_17:int = (_local_16 + _local_14);
            var _local_18:int = _local_17;
            var _local_19:ByteArray = _arg_1.getPixels(PNGEncoder2Impl.region);
            _local_19.position = 0;
            _local_20 = 0;
            _local_19.readBytes(ApplicationDomain.currentDomain.domainMemory, _local_16, _local_20);
            if (_local_7 != _arg_2)
            {
                _local_16 = (_local_16 + (_local_6 * 4));
            };
            if (_arg_1.transparent)
            {
                if (_local_7 == _arg_2)
                {
                    si8(1, _local_18);
                    _local_18 = (_local_18 + 1);
                    if (((_local_6 > (0)) && (_local_8 > 0)))
                    {
                        _local_24 = li32(_local_16);
                        _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                        si32(_local_23, _local_18);
                        _local_21 = (_local_18 + _local_10);
                        _local_18 = (_local_18 + 4);
                        _local_16 = (_local_16 + 4);
                        _local_22 = (_local_18 + ((_local_10 - 1) & 0xFFFFFFC0));
                        while (_local_18 != _local_22)
                        {
                            _local_20 = li32(_local_16);
                            _local_25 = li32(_local_16 - 4);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, _local_18);
                            _local_20 = li32(_local_16 + 4);
                            _local_25 = li32(_local_16);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 4));
                            _local_20 = li32(_local_16 + 8);
                            _local_25 = li32(_local_16 + 4);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 8));
                            _local_20 = li32(_local_16 + 12);
                            _local_25 = li32(_local_16 + 8);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 12));
                            _local_20 = li32(_local_16 + 16);
                            _local_25 = li32(_local_16 + 12);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 16));
                            _local_20 = li32(_local_16 + 20);
                            _local_25 = li32(_local_16 + 16);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 20));
                            _local_20 = li32(_local_16 + 24);
                            _local_25 = li32(_local_16 + 20);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 24));
                            _local_20 = li32(_local_16 + 28);
                            _local_25 = li32(_local_16 + 24);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 28));
                            _local_20 = li32(_local_16 + 32);
                            _local_25 = li32(_local_16 + 28);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 32));
                            _local_20 = li32(_local_16 + 36);
                            _local_25 = li32(_local_16 + 32);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 36));
                            _local_20 = li32(_local_16 + 40);
                            _local_25 = li32(_local_16 + 36);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 40));
                            _local_20 = li32(_local_16 + 44);
                            _local_25 = li32(_local_16 + 40);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 44));
                            _local_20 = li32(_local_16 + 48);
                            _local_25 = li32(_local_16 + 44);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 48));
                            _local_20 = li32(_local_16 + 52);
                            _local_25 = li32(_local_16 + 48);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 52));
                            _local_20 = li32(_local_16 + 56);
                            _local_25 = li32(_local_16 + 52);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 56));
                            _local_20 = li32(_local_16 + 60);
                            _local_25 = li32(_local_16 + 56);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 60));
                            _local_18 = (_local_18 + 64);
                            _local_16 = (_local_16 + 64);
                        };
                        while (_local_18 != _local_21)
                        {
                            _local_20 = li32(_local_16);
                            _local_25 = li32(_local_16 - 4);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, _local_18);
                            _local_18 = (_local_18 + 4);
                            _local_16 = (_local_16 + 4);
                        };
                    };
                };
                _local_23 = 1;
                while (_local_23 < _local_9)
                {
                    _local_24 = _local_23++;
                    si8(4, _local_18);
                    _local_18 = (_local_18 + 1);
                    if (_local_6 > 0)
                    {
                        _local_20 = li32(_local_16);
                        _local_25 = li32(_local_16 - _local_10);
                        _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                        _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                        si32(_local_26, _local_18);
                        _local_21 = (_local_18 + _local_10);
                        _local_18 = (_local_18 + 4);
                        _local_16 = (_local_16 + 4);
                        _local_22 = (_local_18 + ((_local_10 - 1) & 0xFFFFFFC0));
                        while (_local_18 != _local_22)
                        {
                            _local_20 = li32(_local_16);
                            _local_28 = li32(_local_16 - 4);
                            _local_29 = li32(_local_16 - _local_10);
                            _local_30 = li32((_local_16 - 4) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, _local_18);
                            _local_20 = li32(_local_16 + 4);
                            _local_28 = li32(_local_16);
                            _local_29 = li32((_local_16 + 4) - _local_10);
                            _local_30 = li32(_local_16 - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 4));
                            _local_20 = li32(_local_16 + 8);
                            _local_28 = li32(_local_16 + 4);
                            _local_29 = li32((_local_16 + 8) - _local_10);
                            _local_30 = li32((_local_16 + 4) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 8));
                            _local_20 = li32(_local_16 + 12);
                            _local_28 = li32(_local_16 + 8);
                            _local_29 = li32((_local_16 + 12) - _local_10);
                            _local_30 = li32((_local_16 + 8) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 12));
                            _local_20 = li32(_local_16 + 16);
                            _local_28 = li32(_local_16 + 12);
                            _local_29 = li32((_local_16 + 16) - _local_10);
                            _local_30 = li32((_local_16 + 12) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 16));
                            _local_20 = li32(_local_16 + 20);
                            _local_28 = li32(_local_16 + 16);
                            _local_29 = li32((_local_16 + 20) - _local_10);
                            _local_30 = li32((_local_16 + 16) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 20));
                            _local_20 = li32(_local_16 + 24);
                            _local_28 = li32(_local_16 + 20);
                            _local_29 = li32((_local_16 + 24) - _local_10);
                            _local_30 = li32((_local_16 + 20) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 24));
                            _local_20 = li32(_local_16 + 28);
                            _local_28 = li32(_local_16 + 24);
                            _local_29 = li32((_local_16 + 28) - _local_10);
                            _local_30 = li32((_local_16 + 24) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 28));
                            _local_20 = li32(_local_16 + 32);
                            _local_28 = li32(_local_16 + 28);
                            _local_29 = li32((_local_16 + 32) - _local_10);
                            _local_30 = li32((_local_16 + 28) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 32));
                            _local_20 = li32(_local_16 + 36);
                            _local_28 = li32(_local_16 + 32);
                            _local_29 = li32((_local_16 + 36) - _local_10);
                            _local_30 = li32((_local_16 + 32) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 36));
                            _local_20 = li32(_local_16 + 40);
                            _local_28 = li32(_local_16 + 36);
                            _local_29 = li32((_local_16 + 40) - _local_10);
                            _local_30 = li32((_local_16 + 36) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 40));
                            _local_20 = li32(_local_16 + 44);
                            _local_28 = li32(_local_16 + 40);
                            _local_29 = li32((_local_16 + 44) - _local_10);
                            _local_30 = li32((_local_16 + 40) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 44));
                            _local_20 = li32(_local_16 + 48);
                            _local_28 = li32(_local_16 + 44);
                            _local_29 = li32((_local_16 + 48) - _local_10);
                            _local_30 = li32((_local_16 + 44) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 48));
                            _local_20 = li32(_local_16 + 52);
                            _local_28 = li32(_local_16 + 48);
                            _local_29 = li32((_local_16 + 52) - _local_10);
                            _local_30 = li32((_local_16 + 48) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 52));
                            _local_20 = li32(_local_16 + 56);
                            _local_28 = li32(_local_16 + 52);
                            _local_29 = li32((_local_16 + 56) - _local_10);
                            _local_30 = li32((_local_16 + 52) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 56));
                            _local_20 = li32(_local_16 + 60);
                            _local_28 = li32(_local_16 + 56);
                            _local_29 = li32((_local_16 + 60) - _local_10);
                            _local_30 = li32((_local_16 + 56) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 60));
                            _local_18 = (_local_18 + 64);
                            _local_16 = (_local_16 + 64);
                        };
                        while (_local_18 != _local_21)
                        {
                            _local_20 = li32(_local_16);
                            _local_28 = li32(_local_16 - 4);
                            _local_29 = li32(_local_16 - _local_10);
                            _local_30 = li32((_local_16 - 4) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, _local_18);
                            _local_18 = (_local_18 + 4);
                            _local_16 = (_local_16 + 4);
                        };
                    };
                };
            }
            else
            {
                if (_local_7 == _arg_2)
                {
                    si8(1, _local_18);
                    _local_18 = (_local_18 + 1);
                    if (((_local_6 > (0)) && (_local_8 > 0)))
                    {
                        _local_23 = li16(_local_16 + 1);
                        si16(_local_23, _local_18);
                        _local_23 = li8(_local_16 + 3);
                        si8(_local_23, (_local_18 + 2));
                        _local_21 = (_local_18 + (_local_6 * 3));
                        _local_18 = (_local_18 + 3);
                        _local_16 = (_local_16 + 4);
                        _local_22 = (++_local_16 + (((_local_6 * 3) - 1) & 0xFFFFFFC0));
                        while (_local_16 != _local_22)
                        {
                            _local_20 = li32(_local_16);
                            _local_25 = li32(_local_16 - 4);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, _local_18);
                            _local_20 = li32(_local_16 + 4);
                            _local_25 = li32(_local_16);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 3));
                            _local_20 = li32(_local_16 + 8);
                            _local_25 = li32(_local_16 + 4);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 6));
                            _local_20 = li32(_local_16 + 12);
                            _local_25 = li32(_local_16 + 8);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 9));
                            _local_20 = li32(_local_16 + 16);
                            _local_25 = li32(_local_16 + 12);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 12));
                            _local_20 = li32(_local_16 + 20);
                            _local_25 = li32(_local_16 + 16);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 15));
                            _local_20 = li32(_local_16 + 24);
                            _local_25 = li32(_local_16 + 20);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 18));
                            _local_20 = li32(_local_16 + 28);
                            _local_25 = li32(_local_16 + 24);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 21));
                            _local_20 = li32(_local_16 + 32);
                            _local_25 = li32(_local_16 + 28);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 24));
                            _local_20 = li32(_local_16 + 36);
                            _local_25 = li32(_local_16 + 32);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 27));
                            _local_20 = li32(_local_16 + 40);
                            _local_25 = li32(_local_16 + 36);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 30));
                            _local_20 = li32(_local_16 + 44);
                            _local_25 = li32(_local_16 + 40);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 33));
                            _local_20 = li32(_local_16 + 48);
                            _local_25 = li32(_local_16 + 44);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 36));
                            _local_20 = li32(_local_16 + 52);
                            _local_25 = li32(_local_16 + 48);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 39));
                            _local_20 = li32(_local_16 + 56);
                            _local_25 = li32(_local_16 + 52);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 42));
                            _local_20 = li32(_local_16 + 60);
                            _local_25 = li32(_local_16 + 56);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 45));
                            _local_18 = (_local_18 + 48);
                            _local_16 = (_local_16 + 64);
                        };
                        while (_local_18 != _local_21)
                        {
                            _local_20 = li32(_local_16);
                            _local_25 = li32(_local_16 - 4);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, _local_18);
                            _local_18 = (_local_18 + 3);
                            _local_16 = (_local_16 + 4);
                        };
                        _local_16--;
                    };
                };
                _local_23 = 1;
                while (_local_23 < _local_9)
                {
                    _local_24 = _local_23++;
                    si8(4, _local_18);
                    _local_18 = (_local_18 + 1);
                    if (_local_6 > 0)
                    {
                        _local_20 = li32(_local_16 + 1);
                        _local_25 = li32((_local_16 + 1) - _local_10);
                        _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                        si32(_local_26, _local_18);
                        _local_21 = (_local_18 + (_local_6 * 3));
                        _local_18 = (_local_18 + 3);
                        _local_16 = (_local_16 + 4);
                        _local_22 = (++_local_16 + (((_local_6 * 3) - 1) & 0xFFFFFFC0));
                        while (_local_16 != _local_22)
                        {
                            _local_20 = li32(_local_16);
                            _local_27 = li32(_local_16 - 4);
                            _local_28 = li32(_local_16 - _local_10);
                            _local_29 = li32((_local_16 - 4) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, _local_18);
                            _local_20 = li32(_local_16 + 4);
                            _local_27 = li32(_local_16);
                            _local_28 = li32((_local_16 + 4) - _local_10);
                            _local_29 = li32(_local_16 - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 3));
                            _local_20 = li32(_local_16 + 8);
                            _local_27 = li32(_local_16 + 4);
                            _local_28 = li32((_local_16 + 8) - _local_10);
                            _local_29 = li32((_local_16 + 4) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 6));
                            _local_20 = li32(_local_16 + 12);
                            _local_27 = li32(_local_16 + 8);
                            _local_28 = li32((_local_16 + 12) - _local_10);
                            _local_29 = li32((_local_16 + 8) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 9));
                            _local_20 = li32(_local_16 + 16);
                            _local_27 = li32(_local_16 + 12);
                            _local_28 = li32((_local_16 + 16) - _local_10);
                            _local_29 = li32((_local_16 + 12) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 12));
                            _local_20 = li32(_local_16 + 20);
                            _local_27 = li32(_local_16 + 16);
                            _local_28 = li32((_local_16 + 20) - _local_10);
                            _local_29 = li32((_local_16 + 16) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 15));
                            _local_20 = li32(_local_16 + 24);
                            _local_27 = li32(_local_16 + 20);
                            _local_28 = li32((_local_16 + 24) - _local_10);
                            _local_29 = li32((_local_16 + 20) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 18));
                            _local_20 = li32(_local_16 + 28);
                            _local_27 = li32(_local_16 + 24);
                            _local_28 = li32((_local_16 + 28) - _local_10);
                            _local_29 = li32((_local_16 + 24) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 21));
                            _local_20 = li32(_local_16 + 32);
                            _local_27 = li32(_local_16 + 28);
                            _local_28 = li32((_local_16 + 32) - _local_10);
                            _local_29 = li32((_local_16 + 28) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 24));
                            _local_20 = li32(_local_16 + 36);
                            _local_27 = li32(_local_16 + 32);
                            _local_28 = li32((_local_16 + 36) - _local_10);
                            _local_29 = li32((_local_16 + 32) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 27));
                            _local_20 = li32(_local_16 + 40);
                            _local_27 = li32(_local_16 + 36);
                            _local_28 = li32((_local_16 + 40) - _local_10);
                            _local_29 = li32((_local_16 + 36) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 30));
                            _local_20 = li32(_local_16 + 44);
                            _local_27 = li32(_local_16 + 40);
                            _local_28 = li32((_local_16 + 44) - _local_10);
                            _local_29 = li32((_local_16 + 40) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 33));
                            _local_20 = li32(_local_16 + 48);
                            _local_27 = li32(_local_16 + 44);
                            _local_28 = li32((_local_16 + 48) - _local_10);
                            _local_29 = li32((_local_16 + 44) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 36));
                            _local_20 = li32(_local_16 + 52);
                            _local_27 = li32(_local_16 + 48);
                            _local_28 = li32((_local_16 + 52) - _local_10);
                            _local_29 = li32((_local_16 + 48) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 39));
                            _local_20 = li32(_local_16 + 56);
                            _local_27 = li32(_local_16 + 52);
                            _local_28 = li32((_local_16 + 56) - _local_10);
                            _local_29 = li32((_local_16 + 52) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 42));
                            _local_20 = li32(_local_16 + 60);
                            _local_27 = li32(_local_16 + 56);
                            _local_28 = li32((_local_16 + 60) - _local_10);
                            _local_29 = li32((_local_16 + 56) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 45));
                            _local_18 = (_local_18 + 48);
                            _local_16 = (_local_16 + 64);
                        };
                        while (_local_18 != _local_21)
                        {
                            _local_20 = li32(_local_16);
                            _local_27 = li32(_local_16 - 4);
                            _local_28 = li32(_local_16 - _local_10);
                            _local_29 = li32((_local_16 - 4) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, _local_18);
                            _local_18 = (_local_18 + 3);
                            _local_16 = (_local_16 + 4);
                        };
                        _local_16--;
                    };
                };
            };
            _arg_4.fastWrite(_local_17, (_local_17 + _local_12));
            var _local_38:* = (_arg_3 == _arg_1.height);
            if (_local_38)
            {
                _local_39 = _arg_4.fastFinalize();
            }
            else
            {
                _local_39 = _arg_4.peek();
            };
            _local_23 = (_local_39.end - _local_39.offset);
            _local_24 = _local_23;
            _arg_5.writeUnsignedInt(_local_24);
            _arg_5.writeUnsignedInt(1229209940);
            if (_local_24 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_arg_5, _arg_5.position, _local_23);
                _arg_5.position = (_arg_5.position + _local_24);
            };
            _local_26 = -1;
            _local_26 = (li32(((_local_26 ^ 0x49) & 0xFF) << 2) ^ (_local_26 >>> 8));
            _local_26 = (li32(((_local_26 ^ 0x44) & 0xFF) << 2) ^ (_local_26 >>> 8));
            _local_26 = (li32(((_local_26 ^ 0x41) & 0xFF) << 2) ^ (_local_26 >>> 8));
            _local_26 = (li32(((_local_26 ^ 0x54) & 0xFF) << 2) ^ (_local_26 >>> 8));
            if (_local_24 != 0)
            {
                _local_27 = 6600;
                _local_28 = (6600 + _local_24);
                _local_29 = (6600 + (_local_24 & 0xFFFFFFF0));
                while (_local_27 < _local_29)
                {
                    _local_30 = (_local_26 ^ li8(_local_27));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 1));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 2));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 3));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 4));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 5));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 6));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 7));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 8));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 9));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 10));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 11));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 12));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 13));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 14));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 15));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_27 = (_local_27 + 16);
                };
                while (_local_27 < _local_28)
                {
                    _local_30 = (_local_26 ^ li8(_local_27));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_27++;
                };
            };
            _local_26 = (_local_26 ^ 0xFFFFFFFF);
            _arg_5.writeUnsignedInt(_local_26);
            if (!_local_38)
            {
                _arg_4.release();
            };
        }

        public static function _writeIDATChunk(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:DeflateStream, _arg_5:ByteArray):void
        {
            var _local_7:int;
            var _local_11:int;
            var _local_13:uint;
            var _local_20:uint;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            var _local_25:uint;
            var _local_26:int;
            var _local_27:int;
            var _local_28:int;
            var _local_29:int;
            var _local_30:int;
            var _local_31:int;
            var _local_32:int;
            var _local_33:int;
            var _local_34:int;
            var _local_35:int;
            var _local_36:int;
            var _local_37:int;
            var _local_39:* = (null as MemoryRange);
            var _local_6:int = _arg_1.width;
            if (_arg_2 == 0)
            {
                _local_7 = 0;
            }
            else
            {
                _local_7 = (_arg_2 - 1);
            };
            var _local_8:* = (_arg_3 - _arg_2);
            var _local_9:* = (_arg_3 - _local_7);
            PNGEncoder2Impl.region.y = _local_7;
            PNGEncoder2Impl.region.width = _local_6;
            PNGEncoder2Impl.region.height = _local_9;
            var _local_10:* = (_local_6 << 2);
            if (_arg_1.transparent)
            {
                _local_11 = 4;
            }
            else
            {
                _local_11 = 3;
            };
            var _local_12:uint = (((_local_6 * _local_8) * _local_11) + _local_8);
            if (_arg_1.transparent)
            {
                _local_13 = 0;
            }
            else
            {
                _local_13 = 1;
            };
            var _local_14:uint = ((_local_6 * _local_9) * 4);
            var _local_15:Number = Math.max(((((6600 + _arg_4.maxOutputBufferSize(_local_12)) + _local_14) + _local_12) + _local_13), ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
            PNGEncoder2Impl.data.length = _local_15;
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            var _local_16:* = (6600 + _arg_4.maxOutputBufferSize(_local_12));
            var _local_17:int = (_local_16 + _local_14);
            var _local_18:int = _local_17;
            var _local_19:ByteArray = _arg_1.getPixels(PNGEncoder2Impl.region);
            _local_19.position = 0;
            _local_20 = 0;
            _local_19.readBytes(ApplicationDomain.currentDomain.domainMemory, _local_16, _local_20);
            if (_local_7 != _arg_2)
            {
                _local_16 = (_local_16 + (_local_6 * 4));
            };
            if (_arg_1.transparent)
            {
                if (_local_7 == _arg_2)
                {
                    si8(1, _local_18);
                    _local_18 = (_local_18 + 1);
                    if (((_local_6 > (0)) && (_local_8 > 0)))
                    {
                        _local_24 = li32(_local_16);
                        _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                        si32(_local_23, _local_18);
                        _local_21 = (_local_18 + _local_10);
                        _local_18 = (_local_18 + 4);
                        _local_16 = (_local_16 + 4);
                        _local_22 = (_local_18 + ((_local_10 - 1) & 0xFFFFFFC0));
                        while (_local_18 != _local_22)
                        {
                            _local_20 = li32(_local_16);
                            _local_25 = li32(_local_16 - 4);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, _local_18);
                            _local_20 = li32(_local_16 + 4);
                            _local_25 = li32(_local_16);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 4));
                            _local_20 = li32(_local_16 + 8);
                            _local_25 = li32(_local_16 + 4);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 8));
                            _local_20 = li32(_local_16 + 12);
                            _local_25 = li32(_local_16 + 8);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 12));
                            _local_20 = li32(_local_16 + 16);
                            _local_25 = li32(_local_16 + 12);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 16));
                            _local_20 = li32(_local_16 + 20);
                            _local_25 = li32(_local_16 + 16);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 20));
                            _local_20 = li32(_local_16 + 24);
                            _local_25 = li32(_local_16 + 20);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 24));
                            _local_20 = li32(_local_16 + 28);
                            _local_25 = li32(_local_16 + 24);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 28));
                            _local_20 = li32(_local_16 + 32);
                            _local_25 = li32(_local_16 + 28);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 32));
                            _local_20 = li32(_local_16 + 36);
                            _local_25 = li32(_local_16 + 32);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 36));
                            _local_20 = li32(_local_16 + 40);
                            _local_25 = li32(_local_16 + 36);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 40));
                            _local_20 = li32(_local_16 + 44);
                            _local_25 = li32(_local_16 + 40);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 44));
                            _local_20 = li32(_local_16 + 48);
                            _local_25 = li32(_local_16 + 44);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 48));
                            _local_20 = li32(_local_16 + 52);
                            _local_25 = li32(_local_16 + 48);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 52));
                            _local_20 = li32(_local_16 + 56);
                            _local_25 = li32(_local_16 + 52);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 56));
                            _local_20 = li32(_local_16 + 60);
                            _local_25 = li32(_local_16 + 56);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, (_local_18 + 60));
                            _local_18 = (_local_18 + 64);
                            _local_16 = (_local_16 + 64);
                        };
                        while (_local_18 != _local_21)
                        {
                            _local_20 = li32(_local_16);
                            _local_25 = li32(_local_16 - 4);
                            _local_24 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_23 = ((_local_24 >>> 8) | (_local_24 << 24));
                            si32(_local_23, _local_18);
                            _local_18 = (_local_18 + 4);
                            _local_16 = (_local_16 + 4);
                        };
                    };
                };
                _local_23 = 1;
                while (_local_23 < _local_9)
                {
                    _local_24 = _local_23++;
                    si8(4, _local_18);
                    _local_18 = (_local_18 + 1);
                    if (_local_6 > 0)
                    {
                        _local_20 = li32(_local_16);
                        _local_25 = li32(_local_16 - _local_10);
                        _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                        _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                        si32(_local_26, _local_18);
                        _local_21 = (_local_18 + _local_10);
                        _local_18 = (_local_18 + 4);
                        _local_16 = (_local_16 + 4);
                        _local_22 = (_local_18 + ((_local_10 - 1) & 0xFFFFFFC0));
                        while (_local_18 != _local_22)
                        {
                            _local_20 = li32(_local_16);
                            _local_28 = li32(_local_16 - 4);
                            _local_29 = li32(_local_16 - _local_10);
                            _local_30 = li32((_local_16 - 4) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, _local_18);
                            _local_20 = li32(_local_16 + 4);
                            _local_28 = li32(_local_16);
                            _local_29 = li32((_local_16 + 4) - _local_10);
                            _local_30 = li32(_local_16 - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 4));
                            _local_20 = li32(_local_16 + 8);
                            _local_28 = li32(_local_16 + 4);
                            _local_29 = li32((_local_16 + 8) - _local_10);
                            _local_30 = li32((_local_16 + 4) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 8));
                            _local_20 = li32(_local_16 + 12);
                            _local_28 = li32(_local_16 + 8);
                            _local_29 = li32((_local_16 + 12) - _local_10);
                            _local_30 = li32((_local_16 + 8) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 12));
                            _local_20 = li32(_local_16 + 16);
                            _local_28 = li32(_local_16 + 12);
                            _local_29 = li32((_local_16 + 16) - _local_10);
                            _local_30 = li32((_local_16 + 12) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 16));
                            _local_20 = li32(_local_16 + 20);
                            _local_28 = li32(_local_16 + 16);
                            _local_29 = li32((_local_16 + 20) - _local_10);
                            _local_30 = li32((_local_16 + 16) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 20));
                            _local_20 = li32(_local_16 + 24);
                            _local_28 = li32(_local_16 + 20);
                            _local_29 = li32((_local_16 + 24) - _local_10);
                            _local_30 = li32((_local_16 + 20) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 24));
                            _local_20 = li32(_local_16 + 28);
                            _local_28 = li32(_local_16 + 24);
                            _local_29 = li32((_local_16 + 28) - _local_10);
                            _local_30 = li32((_local_16 + 24) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 28));
                            _local_20 = li32(_local_16 + 32);
                            _local_28 = li32(_local_16 + 28);
                            _local_29 = li32((_local_16 + 32) - _local_10);
                            _local_30 = li32((_local_16 + 28) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 32));
                            _local_20 = li32(_local_16 + 36);
                            _local_28 = li32(_local_16 + 32);
                            _local_29 = li32((_local_16 + 36) - _local_10);
                            _local_30 = li32((_local_16 + 32) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 36));
                            _local_20 = li32(_local_16 + 40);
                            _local_28 = li32(_local_16 + 36);
                            _local_29 = li32((_local_16 + 40) - _local_10);
                            _local_30 = li32((_local_16 + 36) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 40));
                            _local_20 = li32(_local_16 + 44);
                            _local_28 = li32(_local_16 + 40);
                            _local_29 = li32((_local_16 + 44) - _local_10);
                            _local_30 = li32((_local_16 + 40) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 44));
                            _local_20 = li32(_local_16 + 48);
                            _local_28 = li32(_local_16 + 44);
                            _local_29 = li32((_local_16 + 48) - _local_10);
                            _local_30 = li32((_local_16 + 44) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 48));
                            _local_20 = li32(_local_16 + 52);
                            _local_28 = li32(_local_16 + 48);
                            _local_29 = li32((_local_16 + 52) - _local_10);
                            _local_30 = li32((_local_16 + 48) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 52));
                            _local_20 = li32(_local_16 + 56);
                            _local_28 = li32(_local_16 + 52);
                            _local_29 = li32((_local_16 + 56) - _local_10);
                            _local_30 = li32((_local_16 + 52) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 56));
                            _local_20 = li32(_local_16 + 60);
                            _local_28 = li32(_local_16 + 56);
                            _local_29 = li32((_local_16 + 60) - _local_10);
                            _local_30 = li32((_local_16 + 56) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, (_local_18 + 60));
                            _local_18 = (_local_18 + 64);
                            _local_16 = (_local_16 + 64);
                        };
                        while (_local_18 != _local_21)
                        {
                            _local_20 = li32(_local_16);
                            _local_28 = li32(_local_16 - 4);
                            _local_29 = li32(_local_16 - _local_10);
                            _local_30 = li32((_local_16 - 4) - _local_10);
                            _local_32 = ((_local_29 & 0xFF) - (_local_30 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = ((_local_28 & 0xFF) - (_local_30 & 0xFF));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_34 = (((_local_28 & 0xFF) + (_local_29 & 0xFF)) - ((_local_30 << 1) & 0x01FE));
                            _local_35 = (_local_34 >> 31);
                            _local_33 = ((_local_34 + _local_35) ^ _local_35);
                            _local_34 = ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF);
                            _local_35 = (((_local_33 - _local_32) >> 31) & 0xFF);
                            _local_36 = ((_local_29 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF00) - (_local_30 & 0xFF00));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF00) + (_local_29 & 0xFF00)) - ((_local_30 << 1) & 0x01FE00));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF00));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF00));
                            _local_36 = ((_local_29 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((_local_28 & 0xFF0000) - (_local_30 & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 & 0xFF0000) + (_local_29 & 0xFF0000)) - ((_local_30 << 1) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF0000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF0000));
                            _local_36 = (((_local_29 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_31 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = (((_local_28 >> 8) & 0xFF0000) - ((_local_30 >> 8) & 0xFF0000));
                            _local_37 = (_local_36 >> 31);
                            _local_32 = ((_local_36 + _local_37) ^ _local_37);
                            _local_36 = ((((_local_28 >> 8) & 0xFF0000) + ((_local_29 >> 8) & 0xFF0000)) - ((_local_30 >> 7) & 0x01FE0000));
                            _local_37 = (_local_36 >> 31);
                            _local_33 = ((_local_36 + _local_37) ^ _local_37);
                            _local_34 = (_local_34 | ((((_local_32 - _local_31) | (_local_33 - _local_31)) >> 31) & 0xFF000000));
                            _local_35 = (_local_35 | (((_local_33 - _local_32) >> 31) & 0xFF000000));
                            _local_25 = (((_local_28 & (~(_local_34))) | ((_local_29 & _local_34) & (~(_local_35)))) | ((_local_30 & _local_34) & _local_35));
                            _local_27 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            _local_26 = ((_local_27 >>> 8) | (_local_27 << 24));
                            si32(_local_26, _local_18);
                            _local_18 = (_local_18 + 4);
                            _local_16 = (_local_16 + 4);
                        };
                    };
                };
            }
            else
            {
                if (_local_7 == _arg_2)
                {
                    si8(1, _local_18);
                    _local_18 = (_local_18 + 1);
                    if (((_local_6 > (0)) && (_local_8 > 0)))
                    {
                        _local_23 = li16(_local_16 + 1);
                        si16(_local_23, _local_18);
                        _local_23 = li8(_local_16 + 3);
                        si8(_local_23, (_local_18 + 2));
                        _local_21 = (_local_18 + (_local_6 * 3));
                        _local_18 = (_local_18 + 3);
                        _local_16 = (_local_16 + 4);
                        _local_22 = (++_local_16 + (((_local_6 * 3) - 1) & 0xFFFFFFC0));
                        while (_local_16 != _local_22)
                        {
                            _local_20 = li32(_local_16);
                            _local_25 = li32(_local_16 - 4);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, _local_18);
                            _local_20 = li32(_local_16 + 4);
                            _local_25 = li32(_local_16);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 3));
                            _local_20 = li32(_local_16 + 8);
                            _local_25 = li32(_local_16 + 4);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 6));
                            _local_20 = li32(_local_16 + 12);
                            _local_25 = li32(_local_16 + 8);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 9));
                            _local_20 = li32(_local_16 + 16);
                            _local_25 = li32(_local_16 + 12);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 12));
                            _local_20 = li32(_local_16 + 20);
                            _local_25 = li32(_local_16 + 16);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 15));
                            _local_20 = li32(_local_16 + 24);
                            _local_25 = li32(_local_16 + 20);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 18));
                            _local_20 = li32(_local_16 + 28);
                            _local_25 = li32(_local_16 + 24);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 21));
                            _local_20 = li32(_local_16 + 32);
                            _local_25 = li32(_local_16 + 28);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 24));
                            _local_20 = li32(_local_16 + 36);
                            _local_25 = li32(_local_16 + 32);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 27));
                            _local_20 = li32(_local_16 + 40);
                            _local_25 = li32(_local_16 + 36);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 30));
                            _local_20 = li32(_local_16 + 44);
                            _local_25 = li32(_local_16 + 40);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 33));
                            _local_20 = li32(_local_16 + 48);
                            _local_25 = li32(_local_16 + 44);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 36));
                            _local_20 = li32(_local_16 + 52);
                            _local_25 = li32(_local_16 + 48);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 39));
                            _local_20 = li32(_local_16 + 56);
                            _local_25 = li32(_local_16 + 52);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 42));
                            _local_20 = li32(_local_16 + 60);
                            _local_25 = li32(_local_16 + 56);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, (_local_18 + 45));
                            _local_18 = (_local_18 + 48);
                            _local_16 = (_local_16 + 64);
                        };
                        while (_local_18 != _local_21)
                        {
                            _local_20 = li32(_local_16);
                            _local_25 = li32(_local_16 - 4);
                            _local_23 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_23, _local_18);
                            _local_18 = (_local_18 + 3);
                            _local_16 = (_local_16 + 4);
                        };
                        _local_16--;
                    };
                };
                _local_23 = 1;
                while (_local_23 < _local_9)
                {
                    _local_24 = _local_23++;
                    si8(4, _local_18);
                    _local_18 = (_local_18 + 1);
                    if (_local_6 > 0)
                    {
                        _local_20 = li32(_local_16 + 1);
                        _local_25 = li32((_local_16 + 1) - _local_10);
                        _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                        si32(_local_26, _local_18);
                        _local_21 = (_local_18 + (_local_6 * 3));
                        _local_18 = (_local_18 + 3);
                        _local_16 = (_local_16 + 4);
                        _local_22 = (++_local_16 + (((_local_6 * 3) - 1) & 0xFFFFFFC0));
                        while (_local_16 != _local_22)
                        {
                            _local_20 = li32(_local_16);
                            _local_27 = li32(_local_16 - 4);
                            _local_28 = li32(_local_16 - _local_10);
                            _local_29 = li32((_local_16 - 4) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, _local_18);
                            _local_20 = li32(_local_16 + 4);
                            _local_27 = li32(_local_16);
                            _local_28 = li32((_local_16 + 4) - _local_10);
                            _local_29 = li32(_local_16 - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 3));
                            _local_20 = li32(_local_16 + 8);
                            _local_27 = li32(_local_16 + 4);
                            _local_28 = li32((_local_16 + 8) - _local_10);
                            _local_29 = li32((_local_16 + 4) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 6));
                            _local_20 = li32(_local_16 + 12);
                            _local_27 = li32(_local_16 + 8);
                            _local_28 = li32((_local_16 + 12) - _local_10);
                            _local_29 = li32((_local_16 + 8) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 9));
                            _local_20 = li32(_local_16 + 16);
                            _local_27 = li32(_local_16 + 12);
                            _local_28 = li32((_local_16 + 16) - _local_10);
                            _local_29 = li32((_local_16 + 12) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 12));
                            _local_20 = li32(_local_16 + 20);
                            _local_27 = li32(_local_16 + 16);
                            _local_28 = li32((_local_16 + 20) - _local_10);
                            _local_29 = li32((_local_16 + 16) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 15));
                            _local_20 = li32(_local_16 + 24);
                            _local_27 = li32(_local_16 + 20);
                            _local_28 = li32((_local_16 + 24) - _local_10);
                            _local_29 = li32((_local_16 + 20) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 18));
                            _local_20 = li32(_local_16 + 28);
                            _local_27 = li32(_local_16 + 24);
                            _local_28 = li32((_local_16 + 28) - _local_10);
                            _local_29 = li32((_local_16 + 24) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 21));
                            _local_20 = li32(_local_16 + 32);
                            _local_27 = li32(_local_16 + 28);
                            _local_28 = li32((_local_16 + 32) - _local_10);
                            _local_29 = li32((_local_16 + 28) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 24));
                            _local_20 = li32(_local_16 + 36);
                            _local_27 = li32(_local_16 + 32);
                            _local_28 = li32((_local_16 + 36) - _local_10);
                            _local_29 = li32((_local_16 + 32) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 27));
                            _local_20 = li32(_local_16 + 40);
                            _local_27 = li32(_local_16 + 36);
                            _local_28 = li32((_local_16 + 40) - _local_10);
                            _local_29 = li32((_local_16 + 36) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 30));
                            _local_20 = li32(_local_16 + 44);
                            _local_27 = li32(_local_16 + 40);
                            _local_28 = li32((_local_16 + 44) - _local_10);
                            _local_29 = li32((_local_16 + 40) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 33));
                            _local_20 = li32(_local_16 + 48);
                            _local_27 = li32(_local_16 + 44);
                            _local_28 = li32((_local_16 + 48) - _local_10);
                            _local_29 = li32((_local_16 + 44) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 36));
                            _local_20 = li32(_local_16 + 52);
                            _local_27 = li32(_local_16 + 48);
                            _local_28 = li32((_local_16 + 52) - _local_10);
                            _local_29 = li32((_local_16 + 48) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 39));
                            _local_20 = li32(_local_16 + 56);
                            _local_27 = li32(_local_16 + 52);
                            _local_28 = li32((_local_16 + 56) - _local_10);
                            _local_29 = li32((_local_16 + 52) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 42));
                            _local_20 = li32(_local_16 + 60);
                            _local_27 = li32(_local_16 + 56);
                            _local_28 = li32((_local_16 + 60) - _local_10);
                            _local_29 = li32((_local_16 + 56) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, (_local_18 + 45));
                            _local_18 = (_local_18 + 48);
                            _local_16 = (_local_16 + 64);
                        };
                        while (_local_18 != _local_21)
                        {
                            _local_20 = li32(_local_16);
                            _local_27 = li32(_local_16 - 4);
                            _local_28 = li32(_local_16 - _local_10);
                            _local_29 = li32((_local_16 - 4) - _local_10);
                            _local_31 = ((_local_28 & 0xFF) - (_local_29 & 0xFF));
                            _local_32 = (_local_31 >> 31);
                            _local_30 = ((_local_31 + _local_32) ^ _local_32);
                            _local_32 = ((_local_27 & 0xFF) - (_local_29 & 0xFF));
                            _local_33 = (_local_32 >> 31);
                            _local_31 = ((_local_32 + _local_33) ^ _local_33);
                            _local_33 = (((_local_27 & 0xFF) + (_local_28 & 0xFF)) - ((_local_29 << 1) & 0x01FE));
                            _local_34 = (_local_33 >> 31);
                            _local_32 = ((_local_33 + _local_34) ^ _local_34);
                            _local_33 = ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF);
                            _local_34 = (((_local_32 - _local_31) >> 31) & 0xFF);
                            _local_35 = ((_local_28 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF00) - (_local_29 & 0xFF00));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF00) + (_local_28 & 0xFF00)) - ((_local_29 << 1) & 0x01FE00));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF00));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF00));
                            _local_35 = ((_local_28 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_30 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = ((_local_27 & 0xFF0000) - (_local_29 & 0xFF0000));
                            _local_36 = (_local_35 >> 31);
                            _local_31 = ((_local_35 + _local_36) ^ _local_36);
                            _local_35 = (((_local_27 & 0xFF0000) + (_local_28 & 0xFF0000)) - ((_local_29 << 1) & 0x01FE0000));
                            _local_36 = (_local_35 >> 31);
                            _local_32 = ((_local_35 + _local_36) ^ _local_36);
                            _local_33 = (_local_33 | ((((_local_31 - _local_30) | (_local_32 - _local_30)) >> 31) & 0xFF0000));
                            _local_34 = (_local_34 | (((_local_32 - _local_31) >> 31) & 0xFF0000));
                            _local_25 = (((_local_27 & (~(_local_33))) | ((_local_28 & _local_33) & (~(_local_34)))) | ((_local_29 & _local_33) & _local_34));
                            _local_26 = (((((_local_20 & 0xFF00FF00) | 0x010000) - (_local_25 & 0xFF00FF00)) & 0xFF00FF00) | ((((_local_20 & 0xFF00FF) | 0x01000100) - (_local_25 & 0xFF00FF)) & 0xFF00FF));
                            si32(_local_26, _local_18);
                            _local_18 = (_local_18 + 3);
                            _local_16 = (_local_16 + 4);
                        };
                        _local_16--;
                    };
                };
            };
            _arg_4.fastWrite(_local_17, (_local_17 + _local_12));
            var _local_38:* = (_arg_3 == _arg_1.height);
            if (_local_38)
            {
                _local_39 = _arg_4.fastFinalize();
            }
            else
            {
                _local_39 = _arg_4.peek();
            };
            _local_23 = (_local_39.end - _local_39.offset);
            _local_24 = _local_23;
            _arg_5.writeUnsignedInt(_local_24);
            _arg_5.writeUnsignedInt(1229209940);
            if (_local_24 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_arg_5, _arg_5.position, _local_23);
                _arg_5.position = (_arg_5.position + _local_24);
            };
            _local_26 = -1;
            _local_26 = (li32(((_local_26 ^ 0x49) & 0xFF) << 2) ^ (_local_26 >>> 8));
            _local_26 = (li32(((_local_26 ^ 0x44) & 0xFF) << 2) ^ (_local_26 >>> 8));
            _local_26 = (li32(((_local_26 ^ 0x41) & 0xFF) << 2) ^ (_local_26 >>> 8));
            _local_26 = (li32(((_local_26 ^ 0x54) & 0xFF) << 2) ^ (_local_26 >>> 8));
            if (_local_24 != 0)
            {
                _local_27 = 6600;
                _local_28 = (6600 + _local_24);
                _local_29 = (6600 + (_local_24 & 0xFFFFFFF0));
                while (_local_27 < _local_29)
                {
                    _local_30 = (_local_26 ^ li8(_local_27));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 1));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 2));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 3));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 4));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 5));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 6));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 7));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 8));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 9));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 10));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 11));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 12));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 13));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 14));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_30 = (_local_26 ^ li8(_local_27 + 15));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_27 = (_local_27 + 16);
                };
                while (_local_27 < _local_28)
                {
                    _local_30 = (_local_26 ^ li8(_local_27));
                    _local_26 = (li32((_local_30 & 0xFF) << 2) ^ (_local_26 >>> 8));
                    _local_27++;
                };
            };
            _local_26 = (_local_26 ^ 0xFFFFFFFF);
            _arg_5.writeUnsignedInt(_local_26);
            if (!_local_38)
            {
                _arg_4.release();
            };
        }

        public static function rotr8(_arg_1:int):int
        {
            return ((_arg_1 >>> 8) | (_arg_1 << 24));
        }

        public static function byteSub4(_arg_1:uint, _arg_2:uint):int
        {
            return (((((_arg_1 & 0xFF00FF00) | 0x010000) - (_arg_2 & 0xFF00FF00)) & 0xFF00FF00) | ((((_arg_1 & 0xFF00FF) | 0x01000100) - (_arg_2 & 0xFF00FF)) & 0xFF00FF));
        }

        public static function paethPredictor4(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_5:* = ((_arg_2 & 0xFF) - (_arg_3 & 0xFF));
            var _local_6:* = (_local_5 >> 31);
            var _local_4:* = ((_local_5 + _local_6) ^ _local_6);
            _local_6 = ((_arg_1 & 0xFF) - (_arg_3 & 0xFF));
            var _local_7:* = (_local_6 >> 31);
            _local_5 = ((_local_6 + _local_7) ^ _local_7);
            _local_7 = (((_arg_1 & 0xFF) + (_arg_2 & 0xFF)) - ((_arg_3 << 1) & 0x01FE));
            var _local_8:* = (_local_7 >> 31);
            _local_6 = ((_local_7 + _local_8) ^ _local_8);
            _local_7 = ((((_local_5 - _local_4) | (_local_6 - _local_4)) >> 31) & 0xFF);
            _local_8 = (((_local_6 - _local_5) >> 31) & 0xFF);
            var _local_9:* = ((_arg_2 & 0xFF00) - (_arg_3 & 0xFF00));
            var _local_10:* = (_local_9 >> 31);
            _local_4 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = ((_arg_1 & 0xFF00) - (_arg_3 & 0xFF00));
            _local_10 = (_local_9 >> 31);
            _local_5 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = (((_arg_1 & 0xFF00) + (_arg_2 & 0xFF00)) - ((_arg_3 << 1) & 0x01FE00));
            _local_10 = (_local_9 >> 31);
            _local_6 = ((_local_9 + _local_10) ^ _local_10);
            _local_7 = (_local_7 | ((((_local_5 - _local_4) | (_local_6 - _local_4)) >> 31) & 0xFF00));
            _local_8 = (_local_8 | (((_local_6 - _local_5) >> 31) & 0xFF00));
            _local_9 = ((_arg_2 & 0xFF0000) - (_arg_3 & 0xFF0000));
            _local_10 = (_local_9 >> 31);
            _local_4 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = ((_arg_1 & 0xFF0000) - (_arg_3 & 0xFF0000));
            _local_10 = (_local_9 >> 31);
            _local_5 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = (((_arg_1 & 0xFF0000) + (_arg_2 & 0xFF0000)) - ((_arg_3 << 1) & 0x01FE0000));
            _local_10 = (_local_9 >> 31);
            _local_6 = ((_local_9 + _local_10) ^ _local_10);
            _local_7 = (_local_7 | ((((_local_5 - _local_4) | (_local_6 - _local_4)) >> 31) & 0xFF0000));
            _local_8 = (_local_8 | (((_local_6 - _local_5) >> 31) & 0xFF0000));
            _local_9 = (((_arg_2 >> 8) & 0xFF0000) - ((_arg_3 >> 8) & 0xFF0000));
            _local_10 = (_local_9 >> 31);
            _local_4 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = (((_arg_1 >> 8) & 0xFF0000) - ((_arg_3 >> 8) & 0xFF0000));
            _local_10 = (_local_9 >> 31);
            _local_5 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = ((((_arg_1 >> 8) & 0xFF0000) + ((_arg_2 >> 8) & 0xFF0000)) - ((_arg_3 >> 7) & 0x01FE0000));
            _local_10 = (_local_9 >> 31);
            _local_6 = ((_local_9 + _local_10) ^ _local_10);
            _local_7 = (_local_7 | ((((_local_5 - _local_4) | (_local_6 - _local_4)) >> 31) & 0xFF000000));
            _local_8 = (_local_8 | (((_local_6 - _local_5) >> 31) & 0xFF000000));
            return (((_arg_1 & (~(_local_7))) | ((_arg_2 & _local_7) & (~(_local_8)))) | ((_arg_3 & _local_7) & _local_8));
        }

        public static function paethPredictor3Lo(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_5:* = ((_arg_2 & 0xFF) - (_arg_3 & 0xFF));
            var _local_6:* = (_local_5 >> 31);
            var _local_4:* = ((_local_5 + _local_6) ^ _local_6);
            _local_6 = ((_arg_1 & 0xFF) - (_arg_3 & 0xFF));
            var _local_7:* = (_local_6 >> 31);
            _local_5 = ((_local_6 + _local_7) ^ _local_7);
            _local_7 = (((_arg_1 & 0xFF) + (_arg_2 & 0xFF)) - ((_arg_3 << 1) & 0x01FE));
            var _local_8:* = (_local_7 >> 31);
            _local_6 = ((_local_7 + _local_8) ^ _local_8);
            _local_7 = ((((_local_5 - _local_4) | (_local_6 - _local_4)) >> 31) & 0xFF);
            _local_8 = (((_local_6 - _local_5) >> 31) & 0xFF);
            var _local_9:* = ((_arg_2 & 0xFF00) - (_arg_3 & 0xFF00));
            var _local_10:* = (_local_9 >> 31);
            _local_4 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = ((_arg_1 & 0xFF00) - (_arg_3 & 0xFF00));
            _local_10 = (_local_9 >> 31);
            _local_5 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = (((_arg_1 & 0xFF00) + (_arg_2 & 0xFF00)) - ((_arg_3 << 1) & 0x01FE00));
            _local_10 = (_local_9 >> 31);
            _local_6 = ((_local_9 + _local_10) ^ _local_10);
            _local_7 = (_local_7 | ((((_local_5 - _local_4) | (_local_6 - _local_4)) >> 31) & 0xFF00));
            _local_8 = (_local_8 | (((_local_6 - _local_5) >> 31) & 0xFF00));
            _local_9 = ((_arg_2 & 0xFF0000) - (_arg_3 & 0xFF0000));
            _local_10 = (_local_9 >> 31);
            _local_4 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = ((_arg_1 & 0xFF0000) - (_arg_3 & 0xFF0000));
            _local_10 = (_local_9 >> 31);
            _local_5 = ((_local_9 + _local_10) ^ _local_10);
            _local_9 = (((_arg_1 & 0xFF0000) + (_arg_2 & 0xFF0000)) - ((_arg_3 << 1) & 0x01FE0000));
            _local_10 = (_local_9 >> 31);
            _local_6 = ((_local_9 + _local_10) ^ _local_10);
            _local_7 = (_local_7 | ((((_local_5 - _local_4) | (_local_6 - _local_4)) >> 31) & 0xFF0000));
            _local_8 = (_local_8 | (((_local_6 - _local_5) >> 31) & 0xFF0000));
            return (((_arg_1 & (~(_local_7))) | ((_arg_2 & _local_7) & (~(_local_8)))) | ((_arg_3 & _local_7) & _local_8));
        }

        public static function abs(_arg_1:int):int
        {
            var _local_2:* = (_arg_1 >> 31);
            return ((_arg_1 + _local_2) ^ _local_2);
        }

        public static function writeIENDChunk(_arg_1:ByteArray):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_2:int;
            _arg_1.writeUnsignedInt(_local_2);
            _arg_1.writeUnsignedInt(1229278788);
            if (_local_2 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_arg_1, _arg_1.position, 0);
                _arg_1.position = (_arg_1.position + _local_2);
            };
            var _local_3:int = -1;
            _local_3 = (li32(((_local_3 ^ 0x49) & 0xFF) << 2) ^ (_local_3 >>> 8));
            _local_3 = (li32(((_local_3 ^ 0x45) & 0xFF) << 2) ^ (_local_3 >>> 8));
            _local_3 = (li32(((_local_3 ^ 0x4E) & 0xFF) << 2) ^ (_local_3 >>> 8));
            _local_3 = (li32(((_local_3 ^ 0x44) & 0xFF) << 2) ^ (_local_3 >>> 8));
            if (_local_2 != 0)
            {
                _local_4 = 6600;
                _local_5 = (6600 + _local_2);
                _local_6 = (6600 + (_local_2 & 0xFFFFFFF0));
                while (_local_4 < _local_6)
                {
                    _local_7 = (_local_3 ^ li8(_local_4));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 1));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 2));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 3));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 4));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 5));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 6));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 7));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 8));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 9));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 10));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 11));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 12));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 13));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 14));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_7 = (_local_3 ^ li8(_local_4 + 15));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_4 = (_local_4 + 16);
                };
                while (_local_4 < _local_5)
                {
                    _local_7 = (_local_3 ^ li8(_local_4));
                    _local_3 = (li32((_local_7 & 0xFF) << 2) ^ (_local_3 >>> 8));
                    _local_4++;
                };
            };
            _local_3 = (_local_3 ^ 0xFFFFFFFF);
            _arg_1.writeUnsignedInt(_local_3);
        }

        public static function writeChunk(_arg_1:ByteArray, _arg_2:int, _arg_3:int):void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_4:int = _arg_3;
            _arg_1.writeUnsignedInt(_local_4);
            _arg_1.writeUnsignedInt(_arg_2);
            if (_local_4 != 0)
            {
                PNGEncoder2Impl.data.position = 6600;
                PNGEncoder2Impl.data.readBytes(_arg_1, _arg_1.position, _arg_3);
                _arg_1.position = (_arg_1.position + _local_4);
            };
            var _local_5:int = -1;
            _local_5 = (li32(((_local_5 ^ (_arg_2 >>> 24)) & 0xFF) << 2) ^ (_local_5 >>> 8));
            _local_5 = (li32(((_local_5 ^ ((_arg_2 >>> 16) & 0xFF)) & 0xFF) << 2) ^ (_local_5 >>> 8));
            _local_5 = (li32(((_local_5 ^ ((_arg_2 >>> 8) & 0xFF)) & 0xFF) << 2) ^ (_local_5 >>> 8));
            _local_5 = (li32(((_local_5 ^ (_arg_2 & 0xFF)) & 0xFF) << 2) ^ (_local_5 >>> 8));
            if (_local_4 != 0)
            {
                _local_6 = 6600;
                _local_7 = (6600 + _local_4);
                _local_8 = (6600 + (_local_4 & 0xFFFFFFF0));
                while (_local_6 < _local_8)
                {
                    _local_9 = (_local_5 ^ li8(_local_6));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 1));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 2));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 3));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 4));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 5));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 6));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 7));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 8));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 9));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 10));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 11));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 12));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 13));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 14));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_9 = (_local_5 ^ li8(_local_6 + 15));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_6 = (_local_6 + 16);
                };
                while (_local_6 < _local_7)
                {
                    _local_9 = (_local_5 ^ li8(_local_6));
                    _local_5 = (li32((_local_9 & 0xFF) << 2) ^ (_local_5 >>> 8));
                    _local_6++;
                };
            };
            _local_5 = (_local_5 ^ 0xFFFFFFFF);
            _arg_1.writeUnsignedInt(_local_5);
        }

        public static function initialize():void
        {
            var _local_1:Number;
            var _local_2:uint;
            var _local_3:int;
            var _local_4:int;
            if (!PNGEncoder2Impl.crcComputed)
            {
                PNGEncoder2Impl.region = new Rectangle(0, 0, 1, 1);
                PNGEncoder2Impl.sprite = new Sprite();
                PNGEncoder2Impl.data = new ByteArray();
                _local_1 = Math.max(6600, ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
                PNGEncoder2Impl.data.length = _local_1;
            };
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            if (!PNGEncoder2Impl.crcComputed)
            {
                _local_3 = 0;
                while (_local_3 < 0x0100)
                {
                    _local_4 = _local_3++;
                    _local_2 = _local_4;
                    if ((_local_2 & 0x01) == 1)
                    {
                        _local_2 = (0xEDB88320 ^ (_local_2 >>> 1));
                    }
                    else
                    {
                        _local_2 = (_local_2 >>> 1);
                    };
                    if ((_local_2 & 0x01) == 1)
                    {
                        _local_2 = (0xEDB88320 ^ (_local_2 >>> 1));
                    }
                    else
                    {
                        _local_2 = (_local_2 >>> 1);
                    };
                    if ((_local_2 & 0x01) == 1)
                    {
                        _local_2 = (0xEDB88320 ^ (_local_2 >>> 1));
                    }
                    else
                    {
                        _local_2 = (_local_2 >>> 1);
                    };
                    if ((_local_2 & 0x01) == 1)
                    {
                        _local_2 = (0xEDB88320 ^ (_local_2 >>> 1));
                    }
                    else
                    {
                        _local_2 = (_local_2 >>> 1);
                    };
                    if ((_local_2 & 0x01) == 1)
                    {
                        _local_2 = (0xEDB88320 ^ (_local_2 >>> 1));
                    }
                    else
                    {
                        _local_2 = (_local_2 >>> 1);
                    };
                    if ((_local_2 & 0x01) == 1)
                    {
                        _local_2 = (0xEDB88320 ^ (_local_2 >>> 1));
                    }
                    else
                    {
                        _local_2 = (_local_2 >>> 1);
                    };
                    if ((_local_2 & 0x01) == 1)
                    {
                        _local_2 = (0xEDB88320 ^ (_local_2 >>> 1));
                    }
                    else
                    {
                        _local_2 = (_local_2 >>> 1);
                    };
                    if ((_local_2 & 0x01) == 1)
                    {
                        _local_2 = (0xEDB88320 ^ (_local_2 >>> 1));
                    }
                    else
                    {
                        _local_2 = (_local_2 >>> 1);
                    };
                    si32(_local_2, (_local_4 << 2));
                };
                PNGEncoder2Impl.crcComputed = true;
            };
        }

        public static function crcTable(_arg_1:int):int
        {
            return (li32((_arg_1 & 0xFF) << 2));
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


        public function updateUpdatesPerFrame(_arg_1:int):void
        {
            updatesPerFrame[updatesPerFrameIndex] = _arg_1;
            updatesPerFrameIndex = ((updatesPerFrameIndex + 1) & 0x03);
        }

        public function updateStep():void
        {
            var _local_3:int;
            var _local_4:* = (null as Vector.<int>);
            var _local_5:int;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:* = (null as Vector.<Number>);
            var _local_10:Number;
            var _local_1:Number = 0;
            var _local_2:int;
            _local_3 = 0;
            _local_4 = msPerFrame;
            while (_local_3 < _local_4.length)
            {
                _local_5 = _local_4[_local_3];
                _local_3++;
                if (_local_5 > 0)
                {
                    _local_1 = (_local_1 + _local_5);
                    _local_2++;
                };
            };
            if (_local_2 != 0)
            {
                _local_1 = (_local_1 / _local_2);
                _local_6 = (1000 / targetFPS);
                if (_local_1 > (_local_6 * 1.15))
                {
                    _local_6 = (_local_6 - (_local_1 - _local_6));
                };
                _local_7 = 0;
                _local_2 = 0;
                _local_3 = 0;
                _local_4 = updatesPerFrame;
                while (_local_3 < _local_4.length)
                {
                    _local_5 = _local_4[_local_3];
                    _local_3++;
                    if (_local_5 > 0)
                    {
                        _local_7 = (_local_7 + _local_5);
                        _local_2++;
                    };
                };
                if (_local_2 != 0)
                {
                    _local_7 = (_local_7 / _local_2);
                    _local_8 = 0;
                    _local_2 = 0;
                    _local_3 = 0;
                    _local_9 = msPerLine;
                    while (_local_3 < _local_9.length)
                    {
                        _local_10 = _local_9[_local_3];
                        _local_3++;
                        if (_local_10 > 0)
                        {
                            _local_8 = (_local_8 + _local_10);
                            _local_2++;
                        };
                    };
                    if (_local_2 != 0)
                    {
                        _local_8 = (_local_8 / _local_2);
                        step = int(Math.ceil(Math.max(((_local_6 / _local_8) / _local_7), (0x5000 / img.width))));
                    }
                    else
                    {
                        step = int(Math.ceil((0x5000 / img.width)));
                    };
                }
                else
                {
                    step = int(Math.ceil((0x5000 / img.width)));
                };
            }
            else
            {
                step = int(Math.ceil((0x5000 / img.width)));
            };
        }

        public function updateMsPerLine(_arg_1:int, _arg_2:int):void
        {
            if (_arg_2 != 0)
            {
                if (_arg_1 <= 0)
                {
                    _arg_1 = 5;
                };
                msPerLine[msPerLineIndex] = ((_arg_1 * 1) / _arg_2);
                msPerLineIndex = ((msPerLineIndex + 1) & 0x03);
            };
        }

        public function updateMsPerFrame(_arg_1:int):void
        {
            msPerFrame[msPerFrameIndex] = _arg_1;
            msPerFrameIndex = ((msPerFrameIndex + 1) & 0x03);
        }

        public function updateFrameInfo():void
        {
            var _local_1:int;
            if (!done)
            {
                frameCount = (frameCount + 1);
                _local_1 = getTimer();
                msPerFrame[msPerFrameIndex] = (_local_1 - lastFrameStart);
                msPerFrameIndex = ((msPerFrameIndex + 1) & 0x03);
                lastFrameStart = _local_1;
                updatesPerFrame[updatesPerFrameIndex] = updates;
                updatesPerFrameIndex = ((updatesPerFrameIndex + 1) & 0x03);
                updates = 0;
            };
        }

        public function update():void
        {
            var _local_1:int;
            var _local_2:* = (null as ByteArray);
            var _local_3:* = (null as ProgressEvent);
            var _local_4:* = (null as Event);
            var _local_5:int;
            var _local_6:int;
            var _local_7:* = (null as Event);
            var _local_8:* = (null as ByteArray);
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:Number;
            var _local_16:int;
            var _local_17:int;
            var _local_18:* = (null as Vector.<int>);
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:Number;
            var _local_22:* = (null as Vector.<Number>);
            var _local_23:Number;
            var _local_24:* = (null as PNGEncoder2Impl);
            if (!done)
            {
                _local_1 = getTimer();
                updates = (updates + 1);
                _local_2 = ApplicationDomain.currentDomain.domainMemory;
                ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
                _local_3 = null;
                _local_4 = null;
                if (img.transparent)
                {
                    _local_5 = 4;
                }
                else
                {
                    _local_5 = 3;
                };
                _local_6 = ((_local_5 * img.width) * img.height);
                if (currentY >= img.height)
                {
                    _local_3 = new ProgressEvent(ProgressEvent.PROGRESS, false, false, _local_6, _local_6);
                    _local_7 = null;
                    if (currentY >= img.height)
                    {
                        done = true;
                        PNGEncoder2Impl.sprite.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                        _local_8 = png;
                        _local_9 = 0;
                        _local_8.writeUnsignedInt(_local_9);
                        _local_8.writeUnsignedInt(1229278788);
                        if (_local_9 != 0)
                        {
                            PNGEncoder2Impl.data.position = 6600;
                            PNGEncoder2Impl.data.readBytes(_local_8, _local_8.position, 0);
                            _local_8.position = (_local_8.position + _local_9);
                        };
                        _local_10 = -1;
                        _local_10 = (li32(((_local_10 ^ 0x49) & 0xFF) << 2) ^ (_local_10 >>> 8));
                        _local_10 = (li32(((_local_10 ^ 0x45) & 0xFF) << 2) ^ (_local_10 >>> 8));
                        _local_10 = (li32(((_local_10 ^ 0x4E) & 0xFF) << 2) ^ (_local_10 >>> 8));
                        _local_10 = (li32(((_local_10 ^ 0x44) & 0xFF) << 2) ^ (_local_10 >>> 8));
                        if (_local_9 != 0)
                        {
                            _local_11 = 6600;
                            _local_12 = (6600 + _local_9);
                            _local_13 = (6600 + (_local_9 & 0xFFFFFFF0));
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
                        _local_8.writeUnsignedInt(_local_10);
                        PNGEncoder2Impl.encoding = false;
                        _local_8.position = 0;
                        _local_7 = new Event(Event.COMPLETE);
                    };
                    _local_4 = _local_7;
                }
                else
                {
                    _local_15 = Math.min((currentY + step), img.height);
                    _local_9 = _local_15;
                    PNGEncoder2Impl.writeIDATChunk(img, currentY, _local_9, deflateStream, png);
                    currentY = _local_9;
                    _local_10 = ((_local_5 * img.width) * currentY);
                    _local_3 = new ProgressEvent(ProgressEvent.PROGRESS, false, false, _local_10, _local_6);
                    _local_7 = null;
                    if (currentY >= img.height)
                    {
                        done = true;
                        PNGEncoder2Impl.sprite.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                        _local_8 = png;
                        _local_11 = 0;
                        _local_8.writeUnsignedInt(_local_11);
                        _local_8.writeUnsignedInt(1229278788);
                        if (_local_11 != 0)
                        {
                            PNGEncoder2Impl.data.position = 6600;
                            PNGEncoder2Impl.data.readBytes(_local_8, _local_8.position, 0);
                            _local_8.position = (_local_8.position + _local_11);
                        };
                        _local_12 = -1;
                        _local_12 = (li32(((_local_12 ^ 0x49) & 0xFF) << 2) ^ (_local_12 >>> 8));
                        _local_12 = (li32(((_local_12 ^ 0x45) & 0xFF) << 2) ^ (_local_12 >>> 8));
                        _local_12 = (li32(((_local_12 ^ 0x4E) & 0xFF) << 2) ^ (_local_12 >>> 8));
                        _local_12 = (li32(((_local_12 ^ 0x44) & 0xFF) << 2) ^ (_local_12 >>> 8));
                        if (_local_11 != 0)
                        {
                            _local_13 = 6600;
                            _local_14 = (6600 + _local_11);
                            _local_16 = (6600 + (_local_11 & 0xFFFFFFF0));
                            while (_local_13 < _local_16)
                            {
                                _local_17 = (_local_12 ^ li8(_local_13));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 1));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 2));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 3));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 4));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 5));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 6));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 7));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 8));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 9));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 10));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 11));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 12));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 13));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 14));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_17 = (_local_12 ^ li8(_local_13 + 15));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_13 = (_local_13 + 16);
                            };
                            while (_local_13 < _local_14)
                            {
                                _local_17 = (_local_12 ^ li8(_local_13));
                                _local_12 = (li32((_local_17 & 0xFF) << 2) ^ (_local_12 >>> 8));
                                _local_13++;
                            };
                        };
                        _local_12 = (_local_12 ^ 0xFFFFFFFF);
                        _local_8.writeUnsignedInt(_local_12);
                        PNGEncoder2Impl.encoding = false;
                        _local_8.position = 0;
                        _local_7 = new Event(Event.COMPLETE);
                    };
                    _local_4 = _local_7;
                    _local_11 = (getTimer() - _local_1);
                    _local_12 = step;
                    if (_local_12 != 0)
                    {
                        if (_local_11 <= 0)
                        {
                            _local_11 = 5;
                        };
                        msPerLine[msPerLineIndex] = ((_local_11 * 1) / _local_12);
                        msPerLineIndex = ((msPerLineIndex + 1) & 0x03);
                    };
                    _local_15 = 0;
                    _local_11 = 0;
                    _local_12 = 0;
                    _local_18 = msPerFrame;
                    while (_local_12 < _local_18.length)
                    {
                        _local_13 = _local_18[_local_12];
                        _local_12++;
                        if (_local_13 > 0)
                        {
                            _local_15 = (_local_15 + _local_13);
                            _local_11++;
                        };
                    };
                    if (_local_11 != 0)
                    {
                        _local_15 = (_local_15 / _local_11);
                        _local_19 = (1000 / targetFPS);
                        if (_local_15 > (_local_19 * 1.15))
                        {
                            _local_19 = (_local_19 - (_local_15 - _local_19));
                        };
                        _local_20 = 0;
                        _local_11 = 0;
                        _local_12 = 0;
                        _local_18 = updatesPerFrame;
                        while (_local_12 < _local_18.length)
                        {
                            _local_13 = _local_18[_local_12];
                            _local_12++;
                            if (_local_13 > 0)
                            {
                                _local_20 = (_local_20 + _local_13);
                                _local_11++;
                            };
                        };
                        if (_local_11 != 0)
                        {
                            _local_20 = (_local_20 / _local_11);
                            _local_21 = 0;
                            _local_11 = 0;
                            _local_12 = 0;
                            _local_22 = msPerLine;
                            while (_local_12 < _local_22.length)
                            {
                                _local_23 = _local_22[_local_12];
                                _local_12++;
                                if (_local_23 > 0)
                                {
                                    _local_21 = (_local_21 + _local_23);
                                    _local_11++;
                                };
                            };
                            if (_local_11 != 0)
                            {
                                _local_21 = (_local_21 / _local_11);
                                step = int(Math.ceil(Math.max(((_local_19 / _local_21) / _local_20), (0x5000 / img.width))));
                            }
                            else
                            {
                                step = int(Math.ceil((0x5000 / img.width)));
                            };
                        }
                        else
                        {
                            step = int(Math.ceil((0x5000 / img.width)));
                        };
                    }
                    else
                    {
                        step = int(Math.ceil((0x5000 / img.width)));
                    };
                };
                ApplicationDomain.currentDomain.domainMemory = _local_2;
                if (_local_3 != null)
                {
                    dispatcher.dispatchEvent(_local_3);
                    _local_3 = null;
                };
                if (_local_4 != null)
                {
                    dispatcher.dispatchEvent(_local_4);
                    _local_4 = null;
                };
                if (done)
                {
                    dispatcher = null;
                    img = null;
                    deflateStream = null;
                    msPerFrame = null;
                    msPerLine = null;
                    updatesPerFrame = null;
                    if (((PNGEncoder2Impl.encoding) && (PNGEncoder2Impl.pendingAsyncEncodings.length > 0)))
                    {
                        _local_24 = PNGEncoder2Impl.pendingAsyncEncodings.shift();
                        _local_24._new(_local_24.img, _local_24.dispatcher, _local_24.metadata);
                    };
                };
            };
        }

        public function onEnterFrame(_arg_1:Event):void
        {
            var _local_2:int;
            var _local_3:* = (null as ByteArray);
            var _local_4:* = (null as ProgressEvent);
            var _local_5:* = (null as Event);
            var _local_6:int;
            var _local_7:int;
            var _local_8:* = (null as Event);
            var _local_9:* = (null as ByteArray);
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:Number;
            var _local_17:int;
            var _local_18:int;
            var _local_19:* = (null as Vector.<int>);
            var _local_20:Number;
            var _local_21:Number;
            var _local_22:Number;
            var _local_23:* = (null as Vector.<Number>);
            var _local_24:Number;
            var _local_25:* = (null as PNGEncoder2Impl);
            if (!done)
            {
                frameCount = (frameCount + 1);
                _local_2 = getTimer();
                msPerFrame[msPerFrameIndex] = (_local_2 - lastFrameStart);
                msPerFrameIndex = ((msPerFrameIndex + 1) & 0x03);
                lastFrameStart = _local_2;
                updatesPerFrame[updatesPerFrameIndex] = updates;
                updatesPerFrameIndex = ((updatesPerFrameIndex + 1) & 0x03);
                updates = 0;
            };
            if (!done)
            {
                _local_2 = getTimer();
                updates = (updates + 1);
                _local_3 = ApplicationDomain.currentDomain.domainMemory;
                ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
                _local_4 = null;
                _local_5 = null;
                if (img.transparent)
                {
                    _local_6 = 4;
                }
                else
                {
                    _local_6 = 3;
                };
                _local_7 = ((_local_6 * img.width) * img.height);
                if (currentY >= img.height)
                {
                    _local_4 = new ProgressEvent(ProgressEvent.PROGRESS, false, false, _local_7, _local_7);
                    _local_8 = null;
                    if (currentY >= img.height)
                    {
                        done = true;
                        PNGEncoder2Impl.sprite.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                        _local_9 = png;
                        _local_10 = 0;
                        _local_9.writeUnsignedInt(_local_10);
                        _local_9.writeUnsignedInt(1229278788);
                        if (_local_10 != 0)
                        {
                            PNGEncoder2Impl.data.position = 6600;
                            PNGEncoder2Impl.data.readBytes(_local_9, _local_9.position, 0);
                            _local_9.position = (_local_9.position + _local_10);
                        };
                        _local_11 = -1;
                        _local_11 = (li32(((_local_11 ^ 0x49) & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_11 = (li32(((_local_11 ^ 0x45) & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_11 = (li32(((_local_11 ^ 0x4E) & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_11 = (li32(((_local_11 ^ 0x44) & 0xFF) << 2) ^ (_local_11 >>> 8));
                        if (_local_10 != 0)
                        {
                            _local_12 = 6600;
                            _local_13 = (6600 + _local_10);
                            _local_14 = (6600 + (_local_10 & 0xFFFFFFF0));
                            while (_local_12 < _local_14)
                            {
                                _local_15 = (_local_11 ^ li8(_local_12));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 1));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 2));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 3));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 4));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 5));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 6));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 7));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 8));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 9));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 10));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 11));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 12));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 13));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 14));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_15 = (_local_11 ^ li8(_local_12 + 15));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_12 = (_local_12 + 16);
                            };
                            while (_local_12 < _local_13)
                            {
                                _local_15 = (_local_11 ^ li8(_local_12));
                                _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                                _local_12++;
                            };
                        };
                        _local_11 = (_local_11 ^ 0xFFFFFFFF);
                        _local_9.writeUnsignedInt(_local_11);
                        PNGEncoder2Impl.encoding = false;
                        _local_9.position = 0;
                        _local_8 = new Event(Event.COMPLETE);
                    };
                    _local_5 = _local_8;
                }
                else
                {
                    _local_16 = Math.min((currentY + step), img.height);
                    _local_10 = _local_16;
                    PNGEncoder2Impl.writeIDATChunk(img, currentY, _local_10, deflateStream, png);
                    currentY = _local_10;
                    _local_11 = ((_local_6 * img.width) * currentY);
                    _local_4 = new ProgressEvent(ProgressEvent.PROGRESS, false, false, _local_11, _local_7);
                    _local_8 = null;
                    if (currentY >= img.height)
                    {
                        done = true;
                        PNGEncoder2Impl.sprite.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                        _local_9 = png;
                        _local_12 = 0;
                        _local_9.writeUnsignedInt(_local_12);
                        _local_9.writeUnsignedInt(1229278788);
                        if (_local_12 != 0)
                        {
                            PNGEncoder2Impl.data.position = 6600;
                            PNGEncoder2Impl.data.readBytes(_local_9, _local_9.position, 0);
                            _local_9.position = (_local_9.position + _local_12);
                        };
                        _local_13 = -1;
                        _local_13 = (li32(((_local_13 ^ 0x49) & 0xFF) << 2) ^ (_local_13 >>> 8));
                        _local_13 = (li32(((_local_13 ^ 0x45) & 0xFF) << 2) ^ (_local_13 >>> 8));
                        _local_13 = (li32(((_local_13 ^ 0x4E) & 0xFF) << 2) ^ (_local_13 >>> 8));
                        _local_13 = (li32(((_local_13 ^ 0x44) & 0xFF) << 2) ^ (_local_13 >>> 8));
                        if (_local_12 != 0)
                        {
                            _local_14 = 6600;
                            _local_15 = (6600 + _local_12);
                            _local_17 = (6600 + (_local_12 & 0xFFFFFFF0));
                            while (_local_14 < _local_17)
                            {
                                _local_18 = (_local_13 ^ li8(_local_14));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 1));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 2));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 3));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 4));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 5));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 6));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 7));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 8));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 9));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 10));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 11));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 12));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 13));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 14));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_18 = (_local_13 ^ li8(_local_14 + 15));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_14 = (_local_14 + 16);
                            };
                            while (_local_14 < _local_15)
                            {
                                _local_18 = (_local_13 ^ li8(_local_14));
                                _local_13 = (li32((_local_18 & 0xFF) << 2) ^ (_local_13 >>> 8));
                                _local_14++;
                            };
                        };
                        _local_13 = (_local_13 ^ 0xFFFFFFFF);
                        _local_9.writeUnsignedInt(_local_13);
                        PNGEncoder2Impl.encoding = false;
                        _local_9.position = 0;
                        _local_8 = new Event(Event.COMPLETE);
                    };
                    _local_5 = _local_8;
                    _local_12 = (getTimer() - _local_2);
                    _local_13 = step;
                    if (_local_13 != 0)
                    {
                        if (_local_12 <= 0)
                        {
                            _local_12 = 5;
                        };
                        msPerLine[msPerLineIndex] = ((_local_12 * 1) / _local_13);
                        msPerLineIndex = ((msPerLineIndex + 1) & 0x03);
                    };
                    _local_16 = 0;
                    _local_12 = 0;
                    _local_13 = 0;
                    _local_19 = msPerFrame;
                    while (_local_13 < _local_19.length)
                    {
                        _local_14 = _local_19[_local_13];
                        _local_13++;
                        if (_local_14 > 0)
                        {
                            _local_16 = (_local_16 + _local_14);
                            _local_12++;
                        };
                    };
                    if (_local_12 != 0)
                    {
                        _local_16 = (_local_16 / _local_12);
                        _local_20 = (1000 / targetFPS);
                        if (_local_16 > (_local_20 * 1.15))
                        {
                            _local_20 = (_local_20 - (_local_16 - _local_20));
                        };
                        _local_21 = 0;
                        _local_12 = 0;
                        _local_13 = 0;
                        _local_19 = updatesPerFrame;
                        while (_local_13 < _local_19.length)
                        {
                            _local_14 = _local_19[_local_13];
                            _local_13++;
                            if (_local_14 > 0)
                            {
                                _local_21 = (_local_21 + _local_14);
                                _local_12++;
                            };
                        };
                        if (_local_12 != 0)
                        {
                            _local_21 = (_local_21 / _local_12);
                            _local_22 = 0;
                            _local_12 = 0;
                            _local_13 = 0;
                            _local_23 = msPerLine;
                            while (_local_13 < _local_23.length)
                            {
                                _local_24 = _local_23[_local_13];
                                _local_13++;
                                if (_local_24 > 0)
                                {
                                    _local_22 = (_local_22 + _local_24);
                                    _local_12++;
                                };
                            };
                            if (_local_12 != 0)
                            {
                                _local_22 = (_local_22 / _local_12);
                                step = int(Math.ceil(Math.max(((_local_20 / _local_22) / _local_21), (0x5000 / img.width))));
                            }
                            else
                            {
                                step = int(Math.ceil((0x5000 / img.width)));
                            };
                        }
                        else
                        {
                            step = int(Math.ceil((0x5000 / img.width)));
                        };
                    }
                    else
                    {
                        step = int(Math.ceil((0x5000 / img.width)));
                    };
                };
                ApplicationDomain.currentDomain.domainMemory = _local_3;
                if (_local_4 != null)
                {
                    dispatcher.dispatchEvent(_local_4);
                    _local_4 = null;
                };
                if (_local_5 != null)
                {
                    dispatcher.dispatchEvent(_local_5);
                    _local_5 = null;
                };
                if (done)
                {
                    dispatcher = null;
                    img = null;
                    deflateStream = null;
                    msPerFrame = null;
                    msPerLine = null;
                    updatesPerFrame = null;
                    if (((PNGEncoder2Impl.encoding) && (PNGEncoder2Impl.pendingAsyncEncodings.length > 0)))
                    {
                        _local_25 = PNGEncoder2Impl.pendingAsyncEncodings.shift();
                        _local_25._new(_local_25.img, _local_25.dispatcher, _local_25.metadata);
                    };
                };
            };
        }

        public function finalize():Event
        {
            var _local_2:* = (null as ByteArray);
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_1:Event;
            if (currentY >= img.height)
            {
                done = true;
                PNGEncoder2Impl.sprite.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                _local_2 = png;
                _local_3 = 0;
                _local_2.writeUnsignedInt(_local_3);
                _local_2.writeUnsignedInt(1229278788);
                if (_local_3 != 0)
                {
                    PNGEncoder2Impl.data.position = 6600;
                    PNGEncoder2Impl.data.readBytes(_local_2, _local_2.position, 0);
                    _local_2.position = (_local_2.position + _local_3);
                };
                _local_4 = -1;
                _local_4 = (li32(((_local_4 ^ 0x49) & 0xFF) << 2) ^ (_local_4 >>> 8));
                _local_4 = (li32(((_local_4 ^ 0x45) & 0xFF) << 2) ^ (_local_4 >>> 8));
                _local_4 = (li32(((_local_4 ^ 0x4E) & 0xFF) << 2) ^ (_local_4 >>> 8));
                _local_4 = (li32(((_local_4 ^ 0x44) & 0xFF) << 2) ^ (_local_4 >>> 8));
                if (_local_3 != 0)
                {
                    _local_5 = 6600;
                    _local_6 = (6600 + _local_3);
                    _local_7 = (6600 + (_local_3 & 0xFFFFFFF0));
                    while (_local_5 < _local_7)
                    {
                        _local_8 = (_local_4 ^ li8(_local_5));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 1));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 2));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 3));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 4));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 5));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 6));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 7));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 8));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 9));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 10));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 11));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 12));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 13));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 14));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_8 = (_local_4 ^ li8(_local_5 + 15));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_5 = (_local_5 + 16);
                    };
                    while (_local_5 < _local_6)
                    {
                        _local_8 = (_local_4 ^ li8(_local_5));
                        _local_4 = (li32((_local_8 & 0xFF) << 2) ^ (_local_4 >>> 8));
                        _local_5++;
                    };
                };
                _local_4 = (_local_4 ^ 0xFFFFFFFF);
                _local_2.writeUnsignedInt(_local_4);
                PNGEncoder2Impl.encoding = false;
                _local_2.position = 0;
                _local_1 = new Event(Event.COMPLETE);
            };
            return (_local_1);
        }

        public function fastNew(_arg_1:BitmapData, _arg_2:IEventDispatcher, _arg_3:*):void
        {
            var _local_4:* = (null as ByteArray);
            var _local_5:* = (null as BitmapData);
            var _local_6:Number;
            var _local_7:uint;
            var _local_8:int;
            var _local_9:int;
            var _local_10:* = (null as ByteArray);
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:Number;
            var _local_17:* = (null as Vector.<int>);
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:* = (null as Vector.<Number>);
            var _local_22:Number;
            img = _arg_1;
            dispatcher = _arg_2;
            metadata = _arg_3;
            if (PNGEncoder2Impl.encoding)
            {
                PNGEncoder2Impl.pendingAsyncEncodings.push(this);
            }
            else
            {
                lastFrameStart = getTimer();
                _local_4 = ApplicationDomain.currentDomain.domainMemory;
                _local_5 = img;
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
                    _local_6 = Math.max(6600, ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
                    PNGEncoder2Impl.data.length = _local_6;
                };
                ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
                if (!PNGEncoder2Impl.crcComputed)
                {
                    _local_8 = 0;
                    while (_local_8 < 0x0100)
                    {
                        _local_9 = _local_8++;
                        _local_7 = _local_9;
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        si32(_local_7, (_local_9 << 2));
                    };
                    PNGEncoder2Impl.crcComputed = true;
                };
                _local_10 = new ByteArray();
                _local_10.writeUnsignedInt(-1991225785);
                _local_10.writeUnsignedInt(218765834);
                _local_8 = 13;
                _local_6 = Math.max((6600 + _local_8), ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
                PNGEncoder2Impl.data.length = _local_6;
                ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
                _local_7 = _local_5.width;
                si8((_local_7 >>> 24), 6600);
                si8((_local_7 >>> 16), 6601);
                si8((_local_7 >>> 8), 6602);
                si8(_local_7, 6603);
                _local_7 = _local_5.height;
                si8((_local_7 >>> 24), 6604);
                si8((_local_7 >>> 16), 6605);
                si8((_local_7 >>> 8), 6606);
                si8(_local_7, 6607);
                si8(8, 6608);
                if (_local_5.transparent)
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
                _local_9 = _local_8;
                _local_10.writeUnsignedInt(_local_9);
                _local_10.writeUnsignedInt(1229472850);
                if (_local_9 != 0)
                {
                    PNGEncoder2Impl.data.position = 6600;
                    PNGEncoder2Impl.data.readBytes(_local_10, _local_10.position, _local_8);
                    _local_10.position = (_local_10.position + _local_9);
                };
                _local_11 = -1;
                _local_11 = (li32(((_local_11 ^ 0x49) & 0xFF) << 2) ^ (_local_11 >>> 8));
                _local_11 = (li32(((_local_11 ^ 0x48) & 0xFF) << 2) ^ (_local_11 >>> 8));
                _local_11 = (li32(((_local_11 ^ 0x44) & 0xFF) << 2) ^ (_local_11 >>> 8));
                _local_11 = (li32(((_local_11 ^ 0x52) & 0xFF) << 2) ^ (_local_11 >>> 8));
                if (_local_9 != 0)
                {
                    _local_12 = 6600;
                    _local_13 = (6600 + _local_9);
                    _local_14 = (6600 + (_local_9 & 0xFFFFFFF0));
                    while (_local_12 < _local_14)
                    {
                        _local_15 = (_local_11 ^ li8(_local_12));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 1));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 2));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 3));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 4));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 5));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 6));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 7));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 8));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 9));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 10));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 11));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 12));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 13));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 14));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 15));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_12 = (_local_12 + 16);
                    };
                    while (_local_12 < _local_13)
                    {
                        _local_15 = (_local_11 ^ li8(_local_12));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_12++;
                    };
                };
                _local_11 = (_local_11 ^ 0xFFFFFFFF);
                _local_10.writeUnsignedInt(_local_11);
                PNGEncoder2Impl.writeMetadataChunks(_arg_3, _local_10);
                png = _local_10;
                currentY = 0;
                frameCount = 0;
                done = false;
                msPerFrame = new Vector.<int>(4, true);
                msPerFrameIndex = 0;
                msPerLine = new Vector.<Number>(4, true);
                msPerLineIndex = 0;
                updatesPerFrame = new Vector.<int>(4, true);
                updatesPerFrameIndex = 0;
                deflateStream = DeflateStream.createEx(PNGEncoder2Impl.level, 0x0400, 6600, true);
                PNGEncoder2Impl.sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
                if (((img.width > (0)) && (img.height > 0)))
                {
                    _local_8 = getTimer();
                    _local_9 = int(Math.ceil(Math.min((0x5000 / img.width), img.height)));
                    PNGEncoder2Impl.writeIDATChunk(img, 0, _local_9, deflateStream, png);
                    _local_11 = getTimer();
                    _local_12 = (_local_11 - _local_8);
                    if (_local_9 != 0)
                    {
                        if (_local_12 <= 0)
                        {
                            _local_12 = 5;
                        };
                        msPerLine[msPerLineIndex] = ((_local_12 * 1) / _local_9);
                        msPerLineIndex = ((msPerLineIndex + 1) & 0x03);
                    };
                    if (((Lib.current == (null)) || (Lib.current.stage == null)))
                    {
                        _local_6 = 24;
                    }
                    else
                    {
                        _local_6 = Lib.current.stage.frameRate;
                    };
                    _local_12 = int(((1 / _local_6) * 1000));
                    msPerFrame[msPerFrameIndex] = _local_12;
                    msPerFrameIndex = ((msPerFrameIndex + 1) & 0x03);
                    updatesPerFrame[updatesPerFrameIndex] = 1;
                    updatesPerFrameIndex = ((updatesPerFrameIndex + 1) & 0x03);
                    _local_16 = 0;
                    _local_12 = 0;
                    _local_13 = 0;
                    _local_17 = msPerFrame;
                    while (_local_13 < _local_17.length)
                    {
                        _local_14 = _local_17[_local_13];
                        _local_13++;
                        if (_local_14 > 0)
                        {
                            _local_16 = (_local_16 + _local_14);
                            _local_12++;
                        };
                    };
                    if (_local_12 != 0)
                    {
                        _local_16 = (_local_16 / _local_12);
                        _local_18 = (1000 / targetFPS);
                        if (_local_16 > (_local_18 * 1.15))
                        {
                            _local_18 = (_local_18 - (_local_16 - _local_18));
                        };
                        _local_19 = 0;
                        _local_12 = 0;
                        _local_13 = 0;
                        _local_17 = updatesPerFrame;
                        while (_local_13 < _local_17.length)
                        {
                            _local_14 = _local_17[_local_13];
                            _local_13++;
                            if (_local_14 > 0)
                            {
                                _local_19 = (_local_19 + _local_14);
                                _local_12++;
                            };
                        };
                        if (_local_12 != 0)
                        {
                            _local_19 = (_local_19 / _local_12);
                            _local_20 = 0;
                            _local_12 = 0;
                            _local_13 = 0;
                            _local_21 = msPerLine;
                            while (_local_13 < _local_21.length)
                            {
                                _local_22 = _local_21[_local_13];
                                _local_13++;
                                if (_local_22 > 0)
                                {
                                    _local_20 = (_local_20 + _local_22);
                                    _local_12++;
                                };
                            };
                            if (_local_12 != 0)
                            {
                                _local_20 = (_local_20 / _local_12);
                                step = int(Math.ceil(Math.max(((_local_18 / _local_20) / _local_19), (0x5000 / img.width))));
                            }
                            else
                            {
                                step = int(Math.ceil((0x5000 / img.width)));
                            };
                        }
                        else
                        {
                            step = int(Math.ceil((0x5000 / img.width)));
                        };
                    }
                    else
                    {
                        step = int(Math.ceil((0x5000 / img.width)));
                    };
                    currentY = _local_9;
                }
                else
                {
                    step = img.height;
                };
                updates = 0;
                ApplicationDomain.currentDomain.domainMemory = _local_4;
            };
        }

        public function _new(_arg_1:BitmapData, _arg_2:IEventDispatcher, _arg_3:*):void
        {
            var _local_4:* = (null as ByteArray);
            var _local_5:* = (null as BitmapData);
            var _local_6:Number;
            var _local_7:uint;
            var _local_8:int;
            var _local_9:int;
            var _local_10:* = (null as ByteArray);
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:Number;
            var _local_17:* = (null as Vector.<int>);
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:* = (null as Vector.<Number>);
            var _local_22:Number;
            img = _arg_1;
            dispatcher = _arg_2;
            metadata = _arg_3;
            if (PNGEncoder2Impl.encoding)
            {
                PNGEncoder2Impl.pendingAsyncEncodings.push(this);
            }
            else
            {
                lastFrameStart = getTimer();
                _local_4 = ApplicationDomain.currentDomain.domainMemory;
                _local_5 = img;
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
                    _local_6 = Math.max(6600, ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
                    PNGEncoder2Impl.data.length = _local_6;
                };
                ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
                if (!PNGEncoder2Impl.crcComputed)
                {
                    _local_8 = 0;
                    while (_local_8 < 0x0100)
                    {
                        _local_9 = _local_8++;
                        _local_7 = _local_9;
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        if ((_local_7 & 0x01) == 1)
                        {
                            _local_7 = (0xEDB88320 ^ (_local_7 >>> 1));
                        }
                        else
                        {
                            _local_7 = (_local_7 >>> 1);
                        };
                        si32(_local_7, (_local_9 << 2));
                    };
                    PNGEncoder2Impl.crcComputed = true;
                };
                _local_10 = new ByteArray();
                _local_10.writeUnsignedInt(-1991225785);
                _local_10.writeUnsignedInt(218765834);
                _local_8 = 13;
                _local_6 = Math.max((6600 + _local_8), ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
                PNGEncoder2Impl.data.length = _local_6;
                ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
                _local_7 = _local_5.width;
                si8((_local_7 >>> 24), 6600);
                si8((_local_7 >>> 16), 6601);
                si8((_local_7 >>> 8), 6602);
                si8(_local_7, 6603);
                _local_7 = _local_5.height;
                si8((_local_7 >>> 24), 6604);
                si8((_local_7 >>> 16), 6605);
                si8((_local_7 >>> 8), 6606);
                si8(_local_7, 6607);
                si8(8, 6608);
                if (_local_5.transparent)
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
                _local_9 = _local_8;
                _local_10.writeUnsignedInt(_local_9);
                _local_10.writeUnsignedInt(1229472850);
                if (_local_9 != 0)
                {
                    PNGEncoder2Impl.data.position = 6600;
                    PNGEncoder2Impl.data.readBytes(_local_10, _local_10.position, _local_8);
                    _local_10.position = (_local_10.position + _local_9);
                };
                _local_11 = -1;
                _local_11 = (li32(((_local_11 ^ 0x49) & 0xFF) << 2) ^ (_local_11 >>> 8));
                _local_11 = (li32(((_local_11 ^ 0x48) & 0xFF) << 2) ^ (_local_11 >>> 8));
                _local_11 = (li32(((_local_11 ^ 0x44) & 0xFF) << 2) ^ (_local_11 >>> 8));
                _local_11 = (li32(((_local_11 ^ 0x52) & 0xFF) << 2) ^ (_local_11 >>> 8));
                if (_local_9 != 0)
                {
                    _local_12 = 6600;
                    _local_13 = (6600 + _local_9);
                    _local_14 = (6600 + (_local_9 & 0xFFFFFFF0));
                    while (_local_12 < _local_14)
                    {
                        _local_15 = (_local_11 ^ li8(_local_12));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 1));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 2));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 3));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 4));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 5));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 6));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 7));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 8));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 9));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 10));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 11));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 12));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 13));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 14));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_15 = (_local_11 ^ li8(_local_12 + 15));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_12 = (_local_12 + 16);
                    };
                    while (_local_12 < _local_13)
                    {
                        _local_15 = (_local_11 ^ li8(_local_12));
                        _local_11 = (li32((_local_15 & 0xFF) << 2) ^ (_local_11 >>> 8));
                        _local_12++;
                    };
                };
                _local_11 = (_local_11 ^ 0xFFFFFFFF);
                _local_10.writeUnsignedInt(_local_11);
                PNGEncoder2Impl.writeMetadataChunks(_arg_3, _local_10);
                png = _local_10;
                currentY = 0;
                frameCount = 0;
                done = false;
                msPerFrame = new Vector.<int>(4, true);
                msPerFrameIndex = 0;
                msPerLine = new Vector.<Number>(4, true);
                msPerLineIndex = 0;
                updatesPerFrame = new Vector.<int>(4, true);
                updatesPerFrameIndex = 0;
                deflateStream = DeflateStream.createEx(PNGEncoder2Impl.level, 0x0400, 6600, true);
                PNGEncoder2Impl.sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
                if (((img.width > (0)) && (img.height > 0)))
                {
                    _local_8 = getTimer();
                    _local_9 = int(Math.ceil(Math.min((0x5000 / img.width), img.height)));
                    PNGEncoder2Impl.writeIDATChunk(img, 0, _local_9, deflateStream, png);
                    _local_11 = getTimer();
                    _local_12 = (_local_11 - _local_8);
                    if (_local_9 != 0)
                    {
                        if (_local_12 <= 0)
                        {
                            _local_12 = 5;
                        };
                        msPerLine[msPerLineIndex] = ((_local_12 * 1) / _local_9);
                        msPerLineIndex = ((msPerLineIndex + 1) & 0x03);
                    };
                    if (((Lib.current == (null)) || (Lib.current.stage == null)))
                    {
                        _local_6 = 24;
                    }
                    else
                    {
                        _local_6 = Lib.current.stage.frameRate;
                    };
                    _local_12 = int(((1 / _local_6) * 1000));
                    msPerFrame[msPerFrameIndex] = _local_12;
                    msPerFrameIndex = ((msPerFrameIndex + 1) & 0x03);
                    updatesPerFrame[updatesPerFrameIndex] = 1;
                    updatesPerFrameIndex = ((updatesPerFrameIndex + 1) & 0x03);
                    _local_16 = 0;
                    _local_12 = 0;
                    _local_13 = 0;
                    _local_17 = msPerFrame;
                    while (_local_13 < _local_17.length)
                    {
                        _local_14 = _local_17[_local_13];
                        _local_13++;
                        if (_local_14 > 0)
                        {
                            _local_16 = (_local_16 + _local_14);
                            _local_12++;
                        };
                    };
                    if (_local_12 != 0)
                    {
                        _local_16 = (_local_16 / _local_12);
                        _local_18 = (1000 / targetFPS);
                        if (_local_16 > (_local_18 * 1.15))
                        {
                            _local_18 = (_local_18 - (_local_16 - _local_18));
                        };
                        _local_19 = 0;
                        _local_12 = 0;
                        _local_13 = 0;
                        _local_17 = updatesPerFrame;
                        while (_local_13 < _local_17.length)
                        {
                            _local_14 = _local_17[_local_13];
                            _local_13++;
                            if (_local_14 > 0)
                            {
                                _local_19 = (_local_19 + _local_14);
                                _local_12++;
                            };
                        };
                        if (_local_12 != 0)
                        {
                            _local_19 = (_local_19 / _local_12);
                            _local_20 = 0;
                            _local_12 = 0;
                            _local_13 = 0;
                            _local_21 = msPerLine;
                            while (_local_13 < _local_21.length)
                            {
                                _local_22 = _local_21[_local_13];
                                _local_13++;
                                if (_local_22 > 0)
                                {
                                    _local_20 = (_local_20 + _local_22);
                                    _local_12++;
                                };
                            };
                            if (_local_12 != 0)
                            {
                                _local_20 = (_local_20 / _local_12);
                                step = int(Math.ceil(Math.max(((_local_18 / _local_20) / _local_19), (0x5000 / img.width))));
                            }
                            else
                            {
                                step = int(Math.ceil((0x5000 / img.width)));
                            };
                        }
                        else
                        {
                            step = int(Math.ceil((0x5000 / img.width)));
                        };
                    }
                    else
                    {
                        step = int(Math.ceil((0x5000 / img.width)));
                    };
                    currentY = _local_9;
                }
                else
                {
                    step = img.height;
                };
                updates = 0;
                ApplicationDomain.currentDomain.domainMemory = _local_4;
            };
        }


    }
} _PNGEncoder2

