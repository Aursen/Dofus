package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_currentline extends Machine 
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
            _local_2 = li32(_local_1 + 4);
            _local_3 = li32(_local_2 + 8);
            _local_4 = li32(mstate.ebp + 8);
            if (!(_local_3 == 6))
            {
                
            _label_1: 
                _local_1 = -1;
                goto _label_2;
            };
            _local_3 = li32(_local_2);
            _local_3 = li8(_local_3 + 6);
            _local_5 = _local_2;
            if (!(_local_3 == 0)) goto _label_1;
            _local_3 = li32(_local_4 + 20);
            if (!(!(_local_3 == _local_1)))
            {
                _local_3 = li32(_local_4 + 24);
                si32(_local_3, (_local_1 + 12));
            };
            _local_3 = li32(_local_5);
            _local_3 = li32(_local_3 + 16);
            _local_1 = li32(_local_1 + 12);
            _local_3 = li32(_local_3 + 12);
            _local_1 = (_local_1 - _local_3);
            _local_1 = (_local_1 >> 2);
            _local_1 = (_local_1 + -1);
            
        _label_2: 
            if (!(_local_1 > -1))
            {
                _local_1 = -1;
            }
            else
            {
                _local_2 = li32(_local_2);
                _local_2 = li32(_local_2 + 16);
                _local_2 = li32(_local_2 + 20);
                if (!(!(_local_2 == 0)))
                {
                    _local_1 = 0;
                }
                else
                {
                    _local_1 = (_local_1 << 2);
                    _local_1 = (_local_2 + _local_1);
                    _local_1 = li32(_local_1);
                };
            };
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

