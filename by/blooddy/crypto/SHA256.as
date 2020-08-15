package by.blooddy.crypto
{
    import flash.utils.ByteArray;
    import flash.system.ApplicationDomain;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public class SHA256 
    {

        public function SHA256():void
        {
        }

        public static function hash(_arg_1:String):String
        {
            var _local_2:ByteArray = new ByteArray();
            _local_2.writeUTFBytes(_arg_1);
            return (SHA256.hashBytes(_local_2));
        }

        public static function hashBytes(_arg_1:ByteArray):String
        {
            var _local_14:uint;
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
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
            var _local_2:* = 1779033703;
            var _local_3:* = -1150833019;
            var _local_4:* = 1013904242;
            var _local_5:* = -1521486534;
            var _local_6:* = 1359893119;
            var _local_7:* = -1694144372;
            var _local_8:* = 528734635;
            var _local_9:* = 1541459225;
            var _local_10:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            var _local_11:uint = (_arg_1.length << 3);
            var _local_12:uint = (0x0200 + (((((_local_11 + 64) >>> 9) << 4) + 15) << 2));
            _local_14 = (_local_12 + 4);
            var _local_15:ByteArray = new ByteArray();
            if (_local_14 != 0)
            {
                _local_15.length = _local_14;
            };
            var _local_13:ByteArray = _local_15;
            _local_13.position = 0x0200;
            _local_13.writeBytes(_arg_1);
            if (_local_13.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _local_13.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            };
            ApplicationDomain.currentDomain.domainMemory = _local_13;
            si32((li32(0x0200 + ((_local_11 >>> 5) << 2)) | (128 << (_local_11 % 32))), (0x0200 + ((_local_11 >>> 5) << 2)));
            si8((_local_11 >> 24), _local_12);
            si8((_local_11 >> 16), (_local_12 + 1));
            si8((_local_11 >> 8), (_local_12 + 2));
            si8(_local_11, (_local_12 + 3));
            var _local_16:Array = [1116352408, 1899447441, -1245643825, -373957723, 961987163, 1508970993, -1841331548, -1424204075, -670586216, 310598401, 607225278, 1426881987, 1925078388, -2132889090, -1680079193, -1046744716, -459576895, -272742522, 264347078, 604807628, 770255983, 1249150122, 1555081692, 1996064986, -1740746414, -1473132947, -1341970488, -1084653625, -958395405, -710438585, 113926993, 338241895, 666307205, 773529912, 1294757372, 1396182291, 1695183700, 1986661051, -2117940946, -1838011259, -1564481375, -1474664885, -1035236496, -949202525, -778901479, -694614492, -200395387, 275423344, 430227734, 506948616, 659060556, 883997877, 958139571, 1322822218, 1537002063, 1747873779, 1955562222, 2024104815, -2067236844, -1933114872, -1866530822, -1538233109, -1090935817, -965641998];
            _local_11 = 0;
            do 
            {
                si32(_local_16[_local_11], (0x0100 + (_local_11 << 2)));
            } while (++_local_11 < 64);
            _local_11 = 0x0200;
            do 
            {
                _local_17 = _local_2;
                _local_18 = _local_3;
                _local_19 = _local_4;
                _local_20 = _local_5;
                _local_21 = _local_6;
                _local_22 = _local_7;
                _local_23 = _local_8;
                _local_24 = _local_9;
                _local_14 = 0;
                do 
                {
                    _local_27 = ((((li8(_local_11 + _local_14) << 24) | (li8((_local_11 + _local_14) + 1) << 16)) | (li8((_local_11 + _local_14) + 2) << 8)) | li8((_local_11 + _local_14) + 3));
                    si32(_local_27, _local_14);
                    _local_29 = ((((_local_24 + ((((_local_21 << 26) | (_local_21 >>> 6)) ^ ((_local_21 << 21) | (_local_21 >>> 11))) ^ ((_local_21 << 7) | (_local_21 >>> 25)))) + ((_local_21 & _local_22) ^ ((~(_local_21)) & _local_23))) + li32(0x0100 + _local_14)) + _local_27);
                    _local_28 = (((((_local_17 << 30) | (_local_17 >>> 2)) ^ ((_local_17 << 19) | (_local_17 >>> 13))) ^ ((_local_17 << 10) | (_local_17 >>> 22))) + (((_local_17 & _local_18) ^ (_local_17 & _local_19)) ^ (_local_18 & _local_19)));
                    _local_24 = _local_23;
                    _local_23 = _local_22;
                    _local_22 = _local_21;
                    _local_21 = (_local_20 + _local_29);
                    _local_20 = _local_19;
                    _local_19 = _local_18;
                    _local_18 = _local_17;
                    _local_17 = (_local_29 + _local_28);
                    _local_14 = (_local_14 + 4);
                } while (_local_14 < 64);
                do 
                {
                    _local_25 = li32(_local_14 - 8);
                    _local_26 = li32(_local_14 - 60);
                    _local_27 = (((((((_local_25 << 15) | (_local_25 >>> 17)) ^ ((_local_25 << 13) | (_local_25 >>> 19))) ^ (_local_25 >>> 10)) + li32(_local_14 - 28)) + ((((_local_26 << 25) | (_local_26 >>> 7)) ^ ((_local_26 << 14) | (_local_26 >>> 18))) ^ (_local_26 >>> 3))) + li32(_local_14 - 64));
                    si32(_local_27, _local_14);
                    _local_29 = ((((_local_24 + ((((_local_21 << 26) | (_local_21 >>> 6)) ^ ((_local_21 << 21) | (_local_21 >>> 11))) ^ ((_local_21 << 7) | (_local_21 >>> 25)))) + ((_local_21 & _local_22) ^ ((~(_local_21)) & _local_23))) + li32(0x0100 + _local_14)) + _local_27);
                    _local_28 = (((((_local_17 << 30) | (_local_17 >>> 2)) ^ ((_local_17 << 19) | (_local_17 >>> 13))) ^ ((_local_17 << 10) | (_local_17 >>> 22))) + (((_local_17 & _local_18) ^ (_local_17 & _local_19)) ^ (_local_18 & _local_19)));
                    _local_24 = _local_23;
                    _local_23 = _local_22;
                    _local_22 = _local_21;
                    _local_21 = (_local_20 + _local_29);
                    _local_20 = _local_19;
                    _local_19 = _local_18;
                    _local_18 = _local_17;
                    _local_17 = (_local_29 + _local_28);
                    _local_14 = (_local_14 + 4);
                } while (_local_14 < 0x0100);
                _local_2 = (_local_2 + _local_17);
                _local_3 = (_local_3 + _local_18);
                _local_4 = (_local_4 + _local_19);
                _local_5 = (_local_5 + _local_20);
                _local_6 = (_local_6 + _local_21);
                _local_7 = (_local_7 + _local_22);
                _local_8 = (_local_8 + _local_23);
                _local_9 = (_local_9 + _local_24);
                _local_11 = (_local_11 + 64);
            } while (_local_11 < _local_12);
            _local_13.position = 0;
            _local_13.writeUTFBytes("0123456789abcdef");
            si8((_local_2 >> 24), 16);
            si8((_local_2 >> 16), 17);
            si8((_local_2 >> 8), 18);
            si8(_local_2, 19);
            si8((_local_3 >> 24), 20);
            si8((_local_3 >> 16), 21);
            si8((_local_3 >> 8), 22);
            si8(_local_3, 23);
            si8((_local_4 >> 24), 24);
            si8((_local_4 >> 16), 25);
            si8((_local_4 >> 8), 26);
            si8(_local_4, 27);
            si8((_local_5 >> 24), 28);
            si8((_local_5 >> 16), 29);
            si8((_local_5 >> 8), 30);
            si8(_local_5, 31);
            si8((_local_6 >> 24), 32);
            si8((_local_6 >> 16), 33);
            si8((_local_6 >> 8), 34);
            si8(_local_6, 35);
            si8((_local_7 >> 24), 36);
            si8((_local_7 >> 16), 37);
            si8((_local_7 >> 8), 38);
            si8(_local_7, 39);
            si8((_local_8 >> 24), 40);
            si8((_local_8 >> 16), 41);
            si8((_local_8 >> 8), 42);
            si8(_local_8, 43);
            si8((_local_9 >> 24), 44);
            si8((_local_9 >> 16), 45);
            si8((_local_9 >> 8), 46);
            si8(_local_9, 47);
            _local_18 = 47;
            _local_11 = 16;
            do 
            {
                _local_17 = li8(_local_11);
                si8(li8(_local_17 >>> 4), ++_local_18);
                si8(li8(_local_17 & 0x0F), ++_local_18);
            } while (++_local_11 < 48);
            ApplicationDomain.currentDomain.domainMemory = _local_10;
            _local_13.position = 48;
            return (_local_13.readUTFBytes(64));
        }


    }
}

