package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_iscleared extends Machine 
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
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(_local_1 + 8);
            _local_3 = li32(mstate.ebp + 12);
            if (!(_local_2 > 3))
            {
                
            _label_1: 
                _local_1 = 0;
                goto _label_2;
            };
            _local_1 = li32(_local_1);
            if (!(!(_local_2 == 4)))
            {
                _local_2 = 0;
                _local_3 = li8(_local_1 + 5);
                _local_3 = (_local_3 & 0xFFFFFFFC);
                si8(_local_3, (_local_1 + 5));
                mstate.eax = _local_2;
            }
            else
            {
                _local_4 = li8(_local_1 + 5);
                _local_4 = (_local_4 & 0x03);
                if (!(_local_4 == 0))
                {
                    _local_1 = 1;
                }
                else
                {
                    if (!(_local_2 == 7)) goto _label_1;
                    if (!(_local_3 == 0)) goto _label_1;
                    _local_1 = li8(_local_1 + 5);
                    _local_1 = (_local_1 >>> 3);
                    _local_1 = (_local_1 & 0x01);
                };
                
            _label_2: 
                mstate.eax = _local_1;
            };
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

