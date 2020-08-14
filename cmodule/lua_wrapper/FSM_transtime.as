package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_transtime extends Machine 
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
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = li32(mstate.ebp + 20);
            _local_5 = (_local_1 & 0x03);
            if (!(!(_local_5 == 0)))
            {
                _local_5 = int((_local_1 / 100));
                _local_5 = (_local_5 * 100);
                _local_5 = (_local_1 - _local_5);
                if (!(_local_5 == 0))
                {
                    
                _label_1: 
                    _local_5 = 1;
                    goto _label_2;
                };
                _local_5 = int((_local_1 / 400));
                _local_5 = (_local_5 * 400);
                _local_5 = (_local_1 - _local_5);
                if (_local_5 == 0) goto _label_1;
            };
            _local_5 = 0;
            
        _label_2: 
            _local_6 = li32(_local_3);
            if (!(_local_6 == 0))
            {
                if (_local_6 == 1) goto _label_4;
                if (!(_local_6 == 2))
                {
                    
                _label_3: 
                    _local_2 = li32(_local_3 + 16);
                    _local_1 = (_local_1 + _local_4);
                    _local_1 = (_local_1 + _local_2);
                    goto _label_9;
                };
                _local_6 = li32(_local_3 + 12);
                _local_7 = (_local_6 + -1);
                if (_local_7 > 0) goto _label_5;
                goto _label_6;
            };
            _local_1 = li32(_local_3 + 4);
            _local_6 = (_local_1 * 86400);
            _local_2 = (_local_2 + _local_6);
            _local_2 = (_local_2 + -86400);
            if( ((_local_1 < 60)) || (!(!(_local_5 == 0))) )
            {
                _local_1 = _local_2;
                goto _label_3;
            };
            _local_1 = li32(_local_3 + 16);
            _local_2 = (_local_4 + _local_2);
            _local_2 = (_local_2 + _local_1);
            _local_2 = (_local_2 + 86400);
            mstate.eax = _local_2;
            goto _label_10;
            
        _label_4: 
            _local_1 = li32(_local_3 + 4);
            _local_3 = li32(_local_3 + 16);
            _local_2 = (_local_4 + _local_2);
            _local_2 = (_local_2 + _local_3);
            _local_1 = (_local_1 * 86400);
            _local_1 = (_local_2 + _local_1);
            goto _label_9;
            
        _label_5: 
            _local_8 = _mon_lengths;
            _local_9 = (_local_5 * 48);
            _local_10 = 0;
            _local_8 = (_local_8 + _local_9);
            _local_9 = _local_10;
            do 
            {
                _local_10 = li32(_local_8);
                _local_10 = (_local_10 * 86400);
                _local_8 = (_local_8 + 4);
                _local_9 = (_local_9 + 1);
                _local_2 = (_local_10 + _local_2);
                if (!(_local_7 > _local_9))
                {
                    
                _label_6: 
                    _local_7 = (_local_1 + -1);
                    _local_1 = ((_local_6 > 2) ? _local_1 : _local_7);
                    _local_7 = (_local_6 + 9);
                    _local_8 = int((_local_1 / 100));
                    _local_9 = int((_local_7 / 12));
                    _local_9 = (_local_9 * 12);
                    _local_10 = (_local_8 * 100);
                    _local_7 = (_local_7 - _local_9);
                    _local_9 = (_local_1 - _local_10);
                    _local_10 = (_local_9 >> 31);
                    _local_8 = (_local_8 << 1);
                    _local_7 = (_local_7 * 26);
                    _local_10 = (_local_10 >>> 30);
                    _local_8 = (1 - _local_8);
                    _local_7 = (_local_7 + 24);
                    _local_10 = (_local_9 + _local_10);
                    _local_8 = (_local_8 + _local_9);
                    _local_7 = int((_local_7 / 10));
                    _local_9 = (_local_10 >> 2);
                    _local_7 = (_local_8 + _local_7);
                    _local_7 = (_local_7 + _local_9);
                    _local_1 = int((_local_1 / 400));
                    _local_1 = (_local_7 + _local_1);
                    _local_7 = int((_local_1 / 7));
                    _local_7 = (_local_7 * 7);
                    _local_8 = li32(_local_3 + 4);
                    _local_1 = (_local_1 - _local_7);
                    _local_7 = (_local_8 - _local_1);
                    _local_8 = (_local_7 + -7);
                    _local_1 = ((_local_1 > -1) ? _local_7 : _local_8);
                    if (!(_local_1 < 0))
                    {
                        _local_7 = 1;
                    }
                    else
                    {
                        _local_7 = li32(_local_3 + 8);
                        _local_1 = (_local_1 + 7);
                        if (!(_local_7 > 1)) goto _label_8;
                        _local_7 = 1;
                        
                    _label_7: 
                        _local_8 = _mon_lengths;
                        _local_9 = (_local_5 * 48);
                        _local_10 = (_local_6 << 2);
                        _local_8 = (_local_8 + _local_9);
                        _local_8 = (_local_10 + _local_8);
                        _local_8 = li32(_local_8 + -4);
                        _local_9 = (_local_1 + 7);
                        if (!(_local_9 < _local_8)) goto _label_8;
                        _local_7 = (_local_7 + 1);
                        _local_1 = _local_9;
                    };
                    _local_8 = li32(_local_3 + 8);
                    if ((_local_8 > _local_7)) break;
                    
                _label_8: 
                    _local_3 = li32(_local_3 + 16);
                    _local_4 = (_local_2 + _local_4);
                    _local_3 = (_local_4 + _local_3);
                    _local_1 = (_local_1 * 86400);
                    _local_1 = (_local_3 + _local_1);
                    
                _label_9: 
                    mstate.eax = _local_1;
                    
                _label_10: 
                    mstate.esp = mstate.ebp;
                    mstate.ebp = li32(mstate.esp);
                    mstate.esp = (mstate.esp + 4);
                    mstate.esp = (mstate.esp + 4);
                    return;
                };
            } while (true);
            goto _label_7;
        }


    }
} cmodule.lua_wrapper

