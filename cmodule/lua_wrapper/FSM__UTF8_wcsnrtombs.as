package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM__UTF8_wcsnrtombs extends Machine 
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
            mstate.esp = (mstate.esp - 16);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = li32(mstate.ebp + 20);
            _local_5 = li32(mstate.ebp + 24);
            _local_6 = li32(_local_5 + 4);
            if (!(_local_6 == 0))
            {
                _local_1 = 22;
                si32(_local_1, _val_2E_1440);
                _local_1 = -1;
            }
            else
            {
                _local_6 = li32(_local_2);
                if (!(_local_1 == 0))
                {
                    _local_7 = 0;
                    _local_8 = (mstate.ebp + -16);
                    _local_9 = _local_7;
                    _local_10 = _local_7;
                    
                _label_1: 
                    _local_12 = _local_4;
                    _local_11 = _local_7;
                    _local_7 = (_local_1 + _local_11);
                    _local_4 = _local_6;
                    if (!(_local_12 == 0))
                    {
                        if (!(_local_9 == _local_3)) goto _label_4;
                    };
                    
                _label_2: 
                    si32(_local_4, _local_2);
                    mstate.eax = _local_10;
                    goto _label_11;
                    
                _label_3: 
                    _local_4 = 0;
                    _local_2 = (_local_3 + -1);
                    _local_3 = -1;
                    _local_1 = (mstate.ebp + -16);
                    do 
                    {
                        _local_7 = li32(_local_6);
                        _local_8 = _local_6;
                        if (!(uint(_local_7) > uint(127)))
                        {
                            _local_7 = 1;
                        }
                        else
                        {
                            mstate.esp = (mstate.esp - 12);
                            si32(_local_1, mstate.esp);
                            si32(_local_7, (mstate.esp + 4));
                            si32(_local_5, (mstate.esp + 8));
                            mstate.esp = (mstate.esp - 4);
                            FSM__UTF8_wcrtomb.start();
                            _local_7 = mstate.eax;
                            mstate.esp = (mstate.esp + 12);
                            if (_local_7 == -1) goto _label_9;
                        };
                        _local_8 = li32(_local_8);
                        if ((!(_local_8 == 0))) continue;
                        _local_6 = (_local_4 + _local_7);
                        _local_6 = (_local_6 + -1);
                    } while ((mstate.eax = _local_6), goto _label_11, (_local_6 = (_local_6 + 4)), (_local_3 = (_local_3 + 1)), (_local_4 = (_local_7 + _local_4)), !(_local_2 == _local_3));
                    _local_6 = _local_4;
                    goto _label_10;
                };
                if (!(_local_3 == 0)) goto _label_3;
                _local_6 = 0;
                goto _label_10;
                
            _label_4: 
                _local_13 = li32(_local_4);
                if (!(uint(_local_13) > uint(127)))
                {
                    si8(_local_13, _local_7);
                    _local_4 = li32(_local_4);
                    if (!(_local_4 == 0))
                    {
                        _local_4 = 1;
                        
                    _label_5: 
                        _local_6 = (_local_6 + 4);
                        _local_7 = (_local_9 + 1);
                        _local_10 = (_local_4 + _local_10);
                        _local_12 = (_local_12 - _local_4);
                        _local_11 = (_local_11 + _local_4);
                        _local_9 = _local_7;
                        _local_4 = _local_12;
                        _local_7 = _local_11;
                        goto _label_1;
                    };
                    _local_4 = 1;
                    goto _label_8;
                };
                _local_14 = li32(___mb_cur_max);
                if (!(uint(_local_14) >= uint(_local_12)))
                {
                    mstate.esp = (mstate.esp - 12);
                    si32(_local_7, mstate.esp);
                    si32(_local_13, (mstate.esp + 4));
                    si32(_local_5, (mstate.esp + 8));
                    mstate.esp = (mstate.esp - 4);
                    FSM__UTF8_wcrtomb.start();
                    _local_7 = mstate.eax;
                    mstate.esp = (mstate.esp + 12);
                    if (_local_7 == -1) goto _label_6;
                    goto _label_7;
                };
                mstate.esp = (mstate.esp - 12);
                si32(_local_8, mstate.esp);
                si32(_local_13, (mstate.esp + 4));
                si32(_local_5, (mstate.esp + 8));
                mstate.esp = (mstate.esp - 4);
                FSM__UTF8_wcrtomb.start();
                _local_13 = mstate.eax;
                mstate.esp = (mstate.esp + 12);
                if (!(!(_local_13 == -1)))
                {
                    
                _label_6: 
                    _local_6 = -1;
                    si32(_local_4, _local_2);
                    //unresolved jump
                };
                if (uint(_local_13) > uint(_local_12)) goto _label_2;
                _local_14 = _local_8;
                _local_15 = _local_13;
                memcpy(_local_7, _local_14, _local_15);
                _local_7 = _local_13;
                
            _label_7: 
                _local_4 = li32(_local_4);
                if (!(_local_4 == 0))
                {
                    _local_4 = _local_7;
                    goto _label_5;
                };
                _local_4 = _local_7;
                
            _label_8: 
                _local_6 = 0;
                _local_4 = (_local_10 + _local_4);
                si32(_local_6, _local_2);
                _local_4 = (_local_4 + -1);
                mstate.eax = _local_4;
                goto _label_11;
                
            _label_9: 
                _local_6 = -1;
                
            _label_10: 
                _local_1 = _local_6;
            };
            mstate.eax = _local_1;
            
        _label_11: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

