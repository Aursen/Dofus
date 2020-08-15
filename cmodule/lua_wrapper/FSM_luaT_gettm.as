package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaT_gettm extends Machine 
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
            _local_1 = 1;
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li8(_local_2 + 7);
            _local_1 = (_local_1 << _local_3);
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = li32(_local_3 + 8);
            _local_1 = (_local_1 + -1);
            _local_1 = (_local_1 & _local_4);
            _local_4 = li32(_local_2 + 16);
            _local_1 = (_local_1 * 28);
            _local_5 = li32(mstate.ebp + 12);
            _local_1 = (_local_4 + _local_1);
                
            outer_block:
            {

                do 
                {
                    _local_4 = li32(_local_1 + 20);
                    if (!(!(_local_4 == 4)))
                    {
                        _local_4 = li32(_local_1 + 12);
                        if (!(!(_local_4 == _local_3))) break outer_block;
                    };
                    _local_1 = li32(_local_1 + 24);
                } while (!(_local_1 == 0));
                _local_1 = _luaO_nilobject_;
            
            }//outer_block
            _local_3 = li32(_local_1 + 8);
            if (!(!(_local_3 == 0)))
            {
                _local_1 = 1;
                _local_3 = li8(_local_2 + 6);
                _local_1 = (_local_1 << _local_5);
                _local_1 = (_local_3 | _local_1);
                si8(_local_1, (_local_2 + 6));
                _local_1 = 0;
            };
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

