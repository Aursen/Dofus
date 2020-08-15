package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___hexdig_init_D2A extends Machine 
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
            _local_1 = __2E_str2661;
            _local_2 = 48;
            _local_1 = (_local_1 + 1);
            _local_3 = 16;
            do 
            {
                _local_4 = ___hexdig_D2A;
                _local_2 = (_local_2 & 0xFF);
                _local_2 = (_local_4 + _local_2);
                si8(_local_3, _local_2);
                _local_2 = li8(_local_1);
                _local_3 = (_local_3 + 1);
                _local_1 = (_local_1 + 1);
            } while (!(_local_2 == 0));
            _local_1 = __2E_str127;
            _local_2 = 97;
            _local_1 = (_local_1 + 1);
            _local_3 = 26;
            do 
            {
                _local_4 = ___hexdig_D2A;
                _local_2 = (_local_2 & 0xFF);
                _local_2 = (_local_4 + _local_2);
                si8(_local_3, _local_2);
                _local_2 = li8(_local_1);
                _local_3 = (_local_3 + 1);
                _local_1 = (_local_1 + 1);
            } while (!(_local_2 == 0));
            _local_1 = __2E_str228;
            _local_2 = 65;
            _local_1 = (_local_1 + 1);
            _local_3 = 26;
            do 
            {
                _local_4 = ___hexdig_D2A;
                _local_2 = (_local_2 & 0xFF);
                _local_2 = (_local_4 + _local_2);
                si8(_local_3, _local_2);
                _local_2 = li8(_local_1);
                _local_3 = (_local_3 + 1);
                _local_1 = (_local_1 + 1);
            } while (!(_local_2 == 0));
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

