package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___ashrdi3 extends Machine 
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
            _local_1 = li32(mstate.ebp + 16);
            _local_2 = li32(mstate.ebp + 20);
            _local_3 = li32(mstate.ebp + 8);
            _local_4 = li32(mstate.ebp + 12);
            _local_5 = ((uint(_local_1) < uint(32)) ? 1 : 0);
            _local_6 = ((_local_2 == 0) ? 1 : 0);
            _local_5 = ((_local_6 != 0) ? _local_5 : 0);
            if (!(!(_local_5 == 0)))
            {
                _local_3 = 0;
                _local_5 = (_local_4 >> 31);
                _local_6 = ((_local_2 != 0) ? 1 : 0);
                _local_7 = ((uint(_local_1) > uint(63)) ? 1 : 0);
                _local_2 = ((_local_2 == 0) ? 1 : 0);
                _local_8 = _local_3;
                _local_9 = _local_5;
                _local_2 = ((_local_2 != 0) ? _local_7 : _local_6);
                if (!(!(_local_2 == 0)))
                {
                    _local_3 = (_local_1 + -32);
                    _local_3 = (_local_4 >> _local_3);
                    _local_3 = (_local_3 | _local_8);
                    mstate.edx = _local_5;
                    goto _label_1;
                };
                _local_1 = (_local_5 | _local_3);
                _local_2 = (_local_8 | _local_9);
                mstate.edx = _local_1;
                mstate.eax = _local_2;
                goto _label_2;
            };
            _local_2 = (_local_1 | _local_2);
            if (!(_local_2 == 0))
            {
                _local_2 = (32 - _local_1);
                _local_2 = (_local_4 << _local_2);
                _local_3 = (_local_3 >>> _local_1);
                _local_4 = (_local_4 >> _local_1);
                _local_3 = (_local_2 | _local_3);
            };
            mstate.edx = _local_4;
            
        _label_1: 
            mstate.eax = _local_3;
            
        _label_2: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

