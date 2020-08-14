package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaC_separateudata extends Machine 
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
            _local_2 = li32(_local_1 + 16);
            _local_3 = li32(_local_2 + 104);
            _local_4 = li32(_local_3);
            _local_1 = (_local_1 + 16);
            _local_5 = li32(mstate.ebp + 12);
            if (!(!(_local_4 == 0)))
            {
                _local_1 = 0;
            }
            else
            {
                _local_6 = 0;
                _local_2 = (_local_2 + 48);
                do 
                {
                    _local_7 = li8(_local_4 + 5);
                    _local_7 = (_local_7 & 0x03);
                    _local_7 = (_local_7 | _local_5);
                    if (!(_local_7 == 0))
                    {
                        _local_7 = li8(_local_4 + 5);
                        _local_8 = (_local_4 + 5);
                        _local_9 = _local_4;
                        _local_7 = (_local_7 & 0x08);
                        if (_local_7 == 0) goto _label_1;
                    };
                    _local_3 = _local_4;
                    _local_4 = _local_6;
                    goto _label_3;
                    
                _label_1: 
                    _local_7 = li32(_local_9 + 8);
                    if (!(_local_7 == 0))
                    {
                        _local_10 = li8(_local_7 + 6);
                        _local_10 = (_local_10 & 0x04);
                        if (!(!(_local_10 == 0)))
                        {
                            _local_10 = 2;
                            _local_11 = li32(_local_1);
                            _local_11 = li32(_local_11 + 176);
                            mstate.esp = (mstate.esp - 12);
                            si32(_local_7, mstate.esp);
                            si32(_local_10, (mstate.esp + 4));
                            si32(_local_11, (mstate.esp + 8));
                            mstate.esp = (mstate.esp - 4);
                            FSM_luaT_gettm.start();
                            _local_7 = mstate.eax;
                            mstate.esp = (mstate.esp + 12);
                            if (!(_local_7 == 0)) goto _label_2;
                        };
                    };
                    _local_3 = li8(_local_8);
                    _local_3 = (_local_3 | 0x08);
                    si8(_local_3, _local_8);
                    _local_3 = _local_4;
                    _local_4 = _local_6;
                    goto _label_3;
                    
                _label_2: 
                    _local_7 = li8(_local_8);
                    _local_9 = li32(_local_9 + 16);
                    _local_7 = (_local_7 | 0x08);
                    si8(_local_7, _local_8);
                    _local_7 = li32(_local_4);
                    _local_6 = (_local_6 + _local_9);
                    si32(_local_7, _local_3);
                    _local_7 = li32(_local_2);
                    _local_6 = (_local_6 + 20);
                    _local_8 = _local_4;
                    if (!(!(_local_7 == 0)))
                    {
                        si32(_local_4, _local_8);
                        si32(_local_4, _local_2);
                        _local_4 = _local_6;
                    }
                    else
                    {
                        _local_7 = li32(_local_7);
                        si32(_local_7, _local_8);
                        _local_7 = li32(_local_2);
                        si32(_local_4, _local_7);
                        si32(_local_4, _local_2);
                        _local_4 = _local_6;
                    };
                    
                _label_3: 
                    _local_7 = li32(_local_3);
                    if ((_local_7 == 0)) break;
                    _local_6 = _local_4;
                    _local_4 = _local_7;
                } while (true);
                _local_1 = _local_4;
            };
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

