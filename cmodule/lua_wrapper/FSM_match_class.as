package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_match_class extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(__CurrentRuneLocale);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(mstate.ebp + 12);
            if (!(uint(_local_3) < uint(0x0100)))
            {
                if (!(_local_3 > -1))
                {
                    
                _label_1: 
                    _local_4 = _local_3;
                    
                _label_2: 
                    if (_local_4 > 114) goto _label_6;
                    if (_local_4 > 99) goto _label_4;
                    if (_local_4 == 97) goto _label_10;
                    if (!(_local_4 == 99))
                    {
                        goto _label_9;
                    };
                    
                _label_3: 
                    if (uint(_local_2) < uint(0x0100)) goto _label_13;
                    mstate.esp = (mstate.esp - 4);
                    si32(_local_2, mstate.esp);
                    mstate.esp = (mstate.esp - 4);
                    FSM____runetype.start();
                    _local_2 = mstate.eax;
                    _local_2 = (_local_2 >>> 9);
                    mstate.esp = (mstate.esp + 4);
                    _local_2 = (_local_2 & 0x01);
                    if (uint(_local_3) > uint(0xFF)) goto _label_12;
                    goto _label_11;
                };
                _local_4 = li32(_local_1 + 3136);
                _local_5 = li32(_local_1 + 3132);
                if (_local_5 == 0) goto _label_1;
                do 
                {
                    _local_6 = (_local_5 & 0x1FFFFFFE);
                    _local_6 = (_local_6 << 3);
                    _local_6 = (_local_4 + _local_6);
                    _local_6 = li32(_local_6);
                    _local_7 = (_local_5 >>> 1);
                    if (!(_local_6 > _local_3))
                    {
                        _local_8 = (_local_7 << 4);
                        _local_8 = (_local_4 + _local_8);
                        _local_8 = li32(_local_8 + 4);
                        if (!(_local_8 < _local_3))
                        {
                            _local_5 = (_local_7 << 4);
                            _local_4 = (_local_4 + _local_5);
                            _local_4 = li32(_local_4 + 8);
                            _local_4 = (_local_4 + _local_3);
                            _local_4 = (_local_4 - _local_6);
                            goto _label_2;
                        };
                    };
                    _local_6 = (_local_7 << 4);
                    _local_6 = (_local_4 + _local_6);
                    _local_6 = li32(_local_6 + 4);
                    if ((_local_6 < _local_3))
                    {
                        _local_6 = (_local_7 << 4);
                        _local_4 = (_local_6 + _local_4);
                        _local_4 = (_local_4 + 16);
                        _local_5 = (_local_5 + -1);
                    };
                    _local_6 = (_local_5 >>> 1);
                    if (uint(_local_5) < uint(2)) goto _label_1;
                    _local_5 = _local_6;
                } while (true);
                
            _label_4: 
                if (_local_4 == 100) goto _label_14;
                if (_local_4 == 108) goto _label_15;
                if (!(_local_4 == 112))
                {
                    goto _label_9;
                };
                
            _label_5: 
                if (uint(_local_2) < uint(0x0100)) goto _label_17;
                mstate.esp = (mstate.esp - 4);
                si32(_local_2, mstate.esp);
                mstate.esp = (mstate.esp - 4);
                FSM____runetype.start();
                _local_2 = mstate.eax;
                _local_2 = (_local_2 >>> 13);
                mstate.esp = (mstate.esp + 4);
                _local_2 = (_local_2 & 0x01);
                if (uint(_local_3) > uint(0xFF)) goto _label_16;
                goto _label_11;
                
            _label_6: 
                if (!(_local_4 > 118))
                {
                    if (_local_4 == 115) goto _label_18;
                    if (!(_local_4 == 117))
                    {
                        goto _label_9;
                    };
                    
                _label_7: 
                    if (uint(_local_2) < uint(0x0100)) goto _label_20;
                    mstate.esp = (mstate.esp - 4);
                    si32(_local_2, mstate.esp);
                    mstate.esp = (mstate.esp - 4);
                    FSM____runetype.start();
                    _local_2 = mstate.eax;
                    _local_2 = (_local_2 >>> 15);
                    mstate.esp = (mstate.esp + 4);
                    _local_2 = (_local_2 & 0x01);
                    if (uint(_local_3) > uint(0xFF)) goto _label_19;
                    goto _label_11;
                };
                if (_local_4 == 119) goto _label_21;
                if (_local_4 == 120) goto _label_22;
                if (!(_local_4 == 122))
                {
                    goto _label_9;
                };
                
            _label_8: 
                _local_2 = ((_local_2 == 0) ? 1 : 0);
                _local_2 = (_local_2 & 0x01);
                if (uint(_local_3) > uint(0xFF)) goto _label_23;
                goto _label_11;
            };
            _local_4 = (_local_3 << 2);
            _local_4 = (_local_1 + _local_4);
            _local_4 = li32(_local_4 + 1076);
            if (!(_local_4 > 114))
            {
                if (!(_local_4 > 99))
                {
                    if (_local_4 == 97) goto _label_10;
                    if (_local_4 == 99) goto _label_3;
                }
                else
                {
                    if (_local_4 == 100) goto _label_14;
                    if (_local_4 == 108) goto _label_15;
                    if (_local_4 == 112) goto _label_5;
                };
            }
            else
            {
                if (!(_local_4 > 118))
                {
                    if (_local_4 == 115) goto _label_18;
                    if (_local_4 == 117) goto _label_7;
                }
                else
                {
                    if (_local_4 == 119) goto _label_21;
                    if (_local_4 == 120) goto _label_22;
                    if (_local_4 == 122) goto _label_8;
                };
            };
            
        _label_9: 
            _local_2 = ((_local_3 == _local_2) ? 1 : 0);
            _local_2 = (_local_2 & 0x01);
            mstate.eax = _local_2;
            goto _label_29;
            
        _label_10: 
            if (!(uint(_local_2) < uint(0x0100)))
            {
                mstate.esp = (mstate.esp - 4);
                si32(_local_2, mstate.esp);
                mstate.esp = (mstate.esp - 4);
                FSM____runetype.start();
                _local_2 = mstate.eax;
                _local_2 = (_local_2 >>> 8);
                mstate.esp = (mstate.esp + 4);
                _local_2 = (_local_2 & 0x01);
                if (!(uint(_local_3) > uint(0xFF)))
                {
                    
                _label_11: 
                    _local_3 = (_local_3 << 2);
                    _local_1 = (_local_1 + _local_3);
                    _local_1 = li32(_local_1 + 52);
                    _local_1 = (_local_1 & 0x1000);
                    if (_local_1 == 0) goto _label_26;
                    _local_1 = _local_2;
                    goto _label_28;
                };
                goto _label_25;
            };
            _local_2 = (_local_2 << 2);
            _local_2 = (_local_1 + _local_2);
            _local_2 = li32(_local_2 + 52);
            _local_2 = (_local_2 >>> 8);
            _local_2 = (_local_2 & 0x01);
            if (!(uint(_local_3) > uint(0xFF))) goto _label_11;
            goto _label_25;
            
        _label_12: 
            goto _label_25;
            
        _label_13: 
            _local_2 = (_local_2 << 2);
            _local_2 = (_local_1 + _local_2);
            _local_2 = li32(_local_2 + 52);
            _local_2 = (_local_2 >>> 9);
            _local_2 = (_local_2 & 0x01);
            if (!(uint(_local_3) > uint(0xFF))) goto _label_11;
            goto _label_25;
            
        _label_14: 
            if (!(uint(_local_2) > uint(0xFF)))
            {
                _local_4 = __DefaultRuneLocale;
                _local_2 = (_local_2 << 2);
                _local_2 = (_local_4 + _local_2);
                _local_2 = li32(_local_2 + 52);
                _local_2 = (_local_2 & 0x0400);
                if (!(_local_2 == 0)) goto _label_24;
            };
            if (!(uint(_local_3) > uint(0xFF)))
            {
                do 
                {
                    _local_2 = 0;
                    goto _label_11;
                    
                _label_15: 
                    if (!(uint(_local_2) < uint(0x0100)))
                    {
                        mstate.esp = (mstate.esp - 4);
                        si32(_local_2, mstate.esp);
                        mstate.esp = (mstate.esp - 4);
                        FSM____runetype.start();
                        _local_2 = mstate.eax;
                        _local_2 = (_local_2 >>> 12);
                        mstate.esp = (mstate.esp + 4);
                        _local_2 = (_local_2 & 0x01);
                        if (!(uint(_local_3) > uint(0xFF))) goto _label_11;
                        goto _label_25;
                    };
                    _local_2 = (_local_2 << 2);
                    _local_2 = (_local_1 + _local_2);
                    _local_2 = li32(_local_2 + 52);
                    _local_2 = (_local_2 >>> 12);
                    _local_2 = (_local_2 & 0x01);
                    if (!(uint(_local_3) > uint(0xFF))) goto _label_11;
                    goto _label_25;
                    
                _label_16: 
                    goto _label_25;
                    
                _label_17: 
                    _local_2 = (_local_2 << 2);
                    _local_2 = (_local_1 + _local_2);
                    _local_2 = li32(_local_2 + 52);
                    _local_2 = (_local_2 >>> 13);
                    _local_2 = (_local_2 & 0x01);
                    if (!(uint(_local_3) > uint(0xFF))) goto _label_11;
                    goto _label_25;
                    
                _label_18: 
                    if (!(uint(_local_2) < uint(0x0100)))
                    {
                        mstate.esp = (mstate.esp - 4);
                        si32(_local_2, mstate.esp);
                        mstate.esp = (mstate.esp - 4);
                        FSM____runetype.start();
                        _local_2 = mstate.eax;
                        _local_2 = (_local_2 >>> 14);
                        mstate.esp = (mstate.esp + 4);
                        _local_2 = (_local_2 & 0x01);
                        if (!(uint(_local_3) > uint(0xFF))) goto _label_11;
                        goto _label_25;
                    };
                    _local_2 = (_local_2 << 2);
                    _local_2 = (_local_1 + _local_2);
                    _local_2 = li32(_local_2 + 52);
                    _local_2 = (_local_2 >>> 14);
                    _local_2 = (_local_2 & 0x01);
                    if (!(uint(_local_3) > uint(0xFF))) goto _label_11;
                    goto _label_25;
                    
                _label_19: 
                    goto _label_25;
                    
                _label_20: 
                    _local_2 = (_local_2 << 2);
                    _local_2 = (_local_1 + _local_2);
                    _local_2 = li32(_local_2 + 52);
                    _local_2 = (_local_2 >>> 15);
                    _local_2 = (_local_2 & 0x01);
                    if (!(uint(_local_3) > uint(0xFF))) goto _label_11;
                    goto _label_25;
                    
                _label_21: 
                    if (!(uint(_local_2) < uint(0x0100)))
                    {
                        mstate.esp = (mstate.esp - 4);
                        si32(_local_2, mstate.esp);
                        mstate.esp = (mstate.esp - 4);
                        FSM____runetype.start();
                        _local_2 = mstate.eax;
                        _local_2 = (_local_2 & 0x0500);
                        _local_2 = ((_local_2 != 0) ? 1 : 0);
                        mstate.esp = (mstate.esp + 4);
                        _local_2 = (_local_2 & 0x01);
                        if (!(uint(_local_3) > uint(0xFF))) goto _label_11;
                        goto _label_25;
                    };
                    _local_2 = (_local_2 << 2);
                    _local_2 = (_local_1 + _local_2);
                    _local_2 = li32(_local_2 + 52);
                    _local_2 = (_local_2 & 0x0500);
                    _local_2 = ((_local_2 != 0) ? 1 : 0);
                    _local_2 = (_local_2 & 0x01);
                    if (!(uint(_local_3) > uint(0xFF))) goto _label_11;
                    goto _label_25;
                    
                _label_22: 
                    if (!(uint(_local_2) > uint(0xFF)))
                    {
                        _local_4 = __DefaultRuneLocale;
                        _local_2 = (_local_2 << 2);
                        _local_2 = (_local_4 + _local_2);
                        _local_2 = li32(_local_2 + 52);
                        _local_2 = (_local_2 & 0x010000);
                        if (!(_local_2 == 0)) goto _label_24;
                    };
                } while (!(uint(_local_3) > uint(0xFF)));
            };
            _local_2 = 0;
            goto _label_25;
            
        _label_23: 
            goto _label_25;
            
        _label_24: 
            if (!(uint(_local_3) > uint(0xFF)))
            {
                _local_2 = 1;
                goto _label_11;
            };
            _local_2 = 1;
            
        _label_25: 
            _local_1 = _local_2;
            mstate.esp = (mstate.esp - 4);
            si32(_local_3, mstate.esp);
            mstate.esp = (mstate.esp - 4);
            FSM____runetype.start();
            _local_2 = mstate.eax;
            mstate.esp = (mstate.esp + 4);
            _local_2 = (_local_2 & 0x1000);
            if ((_local_2 == 0))
            {
                goto _label_27;
                
            _label_26: 
                _local_1 = _local_2;
                
            _label_27: 
                _local_1 = ((_local_1 == 0) ? 1 : 0);
                _local_1 = (_local_1 & 0x01);
            };
            
        _label_28: 
            mstate.eax = _local_1;
            
        _label_29: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

