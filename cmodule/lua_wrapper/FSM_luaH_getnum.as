package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaH_getnum extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Number;
            var _local_7:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 8);
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(_local_2 + 28);
            _local_4 = (_local_1 + -1);
            if (!(uint(_local_4) >= uint(_local_3)))
            {
                _local_1 = li32(_local_2 + 12);
                _local_2 = (_local_4 * 12);
                _local_1 = (_local_1 + _local_2);
            }
            else
            {
                _local_6 = 0;
                _local_7 = Number(_local_1);
                sf64(_local_7, (mstate.ebp + -8));
                _local_1 = li32(mstate.ebp + -8);
                _local_3 = li32(mstate.ebp + -4);
                if (!(!(_local_7 == _local_6)))
                {
                    _local_1 = li32(_local_2 + 16);
                }
                else
                {
                    _local_4 = 1;
                    _local_5 = li8(_local_2 + 7);
                    _local_4 = (_local_4 << _local_5);
                    _local_4 = (_local_4 + -1);
                    _local_4 = (_local_4 | 0x01);
                    _local_1 = (_local_3 + _local_1);
                    _local_1 = (uint(_local_1) % uint(_local_4));
                    _local_2 = li32(_local_2 + 16);
                    _local_1 = (_local_1 * 28);
                    _local_1 = (_local_2 + _local_1);
                };
                
            _label_1: 
                _local_2 = li32(_local_1 + 20);
                if (!(_local_2 == 3)) goto _label_3;
                _local_6 = lf64(_local_1 + 12);
                if (!(_local_6 == _local_7)) goto _label_3;
            };
            
        _label_2: 
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_3: 
            _local_1 = li32(_local_1 + 24);
            if (!(_local_1 == 0)) goto _label_1;
            _local_1 = _luaO_nilobject_;
            goto _label_2;
        }


    }
} cmodule.lua_wrapper

