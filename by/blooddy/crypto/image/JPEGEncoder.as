package by.blooddy.crypto.image
{
    import flash.system.ApplicationDomain;
    import flash.utils.ByteArray;
    import flash.display.BitmapData;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public class JPEGEncoder 
    {

        public function JPEGEncoder():void
        {
        }

        public static function encode(_arg_1:BitmapData, _arg_2:uint=60):ByteArray
        {
            var _local_7:uint;
            var _local_9:uint;
            var _local_16:uint;
            var _local_17:uint;
            var _local_18:uint;
            var _local_19:uint;
            var _local_20:uint;
            var _local_21:uint;
            var _local_22:int;
            var _local_23:Number;
            var _local_24:Number;
            var _local_25:Number;
            var _local_26:Number;
            var _local_27:Number;
            var _local_28:Number;
            var _local_29:Number;
            var _local_30:Number;
            var _local_31:Number;
            var _local_32:Number;
            var _local_33:Number;
            var _local_34:Number;
            var _local_35:Number;
            var _local_36:Number;
            var _local_37:Number;
            var _local_38:Number;
            var _local_39:Number;
            var _local_40:Number;
            var _local_41:Number;
            var _local_42:Number;
            var _local_43:Number;
            var _local_44:Number;
            var _local_45:Number;
            var _local_46:Number;
            var _local_47:Number;
            var _local_48:Number;
            var _local_49:Number;
            var _local_50:Number;
            var _local_51:int;
            var _local_52:int;
            var _local_53:int;
            var _local_54:int;
            var _local_55:int;
            var _local_56:int;
            var _local_57:int;
            if (_arg_1 == null)
            {
                Error.throwError(TypeError, 2007, "image");
            };
            if (_arg_2 > 100)
            {
                Error.throwError(RangeError, 2006, "quality");
            };
            var _local_3:ByteArray = ApplicationDomain.currentDomain.domainMemory;
            var _local_4:uint = _arg_1.width;
            var _local_5:uint = _arg_1.height;
            var _local_6:ByteArray = new ByteArray();
            _local_6.position = 0x0700;
            _local_6.writeBytes(JPEGTable.getTable(_arg_2));
            _local_6.length = (_local_6.length + (680 + ((_local_4 * _local_5) * 3)));
            if (_local_6.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _local_6.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            };
            ApplicationDomain.currentDomain.domainMemory = _local_6;
            si16(55551, 201609);
            _local_7 = 201611;
            si16(57599, _local_7);
            si16(0x1000, (_local_7 + 2));
            si32(1179207242, (_local_7 + 4));
            si8(0, (_local_7 + 8));
            si16(0x0101, (_local_7 + 9));
            si8(0, (_local_7 + 11));
            si32(16777472, (_local_7 + 12));
            si16(0, (_local_7 + 16));
            _local_7 = 201629;
            si16(57855, _local_7);
            si16(0x4600, (_local_7 + 2));
            si32(1718188101, (_local_7 + 4));
            si16(0, (_local_7 + 8));
            si32(2771273, (_local_7 + 10));
            si32(8, (_local_7 + 14));
            si16(1, (_local_7 + 18));
            si16(305, (_local_7 + 20));
            si16(2, (_local_7 + 22));
            si32(35, (_local_7 + 24));
            si32(26, (_local_7 + 28));
            si32(0, (_local_7 + 32));
            _local_6.position = (_local_7 + 36);
            _local_6.writeMultiByte("by.blooddy.crypto.image.JPEGEncoder", "x-ascii");
            si8(0, (_local_7 + 71));
            _local_7 = 201701;
            si16(56319, _local_7);
            si16(0x8400, (_local_7 + 2));
            _local_6.position = (_local_7 + 4);
            _local_6.writeBytes(_local_6, 0x0700, 130);
            si8(0, (_local_7 + 4));
            si8(1, (_local_7 + 69));
            _local_7 = 201835;
            var _local_8:uint = _arg_1.width;
            _local_9 = _arg_1.height;
            si16(49407, _local_7);
            si16(0x1100, (_local_7 + 2));
            si8(8, (_local_7 + 4));
            si16((((_local_9 >> 8) & 0xFF) | ((_local_9 & 0xFF) << 8)), (_local_7 + 5));
            si16((((_local_8 >> 8) & 0xFF) | ((_local_8 & 0xFF) << 8)), (_local_7 + 7));
            si8(3, (_local_7 + 9));
            si32(4353, (_local_7 + 10));
            si32(69890, (_local_7 + 13));
            si32(69891, (_local_7 + 16));
            _local_7 = 201854;
            si16(50431, _local_7);
            si16(41473, (_local_7 + 2));
            _local_6.position = (_local_7 + 4);
            _local_6.writeBytes(_local_6, 3010, 416);
            si8(0, (_local_7 + 4));
            si8(16, (_local_7 + 33));
            si8(1, (_local_7 + 212));
            si8(17, (_local_7 + 241));
            _local_7 = 202274;
            si16(56063, _local_7);
            si16(0x0C00, (_local_7 + 2));
            si8(3, (_local_7 + 4));
            si16(1, (_local_7 + 5));
            si16(4354, (_local_7 + 7));
            si16(4355, (_local_7 + 9));
            si32(0x3F00, (_local_7 + 11));
            var _local_10:* = 202288;
            var _local_11:int = 7;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            _local_8 = 0;
            do 
            {
                _local_7 = 0;
                do 
                {
                    _local_9 = 0;
                    _local_16 = (_local_7 + 8);
                    _local_17 = (_local_8 + 8);
                    do 
                    {
                        do 
                        {
                            _local_18 = _arg_1.getPixel(_local_7, _local_8);
                            _local_19 = (_local_18 >>> 16);
                            _local_20 = ((_local_18 >> 8) & 0xFF);
                            _local_21 = (_local_18 & 0xFF);
                            sf64(((((0.299 * _local_19) + (0.587 * _local_20)) + (0.114 * _local_21)) - 128), (0x0100 + _local_9));
                            sf64((((-0.16874 * _local_19) - (0.33126 * _local_20)) + (0.5 * _local_21)), (0x0300 + _local_9));
                            sf64((((0.5 * _local_19) - (0.41869 * _local_20)) - (0.08131 * _local_21)), (0x0500 + _local_9));
                            _local_9 = (_local_9 + 8);
                        } while (++_local_7 < _local_16);
                        _local_7 = (_local_7 - 8);
                    } while (++_local_8 < _local_17);
                    _local_8 = (_local_8 - 8);
                    _local_9 = 0x0100;
                    _local_22 = _local_13;
                    _local_16 = 3426;
                    _local_17 = 3462;
                    _local_18 = 0;
                    do 
                    {
                        _local_23 = lf64(_local_9 + _local_18);
                        _local_24 = lf64((_local_9 + _local_18) + 8);
                        _local_25 = lf64((_local_9 + _local_18) + 16);
                        _local_26 = lf64((_local_9 + _local_18) + 24);
                        _local_27 = lf64((_local_9 + _local_18) + 32);
                        _local_28 = lf64((_local_9 + _local_18) + 40);
                        _local_29 = lf64((_local_9 + _local_18) + 48);
                        _local_30 = lf64((_local_9 + _local_18) + 56);
                        _local_31 = (_local_23 + _local_30);
                        _local_38 = (_local_23 - _local_30);
                        _local_32 = (_local_24 + _local_29);
                        _local_37 = (_local_24 - _local_29);
                        _local_33 = (_local_25 + _local_28);
                        _local_36 = (_local_25 - _local_28);
                        _local_34 = (_local_26 + _local_27);
                        _local_35 = (_local_26 - _local_27);
                        _local_39 = (_local_31 + _local_34);
                        _local_42 = (_local_31 - _local_34);
                        _local_40 = (_local_32 + _local_33);
                        _local_41 = (_local_32 - _local_33);
                        sf64((_local_39 + _local_40), (_local_9 + _local_18));
                        sf64((_local_39 - _local_40), ((_local_9 + _local_18) + 32));
                        _local_43 = ((_local_41 + _local_42) * 0.707106781);
                        sf64((_local_42 + _local_43), ((_local_9 + _local_18) + 16));
                        sf64((_local_42 - _local_43), ((_local_9 + _local_18) + 48));
                        _local_39 = (_local_35 + _local_36);
                        _local_40 = (_local_36 + _local_37);
                        _local_41 = (_local_37 + _local_38);
                        _local_47 = ((_local_39 - _local_41) * 0.382683433);
                        _local_44 = ((0.5411961 * _local_39) + _local_47);
                        _local_46 = ((1.306562965 * _local_41) + _local_47);
                        _local_45 = (_local_40 * 0.707106781);
                        _local_48 = (_local_38 + _local_45);
                        _local_49 = (_local_38 - _local_45);
                        sf64((_local_49 + _local_44), ((_local_9 + _local_18) + 40));
                        sf64((_local_49 - _local_44), ((_local_9 + _local_18) + 24));
                        sf64((_local_48 + _local_46), ((_local_9 + _local_18) + 8));
                        sf64((_local_48 - _local_46), ((_local_9 + _local_18) + 56));
                        _local_18 = (_local_18 + 64);
                    } while (_local_18 < 0x0200);
                    _local_18 = 0;
                    do 
                    {
                        _local_23 = lf64(_local_9 + _local_18);
                        _local_24 = lf64((_local_9 + _local_18) + 64);
                        _local_25 = lf64((_local_9 + _local_18) + 128);
                        _local_26 = lf64((_local_9 + _local_18) + 192);
                        _local_27 = lf64((_local_9 + _local_18) + 0x0100);
                        _local_28 = lf64((_local_9 + _local_18) + 320);
                        _local_29 = lf64((_local_9 + _local_18) + 384);
                        _local_30 = lf64((_local_9 + _local_18) + 448);
                        _local_31 = (_local_23 + _local_30);
                        _local_38 = (_local_23 - _local_30);
                        _local_32 = (_local_24 + _local_29);
                        _local_37 = (_local_24 - _local_29);
                        _local_33 = (_local_25 + _local_28);
                        _local_36 = (_local_25 - _local_28);
                        _local_34 = (_local_26 + _local_27);
                        _local_35 = (_local_26 - _local_27);
                        _local_39 = (_local_31 + _local_34);
                        _local_42 = (_local_31 - _local_34);
                        _local_40 = (_local_32 + _local_33);
                        _local_41 = (_local_32 - _local_33);
                        sf64((_local_39 + _local_40), (_local_9 + _local_18));
                        sf64((_local_39 - _local_40), ((_local_9 + _local_18) + 0x0100));
                        _local_43 = ((_local_41 + _local_42) * 0.707106781);
                        sf64((_local_42 + _local_43), ((_local_9 + _local_18) + 128));
                        sf64((_local_42 - _local_43), ((_local_9 + _local_18) + 384));
                        _local_39 = (_local_35 + _local_36);
                        _local_40 = (_local_36 + _local_37);
                        _local_41 = (_local_37 + _local_38);
                        _local_47 = ((_local_39 - _local_41) * 0.382683433);
                        _local_44 = ((0.5411961 * _local_39) + _local_47);
                        _local_46 = ((1.306562965 * _local_41) + _local_47);
                        _local_45 = (_local_40 * 0.707106781);
                        _local_48 = (_local_38 + _local_45);
                        _local_49 = (_local_38 - _local_45);
                        sf64((_local_49 + _local_44), ((_local_9 + _local_18) + 320));
                        sf64((_local_49 - _local_44), ((_local_9 + _local_18) + 192));
                        sf64((_local_48 + _local_46), ((_local_9 + _local_18) + 64));
                        sf64((_local_48 - _local_46), ((_local_9 + _local_18) + 448));
                        _local_18 = (_local_18 + 8);
                    } while (_local_18 < 64);
                    _local_19 = 0;
                    do 
                    {
                        _local_50 = (lf64(_local_9 + (_local_19 << 3)) * lf64(1922 + (_local_19 << 3)));
                        si32((_local_50 + ((_local_50 > 0) ? 0.5 : -0.5)), (li8(2946 + _local_19) << 2));
                    } while (++_local_19 < 64);
                    _local_51 = li32(0);
                    _local_52 = (_local_51 - _local_22);
                    _local_22 = _local_51;
                    if (_local_52 == 0)
                    {
                        _local_53 = li8(_local_16);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_16 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                    }
                    else
                    {
                        _local_18 = ((32767 + _local_52) * 3);
                        _local_19 = (_local_16 + (li8(5004 + _local_18) * 3));
                        _local_53 = li8(_local_19);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_19 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                        _local_19 = (5004 + _local_18);
                        _local_53 = li8(_local_19);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_19 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                    };
                    _local_19 = 63;
                    while (((_local_19 > (0)) && (li32(_local_19 << 2) == 0)))
                    {
                        _local_19--;
                    };
                    if (_local_19 != 0)
                    {
                        _local_20 = 1;
                        while (_local_20 <= _local_19)
                        {
                            _local_54 = _local_20;
                            while (((_local_20 <= (_local_19)) && (li32(_local_20 << 2) == 0)))
                            {
                                _local_20++;
                            };
                            _local_55 = (_local_20 - _local_54);
                            if (_local_55 >= 16)
                            {
                                _local_53 = (_local_55 >> 4);
                                _local_56 = 1;
                                while (_local_56 <= _local_53)
                                {
                                    _local_21 = (_local_17 + 720);
                                    _local_57 = li8(_local_21);
                                    while (--_local_57 >= 0)
                                    {
                                        if ((li16(_local_21 + 1) & (1 << _local_57)) != 0)
                                        {
                                            _local_12 = (_local_12 | (1 << _local_11));
                                        };
                                        if (--_local_11 < 0)
                                        {
                                            if (_local_12 == 0xFF)
                                            {
                                                si16(0xFF, _local_10);
                                                _local_10 = (_local_10 + 2);
                                            }
                                            else
                                            {
                                                si8(_local_12, _local_10);
                                                _local_10++;
                                            };
                                            _local_11 = 7;
                                            _local_12 = 0;
                                        };
                                    };
                                    _local_56++;
                                };
                                _local_55 = (_local_55 & 0x0F);
                            };
                            _local_18 = ((32767 + li32(_local_20 << 2)) * 3);
                            _local_21 = ((_local_17 + ((_local_55 << 4) * 3)) + (li8(5004 + _local_18) * 3));
                            _local_57 = li8(_local_21);
                            while (--_local_57 >= 0)
                            {
                                if ((li16(_local_21 + 1) & (1 << _local_57)) != 0)
                                {
                                    _local_12 = (_local_12 | (1 << _local_11));
                                };
                                if (--_local_11 < 0)
                                {
                                    if (_local_12 == 0xFF)
                                    {
                                        si16(0xFF, _local_10);
                                        _local_10 = (_local_10 + 2);
                                    }
                                    else
                                    {
                                        si8(_local_12, _local_10);
                                        _local_10++;
                                    };
                                    _local_11 = 7;
                                    _local_12 = 0;
                                };
                            };
                            _local_21 = (5004 + _local_18);
                            _local_57 = li8(_local_21);
                            while (--_local_57 >= 0)
                            {
                                if ((li16(_local_21 + 1) & (1 << _local_57)) != 0)
                                {
                                    _local_12 = (_local_12 | (1 << _local_11));
                                };
                                if (--_local_11 < 0)
                                {
                                    if (_local_12 == 0xFF)
                                    {
                                        si16(0xFF, _local_10);
                                        _local_10 = (_local_10 + 2);
                                    }
                                    else
                                    {
                                        si8(_local_12, _local_10);
                                        _local_10++;
                                    };
                                    _local_11 = 7;
                                    _local_12 = 0;
                                };
                            };
                            _local_20++;
                        };
                    };
                    if (_local_19 != 63)
                    {
                        _local_53 = li8(_local_17);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_17 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                    };
                    _local_13 = _local_22;
                    _local_9 = 0x0300;
                    _local_22 = _local_14;
                    _local_16 = 4215;
                    _local_17 = 4251;
                    _local_18 = 0;
                    do 
                    {
                        _local_23 = lf64(_local_9 + _local_18);
                        _local_24 = lf64((_local_9 + _local_18) + 8);
                        _local_25 = lf64((_local_9 + _local_18) + 16);
                        _local_26 = lf64((_local_9 + _local_18) + 24);
                        _local_27 = lf64((_local_9 + _local_18) + 32);
                        _local_28 = lf64((_local_9 + _local_18) + 40);
                        _local_29 = lf64((_local_9 + _local_18) + 48);
                        _local_30 = lf64((_local_9 + _local_18) + 56);
                        _local_31 = (_local_23 + _local_30);
                        _local_38 = (_local_23 - _local_30);
                        _local_32 = (_local_24 + _local_29);
                        _local_37 = (_local_24 - _local_29);
                        _local_33 = (_local_25 + _local_28);
                        _local_36 = (_local_25 - _local_28);
                        _local_34 = (_local_26 + _local_27);
                        _local_35 = (_local_26 - _local_27);
                        _local_39 = (_local_31 + _local_34);
                        _local_42 = (_local_31 - _local_34);
                        _local_40 = (_local_32 + _local_33);
                        _local_41 = (_local_32 - _local_33);
                        sf64((_local_39 + _local_40), (_local_9 + _local_18));
                        sf64((_local_39 - _local_40), ((_local_9 + _local_18) + 32));
                        _local_43 = ((_local_41 + _local_42) * 0.707106781);
                        sf64((_local_42 + _local_43), ((_local_9 + _local_18) + 16));
                        sf64((_local_42 - _local_43), ((_local_9 + _local_18) + 48));
                        _local_39 = (_local_35 + _local_36);
                        _local_40 = (_local_36 + _local_37);
                        _local_41 = (_local_37 + _local_38);
                        _local_47 = ((_local_39 - _local_41) * 0.382683433);
                        _local_44 = ((0.5411961 * _local_39) + _local_47);
                        _local_46 = ((1.306562965 * _local_41) + _local_47);
                        _local_45 = (_local_40 * 0.707106781);
                        _local_48 = (_local_38 + _local_45);
                        _local_49 = (_local_38 - _local_45);
                        sf64((_local_49 + _local_44), ((_local_9 + _local_18) + 40));
                        sf64((_local_49 - _local_44), ((_local_9 + _local_18) + 24));
                        sf64((_local_48 + _local_46), ((_local_9 + _local_18) + 8));
                        sf64((_local_48 - _local_46), ((_local_9 + _local_18) + 56));
                        _local_18 = (_local_18 + 64);
                    } while (_local_18 < 0x0200);
                    _local_18 = 0;
                    do 
                    {
                        _local_23 = lf64(_local_9 + _local_18);
                        _local_24 = lf64((_local_9 + _local_18) + 64);
                        _local_25 = lf64((_local_9 + _local_18) + 128);
                        _local_26 = lf64((_local_9 + _local_18) + 192);
                        _local_27 = lf64((_local_9 + _local_18) + 0x0100);
                        _local_28 = lf64((_local_9 + _local_18) + 320);
                        _local_29 = lf64((_local_9 + _local_18) + 384);
                        _local_30 = lf64((_local_9 + _local_18) + 448);
                        _local_31 = (_local_23 + _local_30);
                        _local_38 = (_local_23 - _local_30);
                        _local_32 = (_local_24 + _local_29);
                        _local_37 = (_local_24 - _local_29);
                        _local_33 = (_local_25 + _local_28);
                        _local_36 = (_local_25 - _local_28);
                        _local_34 = (_local_26 + _local_27);
                        _local_35 = (_local_26 - _local_27);
                        _local_39 = (_local_31 + _local_34);
                        _local_42 = (_local_31 - _local_34);
                        _local_40 = (_local_32 + _local_33);
                        _local_41 = (_local_32 - _local_33);
                        sf64((_local_39 + _local_40), (_local_9 + _local_18));
                        sf64((_local_39 - _local_40), ((_local_9 + _local_18) + 0x0100));
                        _local_43 = ((_local_41 + _local_42) * 0.707106781);
                        sf64((_local_42 + _local_43), ((_local_9 + _local_18) + 128));
                        sf64((_local_42 - _local_43), ((_local_9 + _local_18) + 384));
                        _local_39 = (_local_35 + _local_36);
                        _local_40 = (_local_36 + _local_37);
                        _local_41 = (_local_37 + _local_38);
                        _local_47 = ((_local_39 - _local_41) * 0.382683433);
                        _local_44 = ((0.5411961 * _local_39) + _local_47);
                        _local_46 = ((1.306562965 * _local_41) + _local_47);
                        _local_45 = (_local_40 * 0.707106781);
                        _local_48 = (_local_38 + _local_45);
                        _local_49 = (_local_38 - _local_45);
                        sf64((_local_49 + _local_44), ((_local_9 + _local_18) + 320));
                        sf64((_local_49 - _local_44), ((_local_9 + _local_18) + 192));
                        sf64((_local_48 + _local_46), ((_local_9 + _local_18) + 64));
                        sf64((_local_48 - _local_46), ((_local_9 + _local_18) + 448));
                        _local_18 = (_local_18 + 8);
                    } while (_local_18 < 64);
                    _local_19 = 0;
                    do 
                    {
                        _local_50 = (lf64(_local_9 + (_local_19 << 3)) * lf64(2434 + (_local_19 << 3)));
                        si32((_local_50 + ((_local_50 > 0) ? 0.5 : -0.5)), (li8(2946 + _local_19) << 2));
                    } while (++_local_19 < 64);
                    _local_51 = li32(0);
                    _local_52 = (_local_51 - _local_22);
                    _local_22 = _local_51;
                    if (_local_52 == 0)
                    {
                        _local_53 = li8(_local_16);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_16 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                    }
                    else
                    {
                        _local_18 = ((32767 + _local_52) * 3);
                        _local_19 = (_local_16 + (li8(5004 + _local_18) * 3));
                        _local_53 = li8(_local_19);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_19 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                        _local_19 = (5004 + _local_18);
                        _local_53 = li8(_local_19);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_19 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                    };
                    _local_19 = 63;
                    while (((_local_19 > (0)) && (li32(_local_19 << 2) == 0)))
                    {
                        _local_19--;
                    };
                    if (_local_19 != 0)
                    {
                        _local_20 = 1;
                        while (_local_20 <= _local_19)
                        {
                            _local_54 = _local_20;
                            while (((_local_20 <= (_local_19)) && (li32(_local_20 << 2) == 0)))
                            {
                                _local_20++;
                            };
                            _local_55 = (_local_20 - _local_54);
                            if (_local_55 >= 16)
                            {
                                _local_53 = (_local_55 >> 4);
                                _local_56 = 1;
                                while (_local_56 <= _local_53)
                                {
                                    _local_21 = (_local_17 + 720);
                                    _local_57 = li8(_local_21);
                                    while (--_local_57 >= 0)
                                    {
                                        if ((li16(_local_21 + 1) & (1 << _local_57)) != 0)
                                        {
                                            _local_12 = (_local_12 | (1 << _local_11));
                                        };
                                        if (--_local_11 < 0)
                                        {
                                            if (_local_12 == 0xFF)
                                            {
                                                si16(0xFF, _local_10);
                                                _local_10 = (_local_10 + 2);
                                            }
                                            else
                                            {
                                                si8(_local_12, _local_10);
                                                _local_10++;
                                            };
                                            _local_11 = 7;
                                            _local_12 = 0;
                                        };
                                    };
                                    _local_56++;
                                };
                                _local_55 = (_local_55 & 0x0F);
                            };
                            _local_18 = ((32767 + li32(_local_20 << 2)) * 3);
                            _local_21 = ((_local_17 + ((_local_55 << 4) * 3)) + (li8(5004 + _local_18) * 3));
                            _local_57 = li8(_local_21);
                            while (--_local_57 >= 0)
                            {
                                if ((li16(_local_21 + 1) & (1 << _local_57)) != 0)
                                {
                                    _local_12 = (_local_12 | (1 << _local_11));
                                };
                                if (--_local_11 < 0)
                                {
                                    if (_local_12 == 0xFF)
                                    {
                                        si16(0xFF, _local_10);
                                        _local_10 = (_local_10 + 2);
                                    }
                                    else
                                    {
                                        si8(_local_12, _local_10);
                                        _local_10++;
                                    };
                                    _local_11 = 7;
                                    _local_12 = 0;
                                };
                            };
                            _local_21 = (5004 + _local_18);
                            _local_57 = li8(_local_21);
                            while (--_local_57 >= 0)
                            {
                                if ((li16(_local_21 + 1) & (1 << _local_57)) != 0)
                                {
                                    _local_12 = (_local_12 | (1 << _local_11));
                                };
                                if (--_local_11 < 0)
                                {
                                    if (_local_12 == 0xFF)
                                    {
                                        si16(0xFF, _local_10);
                                        _local_10 = (_local_10 + 2);
                                    }
                                    else
                                    {
                                        si8(_local_12, _local_10);
                                        _local_10++;
                                    };
                                    _local_11 = 7;
                                    _local_12 = 0;
                                };
                            };
                            _local_20++;
                        };
                    };
                    if (_local_19 != 63)
                    {
                        _local_53 = li8(_local_17);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_17 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                    };
                    _local_14 = _local_22;
                    _local_9 = 0x0500;
                    _local_22 = _local_15;
                    _local_16 = 4215;
                    _local_17 = 4251;
                    _local_18 = 0;
                    do 
                    {
                        _local_23 = lf64(_local_9 + _local_18);
                        _local_24 = lf64((_local_9 + _local_18) + 8);
                        _local_25 = lf64((_local_9 + _local_18) + 16);
                        _local_26 = lf64((_local_9 + _local_18) + 24);
                        _local_27 = lf64((_local_9 + _local_18) + 32);
                        _local_28 = lf64((_local_9 + _local_18) + 40);
                        _local_29 = lf64((_local_9 + _local_18) + 48);
                        _local_30 = lf64((_local_9 + _local_18) + 56);
                        _local_31 = (_local_23 + _local_30);
                        _local_38 = (_local_23 - _local_30);
                        _local_32 = (_local_24 + _local_29);
                        _local_37 = (_local_24 - _local_29);
                        _local_33 = (_local_25 + _local_28);
                        _local_36 = (_local_25 - _local_28);
                        _local_34 = (_local_26 + _local_27);
                        _local_35 = (_local_26 - _local_27);
                        _local_39 = (_local_31 + _local_34);
                        _local_42 = (_local_31 - _local_34);
                        _local_40 = (_local_32 + _local_33);
                        _local_41 = (_local_32 - _local_33);
                        sf64((_local_39 + _local_40), (_local_9 + _local_18));
                        sf64((_local_39 - _local_40), ((_local_9 + _local_18) + 32));
                        _local_43 = ((_local_41 + _local_42) * 0.707106781);
                        sf64((_local_42 + _local_43), ((_local_9 + _local_18) + 16));
                        sf64((_local_42 - _local_43), ((_local_9 + _local_18) + 48));
                        _local_39 = (_local_35 + _local_36);
                        _local_40 = (_local_36 + _local_37);
                        _local_41 = (_local_37 + _local_38);
                        _local_47 = ((_local_39 - _local_41) * 0.382683433);
                        _local_44 = ((0.5411961 * _local_39) + _local_47);
                        _local_46 = ((1.306562965 * _local_41) + _local_47);
                        _local_45 = (_local_40 * 0.707106781);
                        _local_48 = (_local_38 + _local_45);
                        _local_49 = (_local_38 - _local_45);
                        sf64((_local_49 + _local_44), ((_local_9 + _local_18) + 40));
                        sf64((_local_49 - _local_44), ((_local_9 + _local_18) + 24));
                        sf64((_local_48 + _local_46), ((_local_9 + _local_18) + 8));
                        sf64((_local_48 - _local_46), ((_local_9 + _local_18) + 56));
                        _local_18 = (_local_18 + 64);
                    } while (_local_18 < 0x0200);
                    _local_18 = 0;
                    do 
                    {
                        _local_23 = lf64(_local_9 + _local_18);
                        _local_24 = lf64((_local_9 + _local_18) + 64);
                        _local_25 = lf64((_local_9 + _local_18) + 128);
                        _local_26 = lf64((_local_9 + _local_18) + 192);
                        _local_27 = lf64((_local_9 + _local_18) + 0x0100);
                        _local_28 = lf64((_local_9 + _local_18) + 320);
                        _local_29 = lf64((_local_9 + _local_18) + 384);
                        _local_30 = lf64((_local_9 + _local_18) + 448);
                        _local_31 = (_local_23 + _local_30);
                        _local_38 = (_local_23 - _local_30);
                        _local_32 = (_local_24 + _local_29);
                        _local_37 = (_local_24 - _local_29);
                        _local_33 = (_local_25 + _local_28);
                        _local_36 = (_local_25 - _local_28);
                        _local_34 = (_local_26 + _local_27);
                        _local_35 = (_local_26 - _local_27);
                        _local_39 = (_local_31 + _local_34);
                        _local_42 = (_local_31 - _local_34);
                        _local_40 = (_local_32 + _local_33);
                        _local_41 = (_local_32 - _local_33);
                        sf64((_local_39 + _local_40), (_local_9 + _local_18));
                        sf64((_local_39 - _local_40), ((_local_9 + _local_18) + 0x0100));
                        _local_43 = ((_local_41 + _local_42) * 0.707106781);
                        sf64((_local_42 + _local_43), ((_local_9 + _local_18) + 128));
                        sf64((_local_42 - _local_43), ((_local_9 + _local_18) + 384));
                        _local_39 = (_local_35 + _local_36);
                        _local_40 = (_local_36 + _local_37);
                        _local_41 = (_local_37 + _local_38);
                        _local_47 = ((_local_39 - _local_41) * 0.382683433);
                        _local_44 = ((0.5411961 * _local_39) + _local_47);
                        _local_46 = ((1.306562965 * _local_41) + _local_47);
                        _local_45 = (_local_40 * 0.707106781);
                        _local_48 = (_local_38 + _local_45);
                        _local_49 = (_local_38 - _local_45);
                        sf64((_local_49 + _local_44), ((_local_9 + _local_18) + 320));
                        sf64((_local_49 - _local_44), ((_local_9 + _local_18) + 192));
                        sf64((_local_48 + _local_46), ((_local_9 + _local_18) + 64));
                        sf64((_local_48 - _local_46), ((_local_9 + _local_18) + 448));
                        _local_18 = (_local_18 + 8);
                    } while (_local_18 < 64);
                    _local_19 = 0;
                    do 
                    {
                        _local_50 = (lf64(_local_9 + (_local_19 << 3)) * lf64(2434 + (_local_19 << 3)));
                        si32((_local_50 + ((_local_50 > 0) ? 0.5 : -0.5)), (li8(2946 + _local_19) << 2));
                    } while (++_local_19 < 64);
                    _local_51 = li32(0);
                    _local_52 = (_local_51 - _local_22);
                    _local_22 = _local_51;
                    if (_local_52 == 0)
                    {
                        _local_53 = li8(_local_16);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_16 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                    }
                    else
                    {
                        _local_18 = ((32767 + _local_52) * 3);
                        _local_19 = (_local_16 + (li8(5004 + _local_18) * 3));
                        _local_53 = li8(_local_19);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_19 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                        _local_19 = (5004 + _local_18);
                        _local_53 = li8(_local_19);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_19 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                    };
                    _local_19 = 63;
                    while (((_local_19 > (0)) && (li32(_local_19 << 2) == 0)))
                    {
                        _local_19--;
                    };
                    if (_local_19 != 0)
                    {
                        _local_20 = 1;
                        while (_local_20 <= _local_19)
                        {
                            _local_54 = _local_20;
                            while (((_local_20 <= (_local_19)) && (li32(_local_20 << 2) == 0)))
                            {
                                _local_20++;
                            };
                            _local_55 = (_local_20 - _local_54);
                            if (_local_55 >= 16)
                            {
                                _local_53 = (_local_55 >> 4);
                                _local_56 = 1;
                                while (_local_56 <= _local_53)
                                {
                                    _local_21 = (_local_17 + 720);
                                    _local_57 = li8(_local_21);
                                    while (--_local_57 >= 0)
                                    {
                                        if ((li16(_local_21 + 1) & (1 << _local_57)) != 0)
                                        {
                                            _local_12 = (_local_12 | (1 << _local_11));
                                        };
                                        if (--_local_11 < 0)
                                        {
                                            if (_local_12 == 0xFF)
                                            {
                                                si16(0xFF, _local_10);
                                                _local_10 = (_local_10 + 2);
                                            }
                                            else
                                            {
                                                si8(_local_12, _local_10);
                                                _local_10++;
                                            };
                                            _local_11 = 7;
                                            _local_12 = 0;
                                        };
                                    };
                                    _local_56++;
                                };
                                _local_55 = (_local_55 & 0x0F);
                            };
                            _local_18 = ((32767 + li32(_local_20 << 2)) * 3);
                            _local_21 = ((_local_17 + ((_local_55 << 4) * 3)) + (li8(5004 + _local_18) * 3));
                            _local_57 = li8(_local_21);
                            while (--_local_57 >= 0)
                            {
                                if ((li16(_local_21 + 1) & (1 << _local_57)) != 0)
                                {
                                    _local_12 = (_local_12 | (1 << _local_11));
                                };
                                if (--_local_11 < 0)
                                {
                                    if (_local_12 == 0xFF)
                                    {
                                        si16(0xFF, _local_10);
                                        _local_10 = (_local_10 + 2);
                                    }
                                    else
                                    {
                                        si8(_local_12, _local_10);
                                        _local_10++;
                                    };
                                    _local_11 = 7;
                                    _local_12 = 0;
                                };
                            };
                            _local_21 = (5004 + _local_18);
                            _local_57 = li8(_local_21);
                            while (--_local_57 >= 0)
                            {
                                if ((li16(_local_21 + 1) & (1 << _local_57)) != 0)
                                {
                                    _local_12 = (_local_12 | (1 << _local_11));
                                };
                                if (--_local_11 < 0)
                                {
                                    if (_local_12 == 0xFF)
                                    {
                                        si16(0xFF, _local_10);
                                        _local_10 = (_local_10 + 2);
                                    }
                                    else
                                    {
                                        si8(_local_12, _local_10);
                                        _local_10++;
                                    };
                                    _local_11 = 7;
                                    _local_12 = 0;
                                };
                            };
                            _local_20++;
                        };
                    };
                    if (_local_19 != 63)
                    {
                        _local_53 = li8(_local_17);
                        while (--_local_53 >= 0)
                        {
                            if ((li16(_local_17 + 1) & (1 << _local_53)) != 0)
                            {
                                _local_12 = (_local_12 | (1 << _local_11));
                            };
                            if (--_local_11 < 0)
                            {
                                if (_local_12 == 0xFF)
                                {
                                    si16(0xFF, _local_10);
                                    _local_10 = (_local_10 + 2);
                                }
                                else
                                {
                                    si8(_local_12, _local_10);
                                    _local_10++;
                                };
                                _local_11 = 7;
                                _local_12 = 0;
                            };
                        };
                    };
                    _local_15 = _local_22;
                    _local_7 = (_local_7 + 8);
                } while (_local_7 < _local_4);
                _local_8 = (_local_8 + 8);
            } while (_local_8 < _local_5);
            if (_local_11 >= 0)
            {
                _local_22 = (_local_11 + 1);
                while (--_local_22 >= 0)
                {
                    if ((((1 << (_local_11 + 1)) - 1) & (1 << _local_22)) != 0)
                    {
                        _local_12 = (_local_12 | (1 << _local_11));
                    };
                    if (--_local_11 < 0)
                    {
                        if (_local_12 == 0xFF)
                        {
                            si16(0xFF, _local_10);
                            _local_10 = (_local_10 + 2);
                        }
                        else
                        {
                            si8(_local_12, _local_10);
                            _local_10++;
                        };
                        _local_11 = 7;
                        _local_12 = 0;
                    };
                };
            };
            si16(55807, _local_10);
            ApplicationDomain.currentDomain.domainMemory = _local_3;
            var _local_58:ByteArray = new ByteArray();
            _local_58.writeBytes(_local_6, 201609, ((_local_10 - 201609) + 2));
            _local_58.position = 0;
            return (_local_58);
        }


    }
} by.blooddy.crypto.image

