package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_countint389 extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Number;
            var _local_6:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_5 = lf64(mstate.ebp + 8);
            _local_1 = li32(mstate.ebp + 20);
            _local_2 = li32(mstate.ebp + 16);
            if (!(_local_2 == 3))
            {
                _local_2 = -2;
            }
            else
            {
                _local_2 = int(_local_5);
                _local_3 = (_local_2 + -1);
                _local_6 = Number(_local_2);
                _local_2 = ((_local_6 == _local_5) ? _local_3 : -2);
            };
            if (!(uint(_local_2) > uint(0x3FFFFFF)))
            {
                if (!(uint(_local_2) > uint(0xFF)))
                {
                    _local_3 = -1;
                }
                else
                {
                    _local_3 = -1;
                    do 
                    {
                        _local_3 = (_local_3 + 1);
                        _local_2 = (_local_2 >>> 8);
                    } while (!(uint(_local_2) < uint(0x0100)));
                    _local_3 = (_local_3 << 3);
                    _local_3 = (_local_3 | 0x07);
                };
                _local_4 = _log_2_2E_3461;
                _local_2 = (_local_4 + _local_2);
                _local_2 = li8(_local_2);
                _local_2 = (_local_2 + _local_3);
                _local_2 = (_local_2 << 2);
                _local_1 = (_local_2 + _local_1);
                _local_2 = li32(_local_1 + 4);
                _local_2 = (_local_2 + 1);
                si32(_local_2, (_local_1 + 4));
                _local_1 = 1;
            }
            else
            {
                _local_1 = 0;
            };
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

