package by.blooddy.crypto.image
{
    import flash.system.ApplicationDomain;
    import flash.utils.ByteArray;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public class JPEGTableHelper 
    {

        public function JPEGTableHelper():void
        {
        }

        public static function createQuantTable(_arg_1:uint):ByteArray
        {
            var _local_6:uint;
            var _local_8:uint;
            var _local_9:Number;
            if (_arg_1 > 100)
            {
                Error.throwError(RangeError, 2006, "quality");
            };
            var _local_2:uint = ((_arg_1 <= 1) ? 5000 : ((_arg_1 < 50) ? int((5000 / _arg_1)) : (200 - (_arg_1 << 1))));
            var _local_3:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            var _local_4:ByteArray = new ByteArray();
            _local_4.position = 130;
            _local_4.writeUTFBytes("\x10\x0B\n\x10\x18(3=\f\f\x0E\x13\x1A:<7\x0E\r\x10\x18(9E8\x0E\x11\x16\x1D3WP>\x12\x16%8DmgM\x18#7@Qhq\\1@NWgyxeH\\_bpdgc");
            _local_4.writeUTFBytes("\x11\x12\x18/cccc\x12\x15\x1ABcccc\x18\x1A8ccccc/Bcccccccccccccccccccccccccccccccccccccc");
            _local_4.position = 1154;
            _local_4.writeUTFBytes("\x00\x01\x05\x06\x0E\x0F\x1B\x1C\x02\x04\x07\r\x10\x1A\x1D*\x03\b\f\x11\x19\x1E)+\t\x0B\x12\x18\x1F(,5\n\x13\x17 '-46\x14\x16!&.37<\x15\"%/28;=#$019:>?");
            _local_4.length = (_local_4.length + 64);
            if (_local_4.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _local_4.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            };
            ApplicationDomain.currentDomain.domainMemory = _local_4;
            var _local_5:uint;
            do 
            {
                _local_6 = uint((((li8(130 + _local_5) * _local_2) + 50) / 100));
                if (_local_6 < 1)
                {
                    _local_6 = 1;
                }
                else
                {
                    if (_local_6 > 0xFF)
                    {
                        _local_6 = 0xFF;
                    };
                };
                si8(_local_6, (1 + li8(1154 + _local_5)));
            } while (++_local_5 < 64);
            _local_5 = 0;
            do 
            {
                _local_6 = uint((((li8(194 + _local_5) * _local_2) + 50) / 100));
                if (_local_6 < 1)
                {
                    _local_6 = 1;
                }
                else
                {
                    if (_local_6 > 0xFF)
                    {
                        _local_6 = 0xFF;
                    };
                };
                si8(_local_6, (66 + li8(1154 + _local_5)));
            } while (++_local_5 < 64);
            sf64(1, 1218);
            sf64(1.387039845, 1226);
            sf64(1.306562965, 1234);
            sf64(1.175875602, 1242);
            sf64(1, 1250);
            sf64(0.785694958, 1258);
            sf64(0.5411961, 1266);
            sf64(0.275899379, 1274);
            _local_5 = 0;
            var _local_7:uint;
            do 
            {
                _local_8 = 0;
                do 
                {
                    _local_9 = ((lf64(1218 + _local_7) * lf64(1218 + _local_8)) * 8);
                    sf64((1 / (li8(1 + li8(1154 + _local_5)) * _local_9)), (130 + (_local_5 << 3)));
                    sf64((1 / (li8(66 + li8(1154 + _local_5)) * _local_9)), (642 + (_local_5 << 3)));
                    _local_5++;
                    _local_8 = (_local_8 + 8);
                } while (_local_8 < 64);
                _local_7 = (_local_7 + 8);
            } while (_local_7 < 64);
            ApplicationDomain.currentDomain.domainMemory = _local_3;
            _local_4.length = 1154;
            var _local_10:ByteArray = new ByteArray();
            _local_10.writeBytes(_local_4);
            _local_10.position = 0;
            return (_local_10);
        }

        public static function createZigZagTable():ByteArray
        {
            var _local_1:ByteArray = new ByteArray();
            _local_1.writeUTFBytes("\x00\x01\x05\x06\x0E\x0F\x1B\x1C\x02\x04\x07\r\x10\x1A\x1D*\x03\b\f\x11\x19\x1E)+\t\x0B\x12\x18\x1F(,5\n\x13\x17 '-46\x14\x16!&.37<\x15\"%/28;=#$019:>?");
            _local_1.position = 0;
            return (_local_1);
        }

        public static function createHuffmanTable():ByteArray
        {
            var _local_8:uint;
            var _local_9:uint;
            var _local_10:uint;
            var _local_1:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            var _local_2:ByteArray = new ByteArray();
            _local_2.length = 1994;
            if (_local_2.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _local_2.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            };
            ApplicationDomain.currentDomain.domainMemory = _local_2;
            _local_2.position = (_local_2.position + 1);
            _local_2.writeUTFBytes("\x00\x01\x05\x01\x01\x01\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00");
            _local_2.writeUTFBytes("\x00\x01\x02\x03\x04\x05\x06\x07\b\t\n\x0B");
            _local_2.position = (_local_2.position + 1);
            _local_2.writeUTFBytes("\x00\x02\x01\x03\x03\x02\x04\x03\x05\x05\x04\x04\x00\x00\x01}");
            var _local_4:Array = [197121, 302321924, 104935713, 123818259, 840200482, 144806273, -1045347805, -254717419, 1919038244, 369756546, 437852183, 673654309, 892611113, 959985462, 1162101562, 1229473606, 1431589706, 1498961750, 1701077850, 1768449894, 1970565994, 2037938038, -2054913158, -1987541114, -1802268022, -1734895979, -1549624679, -1482250844, -1297438296, -1229605709, -1162233673, -976960574, -909588538, -724315446, -656943403, -488514855, -421141277, -353769241, -185339151, -117967115, 64249];
            var _local_3:int;
            do 
            {
                si32(_local_4[_local_3], (46 + (_local_3 << 2)));
            } while (++_local_3 < 41);
            _local_2.position = 208;
            _local_2.position = (_local_2.position + 1);
            _local_2.writeUTFBytes("\x00\x03\x01\x01\x01\x01\x01\x01\x01\x01\x01\x00\x00\x00\x00\x00");
            _local_2.writeBytes(_local_2, 17, 12);
            _local_2.position = (_local_2.position + 1);
            _local_2.writeUTFBytes("\x00\x02\x01\x02\x04\x04\x03\x04\x07\x05\x04\x04\x00\x01\x02w");
            _local_4 = [50462976, 553976849, 1091700273, 1902184273, -2127420909, -1857940472, 163688865, -263048413, -781032939, 874780170, 401679841, 639244568, 707340327, 943142453, 1145256505, 1212630597, 1414744649, 1482118741, 1684232793, 1751606885, 1953720937, 2021095029, -2088600967, -2021227132, -1836414584, -1768581997, -1701209961, -1515936862, -1448564826, -1263291734, -1195919691, -1010648391, -943274556, -758462008, -690629421, -623257385, -437984286, -370612250, -185339158, -117967115, 64249];
            _local_3 = 0;
            do 
            {
                si32(_local_4[_local_3], (254 + (_local_3 << 2)));
            } while (++_local_3 < 41);
            var _local_5:int;
            var _local_6:int;
            var _local_7:uint = 1;
            do 
            {
                _local_9 = li8(_local_7);
                _local_8 = 1;
                while (_local_8 <= _local_9)
                {
                    _local_10 = (416 + (li8(17 + _local_6) * 3));
                    si8(_local_7, _local_10);
                    si16(_local_5, (_local_10 + 1));
                    _local_6++;
                    _local_5++;
                    _local_8++;
                };
                _local_5 = (_local_5 << 1);
            } while (++_local_7 <= 16);
            _local_5 = 0;
            _local_6 = 0;
            _local_7 = 1;
            do 
            {
                _local_9 = li8(29 + _local_7);
                _local_8 = 1;
                while (_local_8 <= _local_9)
                {
                    _local_10 = (452 + (li8(46 + _local_6) * 3));
                    si8(_local_7, _local_10);
                    si16(_local_5, (_local_10 + 1));
                    _local_6++;
                    _local_5++;
                    _local_8++;
                };
                _local_5 = (_local_5 << 1);
            } while (++_local_7 <= 16);
            _local_5 = 0;
            _local_6 = 0;
            _local_7 = 1;
            do 
            {
                _local_9 = li8(208 + _local_7);
                _local_8 = 1;
                while (_local_8 <= _local_9)
                {
                    _local_10 = (1205 + (li8(225 + _local_6) * 3));
                    si8(_local_7, _local_10);
                    si16(_local_5, (_local_10 + 1));
                    _local_6++;
                    _local_5++;
                    _local_8++;
                };
                _local_5 = (_local_5 << 1);
            } while (++_local_7 <= 16);
            _local_5 = 0;
            _local_6 = 0;
            _local_7 = 1;
            do 
            {
                _local_9 = li8(237 + _local_7);
                _local_8 = 1;
                while (_local_8 <= _local_9)
                {
                    _local_10 = (1241 + (li8(254 + _local_6) * 3));
                    si8(_local_7, _local_10);
                    si16(_local_5, (_local_10 + 1));
                    _local_6++;
                    _local_5++;
                    _local_8++;
                };
                _local_5 = (_local_5 << 1);
            } while (++_local_7 <= 16);
            _local_2.position = 0;
            ApplicationDomain.currentDomain.domainMemory = _local_1;
            return (_local_2);
        }

        public static function createCategoryTable():ByteArray
        {
            var _local_5:uint;
            var _local_6:int;
            var _local_7:int;
            var _local_1:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            var _local_2:ByteArray = new ByteArray();
            _local_2.length = 196605;
            if (_local_2.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _local_2.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            };
            ApplicationDomain.currentDomain.domainMemory = _local_2;
            var _local_3:int = 1;
            var _local_4:int = 2;
            var _local_8:uint = 1;
            do 
            {
                _local_6 = _local_3;
                _local_7 = _local_4;
                do 
                {
                    _local_5 = ((32767 + _local_6) * 3);
                    si8(_local_8, _local_5);
                    si16(_local_6, (_local_5 + 1));
                } while (++_local_6 < _local_7);
                _local_6 = (-(_local_4) + 1);
                _local_7 = -(_local_3);
                do 
                {
                    _local_5 = ((32767 + _local_6) * 3);
                    si8(_local_8, _local_5);
                    si16(((_local_4 - 1) + _local_6), (_local_5 + 1));
                } while (++_local_6 <= _local_7);
                _local_3 = (_local_3 << 1);
                _local_4 = (_local_4 << 1);
            } while (++_local_8 <= 15);
            _local_2.position = 0;
            ApplicationDomain.currentDomain.domainMemory = _local_1;
            return (_local_2);
        }


    }
} by.blooddy.crypto.image

