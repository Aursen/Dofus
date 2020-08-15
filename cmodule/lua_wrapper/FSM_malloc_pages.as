package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_malloc_pages extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_1 = (_local_1 + 4095);
            _local_2 = li32(_free_list);
            _local_3 = (_local_1 & 0xFFFFF000);
            if (!(_local_2 == 0))
            {
                _local_1 = _local_2;
                do 
                {
                    _local_2 = li32(_local_1 + 16);
                    _local_4 = (_local_1 + 16);
                    if (!(uint(_local_2) < uint(_local_3)))
                    {
                        _local_5 = li32(_local_1 + 8);
                        _local_6 = (_local_1 + 8);
                        if (!(!(_local_2 == _local_3)))
                        {
                            _local_2 = li32(_local_1);
                            _local_4 = _local_1;
                            if (!(_local_2 == 0))
                            {
                                _local_6 = li32(_local_1 + 4);
                                si32(_local_6, (_local_2 + 4));
                            };
                            _local_2 = li32(_local_1 + 4);
                            _local_4 = li32(_local_4);
                            si32(_local_4, _local_2);
                            _local_2 = (_local_3 >>> 12);
                            if (!(_local_5 == 0))
                            {
                                _local_4 = _local_5;
                                goto _label_3;
                            };
                            goto _label_1;
                        };
                        _local_1 = (_local_5 + _local_3);
                        si32(_local_1, _local_6);
                        _local_1 = (_local_2 - _local_3);
                        si32(_local_1, _local_4);
                        _local_2 = (_local_3 >>> 12);
                        if (!(_local_5 == 0))
                        {
                            _local_1 = 0;
                            _local_4 = _local_5;
                            goto _label_3;
                        };
                        _local_1 = 0;
                        goto _label_1;
                    };
                    _local_1 = li32(_local_1);
                } while (!(_local_1 == 0));
            };
            _local_1 = 0;
            _local_2 = (_local_3 >>> 12);
            
        _label_1: 
            _local_4 = _local_1;
            _local_5 = _local_2;
            _local_1 = 0;
            _local_1 = _sbrk(_local_1);
            _local_1 = (_local_1 + 4095);
            _local_6 = (_local_1 & 0xFFFFF000);
            _local_1 = (_local_6 + _local_3);
            if (!(uint(_local_1) >= uint(_local_6)))
            {
                
            _label_2: 
                _local_6 = 0;
                _local_1 = _local_4;
                _local_2 = _local_5;
                _local_4 = _local_6;
                goto _label_3;
            };
            _local_2 = _local_1;
            _local_2 = _brk(_local_2);
            if (!(_local_2 == 0)) goto _label_2;
            _local_2 = (_local_1 >>> 12);
            _local_7 = li32(_malloc_origo);
            _local_2 = (_local_2 + -1);
            _local_7 = (_local_2 - _local_7);
            si32(_local_7, _last_index);
            si32(_local_1, _malloc_brk);
            _local_1 = li32(_malloc_ninfo);
            _local_2 = (_local_7 + 1);
            if (!(uint(_local_2) >= uint(_local_1)))
            {
                _local_1 = _local_4;
                _local_2 = _local_5;
                _local_4 = _local_6;
            }
            else
            {
                _local_1 = __2E_str210;
                _local_2 = 4;
                _local_8 = 0;
                log(_local_2, mstate.gworker.stringFromPtr(_local_1));
                _local_1 = _sbrk(_local_8);
                _local_1 = (_local_1 & 0x0FFF);
                _local_1 = (0x1000 - _local_1);
                _local_2 = (_local_7 >>> 9);
                _local_1 = (_local_1 & 0x0FFF);
                _local_2 = (_local_2 & 0x0FFFFF);
                _local_2 = (_local_2 + 2);
                _local_1 = _sbrk(_local_1);
                _local_1 = (_local_2 << 12);
                _local_1 = _sbrk(_local_1);
                _local_7 = _local_1;
                if (_local_1 == -1) goto _label_2;
                _local_8 = __2E_str19;
                _local_9 = li32(_malloc_ninfo);
                _local_10 = li32(_page_dir);
                _local_9 = (_local_9 << 2);
                _local_2 = (_local_2 << 10);
                memcpy(_local_1, _local_10, _local_9);
                _local_1 = (_local_2 & 0x3FFFFC00);
                si32(_local_1, _malloc_ninfo);
                si32(_local_7, _page_dir);
                _local_2 = 4;
                _local_1 = _local_8;
                log(_local_2, mstate.gworker.stringFromPtr(_local_1));
                _local_1 = _local_4;
                _local_2 = _local_5;
                _local_4 = _local_6;
            };
            
        _label_3: 
            if (!(_local_4 == 0))
            {
                _local_5 = 2;
                _local_6 = li32(_malloc_origo);
                _local_7 = (_local_4 >>> 12);
                _local_8 = (_local_7 - _local_6);
                _local_9 = li32(_page_dir);
                _local_8 = (_local_8 << 2);
                _local_8 = (_local_9 + _local_8);
                si32(_local_5, _local_8);
                if (!(uint(_local_2) < uint(2)))
                {
                    _local_5 = 0;
                    _local_6 = (_local_7 - _local_6);
                    _local_6 = (_local_6 << 2);
                    _local_6 = (_local_6 + _local_9);
                    _local_6 = (_local_6 + 4);
                    _local_2 = (_local_2 + -1);
                    do 
                    {
                        _local_7 = 3;
                        si32(_local_7, _local_6);
                        _local_6 = (_local_6 + 4);
                        _local_5 = (_local_5 + 1);
                    } while (!(_local_5 == _local_2));
                };
                _local_2 = li8(_malloc_junk_2E_b);
                _local_2 = (_local_2 ^ 0x01);
                _local_2 = (_local_2 & 0x01);
                if (!(!(_local_2 == 0)))
                {
                    _local_2 = -48;
                    _local_5 = _local_4;
                    memset(_local_5, _local_2, _local_3);
                };
            };
            if (!(_local_1 == 0))
            {
                _local_2 = li32(_px);
                if (!(!(_local_2 == 0)))
                {
                    si32(_local_1, _px);
                }
                else
                {
                    mstate.esp = (mstate.esp - 4);
                    si32(_local_1, mstate.esp);
                    mstate.esp = (mstate.esp - 4);
                    FSM_ifree.start();
                    mstate.esp = (mstate.esp + 4);
                };
            };
            mstate.eax = _local_4;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

