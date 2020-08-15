package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_localsub399 extends Machine 
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
            _local_1 = li32(_lclmem + 4);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(mstate.ebp + 16);
            if (!(!(_local_1 == 0)))
            {
                
            _label_1: 
                _local_1 = _lclmem;
                _local_4 = 0;
                _local_1 = (_local_1 + 1872);
                goto _label_2;
            };
            _local_4 = li32(_lclmem + 16);
            if (_local_4 > _local_2) goto _label_1;
            _local_4 = _lclmem;
            _local_5 = 0;
            _local_4 = (_local_4 + 20);
            goto _label_3;
            do 
            {
                _local_4 = li32(_lclmem + 8);
                _local_5 = (_local_5 + 20);
                _local_6 = (_local_1 + 1);
                if (!(_local_6 < _local_4))
                {
                    _local_1 = 0;
                    goto _label_4;
                };
                _local_1 = _local_5;
                _local_4 = _local_6;
                
            _label_2: 
                _local_5 = _local_1;
                _local_1 = _local_4;
                _local_4 = li32(_local_5);
            } while ((!(_local_4 == 0)));
            goto _label_4;
            do 
            {
                _local_5 = li32(_local_5);
                _local_6 = (_local_6 + 4);
                _local_7 = (_local_4 + 1);
                if ((_local_5 > _local_2)) break;
                _local_4 = _local_6;
                _local_5 = _local_7;
                
            _label_3: 
                _local_6 = _local_4;
                _local_4 = _local_5;
                _local_5 = _local_6;
                _local_7 = (_local_4 + 1);
            } while ((_local_1 > _local_7));
            _local_1 = _lclmem;
            _local_1 = (_local_1 + _local_4);
            _local_1 = li8(_local_1 + 1496);
            
        _label_4: 
            _local_4 = _lclmem;
            _local_1 = (_local_1 * 20);
            _local_1 = (_local_4 + _local_1);
            _local_5 = li32(_local_1 + 1868);
            mstate.esp = (mstate.esp - 16);
            si32(_local_2, mstate.esp);
            si32(_local_5, (mstate.esp + 4));
            si32(_local_4, (mstate.esp + 8));
            si32(_local_3, (mstate.esp + 12));
            mstate.esp = (mstate.esp - 4);
            FSM_timesub398.start();
            mstate.esp = (mstate.esp + 16);
            _local_2 = li32(_local_1 + 1872);
            si32(_local_2, (_local_3 + 32));
            _local_1 = li32(_local_1 + 1876);
            _local_1 = (_local_4 + _local_1);
            _local_4 = _tzname;
            _local_2 = (_local_2 << 2);
            _local_1 = (_local_1 + 6988);
            _local_2 = (_local_4 + _local_2);
            si32(_local_1, _local_2);
            si32(_local_1, (_local_3 + 40));
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

