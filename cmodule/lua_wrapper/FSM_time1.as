package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_time1 extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 2064);
            _local_1 = (mstate.ebp + -2064);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(_local_2 + 32);
            _local_4 = (_local_2 + 32);
            _local_5 = (mstate.ebp + -1040);
            if (!(_local_3 < 2))
            {
                _local_3 = 1;
                si32(_local_3, _local_4);
            };
            _local_3 = 0;
            mstate.esp = (mstate.esp - 12);
            _local_6 = (mstate.ebp + -4);
            si32(_local_2, mstate.esp);
            si32(_local_6, (mstate.esp + 4));
            si32(_local_3, (mstate.esp + 8));
            mstate.esp = (mstate.esp - 4);
            FSM_time2sub.start();
            _local_3 = mstate.eax;
            mstate.esp = (mstate.esp + 12);
            _local_6 = li32(mstate.ebp + -4);
            if ((_local_6 == 0))
            {
                _local_3 = 1;
                mstate.esp = (mstate.esp - 12);
                _local_6 = (mstate.ebp + -4);
                si32(_local_2, mstate.esp);
                si32(_local_6, (mstate.esp + 4));
                si32(_local_3, (mstate.esp + 8));
                mstate.esp = (mstate.esp - 4);
                FSM_time2sub.start();
                _local_3 = mstate.eax;
                mstate.esp = (mstate.esp + 12);
            };
            _local_6 = li32(mstate.ebp + -4);
            if (!(_local_6 == 0))
            {
                _local_1 = _local_3;
            }
            else
            {
                _local_3 = li32(_local_4);
                if (!(_local_3 > -1))
                {
                    _local_3 = 0;
                    si32(_local_3, _local_4);
                    _local_3 = li32(_lclmem + 8);
                    if (!(_local_3 > 0))
                    {
                        _local_1 = 0;
                        goto _label_2;
                    };
                    _local_6 = 0;
                }
                else
                {
                    _local_7 = li32(_lclmem + 8);
                    if (!(_local_7 > 0))
                    {
                        _local_1 = _local_3;
                        goto _label_2;
                    };
                    _local_6 = _local_3;
                    _local_3 = _local_7;
                };
                _local_7 = 0;
                
            _label_1: 
                _local_8 = 0;
                si32(_local_8, _local_1);
                _local_1 = (_local_1 + 4);
                _local_7 = (_local_7 + 1);
                if (_local_3 > _local_7) goto _label_7;
                _local_1 = _local_6;
                
            _label_2: 
                _local_3 = li32(_lclmem + 4);
                _local_3 = (_local_3 + -1);
                if (!(_local_3 > -1))
                {
                    _local_3 = 0;
                    
                _label_3: 
                    _local_9 = _local_3;
                    _local_6 = 0;
                    _local_8 = _local_2;
                    _local_3 = _local_5;
                    goto _label_5;
                };
                _local_6 = 0;
                _local_7 = _local_5;
                do 
                {
                    _local_8 = _lclmem;
                    _local_9 = _local_7;
                    
                _label_4: 
                    _local_10 = (mstate.ebp + -2064);
                    _local_11 = (_local_8 + _local_3);
                    _local_11 = li8(_local_11 + 1496);
                    _local_12 = (_local_11 << 2);
                    _local_10 = (_local_10 + _local_12);
                    _local_12 = li32(_local_10);
                    if ((!(_local_12 == 0))) break;
                    _local_8 = 1;
                    si32(_local_8, _local_10);
                    si32(_local_11, _local_9);
                    _local_7 = (_local_7 + 4);
                    _local_6 = (_local_6 + 1);
                    _local_3 = (_local_3 + -1);
                    if (!(_local_3 > -1))
                    {
                        _local_3 = _local_6;
                        goto _label_3;
                    };
                } while (true);
                _local_3 = (_local_3 + -1);
                if (!(_local_3 > -1))
                {
                    _local_3 = _local_6;
                    goto _label_3;
                };
                goto _label_4;
                do 
                {
                    _local_10 = _lclmem;
                    _local_1 = li32(_local_1);
                    _local_11 = (_local_1 * 20);
                    _local_10 = (_local_10 + _local_11);
                    _local_10 = li32(_local_10 + 1872);
                    if (!(_local_10 == _local_3))
                    {
                        _local_1 = _local_3;
                    }
                    else
                    {
                        _local_10 = _lclmem;
                        _local_1 = (_local_1 * 20);
                        _local_1 = (_local_10 + _local_1);
                        _local_1 = (_local_1 + 1868);
                        _local_10 = 0;
                        _local_11 = _local_5;
                        while ((_local_10 = _local_3), (_local_3 = (_local_12 = _local_11)), ((_local_11 = _local_10) < _local_9))
                        {
                            _local_13 = _lclmem;
                            _local_3 = li32(_local_3);
                            _local_14 = (_local_3 * 20);
                            _local_13 = (_local_13 + _local_14);
                            _local_13 = li32(_local_13 + 1872);
                            if (!(!(_local_13 == _local_10)))
                            {
                                _local_3 = _local_10;
                            }
                            else
                            {
                                _local_13 = _lclmem;
                                _local_3 = (_local_3 * 20);
                                _local_3 = (_local_13 + _local_3);
                                _local_13 = li32(_local_8);
                                _local_14 = li32(_local_3 + 1868);
                                _local_15 = li32(_local_1);
                                _local_13 = (_local_14 + _local_13);
                                _local_10 = ((_local_10 == 0) ? 1 : 0);
                                _local_13 = (_local_13 - _local_15);
                                si32(_local_13, _local_8);
                                _local_10 = (_local_10 & 0x01);
                                si32(_local_10, _local_4);
                                mstate.esp = (mstate.esp - 12);
                                _local_10 = (mstate.ebp + -4);
                                _local_13 = 0;
                                si32(_local_2, mstate.esp);
                                si32(_local_10, (mstate.esp + 4));
                                si32(_local_13, (mstate.esp + 8));
                                mstate.esp = (mstate.esp - 4);
                                FSM_time2sub.start();
                                _local_10 = mstate.eax;
                                mstate.esp = (mstate.esp + 12);
                                _local_13 = li32(mstate.ebp + -4);
                                _local_3 = (_local_3 + 1868);
                                if ((_local_13 == 0))
                                {
                                    _local_10 = 1;
                                    mstate.esp = (mstate.esp - 12);
                                    _local_13 = (mstate.ebp + -4);
                                    si32(_local_2, mstate.esp);
                                    si32(_local_13, (mstate.esp + 4));
                                    si32(_local_10, (mstate.esp + 8));
                                    mstate.esp = (mstate.esp - 4);
                                    FSM_time2sub.start();
                                    _local_10 = mstate.eax;
                                    mstate.esp = (mstate.esp + 12);
                                };
                                _local_13 = li32(mstate.ebp + -4);
                                if (!(_local_13 == 0))
                                {
                                    _local_1 = _local_10;
                                    goto _label_6;
                                };
                                _local_10 = li32(_local_8);
                                _local_3 = li32(_local_3);
                                _local_13 = li32(_local_1);
                                _local_3 = (_local_10 - _local_3);
                                _local_3 = (_local_3 + _local_13);
                                si32(_local_3, _local_8);
                                _local_3 = li32(_local_4);
                                _local_3 = ((_local_3 == 0) ? 1 : 0);
                                _local_3 = (_local_3 & 0x01);
                                si32(_local_3, _local_4);
                            };
                            _local_10 = (_local_12 + 4);
                            _local_12 = (_local_11 + 1);
                            _local_11 = _local_10;
                            _local_10 = _local_12;
                        };
                        _local_1 = _local_10;
                    };
                    _local_3 = (_local_7 + 4);
                    _local_6 = (_local_6 + 1);
                    
                _label_5: 
                    _local_7 = _local_3;
                    _local_3 = _local_1;
                    _local_1 = _local_7;
                } while ((_local_6 < _local_9));
                _local_1 = -1;
            };
            
        _label_6: 
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_7: 
            goto _label_1;
        }


    }
}

