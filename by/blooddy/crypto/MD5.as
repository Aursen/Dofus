package by.blooddy.crypto
{
    import flash.utils.ByteArray;
    import flash.system.ApplicationDomain;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public class MD5 
    {

        public function MD5():void
        {
        }

        public static function hash(_arg_1:String):String
        {
            var _local_2:ByteArray = new ByteArray();
            _local_2.writeUTFBytes(_arg_1);
            return (MD5.hashBytes(_local_2));
        }

        public static function hashBytes(_arg_1:ByteArray):String
        {
            var _local_2:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            var _local_3:uint = (_arg_1.length << 3);
            var _local_4:uint = (((((_local_3 + 64) >>> 9) << 4) + 15) << 2);
            var _local_6:uint = (_local_4 + 4);
            var _local_7:ByteArray = new ByteArray();
            if (_local_6 != 0)
            {
                _local_7.length = _local_6;
            };
            var _local_5:ByteArray = _local_7;
            _local_5.writeBytes(_arg_1);
            if (_local_5.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _local_5.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            };
            ApplicationDomain.currentDomain.domainMemory = _local_5;
            si32((li32((_local_3 >>> 5) << 2) | (128 << (_local_3 % 32))), ((_local_3 >>> 5) << 2));
            si32(_local_3, (_local_4 - 4));
            var _local_8:* = 1732584193;
            var _local_9:* = -271733879;
            var _local_10:* = -1732584194;
            var _local_11:* = 271733878;
            var _local_12:int = _local_8;
            var _local_13:int = _local_9;
            var _local_14:int = _local_10;
            var _local_15:int = _local_11;
            _local_3 = 0;
            do 
            {
                _local_12 = _local_8;
                _local_13 = _local_9;
                _local_14 = _local_10;
                _local_15 = _local_11;
                _local_8 = (_local_8 + ((((_local_9 & _local_10) | ((~(_local_9)) & _local_11)) + li32(_local_3)) + -680876936));
                _local_8 = (((_local_8 << 7) | (_local_8 >>> 25)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 & _local_9) | ((~(_local_8)) & _local_10)) + li32(_local_3 + 4)) + -389564586));
                _local_11 = (((_local_11 << 12) | (_local_11 >>> 20)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 & _local_8) | ((~(_local_11)) & _local_9)) + li32(_local_3 + 8)) + 606105819));
                _local_10 = (((_local_10 << 17) | (_local_10 >>> 15)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 & _local_11) | ((~(_local_10)) & _local_8)) + li32(_local_3 + 12)) + -1044525330));
                _local_9 = (((_local_9 << 22) | (_local_9 >>> 10)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 & _local_10) | ((~(_local_9)) & _local_11)) + li32(_local_3 + 16)) + -176418897));
                _local_8 = (((_local_8 << 7) | (_local_8 >>> 25)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 & _local_9) | ((~(_local_8)) & _local_10)) + li32(_local_3 + 20)) + 1200080426));
                _local_11 = (((_local_11 << 12) | (_local_11 >>> 20)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 & _local_8) | ((~(_local_11)) & _local_9)) + li32(_local_3 + 24)) + -1473231341));
                _local_10 = (((_local_10 << 17) | (_local_10 >>> 15)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 & _local_11) | ((~(_local_10)) & _local_8)) + li32(_local_3 + 28)) + -45705983));
                _local_9 = (((_local_9 << 22) | (_local_9 >>> 10)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 & _local_10) | ((~(_local_9)) & _local_11)) + li32(_local_3 + 32)) + 1770035416));
                _local_8 = (((_local_8 << 7) | (_local_8 >>> 25)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 & _local_9) | ((~(_local_8)) & _local_10)) + li32(_local_3 + 36)) + -1958414417));
                _local_11 = (((_local_11 << 12) | (_local_11 >>> 20)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 & _local_8) | ((~(_local_11)) & _local_9)) + li32(_local_3 + 40)) + -42063));
                _local_10 = (((_local_10 << 17) | (_local_10 >>> 15)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 & _local_11) | ((~(_local_10)) & _local_8)) + li32(_local_3 + 44)) + -1990404162));
                _local_9 = (((_local_9 << 22) | (_local_9 >>> 10)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 & _local_10) | ((~(_local_9)) & _local_11)) + li32(_local_3 + 48)) + 1804603682));
                _local_8 = (((_local_8 << 7) | (_local_8 >>> 25)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 & _local_9) | ((~(_local_8)) & _local_10)) + li32(_local_3 + 52)) + -40341101));
                _local_11 = (((_local_11 << 12) | (_local_11 >>> 20)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 & _local_8) | ((~(_local_11)) & _local_9)) + li32(_local_3 + 56)) + -1502002290));
                _local_10 = (((_local_10 << 17) | (_local_10 >>> 15)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 & _local_11) | ((~(_local_10)) & _local_8)) + li32(_local_3 + 60)) + 1236535329));
                _local_9 = (((_local_9 << 22) | (_local_9 >>> 10)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 & _local_11) | (_local_10 & (~(_local_11)))) + li32(_local_3 + 4)) + -165796510));
                _local_8 = (((_local_8 << 5) | (_local_8 >>> 27)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 & _local_10) | (_local_9 & (~(_local_10)))) + li32(_local_3 + 24)) + -1069501632));
                _local_11 = (((_local_11 << 9) | (_local_11 >>> 23)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 & _local_9) | (_local_8 & (~(_local_9)))) + li32(_local_3 + 44)) + 643717713));
                _local_10 = (((_local_10 << 14) | (_local_10 >>> 18)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 & _local_8) | (_local_11 & (~(_local_8)))) + li32(_local_3)) + -373897302));
                _local_9 = (((_local_9 << 20) | (_local_9 >>> 12)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 & _local_11) | (_local_10 & (~(_local_11)))) + li32(_local_3 + 20)) + -701558691));
                _local_8 = (((_local_8 << 5) | (_local_8 >>> 27)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 & _local_10) | (_local_9 & (~(_local_10)))) + li32(_local_3 + 40)) + 38016083));
                _local_11 = (((_local_11 << 9) | (_local_11 >>> 23)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 & _local_9) | (_local_8 & (~(_local_9)))) + li32(_local_3 + 60)) + -660478335));
                _local_10 = (((_local_10 << 14) | (_local_10 >>> 18)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 & _local_8) | (_local_11 & (~(_local_8)))) + li32(_local_3 + 16)) + -405537848));
                _local_9 = (((_local_9 << 20) | (_local_9 >>> 12)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 & _local_11) | (_local_10 & (~(_local_11)))) + li32(_local_3 + 36)) + 568446438));
                _local_8 = (((_local_8 << 5) | (_local_8 >>> 27)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 & _local_10) | (_local_9 & (~(_local_10)))) + li32(_local_3 + 56)) + -1019803690));
                _local_11 = (((_local_11 << 9) | (_local_11 >>> 23)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 & _local_9) | (_local_8 & (~(_local_9)))) + li32(_local_3 + 12)) + -187363961));
                _local_10 = (((_local_10 << 14) | (_local_10 >>> 18)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 & _local_8) | (_local_11 & (~(_local_8)))) + li32(_local_3 + 32)) + 1163531501));
                _local_9 = (((_local_9 << 20) | (_local_9 >>> 12)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 & _local_11) | (_local_10 & (~(_local_11)))) + li32(_local_3 + 52)) + -1444681467));
                _local_8 = (((_local_8 << 5) | (_local_8 >>> 27)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 & _local_10) | (_local_9 & (~(_local_10)))) + li32(_local_3 + 8)) + -51403784));
                _local_11 = (((_local_11 << 9) | (_local_11 >>> 23)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 & _local_9) | (_local_8 & (~(_local_9)))) + li32(_local_3 + 28)) + 1735328473));
                _local_10 = (((_local_10 << 14) | (_local_10 >>> 18)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 & _local_8) | (_local_11 & (~(_local_8)))) + li32(_local_3 + 48)) + -1926607734));
                _local_9 = (((_local_9 << 20) | (_local_9 >>> 12)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 ^ _local_10) ^ _local_11) + li32(_local_3 + 20)) + -378558));
                _local_8 = (((_local_8 << 4) | (_local_8 >>> 28)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 ^ _local_9) ^ _local_10) + li32(_local_3 + 32)) + -2022574463));
                _local_11 = (((_local_11 << 11) | (_local_11 >>> 21)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 ^ _local_8) ^ _local_9) + li32(_local_3 + 44)) + 1839030562));
                _local_10 = (((_local_10 << 16) | (_local_10 >>> 16)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 ^ _local_11) ^ _local_8) + li32(_local_3 + 56)) + -35309556));
                _local_9 = (((_local_9 << 23) | (_local_9 >>> 9)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 ^ _local_10) ^ _local_11) + li32(_local_3 + 4)) + -1530992060));
                _local_8 = (((_local_8 << 4) | (_local_8 >>> 28)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 ^ _local_9) ^ _local_10) + li32(_local_3 + 16)) + 1272893353));
                _local_11 = (((_local_11 << 11) | (_local_11 >>> 21)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 ^ _local_8) ^ _local_9) + li32(_local_3 + 28)) + -155497632));
                _local_10 = (((_local_10 << 16) | (_local_10 >>> 16)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 ^ _local_11) ^ _local_8) + li32(_local_3 + 40)) + -1094730640));
                _local_9 = (((_local_9 << 23) | (_local_9 >>> 9)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 ^ _local_10) ^ _local_11) + li32(_local_3 + 52)) + 681279174));
                _local_8 = (((_local_8 << 4) | (_local_8 >>> 28)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 ^ _local_9) ^ _local_10) + li32(_local_3)) + -358537222));
                _local_11 = (((_local_11 << 11) | (_local_11 >>> 21)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 ^ _local_8) ^ _local_9) + li32(_local_3 + 12)) + -722521979));
                _local_10 = (((_local_10 << 16) | (_local_10 >>> 16)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 ^ _local_11) ^ _local_8) + li32(_local_3 + 24)) + 76029189));
                _local_9 = (((_local_9 << 23) | (_local_9 >>> 9)) + _local_10);
                _local_8 = (_local_8 + ((((_local_9 ^ _local_10) ^ _local_11) + li32(_local_3 + 36)) + -640364487));
                _local_8 = (((_local_8 << 4) | (_local_8 >>> 28)) + _local_9);
                _local_11 = (_local_11 + ((((_local_8 ^ _local_9) ^ _local_10) + li32(_local_3 + 48)) + -421815835));
                _local_11 = (((_local_11 << 11) | (_local_11 >>> 21)) + _local_8);
                _local_10 = (_local_10 + ((((_local_11 ^ _local_8) ^ _local_9) + li32(_local_3 + 60)) + 530742520));
                _local_10 = (((_local_10 << 16) | (_local_10 >>> 16)) + _local_11);
                _local_9 = (_local_9 + ((((_local_10 ^ _local_11) ^ _local_8) + li32(_local_3 + 8)) + -995338651));
                _local_9 = (((_local_9 << 23) | (_local_9 >>> 9)) + _local_10);
                _local_8 = (_local_8 + (((_local_10 ^ (_local_9 | (~(_local_11)))) + li32(_local_3)) + -198630844));
                _local_8 = (((_local_8 << 6) | (_local_8 >>> 26)) + _local_9);
                _local_11 = (_local_11 + (((_local_9 ^ (_local_8 | (~(_local_10)))) + li32(_local_3 + 28)) + 1126891415));
                _local_11 = (((_local_11 << 10) | (_local_11 >>> 22)) + _local_8);
                _local_10 = (_local_10 + (((_local_8 ^ (_local_11 | (~(_local_9)))) + li32(_local_3 + 56)) + -1416354905));
                _local_10 = (((_local_10 << 15) | (_local_10 >>> 17)) + _local_11);
                _local_9 = (_local_9 + (((_local_11 ^ (_local_10 | (~(_local_8)))) + li32(_local_3 + 20)) + -57434055));
                _local_9 = (((_local_9 << 21) | (_local_9 >>> 11)) + _local_10);
                _local_8 = (_local_8 + (((_local_10 ^ (_local_9 | (~(_local_11)))) + li32(_local_3 + 48)) + 1700485571));
                _local_8 = (((_local_8 << 6) | (_local_8 >>> 26)) + _local_9);
                _local_11 = (_local_11 + (((_local_9 ^ (_local_8 | (~(_local_10)))) + li32(_local_3 + 12)) + -1894986606));
                _local_11 = (((_local_11 << 10) | (_local_11 >>> 22)) + _local_8);
                _local_10 = (_local_10 + (((_local_8 ^ (_local_11 | (~(_local_9)))) + li32(_local_3 + 40)) + -1051523));
                _local_10 = (((_local_10 << 15) | (_local_10 >>> 17)) + _local_11);
                _local_9 = (_local_9 + (((_local_11 ^ (_local_10 | (~(_local_8)))) + li32(_local_3 + 4)) + -2054922799));
                _local_9 = (((_local_9 << 21) | (_local_9 >>> 11)) + _local_10);
                _local_8 = (_local_8 + (((_local_10 ^ (_local_9 | (~(_local_11)))) + li32(_local_3 + 32)) + 1873313359));
                _local_8 = (((_local_8 << 6) | (_local_8 >>> 26)) + _local_9);
                _local_11 = (_local_11 + (((_local_9 ^ (_local_8 | (~(_local_10)))) + li32(_local_3 + 60)) + -30611744));
                _local_11 = (((_local_11 << 10) | (_local_11 >>> 22)) + _local_8);
                _local_10 = (_local_10 + (((_local_8 ^ (_local_11 | (~(_local_9)))) + li32(_local_3 + 24)) + -1560198380));
                _local_10 = (((_local_10 << 15) | (_local_10 >>> 17)) + _local_11);
                _local_9 = (_local_9 + (((_local_11 ^ (_local_10 | (~(_local_8)))) + li32(_local_3 + 52)) + 1309151649));
                _local_9 = (((_local_9 << 21) | (_local_9 >>> 11)) + _local_10);
                _local_8 = (_local_8 + (((_local_10 ^ (_local_9 | (~(_local_11)))) + li32(_local_3 + 16)) + -145523070));
                _local_8 = (((_local_8 << 6) | (_local_8 >>> 26)) + _local_9);
                _local_11 = (_local_11 + (((_local_9 ^ (_local_8 | (~(_local_10)))) + li32(_local_3 + 44)) + -1120210379));
                _local_11 = (((_local_11 << 10) | (_local_11 >>> 22)) + _local_8);
                _local_10 = (_local_10 + (((_local_8 ^ (_local_11 | (~(_local_9)))) + li32(_local_3 + 8)) + 718787259));
                _local_10 = (((_local_10 << 15) | (_local_10 >>> 17)) + _local_11);
                _local_9 = (_local_9 + (((_local_11 ^ (_local_10 | (~(_local_8)))) + li32(_local_3 + 36)) + -343485551));
                _local_9 = (((_local_9 << 21) | (_local_9 >>> 11)) + _local_10);
                _local_8 = (_local_8 + _local_12);
                _local_9 = (_local_9 + _local_13);
                _local_10 = (_local_10 + _local_14);
                _local_11 = (_local_11 + _local_15);
                _local_3 = (_local_3 + 64);
            } while (_local_3 < _local_4);
            _local_5.position = 0;
            _local_5.writeUTFBytes("0123456789abcdef");
            si32(_local_8, 16);
            si32(_local_9, 20);
            si32(_local_10, 24);
            si32(_local_11, 28);
            _local_9 = 31;
            _local_3 = 16;
            do 
            {
                _local_8 = li8(_local_3);
                si8(li8(_local_8 >>> 4), ++_local_9);
                si8(li8(_local_8 & 0x0F), ++_local_9);
            } while (++_local_3 < 32);
            ApplicationDomain.currentDomain.domainMemory = _local_2;
            _local_5.position = 32;
            return (_local_5.readUTFBytes(32));
        }


    }
} by.blooddy.crypto

