package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_getsecs extends Machine 
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
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = _local_1;
            if (!(_local_1 == 0))
            {
                _local_1 = li8(_local_1);
                _local_4 = (_local_1 << 24);
                _local_4 = (_local_4 >> 24);
                _local_4 = (_local_4 + -48);
                if (!(uint(_local_4) > uint(9)))
                {
                    _local_4 = 0;
                    do 
                    {
                        _local_1 = (_local_1 << 24);
                        _local_1 = (_local_1 >> 24);
                        _local_4 = (_local_4 * 10);
                        _local_1 = (_local_4 + _local_1);
                        _local_1 = (_local_1 + -48);
                        if (_local_1 > 167) goto _label_1;
                        _local_5 = li8(_local_3 + 1);
                        _local_3 = (_local_3 + 1);
                        _local_4 = (_local_5 << 24);
                        _local_4 = (_local_4 >> 24);
                        _local_6 = _local_3;
                        _local_4 = (_local_4 + -48);
                        if ((uint(_local_4) > uint(9))) break;
                        _local_3 = _local_6;
                        _local_4 = _local_1;
                        _local_1 = _local_5;
                    } while (true);
                    if (!(_local_1 < 0)) goto _label_2;
                };
            };
            
        _label_1: 
            _local_3 = 0;
            
        _label_2: 
            _local_4 = _local_3;
            if (!(!(_local_3 == 0)))
            {
                
            _label_3: 
                _local_1 = 0;
                
            _label_4: 
                mstate.eax = _local_1;
                goto _label_9;
            };
            _local_5 = (_local_1 * 3600);
            si32(_local_5, _local_2);
            _local_6 = li8(_local_3);
            if (!(_local_6 == 58))
            {
                _local_1 = _local_3;
                goto _label_4;
            };
            _local_3 = (_local_3 + 1);
            if (!(!(_local_3 == 0)))
            {
                
            _label_5: 
                _local_3 = 0;
                goto _label_6;
            };
            _local_3 = li8(_local_3);
            _local_6 = (_local_3 << 24);
            _local_6 = (_local_6 >> 24);
            _local_6 = (_local_6 + -48);
            if (uint(_local_6) > uint(9)) goto _label_5;
            _local_6 = 0;
            do 
            {
                _local_3 = (_local_3 << 24);
                _local_3 = (_local_3 >> 24);
                _local_6 = (_local_6 * 10);
                _local_3 = (_local_6 + _local_3);
                _local_3 = (_local_3 + -48);
                if (_local_3 > 59) goto _label_5;
                _local_7 = li8(_local_4 + 2);
                _local_6 = (_local_7 << 24);
                _local_4 = (_local_4 + 1);
                _local_6 = (_local_6 >> 24);
                _local_6 = (_local_6 + -48);
                if ((uint(_local_6) > uint(9))) break;
                _local_6 = _local_3;
                _local_3 = _local_7;
            } while (true);
            if (_local_3 < 0) goto _label_5;
            _local_4 = (_local_4 + 1);
            _local_1 = _local_3;
            _local_3 = _local_4;
            
        _label_6: 
            _local_4 = _local_3;
            if (_local_3 == 0) goto _label_3;
            _local_6 = (_local_1 * 60);
            _local_5 = (_local_6 + _local_5);
            si32(_local_5, _local_2);
            _local_6 = li8(_local_3);
            if (!(_local_6 == 58))
            {
                _local_1 = _local_3;
                goto _label_4;
            };
            _local_3 = (_local_3 + 1);
            if (!(!(_local_3 == 0)))
            {
                
            _label_7: 
                _local_3 = 0;
                goto _label_8;
            };
            _local_3 = li8(_local_3);
            _local_6 = (_local_3 << 24);
            _local_6 = (_local_6 >> 24);
            _local_6 = (_local_6 + -48);
            if (uint(_local_6) > uint(9)) goto _label_7;
            _local_6 = 0;
            do 
            {
                _local_3 = (_local_3 << 24);
                _local_3 = (_local_3 >> 24);
                _local_6 = (_local_6 * 10);
                _local_3 = (_local_6 + _local_3);
                _local_3 = (_local_3 + -48);
                if (_local_3 > 60) goto _label_7;
                _local_7 = li8(_local_4 + 2);
                _local_6 = (_local_7 << 24);
                _local_4 = (_local_4 + 1);
                _local_6 = (_local_6 >> 24);
                _local_6 = (_local_6 + -48);
                if ((uint(_local_6) > uint(9))) break;
                _local_6 = _local_3;
                _local_3 = _local_7;
            } while (true);
            if (_local_3 < 0) goto _label_7;
            _local_4 = (_local_4 + 1);
            _local_1 = _local_3;
            _local_3 = _local_4;
            
        _label_8: 
            if (_local_3 == 0) goto _label_3;
            _local_1 = (_local_1 + _local_5);
            si32(_local_1, _local_2);
            mstate.eax = _local_3;
            
        _label_9: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

