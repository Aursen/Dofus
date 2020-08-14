package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaO_int2fb extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            if (!(uint(_local_1) > uint(15)))
            {
                _local_2 = 8;
            }
            else
            {
                _local_2 = -1;
                do 
                {
                    _local_1 = (_local_1 + 1);
                    _local_2 = (_local_2 + 1);
                    _local_1 = (_local_1 >>> 1);
                } while (!(uint(_local_1) < uint(16)));
                _local_2 = (_local_2 << 3);
                _local_2 = (_local_2 + 16);
            };
            if (!(uint(_local_1) < uint(8)))
            {
                _local_1 = (_local_1 + -8);
                _local_1 = (_local_2 | _local_1);
            };
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

