package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM__UTF8_mbsinit extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            if (!(_local_1 == 0))
            {
                _local_1 = li32(_local_1 + 4);
                _local_1 = ((_local_1 == 0) ? 1 : 0);
                _local_1 = (_local_1 & 0x01);
            }
            else
            {
                _local_1 = 1;
            };
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

