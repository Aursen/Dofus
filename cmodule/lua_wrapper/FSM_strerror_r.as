package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_strerror_r extends Machine 
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
            mstate.esp = (mstate.esp - 48);
            _local_1 = (mstate.ebp + -48);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(mstate.ebp + 12);
            _local_4 = li32(mstate.ebp + 16);
            _local_5 = _local_3;
            _local_6 = (_local_2 + -1);
            if (!(uint(_local_6) < uint(92)))
            {
                _local_6 = 0;
                _local_7 = (_local_2 >> 31);
                _local_8 = (_local_2 + _local_7);
                si8(_local_6, (mstate.ebp + -13));
                _local_6 = (_local_8 ^ _local_7);
                _local_7 = -1;
                do 
                {
                    _local_8 = __2E_str2661;
                    _local_9 = int((uint(_local_6) / uint(10)));
                    _local_10 = (_local_9 * 10);
                    _local_10 = (_local_6 - _local_10);
                    _local_8 = (_local_8 + _local_10);
                    _local_8 = li8(_local_8);
                    si8(_local_8, (_local_1 + 34));
                    _local_1 = (_local_1 + -1);
                    _local_7 = (_local_7 + 1);
                    if ((uint(_local_6) < uint(10))) break;
                    _local_6 = _local_9;
                } while (true);
                if (!(_local_2 < 0))
                {
                    _local_2 = (_local_1 + 35);
                }
                else
                {
                    _local_2 = (mstate.ebp + -48);
                    _local_1 = (33 - _local_7);
                    _local_6 = 45;
                    _local_2 = (_local_2 + _local_1);
                    si8(_local_6, _local_2);
                };
                _local_1 = 32;
                si8(_local_1, (_local_2 + -1));
                _local_1 = 58;
                si8(_local_1, (_local_2 + -2));
                mstate.esp = (mstate.esp - 12);
                _local_1 = __2E_str393;
                si32(_local_3, mstate.esp);
                si32(_local_1, (mstate.esp + 4));
                si32(_local_4, (mstate.esp + 8));
                mstate.esp = (mstate.esp - 4);
                FSM_strlcpy.start();
                _local_1 = mstate.eax;
                mstate.esp = (mstate.esp + 12);
                _local_1 = (_local_2 + -2);
                if (!(!(_local_4 == 0)))
                {
                    goto _label_3;
                    
                _label_1: 
                    _local_7 = (_local_3 + 1);
                    if (!(_local_6 == _local_3))
                    {
                        _local_3 = _local_7;
                        goto _label_2;
                    };
                    _local_3 = (_local_5 + _local_7);
                    goto _label_3;
                };
                _local_3 = 0;
                _local_6 = (_local_4 + -1);
                
            _label_2: 
                _local_7 = (_local_5 + _local_3);
                _local_7 = li8(_local_7);
                if (!(_local_7 == 0)) goto _label_1;
                _local_3 = (_local_5 + _local_3);
                
            _label_3: 
                _local_5 = (_local_3 - _local_5);
                _local_1 = li8(_local_1);
                _local_6 = (_local_4 - _local_5);
                if (!(_local_5 == _local_4))
                {
                    _local_1 = (_local_1 & 0xFF);
                    if (!(_local_1 == 0))
                    {
                        _local_1 = _local_6;
                        
                    _label_4: 
                        if (!(_local_1 == 1)) goto _label_5;
                        goto _label_6;
                    };
                    _local_2 = _local_3;
                    goto _label_7;
                };
                _local_3 = (_local_1 & 0xFF);
                if (!(_local_3 == 0))
                {
                    _local_2 = (_local_2 + -1);
                    do 
                    {
                        _local_3 = li8(_local_2);
                        _local_2 = (_local_2 + 1);
                        if (_local_3 == 0) goto _label_8;
                    } while (true);
                    
                _label_5: 
                    _local_4 = li8(_local_2 + -2);
                    si8(_local_4, _local_3);
                    _local_1 = (_local_1 + -1);
                    _local_3 = (_local_3 + 1);
                    
                _label_6: 
                    _local_4 = li8(_local_2 + -1);
                    _local_2 = (_local_2 + 1);
                    if (!(_local_4 == 0)) goto _label_4;
                    _local_2 = _local_3;
                    
                _label_7: 
                    _local_3 = 0;
                    si8(_local_3, _local_2);
                };
                
            _label_8: 
                _local_2 = 22;
                mstate.eax = _local_2;
                
            _label_9: 
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
            };
            _local_1 = _sys_errlist;
            _local_2 = (_local_2 << 2);
            _local_1 = (_local_1 + _local_2);
            _local_1 = li32(_local_1);
            mstate.esp = (mstate.esp - 12);
            si32(_local_3, mstate.esp);
            si32(_local_1, (mstate.esp + 4));
            si32(_local_4, (mstate.esp + 8));
            mstate.esp = (mstate.esp - 4);
            FSM_strlcpy.start();
            _local_1 = mstate.eax;
            mstate.esp = (mstate.esp + 12);
            _local_1 = ((uint(_local_1) < uint(_local_4)) ? 0 : 34);
            mstate.eax = _local_1;
            goto _label_9;
        }


    }
} cmodule.lua_wrapper

