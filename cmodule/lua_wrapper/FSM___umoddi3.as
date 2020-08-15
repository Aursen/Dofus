package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___umoddi3 extends Machine 
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
            mstate.esp = (mstate.esp - 8);
            _local_1 = (mstate.ebp + -8);
            mstate.esp = (mstate.esp - 20);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(mstate.ebp + 12);
            _local_4 = li32(mstate.ebp + 16);
            _local_5 = li32(mstate.ebp + 20);
            si32(_local_2, mstate.esp);
            si32(_local_3, (mstate.esp + 4));
            si32(_local_4, (mstate.esp + 8));
            si32(_local_5, (mstate.esp + 12));
            si32(_local_1, (mstate.esp + 16));
            mstate.esp = (mstate.esp - 4);
            FSM___qdivrem.start();
            _local_1 = mstate.eax;
            _local_1 = mstate.edx;
            mstate.esp = (mstate.esp + 20);
            _local_1 = li32(mstate.ebp + -8);
            _local_2 = li32(mstate.ebp + -4);
            mstate.edx = _local_2;
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

