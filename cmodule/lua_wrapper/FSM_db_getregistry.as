package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_db_getregistry extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = -10000;
            mstate.esp = (mstate.esp - 8);
            _local_2 = li32(mstate.ebp + 8);
            si32(_local_2, mstate.esp);
            si32(_local_1, (mstate.esp + 4));
            mstate.esp = (mstate.esp - 4);
            FSM_index2adr.start();
            _local_1 = mstate.eax;
            mstate.esp = (mstate.esp + 8);
            _local_3 = li32(_local_2 + 8);
            _local_4 = lf64(_local_1);
            sf64(_local_4, _local_3);
            _local_1 = li32(_local_1 + 8);
            si32(_local_1, (_local_3 + 8));
            _local_1 = li32(_local_2 + 8);
            _local_1 = (_local_1 + 12);
            si32(_local_1, (_local_2 + 8));
            _local_1 = 1;
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

