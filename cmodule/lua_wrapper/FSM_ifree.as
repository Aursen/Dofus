package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_ifree extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            do 
            {
                _local_3 = _local_1;
                if (!(_local_3 == 0))
                {
                    _local_1 = li32(_malloc_origo);
                    _local_2 = (_local_3 >>> 12);
                    _local_4 = (_local_2 - _local_1);
                    _local_5 = _local_3;
                    if (!(uint(_local_4) < uint(12)))
                    {
                        _local_6 = li32(_last_index);
                        if (!(uint(_local_4) > uint(_local_6)))
                        {
                            _local_6 = li32(_page_dir);
                            _local_7 = (_local_4 << 2);
                            _local_7 = (_local_6 + _local_7);
                            _local_8 = li32(_local_7);
                            _local_9 = _local_6;
                            if (!(uint(_local_8) > uint(3)))
                            {
                                if (!(_local_8 == 2)) goto _label_8;
                                if (_local_8 == 1) goto _label_8;
                                _local_5 = (_local_5 & 0x0FFF);
                                if (!(_local_5 == 0)) goto _label_8;
                                _local_5 = 1;
                                _local_8 = (_local_4 << 2);
                                si32(_local_5, _local_7);
                                _local_5 = (_local_8 + _local_9);
                                _local_5 = li32(_local_5 + 4);
                                if (!(_local_5 == 3))
                                {
                                    _local_1 = 0x1000;
                                }
                                else
                                {
                                    _local_5 = 1;
                                    _local_1 = (_local_2 - _local_1);
                                    _local_1 = (_local_1 << 2);
                                    _local_8 = _local_6;
                                    do 
                                    {
                                        _local_2 = 1;
                                        _local_4 = (_local_1 + _local_8);
                                        si32(_local_2, (_local_4 + 4));
                                        _local_2 = li32(_local_4 + 8);
                                        _local_8 = (_local_8 + 4);
                                        _local_5 = (_local_5 + 1);
                                    } while (!(!(_local_2 == 3)));
                                    _local_1 = (_local_5 << 12);
                                };
                                _local_5 = _local_1;
                                _local_1 = li8(_malloc_junk_2E_b);
                                _local_1 = (_local_1 ^ 0x01);
                                _local_1 = (_local_1 & 0x01);
                                if (!(!(_local_1 == 0)))
                                {
                                    _local_1 = -48;
                                    _local_8 = _local_3;
                                    _local_2 = _local_5;
                                    memset(_local_8, _local_1, _local_2);
                                };
                                _local_1 = li8(_malloc_hint_2E_b);
                                _local_1 = (_local_1 ^ 0x01);
                                _local_1 = (_local_1 & 0x01);
                                if (!(!(_local_1 == 0)))
                                {
                                    _local_1 = __2E_str8;
                                    _local_8 = 4;
                                    _local_2 = _local_8;
                                    log(_local_2, mstate.gworker.stringFromPtr(_local_1));
                                };
                                _local_1 = li32(_px);
                                _local_8 = (_local_3 + _local_5);
                                if (!(_local_1 == 0))
                                {
                                    _local_2 = _local_1;
                                }
                                else
                                {
                                    _local_1 = 20;
                                    mstate.esp = (mstate.esp - 4);
                                    si32(_local_1, mstate.esp);
                                    mstate.esp = (mstate.esp - 4);
                                    FSM_imalloc.start();
                                    _local_1 = mstate.eax;
                                    mstate.esp = (mstate.esp + 4);
                                    si32(_local_1, _px);
                                    _local_2 = _local_1;
                                };
                                si32(_local_3, (_local_1 + 8));
                                si32(_local_8, (_local_2 + 12));
                                si32(_local_5, (_local_2 + 16));
                                _local_1 = li32(_free_list);
                                if (!(!(_local_1 == 0)))
                                {
                                    _local_5 = _free_list;
                                    si32(_local_1, _local_2);
                                    si32(_local_5, (_local_2 + 4));
                                    si32(_local_2, _free_list);
                                    _local_1 = 0;
                                    si32(_local_1, _px);
                                    _local_1 = li32(_local_2);
                                    if (!(_local_1 == 0))
                                    {
                                        _local_1 = 0;
                                        goto _label_6;
                                    };
                                    _local_1 = 0;
                                    _local_5 = _local_2;
                                }
                                else
                                {
                                    _local_4 = li32(_local_1 + 12);
                                    if ((uint(_local_4) < uint(_local_3)))
                                    {
                                        do 
                                        {
                                            _local_4 = _local_1;
                                            _local_1 = li32(_local_4);
                                            if (!(!(_local_1 == 0))) goto _label_1;
                                            _local_4 = li32(_local_1 + 12);
                                        } while ((uint(_local_4) < uint(_local_3)));
                                        goto _label_2;
                                        
                                    _label_1: 
                                        _local_1 = _local_4;
                                    };
                                    
                                _label_2: 
                                    _local_4 = li32(_local_1 + 8);
                                    _local_6 = (_local_1 + 8);
                                    if (!(uint(_local_4) <= uint(_local_8)))
                                    {
                                        _local_5 = 0;
                                        si32(_local_1, _local_2);
                                        _local_8 = li32(_local_1 + 4);
                                        si32(_local_8, (_local_2 + 4));
                                        si32(_local_2, (_local_1 + 4));
                                        _local_1 = li32(_local_2 + 4);
                                        si32(_local_2, _local_1);
                                        si32(_local_5, _px);
                                        _local_1 = _local_2;
                                    }
                                    else
                                    {
                                        _local_7 = li32(_local_1 + 12);
                                        _local_9 = (_local_1 + 12);
                                        if (!(!(_local_7 == _local_3)))
                                        {
                                            _local_8 = (_local_7 + _local_5);
                                            si32(_local_8, _local_9);
                                            _local_2 = li32(_local_1 + 16);
                                            _local_5 = (_local_2 + _local_5);
                                            si32(_local_5, (_local_1 + 16));
                                            _local_2 = li32(_local_1);
                                            _local_3 = (_local_1 + 16);
                                            _local_4 = _local_1;
                                            if (!(!(_local_2 == 0)))
                                            {
                                                
                                            _label_3: 
                                                _local_5 = 0;
                                                goto _label_4;
                                            };
                                            _local_6 = li32(_local_2 + 8);
                                            if (!(_local_8 == _local_6)) goto _label_3;
                                            _local_8 = li32(_local_2 + 12);
                                            si32(_local_8, _local_9);
                                            _local_8 = li32(_local_2 + 16);
                                            _local_5 = (_local_8 + _local_5);
                                            si32(_local_5, _local_3);
                                            _local_5 = li32(_local_2);
                                            si32(_local_5, _local_4);
                                            if (!(!(_local_5 == 0)))
                                            {
                                                _local_5 = _local_2;
                                                goto _label_4;
                                            };
                                            si32(_local_1, (_local_5 + 4));
                                            _local_5 = _local_2;
                                            goto _label_4;
                                        };
                                        if (!(!(_local_4 == _local_8)))
                                        {
                                            _local_2 = 0;
                                            _local_8 = li32(_local_1 + 16);
                                            _local_5 = (_local_8 + _local_5);
                                            si32(_local_5, (_local_1 + 16));
                                            si32(_local_3, _local_6);
                                            _local_5 = _local_2;
                                        }
                                        else
                                        {
                                            _local_5 = li32(_local_1);
                                            _local_3 = _local_1;
                                            if (!(_local_5 == 0)) goto _label_3;
                                            _local_5 = 0;
                                            si32(_local_5, _local_2);
                                            si32(_local_1, (_local_2 + 4));
                                            si32(_local_2, _local_3);
                                            si32(_local_5, _px);
                                            _local_1 = _local_2;
                                        };
                                    };
                                    
                                _label_4: 
                                    _local_3 = _local_5;
                                    _local_5 = li32(_local_1);
                                    if (!(_local_5 == 0))
                                    {
                                        _local_1 = _local_3;
                                        goto _label_6;
                                    };
                                    _local_5 = _local_1;
                                    _local_1 = _local_3;
                                };
                                _local_3 = _local_5;
                                _local_5 = li32(_local_3 + 16);
                                _local_8 = li32(_malloc_cache);
                                _local_2 = (_local_3 + 16);
                                if (!(uint(_local_5) > uint(_local_8)))
                                {
                                    
                                _label_5: 
                                    goto _label_6;
                                };
                                _local_5 = li32(_local_3 + 12);
                                _local_8 = li32(_malloc_brk);
                                _local_4 = (_local_3 + 12);
                                if (!(_local_5 == _local_8)) goto _label_5;
                                _local_5 = 0;
                                _local_5 = _sbrk(_local_5);
                                _local_8 = li32(_malloc_brk);
                                if (!(_local_5 == _local_8)) goto _label_5;
                                _local_3 = li32(_local_3 + 8);
                                _local_5 = li32(_malloc_cache);
                                _local_3 = (_local_3 + _local_5);
                                si32(_local_3, _local_4);
                                si32(_local_5, _local_2);
                                _local_3 = _brk(_local_3);
                                _local_3 = li32(_local_4);
                                si32(_local_3, _malloc_brk);
                                _local_5 = li32(_malloc_origo);
                                _local_8 = li32(_last_index);
                                _local_3 = (_local_3 >>> 12);
                                _local_2 = (_local_3 - _local_5);
                                if (!(uint(_local_2) > uint(_local_8)))
                                {
                                    _local_3 = (_local_3 - _local_5);
                                    _local_5 = li32(_page_dir);
                                    _local_4 = (_local_3 << 2);
                                    _local_5 = (_local_5 + _local_4);
                                    do 
                                    {
                                        _local_4 = 0;
                                        si32(_local_4, _local_5);
                                        _local_5 = (_local_5 + 4);
                                        _local_3 = (_local_3 + 1);
                                    } while (!(uint(_local_3) > uint(_local_8)));
                                };
                                _local_3 = (_local_2 + -1);
                                si32(_local_3, _last_index);
                                
                            _label_6: 
                                if (_local_1 == 0) goto _label_8;
                                continue;
                            };
                            _local_1 = li16(_local_8 + 8);
                            _local_2 = li16(_local_8 + 10);
                            _local_4 = (_local_5 & 0x0FFF);
                            _local_2 = (_local_4 >>> _local_2);
                            _local_4 = (_local_8 + 10);
                            _local_6 = (_local_1 + -1);
                            _local_5 = (_local_6 & _local_5);
                            if (!(!(_local_5 == 0)))
                            {
                                _local_5 = 1;
                                _local_6 = (_local_2 & 0xFFFFFFE0);
                                _local_6 = (_local_6 >>> 3);
                                _local_6 = (_local_8 + _local_6);
                                _local_2 = (_local_2 & 0x1F);
                                _local_7 = li32(_local_6 + 16);
                                _local_2 = (_local_5 << _local_2);
                                _local_5 = (_local_6 + 16);
                                _local_6 = (_local_7 & _local_2);
                                if (!(!(_local_6 == 0)))
                                {
                                    _local_6 = li8(_malloc_junk_2E_b);
                                    _local_6 = (_local_6 ^ 0x01);
                                    _local_6 = (_local_6 & 0x01);
                                    if (!(!(_local_6 == 0)))
                                    {
                                        _local_6 = -48;
                                        memset(_local_3, _local_6, _local_1);
                                    };
                                    _local_1 = li32(_local_5);
                                    _local_1 = (_local_1 | _local_2);
                                    si32(_local_1, _local_5);
                                    _local_1 = li16(_local_8 + 12);
                                    _local_2 = (_local_1 + 1);
                                    si16(_local_2, (_local_8 + 12));
                                    _local_3 = li16(_local_4);
                                    _local_4 = li32(_page_dir);
                                    _local_3 = (_local_3 << 2);
                                    _local_3 = (_local_4 + _local_3);
                                    if (!(_local_1 == 0)) goto _label_9;
                                    _local_1 = li32(_local_3);
                                    if (!(!(_local_1 == 0)))
                                    {
                                        _local_1 = _local_3;
                                    }
                                    else
                                    {
                                        _local_1 = (_local_8 + 4);
                                        _local_2 = _local_3;
                                        do 
                                        {
                                            _local_3 = li32(_local_2);
                                            _local_4 = li32(_local_3);
                                            if (!(!(_local_4 == 0)))
                                            {
                                                _local_1 = _local_2;
                                                goto _label_7;
                                            };
                                            _local_5 = li32(_local_4 + 4);
                                            _local_6 = li32(_local_1);
                                            _local_2 = ((uint(_local_5) < uint(_local_6)) ? _local_3 : _local_2);
                                            _local_5 = ((uint(_local_5) >= uint(_local_6)) ? 1 : 0);
                                            if ((_local_4 == 0)) break;
                                            _local_4 = (_local_5 & 0x01);
                                            if ((!(_local_4 == 0))) break;
                                            _local_2 = _local_3;
                                        } while (true);
                                        _local_1 = _local_2;
                                    };
                                    
                                _label_7: 
                                    _local_2 = li32(_local_1);
                                    si32(_local_2, _local_8);
                                    si32(_local_8, _local_1);
                                };
                            };
                        };
                    };
                };
                
            _label_8: 
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
                
            _label_9: 
                _local_1 = li16(_local_8 + 14);
                _local_2 = (_local_2 & 0xFFFF);
                if (!(_local_2 == _local_1)) goto _label_8;
                _local_1 = li32(_local_3);
                if (!(_local_1 == _local_8))
                {
                    _local_1 = _local_3;
                    do 
                    {
                        _local_1 = li32(_local_1);
                        _local_2 = li32(_local_1);
                        if (_local_2 == _local_8) goto _label_11;
                    } while (true);
                    
                _label_10: 
                    mstate.esp = (mstate.esp - 4);
                    si32(_local_2, mstate.esp);
                    mstate.esp = (mstate.esp - 4);
                    FSM_ifree.start();
                    mstate.esp = (mstate.esp + 4);
                    continue;
                };
                _local_1 = _local_3;
                
            _label_11: 
                _local_2 = 2;
                _local_3 = li32(_local_8);
                si32(_local_3, _local_1);
                _local_1 = li32(_local_8 + 4);
                _local_3 = li32(_malloc_origo);
                _local_1 = (_local_1 >>> 12);
                _local_1 = (_local_1 - _local_3);
                _local_1 = (_local_1 << 2);
                _local_1 = (_local_4 + _local_1);
                si32(_local_2, _local_1);
                _local_1 = li32(_local_8 + 4);
                _local_2 = _local_8;
                if (!(_local_1 == _local_8)) goto _label_10;
            } while (true);
        }


    }
}

