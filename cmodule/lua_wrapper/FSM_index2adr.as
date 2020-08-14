package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_index2adr extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            if (!(_local_2 < 1))
            {
                _local_3 = _luaO_nilobject_;
                _local_4 = li32(_local_1 + 12);
                _local_2 = (_local_2 * 12);
                _local_2 = (_local_2 + _local_4);
                _local_1 = li32(_local_1 + 8);
                _local_2 = (_local_2 + -12);
                _local_1 = ((uint(_local_1) > uint(_local_2)) ? _local_2 : _local_3);
            }
            else
            {
                if (!(_local_2 < -9999))
                {
                    _local_1 = li32(_local_1 + 8);
                    _local_2 = (_local_2 * 12);
                    _local_1 = (_local_1 + _local_2);
                }
                else
                {
                    if (!(_local_2 == -10002))
                    {
                        if (!(_local_2 == -10001))
                        {
                            if (!(_local_2 == -10000)) goto _label_1;
                            _local_1 = li32(_local_1 + 16);
                            _local_1 = (_local_1 + 92);
                            goto _label_2;
                        };
                        _local_2 = 5;
                        _local_3 = li32(_local_1 + 20);
                        _local_3 = li32(_local_3 + 4);
                        _local_3 = li32(_local_3);
                        _local_3 = li32(_local_3 + 12);
                        si32(_local_3, (_local_1 + 84));
                        si32(_local_2, (_local_1 + 92));
                        _local_1 = (_local_1 + 84);
                        goto _label_2;
                    };
                    _local_1 = (_local_1 + 72);
                    goto _label_2;
                    
                _label_1: 
                    _local_1 = li32(_local_1 + 20);
                    _local_1 = li32(_local_1 + 4);
                    _local_1 = li32(_local_1);
                    _local_3 = li8(_local_1 + 7);
                    _local_2 = (-10002 - _local_2);
                    if (!(_local_3 < _local_2))
                    {
                        _local_2 = (_local_2 * 12);
                        _local_1 = (_local_2 + _local_1);
                        _local_1 = (_local_1 + 8);
                    }
                    else
                    {
                        _local_1 = _luaO_nilobject_;
                    };
                };
            };
            
        _label_2: 
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

