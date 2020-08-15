package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaF_getlocalname388 extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = li32(mstate.ebp + 20);
            _local_5 = _local_1;
            if (!(_local_2 < 1))
            {
                _local_6 = 0;
                while ((_local_5 = _local_6), (_local_6 = li32((_local_7 = _local_5) + 4)), (_local_6 <= _local_4))
                {
                    _local_6 = li32(_local_7 + 8);
                    if ((_local_6 > _local_4))
                    {
                        _local_6 = (_local_3 + -1);
                        if (_local_3 == 1) goto _label_1;
                        _local_3 = _local_6;
                    };
                    _local_6 = (_local_7 + 12);
                    _local_7 = (_local_5 + 1);
                    if ((_local_7 >= _local_2)) break;
                    _local_5 = _local_6;
                    _local_6 = _local_7;
                };
            };
            _local_1 = 0;
            mstate.eax = _local_1;
            do 
            {
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
                
            _label_1: 
                _local_3 = (_local_5 * 12);
                _local_3 = (_local_1 + _local_3);
                _local_3 = li32(_local_3);
                _local_3 = (_local_3 + 16);
                mstate.eax = _local_3;
            } while (true);
        }


    }
}

