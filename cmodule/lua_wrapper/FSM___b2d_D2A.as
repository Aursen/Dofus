package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___b2d_D2A extends Machine 
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
            var _local_10:int;
            var _local_11:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 8);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(_local_1 + 16);
            _local_3 = (_local_2 + -1);
            _local_4 = (_local_3 << 2);
            _local_5 = (_local_1 + 20);
            _local_4 = (_local_5 + _local_4);
            _local_6 = li32(_local_4);
            _local_7 = ((uint(_local_6) < uint(0x10000)) ? 16 : 0);
            _local_8 = (_local_6 << _local_7);
            _local_9 = ((uint(_local_8) < uint(0x1000000)) ? 8 : 0);
            _local_8 = (_local_8 << _local_9);
            _local_10 = ((uint(_local_8) < uint(0x10000000)) ? 4 : 0);
            _local_7 = (_local_9 | _local_7);
            _local_8 = (_local_8 << _local_10);
            _local_9 = ((uint(_local_8) < uint(0x40000000)) ? 2 : 0);
            _local_7 = (_local_7 | _local_10);
            _local_7 = (_local_7 | _local_9);
            _local_8 = (_local_8 << _local_9);
            _local_9 = li32(mstate.ebp + 12);
            if ((_local_8 > -1))
            {
                _local_8 = (_local_8 & 0x40000000);
                _local_7 = (_local_7 + 1);
                _local_7 = ((_local_8 == 0) ? 32 : _local_7);
            };
            _local_8 = (32 - _local_7);
            si32(_local_8, _local_9);
            if (!(_local_7 > 10))
            {
                _local_4 = (_local_7 + 21);
                _local_5 = (11 - _local_7);
                _local_4 = (_local_6 << _local_4);
                _local_6 = (_local_6 >>> _local_5);
                if (!(_local_3 > 0))
                {
                    _local_5 = _local_6;
                }
                else
                {
                    _local_2 = (_local_2 << 2);
                    _local_1 = (_local_2 + _local_1);
                    _local_1 = li32(_local_1 + 12);
                    _local_5 = (_local_1 >>> _local_5);
                    _local_4 = (_local_5 | _local_4);
                    _local_5 = _local_6;
                };
            }
            else
            {
                if (!(_local_3 > 0))
                {
                    _local_1 = 0;
                    _local_2 = _local_4;
                }
                else
                {
                    _local_2 = (_local_2 << 2);
                    _local_1 = (_local_2 + _local_1);
                    _local_4 = li32(_local_1 + 12);
                    _local_1 = (_local_1 + 12);
                    _local_2 = _local_1;
                    _local_1 = _local_4;
                };
                _local_4 = _local_2;
                _local_2 = (_local_7 + -11);
                if (!(!(_local_7 == 11)))
                {
                    _local_5 = _local_6;
                    _local_4 = _local_1;
                }
                else
                {
                    _local_3 = (43 - _local_7);
                    _local_7 = (_local_1 >>> _local_3);
                    _local_6 = (_local_6 << _local_2);
                    _local_6 = (_local_7 | _local_6);
                    if (!(uint(_local_4) > uint(_local_5)))
                    {
                        _local_4 = 0;
                    }
                    else
                    {
                        _local_4 = li32(_local_4 + -4);
                    };
                    _local_4 = (_local_4 >>> _local_3);
                    _local_5 = (_local_1 << _local_2);
                    _local_4 = (_local_4 | _local_5);
                    _local_5 = _local_6;
                };
            };
            _local_1 = _local_5;
            _local_2 = _local_4;
            _local_1 = (_local_1 | 0x3FF00000);
            si32(_local_2, (mstate.ebp + -8));
            si32(_local_1, (mstate.ebp + -4));
            _local_11 = lf64(mstate.ebp + -8);
            mstate.st0 = _local_11;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

