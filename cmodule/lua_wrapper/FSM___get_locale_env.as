package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___get_locale_env extends Machine 
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
            _local_1 = __2E_str31162;
            mstate.esp = (mstate.esp - 4);
            si32(_local_1, mstate.esp);
            mstate.esp = (mstate.esp - 4);
            FSM_getenv.start();
            _local_1 = mstate.eax;
            mstate.esp = (mstate.esp + 4);
            _local_2 = li32(mstate.ebp + 8);
            if (!(_local_1 == 0))
            {
                _local_3 = li8(_local_1);
                if (!(_local_3 == 0))
                {
                    _local_2 = _local_1;
                    goto _label_1;
                };
            };
            _local_1 = _categories;
            _local_2 = (_local_2 << 2);
            _local_2 = (_local_1 + _local_2);
            _local_2 = li32(_local_2);
            mstate.esp = (mstate.esp - 4);
            si32(_local_2, mstate.esp);
            mstate.esp = (mstate.esp - 4);
            FSM_getenv.start();
            _local_2 = mstate.eax;
            mstate.esp = (mstate.esp + 4);
            
        _label_1: 
            _local_1 = _local_2;
            if (!(_local_1 == 0))
            {
                _local_2 = li8(_local_1);
                if (!(_local_2 == 0)) goto _label_2;
            };
            _local_1 = __2E_str738;
            mstate.esp = (mstate.esp - 4);
            si32(_local_1, mstate.esp);
            mstate.esp = (mstate.esp - 4);
            FSM_getenv.start();
            _local_1 = mstate.eax;
            mstate.esp = (mstate.esp + 4);
            
        _label_2: 
            if (!(_local_1 == 0))
            {
                _local_2 = __2E_str3149;
                _local_3 = li8(_local_1);
                _local_1 = ((_local_3 == 0) ? _local_2 : _local_1);
            }
            else
            {
                _local_1 = __2E_str3149;
            };
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

