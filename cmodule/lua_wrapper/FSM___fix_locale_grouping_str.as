package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___fix_locale_grouping_str extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            if (!(_local_1 == 0))
            {
                _local_2 = li8(_local_1);
                if (!(_local_2 == 0))
                {
                    _local_2 = _local_1;
                    _local_3 = _local_1;
                    for (;;(_local_8 = (_local_6 + _local_2)), (_local_8 = li8(_local_8)), (_local_9 = (_local_4 + _local_3)), if (!(_local_8 == 59))
                    {
                        _local_10 = (_local_8 & 0xFF);
                        if (!(!(_local_10 == 45)))
                        {
                            _local_10 = (_local_6 + _local_2);
                            _local_10 = li8(_local_10 + 1);
                            if (!(!(_local_10 == 49)))
                            {
                                _local_8 = 127;
                                si8(_local_8, _local_9);
                                _local_8 = (_local_6 + _local_2);
                                _local_8 = li8(_local_8 + 2);
                                _local_2 = (_local_2 + 2);
                                _local_3 = (_local_3 + 1);
                                if (_local_8 == 0) goto _label_2;
                                continue;
                            };
                        };
                        _local_4 = __DefaultRuneLocale;
                        _local_10 = (_local_8 & 0xFF);
                        _local_10 = (_local_10 << 2);
                        _local_4 = (_local_4 + _local_10);
                        _local_4 = li32(_local_4 + 52);
                        _local_4 = (_local_4 & 0x0400);
                        if (_local_4 == 0) goto _label_4;
                        _local_4 = __DefaultRuneLocale;
                        _local_10 = (_local_2 | 0x01);
                        _local_7 = (_local_7 + _local_10);
                        _local_10 = li8(_local_7);
                        _local_11 = (_local_10 << 2);
                        _local_4 = (_local_4 + _local_11);
                        _local_4 = li32(_local_4 + 52);
                        _local_8 = (_local_8 + -48);
                        _local_4 = (_local_4 & 0x0400);
                        if (!(!(_local_4 == 0)))
                        {
                            _local_2 = (_local_6 + _local_2);
                            _local_7 = _local_8;
                        }
                        else
                        {
                            _local_2 = (_local_8 * 10);
                            _local_2 = (_local_2 + _local_10);
                            _local_4 = (_local_2 + -48);
                            _local_2 = _local_7;
                            _local_7 = _local_4;
                        };
                        _local_4 = _local_7;
                        si8(_local_4, _local_9);
                        _local_4 = (_local_4 & 0xFF);
                        if (!(!(_local_4 == 0)))
                        {
                            _local_2 = _nogrouping;
                            _local_2 = ((_local_9 == _local_1) ? _local_2 : _local_1);
                            mstate.eax = _local_2;
                            goto _label_6;
                        };
                        _local_3 = (_local_3 + _local_5);
                        _local_3 = (_local_3 + 1);
                    }
                    else
                    {
                        _local_2 = (_local_6 + _local_2);
                        _local_3 = (_local_4 + _local_3);
                    }, (_local_2 = (_local_2 + 1)))
                    {
                    };
                    
                _label_1: 
                    _local_3 = _local_5;
                    goto _label_3;
                    
                _label_2: 
                    _local_3 = (_local_5 + _local_3);
                    
                _label_3: 
                    _local_2 = _local_3;
                    _local_3 = 0;
                    si8(_local_3, _local_2);
                    goto _label_5;
                };
            };
            
        _label_4: 
            _local_1 = _nogrouping;
            
        _label_5: 
            mstate.eax = _local_1;
            
        _label_6: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

