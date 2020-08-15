package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_time2sub extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
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
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            var _local_25:int;
            var _local_26:int;
            var _local_27:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 48);
            _local_1 = 0;
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 8);
            si32(_local_1, _local_2);
            _local_1 = li32(_local_3);
            _local_4 = li32(_local_3 + 4);
            _local_5 = li32(_local_3 + 8);
            _local_6 = li32(_local_3 + 12);
            _local_7 = li32(_local_3 + 16);
            _local_8 = li32(_local_3 + 20);
            _local_9 = li32(_local_3 + 32);
            _local_10 = li32(mstate.ebp + 16);
            if ((!(_local_10 == 0)))
            {
                if (!(_local_1 < 0))
                {
                    _local_10 = int((_local_1 / 60));
                    _local_11 = ((_local_1 < -59) ? 1 : 0);
                    _local_12 = (_local_4 + _local_10);
                    _local_13 = _local_12;
                }
                else
                {
                    _local_10 = (_local_1 ^ 0xFFFFFFFF);
                    _local_11 = int((_local_10 / 60));
                    _local_11 = (_local_11 ^ 0xFFFFFFFF);
                    _local_14 = ((_local_10 > -60) ? 1 : 0);
                    _local_12 = (_local_4 + _local_11);
                    _local_13 = _local_12;
                    _local_10 = _local_11;
                    _local_11 = _local_14;
                };
                _local_4 = ((_local_12 < _local_4) ? 1 : 0);
                _local_10 = (_local_10 * 60);
                _local_4 = (_local_4 ^ _local_11);
                _local_1 = (_local_1 - _local_10);
                _local_4 = (_local_4 & 0x01);
                if (!(_local_4 == 0)) goto _label_17;
                _local_4 = _local_13;
            };
            if (!(_local_4 < 0))
            {
                _local_10 = int((_local_4 / 60));
                _local_11 = ((_local_4 < -59) ? 1 : 0);
                _local_12 = (_local_5 + _local_10);
                _local_13 = _local_12;
            }
            else
            {
                _local_10 = (_local_4 ^ 0xFFFFFFFF);
                _local_11 = int((_local_10 / 60));
                _local_11 = (_local_11 ^ 0xFFFFFFFF);
                _local_14 = ((_local_10 > -60) ? 1 : 0);
                _local_12 = (_local_5 + _local_11);
                _local_13 = _local_12;
                _local_10 = _local_11;
                _local_11 = _local_14;
            };
            _local_5 = ((_local_12 < _local_5) ? 1 : 0);
            _local_10 = (_local_10 * 60);
            _local_5 = (_local_5 ^ _local_11);
            _local_4 = (_local_4 - _local_10);
            _local_5 = (_local_5 & 0x01);
            if (!(!(_local_5 == 0)))
            {
                if (!(_local_13 < 0))
                {
                    _local_5 = int((_local_13 / 24));
                    _local_10 = ((_local_13 < -23) ? 1 : 0);
                    _local_11 = (_local_6 + _local_5);
                    _local_12 = _local_11;
                }
                else
                {
                    _local_5 = (_local_13 ^ 0xFFFFFFFF);
                    _local_10 = int((_local_5 / 24));
                    _local_10 = (_local_10 ^ 0xFFFFFFFF);
                    _local_14 = ((_local_5 > -24) ? 1 : 0);
                    _local_11 = (_local_6 + _local_10);
                    _local_12 = _local_11;
                    _local_5 = _local_10;
                    _local_10 = _local_14;
                };
                _local_6 = ((_local_11 < _local_6) ? 1 : 0);
                _local_5 = (_local_5 * 24);
                _local_6 = (_local_6 ^ _local_10);
                _local_5 = (_local_13 - _local_5);
                _local_6 = (_local_6 & 0x01);
                if (!(!(_local_6 == 0)))
                {
                    if (!(_local_7 < 0))
                    {
                        _local_6 = int((_local_7 / 12));
                        _local_10 = ((_local_7 < -11) ? 1 : 0);
                        _local_11 = (_local_8 + _local_6);
                        _local_13 = _local_11;
                    }
                    else
                    {
                        _local_6 = (_local_7 ^ 0xFFFFFFFF);
                        _local_10 = int((_local_6 / 12));
                        _local_10 = (_local_10 ^ 0xFFFFFFFF);
                        _local_14 = ((_local_6 > -12) ? 1 : 0);
                        _local_11 = (_local_8 + _local_10);
                        _local_13 = _local_11;
                        _local_6 = _local_10;
                        _local_10 = _local_14;
                    };
                    _local_8 = ((_local_11 < _local_8) ? 1 : 0);
                    _local_6 = (_local_6 * 12);
                    _local_8 = (_local_8 ^ _local_10);
                    _local_6 = (_local_7 - _local_6);
                    _local_7 = (_local_8 & 0x01);
                    if (!(!(_local_7 == 0)))
                    {
                        _local_7 = (_local_13 + 1900);
                        if (!(_local_7 < _local_13))
                        {
                            if (!(_local_12 < 1))
                            {
                                _local_13 = _local_7;
                                _local_7 = _local_12;
                            }
                            else
                            {
                                _local_8 = ((_local_6 > 1) ? 1 : 0);
                                _local_8 = (_local_8 & 0x01);
                                _local_8 = (_local_8 + 1899);
                                _local_10 = _local_7;
                                _local_7 = _local_12;
                                do 
                                {
                                    _local_10 = (_local_10 + -1);
                                    _local_12 = (_local_13 + 1900);
                                    if (_local_10 >= _local_12) goto _label_17;
                                    _local_12 = (_local_8 + _local_13);
                                    _local_11 = (_local_12 & 0x03);
                                    if (!(!(_local_11 == 0)))
                                    {
                                        _local_11 = int((_local_12 / 100));
                                        _local_11 = (_local_11 * 100);
                                        _local_11 = (_local_12 - _local_11);
                                        if (!(_local_11 == 0))
                                        {
                                            
                                        _label_1: 
                                            _local_12 = 1;
                                            goto _label_2;
                                        };
                                        _local_11 = int((_local_12 / 400));
                                        _local_11 = (_local_11 * 400);
                                        _local_12 = (_local_12 - _local_11);
                                        if (_local_12 == 0) goto _label_1;
                                    };
                                    _local_12 = 0;
                                    
                                _label_2: 
                                    _local_11 = _year_lengths;
                                    _local_12 = (_local_12 << 2);
                                    _local_12 = (_local_11 + _local_12);
                                    _local_12 = li32(_local_12);
                                    _local_13 = (_local_13 + -1);
                                    _local_7 = (_local_12 + _local_7);
                                    if (_local_7 > 0) goto _label_6;
                                } while (true);
                                
                            _label_3: 
                                _local_12 = (_local_11 + _local_8);
                                _local_14 = (_local_12 & 0x03);
                                if (!(!(_local_14 == 0)))
                                {
                                    _local_14 = int((_local_12 / 100));
                                    _local_14 = (_local_14 * 100);
                                    _local_14 = (_local_12 - _local_14);
                                    if (!(_local_14 == 0))
                                    {
                                        
                                    _label_4: 
                                        _local_12 = 1;
                                        goto _label_5;
                                    };
                                    _local_14 = int((_local_12 / 400));
                                    _local_14 = (_local_14 * 400);
                                    _local_12 = (_local_12 - _local_14);
                                    if (_local_12 == 0) goto _label_4;
                                };
                                _local_12 = 0;
                                
                            _label_5: 
                                _local_14 = _year_lengths;
                                _local_12 = (_local_12 << 2);
                                _local_12 = (_local_14 + _local_12);
                                _local_12 = li32(_local_12);
                                _local_8 = (_local_8 + 1);
                                _local_14 = (_local_13 + 1);
                                _local_7 = (_local_7 - _local_12);
                                _local_12 = (_local_10 + _local_8);
                                if (_local_12 < _local_13) goto _label_17;
                                _local_13 = _local_8;
                                _local_12 = _local_14;
                                goto _label_7;
                                
                            _label_6: 
                                _local_13 = (_local_13 + 1900);
                            };
                            _local_10 = _local_13;
                            _local_13 = 0;
                            _local_8 = ((_local_6 > 1) ? 1 : 0);
                            _local_8 = (_local_8 & 0x01);
                            _local_11 = (_local_10 + _local_8);
                            _local_12 = _local_10;
                            
                        _label_7: 
                            _local_8 = _local_13;
                            _local_13 = _local_12;
                            if (_local_7 > 366) goto _label_3;
                            _local_11 = (_local_10 + _local_8);
                            _local_8 = (_local_8 + _local_10);
                            _local_10 = _local_11;
                            do 
                            {
                                _local_11 = _mon_lengths;
                                _local_12 = (_local_6 << 2);
                                _local_11 = (_local_11 + _local_12);
                                _local_12 = (_local_8 & 0x03);
                                do 
                                {
                                    if (!(!(_local_12 == 0)))
                                    {
                                        _local_13 = int((_local_8 / 100));
                                        _local_13 = (_local_13 * 100);
                                        _local_13 = (_local_8 - _local_13);
                                        if (!(_local_13 == 0))
                                        {
                                            
                                        _label_8: 
                                            _local_13 = 1;
                                            continue;
                                        };
                                        _local_13 = int((_local_8 / 400));
                                        _local_13 = (_local_13 * 400);
                                        _local_13 = (_local_8 - _local_13);
                                        if (_local_13 == 0) goto _label_8;
                                    };
                                    _local_13 = 0;
                                } while ((_local_13 = (_local_13 * 48)), (_local_13 = (_local_11 + _local_13)), (_local_13 = li32(_local_13)), if (_local_7 <= _local_13) goto _label_9;
, (_local_11 = (_local_11 + 4)), (_local_6 = (_local_6 + 1)), (_local_7 = (_local_7 - _local_13)), !(_local_6 > 11));
                                _local_6 = (_local_8 + 1);
                                _local_10 = (_local_10 + 1);
                                if (_local_10 < _local_8) goto _label_17;
                                _local_11 = 0;
                                _local_8 = _local_6;
                                _local_6 = _local_11;
                            } while (true);
                            
                        _label_9: 
                            _local_10 = (_local_8 + -1900);
                            if (!(_local_10 < 0))
                            {
                                if (!(_local_10 >= _local_8))
                                {
                                    if (!(uint(_local_1) > uint(59)))
                                    {
                                        _local_8 = 31;
                                        _local_11 = 0;
                                        _local_12 = _local_11;
                                        _local_13 = _local_1;
                                        _local_1 = _local_11;
                                        
                                    _label_10: 
                                        _local_15 = _local_1;
                                        _local_1 = _local_8;
                                        _local_8 = (mstate.ebp + -48);
                                        mstate.esp = (mstate.esp - 12);
                                        _local_11 = 0;
                                        si32(_local_12, mstate.esp);
                                        si32(_local_11, (mstate.esp + 4));
                                        si32(_local_8, (mstate.esp + 8));
                                        mstate.esp = (mstate.esp - 4);
                                        FSM_localsub399.start();
                                        mstate.esp = (mstate.esp + 12);
                                        _local_8 = li32(mstate.ebp + -28);
                                        if (_local_8 == _local_10) goto _label_11;
                                        _local_11 = _local_10;
                                        goto _label_12;
                                    };
                                    if (!(_local_10 < 70))
                                    {
                                        _local_8 = 31;
                                        _local_13 = 0;
                                        _local_12 = _local_13;
                                        goto _label_10;
                                    };
                                    _local_8 = (_local_1 + -59);
                                    if (!(_local_8 >= _local_1))
                                    {
                                        _local_1 = (mstate.ebp + -48);
                                        mstate.esp = (mstate.esp - 12);
                                        _local_12 = 0;
                                        si32(_local_12, mstate.esp);
                                        si32(_local_12, (mstate.esp + 4));
                                        si32(_local_1, (mstate.esp + 8));
                                        mstate.esp = (mstate.esp - 4);
                                        FSM_localsub399.start();
                                        mstate.esp = (mstate.esp + 12);
                                        _local_1 = li32(mstate.ebp + -28);
                                        if (!(_local_1 == _local_10))
                                        {
                                            _local_12 = _local_10;
                                        }
                                        else
                                        {
                                            _local_1 = li32(mstate.ebp + -32);
                                            if (!(_local_1 == _local_6))
                                            {
                                                _local_12 = _local_6;
                                            }
                                            else
                                            {
                                                _local_1 = li32(mstate.ebp + -36);
                                                if (!(_local_1 == _local_7))
                                                {
                                                    _local_12 = _local_7;
                                                }
                                                else
                                                {
                                                    _local_1 = li32(mstate.ebp + -40);
                                                    if (!(_local_1 == _local_5))
                                                    {
                                                        _local_12 = _local_5;
                                                    }
                                                    else
                                                    {
                                                        _local_1 = li32(mstate.ebp + -44);
                                                        if (!(_local_1 == _local_4))
                                                        {
                                                            _local_12 = _local_4;
                                                        }
                                                        else
                                                        {
                                                            _local_12 = 59;
                                                            _local_1 = li32(mstate.ebp + -48);
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                        if (!(_local_1 == _local_12))
                                        {
                                            _local_13 = 31;
                                            _local_11 = 59;
                                            _local_14 = 0;
                                            goto _label_13;
                                            
                                        _label_11: 
                                            _local_8 = li32(mstate.ebp + -32);
                                            if (!(_local_8 == _local_6))
                                            {
                                                _local_11 = _local_6;
                                            }
                                            else
                                            {
                                                _local_8 = li32(mstate.ebp + -36);
                                                if (!(_local_8 == _local_7))
                                                {
                                                    _local_11 = _local_7;
                                                }
                                                else
                                                {
                                                    _local_8 = li32(mstate.ebp + -40);
                                                    if (!(_local_8 == _local_5))
                                                    {
                                                        _local_11 = _local_5;
                                                    }
                                                    else
                                                    {
                                                        _local_8 = li32(mstate.ebp + -44);
                                                        if (!(_local_8 == _local_4))
                                                        {
                                                            _local_11 = _local_4;
                                                        }
                                                        else
                                                        {
                                                            _local_8 = li32(mstate.ebp + -48);
                                                            _local_11 = _local_13;
                                                        };
                                                    };
                                                };
                                            };
                                            
                                        _label_12: 
                                            _local_16 = _local_8;
                                            _local_17 = _local_11;
                                            if (_local_16 == _local_17) goto _label_19;
                                            _local_14 = _local_12;
                                            _local_11 = _local_13;
                                            _local_8 = _local_15;
                                            _local_13 = _local_1;
                                            _local_1 = _local_16;
                                            _local_12 = _local_17;
                                            
                                        _label_13: 
                                            _local_15 = (_local_13 + -1);
                                            _local_1 = (_local_1 - _local_12);
                                            if (_local_13 < 0) goto _label_17;
                                            if (!(_local_15 > -1))
                                            {
                                                _local_1 = (_local_14 + -1);
                                                _local_12 = _local_1;
                                                _local_13 = _local_11;
                                                _local_1 = _local_8;
                                                _local_8 = _local_15;
                                                goto _label_10;
                                            };
                                            _local_12 = 1;
                                            _local_12 = (_local_12 << _local_15);
                                            if (!(_local_1 < 1))
                                            {
                                                _local_12 = (_local_14 - _local_12);
                                                _local_13 = _local_11;
                                                _local_1 = _local_8;
                                                _local_8 = _local_15;
                                                goto _label_10;
                                            };
                                            _local_1 = (_local_14 + _local_12);
                                            _local_12 = _local_1;
                                            _local_13 = _local_11;
                                            _local_1 = _local_8;
                                            _local_8 = _local_15;
                                            goto _label_10;
                                        };
                                        _local_1 = 59;
                                        _local_12 = 0;
                                        
                                    _label_14: 
                                        _local_11 = _local_12;
                                        if (!(_local_9 > -1))
                                        {
                                            
                                        _label_15: 
                                            _local_1 = _local_11;
                                            
                                        _label_16: 
                                            _local_4 = (_local_1 + _local_8);
                                            _local_1 = ((_local_4 < _local_1) ? 1 : 0);
                                            _local_5 = ((_local_8 < 0) ? 1 : 0);
                                            _local_1 = (_local_1 ^ _local_5);
                                            _local_1 = (_local_1 & 0x01);
                                            if (!(_local_1 == 0)) goto _label_17;
                                            _local_1 = 0;
                                            mstate.esp = (mstate.esp - 12);
                                            si32(_local_4, mstate.esp);
                                            si32(_local_1, (mstate.esp + 4));
                                            si32(_local_3, (mstate.esp + 8));
                                            mstate.esp = (mstate.esp - 4);
                                            FSM_localsub399.start();
                                            mstate.esp = (mstate.esp + 12);
                                            _local_1 = 1;
                                            si32(_local_1, _local_2);
                                            mstate.eax = _local_4;
                                            goto _label_18;
                                        };
                                        _local_12 = (mstate.ebp + -48);
                                        _local_13 = li32(mstate.ebp + -16);
                                        _local_12 = (_local_12 + 32);
                                        if (_local_13 == _local_9) goto _label_15;
                                        _local_13 = li32(_lclmem + 8);
                                        _local_14 = (_local_13 + -1);
                                        if (!(_local_14 < 0))
                                        {
                                            _local_14 = (mstate.ebp + -48);
                                            _local_15 = _lclmem;
                                            _local_16 = (_local_13 * 20);
                                            _local_15 = (_local_15 + _local_16);
                                            _local_13 = (_local_13 + -1);
                                            _local_16 = (_local_14 + 4);
                                            _local_17 = (_local_14 + 8);
                                            _local_18 = (_local_14 + 12);
                                            _local_19 = (_local_14 + 16);
                                            _local_20 = (_local_14 + 20);
                                            do 
                                            {
                                                _local_21 = li32(_local_15 + 1852);
                                                if (!(!(_local_21 == _local_9)))
                                                {
                                                    _local_21 = li32(_lclmem + 8);
                                                    _local_22 = (_local_21 + -1);
                                                    if (!(_local_22 < 0))
                                                    {
                                                        _local_22 = _lclmem;
                                                        _local_23 = (_local_21 * 20);
                                                        _local_22 = (_local_22 + _local_23);
                                                        _local_21 = (_local_21 + -1);
                                                        _local_23 = (_local_15 + 1848);
                                                        do 
                                                        {
                                                            _local_24 = li32(_local_22 + 1852);
                                                            if (!(_local_24 == _local_9))
                                                            {
                                                                _local_24 = (mstate.ebp + -48);
                                                                _local_25 = li32(_local_22 + 1848);
                                                                _local_26 = li32(_local_23);
                                                                _local_25 = (_local_11 + _local_25);
                                                                mstate.esp = (mstate.esp - 12);
                                                                _local_27 = 0;
                                                                _local_25 = (_local_25 - _local_26);
                                                                si32(_local_25, mstate.esp);
                                                                si32(_local_27, (mstate.esp + 4));
                                                                si32(_local_24, (mstate.esp + 8));
                                                                mstate.esp = (mstate.esp - 4);
                                                                FSM_localsub399.start();
                                                                mstate.esp = (mstate.esp + 12);
                                                                _local_24 = li32(_local_20);
                                                                if (!(_local_24 == _local_10))
                                                                {
                                                                    _local_26 = _local_10;
                                                                }
                                                                else
                                                                {
                                                                    _local_24 = li32(_local_19);
                                                                    if (!(_local_24 == _local_6))
                                                                    {
                                                                        _local_26 = _local_6;
                                                                    }
                                                                    else
                                                                    {
                                                                        _local_24 = li32(_local_18);
                                                                        if (!(_local_24 == _local_7))
                                                                        {
                                                                            _local_26 = _local_7;
                                                                        }
                                                                        else
                                                                        {
                                                                            _local_24 = li32(_local_17);
                                                                            if (!(_local_24 == _local_5))
                                                                            {
                                                                                _local_26 = _local_5;
                                                                            }
                                                                            else
                                                                            {
                                                                                _local_24 = li32(_local_16);
                                                                                if (!(_local_24 == _local_4))
                                                                                {
                                                                                    _local_26 = _local_4;
                                                                                }
                                                                                else
                                                                                {
                                                                                    _local_24 = li32(_local_14);
                                                                                    _local_26 = _local_1;
                                                                                };
                                                                            };
                                                                        };
                                                                    };
                                                                };
                                                                if (!(!(_local_24 == _local_26)))
                                                                {
                                                                    _local_24 = li32(_local_12);
                                                                    if (!(!(_local_24 == _local_9)))
                                                                    {
                                                                        _local_1 = _local_25;
                                                                        goto _label_16;
                                                                    };
                                                                };
                                                            };
                                                            _local_22 = (_local_22 + -20);
                                                            _local_21 = (_local_21 + -1);
                                                        } while (!(_local_21 < 0));
                                                    };
                                                };
                                                _local_15 = (_local_15 + -20);
                                                _local_13 = (_local_13 + -1);
                                            } while (!(_local_13 < 0));
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            
        _label_17: 
            _local_1 = -1;
            mstate.eax = _local_1;
            
        _label_18: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_19: 
            _local_1 = _local_13;
            _local_8 = _local_15;
            goto _label_14;
        }


    }
}

