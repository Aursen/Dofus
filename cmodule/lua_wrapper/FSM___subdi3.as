package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___subdi3 extends Machine 
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
            _local_2 = li32(mstate.ebp + 16);
            _local_2 = (_local_1 - _local_2);
            _local_1 = ((uint(_local_2) > uint(_local_1)) ? 1 : 0);
            _local_3 = li32(mstate.ebp + 12);
            _local_4 = li32(mstate.ebp + 20);
            _local_3 = __subc(_local_3, _local_4);
            _local_1 = (_local_1 & 0x01);
            _local_1 = __subc(_local_3, _local_1);
            mstate.edx = _local_1;
            mstate.eax = _local_2;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

