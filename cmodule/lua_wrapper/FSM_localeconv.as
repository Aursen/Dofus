package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_localeconv extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li8(___mlocale_changed_2E_b);
            if (!(!(_local_1 == 0)))
            {
                _local_1 = 1;
                si8(_local_1, ___mlocale_changed_2E_b);
            };
            _local_1 = li8(___nlocale_changed_2E_b);
            if (!(!(_local_1 == 0)))
            {
                _local_1 = __C_numeric_locale;
                _local_2 = li32(__numeric_using_locale);
                _local_3 = __numeric_locale;
                _local_1 = ((_local_2 == 0) ? _local_1 : _local_3);
                _local_2 = li32(_local_1);
                si32(_local_2, _ret_2E_1494_2E_0);
                _local_2 = li32(_local_1 + 4);
                si32(_local_2, _ret_2E_1494_2E_1);
                _local_1 = li32(_local_1 + 8);
                si32(_local_1, _ret_2E_1494_2E_2);
                _local_1 = 1;
                si8(_local_1, ___nlocale_changed_2E_b);
            };
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

