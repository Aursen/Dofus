package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_timesub398 extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 16);
            _local_2 = li32(_local_1);
            _local_3 = li32(mstate.ebp + 8);
            _local_4 = li32(mstate.ebp + 12);
            _local_5 = li32(mstate.ebp + 20);
            _local_6 = _local_1;
            _local_7 = (_local_2 + -1);
            if (!(_local_7 < 0))
            {
                _local_7 = 0;
                _local_8 = (_local_2 << 3);
                _local_6 = (_local_6 + _local_8);
                _local_6 = (_local_6 + 7492);
                _local_8 = (_local_2 + -1);
                do 
                {
                    _local_9 = li32(_local_6);
                    if ((_local_9 > _local_3)) continue;
                    _local_6 = (_local_2 - _local_7);
                    if (!(_local_9 == _local_3))
                    {
                        
                    _label_1: 
                        _local_6 = 0;
                        //unresolved jump
                    };
                    if (!(_local_6 == 1)) goto _label_10;
                    _local_7 = (_local_8 << 3);
                    _local_7 = (_local_1 + _local_7);
                    _local_7 = li32(_local_7 + 7504);
                    if (_local_7 < 1) goto _label_10;
                } while ((_local_6 = 0), do 
                {
                    _local_7 = (_local_8 - _local_6);
                    if ((_local_7 < 1)) break;
                    _local_2 = (_local_7 + -1);
                    _local_9 = (_local_2 << 3);
                    _local_10 = (_local_1 + 7500);
                    _local_11 = (_local_7 << 3);
                    _local_9 = (_local_10 + _local_9);
                    _local_10 = (_local_10 + _local_11);
                    _local_9 = li32(_local_9);
                    _local_10 = li32(_local_10);
                    _local_9 = (_local_9 + 1);
                    if ((!(_local_10 == _local_9))) break;
                    _local_2 = (_local_2 << 3);
                    _local_9 = (_local_1 + 7500);
                    _local_7 = (_local_7 << 3);
                    _local_2 = (_local_9 + _local_2);
                    _local_7 = (_local_9 + _local_7);
                    _local_2 = li32(_local_2 + 4);
                    _local_7 = li32(_local_7 + 4);
                    _local_9 = (_local_6 + 1);
                    _local_2 = (_local_2 + 1);
                    if ((!(_local_7 == _local_2))) break;
                    _local_6 = _local_9;
                } while (true), (_local_6 = (_local_6 + 1)), (_local_7 = (_local_8 << 3)), (_local_8 = int((_local_3 / 86400))), (_local_7 = (_local_1 + _local_7)), (_local_7 = li32(_local_7 + 7504)), (_local_1 = (_local_8 * 86400)), (_local_1 = (_local_3 - _local_1)), (_local_7 = (_local_4 - _local_7)), (_local_7 = (_local_1 + _local_7)), if (_local_7 < 0) goto _label_2;
, goto _label_5, (_local_6 = (_local_6 + -8)), (_local_8 = (_local_8 + -1)), (_local_7 = (_local_7 + 1)), !(_local_8 < 0));
            };
            _local_6 = 0;
            _local_7 = int((_local_3 / 86400));
            _local_8 = (_local_7 * 86400);
            _local_8 = (_local_3 - _local_8);
            _local_1 = _local_4;
            goto _label_4;
            
        _label_2: 
            do 
            {
                
            _label_3: 
                _local_2 = 86400;
                _local_3 = (_local_8 + -1);
                _local_1 = _local_7;
                _local_8 = _local_2;
                _local_7 = _local_3;
                
            _label_4: 
                _local_2 = _local_7;
                _local_7 = (_local_8 + _local_1);
                if (!(_local_7 < 0))
                {
                    _local_8 = _local_2;
                    
                _label_5: 
                    _local_1 = _local_6;
                    _local_2 = _local_7;
                    _local_3 = _local_8;
                    if ((_local_2 > 86399))
                    {
                        _local_6 = -1;
                        do 
                        {
                            _local_2 = (_local_2 + -86400);
                            _local_6 = (_local_6 + 1);
                        } while (!(_local_2 < 86400));
                        _local_3 = (_local_6 + _local_3);
                        _local_3 = (_local_3 + 1);
                    };
                    _local_6 = int((_local_2 / 3600));
                    _local_7 = (_local_6 * 3600);
                    _local_2 = (_local_2 - _local_7);
                    _local_7 = int((_local_2 / 60));
                    _local_8 = (_local_7 * 60);
                    _local_9 = (_local_3 + 4);
                    si32(_local_6, (_local_5 + 8));
                    _local_6 = int((_local_9 / 7));
                    _local_2 = (_local_2 - _local_8);
                    _local_6 = (_local_6 * 7);
                    si32(_local_7, (_local_5 + 4));
                    _local_1 = (_local_2 + _local_1);
                    si32(_local_1, _local_5);
                    _local_1 = (_local_9 - _local_6);
                    si32(_local_1, (_local_5 + 24));
                    _local_2 = (_local_5 + 24);
                    if (!(_local_1 < 0))
                    {
                        _local_1 = 1970;
                        _local_2 = _local_3;
                    }
                    else
                    {
                        _local_1 = (_local_1 + 7);
                        si32(_local_1, _local_2);
                        if (!(_local_3 < 0))
                        {
                            _local_1 = 1970;
                            _local_2 = _local_3;
                            goto _label_7;
                        };
                        _local_1 = 1970;
                        _local_2 = _local_3;
                        
                    _label_6: 
                        _local_3 = (_local_2 >> 31);
                        _local_3 = (_local_3 + _local_1);
                        _local_6 = int((_local_2 / 365));
                        _local_3 = (_local_3 + _local_6);
                        _local_6 = (_local_3 + -1);
                        _local_7 = (_local_6 >> 31);
                        _local_7 = (_local_7 >>> 30);
                        _local_7 = (_local_6 + _local_7);
                        _local_8 = (_local_1 + -1);
                        _local_7 = (_local_7 >> 2);
                        _local_9 = (_local_8 >> 31);
                        _local_2 = (_local_2 - _local_7);
                        _local_7 = int((_local_6 / 100));
                        _local_9 = (_local_9 >>> 30);
                        _local_1 = (_local_3 - _local_1);
                        _local_2 = (_local_2 + _local_7);
                        _local_6 = int((_local_6 / 400));
                        _local_7 = (_local_8 + _local_9);
                        _local_2 = (_local_2 - _local_6);
                        _local_1 = (_local_1 * 365);
                        _local_6 = (_local_7 >> 2);
                        _local_1 = (_local_2 - _local_1);
                        _local_1 = (_local_1 + _local_6);
                        _local_2 = int((_local_8 / 100));
                        _local_1 = (_local_1 - _local_2);
                        _local_2 = int((_local_8 / 400));
                        _local_2 = (_local_1 + _local_2);
                        _local_1 = _local_3;
                    };
                    if ((_local_2 < 0)) break;
                    
                _label_7: 
                    _local_3 = (_local_1 & 0x03);
                    if (!(!(_local_3 == 0)))
                    {
                        _local_3 = int((_local_1 / 100));
                        _local_3 = (_local_3 * 100);
                        _local_3 = (_local_1 - _local_3);
                        if (!(_local_3 == 0))
                        {
                            
                        _label_8: 
                            _local_3 = 1;
                            goto _label_9;
                        };
                        _local_3 = int((_local_1 / 400));
                        _local_3 = (_local_3 * 400);
                        _local_3 = (_local_1 - _local_3);
                        if (_local_3 == 0) goto _label_8;
                    };
                    _local_3 = 0;
                    
                _label_9: 
                    _local_6 = _year_lengths;
                    _local_7 = (_local_3 << 2);
                    _local_6 = (_local_6 + _local_7);
                    _local_6 = li32(_local_6);
                    if (!(_local_6 > _local_2)) goto _label_6;
                    _local_6 = _mon_lengths;
                    _local_1 = (_local_1 + -1900);
                    si32(_local_1, (_local_5 + 20));
                    _local_1 = (_local_3 * 48);
                    si32(_local_2, (_local_5 + 28));
                    _local_7 = 0;
                    si32(_local_7, (_local_5 + 16));
                    _local_1 = (_local_6 + _local_1);
                    _local_1 = li32(_local_1);
                    _local_6 = (_local_5 + 16);
                    if ((_local_1 <= _local_2))
                    {
                        _local_1 = _mon_lengths;
                        _local_3 = (_local_3 * 48);
                        _local_7 = 0;
                        _local_1 = (_local_1 + _local_3);
                        _local_3 = _local_7;
                        do 
                        {
                            _local_7 = li32(_local_1);
                            _local_8 = li32(_local_1 + 4);
                            _local_3 = (_local_3 + 1);
                            _local_1 = (_local_1 + 4);
                            _local_2 = (_local_2 - _local_7);
                        } while (!(_local_8 > _local_2));
                        si32(_local_3, _local_6);
                    };
                    _local_1 = _local_2;
                    _local_2 = 0;
                    _local_1 = (_local_1 + 1);
                    si32(_local_1, (_local_5 + 12));
                    si32(_local_2, (_local_5 + 32));
                    si32(_local_4, (_local_5 + 36));
                    mstate.esp = mstate.ebp;
                    mstate.ebp = li32(mstate.esp);
                    mstate.esp = (mstate.esp + 4);
                    mstate.esp = (mstate.esp + 4);
                    return;
                    
                _label_10: 
                    _local_6 = (_local_6 << 3);
                    _local_7 = (_local_1 + 7500);
                    _local_2 = (_local_8 << 3);
                    _local_6 = (_local_6 + _local_7);
                    _local_7 = (_local_7 + _local_2);
                    _local_7 = li32(_local_7 + 4);
                    _local_6 = li32(_local_6 + -12);
                    //unresolved if
                    goto _label_1;
                };
                _local_8 = _local_2;
            } while (true);
            goto _label_6;
        }


    }
}

