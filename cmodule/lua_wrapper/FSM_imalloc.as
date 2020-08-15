package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_imalloc extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = (_local_1 + 0x1000);
            if (!(uint(_local_2) >= uint(_local_1)))
            {
                
            _label_1: 
                _local_2 = 0;
                goto _label_12;
            };
            if (!(uint(_local_1) > uint(0x0800)))
            {
                _local_2 = (_local_1 + -1);
                _local_2 = ((uint(_local_1) < uint(16)) ? 15 : _local_2);
                if (uint(_local_2) < uint(2)) goto _label_14;
                _local_3 = -1;
                do 
                {
                    _local_3 = (_local_3 + 1);
                    _local_2 = (_local_2 >> 1);
                } while (!(uint(_local_2) < uint(2)));
                _local_2 = (_local_3 + 2);
                
            _label_2: 
                _local_3 = li32(_page_dir);
                _local_4 = (_local_2 << 2);
                _local_4 = (_local_3 + _local_4);
                _local_4 = li32(_local_4);
                if (!(!(_local_4 == 0)))
                {
                    _local_3 = 0x1000;
                    mstate.esp = (mstate.esp - 4);
                    si32(_local_3, mstate.esp);
                    mstate.esp = (mstate.esp - 4);
                    FSM_malloc_pages.start();
                    _local_3 = mstate.eax;
                    mstate.esp = (mstate.esp + 4);
                    if (_local_3 == 0) goto _label_1;
                    _local_4 = 0x1000;
                    _local_4 = (_local_4 >>> _local_2);
                    _local_5 = (_local_4 + 31);
                    _local_5 = (_local_5 >>> 3);
                    _local_6 = 1;
                    _local_5 = (_local_5 & 0x1FFFFFFC);
                    _local_7 = (_local_5 + 16);
                    _local_6 = (_local_6 << _local_2);
                    _local_8 = (_local_7 << 1);
                    if (!(_local_6 > _local_8))
                    {
                        _local_8 = _local_3;
                    }
                    else
                    {
                        mstate.esp = (mstate.esp - 4);
                        si32(_local_7, mstate.esp);
                        mstate.esp = (mstate.esp - 4);
                        FSM_imalloc.start();
                        _local_8 = mstate.eax;
                        mstate.esp = (mstate.esp + 4);
                        if (_local_8 == 0) goto _label_15;
                    };
                    si16(_local_6, (_local_8 + 8));
                    si16(_local_2, (_local_8 + 10));
                    si16(_local_4, (_local_8 + 12));
                    si16(_local_4, (_local_8 + 14));
                    si32(_local_3, (_local_8 + 4));
                    _local_9 = (_local_4 & 0xFFFF);
                    _local_10 = (_local_8 + 14);
                    _local_11 = (_local_8 + 12);
                    _local_12 = _local_8;
                    if (!(uint(_local_9) > uint(31)))
                    {
                        _local_13 = 0;
                        
                    _label_3: 
                        if (_local_13 < _local_9) goto _label_5;
                        
                    _label_4: 
                        if (!(_local_3 == _local_8)) goto _label_7;
                        if (_local_7 < 1) goto _label_7;
                        _local_7 = 0;
                        _local_5 = (_local_5 + 16);
                        do 
                        {
                            _local_9 = 1;
                            _local_13 = (_local_7 & 0xFFFFFFE0);
                            _local_14 = (_local_7 & 0x1F);
                            _local_13 = (_local_13 >>> 3);
                            _local_9 = (_local_9 << _local_14);
                            _local_13 = (_local_12 + _local_13);
                            _local_14 = li32(_local_13 + 16);
                            _local_9 = (_local_9 ^ 0xFFFFFFFF);
                            _local_9 = (_local_14 & _local_9);
                            si32(_local_9, (_local_13 + 16));
                            _local_9 = li16(_local_10);
                            _local_9 = (_local_9 + -1);
                            si16(_local_9, _local_10);
                            _local_5 = (_local_5 - _local_6);
                            _local_7 = (_local_7 + 1);
                            if (_local_5 < 1) goto _label_6;
                        } while (true);
                    };
                    _local_13 = 0;
                    _local_14 = _local_9;
                    _local_15 = _local_13;
                    do 
                    {
                        _local_16 = -1;
                        _local_17 = (_local_13 & 0x07FFFFFF);
                        _local_17 = (_local_17 << 2);
                        _local_17 = (_local_12 + _local_17);
                        si32(_local_16, (_local_17 + 16));
                        _local_14 = (_local_14 + -32);
                        _local_15 = (_local_15 + 32);
                        _local_13 = (_local_13 + 1);
                        if (!(uint(_local_14) > uint(31)))
                        {
                            _local_13 = _local_15;
                            goto _label_3;
                        };
                    } while (true);
                    
                _label_5: 
                    _local_14 = 0;
                    _local_9 = (_local_9 - _local_13);
                    do 
                    {
                        _local_15 = 1;
                        _local_16 = (_local_13 + _local_14);
                        _local_17 = (_local_16 & 0xFFFFFFE0);
                        _local_17 = (_local_17 >>> 3);
                        _local_16 = (_local_16 & 0x1F);
                        _local_17 = (_local_12 + _local_17);
                        _local_18 = li32(_local_17 + 16);
                        _local_15 = (_local_15 << _local_16);
                        _local_15 = (_local_18 | _local_15);
                        si32(_local_15, (_local_17 + 16));
                        _local_14 = (_local_14 + 1);
                        if (_local_14 == _local_9) goto _label_4;
                    } while (true);
                    
                _label_6: 
                    _local_5 = (_local_7 + -1);
                    _local_4 = (_local_4 - _local_5);
                    _local_4 = (_local_4 + -1);
                    si16(_local_4, _local_11);
                    
                _label_7: 
                    _local_4 = li32(_malloc_origo);
                    _local_3 = (_local_3 >>> 12);
                    _local_3 = (_local_3 - _local_4);
                    _local_4 = li32(_page_dir);
                    _local_3 = (_local_3 << 2);
                    _local_5 = (_local_2 << 2);
                    _local_3 = (_local_4 + _local_3);
                    si32(_local_12, _local_3);
                    _local_3 = (_local_4 + _local_5);
                    _local_5 = li32(_local_3);
                    si32(_local_5, _local_8);
                    si32(_local_12, _local_3);
                    _local_3 = li32(_local_12 + 16);
                    _local_5 = (_local_12 + 16);
                    if (!(_local_3 == 0))
                    {
                        _local_3 = _local_4;
                        _local_4 = _local_12;
                        
                    _label_8: 
                        _local_7 = li32(_local_5);
                        _local_6 = (_local_7 & 0x01);
                        if (_local_6 == 0) goto _label_16;
                        _local_8 = 1;
                        _local_6 = 0;
                        goto _label_11;
                    };
                    _local_3 = _local_4;
                    _local_4 = _local_12;
                    goto _label_9;
                };
                _local_5 = li32(_local_4 + 16);
                _local_6 = (_local_4 + 16);
                if (!(_local_5 == 0))
                {
                    _local_5 = _local_6;
                    goto _label_8;
                };
                _local_5 = _local_6;
                do 
                {
                    
                _label_9: 
                    _local_6 = li32(_local_5 + 4);
                    _local_5 = (_local_5 + 4);
                    _local_7 = _local_5;
                    if (!(_local_6 == 0)) goto _label_8;
                    _local_5 = _local_7;
                } while (true);
                do 
                {
                    
                _label_10: 
                    _local_6 = (_local_6 + 1);
                    _local_8 = (_local_8 << 1);
                    _local_9 = (_local_7 & _local_8);
                } while ((_local_9 == 0));
                
            _label_11: 
                _local_7 = (_local_7 ^ _local_8);
                si32(_local_7, _local_5);
                _local_7 = li16(_local_4 + 12);
                _local_7 = (_local_7 + -1);
                si16(_local_7, (_local_4 + 12));
                _local_7 = (_local_7 & 0xFFFF);
                if (!(!(_local_7 == 0)))
                {
                    _local_7 = 0;
                    _local_2 = (_local_2 << 2);
                    _local_8 = li32(_local_4);
                    _local_2 = (_local_3 + _local_2);
                    si32(_local_8, _local_2);
                    si32(_local_7, _local_4);
                };
                _local_2 = (_local_4 + 16);
                _local_2 = (_local_5 - _local_2);
                _local_2 = (_local_2 << 3);
                _local_3 = li8(_malloc_junk_2E_b);
                _local_5 = li16(_local_4 + 10);
                _local_2 = (_local_2 + _local_6);
                _local_3 = (_local_3 ^ 0x01);
                _local_2 = (_local_2 << _local_5);
                _local_3 = (_local_3 & 0x01);
                if (!(!(_local_3 == 0)))
                {
                    _local_3 = -48;
                    _local_5 = li16(_local_4 + 8);
                    _local_6 = li32(_local_4 + 4);
                    _local_6 = (_local_6 + _local_2);
                    memset(_local_6, _local_3, _local_5);
                    _local_4 = li32(_local_4 + 4);
                    _local_2 = (_local_4 + _local_2);
                }
                else
                {
                    _local_3 = li32(_local_4 + 4);
                    _local_2 = (_local_3 + _local_2);
                };
            }
            else
            {
                mstate.esp = (mstate.esp - 4);
                si32(_local_1, mstate.esp);
                mstate.esp = (mstate.esp - 4);
                FSM_malloc_pages.start();
                _local_2 = mstate.eax;
                mstate.esp = (mstate.esp + 4);
            };
            
        _label_12: 
            _local_3 = li8(_malloc_zero_2E_b);
            _local_3 = (_local_3 ^ 0x01);
            if (!(_local_2 == 0))
            {
                _local_3 = (_local_3 & 0x01);
                if (!(!(_local_3 == 0)))
                {
                    _local_3 = 0;
                    _local_4 = _local_2;
                    memset(_local_4, _local_3, _local_1);
                };
            };
            
        _label_13: 
            mstate.eax = _local_2;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_14: 
            _local_2 = 1;
            goto _label_2;
            
        _label_15: 
            _local_2 = 0;
            mstate.esp = (mstate.esp - 4);
            si32(_local_3, mstate.esp);
            mstate.esp = (mstate.esp - 4);
            FSM_ifree.start();
            mstate.esp = (mstate.esp + 4);
            goto _label_13;
            
        _label_16: 
            _local_8 = 1;
            _local_6 = 0;
            goto _label_10;
        }


    }
}

