package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___muldi3 extends Machine 
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
            var _local_11:int;
            var _local_12:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = 0;
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(mstate.ebp + 20);
            _local_3 = li32(mstate.ebp + 8);
            _local_4 = (_local_1 >> 31);
            _local_5 = li32(mstate.ebp + 16);
            _local_6 = (_local_2 >> 31);
            _local_3 = __addc(_local_3, _local_4);
            _local_7 = __adde(_local_1, _local_4);
            _local_5 = __addc(_local_5, _local_6);
            _local_8 = __adde(_local_2, _local_6);
            _local_1 = (_local_1 >>> 31);
            _local_7 = (_local_7 ^ _local_4);
            _local_3 = (_local_3 ^ _local_4);
            _local_2 = (_local_2 >>> 31);
            _local_4 = (_local_8 ^ _local_6);
            _local_5 = (_local_5 ^ _local_6);
            _local_6 = _local_7;
            _local_8 = _local_7;
            if (!(!(_local_7 == 0)))
            {
                if (!(!(_local_4 == 0)))
                {
                    mstate.esp = (mstate.esp - 8);
                    si32(_local_3, mstate.esp);
                    si32(_local_5, (mstate.esp + 4));
                    mstate.esp = (mstate.esp - 4);
                    FSM___lmulq.start();
                    _local_3 = mstate.eax;
                    _local_4 = mstate.edx;
                    mstate.esp = (mstate.esp + 8);
                    if (_local_1 == _local_2) goto _label_2;
                    goto _label_1;
                };
            };
            _local_7 = ((uint(_local_5) < uint(_local_4)) ? _local_5 : _local_4);
            _local_9 = ((uint(_local_5) < uint(_local_4)) ? _local_4 : _local_5);
            _local_10 = ((uint(_local_6) < uint(_local_3)) ? _local_8 : _local_3);
            _local_8 = ((uint(_local_6) < uint(_local_3)) ? _local_3 : _local_8);
            _local_11 = ((uint(_local_5) < uint(_local_4)) ? 1 : 0);
            _local_12 = ((uint(_local_6) < uint(_local_3)) ? 1 : 0);
            _local_7 = (_local_9 - _local_7);
            _local_8 = (_local_8 - _local_10);
            mstate.esp = (mstate.esp - 8);
            _local_9 = (_local_11 ^ _local_12);
            _local_7 = (_local_7 * _local_8);
            si32(_local_3, mstate.esp);
            si32(_local_5, (mstate.esp + 4));
            _local_3 = (_local_9 & 0x01);
            _local_5 = (0 - _local_7);
            _local_3 = ((_local_3 != 0) ? _local_5 : _local_7);
            _local_4 = (_local_4 * _local_6);
            mstate.esp = (mstate.esp - 4);
            FSM___lmulq.start();
            _local_5 = mstate.eax;
            _local_6 = mstate.edx;
            _local_3 = (_local_3 + _local_4);
            _local_3 = (_local_3 + _local_5);
            mstate.esp = (mstate.esp + 8);
            _local_4 = (_local_3 + _local_6);
            if (!(_local_1 == _local_2))
            {
                _local_3 = _local_5;
                
            _label_1: 
                _local_1 = 0;
                _local_3 = __subc(_local_1, _local_3);
                _local_4 = __sube(_local_1, _local_4);
                mstate.edx = _local_4;
                mstate.eax = _local_3;
                goto _label_3;
                
            _label_2: 
                _local_1 = _local_3;
                _local_2 = _local_4;
                mstate.edx = _local_2;
                mstate.eax = _local_1;
                
            _label_3: 
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
            };
            _local_3 = _local_5;
            goto _label_2;
        }


    }
}

