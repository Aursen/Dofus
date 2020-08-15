package _DeflateStream
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public class LZHash 
    {

        public static var HASH_BITS:int = 16;
        public static var HASH_ENTRIES:int = 0x10000;
        public static var HASH_MASK:int = 0xFFFF;
        public static var SLOT_SIZE:int = 5;
        public static var HASH_SIZE:int = 0x50000;
        public static var MAX_ATTEMPTS:int = 5;
        public static var MAX_HASH_DEPTH:int = 8;
        public static var LOOKAHEADS:int = 1;
        public static var LOOKAHEAD_SIZE:int = 8;
        public static var LOOKAHEAD_MASK:int = 7;
        public static var HASH_SCRATCH_SIZE:int = 12;
        public static var SCRATCH_SIZE:int = 20;
        public static var GOOD_MATCH_LENGTH_THRESHOLD:int = 4;
        public static var MEMORY_SIZE:int = 327700;
        public static var MAX_LOOKAHEAD:int = 9;
        public static var MIN_MATCH_LENGTH:int = 4;

        public var windowSize:int;
        public var resultAddr:int;
        public var maxMatchLength:int;
        public var hashScratchAddr:int;
        public var baseResultAddr:int;
        public var avgMatchLength:int;
        public var addr:int;

        public function LZHash(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            addr = _arg_1;
            maxMatchLength = _arg_2;
            windowSize = _arg_3;
            avgMatchLength = 12;
            var _local_4:* = ((_arg_1 + 327700) - 20);
            resultAddr = _local_4;
            baseResultAddr = _local_4;
            hashScratchAddr = (baseResultAddr + 8);
            clearTable();
        }

        public static function hash4(_arg_1:int, _arg_2:int):int
        {
            var _local_3:* = 775236557;
            var _local_4:* = -862048943;
            var _local_5:* = 461845907;
            var _local_6:* = (li32(_arg_1) * _local_4);
            _local_6 = ((_local_6 << 15) | (_local_6 >>> 17));
            _local_3 = (_local_3 ^ (_local_6 * _local_5));
            _local_3 = ((_local_3 << 13) | (_local_3 >>> 19));
            _local_3 = ((_local_3 * 5) + -430675100);
            var _local_7:* = (_local_3 ^ 0x04);
            _local_7 = (_local_7 ^ (_local_7 >>> 16));
            _local_7 = (_local_7 * -2048144789);
            _local_7 = (_local_7 ^ (_local_7 >>> 13));
            _local_7 = (_local_7 * -1028477387);
            return ((_local_7 ^ (_local_7 >>> 16)) & _arg_2);
        }

        public static function murmur_fmix(_arg_1:int):int
        {
            _arg_1 = (_arg_1 ^ (_arg_1 >>> 16));
            _arg_1 = (_arg_1 * -2048144789);
            _arg_1 = (_arg_1 ^ (_arg_1 >>> 13));
            _arg_1 = (_arg_1 * -1028477387);
            return (_arg_1 ^ (_arg_1 >>> 16));
        }


        public function update(_arg_1:int):void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_4:* = 775236557;
            var _local_5:* = -862048943;
            _local_6 = 461845907;
            _local_7 = (li32(_arg_1) * _local_5);
            _local_7 = ((_local_7 << 15) | (_local_7 >>> 17));
            _local_4 = (_local_4 ^ (_local_7 * _local_6));
            _local_4 = ((_local_4 << 13) | (_local_4 >>> 19));
            _local_4 = ((_local_4 * 5) + -430675100);
            _local_8 = (_local_4 ^ 0x04);
            _local_8 = (_local_8 ^ (_local_8 >>> 16));
            _local_8 = (_local_8 * -2048144789);
            _local_8 = (_local_8 ^ (_local_8 >>> 13));
            _local_8 = (_local_8 * -1028477387);
            var _local_3:* = ((_local_8 ^ (_local_8 >>> 16)) & 0xFFFF);
            var _local_2:* = (addr + (_local_3 * 5));
            _local_3 = 4;
            _local_4 = _arg_1;
            _local_5 = li8(_local_2);
            if (((_local_5 < (8)) && (_local_5 >= 0)))
            {
                _local_6 = li32(_local_2 + 1);
                si8(_local_3, _local_2);
                si32(_local_4, (_local_2 + 1));
                _local_3 = (_local_5 + 1);
                _local_4 = _local_6;
                _local_8 = li32(_local_4);
                si32(_local_8, hashScratchAddr);
                _local_8 = li32(_local_4 + 4);
                si32(_local_8, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_3));
                _local_8 = 775236557;
                _local_9 = -862048943;
                _local_10 = 461845907;
                _local_11 = (li32(hashScratchAddr) * _local_9);
                _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                _local_8 = (_local_8 ^ (_local_11 * _local_10));
                _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                _local_8 = ((_local_8 * 5) + -430675100);
                _local_11 = (li32(hashScratchAddr + 4) * _local_9);
                _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                _local_8 = (_local_8 ^ (_local_11 * _local_10));
                _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                _local_8 = ((_local_8 * 5) + -430675100);
                _local_12 = (_local_8 ^ _local_3);
                _local_12 = (_local_12 ^ (_local_12 >>> 16));
                _local_12 = (_local_12 * -2048144789);
                _local_12 = (_local_12 ^ (_local_12 >>> 13));
                _local_12 = (_local_12 * -1028477387);
                _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                _local_2 = (addr + (_local_7 * 5));
                _local_5 = li8(_local_2);
                if (((_local_5 < (8)) && (_local_5 >= 0)))
                {
                    _local_6 = li32(_local_2 + 1);
                    si8(_local_3, _local_2);
                    si32(_local_4, (_local_2 + 1));
                    _local_3 = (_local_5 + 1);
                    _local_4 = _local_6;
                    _local_8 = li32(_local_4);
                    si32(_local_8, hashScratchAddr);
                    _local_8 = li32(_local_4 + 4);
                    si32(_local_8, (hashScratchAddr + 4));
                    si32(0, (hashScratchAddr + _local_3));
                    _local_8 = 775236557;
                    _local_9 = -862048943;
                    _local_10 = 461845907;
                    _local_11 = (li32(hashScratchAddr) * _local_9);
                    _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                    _local_8 = (_local_8 ^ (_local_11 * _local_10));
                    _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                    _local_8 = ((_local_8 * 5) + -430675100);
                    _local_11 = (li32(hashScratchAddr + 4) * _local_9);
                    _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                    _local_8 = (_local_8 ^ (_local_11 * _local_10));
                    _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                    _local_8 = ((_local_8 * 5) + -430675100);
                    _local_12 = (_local_8 ^ _local_3);
                    _local_12 = (_local_12 ^ (_local_12 >>> 16));
                    _local_12 = (_local_12 * -2048144789);
                    _local_12 = (_local_12 ^ (_local_12 >>> 13));
                    _local_12 = (_local_12 * -1028477387);
                    _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                    _local_2 = (addr + (_local_7 * 5));
                    _local_5 = li8(_local_2);
                    if (((_local_5 < (8)) && (_local_5 >= 0)))
                    {
                        _local_6 = li32(_local_2 + 1);
                        si8(_local_3, _local_2);
                        si32(_local_4, (_local_2 + 1));
                        _local_3 = (_local_5 + 1);
                        _local_4 = _local_6;
                        _local_8 = li32(_local_4);
                        si32(_local_8, hashScratchAddr);
                        _local_8 = li32(_local_4 + 4);
                        si32(_local_8, (hashScratchAddr + 4));
                        si32(0, (hashScratchAddr + _local_3));
                        _local_8 = 775236557;
                        _local_9 = -862048943;
                        _local_10 = 461845907;
                        _local_11 = (li32(hashScratchAddr) * _local_9);
                        _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                        _local_8 = (_local_8 ^ (_local_11 * _local_10));
                        _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                        _local_8 = ((_local_8 * 5) + -430675100);
                        _local_11 = (li32(hashScratchAddr + 4) * _local_9);
                        _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                        _local_8 = (_local_8 ^ (_local_11 * _local_10));
                        _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                        _local_8 = ((_local_8 * 5) + -430675100);
                        _local_12 = (_local_8 ^ _local_3);
                        _local_12 = (_local_12 ^ (_local_12 >>> 16));
                        _local_12 = (_local_12 * -2048144789);
                        _local_12 = (_local_12 ^ (_local_12 >>> 13));
                        _local_12 = (_local_12 * -1028477387);
                        _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                        _local_2 = (addr + (_local_7 * 5));
                        _local_5 = li8(_local_2);
                        if (((_local_5 < (8)) && (_local_5 >= 0)))
                        {
                            _local_6 = li32(_local_2 + 1);
                            si8(_local_3, _local_2);
                            si32(_local_4, (_local_2 + 1));
                            _local_3 = (_local_5 + 1);
                            _local_4 = _local_6;
                            _local_8 = li32(_local_4);
                            si32(_local_8, hashScratchAddr);
                            _local_8 = li32(_local_4 + 4);
                            si32(_local_8, (hashScratchAddr + 4));
                            si32(0, (hashScratchAddr + _local_3));
                            _local_8 = 775236557;
                            _local_9 = -862048943;
                            _local_10 = 461845907;
                            _local_11 = (li32(hashScratchAddr) * _local_9);
                            _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                            _local_8 = (_local_8 ^ (_local_11 * _local_10));
                            _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                            _local_8 = ((_local_8 * 5) + -430675100);
                            _local_11 = (li32(hashScratchAddr + 4) * _local_9);
                            _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                            _local_8 = (_local_8 ^ (_local_11 * _local_10));
                            _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                            _local_8 = ((_local_8 * 5) + -430675100);
                            _local_12 = (_local_8 ^ _local_3);
                            _local_12 = (_local_12 ^ (_local_12 >>> 16));
                            _local_12 = (_local_12 * -2048144789);
                            _local_12 = (_local_12 ^ (_local_12 >>> 13));
                            _local_12 = (_local_12 * -1028477387);
                            _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                            _local_2 = (addr + (_local_7 * 5));
                        };
                    };
                };
            };
            si8(_local_3, _local_2);
            si32(_local_4, (_local_2 + 1));
        }

        public function unsafeSearchAndUpdate(_arg_1:int):void
        {
            var _local_2:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
            var _local_20:int;
            _local_5 = 775236557;
            _local_6 = -862048943;
            _local_7 = 461845907;
            _local_8 = (li32(_arg_1 + 1) * _local_6);
            _local_8 = ((_local_8 << 15) | (_local_8 >>> 17));
            _local_5 = (_local_5 ^ (_local_8 * _local_7));
            _local_5 = ((_local_5 << 13) | (_local_5 >>> 19));
            _local_5 = ((_local_5 * 5) + -430675100);
            _local_9 = (_local_5 ^ 0x04);
            _local_9 = (_local_9 ^ (_local_9 >>> 16));
            _local_9 = (_local_9 * -2048144789);
            _local_9 = (_local_9 ^ (_local_9 >>> 13));
            _local_9 = (_local_9 * -1028477387);
            _local_4 = ((_local_9 ^ (_local_9 >>> 16)) & 0xFFFF);
            var _local_3:* = (addr + (_local_4 * 5));
            if (li16(baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07)) < (avgMatchLength + 4))
            {
                _local_4 = (_arg_1 + 1);
                _local_5 = 3;
                _local_6 = -1;
                _local_8 = li32(_local_3 + 1);
                if ((((_local_8 >= (0)) && (li32(_local_4) == li32(_local_8))) && ((_local_4 - _local_8) <= windowSize)))
                {
                    _local_9 = (_local_4 + 4);
                    _local_7 = 4;
                    _local_8 = (_local_8 + 4);
                    while (((li32(_local_8) == (li32(_local_9))) && ((_local_7 + 4) <= maxMatchLength)))
                    {
                        _local_7 = (_local_7 + 4);
                        _local_8 = (_local_8 + 4);
                        _local_9 = (_local_9 + 4);
                    };
                    while (((li8(_local_8) == (li8(_local_9))) && (_local_7 < maxMatchLength)))
                    {
                        _local_7++;
                        _local_8++;
                        _local_9++;
                    };
                    _local_5 = _local_7;
                    _local_6 = _local_8;
                };
                _local_10 = 5;
                _local_11 = 9;
                while (_local_10 < _local_11)
                {
                    _local_12 = _local_10++;
                    _local_15 = li32(_local_4);
                    si32(_local_15, hashScratchAddr);
                    _local_15 = li32(_local_4 + 4);
                    si32(_local_15, (hashScratchAddr + 4));
                    si32(0, (hashScratchAddr + _local_12));
                    _local_15 = 775236557;
                    _local_16 = -862048943;
                    _local_17 = 461845907;
                    _local_18 = (li32(hashScratchAddr) * _local_16);
                    _local_18 = ((_local_18 << 15) | (_local_18 >>> 17));
                    _local_15 = (_local_15 ^ (_local_18 * _local_17));
                    _local_15 = ((_local_15 << 13) | (_local_15 >>> 19));
                    _local_15 = ((_local_15 * 5) + -430675100);
                    _local_18 = (li32(hashScratchAddr + 4) * _local_16);
                    _local_18 = ((_local_18 << 15) | (_local_18 >>> 17));
                    _local_15 = (_local_15 ^ (_local_18 * _local_17));
                    _local_15 = ((_local_15 << 13) | (_local_15 >>> 19));
                    _local_15 = ((_local_15 * 5) + -430675100);
                    _local_19 = (_local_15 ^ _local_12);
                    _local_19 = (_local_19 ^ (_local_19 >>> 16));
                    _local_19 = (_local_19 * -2048144789);
                    _local_19 = (_local_19 ^ (_local_19 >>> 13));
                    _local_19 = (_local_19 * -1028477387);
                    _local_14 = ((_local_19 ^ (_local_19 >>> 16)) & 0xFFFF);
                    _local_13 = ((addr + (_local_14 * 5)) + 1);
                    _local_8 = li32(_local_13);
                    if (((((_local_8 >= (0)) && (li32((_local_8 + _local_5) - 3) == li32((_local_4 + _local_5) - 3))) && (li32(_local_4) == li32(_local_8))) && ((_local_4 - _local_8) <= windowSize)))
                    {
                        _local_9 = (_local_4 + 4);
                        _local_7 = 4;
                        _local_8 = (_local_8 + 4);
                        while (((li32(_local_8) == (li32(_local_9))) && ((_local_7 + 4) <= maxMatchLength)))
                        {
                            _local_7 = (_local_7 + 4);
                            _local_8 = (_local_8 + 4);
                            _local_9 = (_local_9 + 4);
                        };
                        while (((li8(_local_8) == (li8(_local_9))) && (_local_7 < maxMatchLength)))
                        {
                            _local_7++;
                            _local_8++;
                            _local_9++;
                        };
                        if (_local_7 > _local_5)
                        {
                            _local_5 = _local_7;
                            _local_6 = _local_8;
                        };
                    };
                };
                si32((((_local_4 - (_local_6 - _local_5)) << 16) | _local_5), resultAddr);
            }
            else
            {
                si32(0, resultAddr);
            };
            _local_4 = _local_3;
            _local_5 = 4;
            _local_6 = (_arg_1 + 1);
            _local_7 = li8(_local_4);
            if (((_local_7 < (8)) && (_local_7 >= 0)))
            {
                _local_8 = li32(_local_4 + 1);
                si8(_local_5, _local_4);
                si32(_local_6, (_local_4 + 1));
                _local_5 = (_local_7 + 1);
                _local_6 = _local_8;
                _local_10 = li32(_local_6);
                si32(_local_10, hashScratchAddr);
                _local_10 = li32(_local_6 + 4);
                si32(_local_10, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_5));
                _local_10 = 775236557;
                _local_11 = -862048943;
                _local_12 = 461845907;
                _local_13 = (li32(hashScratchAddr) * _local_11);
                _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                _local_10 = (_local_10 ^ (_local_13 * _local_12));
                _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                _local_10 = ((_local_10 * 5) + -430675100);
                _local_13 = (li32(hashScratchAddr + 4) * _local_11);
                _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                _local_10 = (_local_10 ^ (_local_13 * _local_12));
                _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                _local_10 = ((_local_10 * 5) + -430675100);
                _local_14 = (_local_10 ^ _local_5);
                _local_14 = (_local_14 ^ (_local_14 >>> 16));
                _local_14 = (_local_14 * -2048144789);
                _local_14 = (_local_14 ^ (_local_14 >>> 13));
                _local_14 = (_local_14 * -1028477387);
                _local_9 = ((_local_14 ^ (_local_14 >>> 16)) & 0xFFFF);
                _local_4 = (addr + (_local_9 * 5));
                _local_7 = li8(_local_4);
                if (((_local_7 < (8)) && (_local_7 >= 0)))
                {
                    _local_8 = li32(_local_4 + 1);
                    si8(_local_5, _local_4);
                    si32(_local_6, (_local_4 + 1));
                    _local_5 = (_local_7 + 1);
                    _local_6 = _local_8;
                    _local_10 = li32(_local_6);
                    si32(_local_10, hashScratchAddr);
                    _local_10 = li32(_local_6 + 4);
                    si32(_local_10, (hashScratchAddr + 4));
                    si32(0, (hashScratchAddr + _local_5));
                    _local_10 = 775236557;
                    _local_11 = -862048943;
                    _local_12 = 461845907;
                    _local_13 = (li32(hashScratchAddr) * _local_11);
                    _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                    _local_10 = (_local_10 ^ (_local_13 * _local_12));
                    _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                    _local_10 = ((_local_10 * 5) + -430675100);
                    _local_13 = (li32(hashScratchAddr + 4) * _local_11);
                    _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                    _local_10 = (_local_10 ^ (_local_13 * _local_12));
                    _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                    _local_10 = ((_local_10 * 5) + -430675100);
                    _local_14 = (_local_10 ^ _local_5);
                    _local_14 = (_local_14 ^ (_local_14 >>> 16));
                    _local_14 = (_local_14 * -2048144789);
                    _local_14 = (_local_14 ^ (_local_14 >>> 13));
                    _local_14 = (_local_14 * -1028477387);
                    _local_9 = ((_local_14 ^ (_local_14 >>> 16)) & 0xFFFF);
                    _local_4 = (addr + (_local_9 * 5));
                    _local_7 = li8(_local_4);
                    if (((_local_7 < (8)) && (_local_7 >= 0)))
                    {
                        _local_8 = li32(_local_4 + 1);
                        si8(_local_5, _local_4);
                        si32(_local_6, (_local_4 + 1));
                        _local_5 = (_local_7 + 1);
                        _local_6 = _local_8;
                        _local_10 = li32(_local_6);
                        si32(_local_10, hashScratchAddr);
                        _local_10 = li32(_local_6 + 4);
                        si32(_local_10, (hashScratchAddr + 4));
                        si32(0, (hashScratchAddr + _local_5));
                        _local_10 = 775236557;
                        _local_11 = -862048943;
                        _local_12 = 461845907;
                        _local_13 = (li32(hashScratchAddr) * _local_11);
                        _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                        _local_10 = (_local_10 ^ (_local_13 * _local_12));
                        _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                        _local_10 = ((_local_10 * 5) + -430675100);
                        _local_13 = (li32(hashScratchAddr + 4) * _local_11);
                        _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                        _local_10 = (_local_10 ^ (_local_13 * _local_12));
                        _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                        _local_10 = ((_local_10 * 5) + -430675100);
                        _local_14 = (_local_10 ^ _local_5);
                        _local_14 = (_local_14 ^ (_local_14 >>> 16));
                        _local_14 = (_local_14 * -2048144789);
                        _local_14 = (_local_14 ^ (_local_14 >>> 13));
                        _local_14 = (_local_14 * -1028477387);
                        _local_9 = ((_local_14 ^ (_local_14 >>> 16)) & 0xFFFF);
                        _local_4 = (addr + (_local_9 * 5));
                        _local_7 = li8(_local_4);
                        if (((_local_7 < (8)) && (_local_7 >= 0)))
                        {
                            _local_8 = li32(_local_4 + 1);
                            si8(_local_5, _local_4);
                            si32(_local_6, (_local_4 + 1));
                            _local_5 = (_local_7 + 1);
                            _local_6 = _local_8;
                            _local_10 = li32(_local_6);
                            si32(_local_10, hashScratchAddr);
                            _local_10 = li32(_local_6 + 4);
                            si32(_local_10, (hashScratchAddr + 4));
                            si32(0, (hashScratchAddr + _local_5));
                            _local_10 = 775236557;
                            _local_11 = -862048943;
                            _local_12 = 461845907;
                            _local_13 = (li32(hashScratchAddr) * _local_11);
                            _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                            _local_10 = (_local_10 ^ (_local_13 * _local_12));
                            _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                            _local_10 = ((_local_10 * 5) + -430675100);
                            _local_13 = (li32(hashScratchAddr + 4) * _local_11);
                            _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                            _local_10 = (_local_10 ^ (_local_13 * _local_12));
                            _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                            _local_10 = ((_local_10 * 5) + -430675100);
                            _local_14 = (_local_10 ^ _local_5);
                            _local_14 = (_local_14 ^ (_local_14 >>> 16));
                            _local_14 = (_local_14 * -2048144789);
                            _local_14 = (_local_14 ^ (_local_14 >>> 13));
                            _local_14 = (_local_14 * -1028477387);
                            _local_9 = ((_local_14 ^ (_local_14 >>> 16)) & 0xFFFF);
                            _local_4 = (addr + (_local_9 * 5));
                        };
                    };
                };
            };
            si8(_local_5, _local_4);
            si32(_local_6, (_local_4 + 1));
            resultAddr = (baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07));
            if (li16(resultAddr) >= 4)
            {
                _local_2 = li16(resultAddr);
                if (li16(baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07)) > _local_2)
                {
                    si32(0, resultAddr);
                }
                else
                {
                    avgMatchLength = ((((avgMatchLength << 1) + (avgMatchLength << 2)) + (_local_2 << 1)) >>> 3);
                    if (_local_2 < (avgMatchLength + 4))
                    {
                        _local_4 = ((_arg_1 + 1) + 1);
                        _local_5 = (_arg_1 + _local_2);
                        while (_local_4 < _local_5)
                        {
                            _local_6 = _local_4++;
                            _local_7 = 4;
                            _local_8 = _local_6;
                            _local_13 = 775236557;
                            _local_14 = -862048943;
                            _local_15 = 461845907;
                            _local_16 = (li32(_local_6) * _local_14);
                            _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                            _local_13 = (_local_13 ^ (_local_16 * _local_15));
                            _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                            _local_13 = ((_local_13 * 5) + -430675100);
                            _local_17 = (_local_13 ^ 0x04);
                            _local_17 = (_local_17 ^ (_local_17 >>> 16));
                            _local_17 = (_local_17 * -2048144789);
                            _local_17 = (_local_17 ^ (_local_17 >>> 13));
                            _local_17 = (_local_17 * -1028477387);
                            _local_12 = ((_local_17 ^ (_local_17 >>> 16)) & 0xFFFF);
                            _local_11 = (addr + (_local_12 * 5));
                            _local_9 = li8(_local_11);
                            if (((_local_9 < (8)) && (_local_9 >= 0)))
                            {
                                _local_10 = li32(_local_11 + 1);
                                si8(_local_7, _local_11);
                                si32(_local_8, (_local_11 + 1));
                                _local_7 = (_local_9 + 1);
                                _local_8 = _local_10;
                                _local_13 = li32(_local_8);
                                si32(_local_13, hashScratchAddr);
                                _local_13 = li32(_local_8 + 4);
                                si32(_local_13, (hashScratchAddr + 4));
                                si32(0, (hashScratchAddr + _local_7));
                                _local_13 = 775236557;
                                _local_14 = -862048943;
                                _local_15 = 461845907;
                                _local_16 = (li32(hashScratchAddr) * _local_14);
                                _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                                _local_13 = (_local_13 ^ (_local_16 * _local_15));
                                _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                                _local_13 = ((_local_13 * 5) + -430675100);
                                _local_16 = (li32(hashScratchAddr + 4) * _local_14);
                                _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                                _local_13 = (_local_13 ^ (_local_16 * _local_15));
                                _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                                _local_13 = ((_local_13 * 5) + -430675100);
                                _local_17 = (_local_13 ^ _local_7);
                                _local_17 = (_local_17 ^ (_local_17 >>> 16));
                                _local_17 = (_local_17 * -2048144789);
                                _local_17 = (_local_17 ^ (_local_17 >>> 13));
                                _local_17 = (_local_17 * -1028477387);
                                _local_12 = ((_local_17 ^ (_local_17 >>> 16)) & 0xFFFF);
                                _local_11 = (addr + (_local_12 * 5));
                                _local_9 = li8(_local_11);
                                if (((_local_9 < (8)) && (_local_9 >= 0)))
                                {
                                    _local_10 = li32(_local_11 + 1);
                                    si8(_local_7, _local_11);
                                    si32(_local_8, (_local_11 + 1));
                                    _local_7 = (_local_9 + 1);
                                    _local_8 = _local_10;
                                    _local_13 = li32(_local_8);
                                    si32(_local_13, hashScratchAddr);
                                    _local_13 = li32(_local_8 + 4);
                                    si32(_local_13, (hashScratchAddr + 4));
                                    si32(0, (hashScratchAddr + _local_7));
                                    _local_13 = 775236557;
                                    _local_14 = -862048943;
                                    _local_15 = 461845907;
                                    _local_16 = (li32(hashScratchAddr) * _local_14);
                                    _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                                    _local_13 = (_local_13 ^ (_local_16 * _local_15));
                                    _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                                    _local_13 = ((_local_13 * 5) + -430675100);
                                    _local_16 = (li32(hashScratchAddr + 4) * _local_14);
                                    _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                                    _local_13 = (_local_13 ^ (_local_16 * _local_15));
                                    _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                                    _local_13 = ((_local_13 * 5) + -430675100);
                                    _local_17 = (_local_13 ^ _local_7);
                                    _local_17 = (_local_17 ^ (_local_17 >>> 16));
                                    _local_17 = (_local_17 * -2048144789);
                                    _local_17 = (_local_17 ^ (_local_17 >>> 13));
                                    _local_17 = (_local_17 * -1028477387);
                                    _local_12 = ((_local_17 ^ (_local_17 >>> 16)) & 0xFFFF);
                                    _local_11 = (addr + (_local_12 * 5));
                                };
                            };
                            si8(_local_7, _local_11);
                            si32(_local_8, (_local_11 + 1));
                        };
                    };
                    resultAddr = (baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07));
                    _local_4 = (_arg_1 + _local_2);
                    _local_7 = 775236557;
                    _local_8 = -862048943;
                    _local_9 = 461845907;
                    _local_10 = (li32(_local_4) * _local_8);
                    _local_10 = ((_local_10 << 15) | (_local_10 >>> 17));
                    _local_7 = (_local_7 ^ (_local_10 * _local_9));
                    _local_7 = ((_local_7 << 13) | (_local_7 >>> 19));
                    _local_7 = ((_local_7 * 5) + -430675100);
                    _local_11 = (_local_7 ^ 0x04);
                    _local_11 = (_local_11 ^ (_local_11 >>> 16));
                    _local_11 = (_local_11 * -2048144789);
                    _local_11 = (_local_11 ^ (_local_11 >>> 13));
                    _local_11 = (_local_11 * -1028477387);
                    _local_6 = ((_local_11 ^ (_local_11 >>> 16)) & 0xFFFF);
                    _local_5 = (addr + (_local_6 * 5));
                    _local_6 = 3;
                    _local_7 = -1;
                    _local_9 = li32(_local_5 + 1);
                    if ((((_local_9 >= (0)) && (li32(_local_4) == li32(_local_9))) && ((_local_4 - _local_9) <= windowSize)))
                    {
                        _local_10 = (_local_4 + 4);
                        _local_8 = 4;
                        _local_9 = (_local_9 + 4);
                        while (((li32(_local_9) == (li32(_local_10))) && ((_local_8 + 4) <= maxMatchLength)))
                        {
                            _local_8 = (_local_8 + 4);
                            _local_9 = (_local_9 + 4);
                            _local_10 = (_local_10 + 4);
                        };
                        while (((li8(_local_9) == (li8(_local_10))) && (_local_8 < maxMatchLength)))
                        {
                            _local_8++;
                            _local_9++;
                            _local_10++;
                        };
                        _local_6 = _local_8;
                        _local_7 = _local_9;
                    };
                    _local_11 = 5;
                    _local_12 = 9;
                    while (_local_11 < _local_12)
                    {
                        _local_13 = _local_11++;
                        _local_16 = li32(_local_4);
                        si32(_local_16, hashScratchAddr);
                        _local_16 = li32(_local_4 + 4);
                        si32(_local_16, (hashScratchAddr + 4));
                        si32(0, (hashScratchAddr + _local_13));
                        _local_16 = 775236557;
                        _local_17 = -862048943;
                        _local_18 = 461845907;
                        _local_19 = (li32(hashScratchAddr) * _local_17);
                        _local_19 = ((_local_19 << 15) | (_local_19 >>> 17));
                        _local_16 = (_local_16 ^ (_local_19 * _local_18));
                        _local_16 = ((_local_16 << 13) | (_local_16 >>> 19));
                        _local_16 = ((_local_16 * 5) + -430675100);
                        _local_19 = (li32(hashScratchAddr + 4) * _local_17);
                        _local_19 = ((_local_19 << 15) | (_local_19 >>> 17));
                        _local_16 = (_local_16 ^ (_local_19 * _local_18));
                        _local_16 = ((_local_16 << 13) | (_local_16 >>> 19));
                        _local_16 = ((_local_16 * 5) + -430675100);
                        _local_20 = (_local_16 ^ _local_13);
                        _local_20 = (_local_20 ^ (_local_20 >>> 16));
                        _local_20 = (_local_20 * -2048144789);
                        _local_20 = (_local_20 ^ (_local_20 >>> 13));
                        _local_20 = (_local_20 * -1028477387);
                        _local_15 = ((_local_20 ^ (_local_20 >>> 16)) & 0xFFFF);
                        _local_14 = ((addr + (_local_15 * 5)) + 1);
                        _local_9 = li32(_local_14);
                        if (((((_local_9 >= (0)) && (li32((_local_9 + _local_6) - 3) == li32((_local_4 + _local_6) - 3))) && (li32(_local_4) == li32(_local_9))) && ((_local_4 - _local_9) <= windowSize)))
                        {
                            _local_10 = (_local_4 + 4);
                            _local_8 = 4;
                            _local_9 = (_local_9 + 4);
                            while (((li32(_local_9) == (li32(_local_10))) && ((_local_8 + 4) <= maxMatchLength)))
                            {
                                _local_8 = (_local_8 + 4);
                                _local_9 = (_local_9 + 4);
                                _local_10 = (_local_10 + 4);
                            };
                            while (((li8(_local_9) == (li8(_local_10))) && (_local_8 < maxMatchLength)))
                            {
                                _local_8++;
                                _local_9++;
                                _local_10++;
                            };
                            if (_local_8 > _local_6)
                            {
                                _local_6 = _local_8;
                                _local_7 = _local_9;
                            };
                        };
                    };
                    si32((((_local_4 - (_local_7 - _local_6)) << 16) | _local_6), resultAddr);
                    _local_6 = _local_5;
                    _local_7 = 4;
                    _local_8 = _local_4;
                    _local_9 = li8(_local_6);
                    if (((_local_9 < (8)) && (_local_9 >= 0)))
                    {
                        _local_10 = li32(_local_6 + 1);
                        si8(_local_7, _local_6);
                        si32(_local_8, (_local_6 + 1));
                        _local_7 = (_local_9 + 1);
                        _local_8 = _local_10;
                        _local_12 = li32(_local_8);
                        si32(_local_12, hashScratchAddr);
                        _local_12 = li32(_local_8 + 4);
                        si32(_local_12, (hashScratchAddr + 4));
                        si32(0, (hashScratchAddr + _local_7));
                        _local_12 = 775236557;
                        _local_13 = -862048943;
                        _local_14 = 461845907;
                        _local_15 = (li32(hashScratchAddr) * _local_13);
                        _local_15 = ((_local_15 << 15) | (_local_15 >>> 17));
                        _local_12 = (_local_12 ^ (_local_15 * _local_14));
                        _local_12 = ((_local_12 << 13) | (_local_12 >>> 19));
                        _local_12 = ((_local_12 * 5) + -430675100);
                        _local_15 = (li32(hashScratchAddr + 4) * _local_13);
                        _local_15 = ((_local_15 << 15) | (_local_15 >>> 17));
                        _local_12 = (_local_12 ^ (_local_15 * _local_14));
                        _local_12 = ((_local_12 << 13) | (_local_12 >>> 19));
                        _local_12 = ((_local_12 * 5) + -430675100);
                        _local_16 = (_local_12 ^ _local_7);
                        _local_16 = (_local_16 ^ (_local_16 >>> 16));
                        _local_16 = (_local_16 * -2048144789);
                        _local_16 = (_local_16 ^ (_local_16 >>> 13));
                        _local_16 = (_local_16 * -1028477387);
                        _local_11 = ((_local_16 ^ (_local_16 >>> 16)) & 0xFFFF);
                        _local_6 = (addr + (_local_11 * 5));
                        _local_9 = li8(_local_6);
                        if (((_local_9 < (8)) && (_local_9 >= 0)))
                        {
                            _local_10 = li32(_local_6 + 1);
                            si8(_local_7, _local_6);
                            si32(_local_8, (_local_6 + 1));
                            _local_7 = (_local_9 + 1);
                            _local_8 = _local_10;
                            _local_12 = li32(_local_8);
                            si32(_local_12, hashScratchAddr);
                            _local_12 = li32(_local_8 + 4);
                            si32(_local_12, (hashScratchAddr + 4));
                            si32(0, (hashScratchAddr + _local_7));
                            _local_12 = 775236557;
                            _local_13 = -862048943;
                            _local_14 = 461845907;
                            _local_15 = (li32(hashScratchAddr) * _local_13);
                            _local_15 = ((_local_15 << 15) | (_local_15 >>> 17));
                            _local_12 = (_local_12 ^ (_local_15 * _local_14));
                            _local_12 = ((_local_12 << 13) | (_local_12 >>> 19));
                            _local_12 = ((_local_12 * 5) + -430675100);
                            _local_15 = (li32(hashScratchAddr + 4) * _local_13);
                            _local_15 = ((_local_15 << 15) | (_local_15 >>> 17));
                            _local_12 = (_local_12 ^ (_local_15 * _local_14));
                            _local_12 = ((_local_12 << 13) | (_local_12 >>> 19));
                            _local_12 = ((_local_12 * 5) + -430675100);
                            _local_16 = (_local_12 ^ _local_7);
                            _local_16 = (_local_16 ^ (_local_16 >>> 16));
                            _local_16 = (_local_16 * -2048144789);
                            _local_16 = (_local_16 ^ (_local_16 >>> 13));
                            _local_16 = (_local_16 * -1028477387);
                            _local_11 = ((_local_16 ^ (_local_16 >>> 16)) & 0xFFFF);
                            _local_6 = (addr + (_local_11 * 5));
                            _local_9 = li8(_local_6);
                            if (((_local_9 < (8)) && (_local_9 >= 0)))
                            {
                                _local_10 = li32(_local_6 + 1);
                                si8(_local_7, _local_6);
                                si32(_local_8, (_local_6 + 1));
                                _local_7 = (_local_9 + 1);
                                _local_8 = _local_10;
                                _local_12 = li32(_local_8);
                                si32(_local_12, hashScratchAddr);
                                _local_12 = li32(_local_8 + 4);
                                si32(_local_12, (hashScratchAddr + 4));
                                si32(0, (hashScratchAddr + _local_7));
                                _local_12 = 775236557;
                                _local_13 = -862048943;
                                _local_14 = 461845907;
                                _local_15 = (li32(hashScratchAddr) * _local_13);
                                _local_15 = ((_local_15 << 15) | (_local_15 >>> 17));
                                _local_12 = (_local_12 ^ (_local_15 * _local_14));
                                _local_12 = ((_local_12 << 13) | (_local_12 >>> 19));
                                _local_12 = ((_local_12 * 5) + -430675100);
                                _local_15 = (li32(hashScratchAddr + 4) * _local_13);
                                _local_15 = ((_local_15 << 15) | (_local_15 >>> 17));
                                _local_12 = (_local_12 ^ (_local_15 * _local_14));
                                _local_12 = ((_local_12 << 13) | (_local_12 >>> 19));
                                _local_12 = ((_local_12 * 5) + -430675100);
                                _local_16 = (_local_12 ^ _local_7);
                                _local_16 = (_local_16 ^ (_local_16 >>> 16));
                                _local_16 = (_local_16 * -2048144789);
                                _local_16 = (_local_16 ^ (_local_16 >>> 13));
                                _local_16 = (_local_16 * -1028477387);
                                _local_11 = ((_local_16 ^ (_local_16 >>> 16)) & 0xFFFF);
                                _local_6 = (addr + (_local_11 * 5));
                                _local_9 = li8(_local_6);
                                if (((_local_9 < (8)) && (_local_9 >= 0)))
                                {
                                    _local_10 = li32(_local_6 + 1);
                                    si8(_local_7, _local_6);
                                    si32(_local_8, (_local_6 + 1));
                                    _local_7 = (_local_9 + 1);
                                    _local_8 = _local_10;
                                    _local_12 = li32(_local_8);
                                    si32(_local_12, hashScratchAddr);
                                    _local_12 = li32(_local_8 + 4);
                                    si32(_local_12, (hashScratchAddr + 4));
                                    si32(0, (hashScratchAddr + _local_7));
                                    _local_12 = 775236557;
                                    _local_13 = -862048943;
                                    _local_14 = 461845907;
                                    _local_15 = (li32(hashScratchAddr) * _local_13);
                                    _local_15 = ((_local_15 << 15) | (_local_15 >>> 17));
                                    _local_12 = (_local_12 ^ (_local_15 * _local_14));
                                    _local_12 = ((_local_12 << 13) | (_local_12 >>> 19));
                                    _local_12 = ((_local_12 * 5) + -430675100);
                                    _local_15 = (li32(hashScratchAddr + 4) * _local_13);
                                    _local_15 = ((_local_15 << 15) | (_local_15 >>> 17));
                                    _local_12 = (_local_12 ^ (_local_15 * _local_14));
                                    _local_12 = ((_local_12 << 13) | (_local_12 >>> 19));
                                    _local_12 = ((_local_12 * 5) + -430675100);
                                    _local_16 = (_local_12 ^ _local_7);
                                    _local_16 = (_local_16 ^ (_local_16 >>> 16));
                                    _local_16 = (_local_16 * -2048144789);
                                    _local_16 = (_local_16 ^ (_local_16 >>> 13));
                                    _local_16 = (_local_16 * -1028477387);
                                    _local_11 = ((_local_16 ^ (_local_16 >>> 16)) & 0xFFFF);
                                    _local_6 = (addr + (_local_11 * 5));
                                };
                            };
                        };
                    };
                    si8(_local_7, _local_6);
                    si32(_local_8, (_local_6 + 1));
                    resultAddr = (baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07));
                };
            };
        }

        public function unsafeInitLookahead(_arg_1:int):void
        {
            var _local_5:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_4:* = 775236557;
            _local_5 = -862048943;
            var _local_6:* = 461845907;
            _local_7 = (li32(_arg_1) * _local_5);
            _local_7 = ((_local_7 << 15) | (_local_7 >>> 17));
            _local_4 = (_local_4 ^ (_local_7 * _local_6));
            _local_4 = ((_local_4 << 13) | (_local_4 >>> 19));
            _local_4 = ((_local_4 * 5) + -430675100);
            _local_8 = (_local_4 ^ 0x04);
            _local_8 = (_local_8 ^ (_local_8 >>> 16));
            _local_8 = (_local_8 * -2048144789);
            _local_8 = (_local_8 ^ (_local_8 >>> 13));
            _local_8 = (_local_8 * -1028477387);
            var _local_3:* = ((_local_8 ^ (_local_8 >>> 16)) & 0xFFFF);
            var _local_2:* = (addr + (_local_3 * 5));
            _local_3 = 3;
            _local_4 = -1;
            _local_6 = li32(_local_2 + 1);
            if ((((_local_6 >= (0)) && (li32(_arg_1) == li32(_local_6))) && ((_arg_1 - _local_6) <= windowSize)))
            {
                _local_7 = (_arg_1 + 4);
                _local_5 = 4;
                _local_6 = (_local_6 + 4);
                while (((li32(_local_6) == (li32(_local_7))) && ((_local_5 + 4) <= maxMatchLength)))
                {
                    _local_5 = (_local_5 + 4);
                    _local_6 = (_local_6 + 4);
                    _local_7 = (_local_7 + 4);
                };
                while (((li8(_local_6) == (li8(_local_7))) && (_local_5 < maxMatchLength)))
                {
                    _local_5++;
                    _local_6++;
                    _local_7++;
                };
                _local_3 = _local_5;
                _local_4 = _local_6;
            };
            _local_8 = 5;
            _local_9 = 9;
            while (_local_8 < _local_9)
            {
                _local_10 = _local_8++;
                _local_13 = li32(_arg_1);
                si32(_local_13, hashScratchAddr);
                _local_13 = li32(_arg_1 + 4);
                si32(_local_13, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_10));
                _local_13 = 775236557;
                _local_14 = -862048943;
                _local_15 = 461845907;
                _local_16 = (li32(hashScratchAddr) * _local_14);
                _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                _local_13 = (_local_13 ^ (_local_16 * _local_15));
                _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                _local_13 = ((_local_13 * 5) + -430675100);
                _local_16 = (li32(hashScratchAddr + 4) * _local_14);
                _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                _local_13 = (_local_13 ^ (_local_16 * _local_15));
                _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                _local_13 = ((_local_13 * 5) + -430675100);
                _local_17 = (_local_13 ^ _local_10);
                _local_17 = (_local_17 ^ (_local_17 >>> 16));
                _local_17 = (_local_17 * -2048144789);
                _local_17 = (_local_17 ^ (_local_17 >>> 13));
                _local_17 = (_local_17 * -1028477387);
                _local_12 = ((_local_17 ^ (_local_17 >>> 16)) & 0xFFFF);
                _local_11 = ((addr + (_local_12 * 5)) + 1);
                _local_6 = li32(_local_11);
                if (((((_local_6 >= (0)) && (li32((_local_6 + _local_3) - 3) == li32((_arg_1 + _local_3) - 3))) && (li32(_arg_1) == li32(_local_6))) && ((_arg_1 - _local_6) <= windowSize)))
                {
                    _local_7 = (_arg_1 + 4);
                    _local_5 = 4;
                    _local_6 = (_local_6 + 4);
                    while (((li32(_local_6) == (li32(_local_7))) && ((_local_5 + 4) <= maxMatchLength)))
                    {
                        _local_5 = (_local_5 + 4);
                        _local_6 = (_local_6 + 4);
                        _local_7 = (_local_7 + 4);
                    };
                    while (((li8(_local_6) == (li8(_local_7))) && (_local_5 < maxMatchLength)))
                    {
                        _local_5++;
                        _local_6++;
                        _local_7++;
                    };
                    if (_local_5 > _local_3)
                    {
                        _local_3 = _local_5;
                        _local_4 = _local_6;
                    };
                };
            };
            si32((((_arg_1 - (_local_4 - _local_3)) << 16) | _local_3), resultAddr);
            _local_3 = _local_2;
            _local_4 = 4;
            _local_5 = _arg_1;
            _local_6 = li8(_local_3);
            if (((_local_6 < (8)) && (_local_6 >= 0)))
            {
                _local_7 = li32(_local_3 + 1);
                si8(_local_4, _local_3);
                si32(_local_5, (_local_3 + 1));
                _local_4 = (_local_6 + 1);
                _local_5 = _local_7;
                _local_9 = li32(_local_5);
                si32(_local_9, hashScratchAddr);
                _local_9 = li32(_local_5 + 4);
                si32(_local_9, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_4));
                _local_9 = 775236557;
                _local_10 = -862048943;
                _local_11 = 461845907;
                _local_12 = (li32(hashScratchAddr) * _local_10);
                _local_12 = ((_local_12 << 15) | (_local_12 >>> 17));
                _local_9 = (_local_9 ^ (_local_12 * _local_11));
                _local_9 = ((_local_9 << 13) | (_local_9 >>> 19));
                _local_9 = ((_local_9 * 5) + -430675100);
                _local_12 = (li32(hashScratchAddr + 4) * _local_10);
                _local_12 = ((_local_12 << 15) | (_local_12 >>> 17));
                _local_9 = (_local_9 ^ (_local_12 * _local_11));
                _local_9 = ((_local_9 << 13) | (_local_9 >>> 19));
                _local_9 = ((_local_9 * 5) + -430675100);
                _local_13 = (_local_9 ^ _local_4);
                _local_13 = (_local_13 ^ (_local_13 >>> 16));
                _local_13 = (_local_13 * -2048144789);
                _local_13 = (_local_13 ^ (_local_13 >>> 13));
                _local_13 = (_local_13 * -1028477387);
                _local_8 = ((_local_13 ^ (_local_13 >>> 16)) & 0xFFFF);
                _local_3 = (addr + (_local_8 * 5));
                _local_6 = li8(_local_3);
                if (((_local_6 < (8)) && (_local_6 >= 0)))
                {
                    _local_7 = li32(_local_3 + 1);
                    si8(_local_4, _local_3);
                    si32(_local_5, (_local_3 + 1));
                    _local_4 = (_local_6 + 1);
                    _local_5 = _local_7;
                    _local_9 = li32(_local_5);
                    si32(_local_9, hashScratchAddr);
                    _local_9 = li32(_local_5 + 4);
                    si32(_local_9, (hashScratchAddr + 4));
                    si32(0, (hashScratchAddr + _local_4));
                    _local_9 = 775236557;
                    _local_10 = -862048943;
                    _local_11 = 461845907;
                    _local_12 = (li32(hashScratchAddr) * _local_10);
                    _local_12 = ((_local_12 << 15) | (_local_12 >>> 17));
                    _local_9 = (_local_9 ^ (_local_12 * _local_11));
                    _local_9 = ((_local_9 << 13) | (_local_9 >>> 19));
                    _local_9 = ((_local_9 * 5) + -430675100);
                    _local_12 = (li32(hashScratchAddr + 4) * _local_10);
                    _local_12 = ((_local_12 << 15) | (_local_12 >>> 17));
                    _local_9 = (_local_9 ^ (_local_12 * _local_11));
                    _local_9 = ((_local_9 << 13) | (_local_9 >>> 19));
                    _local_9 = ((_local_9 * 5) + -430675100);
                    _local_13 = (_local_9 ^ _local_4);
                    _local_13 = (_local_13 ^ (_local_13 >>> 16));
                    _local_13 = (_local_13 * -2048144789);
                    _local_13 = (_local_13 ^ (_local_13 >>> 13));
                    _local_13 = (_local_13 * -1028477387);
                    _local_8 = ((_local_13 ^ (_local_13 >>> 16)) & 0xFFFF);
                    _local_3 = (addr + (_local_8 * 5));
                    _local_6 = li8(_local_3);
                    if (((_local_6 < (8)) && (_local_6 >= 0)))
                    {
                        _local_7 = li32(_local_3 + 1);
                        si8(_local_4, _local_3);
                        si32(_local_5, (_local_3 + 1));
                        _local_4 = (_local_6 + 1);
                        _local_5 = _local_7;
                        _local_9 = li32(_local_5);
                        si32(_local_9, hashScratchAddr);
                        _local_9 = li32(_local_5 + 4);
                        si32(_local_9, (hashScratchAddr + 4));
                        si32(0, (hashScratchAddr + _local_4));
                        _local_9 = 775236557;
                        _local_10 = -862048943;
                        _local_11 = 461845907;
                        _local_12 = (li32(hashScratchAddr) * _local_10);
                        _local_12 = ((_local_12 << 15) | (_local_12 >>> 17));
                        _local_9 = (_local_9 ^ (_local_12 * _local_11));
                        _local_9 = ((_local_9 << 13) | (_local_9 >>> 19));
                        _local_9 = ((_local_9 * 5) + -430675100);
                        _local_12 = (li32(hashScratchAddr + 4) * _local_10);
                        _local_12 = ((_local_12 << 15) | (_local_12 >>> 17));
                        _local_9 = (_local_9 ^ (_local_12 * _local_11));
                        _local_9 = ((_local_9 << 13) | (_local_9 >>> 19));
                        _local_9 = ((_local_9 * 5) + -430675100);
                        _local_13 = (_local_9 ^ _local_4);
                        _local_13 = (_local_13 ^ (_local_13 >>> 16));
                        _local_13 = (_local_13 * -2048144789);
                        _local_13 = (_local_13 ^ (_local_13 >>> 13));
                        _local_13 = (_local_13 * -1028477387);
                        _local_8 = ((_local_13 ^ (_local_13 >>> 16)) & 0xFFFF);
                        _local_3 = (addr + (_local_8 * 5));
                        _local_6 = li8(_local_3);
                        if (((_local_6 < (8)) && (_local_6 >= 0)))
                        {
                            _local_7 = li32(_local_3 + 1);
                            si8(_local_4, _local_3);
                            si32(_local_5, (_local_3 + 1));
                            _local_4 = (_local_6 + 1);
                            _local_5 = _local_7;
                            _local_9 = li32(_local_5);
                            si32(_local_9, hashScratchAddr);
                            _local_9 = li32(_local_5 + 4);
                            si32(_local_9, (hashScratchAddr + 4));
                            si32(0, (hashScratchAddr + _local_4));
                            _local_9 = 775236557;
                            _local_10 = -862048943;
                            _local_11 = 461845907;
                            _local_12 = (li32(hashScratchAddr) * _local_10);
                            _local_12 = ((_local_12 << 15) | (_local_12 >>> 17));
                            _local_9 = (_local_9 ^ (_local_12 * _local_11));
                            _local_9 = ((_local_9 << 13) | (_local_9 >>> 19));
                            _local_9 = ((_local_9 * 5) + -430675100);
                            _local_12 = (li32(hashScratchAddr + 4) * _local_10);
                            _local_12 = ((_local_12 << 15) | (_local_12 >>> 17));
                            _local_9 = (_local_9 ^ (_local_12 * _local_11));
                            _local_9 = ((_local_9 << 13) | (_local_9 >>> 19));
                            _local_9 = ((_local_9 * 5) + -430675100);
                            _local_13 = (_local_9 ^ _local_4);
                            _local_13 = (_local_13 ^ (_local_13 >>> 16));
                            _local_13 = (_local_13 * -2048144789);
                            _local_13 = (_local_13 ^ (_local_13 >>> 13));
                            _local_13 = (_local_13 * -1028477387);
                            _local_8 = ((_local_13 ^ (_local_13 >>> 16)) & 0xFFFF);
                            _local_3 = (addr + (_local_8 * 5));
                        };
                    };
                };
            };
            si8(_local_4, _local_3);
            si32(_local_5, (_local_3 + 1));
            resultAddr = (baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07));
        }

        public function setSearchResult(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            si32((((_arg_1 - (_arg_3 - _arg_2)) << 16) | _arg_2), resultAddr);
        }

        public function searchAndUpdate(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            _local_6 = 775236557;
            _local_7 = -862048943;
            _local_8 = 461845907;
            _local_9 = (li32(_arg_1 + 1) * _local_7);
            _local_9 = ((_local_9 << 15) | (_local_9 >>> 17));
            _local_6 = (_local_6 ^ (_local_9 * _local_8));
            _local_6 = ((_local_6 << 13) | (_local_6 >>> 19));
            _local_6 = ((_local_6 * 5) + -430675100);
            _local_10 = (_local_6 ^ 0x04);
            _local_10 = (_local_10 ^ (_local_10 >>> 16));
            _local_10 = (_local_10 * -2048144789);
            _local_10 = (_local_10 ^ (_local_10 >>> 13));
            _local_10 = (_local_10 * -1028477387);
            _local_5 = ((_local_10 ^ (_local_10 >>> 16)) & 0xFFFF);
            var _local_4:* = (addr + (_local_5 * 5));
            if (li16(baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07)) < (avgMatchLength + 4))
            {
                _local_5 = (_arg_1 + 1);
                _local_6 = 3;
                _local_7 = -1;
                _local_9 = li32(_local_4 + 1);
                if ((((_local_9 >= (0)) && (li32(_local_5) == li32(_local_9))) && ((_local_5 - _local_9) <= windowSize)))
                {
                    _local_10 = (_local_5 + 4);
                    _local_8 = 4;
                    _local_9 = (_local_9 + 4);
                    while (((((_local_10 + 4) <= (_arg_2)) && (li32(_local_9) == li32(_local_10))) && ((_local_8 + 4) <= maxMatchLength)))
                    {
                        _local_8 = (_local_8 + 4);
                        _local_9 = (_local_9 + 4);
                        _local_10 = (_local_10 + 4);
                    };
                    while ((((_local_10 < (_arg_2)) && (li8(_local_9) == li8(_local_10))) && (_local_8 < maxMatchLength)))
                    {
                        _local_8++;
                        _local_9++;
                        _local_10++;
                    };
                    _local_6 = _local_8;
                    _local_7 = _local_9;
                };
                _local_11 = 5;
                _local_12 = 9;
                while (_local_11 < _local_12)
                {
                    _local_13 = _local_11++;
                    _local_16 = li32(_local_5);
                    si32(_local_16, hashScratchAddr);
                    _local_16 = li32(_local_5 + 4);
                    si32(_local_16, (hashScratchAddr + 4));
                    si32(0, (hashScratchAddr + _local_13));
                    _local_16 = 775236557;
                    _local_17 = -862048943;
                    _local_18 = 461845907;
                    _local_19 = (li32(hashScratchAddr) * _local_17);
                    _local_19 = ((_local_19 << 15) | (_local_19 >>> 17));
                    _local_16 = (_local_16 ^ (_local_19 * _local_18));
                    _local_16 = ((_local_16 << 13) | (_local_16 >>> 19));
                    _local_16 = ((_local_16 * 5) + -430675100);
                    _local_19 = (li32(hashScratchAddr + 4) * _local_17);
                    _local_19 = ((_local_19 << 15) | (_local_19 >>> 17));
                    _local_16 = (_local_16 ^ (_local_19 * _local_18));
                    _local_16 = ((_local_16 << 13) | (_local_16 >>> 19));
                    _local_16 = ((_local_16 * 5) + -430675100);
                    _local_20 = (_local_16 ^ _local_13);
                    _local_20 = (_local_20 ^ (_local_20 >>> 16));
                    _local_20 = (_local_20 * -2048144789);
                    _local_20 = (_local_20 ^ (_local_20 >>> 13));
                    _local_20 = (_local_20 * -1028477387);
                    _local_15 = ((_local_20 ^ (_local_20 >>> 16)) & 0xFFFF);
                    _local_14 = ((addr + (_local_15 * 5)) + 1);
                    _local_9 = li32(_local_14);
                    if ((((_local_9 >= (0)) && (li32(_local_5) == li32(_local_9))) && ((_local_5 - _local_9) <= windowSize)))
                    {
                        _local_10 = (_local_5 + 4);
                        _local_8 = 4;
                        _local_9 = (_local_9 + 4);
                        while (((((_local_10 + 4) <= (_arg_2)) && (li32(_local_9) == li32(_local_10))) && ((_local_8 + 4) <= maxMatchLength)))
                        {
                            _local_8 = (_local_8 + 4);
                            _local_9 = (_local_9 + 4);
                            _local_10 = (_local_10 + 4);
                        };
                        while ((((_local_10 < (_arg_2)) && (li8(_local_9) == li8(_local_10))) && (_local_8 < maxMatchLength)))
                        {
                            _local_8++;
                            _local_9++;
                            _local_10++;
                        };
                        if (_local_8 > _local_6)
                        {
                            _local_6 = _local_8;
                            _local_7 = _local_9;
                        };
                    };
                };
                si32((((_local_5 - (_local_7 - _local_6)) << 16) | _local_6), resultAddr);
            }
            else
            {
                si32(0, resultAddr);
            };
            _local_5 = _local_4;
            _local_6 = 4;
            _local_7 = (_arg_1 + 1);
            _local_8 = li8(_local_5);
            if (((_local_8 < (8)) && (_local_8 >= 0)))
            {
                _local_9 = li32(_local_5 + 1);
                si8(_local_6, _local_5);
                si32(_local_7, (_local_5 + 1));
                _local_6 = (_local_8 + 1);
                _local_7 = _local_9;
                _local_11 = li32(_local_7);
                si32(_local_11, hashScratchAddr);
                _local_11 = li32(_local_7 + 4);
                si32(_local_11, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_6));
                _local_11 = 775236557;
                _local_12 = -862048943;
                _local_13 = 461845907;
                _local_14 = (li32(hashScratchAddr) * _local_12);
                _local_14 = ((_local_14 << 15) | (_local_14 >>> 17));
                _local_11 = (_local_11 ^ (_local_14 * _local_13));
                _local_11 = ((_local_11 << 13) | (_local_11 >>> 19));
                _local_11 = ((_local_11 * 5) + -430675100);
                _local_14 = (li32(hashScratchAddr + 4) * _local_12);
                _local_14 = ((_local_14 << 15) | (_local_14 >>> 17));
                _local_11 = (_local_11 ^ (_local_14 * _local_13));
                _local_11 = ((_local_11 << 13) | (_local_11 >>> 19));
                _local_11 = ((_local_11 * 5) + -430675100);
                _local_15 = (_local_11 ^ _local_6);
                _local_15 = (_local_15 ^ (_local_15 >>> 16));
                _local_15 = (_local_15 * -2048144789);
                _local_15 = (_local_15 ^ (_local_15 >>> 13));
                _local_15 = (_local_15 * -1028477387);
                _local_10 = ((_local_15 ^ (_local_15 >>> 16)) & 0xFFFF);
                _local_5 = (addr + (_local_10 * 5));
                _local_8 = li8(_local_5);
                if (((_local_8 < (8)) && (_local_8 >= 0)))
                {
                    _local_9 = li32(_local_5 + 1);
                    si8(_local_6, _local_5);
                    si32(_local_7, (_local_5 + 1));
                    _local_6 = (_local_8 + 1);
                    _local_7 = _local_9;
                    _local_11 = li32(_local_7);
                    si32(_local_11, hashScratchAddr);
                    _local_11 = li32(_local_7 + 4);
                    si32(_local_11, (hashScratchAddr + 4));
                    si32(0, (hashScratchAddr + _local_6));
                    _local_11 = 775236557;
                    _local_12 = -862048943;
                    _local_13 = 461845907;
                    _local_14 = (li32(hashScratchAddr) * _local_12);
                    _local_14 = ((_local_14 << 15) | (_local_14 >>> 17));
                    _local_11 = (_local_11 ^ (_local_14 * _local_13));
                    _local_11 = ((_local_11 << 13) | (_local_11 >>> 19));
                    _local_11 = ((_local_11 * 5) + -430675100);
                    _local_14 = (li32(hashScratchAddr + 4) * _local_12);
                    _local_14 = ((_local_14 << 15) | (_local_14 >>> 17));
                    _local_11 = (_local_11 ^ (_local_14 * _local_13));
                    _local_11 = ((_local_11 << 13) | (_local_11 >>> 19));
                    _local_11 = ((_local_11 * 5) + -430675100);
                    _local_15 = (_local_11 ^ _local_6);
                    _local_15 = (_local_15 ^ (_local_15 >>> 16));
                    _local_15 = (_local_15 * -2048144789);
                    _local_15 = (_local_15 ^ (_local_15 >>> 13));
                    _local_15 = (_local_15 * -1028477387);
                    _local_10 = ((_local_15 ^ (_local_15 >>> 16)) & 0xFFFF);
                    _local_5 = (addr + (_local_10 * 5));
                    _local_8 = li8(_local_5);
                    if (((_local_8 < (8)) && (_local_8 >= 0)))
                    {
                        _local_9 = li32(_local_5 + 1);
                        si8(_local_6, _local_5);
                        si32(_local_7, (_local_5 + 1));
                        _local_6 = (_local_8 + 1);
                        _local_7 = _local_9;
                        _local_11 = li32(_local_7);
                        si32(_local_11, hashScratchAddr);
                        _local_11 = li32(_local_7 + 4);
                        si32(_local_11, (hashScratchAddr + 4));
                        si32(0, (hashScratchAddr + _local_6));
                        _local_11 = 775236557;
                        _local_12 = -862048943;
                        _local_13 = 461845907;
                        _local_14 = (li32(hashScratchAddr) * _local_12);
                        _local_14 = ((_local_14 << 15) | (_local_14 >>> 17));
                        _local_11 = (_local_11 ^ (_local_14 * _local_13));
                        _local_11 = ((_local_11 << 13) | (_local_11 >>> 19));
                        _local_11 = ((_local_11 * 5) + -430675100);
                        _local_14 = (li32(hashScratchAddr + 4) * _local_12);
                        _local_14 = ((_local_14 << 15) | (_local_14 >>> 17));
                        _local_11 = (_local_11 ^ (_local_14 * _local_13));
                        _local_11 = ((_local_11 << 13) | (_local_11 >>> 19));
                        _local_11 = ((_local_11 * 5) + -430675100);
                        _local_15 = (_local_11 ^ _local_6);
                        _local_15 = (_local_15 ^ (_local_15 >>> 16));
                        _local_15 = (_local_15 * -2048144789);
                        _local_15 = (_local_15 ^ (_local_15 >>> 13));
                        _local_15 = (_local_15 * -1028477387);
                        _local_10 = ((_local_15 ^ (_local_15 >>> 16)) & 0xFFFF);
                        _local_5 = (addr + (_local_10 * 5));
                        _local_8 = li8(_local_5);
                        if (((_local_8 < (8)) && (_local_8 >= 0)))
                        {
                            _local_9 = li32(_local_5 + 1);
                            si8(_local_6, _local_5);
                            si32(_local_7, (_local_5 + 1));
                            _local_6 = (_local_8 + 1);
                            _local_7 = _local_9;
                            _local_11 = li32(_local_7);
                            si32(_local_11, hashScratchAddr);
                            _local_11 = li32(_local_7 + 4);
                            si32(_local_11, (hashScratchAddr + 4));
                            si32(0, (hashScratchAddr + _local_6));
                            _local_11 = 775236557;
                            _local_12 = -862048943;
                            _local_13 = 461845907;
                            _local_14 = (li32(hashScratchAddr) * _local_12);
                            _local_14 = ((_local_14 << 15) | (_local_14 >>> 17));
                            _local_11 = (_local_11 ^ (_local_14 * _local_13));
                            _local_11 = ((_local_11 << 13) | (_local_11 >>> 19));
                            _local_11 = ((_local_11 * 5) + -430675100);
                            _local_14 = (li32(hashScratchAddr + 4) * _local_12);
                            _local_14 = ((_local_14 << 15) | (_local_14 >>> 17));
                            _local_11 = (_local_11 ^ (_local_14 * _local_13));
                            _local_11 = ((_local_11 << 13) | (_local_11 >>> 19));
                            _local_11 = ((_local_11 * 5) + -430675100);
                            _local_15 = (_local_11 ^ _local_6);
                            _local_15 = (_local_15 ^ (_local_15 >>> 16));
                            _local_15 = (_local_15 * -2048144789);
                            _local_15 = (_local_15 ^ (_local_15 >>> 13));
                            _local_15 = (_local_15 * -1028477387);
                            _local_10 = ((_local_15 ^ (_local_15 >>> 16)) & 0xFFFF);
                            _local_5 = (addr + (_local_10 * 5));
                        };
                    };
                };
            };
            si8(_local_6, _local_5);
            si32(_local_7, (_local_5 + 1));
            resultAddr = (baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07));
            if (li16(resultAddr) >= 4)
            {
                _local_3 = li16(resultAddr);
                if (li16(baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07)) > _local_3)
                {
                    si32(0, resultAddr);
                }
                else
                {
                    if (((_arg_1 + _local_3) + 9) < _arg_2)
                    {
                        if (_local_3 < (avgMatchLength + 4))
                        {
                            _local_5 = ((_arg_1 + 1) + 1);
                            _local_6 = (_arg_1 + _local_3);
                            while (_local_5 < _local_6)
                            {
                                _local_7 = _local_5++;
                                _local_8 = 4;
                                _local_9 = _local_7;
                                _local_14 = 775236557;
                                _local_15 = -862048943;
                                _local_16 = 461845907;
                                _local_17 = (li32(_local_7) * _local_15);
                                _local_17 = ((_local_17 << 15) | (_local_17 >>> 17));
                                _local_14 = (_local_14 ^ (_local_17 * _local_16));
                                _local_14 = ((_local_14 << 13) | (_local_14 >>> 19));
                                _local_14 = ((_local_14 * 5) + -430675100);
                                _local_18 = (_local_14 ^ 0x04);
                                _local_18 = (_local_18 ^ (_local_18 >>> 16));
                                _local_18 = (_local_18 * -2048144789);
                                _local_18 = (_local_18 ^ (_local_18 >>> 13));
                                _local_18 = (_local_18 * -1028477387);
                                _local_13 = ((_local_18 ^ (_local_18 >>> 16)) & 0xFFFF);
                                _local_12 = (addr + (_local_13 * 5));
                                _local_10 = li8(_local_12);
                                if (((_local_10 < (8)) && (_local_10 >= 0)))
                                {
                                    _local_11 = li32(_local_12 + 1);
                                    si8(_local_8, _local_12);
                                    si32(_local_9, (_local_12 + 1));
                                    _local_8 = (_local_10 + 1);
                                    _local_9 = _local_11;
                                    _local_14 = li32(_local_9);
                                    si32(_local_14, hashScratchAddr);
                                    _local_14 = li32(_local_9 + 4);
                                    si32(_local_14, (hashScratchAddr + 4));
                                    si32(0, (hashScratchAddr + _local_8));
                                    _local_14 = 775236557;
                                    _local_15 = -862048943;
                                    _local_16 = 461845907;
                                    _local_17 = (li32(hashScratchAddr) * _local_15);
                                    _local_17 = ((_local_17 << 15) | (_local_17 >>> 17));
                                    _local_14 = (_local_14 ^ (_local_17 * _local_16));
                                    _local_14 = ((_local_14 << 13) | (_local_14 >>> 19));
                                    _local_14 = ((_local_14 * 5) + -430675100);
                                    _local_17 = (li32(hashScratchAddr + 4) * _local_15);
                                    _local_17 = ((_local_17 << 15) | (_local_17 >>> 17));
                                    _local_14 = (_local_14 ^ (_local_17 * _local_16));
                                    _local_14 = ((_local_14 << 13) | (_local_14 >>> 19));
                                    _local_14 = ((_local_14 * 5) + -430675100);
                                    _local_18 = (_local_14 ^ _local_8);
                                    _local_18 = (_local_18 ^ (_local_18 >>> 16));
                                    _local_18 = (_local_18 * -2048144789);
                                    _local_18 = (_local_18 ^ (_local_18 >>> 13));
                                    _local_18 = (_local_18 * -1028477387);
                                    _local_13 = ((_local_18 ^ (_local_18 >>> 16)) & 0xFFFF);
                                    _local_12 = (addr + (_local_13 * 5));
                                    _local_10 = li8(_local_12);
                                    if (((_local_10 < (8)) && (_local_10 >= 0)))
                                    {
                                        _local_11 = li32(_local_12 + 1);
                                        si8(_local_8, _local_12);
                                        si32(_local_9, (_local_12 + 1));
                                        _local_8 = (_local_10 + 1);
                                        _local_9 = _local_11;
                                        _local_14 = li32(_local_9);
                                        si32(_local_14, hashScratchAddr);
                                        _local_14 = li32(_local_9 + 4);
                                        si32(_local_14, (hashScratchAddr + 4));
                                        si32(0, (hashScratchAddr + _local_8));
                                        _local_14 = 775236557;
                                        _local_15 = -862048943;
                                        _local_16 = 461845907;
                                        _local_17 = (li32(hashScratchAddr) * _local_15);
                                        _local_17 = ((_local_17 << 15) | (_local_17 >>> 17));
                                        _local_14 = (_local_14 ^ (_local_17 * _local_16));
                                        _local_14 = ((_local_14 << 13) | (_local_14 >>> 19));
                                        _local_14 = ((_local_14 * 5) + -430675100);
                                        _local_17 = (li32(hashScratchAddr + 4) * _local_15);
                                        _local_17 = ((_local_17 << 15) | (_local_17 >>> 17));
                                        _local_14 = (_local_14 ^ (_local_17 * _local_16));
                                        _local_14 = ((_local_14 << 13) | (_local_14 >>> 19));
                                        _local_14 = ((_local_14 * 5) + -430675100);
                                        _local_18 = (_local_14 ^ _local_8);
                                        _local_18 = (_local_18 ^ (_local_18 >>> 16));
                                        _local_18 = (_local_18 * -2048144789);
                                        _local_18 = (_local_18 ^ (_local_18 >>> 13));
                                        _local_18 = (_local_18 * -1028477387);
                                        _local_13 = ((_local_18 ^ (_local_18 >>> 16)) & 0xFFFF);
                                        _local_12 = (addr + (_local_13 * 5));
                                    };
                                };
                                si8(_local_8, _local_12);
                                si32(_local_9, (_local_12 + 1));
                            };
                        };
                        resultAddr = (baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07));
                        _local_5 = (_arg_1 + _local_3);
                        _local_8 = 775236557;
                        _local_9 = -862048943;
                        _local_10 = 461845907;
                        _local_11 = (li32(_local_5) * _local_9);
                        _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                        _local_8 = (_local_8 ^ (_local_11 * _local_10));
                        _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                        _local_8 = ((_local_8 * 5) + -430675100);
                        _local_12 = (_local_8 ^ 0x04);
                        _local_12 = (_local_12 ^ (_local_12 >>> 16));
                        _local_12 = (_local_12 * -2048144789);
                        _local_12 = (_local_12 ^ (_local_12 >>> 13));
                        _local_12 = (_local_12 * -1028477387);
                        _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                        _local_6 = (addr + (_local_7 * 5));
                        _local_7 = 3;
                        _local_8 = -1;
                        _local_10 = li32(_local_6 + 1);
                        if ((((_local_10 >= (0)) && (li32(_local_5) == li32(_local_10))) && ((_local_5 - _local_10) <= windowSize)))
                        {
                            _local_11 = (_local_5 + 4);
                            _local_9 = 4;
                            _local_10 = (_local_10 + 4);
                            while (((((_local_11 + 4) <= (_arg_2)) && (li32(_local_10) == li32(_local_11))) && ((_local_9 + 4) <= maxMatchLength)))
                            {
                                _local_9 = (_local_9 + 4);
                                _local_10 = (_local_10 + 4);
                                _local_11 = (_local_11 + 4);
                            };
                            while ((((_local_11 < (_arg_2)) && (li8(_local_10) == li8(_local_11))) && (_local_9 < maxMatchLength)))
                            {
                                _local_9++;
                                _local_10++;
                                _local_11++;
                            };
                            _local_7 = _local_9;
                            _local_8 = _local_10;
                        };
                        _local_12 = 5;
                        _local_13 = 9;
                        while (_local_12 < _local_13)
                        {
                            _local_14 = _local_12++;
                            _local_17 = li32(_local_5);
                            si32(_local_17, hashScratchAddr);
                            _local_17 = li32(_local_5 + 4);
                            si32(_local_17, (hashScratchAddr + 4));
                            si32(0, (hashScratchAddr + _local_14));
                            _local_17 = 775236557;
                            _local_18 = -862048943;
                            _local_19 = 461845907;
                            _local_20 = (li32(hashScratchAddr) * _local_18);
                            _local_20 = ((_local_20 << 15) | (_local_20 >>> 17));
                            _local_17 = (_local_17 ^ (_local_20 * _local_19));
                            _local_17 = ((_local_17 << 13) | (_local_17 >>> 19));
                            _local_17 = ((_local_17 * 5) + -430675100);
                            _local_20 = (li32(hashScratchAddr + 4) * _local_18);
                            _local_20 = ((_local_20 << 15) | (_local_20 >>> 17));
                            _local_17 = (_local_17 ^ (_local_20 * _local_19));
                            _local_17 = ((_local_17 << 13) | (_local_17 >>> 19));
                            _local_17 = ((_local_17 * 5) + -430675100);
                            _local_21 = (_local_17 ^ _local_14);
                            _local_21 = (_local_21 ^ (_local_21 >>> 16));
                            _local_21 = (_local_21 * -2048144789);
                            _local_21 = (_local_21 ^ (_local_21 >>> 13));
                            _local_21 = (_local_21 * -1028477387);
                            _local_16 = ((_local_21 ^ (_local_21 >>> 16)) & 0xFFFF);
                            _local_15 = ((addr + (_local_16 * 5)) + 1);
                            _local_10 = li32(_local_15);
                            if ((((_local_10 >= (0)) && (li32(_local_5) == li32(_local_10))) && ((_local_5 - _local_10) <= windowSize)))
                            {
                                _local_11 = (_local_5 + 4);
                                _local_9 = 4;
                                _local_10 = (_local_10 + 4);
                                while (((((_local_11 + 4) <= (_arg_2)) && (li32(_local_10) == li32(_local_11))) && ((_local_9 + 4) <= maxMatchLength)))
                                {
                                    _local_9 = (_local_9 + 4);
                                    _local_10 = (_local_10 + 4);
                                    _local_11 = (_local_11 + 4);
                                };
                                while ((((_local_11 < (_arg_2)) && (li8(_local_10) == li8(_local_11))) && (_local_9 < maxMatchLength)))
                                {
                                    _local_9++;
                                    _local_10++;
                                    _local_11++;
                                };
                                if (_local_9 > _local_7)
                                {
                                    _local_7 = _local_9;
                                    _local_8 = _local_10;
                                };
                            };
                        };
                        si32((((_local_5 - (_local_8 - _local_7)) << 16) | _local_7), resultAddr);
                        _local_7 = _local_6;
                        _local_8 = 4;
                        _local_9 = _local_5;
                        _local_10 = li8(_local_7);
                        if (((_local_10 < (8)) && (_local_10 >= 0)))
                        {
                            _local_11 = li32(_local_7 + 1);
                            si8(_local_8, _local_7);
                            si32(_local_9, (_local_7 + 1));
                            _local_8 = (_local_10 + 1);
                            _local_9 = _local_11;
                            _local_13 = li32(_local_9);
                            si32(_local_13, hashScratchAddr);
                            _local_13 = li32(_local_9 + 4);
                            si32(_local_13, (hashScratchAddr + 4));
                            si32(0, (hashScratchAddr + _local_8));
                            _local_13 = 775236557;
                            _local_14 = -862048943;
                            _local_15 = 461845907;
                            _local_16 = (li32(hashScratchAddr) * _local_14);
                            _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                            _local_13 = (_local_13 ^ (_local_16 * _local_15));
                            _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                            _local_13 = ((_local_13 * 5) + -430675100);
                            _local_16 = (li32(hashScratchAddr + 4) * _local_14);
                            _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                            _local_13 = (_local_13 ^ (_local_16 * _local_15));
                            _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                            _local_13 = ((_local_13 * 5) + -430675100);
                            _local_17 = (_local_13 ^ _local_8);
                            _local_17 = (_local_17 ^ (_local_17 >>> 16));
                            _local_17 = (_local_17 * -2048144789);
                            _local_17 = (_local_17 ^ (_local_17 >>> 13));
                            _local_17 = (_local_17 * -1028477387);
                            _local_12 = ((_local_17 ^ (_local_17 >>> 16)) & 0xFFFF);
                            _local_7 = (addr + (_local_12 * 5));
                            _local_10 = li8(_local_7);
                            if (((_local_10 < (8)) && (_local_10 >= 0)))
                            {
                                _local_11 = li32(_local_7 + 1);
                                si8(_local_8, _local_7);
                                si32(_local_9, (_local_7 + 1));
                                _local_8 = (_local_10 + 1);
                                _local_9 = _local_11;
                                _local_13 = li32(_local_9);
                                si32(_local_13, hashScratchAddr);
                                _local_13 = li32(_local_9 + 4);
                                si32(_local_13, (hashScratchAddr + 4));
                                si32(0, (hashScratchAddr + _local_8));
                                _local_13 = 775236557;
                                _local_14 = -862048943;
                                _local_15 = 461845907;
                                _local_16 = (li32(hashScratchAddr) * _local_14);
                                _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                                _local_13 = (_local_13 ^ (_local_16 * _local_15));
                                _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                                _local_13 = ((_local_13 * 5) + -430675100);
                                _local_16 = (li32(hashScratchAddr + 4) * _local_14);
                                _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                                _local_13 = (_local_13 ^ (_local_16 * _local_15));
                                _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                                _local_13 = ((_local_13 * 5) + -430675100);
                                _local_17 = (_local_13 ^ _local_8);
                                _local_17 = (_local_17 ^ (_local_17 >>> 16));
                                _local_17 = (_local_17 * -2048144789);
                                _local_17 = (_local_17 ^ (_local_17 >>> 13));
                                _local_17 = (_local_17 * -1028477387);
                                _local_12 = ((_local_17 ^ (_local_17 >>> 16)) & 0xFFFF);
                                _local_7 = (addr + (_local_12 * 5));
                                _local_10 = li8(_local_7);
                                if (((_local_10 < (8)) && (_local_10 >= 0)))
                                {
                                    _local_11 = li32(_local_7 + 1);
                                    si8(_local_8, _local_7);
                                    si32(_local_9, (_local_7 + 1));
                                    _local_8 = (_local_10 + 1);
                                    _local_9 = _local_11;
                                    _local_13 = li32(_local_9);
                                    si32(_local_13, hashScratchAddr);
                                    _local_13 = li32(_local_9 + 4);
                                    si32(_local_13, (hashScratchAddr + 4));
                                    si32(0, (hashScratchAddr + _local_8));
                                    _local_13 = 775236557;
                                    _local_14 = -862048943;
                                    _local_15 = 461845907;
                                    _local_16 = (li32(hashScratchAddr) * _local_14);
                                    _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                                    _local_13 = (_local_13 ^ (_local_16 * _local_15));
                                    _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                                    _local_13 = ((_local_13 * 5) + -430675100);
                                    _local_16 = (li32(hashScratchAddr + 4) * _local_14);
                                    _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                                    _local_13 = (_local_13 ^ (_local_16 * _local_15));
                                    _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                                    _local_13 = ((_local_13 * 5) + -430675100);
                                    _local_17 = (_local_13 ^ _local_8);
                                    _local_17 = (_local_17 ^ (_local_17 >>> 16));
                                    _local_17 = (_local_17 * -2048144789);
                                    _local_17 = (_local_17 ^ (_local_17 >>> 13));
                                    _local_17 = (_local_17 * -1028477387);
                                    _local_12 = ((_local_17 ^ (_local_17 >>> 16)) & 0xFFFF);
                                    _local_7 = (addr + (_local_12 * 5));
                                    _local_10 = li8(_local_7);
                                    if (((_local_10 < (8)) && (_local_10 >= 0)))
                                    {
                                        _local_11 = li32(_local_7 + 1);
                                        si8(_local_8, _local_7);
                                        si32(_local_9, (_local_7 + 1));
                                        _local_8 = (_local_10 + 1);
                                        _local_9 = _local_11;
                                        _local_13 = li32(_local_9);
                                        si32(_local_13, hashScratchAddr);
                                        _local_13 = li32(_local_9 + 4);
                                        si32(_local_13, (hashScratchAddr + 4));
                                        si32(0, (hashScratchAddr + _local_8));
                                        _local_13 = 775236557;
                                        _local_14 = -862048943;
                                        _local_15 = 461845907;
                                        _local_16 = (li32(hashScratchAddr) * _local_14);
                                        _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                                        _local_13 = (_local_13 ^ (_local_16 * _local_15));
                                        _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                                        _local_13 = ((_local_13 * 5) + -430675100);
                                        _local_16 = (li32(hashScratchAddr + 4) * _local_14);
                                        _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                                        _local_13 = (_local_13 ^ (_local_16 * _local_15));
                                        _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                                        _local_13 = ((_local_13 * 5) + -430675100);
                                        _local_17 = (_local_13 ^ _local_8);
                                        _local_17 = (_local_17 ^ (_local_17 >>> 16));
                                        _local_17 = (_local_17 * -2048144789);
                                        _local_17 = (_local_17 ^ (_local_17 >>> 13));
                                        _local_17 = (_local_17 * -1028477387);
                                        _local_12 = ((_local_17 ^ (_local_17 >>> 16)) & 0xFFFF);
                                        _local_7 = (addr + (_local_12 * 5));
                                    };
                                };
                            };
                        };
                        si8(_local_8, _local_7);
                        si32(_local_9, (_local_7 + 1));
                        resultAddr = (baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07));
                    };
                };
            };
        }

        public function nextResultAddr(_arg_1:int):int
        {
            return (baseResultAddr + (((_arg_1 - baseResultAddr) + 4) & 0x07));
        }

        public function initLookahead(_arg_1:int, _arg_2:int):void
        {
            var _local_6:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_5:* = 775236557;
            _local_6 = -862048943;
            var _local_7:* = 461845907;
            _local_8 = (li32(_arg_1) * _local_6);
            _local_8 = ((_local_8 << 15) | (_local_8 >>> 17));
            _local_5 = (_local_5 ^ (_local_8 * _local_7));
            _local_5 = ((_local_5 << 13) | (_local_5 >>> 19));
            _local_5 = ((_local_5 * 5) + -430675100);
            _local_9 = (_local_5 ^ 0x04);
            _local_9 = (_local_9 ^ (_local_9 >>> 16));
            _local_9 = (_local_9 * -2048144789);
            _local_9 = (_local_9 ^ (_local_9 >>> 13));
            _local_9 = (_local_9 * -1028477387);
            var _local_4:* = ((_local_9 ^ (_local_9 >>> 16)) & 0xFFFF);
            var _local_3:* = (addr + (_local_4 * 5));
            _local_4 = 3;
            _local_5 = -1;
            _local_7 = li32(_local_3 + 1);
            if ((((_local_7 >= (0)) && (li32(_arg_1) == li32(_local_7))) && ((_arg_1 - _local_7) <= windowSize)))
            {
                _local_8 = (_arg_1 + 4);
                _local_6 = 4;
                _local_7 = (_local_7 + 4);
                while (((((_local_8 + 4) <= (_arg_2)) && (li32(_local_7) == li32(_local_8))) && ((_local_6 + 4) <= maxMatchLength)))
                {
                    _local_6 = (_local_6 + 4);
                    _local_7 = (_local_7 + 4);
                    _local_8 = (_local_8 + 4);
                };
                while ((((_local_8 < (_arg_2)) && (li8(_local_7) == li8(_local_8))) && (_local_6 < maxMatchLength)))
                {
                    _local_6++;
                    _local_7++;
                    _local_8++;
                };
                _local_4 = _local_6;
                _local_5 = _local_7;
            };
            _local_9 = 5;
            _local_10 = 9;
            while (_local_9 < _local_10)
            {
                _local_11 = _local_9++;
                _local_14 = li32(_arg_1);
                si32(_local_14, hashScratchAddr);
                _local_14 = li32(_arg_1 + 4);
                si32(_local_14, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_11));
                _local_14 = 775236557;
                _local_15 = -862048943;
                _local_16 = 461845907;
                _local_17 = (li32(hashScratchAddr) * _local_15);
                _local_17 = ((_local_17 << 15) | (_local_17 >>> 17));
                _local_14 = (_local_14 ^ (_local_17 * _local_16));
                _local_14 = ((_local_14 << 13) | (_local_14 >>> 19));
                _local_14 = ((_local_14 * 5) + -430675100);
                _local_17 = (li32(hashScratchAddr + 4) * _local_15);
                _local_17 = ((_local_17 << 15) | (_local_17 >>> 17));
                _local_14 = (_local_14 ^ (_local_17 * _local_16));
                _local_14 = ((_local_14 << 13) | (_local_14 >>> 19));
                _local_14 = ((_local_14 * 5) + -430675100);
                _local_18 = (_local_14 ^ _local_11);
                _local_18 = (_local_18 ^ (_local_18 >>> 16));
                _local_18 = (_local_18 * -2048144789);
                _local_18 = (_local_18 ^ (_local_18 >>> 13));
                _local_18 = (_local_18 * -1028477387);
                _local_13 = ((_local_18 ^ (_local_18 >>> 16)) & 0xFFFF);
                _local_12 = ((addr + (_local_13 * 5)) + 1);
                _local_7 = li32(_local_12);
                if ((((_local_7 >= (0)) && (li32(_arg_1) == li32(_local_7))) && ((_arg_1 - _local_7) <= windowSize)))
                {
                    _local_8 = (_arg_1 + 4);
                    _local_6 = 4;
                    _local_7 = (_local_7 + 4);
                    while (((((_local_8 + 4) <= (_arg_2)) && (li32(_local_7) == li32(_local_8))) && ((_local_6 + 4) <= maxMatchLength)))
                    {
                        _local_6 = (_local_6 + 4);
                        _local_7 = (_local_7 + 4);
                        _local_8 = (_local_8 + 4);
                    };
                    while ((((_local_8 < (_arg_2)) && (li8(_local_7) == li8(_local_8))) && (_local_6 < maxMatchLength)))
                    {
                        _local_6++;
                        _local_7++;
                        _local_8++;
                    };
                    if (_local_6 > _local_4)
                    {
                        _local_4 = _local_6;
                        _local_5 = _local_7;
                    };
                };
            };
            si32((((_arg_1 - (_local_5 - _local_4)) << 16) | _local_4), resultAddr);
            _local_4 = _local_3;
            _local_5 = 4;
            _local_6 = _arg_1;
            _local_7 = li8(_local_4);
            if (((_local_7 < (8)) && (_local_7 >= 0)))
            {
                _local_8 = li32(_local_4 + 1);
                si8(_local_5, _local_4);
                si32(_local_6, (_local_4 + 1));
                _local_5 = (_local_7 + 1);
                _local_6 = _local_8;
                _local_10 = li32(_local_6);
                si32(_local_10, hashScratchAddr);
                _local_10 = li32(_local_6 + 4);
                si32(_local_10, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_5));
                _local_10 = 775236557;
                _local_11 = -862048943;
                _local_12 = 461845907;
                _local_13 = (li32(hashScratchAddr) * _local_11);
                _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                _local_10 = (_local_10 ^ (_local_13 * _local_12));
                _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                _local_10 = ((_local_10 * 5) + -430675100);
                _local_13 = (li32(hashScratchAddr + 4) * _local_11);
                _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                _local_10 = (_local_10 ^ (_local_13 * _local_12));
                _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                _local_10 = ((_local_10 * 5) + -430675100);
                _local_14 = (_local_10 ^ _local_5);
                _local_14 = (_local_14 ^ (_local_14 >>> 16));
                _local_14 = (_local_14 * -2048144789);
                _local_14 = (_local_14 ^ (_local_14 >>> 13));
                _local_14 = (_local_14 * -1028477387);
                _local_9 = ((_local_14 ^ (_local_14 >>> 16)) & 0xFFFF);
                _local_4 = (addr + (_local_9 * 5));
                _local_7 = li8(_local_4);
                if (((_local_7 < (8)) && (_local_7 >= 0)))
                {
                    _local_8 = li32(_local_4 + 1);
                    si8(_local_5, _local_4);
                    si32(_local_6, (_local_4 + 1));
                    _local_5 = (_local_7 + 1);
                    _local_6 = _local_8;
                    _local_10 = li32(_local_6);
                    si32(_local_10, hashScratchAddr);
                    _local_10 = li32(_local_6 + 4);
                    si32(_local_10, (hashScratchAddr + 4));
                    si32(0, (hashScratchAddr + _local_5));
                    _local_10 = 775236557;
                    _local_11 = -862048943;
                    _local_12 = 461845907;
                    _local_13 = (li32(hashScratchAddr) * _local_11);
                    _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                    _local_10 = (_local_10 ^ (_local_13 * _local_12));
                    _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                    _local_10 = ((_local_10 * 5) + -430675100);
                    _local_13 = (li32(hashScratchAddr + 4) * _local_11);
                    _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                    _local_10 = (_local_10 ^ (_local_13 * _local_12));
                    _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                    _local_10 = ((_local_10 * 5) + -430675100);
                    _local_14 = (_local_10 ^ _local_5);
                    _local_14 = (_local_14 ^ (_local_14 >>> 16));
                    _local_14 = (_local_14 * -2048144789);
                    _local_14 = (_local_14 ^ (_local_14 >>> 13));
                    _local_14 = (_local_14 * -1028477387);
                    _local_9 = ((_local_14 ^ (_local_14 >>> 16)) & 0xFFFF);
                    _local_4 = (addr + (_local_9 * 5));
                    _local_7 = li8(_local_4);
                    if (((_local_7 < (8)) && (_local_7 >= 0)))
                    {
                        _local_8 = li32(_local_4 + 1);
                        si8(_local_5, _local_4);
                        si32(_local_6, (_local_4 + 1));
                        _local_5 = (_local_7 + 1);
                        _local_6 = _local_8;
                        _local_10 = li32(_local_6);
                        si32(_local_10, hashScratchAddr);
                        _local_10 = li32(_local_6 + 4);
                        si32(_local_10, (hashScratchAddr + 4));
                        si32(0, (hashScratchAddr + _local_5));
                        _local_10 = 775236557;
                        _local_11 = -862048943;
                        _local_12 = 461845907;
                        _local_13 = (li32(hashScratchAddr) * _local_11);
                        _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                        _local_10 = (_local_10 ^ (_local_13 * _local_12));
                        _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                        _local_10 = ((_local_10 * 5) + -430675100);
                        _local_13 = (li32(hashScratchAddr + 4) * _local_11);
                        _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                        _local_10 = (_local_10 ^ (_local_13 * _local_12));
                        _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                        _local_10 = ((_local_10 * 5) + -430675100);
                        _local_14 = (_local_10 ^ _local_5);
                        _local_14 = (_local_14 ^ (_local_14 >>> 16));
                        _local_14 = (_local_14 * -2048144789);
                        _local_14 = (_local_14 ^ (_local_14 >>> 13));
                        _local_14 = (_local_14 * -1028477387);
                        _local_9 = ((_local_14 ^ (_local_14 >>> 16)) & 0xFFFF);
                        _local_4 = (addr + (_local_9 * 5));
                        _local_7 = li8(_local_4);
                        if (((_local_7 < (8)) && (_local_7 >= 0)))
                        {
                            _local_8 = li32(_local_4 + 1);
                            si8(_local_5, _local_4);
                            si32(_local_6, (_local_4 + 1));
                            _local_5 = (_local_7 + 1);
                            _local_6 = _local_8;
                            _local_10 = li32(_local_6);
                            si32(_local_10, hashScratchAddr);
                            _local_10 = li32(_local_6 + 4);
                            si32(_local_10, (hashScratchAddr + 4));
                            si32(0, (hashScratchAddr + _local_5));
                            _local_10 = 775236557;
                            _local_11 = -862048943;
                            _local_12 = 461845907;
                            _local_13 = (li32(hashScratchAddr) * _local_11);
                            _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                            _local_10 = (_local_10 ^ (_local_13 * _local_12));
                            _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                            _local_10 = ((_local_10 * 5) + -430675100);
                            _local_13 = (li32(hashScratchAddr + 4) * _local_11);
                            _local_13 = ((_local_13 << 15) | (_local_13 >>> 17));
                            _local_10 = (_local_10 ^ (_local_13 * _local_12));
                            _local_10 = ((_local_10 << 13) | (_local_10 >>> 19));
                            _local_10 = ((_local_10 * 5) + -430675100);
                            _local_14 = (_local_10 ^ _local_5);
                            _local_14 = (_local_14 ^ (_local_14 >>> 16));
                            _local_14 = (_local_14 * -2048144789);
                            _local_14 = (_local_14 ^ (_local_14 >>> 13));
                            _local_14 = (_local_14 * -1028477387);
                            _local_9 = ((_local_14 ^ (_local_14 >>> 16)) & 0xFFFF);
                            _local_4 = (addr + (_local_9 * 5));
                        };
                    };
                };
            };
            si8(_local_5, _local_4);
            si32(_local_6, (_local_4 + 1));
            resultAddr = (baseResultAddr + (((resultAddr - baseResultAddr) + 4) & 0x07));
        }

        public function hash(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int = li32(_arg_1);
            si32(_local_4, hashScratchAddr);
            _local_4 = li32(_arg_1 + 4);
            si32(_local_4, (hashScratchAddr + 4));
            si32(0, (hashScratchAddr + _arg_2));
            _local_4 = 775236557;
            var _local_5:* = -862048943;
            var _local_6:* = 461845907;
            var _local_7:* = (li32(hashScratchAddr) * _local_5);
            _local_7 = ((_local_7 << 15) | (_local_7 >>> 17));
            _local_4 = (_local_4 ^ (_local_7 * _local_6));
            _local_4 = ((_local_4 << 13) | (_local_4 >>> 19));
            _local_4 = ((_local_4 * 5) + -430675100);
            _local_7 = (li32(hashScratchAddr + 4) * _local_5);
            _local_7 = ((_local_7 << 15) | (_local_7 >>> 17));
            _local_4 = (_local_4 ^ (_local_7 * _local_6));
            _local_4 = ((_local_4 << 13) | (_local_4 >>> 19));
            _local_4 = ((_local_4 * 5) + -430675100);
            var _local_8:* = (_local_4 ^ _arg_2);
            _local_8 = (_local_8 ^ (_local_8 >>> 16));
            _local_8 = (_local_8 * -2048144789);
            _local_8 = (_local_8 ^ (_local_8 >>> 13));
            _local_8 = (_local_8 * -1028477387);
            return ((_local_8 ^ (_local_8 >>> 16)) & _arg_3);
        }

        public function fastUpdate(_arg_1:int):void
        {
            var _local_5:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_2:int = 4;
            var _local_3:int = _arg_1;
            _local_8 = 775236557;
            _local_9 = -862048943;
            _local_10 = 461845907;
            _local_11 = (li32(_arg_1) * _local_9);
            _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
            _local_8 = (_local_8 ^ (_local_11 * _local_10));
            _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
            _local_8 = ((_local_8 * 5) + -430675100);
            _local_12 = (_local_8 ^ 0x04);
            _local_12 = (_local_12 ^ (_local_12 >>> 16));
            _local_12 = (_local_12 * -2048144789);
            _local_12 = (_local_12 ^ (_local_12 >>> 13));
            _local_12 = (_local_12 * -1028477387);
            _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
            var _local_6:* = (addr + (_local_7 * 5));
            var _local_4:int = li8(_local_6);
            if (((_local_4 < (8)) && (_local_4 >= 0)))
            {
                _local_5 = li32(_local_6 + 1);
                si8(_local_2, _local_6);
                si32(_local_3, (_local_6 + 1));
                _local_2 = (_local_4 + 1);
                _local_3 = _local_5;
                _local_8 = li32(_local_3);
                si32(_local_8, hashScratchAddr);
                _local_8 = li32(_local_3 + 4);
                si32(_local_8, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_2));
                _local_8 = 775236557;
                _local_9 = -862048943;
                _local_10 = 461845907;
                _local_11 = (li32(hashScratchAddr) * _local_9);
                _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                _local_8 = (_local_8 ^ (_local_11 * _local_10));
                _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                _local_8 = ((_local_8 * 5) + -430675100);
                _local_11 = (li32(hashScratchAddr + 4) * _local_9);
                _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                _local_8 = (_local_8 ^ (_local_11 * _local_10));
                _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                _local_8 = ((_local_8 * 5) + -430675100);
                _local_12 = (_local_8 ^ _local_2);
                _local_12 = (_local_12 ^ (_local_12 >>> 16));
                _local_12 = (_local_12 * -2048144789);
                _local_12 = (_local_12 ^ (_local_12 >>> 13));
                _local_12 = (_local_12 * -1028477387);
                _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                _local_6 = (addr + (_local_7 * 5));
                _local_4 = li8(_local_6);
                if (((_local_4 < (8)) && (_local_4 >= 0)))
                {
                    _local_5 = li32(_local_6 + 1);
                    si8(_local_2, _local_6);
                    si32(_local_3, (_local_6 + 1));
                    _local_2 = (_local_4 + 1);
                    _local_3 = _local_5;
                    _local_8 = li32(_local_3);
                    si32(_local_8, hashScratchAddr);
                    _local_8 = li32(_local_3 + 4);
                    si32(_local_8, (hashScratchAddr + 4));
                    si32(0, (hashScratchAddr + _local_2));
                    _local_8 = 775236557;
                    _local_9 = -862048943;
                    _local_10 = 461845907;
                    _local_11 = (li32(hashScratchAddr) * _local_9);
                    _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                    _local_8 = (_local_8 ^ (_local_11 * _local_10));
                    _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                    _local_8 = ((_local_8 * 5) + -430675100);
                    _local_11 = (li32(hashScratchAddr + 4) * _local_9);
                    _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                    _local_8 = (_local_8 ^ (_local_11 * _local_10));
                    _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                    _local_8 = ((_local_8 * 5) + -430675100);
                    _local_12 = (_local_8 ^ _local_2);
                    _local_12 = (_local_12 ^ (_local_12 >>> 16));
                    _local_12 = (_local_12 * -2048144789);
                    _local_12 = (_local_12 ^ (_local_12 >>> 13));
                    _local_12 = (_local_12 * -1028477387);
                    _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                    _local_6 = (addr + (_local_7 * 5));
                };
            };
            si8(_local_2, _local_6);
            si32(_local_3, (_local_6 + 1));
        }

        public function clearTable():void
        {
            var _local_1:int = addr;
            var _local_2:* = (addr + 0x50000);
            while (_local_1 < _local_2)
            {
                si32(-1, _local_1);
                si32(-1, (_local_1 + 4));
                si32(-1, (_local_1 + 8));
                si32(-1, (_local_1 + 12));
                si32(-1, (_local_1 + 16));
                si32(-1, (_local_1 + 20));
                si32(-1, (_local_1 + 24));
                si32(-1, (_local_1 + 28));
                _local_1 = (_local_1 + 32);
            };
        }

        public function calcHashOffset(_arg_1:int):int
        {
            return (addr + (_arg_1 * 5));
        }

        public function _update(_arg_1:int, _arg_2:int):void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_3:int = 4;
            var _local_4:int = _arg_1;
            var _local_5:int = li8(_arg_2);
            if (((_local_5 < (8)) && (_local_5 >= 0)))
            {
                _local_6 = li32(_arg_2 + 1);
                si8(_local_3, _arg_2);
                si32(_local_4, (_arg_2 + 1));
                _local_3 = (_local_5 + 1);
                _local_4 = _local_6;
                _local_8 = li32(_local_4);
                si32(_local_8, hashScratchAddr);
                _local_8 = li32(_local_4 + 4);
                si32(_local_8, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_3));
                _local_8 = 775236557;
                _local_9 = -862048943;
                _local_10 = 461845907;
                _local_11 = (li32(hashScratchAddr) * _local_9);
                _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                _local_8 = (_local_8 ^ (_local_11 * _local_10));
                _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                _local_8 = ((_local_8 * 5) + -430675100);
                _local_11 = (li32(hashScratchAddr + 4) * _local_9);
                _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                _local_8 = (_local_8 ^ (_local_11 * _local_10));
                _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                _local_8 = ((_local_8 * 5) + -430675100);
                _local_12 = (_local_8 ^ _local_3);
                _local_12 = (_local_12 ^ (_local_12 >>> 16));
                _local_12 = (_local_12 * -2048144789);
                _local_12 = (_local_12 ^ (_local_12 >>> 13));
                _local_12 = (_local_12 * -1028477387);
                _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                _arg_2 = (addr + (_local_7 * 5));
                _local_5 = li8(_arg_2);
                if (((_local_5 < (8)) && (_local_5 >= 0)))
                {
                    _local_6 = li32(_arg_2 + 1);
                    si8(_local_3, _arg_2);
                    si32(_local_4, (_arg_2 + 1));
                    _local_3 = (_local_5 + 1);
                    _local_4 = _local_6;
                    _local_8 = li32(_local_4);
                    si32(_local_8, hashScratchAddr);
                    _local_8 = li32(_local_4 + 4);
                    si32(_local_8, (hashScratchAddr + 4));
                    si32(0, (hashScratchAddr + _local_3));
                    _local_8 = 775236557;
                    _local_9 = -862048943;
                    _local_10 = 461845907;
                    _local_11 = (li32(hashScratchAddr) * _local_9);
                    _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                    _local_8 = (_local_8 ^ (_local_11 * _local_10));
                    _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                    _local_8 = ((_local_8 * 5) + -430675100);
                    _local_11 = (li32(hashScratchAddr + 4) * _local_9);
                    _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                    _local_8 = (_local_8 ^ (_local_11 * _local_10));
                    _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                    _local_8 = ((_local_8 * 5) + -430675100);
                    _local_12 = (_local_8 ^ _local_3);
                    _local_12 = (_local_12 ^ (_local_12 >>> 16));
                    _local_12 = (_local_12 * -2048144789);
                    _local_12 = (_local_12 ^ (_local_12 >>> 13));
                    _local_12 = (_local_12 * -1028477387);
                    _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                    _arg_2 = (addr + (_local_7 * 5));
                    _local_5 = li8(_arg_2);
                    if (((_local_5 < (8)) && (_local_5 >= 0)))
                    {
                        _local_6 = li32(_arg_2 + 1);
                        si8(_local_3, _arg_2);
                        si32(_local_4, (_arg_2 + 1));
                        _local_3 = (_local_5 + 1);
                        _local_4 = _local_6;
                        _local_8 = li32(_local_4);
                        si32(_local_8, hashScratchAddr);
                        _local_8 = li32(_local_4 + 4);
                        si32(_local_8, (hashScratchAddr + 4));
                        si32(0, (hashScratchAddr + _local_3));
                        _local_8 = 775236557;
                        _local_9 = -862048943;
                        _local_10 = 461845907;
                        _local_11 = (li32(hashScratchAddr) * _local_9);
                        _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                        _local_8 = (_local_8 ^ (_local_11 * _local_10));
                        _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                        _local_8 = ((_local_8 * 5) + -430675100);
                        _local_11 = (li32(hashScratchAddr + 4) * _local_9);
                        _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                        _local_8 = (_local_8 ^ (_local_11 * _local_10));
                        _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                        _local_8 = ((_local_8 * 5) + -430675100);
                        _local_12 = (_local_8 ^ _local_3);
                        _local_12 = (_local_12 ^ (_local_12 >>> 16));
                        _local_12 = (_local_12 * -2048144789);
                        _local_12 = (_local_12 ^ (_local_12 >>> 13));
                        _local_12 = (_local_12 * -1028477387);
                        _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                        _arg_2 = (addr + (_local_7 * 5));
                        _local_5 = li8(_arg_2);
                        if (((_local_5 < (8)) && (_local_5 >= 0)))
                        {
                            _local_6 = li32(_arg_2 + 1);
                            si8(_local_3, _arg_2);
                            si32(_local_4, (_arg_2 + 1));
                            _local_3 = (_local_5 + 1);
                            _local_4 = _local_6;
                            _local_8 = li32(_local_4);
                            si32(_local_8, hashScratchAddr);
                            _local_8 = li32(_local_4 + 4);
                            si32(_local_8, (hashScratchAddr + 4));
                            si32(0, (hashScratchAddr + _local_3));
                            _local_8 = 775236557;
                            _local_9 = -862048943;
                            _local_10 = 461845907;
                            _local_11 = (li32(hashScratchAddr) * _local_9);
                            _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                            _local_8 = (_local_8 ^ (_local_11 * _local_10));
                            _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                            _local_8 = ((_local_8 * 5) + -430675100);
                            _local_11 = (li32(hashScratchAddr + 4) * _local_9);
                            _local_11 = ((_local_11 << 15) | (_local_11 >>> 17));
                            _local_8 = (_local_8 ^ (_local_11 * _local_10));
                            _local_8 = ((_local_8 << 13) | (_local_8 >>> 19));
                            _local_8 = ((_local_8 * 5) + -430675100);
                            _local_12 = (_local_8 ^ _local_3);
                            _local_12 = (_local_12 ^ (_local_12 >>> 16));
                            _local_12 = (_local_12 * -2048144789);
                            _local_12 = (_local_12 ^ (_local_12 >>> 13));
                            _local_12 = (_local_12 * -1028477387);
                            _local_7 = ((_local_12 ^ (_local_12 >>> 16)) & 0xFFFF);
                            _arg_2 = (addr + (_local_7 * 5));
                        };
                    };
                };
            };
            si8(_local_3, _arg_2);
            si32(_local_4, (_arg_2 + 1));
        }

        public function _unsafeSearch(_arg_1:int, _arg_2:int):void
        {
            var _local_5:int;
            var _local_7:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_3:int = 3;
            var _local_4:int = -1;
            var _local_6:int = li32(_arg_2 + 1);
            if ((((_local_6 >= (0)) && (li32(_arg_1) == li32(_local_6))) && ((_arg_1 - _local_6) <= windowSize)))
            {
                _local_7 = (_arg_1 + 4);
                _local_5 = 4;
                _local_6 = (_local_6 + 4);
                while (((li32(_local_6) == (li32(_local_7))) && ((_local_5 + 4) <= maxMatchLength)))
                {
                    _local_5 = (_local_5 + 4);
                    _local_6 = (_local_6 + 4);
                    _local_7 = (_local_7 + 4);
                };
                while (((li8(_local_6) == (li8(_local_7))) && (_local_5 < maxMatchLength)))
                {
                    _local_5++;
                    _local_6++;
                    _local_7++;
                };
                _local_3 = _local_5;
                _local_4 = _local_6;
            };
            var _local_8:int = 5;
            var _local_9:int = 9;
            while (_local_8 < _local_9)
            {
                _local_10 = _local_8++;
                _local_13 = li32(_arg_1);
                si32(_local_13, hashScratchAddr);
                _local_13 = li32(_arg_1 + 4);
                si32(_local_13, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_10));
                _local_13 = 775236557;
                _local_14 = -862048943;
                _local_15 = 461845907;
                _local_16 = (li32(hashScratchAddr) * _local_14);
                _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                _local_13 = (_local_13 ^ (_local_16 * _local_15));
                _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                _local_13 = ((_local_13 * 5) + -430675100);
                _local_16 = (li32(hashScratchAddr + 4) * _local_14);
                _local_16 = ((_local_16 << 15) | (_local_16 >>> 17));
                _local_13 = (_local_13 ^ (_local_16 * _local_15));
                _local_13 = ((_local_13 << 13) | (_local_13 >>> 19));
                _local_13 = ((_local_13 * 5) + -430675100);
                _local_17 = (_local_13 ^ _local_10);
                _local_17 = (_local_17 ^ (_local_17 >>> 16));
                _local_17 = (_local_17 * -2048144789);
                _local_17 = (_local_17 ^ (_local_17 >>> 13));
                _local_17 = (_local_17 * -1028477387);
                _local_12 = ((_local_17 ^ (_local_17 >>> 16)) & 0xFFFF);
                _local_11 = ((addr + (_local_12 * 5)) + 1);
                _local_6 = li32(_local_11);
                if (((((_local_6 >= (0)) && (li32((_local_6 + _local_3) - 3) == li32((_arg_1 + _local_3) - 3))) && (li32(_arg_1) == li32(_local_6))) && ((_arg_1 - _local_6) <= windowSize)))
                {
                    _local_7 = (_arg_1 + 4);
                    _local_5 = 4;
                    _local_6 = (_local_6 + 4);
                    while (((li32(_local_6) == (li32(_local_7))) && ((_local_5 + 4) <= maxMatchLength)))
                    {
                        _local_5 = (_local_5 + 4);
                        _local_6 = (_local_6 + 4);
                        _local_7 = (_local_7 + 4);
                    };
                    while (((li8(_local_6) == (li8(_local_7))) && (_local_5 < maxMatchLength)))
                    {
                        _local_5++;
                        _local_6++;
                        _local_7++;
                    };
                    if (_local_5 > _local_3)
                    {
                        _local_3 = _local_5;
                        _local_4 = _local_6;
                    };
                };
            };
            si32((((_arg_1 - (_local_4 - _local_3)) << 16) | _local_3), resultAddr);
        }

        public function _search(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_6:int;
            var _local_8:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_4:int = 3;
            var _local_5:int = -1;
            var _local_7:int = li32(_arg_2 + 1);
            if ((((_local_7 >= (0)) && (li32(_arg_1) == li32(_local_7))) && ((_arg_1 - _local_7) <= windowSize)))
            {
                _local_8 = (_arg_1 + 4);
                _local_6 = 4;
                _local_7 = (_local_7 + 4);
                while (((((_local_8 + 4) <= (_arg_3)) && (li32(_local_7) == li32(_local_8))) && ((_local_6 + 4) <= maxMatchLength)))
                {
                    _local_6 = (_local_6 + 4);
                    _local_7 = (_local_7 + 4);
                    _local_8 = (_local_8 + 4);
                };
                while ((((_local_8 < (_arg_3)) && (li8(_local_7) == li8(_local_8))) && (_local_6 < maxMatchLength)))
                {
                    _local_6++;
                    _local_7++;
                    _local_8++;
                };
                _local_4 = _local_6;
                _local_5 = _local_7;
            };
            var _local_9:int = 5;
            var _local_10:int = 9;
            while (_local_9 < _local_10)
            {
                _local_11 = _local_9++;
                _local_14 = li32(_arg_1);
                si32(_local_14, hashScratchAddr);
                _local_14 = li32(_arg_1 + 4);
                si32(_local_14, (hashScratchAddr + 4));
                si32(0, (hashScratchAddr + _local_11));
                _local_14 = 775236557;
                _local_15 = -862048943;
                _local_16 = 461845907;
                _local_17 = (li32(hashScratchAddr) * _local_15);
                _local_17 = ((_local_17 << 15) | (_local_17 >>> 17));
                _local_14 = (_local_14 ^ (_local_17 * _local_16));
                _local_14 = ((_local_14 << 13) | (_local_14 >>> 19));
                _local_14 = ((_local_14 * 5) + -430675100);
                _local_17 = (li32(hashScratchAddr + 4) * _local_15);
                _local_17 = ((_local_17 << 15) | (_local_17 >>> 17));
                _local_14 = (_local_14 ^ (_local_17 * _local_16));
                _local_14 = ((_local_14 << 13) | (_local_14 >>> 19));
                _local_14 = ((_local_14 * 5) + -430675100);
                _local_18 = (_local_14 ^ _local_11);
                _local_18 = (_local_18 ^ (_local_18 >>> 16));
                _local_18 = (_local_18 * -2048144789);
                _local_18 = (_local_18 ^ (_local_18 >>> 13));
                _local_18 = (_local_18 * -1028477387);
                _local_13 = ((_local_18 ^ (_local_18 >>> 16)) & 0xFFFF);
                _local_12 = ((addr + (_local_13 * 5)) + 1);
                _local_7 = li32(_local_12);
                if ((((_local_7 >= (0)) && (li32(_arg_1) == li32(_local_7))) && ((_arg_1 - _local_7) <= windowSize)))
                {
                    _local_8 = (_arg_1 + 4);
                    _local_6 = 4;
                    _local_7 = (_local_7 + 4);
                    while (((((_local_8 + 4) <= (_arg_3)) && (li32(_local_7) == li32(_local_8))) && ((_local_6 + 4) <= maxMatchLength)))
                    {
                        _local_6 = (_local_6 + 4);
                        _local_7 = (_local_7 + 4);
                        _local_8 = (_local_8 + 4);
                    };
                    while ((((_local_8 < (_arg_3)) && (li8(_local_7) == li8(_local_8))) && (_local_6 < maxMatchLength)))
                    {
                        _local_6++;
                        _local_7++;
                        _local_8++;
                    };
                    if (_local_6 > _local_4)
                    {
                        _local_4 = _local_6;
                        _local_5 = _local_7;
                    };
                };
            };
            si32((((_arg_1 - (_local_5 - _local_4)) << 16) | _local_4), resultAddr);
        }

        public function _clearTable():void
        {
            var _local_1:int = addr;
            var _local_2:* = (addr + 0x50000);
            while (_local_1 < _local_2)
            {
                si32(-1, _local_1);
                si32(-1, (_local_1 + 4));
                si32(-1, (_local_1 + 8));
                si32(-1, (_local_1 + 12));
                si32(-1, (_local_1 + 16));
                si32(-1, (_local_1 + 20));
                si32(-1, (_local_1 + 24));
                si32(-1, (_local_1 + 28));
                _local_1 = (_local_1 + 32);
            };
        }


    }
}

