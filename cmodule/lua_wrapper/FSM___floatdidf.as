package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___floatdidf extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Number;
            var _local_6:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = (_local_1 >> 31);
            _local_2 = __addc(_local_2, _local_3);
            _local_4 = __adde(_local_1, _local_3);
            _local_4 = (_local_4 ^ _local_3);
            _local_2 = (_local_2 ^ _local_3);
            _local_5 = Number(uint(_local_4));
            _local_6 = Number(uint(_local_2));
            _local_5 = (_local_5 * 4294970000);
            _local_5 = (_local_6 + _local_5);
            if (!(_local_1 > -1))
            {
                _local_5 = -(_local_5);
            };
            mstate.st0 = _local_5;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

