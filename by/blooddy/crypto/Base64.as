package by.blooddy.crypto
{
    import flash.system.ApplicationDomain;
    import flash.utils.ByteArray;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public class Base64 
    {

        public function Base64():void
        {
        }

        public static function encode(_arg_1:ByteArray, _arg_2:Boolean=false):String
        {
            var _local_11:int;
            var _local_12:uint;
            var _local_3:uint = _arg_1.length;
            var _local_4:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            var _local_5:ByteArray = new ByteArray();
            _local_5.writeUTFBytes("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/");
            _local_5.writeBytes(_arg_1);
            var _local_6:uint = (_local_3 % 3);
            var _local_7:uint = (((64 + _local_3) - _local_6) - 1);
            var _local_8:uint = ((int((_local_3 / 3)) << 2) + ((_local_6 > 0) ? 4 : 0));
            _local_5.length = (_local_5.length + (_local_8 + ((_arg_2) ? int((_local_8 / 76)) : 0)));
            if (_local_5.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _local_5.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            };
            ApplicationDomain.currentDomain.domainMemory = _local_5;
            var _local_9:uint = 63;
            var _local_10:uint = (64 + _local_3);
            while (_local_9 < _local_7)
            {
                _local_11 = (((li8(++_local_9) << 16) | (li8(++_local_9) << 8)) | li8(++_local_9));
                si32((((li8(_local_11 >>> 18) | (li8((_local_11 >>> 12) & 0x3F) << 8)) | (li8((_local_11 >>> 6) & 0x3F) << 16)) | (li8(_local_11 & 0x3F) << 24)), _local_10);
                _local_10 = (_local_10 + 4);
                if (((_arg_2) && ((((_local_9 - 64) + 1) % 57) == 0)))
                {
                    _local_12 = _local_10;
                    _local_10 = (_local_12 + 1);
                    si8(10, _local_12);
                };
            };
            switch (_local_6)
            {
                default:
                    break;
                case 1:
                    _local_11 = li8(++_local_9);
                    si32(((li8(_local_11 >>> 2) | (li8((_local_11 & 0x03) << 4) << 8)) | 0x3D3D0000), _local_10);
                    break;
                case 2:
                    _local_11 = ((li8(++_local_9) << 8) | li8(++_local_9));
                    si32((((li8(_local_11 >>> 10) | (li8((_local_11 >>> 4) & 0x3F) << 8)) | (li8((_local_11 & 0x0F) << 2) << 16)) | 0x3D000000), _local_10);
            };
            _local_5.position = (64 + _local_3);
            var _local_13:String = _local_5.readUTFBytes(_local_5.bytesAvailable);
            ApplicationDomain.currentDomain.domainMemory = _local_4;
            return (_local_13);
        }

        public static function decode(_arg_1:String):ByteArray
        {
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_2:uint = (_arg_1.length * 0.75);
            var _local_3:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            var _local_4:ByteArray = new ByteArray();
            _local_4.writeUTFBytes("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@>@@@?456789:;<=@@@@@@@\x00\x01\x02\x03\x04\x05\x06\x07\b\t\n\x0B\f\r\x0E\x0F\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19@@@@@@\x1A\x1B\x1C\x1D\x1E\x1F !\"#$%&'()*+,-./0123@@@@@");
            _local_4.writeUTFBytes(_arg_1);
            var _local_5:uint = ((_local_4.length - 4) - 1);
            if (_local_4.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _local_4.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            };
            ApplicationDomain.currentDomain.domainMemory = _local_4;
            var _local_6:* = (li8(204) == 10);
            var _local_7:uint = 127;
            var _local_8:uint = 127;
            while (_local_7 < _local_5)
            {
                _local_13 = li8(++_local_7);
                if ((_local_13 & 0x80) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
                _local_13 = li8(_local_13);
                if (_local_13 == 64)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
                _local_9 = _local_13;
                _local_13 = li8(++_local_7);
                if ((_local_13 & 0x80) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
                _local_13 = li8(_local_13);
                if (_local_13 == 64)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
                _local_10 = _local_13;
                _local_13 = li8(++_local_7);
                if ((_local_13 & 0x80) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
                _local_13 = li8(_local_13);
                if (_local_13 == 64)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
                _local_11 = _local_13;
                _local_13 = li8(++_local_7);
                if ((_local_13 & 0x80) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
                _local_13 = li8(_local_13);
                if (_local_13 == 64)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
                _local_12 = _local_13;
                si8(((_local_9 << 2) | (_local_10 >> 4)), ++_local_8);
                si8(((_local_10 << 4) | (_local_11 >> 2)), ++_local_8);
                si8(((_local_11 << 6) | _local_12), ++_local_8);
                if (((_local_6) && (((((_local_8 - 128) + 1) % 57) == (0)) && (!(li8(++_local_7) == 10)))))
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
            };
            if (_local_7 != _local_5)
            {
                ApplicationDomain.currentDomain.domainMemory = _local_3;
                Error.throwError(VerifyError, 1509);
            };
            _local_13 = li8(++_local_7);
            if ((_local_13 & 0x80) != 0)
            {
                ApplicationDomain.currentDomain.domainMemory = _local_3;
                Error.throwError(VerifyError, 1509);
            };
            _local_13 = li8(_local_13);
            if (_local_13 == 64)
            {
                ApplicationDomain.currentDomain.domainMemory = _local_3;
                Error.throwError(VerifyError, 1509);
            };
            _local_9 = _local_13;
            _local_13 = li8(++_local_7);
            if ((_local_13 & 0x80) != 0)
            {
                ApplicationDomain.currentDomain.domainMemory = _local_3;
                Error.throwError(VerifyError, 1509);
            };
            _local_13 = li8(_local_13);
            if (_local_13 == 64)
            {
                ApplicationDomain.currentDomain.domainMemory = _local_3;
                Error.throwError(VerifyError, 1509);
            };
            _local_10 = _local_13;
            si8(((_local_9 << 2) | (_local_10 >> 4)), ++_local_8);
            _local_13 = li8(++_local_7);
            if ((_local_13 & 0x80) != 0)
            {
                ApplicationDomain.currentDomain.domainMemory = _local_3;
                Error.throwError(VerifyError, 1509);
            };
            if (_local_13 == 61)
            {
                _local_13 = -1;
            }
            else
            {
                _local_13 = li8(_local_13);
                if (_local_13 == 64)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
            };
            _local_11 = _local_13;
            if (_local_11 != -1)
            {
                si8(((_local_10 << 4) | (_local_11 >> 2)), ++_local_8);
                _local_13 = li8(++_local_7);
                if ((_local_13 & 0x80) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
                if (_local_13 == 61)
                {
                    _local_13 = -1;
                }
                else
                {
                    _local_13 = li8(_local_13);
                    if (_local_13 == 64)
                    {
                        ApplicationDomain.currentDomain.domainMemory = _local_3;
                        Error.throwError(VerifyError, 1509);
                    };
                };
                _local_12 = _local_13;
                if (_local_12 != -1)
                {
                    si8(((_local_11 << 6) | _local_12), ++_local_8);
                };
            }
            else
            {
                _local_13 = li8(++_local_7);
                if ((_local_13 & 0x80) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
                if (_local_13 == 61)
                {
                    _local_13 = -1;
                }
                else
                {
                    _local_13 = li8(_local_13);
                    if (_local_13 == 64)
                    {
                        ApplicationDomain.currentDomain.domainMemory = _local_3;
                        Error.throwError(VerifyError, 1509);
                    };
                };
                if (_local_13 != -1)
                {
                    ApplicationDomain.currentDomain.domainMemory = _local_3;
                    Error.throwError(VerifyError, 1509);
                };
            };
            ApplicationDomain.currentDomain.domainMemory = _local_3;
            var _local_14:ByteArray = new ByteArray();
            _local_14.writeBytes(_local_4, 128, ((_local_8 - 128) + 1));
            _local_14.position = 0;
            return (_local_14);
        }


    }
} by.blooddy.crypto

