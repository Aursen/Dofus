package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___lmulq extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = (_local_2 & 0xFFFF);
            _local_4 = (_local_1 & 0xFFFF);
            _local_5 = (_local_3 * _local_4);
            _local_6 = (_local_2 >>> 16);
            _local_7 = (_local_1 >>> 16);
            if (!(uint(_local_2) > uint(0xFFFF)))
            {
                if (!(uint(_local_1) > uint(0xFFFF)))
                {
                    _local_3 = 0;
                    mstate.edx = _local_3;
                    mstate.eax = _local_5;
                    
                _label_1: 
                    mstate.esp = mstate.ebp;
                    mstate.ebp = li32(mstate.esp);
                    mstate.esp = (mstate.esp + 4);
                    mstate.esp = (mstate.esp + 4);
                    return;
                };
            };
            _local_1 = ((uint(_local_7) < uint(_local_4)) ? _local_4 : _local_7);
            _local_2 = ((uint(_local_7) < uint(_local_4)) ? _local_7 : _local_4);
            _local_8 = ((uint(_local_3) < uint(_local_6)) ? _local_6 : _local_3);
            _local_9 = ((uint(_local_3) < uint(_local_6)) ? _local_3 : _local_6);
            _local_10 = (_local_6 * _local_7);
            _local_8 = (_local_8 - _local_9);
            _local_1 = (_local_1 - _local_2);
            _local_2 = (_local_10 >>> 16);
            _local_1 = (_local_8 * _local_1);
            _local_4 = ((uint(_local_7) < uint(_local_4)) ? 1 : 0);
            _local_3 = ((uint(_local_3) < uint(_local_6)) ? 1 : 0);
            _local_3 = (_local_3 ^ _local_4);
            _local_4 = (_local_1 << 16);
            _local_6 = (_local_10 << 16);
            _local_2 = (_local_2 + _local_10);
            _local_3 = (_local_3 ^ 0x01);
            _local_3 = (_local_3 & 0x01);
            if (!(!(_local_3 == 0)))
            {
                _local_4 = (_local_6 - _local_4);
                _local_6 = ((uint(_local_4) > uint(_local_6)) ? 1 : 0);
                _local_1 = (_local_1 >>> 16);
                _local_6 = (_local_6 & 0x01);
                _local_1 = (_local_2 - _local_1);
                _local_1 = (_local_1 - _local_6);
                _local_2 = _local_4;
            }
            else
            {
                _local_3 = (_local_4 + _local_6);
                _local_4 = ((uint(_local_3) < uint(_local_6)) ? 1 : 0);
                _local_1 = (_local_1 >>> 16);
                _local_4 = (_local_4 & 0x01);
                _local_1 = (_local_1 + _local_2);
                _local_1 = (_local_1 + _local_4);
                _local_2 = _local_3;
            };
            _local_3 = (_local_5 << 16);
            _local_3 = (_local_2 + _local_3);
            _local_2 = ((uint(_local_3) < uint(_local_2)) ? 1 : 0);
            _local_3 = (_local_3 + _local_5);
            _local_4 = (_local_5 >>> 16);
            _local_5 = ((uint(_local_3) < uint(_local_5)) ? 1 : 0);
            _local_2 = (_local_2 & 0x01);
            _local_1 = (_local_1 + _local_4);
            _local_4 = (_local_5 & 0x01);
            _local_1 = (_local_1 + _local_2);
            _local_1 = (_local_1 + _local_4);
            mstate.edx = _local_1;
            mstate.eax = _local_3;
            goto _label_1;
        }


    }
} cmodule.lua_wrapper

