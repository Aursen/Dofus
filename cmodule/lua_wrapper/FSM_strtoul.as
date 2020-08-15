package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_strtoul extends Machine 
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
            _local_1 = 0;
            _local_2 = li32(__CurrentRuneLocale);
            _local_3 = li32(mstate.ebp + 8);
            _local_4 = li32(mstate.ebp + 12);
            _local_5 = li32(mstate.ebp + 16);
            _local_6 = _local_3;
            do 
            {
                _local_7 = (_local_6 + _local_1);
                _local_7 = li8(_local_7);
                _local_8 = (_local_7 << 2);
                _local_8 = (_local_2 + _local_8);
                _local_8 = li32(_local_8 + 52);
                _local_1 = (_local_1 + 1);
                _local_8 = (_local_8 & 0x4000);
            } while (!(_local_8 == 0));
            _local_2 = (_local_3 + _local_1);
            _local_6 = (_local_7 & 0xFF);
            if (!(_local_6 == 43))
            {
                _local_6 = (_local_7 & 0xFF);
                if (!(_local_6 == 45))
                {
                    _local_1 = _local_7;
                    goto _label_1;
                };
                _local_1 = (_local_1 << 0);
                _local_1 = (_local_1 + _local_3);
                _local_2 = li8(_local_2);
                _local_1 = (_local_1 + 1);
                if( ((_local_5 == 0)) || (!(!(_local_5 == 16))) )
                {
                    _local_6 = 1;
                    goto _label_2;
                };
                _local_6 = 1;
                goto _label_4;
            };
            _local_1 = (_local_1 << 0);
            _local_1 = (_local_1 + _local_3);
            _local_2 = li8(_local_2);
            _local_6 = (_local_1 + 1);
            _local_1 = _local_2;
            _local_2 = _local_6;
            
        _label_1: 
            _local_7 = _local_2;
            if( ((_local_5 == 0)) || (!(!(_local_5 == 16))) )
            {
                _local_6 = 0;
                _local_2 = _local_1;
                _local_1 = _local_7;
                
            _label_2: 
                _local_7 = (_local_2 & 0xFF);
                if (!(_local_7 == 48))
                {
                    
                _label_3: 
                    goto _label_4;
                };
                _local_7 = li8(_local_1);
                if (!(_local_7 == 88))
                {
                    _local_7 = (_local_7 & 0xFF);
                    if (!(_local_7 == 120)) goto _label_3;
                };
                _local_7 = li8(_local_1 + 1);
                _local_8 = (_local_7 + -48);
                _local_8 = (_local_8 & 0xFF);
                if (!(uint(_local_8) < uint(10)))
                {
                    _local_8 = (_local_7 + -65);
                    _local_8 = (_local_8 & 0xFF);
                    if (!(uint(_local_8) < uint(6)))
                    {
                        _local_8 = (_local_7 + -97);
                        _local_8 = (_local_8 & 0xFF);
                        if (uint(_local_8) > uint(5)) goto _label_3;
                    };
                };
                _local_5 = 16;
                _local_1 = (_local_1 + 2);
                _local_2 = _local_7;
                
            _label_4: 
                if ((_local_5 == 0))
                {
                    _local_5 = (_local_2 & 0xFF);
                    if (!(!(_local_5 == 48)))
                    {
                        _local_5 = 8;
                    }
                    else
                    {
                        _local_5 = 10;
                    };
                };
                _local_7 = (_local_5 + -2);
                if (!(uint(_local_7) < uint(35)))
                {
                    _local_2 = 0;
                    _local_5 = _local_2;
                }
                else
                {
                    _local_7 = 0;
                    _local_8 = (uint(-1) % uint(_local_5));
                    _local_9 = int((uint(-1) / uint(_local_5)));
                    _local_10 = _local_7;
                    do 
                    {
                        _local_11 = (_local_2 + -48);
                        _local_11 = (_local_11 & 0xFF);
                        if (!(uint(_local_11) < uint(10)))
                        {
                            
                        _label_5: 
                            _local_11 = (_local_2 + -65);
                            _local_11 = (_local_11 & 0xFF);
                            if (uint(_local_11) > uint(25)) goto _label_10;
                            _local_2 = (_local_2 + -55);
                            _local_11 = (_local_2 << 24);
                            _local_11 = (_local_11 >> 24);
                            if (_local_11 < _local_5) goto _label_9;
                            
                        _label_6: 
                            _local_2 = _local_10;
                            goto _label_8;
                            
                        _label_7: 
                            _local_11 = 1;
                            _local_2 = _local_10;
                            _local_10 = _local_11;
                        };
                        _local_2 = (_local_2 + -48);
                        _local_11 = (_local_2 << 24);
                        _local_11 = (_local_11 >> 24);
                        if (!(_local_11 < _local_5))
                        {
                            _local_2 = _local_10;
                            
                        _label_8: 
                            if ((_local_2 > -1)) break;
                            _local_5 = 34;
                            si32(_local_5, _val_2E_1440);
                            if (_local_4 == 0) goto _label_15;
                            _local_5 = -1;
                            goto _label_14;
                        };
                        goto _label_11;
                        
                    _label_9: 
                        goto _label_11;
                        
                    _label_10: 
                        _local_11 = (_local_2 + -97);
                        _local_11 = (_local_11 & 0xFF);
                        if (uint(_local_11) > uint(25)) goto _label_6;
                        _local_2 = (_local_2 + -87);
                        _local_11 = (_local_2 << 24);
                        _local_11 = (_local_11 >> 24);
                        if (_local_11 >= _local_5) goto _label_6;
                        
                    _label_11: 
                        if (!(uint(_local_7) > uint(_local_9)))
                        {
                            if (!(_local_10 < 0))
                            {
                                if (!(!(_local_7 == _local_9)))
                                {
                                    _local_10 = (_local_2 << 24);
                                    _local_10 = (_local_10 >> 24);
                                    if (_local_10 > _local_8) goto _label_12;
                                };
                                _local_2 = (_local_2 << 24);
                                _local_2 = (_local_2 >> 24);
                                _local_7 = (_local_7 * _local_5);
                                _local_10 = li8(_local_1);
                                _local_1 = (_local_1 + 1);
                                _local_7 = (_local_7 + _local_2);
                                _local_2 = (_local_10 + -48);
                                _local_2 = (_local_2 & 0xFF);
                                if (uint(_local_2) < uint(10)) goto _label_7;
                                _local_11 = 1;
                                _local_2 = _local_10;
                                _local_10 = _local_11;
                                goto _label_5;
                            };
                        };
                        
                    _label_12: 
                        _local_10 = -1;
                        _local_2 = li8(_local_1);
                        _local_1 = (_local_1 + 1);
                    } while (true);
                    if (!(_local_2 == 0)) goto _label_13;
                    _local_5 = _local_2;
                    _local_2 = _local_7;
                };
                _local_6 = _local_2;
                _local_2 = 22;
                si32(_local_2, _val_2E_1440);
                if (!(_local_4 == 0))
                {
                    _local_2 = _local_5;
                    _local_5 = _local_6;
                }
                else
                {
                    _local_1 = _local_6;
                    goto _label_16;
                    
                _label_13: 
                    _local_5 = (_local_6 & 0x01);
                    _local_6 = (0 - _local_7);
                    _local_5 = ((_local_5 != 0) ? _local_6 : _local_7);
                    if (_local_4 == 0) goto _label_18;
                };
                
            _label_14: 
                if (!(_local_2 == 0))
                {
                    _local_1 = (_local_1 + -1);
                    si32(_local_1, _local_4);
                }
                else
                {
                    si32(_local_3, _local_4);
                };
                mstate.eax = _local_5;
                goto _label_17;
                
            _label_15: 
                _local_1 = -1;
                
            _label_16: 
                mstate.eax = _local_1;
                
            _label_17: 
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
            };
            _local_2 = 0;
            _local_6 = _local_2;
            _local_2 = _local_1;
            _local_1 = _local_7;
            goto _label_4;
            
        _label_18: 
            _local_1 = _local_5;
            goto _label_16;
        }


    }
}

