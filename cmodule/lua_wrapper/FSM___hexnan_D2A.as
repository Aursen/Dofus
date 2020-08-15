package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___hexnan_D2A extends Machine 
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
            var _local_14:int;
            var _local_15:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = li8(___hexdig_D2A + 48);
            _local_5 = _local_3;
            if (!(!(_local_4 == 0)))
            {
                mstate.esp = (mstate.esp - 4);
                FSM___hexdig_init_D2A.start();
            };
            _local_2 = li32(_local_2);
            _local_4 = (_local_2 & 0x1F);
            _local_2 = (_local_2 >> 5);
            if (!(_local_4 == 0))
            {
                _local_6 = 0;
                _local_2 = (_local_2 << 2);
                _local_2 = (_local_3 + _local_2);
                si32(_local_6, _local_2);
                _local_6 = li32(_local_1);
                _local_7 = li8(_local_6 + 1);
                _local_8 = (_local_6 + 1);
                if (!(_local_7 == 0))
                {
                    _local_9 = 0;
                    _local_10 = _local_2;
                    _local_11 = _local_9;
                    _local_12 = _local_9;
                    _local_13 = _local_2;
                    
                _label_1: 
                    _local_14 = _local_9;
                    _local_15 = _local_8;
                    _local_8 = ___hexdig_D2A;
                    _local_9 = (_local_7 & 0xFF);
                    _local_8 = (_local_8 + _local_9);
                    _local_8 = li8(_local_8);
                    _local_9 = _local_2;
                    if (!(_local_8 == 0)) goto _label_8;
                    _local_8 = (_local_7 & 0xFF);
                    if (uint(_local_8) > uint(32)) goto _label_3;
                    if (_local_11 < _local_14) goto _label_2;
                    _local_8 = _local_10;
                    _local_9 = _local_11;
                    _local_10 = _local_12;
                    _local_6 = _local_14;
                    _local_7 = _local_15;
                    _local_11 = _local_13;
                    goto _label_9;
                };
                _local_1 = 0;
                _local_6 = _local_2;
                _local_7 = _local_1;
                _local_8 = _local_2;
                goto _label_10;
            };
            _local_6 = 0;
            _local_2 = (_local_2 << 2);
            _local_2 = (_local_2 + _local_3);
            si32(_local_6, (_local_2 + -4));
            _local_7 = li32(_local_1);
            _local_2 = (_local_2 + -4);
            _local_8 = _local_2;
            _local_9 = _local_6;
            _local_10 = _local_6;
            _local_11 = _local_2;
            goto _label_9;
            
        _label_2: 
            if (!(uint(_local_2) >= uint(_local_13)))
            {
                if (!(_local_12 > 7))
                {
                    _local_6 = (8 - _local_12);
                    _local_6 = (_local_6 << 2);
                    _local_7 = (32 - _local_6);
                    _local_8 = _local_9;
                    do 
                    {
                        _local_9 = li32(_local_8 + 4);
                        _local_12 = li32(_local_8);
                        _local_9 = (_local_9 << _local_7);
                        _local_9 = (_local_9 | _local_12);
                        si32(_local_9, _local_8);
                        _local_9 = li32(_local_8 + 4);
                        _local_9 = (_local_9 >>> _local_6);
                        si32(_local_9, (_local_8 + 4));
                        _local_8 = (_local_8 + 4);
                    } while (!(uint(_local_8) >= uint(_local_13)));
                };
            };
            if (!(uint(_local_2) > uint(_local_3)))
            {
                _local_6 = 8;
                _local_8 = _local_10;
                _local_9 = _local_11;
                _local_10 = _local_6;
                _local_6 = _local_14;
                _local_7 = _local_15;
                _local_11 = _local_13;
            }
            else
            {
                _local_6 = 0;
                si32(_local_6, (_local_2 + -4));
                _local_2 = (_local_2 + -4);
                _local_8 = _local_10;
                _local_9 = _local_14;
                _local_10 = _local_6;
                _local_6 = _local_14;
                _local_7 = _local_15;
                _local_11 = _local_2;
                goto _label_9;
                
            _label_3: 
                _local_8 = (_local_7 & 0xFF);
                if (!(!(_local_8 == 41)))
                {
                    if (!(_local_14 == 0)) goto _label_7;
                };
                
            _label_4: 
                _local_2 = 4;
                
            _label_5: 
                _local_1 = _local_2;
                mstate.eax = _local_1;
                
            _label_6: 
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
                
            _label_7: 
                _local_8 = (_local_6 + 2);
                si32(_local_8, _local_1);
                if (_local_14 == 0) goto _label_4;
                _local_8 = _local_10;
                _local_6 = _local_12;
                _local_7 = _local_13;
                goto _label_11;
                
            _label_8: 
                _local_6 = (_local_12 + 1);
                _local_7 = (_local_14 + 1);
                if ((_local_6 > 8))
                {
                    if (!(uint(_local_2) > uint(_local_3)))
                    {
                        _local_8 = _local_10;
                        _local_9 = _local_11;
                        _local_10 = _local_6;
                        _local_6 = _local_7;
                        _local_7 = _local_15;
                        _local_11 = _local_13;
                        goto _label_9;
                    };
                    _local_6 = 0;
                    si32(_local_6, (_local_2 + -4));
                    _local_6 = 1;
                    _local_2 = (_local_2 + -4);
                };
                _local_9 = li32(_local_2);
                _local_8 = (_local_8 & 0x0F);
                _local_9 = (_local_9 << 4);
                _local_8 = (_local_9 | _local_8);
                si32(_local_8, _local_2);
                _local_8 = _local_10;
                _local_9 = _local_11;
                _local_10 = _local_6;
                _local_6 = _local_7;
                _local_7 = _local_15;
                _local_11 = _local_13;
            };
            
        _label_9: 
            _local_12 = _local_10;
            _local_13 = _local_6;
            _local_6 = _local_7;
            _local_14 = _local_11;
            _local_7 = li8(_local_6 + 1);
            _local_15 = (_local_6 + 1);
            if (!(_local_7 == 0))
            {
                _local_10 = _local_8;
                _local_11 = _local_9;
                _local_9 = _local_13;
                _local_13 = _local_14;
                _local_8 = _local_15;
                goto _label_1;
            };
            _local_6 = _local_8;
            _local_7 = _local_12;
            _local_1 = _local_13;
            _local_8 = _local_14;
            
        _label_10: 
            _local_9 = _local_8;
            if (_local_1 == 0) goto _label_4;
            _local_8 = _local_6;
            _local_6 = _local_7;
            _local_7 = _local_9;
            
        _label_11: 
            _local_1 = _local_8;
            _local_8 = _local_1;
            _local_9 = _local_2;
            if (!(uint(_local_2) >= uint(_local_7)))
            {
                if (!(_local_6 > 7))
                {
                    _local_6 = (8 - _local_6);
                    _local_6 = (_local_6 << 2);
                    _local_10 = (32 - _local_6);
                    _local_11 = _local_9;
                    do 
                    {
                        _local_12 = li32(_local_11 + 4);
                        _local_13 = li32(_local_11);
                        _local_12 = (_local_12 << _local_10);
                        _local_12 = (_local_12 | _local_13);
                        si32(_local_12, _local_11);
                        _local_12 = li32(_local_11 + 4);
                        _local_12 = (_local_12 >>> _local_6);
                        si32(_local_12, (_local_11 + 4));
                        _local_11 = (_local_11 + 4);
                    } while (!(uint(_local_11) >= uint(_local_7)));
                };
            };
            if (!(uint(_local_2) <= uint(_local_3)))
            {
                _local_2 = 0;
                _local_4 = _local_2;
                do 
                {
                    _local_6 = (_local_9 + _local_4);
                    _local_6 = li32(_local_6);
                    _local_7 = (_local_5 + _local_4);
                    _local_4 = (_local_4 + 4);
                    si32(_local_6, _local_7);
                    _local_2 = (_local_2 + 1);
                    _local_6 = (_local_9 + _local_4);
                } while (!(uint(_local_6) > uint(_local_1)));
                _local_4 = 0;
                do 
                {
                    _local_5 = 0;
                    _local_6 = (_local_2 + _local_4);
                    _local_4 = (_local_4 + 1);
                    _local_6 = (_local_6 << 2);
                    _local_7 = (_local_2 + _local_4);
                    _local_6 = (_local_3 + _local_6);
                    si32(_local_5, _local_6);
                    _local_5 = (_local_7 << 2);
                    _local_5 = (_local_3 + _local_5);
                    if (uint(_local_5) > uint(_local_1)) goto _label_12;
                } while (true);
            };
            if (!(_local_4 == 0))
            {
                _local_2 = -1;
                _local_4 = (32 - _local_4);
                _local_5 = li32(_local_1);
                _local_2 = (_local_2 >>> _local_4);
                _local_2 = (_local_5 & _local_2);
                si32(_local_2, _local_1);
            };
            
        _label_12: 
            _local_2 = li32(_local_1);
            if (!(_local_2 == 0))
            {
                
            _label_13: 
                _local_1 = 5;
                _local_2 = _local_1;
                goto _label_5;
            };
            _local_2 = 0;
            _local_4 = _local_8;
            do 
            {
                _local_5 = _local_4;
                if (!(!(_local_4 == _local_3)))
                {
                    _local_2 = 1;
                    si32(_local_2, _local_5);
                    _local_2 = 5;
                    mstate.eax = _local_2;
                    goto _label_6;
                };
                _local_5 = (_local_2 ^ 0x3FFFFFFF);
                _local_5 = (_local_5 << 2);
                _local_5 = (_local_1 + _local_5);
                _local_5 = li32(_local_5);
                _local_4 = (_local_4 + -4);
                _local_2 = (_local_2 + 1);
                if (!(_local_5 == 0)) goto _label_13;
            } while (true);
        }


    }
}

