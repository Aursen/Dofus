package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_aux_upvalue extends Machine 
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
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = li32(_local_1 + 8);
            if (!(!(_local_4 == 6)))
            {
                _local_1 = li32(_local_1);
                _local_4 = li8(_local_1 + 6);
                _local_5 = _local_1;
                if (!(_local_4 == 0))
                {
                    if (_local_2 < 1) goto _label_1;
                    _local_5 = li8(_local_1 + 7);
                    if (_local_5 < _local_2) goto _label_1;
                    _local_5 = __2E_str45;
                    _local_2 = (_local_2 * 12);
                    _local_2 = (_local_2 + _local_1);
                    _local_2 = (_local_2 + 8);
                    si32(_local_2, _local_3);
                    mstate.eax = _local_5;
                    goto _label_3;
                };
                _local_1 = li32(_local_5 + 16);
                _local_4 = _local_5;
                if (!(_local_2 < 1))
                {
                    _local_5 = li32(_local_1 + 36);
                    if (!(_local_5 < _local_2))
                    {
                        _local_2 = (_local_2 + -1);
                        _local_2 = (_local_2 << 2);
                        _local_4 = (_local_4 + _local_2);
                        _local_4 = li32(_local_4 + 20);
                        _local_4 = li32(_local_4 + 8);
                        si32(_local_4, _local_3);
                        _local_1 = li32(_local_1 + 28);
                        _local_1 = (_local_1 + _local_2);
                        _local_1 = li32(_local_1);
                        _local_1 = (_local_1 + 16);
                        goto _label_2;
                    };
                };
            };
            
        _label_1: 
            _local_1 = 0;
            
        _label_2: 
            mstate.eax = _local_1;
            
        _label_3: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

