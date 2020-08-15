package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_settzname extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = _wildabbr;
            si32(_local_1, _tzname);
            si32(_local_1, (_tzname + 4));
            _local_1 = li32(_lclmem + 8);
            if (!(_local_1 < 1))
            {
                _local_2 = _lclmem;
                _local_3 = 0;
                do 
                {
                    _local_4 = _lclmem;
                    _local_5 = li32(_local_2 + 1872);
                    _local_6 = li32(_local_2 + 1876);
                    _local_4 = (_local_4 + _local_6);
                    _local_6 = _tzname;
                    _local_5 = (_local_5 << 2);
                    _local_4 = (_local_4 + 6988);
                    _local_5 = (_local_6 + _local_5);
                    si32(_local_4, _local_5);
                    _local_2 = (_local_2 + 20);
                    _local_3 = (_local_3 + 1);
                    if (_local_1 <= _local_3) goto _label_2;
                } while (true);
                do 
                {
                    
                _label_1: 
                    _local_4 = _lclmem;
                    _local_5 = (_local_2 + _local_1);
                    _local_5 = li8(_local_5 + 1496);
                    _local_5 = (_local_5 * 20);
                    _local_5 = (_local_4 + _local_5);
                    _local_6 = li32(_local_5 + 1872);
                    _local_5 = li32(_local_5 + 1876);
                    _local_4 = (_local_4 + _local_5);
                    _local_5 = _tzname;
                    _local_6 = (_local_6 << 2);
                    _local_4 = (_local_4 + 6988);
                    _local_5 = (_local_5 + _local_6);
                    si32(_local_4, _local_5);
                    _local_1 = (_local_1 + 1);
                    if (_local_3 <= _local_1) goto _label_3;
                } while (true);
            };
            
        _label_2: 
            _local_3 = li32(_lclmem + 4);
            if (!(_local_3 < 1))
            {
                _local_2 = _lclmem;
                _local_1 = 0;
                goto _label_1;
            };
            
        _label_3: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

