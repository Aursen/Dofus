package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___ulp_D2A extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 24);
            _local_1 = li32(mstate.ebp + 12);
            _local_1 = (_local_1 & 0x7FF00000);
            _local_2 = (_local_1 + -54525952);
            if (!(_local_2 < 1))
            {
                _local_1 = 0;
                si32(_local_1, (mstate.ebp + -8));
                si32(_local_2, (mstate.ebp + -4));
                _local_4 = lf64(mstate.ebp + -8);
            }
            else
            {
                _local_1 = (54525952 - _local_1);
                _local_1 = (_local_1 >> 20);
                if (!(_local_1 > 19))
                {
                    _local_2 = 0x80000;
                    _local_3 = 0;
                    _local_1 = (_local_2 >>> _local_1);
                    si32(_local_3, (mstate.ebp + -16));
                    si32(_local_1, (mstate.ebp + -12));
                    _local_4 = lf64(mstate.ebp + -16);
                }
                else
                {
                    _local_2 = (_local_1 + -20);
                    if (!(_local_2 > 30))
                    {
                        _local_2 = 1;
                        _local_1 = (51 - _local_1);
                        _local_3 = 0;
                        _local_1 = (_local_2 << _local_1);
                        si32(_local_1, (mstate.ebp + -24));
                        si32(_local_3, (mstate.ebp + -20));
                        _local_4 = lf64(mstate.ebp + -24);
                    }
                    else
                    {
                        _local_4 = 4.94065645841247E-324;
                    };
                };
            };
            mstate.st0 = _local_4;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

