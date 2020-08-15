package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___rshift_D2A extends Machine 
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
            var _local_13:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(_local_1 + 16);
            _local_4 = (_local_1 + 16);
            _local_5 = (_local_2 >> 5);
            _local_6 = (_local_1 + 20);
            _local_7 = _local_1;
            if (!(_local_3 > _local_5))
            {
                
            _label_1: 
                _local_2 = _local_6;
                goto _label_3;
            };
            _local_2 = (_local_2 & 0x1F);
            if (!(!(_local_2 == 0)))
            {
                if (_local_5 >= _local_3) goto _label_1;
                _local_2 = 0;
                _local_8 = (_local_5 << 2);
                _local_7 = (_local_7 + 20);
                do 
                {
                    _local_9 = (_local_8 + _local_7);
                    _local_9 = li32(_local_9);
                    si32(_local_9, _local_7);
                    _local_7 = (_local_7 + 4);
                    _local_2 = (_local_2 + 1);
                    _local_9 = (_local_5 + _local_2);
                    if (_local_9 >= _local_3) goto _label_2;
                } while (true);
            };
            _local_8 = (_local_5 << 2);
            _local_8 = (_local_1 + _local_8);
            _local_8 = li32(_local_8 + 20);
            _local_8 = (_local_8 >>> _local_2);
            _local_9 = (32 - _local_2);
            _local_10 = (_local_5 + 1);
            if (!(_local_10 < _local_3))
            {
                _local_2 = _local_6;
                _local_7 = _local_8;
            }
            else
            {
                _local_10 = 0;
                _local_11 = (_local_5 << 2);
                _local_5 = (_local_5 + 1);
                do 
                {
                    _local_12 = (_local_11 + _local_7);
                    _local_13 = li32(_local_12 + 24);
                    _local_13 = (_local_13 << _local_9);
                    _local_8 = (_local_13 | _local_8);
                    si32(_local_8, (_local_7 + 20));
                    _local_8 = li32(_local_12 + 24);
                    _local_7 = (_local_7 + 4);
                    _local_10 = (_local_10 + 1);
                    _local_8 = (_local_8 >>> _local_2);
                    _local_12 = (_local_5 + _local_10);
                } while (!(_local_12 >= _local_3));
                _local_2 = (_local_10 << 2);
                _local_2 = (_local_1 + _local_2);
                _local_2 = (_local_2 + 20);
                _local_7 = _local_8;
            };
            _local_3 = _local_7;
            si32(_local_3, _local_2);
            if ((!(_local_3 == 0)))
            {
                _local_2 = (_local_2 + 4);
                goto _label_3;
                
            _label_2: 
                _local_2 = (_local_2 << 2);
                _local_2 = (_local_1 + _local_2);
                _local_2 = (_local_2 + 20);
            };
            
        _label_3: 
            _local_1 = (_local_1 + 20);
            _local_1 = (_local_2 - _local_1);
            _local_2 = (_local_1 >> 2);
            si32(_local_2, _local_4);
            if (!(uint(_local_1) > uint(3)))
            {
                _local_1 = 0;
                si32(_local_1, _local_6);
            };
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

