package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaT_gettmbyobj extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(_local_1 + 8);
            _local_3 = li32(mstate.ebp + 8);
            _local_4 = li32(mstate.ebp + 16);
            if (!(_local_2 == 7))
            {
                if (!(_local_2 == 5)) goto _label_1;
                _local_1 = li32(_local_1);
                _local_1 = li32(_local_1 + 8);
                if (_local_1 == 0) goto _label_3;
                goto _label_2;
            };
            _local_1 = li32(_local_1);
            _local_1 = li32(_local_1 + 8);
            if (!(_local_1 == 0))
            {
                goto _label_2;
                
            _label_1: 
                _local_1 = li32(_local_3 + 16);
                _local_2 = (_local_2 << 2);
                _local_1 = (_local_1 + _local_2);
                _local_1 = li32(_local_1 + 132);
                if (!(_local_1 == 0))
                {
                    
                _label_2: 
                    _local_2 = 1;
                    _local_3 = li32(_local_3 + 16);
                    _local_4 = (_local_4 << 2);
                    _local_5 = li8(_local_1 + 7);
                    _local_3 = (_local_3 + _local_4);
                    _local_2 = (_local_2 << _local_5);
                    _local_3 = li32(_local_3 + 168);
                    _local_4 = li32(_local_3 + 8);
                    _local_2 = (_local_2 + -1);
                    _local_2 = (_local_2 & _local_4);
                    _local_1 = li32(_local_1 + 16);
                    _local_2 = (_local_2 * 28);
                    _local_1 = (_local_1 + _local_2);
                    do 
                    {
                        _local_2 = li32(_local_1 + 20);
                        if ((!(_local_2 == 4))) continue;
                        _local_2 = li32(_local_1 + 12);
                        if ((!(_local_2 == _local_3))) continue;
                    } while ((mstate.eax = _local_1), (mstate.esp = mstate.ebp), (mstate.ebp = li32(mstate.esp)), (mstate.esp = (mstate.esp + 4)), (mstate.esp = (mstate.esp + 4)), return, (_local_1 = li32(_local_1 + 24)), !(_local_1 == 0));
                };
            };
            
        _label_3: 
            _local_1 = _luaO_nilobject_;
            //unresolved jump
        }


    }
} cmodule.lua_wrapper

