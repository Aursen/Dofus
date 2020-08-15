package _DeflateStream
{
    import flash.system.ApplicationDomain;
    import flash.utils.ByteArray;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public class HuffmanTree 
    {

        public static var scratchAddr:int;

        public function HuffmanTree():void
        {
        }

        public static function fromWeightedAlphabet(_arg_1:Array, _arg_2:int):Array
        {
            var _local_11:int;
            var _local_3:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            var _local_4:int = HuffmanTree.scratchAddr;
            var _local_5:ByteArray = new ByteArray();
            var _local_6:Number = Math.max(((_arg_1.length * 4) * 2), ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);
            _local_5.length = _local_6;
            ApplicationDomain.currentDomain.domainMemory = _local_5;
            var _local_7:int;
            var _local_8:* = (_local_7 + (_arg_1.length * 4));
            HuffmanTree.scratchAddr = _local_8;
            var _local_9:int;
            var _local_10:int;
            while (_local_10 < _arg_1.length)
            {
                _local_11 = _arg_1[_local_10];
                _local_10++;
                si32(_local_11, (_local_7 + _local_9));
                _local_9 = (_local_9 + 4);
            };
            HuffmanTree.weightedAlphabetToCodes(_local_7, _local_8, _arg_2);
            var _local_12:Array = [];
            _local_9 = _local_7;
            while (_local_9 < _local_8)
            {
                _local_12.push(li32(_local_9));
                _local_9 = (_local_9 + 4);
            };
            ApplicationDomain.currentDomain.domainMemory = _local_3;
            HuffmanTree.scratchAddr = _local_4;
            return (_local_12);
        }

        public static function weightedAlphabetToCodes(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_16:Number;
            var _local_4:int = _arg_2;
            var _local_5:* = ((_local_4 - _arg_1) >> 2);
            var _local_6:int = _local_5;
            if (_local_6 > 0)
            {
                _local_7 = 0;
                while (_local_7 < _local_6)
                {
                    _local_8 = _local_7++;
                    si32(_local_8, (HuffmanTree.scratchAddr + (_local_8 << 2)));
                };
                _local_7 = 0;
                _local_8 = 0;
                while (_local_8 < _local_6)
                {
                    _local_9 = _local_8++;
                    if (li32(_arg_1 + (_local_9 << 2)) == 0)
                    {
                        _local_7++;
                    }
                    else
                    {
                        _local_10 = li32(_arg_1 + (_local_9 << 2));
                        si32(_local_10, (_arg_1 + ((_local_9 - _local_7) << 2)));
                        _local_10 = li32(HuffmanTree.scratchAddr + (_local_9 << 2));
                        si32(_local_10, (HuffmanTree.scratchAddr + ((_local_9 - _local_7) << 2)));
                    };
                };
                _local_6 = (_local_6 - _local_7);
                _local_4 = (_arg_1 + (_local_6 << 2));
                _local_12 = (_local_4 - _arg_1);
                _local_8 = 4;
                while (_local_8 < _local_12)
                {
                    _local_10 = li32(_arg_1 + _local_8);
                    _local_11 = li32(HuffmanTree.scratchAddr + _local_8);
                    _local_9 = (_local_8 - 4);
                    while (((_local_9 >= (0)) && (li32(_arg_1 + _local_9) > _local_10)))
                    {
                        _local_13 = li32(_arg_1 + _local_9);
                        si32(_local_13, ((_arg_1 + _local_9) + 4));
                        _local_13 = li32(HuffmanTree.scratchAddr + _local_9);
                        si32(_local_13, ((HuffmanTree.scratchAddr + _local_9) + 4));
                        _local_9 = (_local_9 - 4);
                    };
                    si32(_local_10, ((_arg_1 + _local_9) + 4));
                    si32(_local_11, ((HuffmanTree.scratchAddr + _local_9) + 4));
                    _local_8 = (_local_8 + 4);
                };
            };
            if (_local_6 != 0)
            {
                if (_local_6 != 1)
                {
                    _local_13 = (li32(_arg_1) + li32(_arg_1 + 4));
                    si32(_local_13, _arg_1);
                    _local_7 = 0;
                    _local_8 = 2;
                    _local_9 = 1;
                    while (_local_9 < (_local_6 - 1))
                    {
                        if (((_local_8 >= (_local_6)) || (li32(_arg_1 + (_local_7 << 2)) < li32(_arg_1 + (_local_8 << 2)))))
                        {
                            _local_13 = li32(_arg_1 + (_local_7 << 2));
                            si32(_local_13, (_arg_1 + (_local_9 << 2)));
                            _local_13 = _local_7++;
                            si32(_local_9, (_arg_1 + (_local_13 << 2)));
                        }
                        else
                        {
                            _local_14 = _local_8++;
                            _local_13 = li32(_arg_1 + (_local_14 << 2));
                            si32(_local_13, (_arg_1 + (_local_9 << 2)));
                        };
                        if (((_local_8 >= (_local_6)) || ((_local_7 < (_local_9)) && (li32(_arg_1 + (_local_7 << 2)) < li32(_arg_1 + (_local_8 << 2))))))
                        {
                            _local_13 = (li32(_arg_1 + (_local_9 << 2)) + li32(_arg_1 + (_local_7 << 2)));
                            si32(_local_13, (_arg_1 + (_local_9 << 2)));
                            _local_13 = _local_7++;
                            si32(_local_9, (_arg_1 + (_local_13 << 2)));
                        }
                        else
                        {
                            _local_14 = _local_8++;
                            _local_13 = (li32(_arg_1 + (_local_9 << 2)) + li32(_arg_1 + (_local_14 << 2)));
                            si32(_local_13, (_arg_1 + (_local_9 << 2)));
                        };
                        _local_9++;
                    };
                    si32(0, (_arg_1 + ((_local_6 - 2) << 2)));
                    _local_9 = (_local_6 - 3);
                    while (_local_9 >= 0)
                    {
                        _local_14 = li32(_arg_1 + (_local_9 << 2));
                        _local_13 = (li32(_arg_1 + (_local_14 << 2)) + 1);
                        si32(_local_13, (_arg_1 + (_local_9 << 2)));
                        _local_9--;
                    };
                    _local_10 = 1;
                    _local_12 = 0;
                    _local_11 = _local_12;
                    _local_7 = (_local_6 - 2);
                    _local_9 = (_local_6 - 1);
                    while (_local_10 > 0)
                    {
                        while (((_local_7 >= (0)) && (li32(_arg_1 + (_local_7 << 2)) == _local_12)))
                        {
                            _local_11++;
                            _local_7--;
                        };
                        while (_local_10 > _local_11)
                        {
                            _local_13 = _local_9--;
                            si32(_local_12, (_arg_1 + (_local_13 << 2)));
                            _local_10--;
                        };
                        _local_10 = (2 * _local_11);
                        _local_12++;
                        _local_11 = 0;
                    };
                }
                else
                {
                    si32(1, _arg_1);
                };
            };
            var _local_15:Boolean;
            _local_7 = ((_local_4 - _arg_1) >>> 2);
            _local_8 = 0;
            while (_local_8 < _local_7)
            {
                _local_9 = _local_8++;
                if (li32(_arg_1 + (_local_9 << 2)) > _arg_3)
                {
                    si32(_arg_3, (_arg_1 + (_local_9 << 2)));
                    _local_15 = true;
                };
            };
            if (_local_15)
            {
                _local_16 = 0;
                _local_8 = 0;
                while (_local_8 < _local_7)
                {
                    _local_9 = _local_8++;
                    _local_16 = (_local_16 + Math.pow(2, -(li32(_arg_1 + (_local_9 << 2)))));
                };
                _local_8 = 0;
                while (((_local_16 > (1)) && (_local_8 < _local_7)))
                {
                    while (((li32(_arg_1 + (_local_8 << 2)) < (_arg_3)) && (_local_16 > 1)))
                    {
                        _local_9 = (li32(_arg_1 + (_local_8 << 2)) + 1);
                        si32(_local_9, (_arg_1 + (_local_8 << 2)));
                        _local_16 = (_local_16 - Math.pow(2, -(li32(_arg_1 + (_local_8 << 2)))));
                    };
                    _local_8++;
                };
                _local_8 = (_local_7 - 1);
                while (_local_8 >= 0)
                {
                    while ((_local_16 + Math.pow(2, -(li32(_arg_1 + (_local_8 << 2))))) <= 1)
                    {
                        _local_16 = (_local_16 + Math.pow(2, -(li32(_arg_1 + (_local_8 << 2)))));
                        _local_9 = (li32(_arg_1 + (_local_8 << 2)) - 1);
                        si32(_local_9, (_arg_1 + (_local_8 << 2)));
                    };
                    _local_8--;
                };
            };
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                _local_8 = _local_7++;
                _local_9 = ((li32(HuffmanTree.scratchAddr + (_local_8 << 2)) << 16) | li32(_arg_1 + (_local_8 << 2)));
                si32(_local_9, (HuffmanTree.scratchAddr + (_local_8 << 2)));
            };
            _local_7 = HuffmanTree.scratchAddr;
            _local_8 = 4;
            while (_local_8 < (_local_4 - _arg_1))
            {
                _local_10 = li32(_local_7 + _local_8);
                _local_12 = (_local_10 >>> 16);
                _local_11 = (_local_10 & 0xFFFF);
                _local_9 = (_local_8 - 4);
                while (((_local_9 >= (0)) && ((_local_13 == 0) ? (li16((_local_7 + _local_9) + 2) < _local_12) : (_local_13 < 0))))
                {
                    _local_13 = li32(_local_7 + _local_9);
                    si32(_local_13, ((_local_7 + _local_9) + 4));
                    _local_9 = (_local_9 - 4);
                };
                si32(_local_10, ((_local_7 + _local_9) + 4));
                _local_8 = (_local_8 + 4);
            };
            if (_local_6 != _local_5)
            {
                _local_7 = 0;
                while (_local_7 < _local_5)
                {
                    _local_8 = _local_7++;
                    si32(0, (_arg_1 + (_local_8 << 2)));
                };
            };
            _local_7 = HuffmanTree.scratchAddr;
            if (_local_6 != 0)
            {
                _local_8 = (_local_6 - 1);
                _local_9 = 0;
                _local_10 = li16(_local_7 + (_local_8 * 4));
                while (_local_8 >= 0)
                {
                    _local_11 = li32(_local_7 + (_local_8 * 4));
                    _local_12 = (_local_11 & 0xFFFF);
                    _local_9 = (_local_9 << (_local_12 - _local_10));
                    _local_14 = _local_9;
                    _local_14 = (((_local_14 >>> 1) & 0x55555555) | ((_local_14 & 0x55555555) << 1));
                    _local_14 = (((_local_14 >>> 2) & 0x33333333) | ((_local_14 & 0x33333333) << 2));
                    _local_14 = (((_local_14 >>> 4) & 0x0F0F0F0F) | ((_local_14 & 0x0F0F0F0F) << 4));
                    _local_14 = (((_local_14 >>> 8) & 0xFF00FF) | ((_local_14 & 0xFF00FF) << 8));
                    _local_13 = ((((_local_14 & 0xFFFF) >>> (16 - _local_12)) << 16) | _local_12);
                    si32(_local_13, (_arg_1 + ((_local_11 >>> 16) * 4)));
                    _local_9++;
                    _local_10 = _local_12;
                    if (_local_9 >= (1 << _local_10))
                    {
                        _local_10++;
                    };
                    _local_8--;
                };
            };
        }

        public static function _weightedAlphabetToCodes(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_15:Number;
            var _local_4:* = ((_arg_2 - _arg_1) >> 2);
            var _local_5:int = _local_4;
            if (_local_5 > 0)
            {
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    _local_7 = _local_6++;
                    si32(_local_7, (HuffmanTree.scratchAddr + (_local_7 << 2)));
                };
                _local_6 = 0;
                _local_7 = 0;
                while (_local_7 < _local_5)
                {
                    _local_8 = _local_7++;
                    if (li32(_arg_1 + (_local_8 << 2)) == 0)
                    {
                        _local_6++;
                    }
                    else
                    {
                        _local_9 = li32(_arg_1 + (_local_8 << 2));
                        si32(_local_9, (_arg_1 + ((_local_8 - _local_6) << 2)));
                        _local_9 = li32(HuffmanTree.scratchAddr + (_local_8 << 2));
                        si32(_local_9, (HuffmanTree.scratchAddr + ((_local_8 - _local_6) << 2)));
                    };
                };
                _local_5 = (_local_5 - _local_6);
                _arg_2 = (_arg_1 + (_local_5 << 2));
                _local_11 = (_arg_2 - _arg_1);
                _local_7 = 4;
                while (_local_7 < _local_11)
                {
                    _local_9 = li32(_arg_1 + _local_7);
                    _local_10 = li32(HuffmanTree.scratchAddr + _local_7);
                    _local_8 = (_local_7 - 4);
                    while (((_local_8 >= (0)) && (li32(_arg_1 + _local_8) > _local_9)))
                    {
                        _local_12 = li32(_arg_1 + _local_8);
                        si32(_local_12, ((_arg_1 + _local_8) + 4));
                        _local_12 = li32(HuffmanTree.scratchAddr + _local_8);
                        si32(_local_12, ((HuffmanTree.scratchAddr + _local_8) + 4));
                        _local_8 = (_local_8 - 4);
                    };
                    si32(_local_9, ((_arg_1 + _local_8) + 4));
                    si32(_local_10, ((HuffmanTree.scratchAddr + _local_8) + 4));
                    _local_7 = (_local_7 + 4);
                };
            };
            if (_local_5 != 0)
            {
                if (_local_5 != 1)
                {
                    _local_12 = (li32(_arg_1) + li32(_arg_1 + 4));
                    si32(_local_12, _arg_1);
                    _local_6 = 0;
                    _local_7 = 2;
                    _local_8 = 1;
                    while (_local_8 < (_local_5 - 1))
                    {
                        if (((_local_7 >= (_local_5)) || (li32(_arg_1 + (_local_6 << 2)) < li32(_arg_1 + (_local_7 << 2)))))
                        {
                            _local_12 = li32(_arg_1 + (_local_6 << 2));
                            si32(_local_12, (_arg_1 + (_local_8 << 2)));
                            _local_12 = _local_6++;
                            si32(_local_8, (_arg_1 + (_local_12 << 2)));
                        }
                        else
                        {
                            _local_13 = _local_7++;
                            _local_12 = li32(_arg_1 + (_local_13 << 2));
                            si32(_local_12, (_arg_1 + (_local_8 << 2)));
                        };
                        if (((_local_7 >= (_local_5)) || ((_local_6 < (_local_8)) && (li32(_arg_1 + (_local_6 << 2)) < li32(_arg_1 + (_local_7 << 2))))))
                        {
                            _local_12 = (li32(_arg_1 + (_local_8 << 2)) + li32(_arg_1 + (_local_6 << 2)));
                            si32(_local_12, (_arg_1 + (_local_8 << 2)));
                            _local_12 = _local_6++;
                            si32(_local_8, (_arg_1 + (_local_12 << 2)));
                        }
                        else
                        {
                            _local_13 = _local_7++;
                            _local_12 = (li32(_arg_1 + (_local_8 << 2)) + li32(_arg_1 + (_local_13 << 2)));
                            si32(_local_12, (_arg_1 + (_local_8 << 2)));
                        };
                        _local_8++;
                    };
                    si32(0, (_arg_1 + ((_local_5 - 2) << 2)));
                    _local_8 = (_local_5 - 3);
                    while (_local_8 >= 0)
                    {
                        _local_13 = li32(_arg_1 + (_local_8 << 2));
                        _local_12 = (li32(_arg_1 + (_local_13 << 2)) + 1);
                        si32(_local_12, (_arg_1 + (_local_8 << 2)));
                        _local_8--;
                    };
                    _local_9 = 1;
                    _local_11 = 0;
                    _local_10 = _local_11;
                    _local_6 = (_local_5 - 2);
                    _local_8 = (_local_5 - 1);
                    while (_local_9 > 0)
                    {
                        while (((_local_6 >= (0)) && (li32(_arg_1 + (_local_6 << 2)) == _local_11)))
                        {
                            _local_10++;
                            _local_6--;
                        };
                        while (_local_9 > _local_10)
                        {
                            _local_12 = _local_8--;
                            si32(_local_11, (_arg_1 + (_local_12 << 2)));
                            _local_9--;
                        };
                        _local_9 = (2 * _local_10);
                        _local_11++;
                        _local_10 = 0;
                    };
                }
                else
                {
                    si32(1, _arg_1);
                };
            };
            var _local_14:Boolean;
            _local_6 = ((_arg_2 - _arg_1) >>> 2);
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                _local_8 = _local_7++;
                if (li32(_arg_1 + (_local_8 << 2)) > _arg_3)
                {
                    si32(_arg_3, (_arg_1 + (_local_8 << 2)));
                    _local_14 = true;
                };
            };
            if (_local_14)
            {
                _local_15 = 0;
                _local_7 = 0;
                while (_local_7 < _local_6)
                {
                    _local_8 = _local_7++;
                    _local_15 = (_local_15 + Math.pow(2, -(li32(_arg_1 + (_local_8 << 2)))));
                };
                _local_7 = 0;
                while (((_local_15 > (1)) && (_local_7 < _local_6)))
                {
                    while (((li32(_arg_1 + (_local_7 << 2)) < (_arg_3)) && (_local_15 > 1)))
                    {
                        _local_8 = (li32(_arg_1 + (_local_7 << 2)) + 1);
                        si32(_local_8, (_arg_1 + (_local_7 << 2)));
                        _local_15 = (_local_15 - Math.pow(2, -(li32(_arg_1 + (_local_7 << 2)))));
                    };
                    _local_7++;
                };
                _local_7 = (_local_6 - 1);
                while (_local_7 >= 0)
                {
                    while ((_local_15 + Math.pow(2, -(li32(_arg_1 + (_local_7 << 2))))) <= 1)
                    {
                        _local_15 = (_local_15 + Math.pow(2, -(li32(_arg_1 + (_local_7 << 2)))));
                        _local_8 = (li32(_arg_1 + (_local_7 << 2)) - 1);
                        si32(_local_8, (_arg_1 + (_local_7 << 2)));
                    };
                    _local_7--;
                };
            };
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _local_7 = _local_6++;
                _local_8 = ((li32(HuffmanTree.scratchAddr + (_local_7 << 2)) << 16) | li32(_arg_1 + (_local_7 << 2)));
                si32(_local_8, (HuffmanTree.scratchAddr + (_local_7 << 2)));
            };
            _local_6 = HuffmanTree.scratchAddr;
            _local_7 = 4;
            while (_local_7 < (_arg_2 - _arg_1))
            {
                _local_9 = li32(_local_6 + _local_7);
                _local_11 = (_local_9 >>> 16);
                _local_10 = (_local_9 & 0xFFFF);
                _local_8 = (_local_7 - 4);
                while (((_local_8 >= (0)) && ((_local_12 == 0) ? (li16((_local_6 + _local_8) + 2) < _local_11) : (_local_12 < 0))))
                {
                    _local_12 = li32(_local_6 + _local_8);
                    si32(_local_12, ((_local_6 + _local_8) + 4));
                    _local_8 = (_local_8 - 4);
                };
                si32(_local_9, ((_local_6 + _local_8) + 4));
                _local_7 = (_local_7 + 4);
            };
            if (_local_5 != _local_4)
            {
                _local_6 = 0;
                while (_local_6 < _local_4)
                {
                    _local_7 = _local_6++;
                    si32(0, (_arg_1 + (_local_7 << 2)));
                };
            };
            _local_6 = HuffmanTree.scratchAddr;
            if (_local_5 != 0)
            {
                _local_7 = (_local_5 - 1);
                _local_8 = 0;
                _local_9 = li16(_local_6 + (_local_7 * 4));
                while (_local_7 >= 0)
                {
                    _local_10 = li32(_local_6 + (_local_7 * 4));
                    _local_11 = (_local_10 & 0xFFFF);
                    _local_8 = (_local_8 << (_local_11 - _local_9));
                    _local_13 = _local_8;
                    _local_13 = (((_local_13 >>> 1) & 0x55555555) | ((_local_13 & 0x55555555) << 1));
                    _local_13 = (((_local_13 >>> 2) & 0x33333333) | ((_local_13 & 0x33333333) << 2));
                    _local_13 = (((_local_13 >>> 4) & 0x0F0F0F0F) | ((_local_13 & 0x0F0F0F0F) << 4));
                    _local_13 = (((_local_13 >>> 8) & 0xFF00FF) | ((_local_13 & 0xFF00FF) << 8));
                    _local_12 = ((((_local_13 & 0xFFFF) >>> (16 - _local_11)) << 16) | _local_11);
                    si32(_local_12, (_arg_1 + ((_local_10 >>> 16) * 4)));
                    _local_8++;
                    _local_9 = _local_11;
                    if (_local_8 >= (1 << _local_9))
                    {
                        _local_9++;
                    };
                    _local_7--;
                };
            };
        }

        public static function sortByWeightNonDecreasing(_arg_1:int, _arg_2:int):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_8:int;
            var _local_7:* = (_arg_2 - _arg_1);
            var _local_3:int = 4;
            while (_local_3 < _local_7)
            {
                _local_5 = li32(_arg_1 + _local_3);
                _local_6 = li32(HuffmanTree.scratchAddr + _local_3);
                _local_4 = (_local_3 - 4);
                while (((_local_4 >= (0)) && (li32(_arg_1 + _local_4) > _local_5)))
                {
                    _local_8 = li32(_arg_1 + _local_4);
                    si32(_local_8, ((_arg_1 + _local_4) + 4));
                    _local_8 = li32(HuffmanTree.scratchAddr + _local_4);
                    si32(_local_8, ((HuffmanTree.scratchAddr + _local_4) + 4));
                    _local_4 = (_local_4 - 4);
                };
                si32(_local_5, ((_arg_1 + _local_4) + 4));
                si32(_local_6, ((HuffmanTree.scratchAddr + _local_4) + 4));
                _local_3 = (_local_3 + 4);
            };
        }

        public static function sortByCodeLengthAndSymbolDecreasing(_arg_1:int, _arg_2:int):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_3:int = 4;
            while (_local_3 < _arg_2)
            {
                _local_5 = li32(_arg_1 + _local_3);
                _local_7 = (_local_5 >>> 16);
                _local_6 = (_local_5 & 0xFFFF);
                _local_4 = (_local_3 - 4);
                while (((_local_4 >= (0)) && ((_local_8 == 0) ? (li16((_arg_1 + _local_4) + 2) < _local_7) : (_local_8 < 0))))
                {
                    _local_8 = li32(_arg_1 + _local_4);
                    si32(_local_8, ((_arg_1 + _local_4) + 4));
                    _local_4 = (_local_4 - 4);
                };
                si32(_local_5, ((_arg_1 + _local_4) + 4));
                _local_3 = (_local_3 + 4);
            };
        }

        public static function compareCodeLengthAndSymbolDecreasing(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:* = (li16(_arg_3 + _arg_4) - _arg_1);
            if (_local_5 == 0)
            {
                return (li16((_arg_3 + _arg_4) + 2) < _arg_2);
            };
            return (_local_5 < 0);
        }

        public static function calculateOptimalCodeLengths(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            if (_arg_2 != 0)
            {
                if (_arg_2 != 1)
                {
                    _local_9 = (li32(_arg_1) + li32(_arg_1 + 4));
                    si32(_local_9, _arg_1);
                    _local_3 = 0;
                    _local_4 = 2;
                    _local_5 = 1;
                    while (_local_5 < (_arg_2 - 1))
                    {
                        if (((_local_4 >= (_arg_2)) || (li32(_arg_1 + (_local_3 << 2)) < li32(_arg_1 + (_local_4 << 2)))))
                        {
                            _local_9 = li32(_arg_1 + (_local_3 << 2));
                            si32(_local_9, (_arg_1 + (_local_5 << 2)));
                            _local_9 = _local_3++;
                            si32(_local_5, (_arg_1 + (_local_9 << 2)));
                        }
                        else
                        {
                            _local_10 = _local_4++;
                            _local_9 = li32(_arg_1 + (_local_10 << 2));
                            si32(_local_9, (_arg_1 + (_local_5 << 2)));
                        };
                        if (((_local_4 >= (_arg_2)) || ((_local_3 < (_local_5)) && (li32(_arg_1 + (_local_3 << 2)) < li32(_arg_1 + (_local_4 << 2))))))
                        {
                            _local_9 = (li32(_arg_1 + (_local_5 << 2)) + li32(_arg_1 + (_local_3 << 2)));
                            si32(_local_9, (_arg_1 + (_local_5 << 2)));
                            _local_9 = _local_3++;
                            si32(_local_5, (_arg_1 + (_local_9 << 2)));
                        }
                        else
                        {
                            _local_10 = _local_4++;
                            _local_9 = (li32(_arg_1 + (_local_5 << 2)) + li32(_arg_1 + (_local_10 << 2)));
                            si32(_local_9, (_arg_1 + (_local_5 << 2)));
                        };
                        _local_5++;
                    };
                    si32(0, (_arg_1 + ((_arg_2 - 2) << 2)));
                    _local_5 = (_arg_2 - 3);
                    while (_local_5 >= 0)
                    {
                        _local_10 = li32(_arg_1 + (_local_5 << 2));
                        _local_9 = (li32(_arg_1 + (_local_10 << 2)) + 1);
                        si32(_local_9, (_arg_1 + (_local_5 << 2)));
                        _local_5--;
                    };
                    _local_6 = 1;
                    _local_8 = 0;
                    _local_7 = _local_8;
                    _local_3 = (_arg_2 - 2);
                    _local_5 = (_arg_2 - 1);
                    while (_local_6 > 0)
                    {
                        while (((_local_3 >= (0)) && (li32(_arg_1 + (_local_3 << 2)) == _local_8)))
                        {
                            _local_7++;
                            _local_3--;
                        };
                        while (_local_6 > _local_7)
                        {
                            _local_9 = _local_5--;
                            si32(_local_8, (_arg_1 + (_local_9 << 2)));
                            _local_6--;
                        };
                        _local_6 = (2 * _local_7);
                        _local_8++;
                        _local_7 = 0;
                    };
                }
                else
                {
                    si32(1, _arg_1);
                };
            };
        }

        public static function get32(_arg_1:int, _arg_2:int):int
        {
            return (li32(_arg_1 + (_arg_2 << 2)));
        }

        public static function set32(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            si32(_arg_3, (_arg_1 + (_arg_2 << 2)));
        }

        public static function limitCodeLengths(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:Number;
            var _local_4:Boolean;
            var _local_5:int = ((_arg_2 - _arg_1) >>> 2);
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _local_7 = _local_6++;
                if (li32(_arg_1 + (_local_7 << 2)) > _arg_3)
                {
                    si32(_arg_3, (_arg_1 + (_local_7 << 2)));
                    _local_4 = true;
                };
            };
            if (_local_4)
            {
                _local_8 = 0;
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    _local_7 = _local_6++;
                    _local_8 = (_local_8 + Math.pow(2, -(li32(_arg_1 + (_local_7 << 2)))));
                };
                _local_6 = 0;
                while (((_local_8 > (1)) && (_local_6 < _local_5)))
                {
                    while (((li32(_arg_1 + (_local_6 << 2)) < (_arg_3)) && (_local_8 > 1)))
                    {
                        _local_7 = (li32(_arg_1 + (_local_6 << 2)) + 1);
                        si32(_local_7, (_arg_1 + (_local_6 << 2)));
                        _local_8 = (_local_8 - Math.pow(2, -(li32(_arg_1 + (_local_6 << 2)))));
                    };
                    _local_6++;
                };
                _local_6 = (_local_5 - 1);
                while (_local_6 >= 0)
                {
                    while ((_local_8 + Math.pow(2, -(li32(_arg_1 + (_local_6 << 2))))) <= 1)
                    {
                        _local_8 = (_local_8 + Math.pow(2, -(li32(_arg_1 + (_local_6 << 2)))));
                        _local_7 = (li32(_arg_1 + (_local_6 << 2)) - 1);
                        si32(_local_7, (_arg_1 + (_local_6 << 2)));
                    };
                    _local_6--;
                };
            };
        }

        public static function calculateCanonicalCodes(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            if (_arg_2 != 0)
            {
                _local_4 = (_arg_2 - 1);
                _local_5 = 0;
                _local_6 = li16(_arg_1 + (_local_4 * 4));
                while (_local_4 >= 0)
                {
                    _local_7 = li32(_arg_1 + (_local_4 * 4));
                    _local_8 = (_local_7 & 0xFFFF);
                    _local_5 = (_local_5 << (_local_8 - _local_6));
                    _local_10 = _local_5;
                    _local_10 = (((_local_10 >>> 1) & 0x55555555) | ((_local_10 & 0x55555555) << 1));
                    _local_10 = (((_local_10 >>> 2) & 0x33333333) | ((_local_10 & 0x33333333) << 2));
                    _local_10 = (((_local_10 >>> 4) & 0x0F0F0F0F) | ((_local_10 & 0x0F0F0F0F) << 4));
                    _local_10 = (((_local_10 >>> 8) & 0xFF00FF) | ((_local_10 & 0xFF00FF) << 8));
                    _local_9 = ((((_local_10 & 0xFFFF) >>> (16 - _local_8)) << 16) | _local_8);
                    si32(_local_9, (_arg_3 + ((_local_7 >>> 16) * 4)));
                    _local_5++;
                    _local_6 = _local_8;
                    if (_local_5 >= (1 << _local_6))
                    {
                        _local_6++;
                    };
                    _local_4--;
                };
            };
        }

        public static function reverseBits(_arg_1:int, _arg_2:int):uint
        {
            _arg_1 = (((_arg_1 >>> 1) & 0x55555555) | ((_arg_1 & 0x55555555) << 1));
            _arg_1 = (((_arg_1 >>> 2) & 0x33333333) | ((_arg_1 & 0x33333333) << 2));
            _arg_1 = (((_arg_1 >>> 4) & 0x0F0F0F0F) | ((_arg_1 & 0x0F0F0F0F) << 4));
            _arg_1 = (((_arg_1 >>> 8) & 0xFF00FF) | ((_arg_1 & 0xFF00FF) << 8));
            return ((_arg_1 & 0xFFFF) >>> (16 - _arg_2));
        }


    }
}

