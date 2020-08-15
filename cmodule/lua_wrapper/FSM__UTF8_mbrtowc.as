package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM__UTF8_mbrtowc extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 20);
            _local_2 = li32(_local_1 + 4);
            _local_3 = (_local_1 + 4);
            _local_4 = li32(mstate.ebp + 8);
            _local_5 = li32(mstate.ebp + 12);
            _local_6 = li32(mstate.ebp + 16);
            _local_7 = _local_1;
            if (!(uint(_local_2) < uint(7)))
            {
                _local_1 = 22;
                
            _label_1: 
                si32(_local_1, _val_2E_1440);
                _local_1 = -1;
            }
            else
            {
                _local_8 = __2E_str45;
                _local_8 = ((_local_5 == 0) ? _local_8 : _local_5);
                _local_6 = ((_local_5 == 0) ? 1 : _local_6);
                _local_4 = ((_local_5 == 0) ? 0 : _local_4);
                if (!(_local_6 == 0)) goto _label_3;
                _local_1 = -2;
            };
            
        _label_2: 
            mstate.eax = _local_1;
            do 
            {
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
                
            _label_3: 
                if (!(!(_local_2 == 0)))
                {
                    _local_5 = li8(_local_8);
                    _local_9 = (_local_5 & 0x80);
                    _local_10 = _local_5;
                    if (!(!(_local_9 == 0)))
                    {
                        _local_1 = (_local_5 & 0xFF);
                        _local_1 = ((_local_1 != 0) ? 1 : 0);
                        _local_1 = (_local_1 & 0x01);
                        if (!(!(_local_4 == 0))) goto _label_2;
                        si32(_local_10, _local_4);
                        //unresolved jump
                    };
                    if (!(!(_local_2 == 0)))
                    {
                        if (!(!(_local_9 == 0)))
                        {
                            _local_10 = 0;
                            _local_5 = 1;
                            _local_9 = 127;
                            goto _label_4;
                        };
                        _local_5 = (_local_10 & 0xE0);
                        if (!(!(_local_5 == 192)))
                        {
                            _local_10 = 128;
                            _local_5 = 2;
                            _local_9 = 31;
                            goto _label_4;
                        };
                        _local_5 = (_local_10 & 0xF0);
                        if (!(!(_local_5 == 224)))
                        {
                            _local_10 = 0x0800;
                            _local_5 = 3;
                            _local_9 = 15;
                            goto _label_4;
                        };
                        _local_5 = (_local_10 & 0xF8);
                        if (!(!(_local_5 == 240)))
                        {
                            _local_10 = 0x10000;
                            _local_5 = 4;
                            _local_9 = 7;
                            goto _label_4;
                        };
                        _local_5 = (_local_10 & 0xFC);
                        if (!(!(_local_5 == 248)))
                        {
                            _local_10 = 0x200000;
                            _local_5 = 5;
                            _local_9 = 3;
                            goto _label_4;
                        };
                        _local_5 = (_local_10 & 0xFE);
                        if (!(_local_5 == 252)) goto _label_8;
                        _local_10 = 0x4000000;
                        _local_5 = 6;
                        _local_9 = 1;
                        goto _label_4;
                    };
                };
                _local_10 = li32(_local_7 + 8);
                _local_9 = _local_5;
                _local_5 = _local_2;
                
            _label_4: 
                if (!(!(_local_2 == 0)))
                {
                    _local_2 = ((_local_2 == 0) ? 1 : 0);
                    _local_11 = li8(_local_8);
                    _local_2 = (_local_2 & 0x01);
                    _local_8 = (_local_8 + 1);
                    _local_9 = (_local_11 & _local_9);
                    _local_11 = ((uint(_local_6) <= uint(_local_5)) ? _local_6 : _local_5);
                    if (uint(_local_2) < uint(_local_11)) goto _label_5;
                    _local_8 = _local_9;
                    goto _label_7;
                };
                _local_2 = ((_local_2 == 0) ? 1 : 0);
                _local_9 = li32(_local_1);
                _local_2 = (_local_2 & 0x01);
                goto _label_6;
                
            _label_5: 
                _local_11 = li8(_local_8);
                _local_12 = (_local_11 & 0xC0);
                if (!(_local_12 == 128))
                {
                    _local_2 = 86;
                    si32(_local_2, _val_2E_1440);
                    _local_2 = -1;
                    mstate.eax = _local_2;
                    continue;
                };
                _local_11 = (_local_11 & 0x3F);
                _local_9 = (_local_9 << 6);
                _local_2 = (_local_2 + 1);
                _local_8 = (_local_8 + 1);
                _local_9 = (_local_11 | _local_9);
                
            _label_6: 
                _local_11 = ((uint(_local_6) <= uint(_local_5)) ? _local_6 : _local_5);
                if (uint(_local_2) < uint(_local_11)) goto _label_9;
                _local_8 = _local_9;
                
            _label_7: 
                _local_6 = _local_8;
                if ((_local_2 >= _local_5)) break;
                _local_4 = -2;
                _local_5 = (_local_5 - _local_2);
                si32(_local_5, _local_3);
                si32(_local_10, (_local_7 + 8));
                si32(_local_6, _local_1);
                mstate.eax = _local_4;
            } while (true);
            if (!(_local_6 >= _local_10))
            {
                
            _label_8: 
                _local_1 = 86;
                goto _label_1;
            };
            if (!(_local_4 == 0))
            {
                _local_1 = 0;
                si32(_local_6, _local_4);
            }
            else
            {
                _local_1 = 0;
            };
            si32(_local_1, _local_3);
            _local_1 = ((_local_6 == 0) ? 0 : _local_5);
            //unresolved jump
            
        _label_9: 
            goto _label_5;
        }


    }
}

