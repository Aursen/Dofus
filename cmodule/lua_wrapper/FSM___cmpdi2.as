package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___cmpdi2 extends Machine 
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
            _local_2 = li32(mstate.ebp + 20);
            _local_3 = li32(mstate.ebp + 8);
            _local_4 = li32(mstate.ebp + 16);
            _local_5 = _local_2;
            _local_5 = _local_1;
            if (!(_local_1 >= _local_2))
            {
                
            _label_1: 
                _local_1 = 0;
                goto _label_2;
            };
            if (!(_local_1 <= _local_2))
            {
                _local_1 = 2;
            }
            else
            {
                _local_1 = _local_4;
                _local_2 = _local_3;
                if (uint(_local_3) < uint(_local_4)) goto _label_1;
                _local_1 = ((uint(_local_2) > uint(_local_1)) ? 2 : 1);
            };
            
        _label_2: 
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

