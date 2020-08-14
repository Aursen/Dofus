package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___divdi3 extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = 0;
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 20);
            _local_4 = li32(mstate.ebp + 8);
            _local_5 = (_local_2 >> 31);
            _local_6 = li32(mstate.ebp + 16);
            _local_7 = (_local_3 >> 31);
            _local_4 = __addc(_local_4, _local_5);
            _local_8 = __adde(_local_2, _local_5);
            _local_6 = __addc(_local_6, _local_7);
            _local_9 = __adde(_local_3, _local_7);
            mstate.esp = (mstate.esp - 20);
            _local_9 = (_local_9 ^ _local_7);
            _local_6 = (_local_6 ^ _local_7);
            _local_7 = (_local_8 ^ _local_5);
            _local_4 = (_local_4 ^ _local_5);
            si32(_local_4, mstate.esp);
            si32(_local_7, (mstate.esp + 4));
            si32(_local_6, (mstate.esp + 8));
            si32(_local_9, (mstate.esp + 12));
            si32(_local_1, (mstate.esp + 16));
            mstate.esp = (mstate.esp - 4);
            FSM___qdivrem.start();
            _local_1 = mstate.eax;
            _local_4 = mstate.edx;
            mstate.esp = (mstate.esp + 20);
            _local_2 = (_local_2 >>> 31);
            _local_3 = (_local_3 >>> 31);
            if (!(_local_2 == _local_3))
            {
                _local_2 = 0;
                _local_1 = __subc(_local_2, _local_1);
                _local_4 = __sube(_local_2, _local_4);
            };
            mstate.edx = _local_4;
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

