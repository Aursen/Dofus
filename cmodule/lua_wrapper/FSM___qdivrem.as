package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___qdivrem extends Machine 
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
            _local_1 = (mstate.ebp + -48);
            _local_2 = li32(mstate.ebp + 24);
            _local_3 = li32(mstate.ebp + 8);
            _local_4 = li32(mstate.ebp + 12);
            _local_5 = li32(mstate.ebp + 16);
            _local_6 = li32(mstate.ebp + 20);
            _local_7 = (mstate.ebp + -32);
            _local_8 = (mstate.ebp + -16);
            _local_9 = (_local_5 | _local_6);
            if (!(!(_local_9 == 0)))
            {
                if (!(!(_local_2 == 0)))
                {
                    _local_1 = 0;
                    _local_1 = int((uint(1) / uint(_local_1)));
                    _local_2 = _local_1;
                    goto _label_12;
                };
                _local_1 = 0;
                si32(_local_3, _local_2);
                si32(_local_4, (_local_2 + 4));
                _local_1 = int((uint(1) / uint(_local_1)));
            }
            else
            {
                _local_9 = ((uint(_local_4) >= uint(_local_6)) ? 1 : 0);
                _local_10 = ((uint(_local_3) >= uint(_local_5)) ? 1 : 0);
                _local_11 = ((_local_4 == _local_6) ? 1 : 0);
                _local_9 = ((_local_11 != 0) ? _local_10 : _local_9);
                if (!(_local_9 == 0)) goto _label_1;
                if (!(!(_local_2 == 0)))
                {
                    _local_1 = 0;
                    _local_2 = _local_1;
                    goto _label_12;
                };
                _local_1 = 0;
                si32(_local_3, _local_2);
                si32(_local_4, (_local_2 + 4));
            };
            mstate.edx = _local_1;
            goto _label_13;
            
        _label_1: 
            _local_9 = 0;
            si16(_local_9, (mstate.ebp + -48));
            _local_9 = (_local_4 >>> 16);
            si16(_local_9, (mstate.ebp + -46));
            si16(_local_4, (mstate.ebp + -44));
            _local_10 = (_local_3 >>> 16);
            si16(_local_10, (mstate.ebp + -42));
            si16(_local_3, (mstate.ebp + -40));
            _local_11 = (_local_6 >>> 16);
            si16(_local_11, (mstate.ebp + -30));
            si16(_local_6, (mstate.ebp + -28));
            _local_6 = (_local_5 >>> 16);
            _local_12 = (mstate.ebp + -48);
            si16(_local_6, (mstate.ebp + -26));
            si16(_local_5, (mstate.ebp + -24));
            _local_5 = (_local_12 + 8);
            _local_6 = (_local_12 + 6);
            _local_13 = (_local_12 + 4);
            _local_14 = (_local_12 + 2);
            _local_15 = (mstate.ebp + -32);
            _local_16 = _local_9;
            if (!(_local_11 == 0))
            {
                _local_3 = 4;
                _local_4 = _local_15;
            }
            else
            {
                _local_11 = 0;
                _local_7 = (_local_7 + 4);
                _local_15 = _local_11;
                do 
                {
                    _local_17 = _local_7;
                    _local_18 = (_local_15 + 3);
                    if (!(!(_local_18 == 1)))
                    {
                        _local_1 = (mstate.ebp + -32);
                        _local_7 = (_local_11 << 1);
                        _local_1 = (_local_7 + _local_1);
                        _local_1 = li16(_local_1 + 4);
                        _local_7 = (uint(_local_9) % uint(_local_1));
                        _local_4 = (_local_4 & 0xFFFF);
                        _local_7 = (_local_7 << 16);
                        _local_4 = (_local_4 | _local_7);
                        _local_7 = (uint(_local_4) % uint(_local_1));
                        _local_7 = (_local_7 << 16);
                        _local_7 = (_local_10 | _local_7);
                        _local_11 = (uint(_local_7) % uint(_local_1));
                        _local_3 = (_local_3 & 0xFFFF);
                        _local_11 = (_local_11 << 16);
                        _local_3 = (_local_3 | _local_11);
                        _local_11 = int((uint(_local_3) / uint(_local_1)));
                        _local_7 = int((uint(_local_7) / uint(_local_1)));
                        _local_4 = int((uint(_local_4) / uint(_local_1)));
                        _local_15 = int((uint(_local_9) / uint(_local_1)));
                        if (!(_local_2 == 0))
                        {
                            _local_5 = 0;
                            _local_1 = (uint(_local_3) % uint(_local_1));
                            si32(_local_1, _local_2);
                            si32(_local_5, (_local_2 + 4));
                        };
                        _local_1 = (_local_11 & 0xFFFF);
                        _local_2 = (_local_7 << 16);
                        _local_3 = (_local_4 & 0xFFFF);
                        _local_4 = (_local_15 << 16);
                        _local_1 = (_local_1 | _local_2);
                        _local_2 = (_local_3 | _local_4);
                        goto _label_12;
                    };
                    _local_17 = li16(_local_17);
                    _local_7 = (_local_7 + 2);
                    _local_15 = (_local_15 + -1);
                    _local_11 = (_local_11 + 1);
                } while (!(!(_local_17 == 0)));
                _local_3 = (mstate.ebp + -32);
                _local_4 = (_local_11 << 1);
                _local_7 = (_local_15 + 4);
                _local_4 = (_local_3 + _local_4);
                _local_3 = _local_7;
            };
            _local_7 = (4 - _local_3);
            _local_9 = _local_4;
            _local_10 = (_local_16 & 0xFFFF);
            if (!(_local_10 == 0))
            {
                _local_1 = _local_7;
                _local_7 = _local_12;
            }
            else
            {
                _local_10 = 0;
                _local_1 = (_local_1 + 4);
                do 
                {
                    _local_11 = li16(_local_1);
                    _local_1 = (_local_1 + 2);
                    _local_10 = (_local_10 + 1);
                } while (!(!(_local_11 == 0)));
                _local_1 = (mstate.ebp + -48);
                _local_11 = (_local_10 + -1);
                _local_10 = (_local_10 << 1);
                _local_7 = (_local_7 - _local_11);
                _local_10 = (_local_1 + _local_10);
                _local_1 = (_local_7 + -1);
                _local_7 = _local_10;
            };
            _local_10 = (3 - _local_1);
            _local_11 = _local_7;
            if (!(_local_10 < 0))
            {
                _local_10 = (_local_1 << 1);
                _local_10 = (_local_8 - _local_10);
                _local_12 = (3 - _local_1);
                _local_10 = (_local_10 + 6);
                do 
                {
                    _local_15 = 0;
                    si16(_local_15, _local_10);
                    _local_10 = (_local_10 + -2);
                    _local_12 = (_local_12 + -1);
                } while (!(_local_12 < 0));
            };
            _local_10 = li16(_local_4 + 2);
            _local_12 = (_local_4 + 2);
            _local_15 = (_local_10 << 16);
            _local_15 = (_local_15 >> 16);
            if (!(_local_15 > -1))
            {
                _local_10 = 0;
            }
            else
            {
                _local_15 = 0;
                
            _label_2: 
                _local_15 = (_local_15 + 1);
                _local_10 = (_local_10 << 1);
                if (uint(_local_10) < uint(0x8000)) goto _label_14;
                _local_10 = _local_15;
            };
            if (!(_local_10 < 1))
            {
                _local_15 = li16(_local_7);
                _local_15 = (_local_15 << _local_10);
                _local_16 = (_local_1 + _local_3);
                if (!(_local_16 > 0))
                {
                    _local_16 = 0;
                    
                _label_3: 
                    _local_16 = (_local_16 << 1);
                    _local_16 = (_local_7 + _local_16);
                    si16(_local_15, _local_16);
                    _local_15 = li16(_local_12);
                    _local_15 = (_local_15 << _local_10);
                    _local_16 = (_local_3 + -1);
                    if (_local_16 > 0) goto _label_4;
                    _local_16 = 1;
                    goto _label_5;
                };
                _local_17 = 0;
                _local_18 = (16 - _local_10);
                _local_19 = _local_11;
                do 
                {
                    _local_20 = li16(_local_19 + 2);
                    _local_20 = (_local_20 >>> _local_18);
                    _local_15 = (_local_20 | _local_15);
                    si16(_local_15, _local_19);
                    _local_15 = li16(_local_19 + 2);
                    _local_17 = (_local_17 + 1);
                    _local_15 = (_local_15 << _local_10);
                    _local_19 = (_local_19 + 2);
                    if (_local_17 == _local_16) goto _label_3;
                } while (true);
                
            _label_4: 
                _local_17 = 0;
                _local_18 = (16 - _local_10);
                _local_19 = _local_9;
                do 
                {
                    _local_20 = li16(_local_19 + 4);
                    _local_20 = (_local_20 >>> _local_18);
                    _local_15 = (_local_20 | _local_15);
                    si16(_local_15, (_local_19 + 2));
                    _local_15 = li16(_local_19 + 4);
                    _local_17 = (_local_17 + 1);
                    _local_15 = (_local_15 << _local_10);
                    _local_19 = (_local_19 + 2);
                } while (!(_local_17 == _local_16));
                _local_16 = _local_3;
                
            _label_5: 
                _local_16 = (_local_16 << 1);
                _local_16 = (_local_4 + _local_16);
                si16(_local_15, _local_16);
            };
            _local_15 = 0;
            _local_12 = li16(_local_12);
            _local_4 = li16(_local_4 + 4);
            _local_16 = (_local_1 << 1);
            _local_8 = (_local_8 - _local_16);
            _local_16 = _local_12;
            _local_17 = _local_15;
            do 
            {
                _local_18 = (_local_11 + _local_17);
                _local_19 = li16(_local_18);
                _local_20 = li16(_local_18 + 2);
                _local_21 = li16(_local_18 + 4);
                _local_22 = (_local_12 & 0xFFFF);
                if (!(!(_local_19 == _local_22)))
                {
                    _local_19 = (_local_20 & 0xFFFF);
                    _local_19 = (_local_19 + _local_16);
                    if (!(uint(_local_19) > uint(0xFFFF)))
                    {
                        _local_20 = 0xFFFF;
                        goto _label_6;
                    };
                    _local_19 = 0xFFFF;
                    goto _label_7;
                };
                _local_20 = (_local_20 & 0xFFFF);
                _local_19 = (_local_19 << 16);
                _local_19 = (_local_19 | _local_20);
                _local_20 = (uint(_local_19) % uint(_local_16));
                _local_22 = int((uint(_local_19) / uint(_local_16)));
                _local_19 = _local_20;
                _local_20 = _local_22;
                
            _label_6: 
                _local_22 = (_local_12 & 0xFFFF);
                _local_23 = (_local_4 & 0xFFFF);
                _local_21 = (_local_21 & 0xFFFF);
                _local_24 = (_local_19 << 16);
                _local_25 = (_local_22 << 16);
                _local_26 = (_local_20 * _local_23);
                while ((_local_27 = _local_19), (_local_19 = _local_20), (_local_20 = (_local_24 | _local_21)), (uint(_local_26) > uint(_local_20)))
                {
                    _local_26 = (_local_26 - _local_23);
                    _local_20 = (_local_22 + _local_27);
                    _local_24 = (_local_25 + _local_24);
                    _local_27 = (_local_19 + -1);
                    if (uint(_local_20) > uint(0xFFFF)) goto _label_15;
                    _local_19 = _local_20;
                    _local_20 = _local_27;
                };
                
            _label_7: 
                if (!(_local_3 > 0))
                {
                    _local_20 = 0;
                }
                else
                {
                    _local_20 = 0;
                    _local_21 = (_local_3 << 1);
                    _local_22 = (_local_11 + _local_17);
                    _local_23 = _local_3;
                    
                _label_8: 
                    _local_24 = (_local_9 + _local_21);
                    _local_24 = li16(_local_24);
                    _local_25 = (_local_22 + _local_21);
                    _local_26 = li16(_local_25);
                    _local_24 = (_local_24 * _local_19);
                    _local_24 = (_local_26 - _local_24);
                    _local_20 = (_local_24 - _local_20);
                    _local_24 = (_local_20 >>> 16);
                    _local_24 = (0x10000 - _local_24);
                    si16(_local_20, _local_25);
                    _local_20 = (_local_21 + -2);
                    _local_23 = (_local_23 + -1);
                    _local_24 = (_local_24 & 0xFFFF);
                    if (_local_23 > 0) goto _label_16;
                    _local_20 = _local_24;
                };
                _local_21 = li16(_local_18);
                _local_20 = (_local_21 - _local_20);
                si16(_local_20, _local_18);
                if ((uint(_local_20) > uint(0xFFFF))) break;
                _local_18 = _local_19;
                
            _label_9: 
                _local_19 = (_local_8 + _local_17);
                si16(_local_18, (_local_19 + 8));
                _local_17 = (_local_17 + 2);
                _local_15 = (_local_15 + 1);
                if (_local_15 > _local_1) goto _label_11;
            } while (true);
            _local_19 = (_local_19 + -1);
            if (!(_local_3 > 0))
            {
                _local_20 = 0;
                
            _label_10: 
                _local_21 = li16(_local_18);
                _local_20 = (_local_21 + _local_20);
                si16(_local_20, _local_18);
                _local_18 = _local_19;
                goto _label_9;
            };
            _local_20 = 0;
            _local_21 = (_local_3 << 1);
            _local_22 = (_local_11 + _local_17);
            _local_23 = _local_3;
            do 
            {
                _local_24 = (_local_22 + _local_21);
                _local_25 = li16(_local_24);
                _local_26 = (_local_9 + _local_21);
                _local_26 = li16(_local_26);
                _local_20 = (_local_25 + _local_20);
                _local_20 = (_local_20 + _local_26);
                si16(_local_20, _local_24);
                _local_21 = (_local_21 + -2);
                _local_23 = (_local_23 + -1);
                _local_20 = (_local_20 >>> 16);
                if (_local_23 < 1) goto _label_10;
            } while (true);
            
        _label_11: 
            if (!(_local_2 == 0))
            {
                if (!(_local_10 == 0))
                {
                    _local_4 = (_local_3 + _local_1);
                    _local_8 = (_local_4 << 1);
                    _local_7 = (_local_7 + _local_8);
                    if (!(_local_4 > _local_1))
                    {
                        _local_1 = _local_7;
                    }
                    else
                    {
                        _local_4 = (_local_3 + _local_1);
                        _local_8 = (_local_4 + -1);
                        _local_8 = (_local_8 << 1);
                        _local_9 = (_local_4 << 1);
                        _local_12 = (16 - _local_10);
                        do 
                        {
                            _local_15 = (_local_9 + _local_11);
                            _local_7 = li16(_local_7);
                            _local_16 = li16(_local_15 + -2);
                            _local_16 = (_local_16 << _local_12);
                            _local_7 = (_local_7 >>> _local_10);
                            _local_7 = (_local_16 | _local_7);
                            si16(_local_7, _local_15);
                            _local_7 = (_local_8 + _local_11);
                            _local_11 = (_local_11 + -2);
                            _local_4 = (_local_4 + -1);
                        } while (!(_local_4 <= _local_1));
                        _local_1 = (_local_3 + _local_1);
                        _local_1 = (_local_1 << 1);
                        _local_1 = (_local_1 + _local_11);
                    };
                    _local_3 = 0;
                    si16(_local_3, _local_1);
                };
                _local_1 = li16(_local_14);
                _local_3 = li16(_local_6);
                _local_4 = li16(_local_13);
                _local_5 = li16(_local_5);
                _local_3 = (_local_3 << 16);
                _local_1 = (_local_1 << 16);
                _local_3 = (_local_3 | _local_5);
                _local_1 = (_local_1 | _local_4);
                si32(_local_3, _local_2);
                si32(_local_1, (_local_2 + 4));
            };
            _local_1 = li16(mstate.ebp + -10);
            _local_2 = li16(mstate.ebp + -14);
            _local_3 = li16(mstate.ebp + -8);
            _local_4 = li16(mstate.ebp + -12);
            _local_1 = (_local_1 << 16);
            _local_2 = (_local_2 << 16);
            _local_1 = (_local_1 | _local_3);
            _local_2 = (_local_2 | _local_4);
            
        _label_12: 
            mstate.edx = _local_2;
            
        _label_13: 
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_14: 
            goto _label_2;
            
        _label_15: 
            _local_19 = _local_27;
            goto _label_7;
            
        _label_16: 
            _local_21 = _local_20;
            _local_20 = _local_24;
            goto _label_8;
        }


    }
} cmodule.lua_wrapper

