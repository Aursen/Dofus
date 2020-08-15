package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___one_cmpldi2 extends Machine 
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
            _local_2 = li32(mstate.ebp + 12);
            _local_2 = (_local_2 ^ 0xFFFFFFFF);
            _local_1 = (_local_1 ^ 0xFFFFFFFF);
            mstate.edx = _local_2;
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

