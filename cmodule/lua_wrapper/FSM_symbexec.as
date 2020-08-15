package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_symbexec extends Machine 
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
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            var _local_25:int;
            var _local_26:int;
            var _local_27:int;
            var _local_28:int;
            var _local_29:int;
            var _local_30:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(_local_1 + 44);
            _local_3 = li8(_local_1 + 75);
            _local_4 = (_local_2 + -1);
            _local_5 = li32(mstate.ebp + 12);
            _local_6 = li32(mstate.ebp + 16);
            if (!(uint(_local_3) > uint(250)))
            {
                _local_7 = li8(_local_1 + 74);
                _local_8 = li8(_local_1 + 73);
                _local_9 = (_local_7 & 0x01);
                _local_10 = _local_7;
                _local_11 = (_local_3 & 0xFF);
                _local_8 = (_local_9 + _local_8);
                if (!(_local_8 > _local_11))
                {
                    _local_7 = (_local_7 & 0x04);
                    if (!(!(_local_9 == 0)))
                    {
                        if (!(_local_7 == 0)) goto _label_25;
                    };
                    _local_7 = li32(_local_1 + 36);
                    _local_8 = li8(_local_1 + 72);
                    if (!(_local_7 > _local_8))
                    {
                        _local_7 = li32(_local_1 + 48);
                        _local_9 = ((_local_7 != 0) ? 1 : 0);
                        _local_7 = ((_local_7 != _local_2) ? 1 : 0);
                        _local_7 = (_local_7 & _local_9);
                        if (!(_local_2 < 1))
                        {
                            _local_7 = (_local_7 & 0x01);
                            if (!(!(_local_7 == 0)))
                            {
                                _local_7 = li32(_local_1 + 12);
                                _local_9 = (_local_4 << 2);
                                _local_9 = (_local_7 + _local_9);
                                _local_9 = li32(_local_9);
                                _local_11 = _local_7;
                                _local_9 = (_local_9 & 0x3F);
                                if (!(!(_local_9 == 30)))
                                {
                                    _local_9 = 0;
                                    _local_12 = (_local_1 + 16);
                                    _local_13 = (_local_1 + 52);
                                    _local_14 = (_local_1 + 8);
                                    _local_15 = (_local_1 + 40);
                                    while ((_local_19 = _local_4), (_local_17 = _local_9), (_local_17 < _local_5))
                                    {
                                        _local_18 = 0;
                                        _local_4 = (_local_17 << 2);
                                        _local_20 = (_local_7 + _local_4);
                                        _local_9 = (_local_17 + 2);
                                        _local_16 = (_local_17 + -131070);
                                        _local_4 = (_local_17 + -131071);
                                        do 
                                        {
                                            _local_21 = li32(_local_20);
                                            _local_22 = (_local_21 >>> 6);
                                            _local_22 = (_local_22 & 0xFF);
                                            _local_23 = (_local_21 & 0x3F);
                                            _local_24 = (_local_17 + _local_18);
                                            if (uint(_local_23) > uint(37)) goto _label_25;
                                            _local_25 = (_local_3 & 0xFF);
                                            if (_local_25 <= _local_22) goto _label_25;
                                            _local_25 = _luaP_opmodes;
                                            _local_25 = (_local_25 + _local_23);
                                            _local_25 = li8(_local_25);
                                            _local_26 = (_local_25 & 0x03);
                                            if ((_local_26 == 0)) break;
                                            if (_local_26 == 1) goto _label_2;
                                            if (_local_26 == 2) goto _label_4;
                                            _local_21 = 0;
                                            _local_26 = _local_21;
                                            
                                        _label_1: 
                                            _local_27 = (_local_25 << 24);
                                            _local_27 = (_local_27 >> 24);
                                            if (!(_local_27 > -1))
                                            {
                                                _local_27 = (_local_9 + _local_18);
                                                if (_local_27 >= _local_2) goto _label_25;
                                                _local_27 = li32(_local_20 + 4);
                                                _local_27 = (_local_27 & 0x3F);
                                                if (!(_local_27 == 22)) goto _label_25;
                                            };
                                            if (_local_23 > 21) goto _label_10;
                                            if (_local_23 > 6) goto _label_8;
                                            if (_local_23 > 3) goto _label_6;
                                            if (_local_23 == 2) goto _label_11;
                                            if (!(_local_23 == 3)) goto _label_20;
                                            if (_local_26 < _local_6) goto _label_20;
                                            if (_local_22 > _local_6) goto _label_20;
                                            _local_19 = (_local_18 + 1);
                                            _local_20 = (_local_20 + 4);
                                            _local_21 = (_local_17 + _local_18);
                                            _local_18 = (_local_17 + _local_19);
                                            if (_local_18 >= _local_5) goto _label_22;
                                            _local_18 = _local_19;
                                            _local_19 = _local_21;
                                        } while (true);
                                        _local_26 = (_local_25 >>> 4);
                                        mstate.esp = (mstate.esp - 12);
                                        _local_26 = (_local_26 & 0x03);
                                        _local_27 = (_local_21 >>> 23);
                                        si32(_local_1, mstate.esp);
                                        si32(_local_27, (mstate.esp + 4));
                                        si32(_local_26, (mstate.esp + 8));
                                        mstate.esp = (mstate.esp - 4);
                                        FSM_checkArgMode.start();
                                        _local_26 = mstate.eax;
                                        _local_21 = (_local_21 >>> 14);
                                        mstate.esp = (mstate.esp + 12);
                                        _local_21 = (_local_21 & 0x01FF);
                                        if (_local_26 == 0) goto _label_25;
                                        _local_26 = (_local_25 >>> 2);
                                        mstate.esp = (mstate.esp - 12);
                                        _local_26 = (_local_26 & 0x03);
                                        si32(_local_1, mstate.esp);
                                        si32(_local_21, (mstate.esp + 4));
                                        si32(_local_26, (mstate.esp + 8));
                                        mstate.esp = (mstate.esp - 4);
                                        FSM_checkArgMode.start();
                                        _local_26 = mstate.eax;
                                        mstate.esp = (mstate.esp + 12);
                                        if (_local_26 == 0) goto _label_25;
                                        _local_26 = _local_27;
                                        goto _label_1;
                                        
                                    _label_2: 
                                        _local_26 = (_local_25 >>> 4);
                                        _local_21 = (_local_21 >>> 14);
                                        _local_26 = (_local_26 & 0x03);
                                        if (_local_26 == 3) goto _label_24;
                                        
                                    _label_3: 
                                        _local_27 = 0;
                                        _local_26 = _local_21;
                                        _local_21 = _local_27;
                                        goto _label_1;
                                        
                                    _label_4: 
                                        _local_21 = (_local_21 >>> 14);
                                        _local_26 = (_local_21 + -131071);
                                        _local_27 = (_local_25 >>> 4);
                                        _local_27 = (_local_27 & 0x03);
                                        if (!(_local_27 == 2))
                                        {
                                            
                                        _label_5: 
                                            _local_21 = 0;
                                            goto _label_1;
                                        };
                                        _local_27 = (_local_16 + _local_18);
                                        _local_27 = ((_local_21 = (_local_29 = _local_21)) + _local_27);
                                        if (_local_2 <= _local_27) goto _label_25;
                                        if (_local_27 < 0) goto _label_25;
                                        if (_local_27 < 1) goto _label_5;
                                        _local_28 = 0;
                                        _local_29 = (_local_4 + _local_18);
                                        _local_21 = (_local_21 + _local_29);
                                        _local_21 = (_local_21 << 2);
                                        _local_21 = (_local_7 + _local_21);
                                        while ((_local_28 < _local_27))
                                        {
                                            _local_21 = li32(_local_21);
                                            _local_30 = (_local_21 & 0x3F);
                                            if ((!(_local_30 == 34))) break;
                                            _local_21 = (_local_21 & 0x7FC000);
                                            if ((!(_local_21 == 0))) break;
                                            _local_21 = (_local_29 + -4);
                                            _local_28 = (_local_28 + 1);
                                        };
                                        _local_21 = (_local_28 & 0x01);
                                        if (_local_21 == 0) goto _label_5;
                                        goto _label_25;
                                        
                                    _label_6: 
                                        if (!(_local_23 == 4))
                                        {
                                            if (!(_local_23 == 5))
                                            {
                                                goto _label_20;
                                            };
                                            
                                        _label_7: 
                                            _local_4 = (_local_25 & 0x40);
                                            _local_9 = li32(_local_14);
                                            _local_16 = (_local_26 * 12);
                                            _local_4 = ((_local_4 != 0) ? 1 : 0);
                                            _local_20 = ((_local_22 == _local_6) ? 1 : 0);
                                            _local_4 = (_local_4 & _local_20);
                                            _local_9 = (_local_9 + _local_16);
                                            _local_9 = li32(_local_9 + 8);
                                            _local_4 = (_local_4 & 0x01);
                                            _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                            if (!(_local_9 == 4)) goto _label_25;
                                            _local_9 = (_local_17 + _local_18);
                                            goto _label_21;
                                            
                                        _label_8: 
                                            if (_local_23 > 10) goto _label_9;
                                            if (_local_23 == 7) goto _label_7;
                                            if (!(_local_23 == 8)) goto _label_20;
                                        };
                                        _local_4 = (_local_25 & 0x40);
                                        _local_4 = ((_local_4 != 0) ? 1 : 0);
                                        _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                        _local_4 = (_local_4 & _local_9);
                                        _local_4 = (_local_4 & 0x01);
                                        _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                        _local_9 = (_local_8 & 0xFF);
                                        if (_local_9 <= _local_26) goto _label_25;
                                        _local_9 = (_local_17 + _local_18);
                                        goto _label_21;
                                        
                                    _label_9: 
                                        if (!(_local_23 == 11))
                                        {
                                            if (!(_local_23 == 21)) goto _label_20;
                                            _local_4 = (_local_25 & 0x40);
                                            _local_4 = ((_local_4 != 0) ? 1 : 0);
                                            _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                            _local_4 = (_local_4 & _local_9);
                                            _local_4 = (_local_4 & 0x01);
                                            _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                            if (_local_26 >= _local_21) goto _label_25;
                                            _local_9 = (_local_17 + _local_18);
                                            goto _label_21;
                                            
                                        _label_10: 
                                            if (!(_local_23 > 32))
                                            {
                                                if (!(_local_23 > 29))
                                                {
                                                    if (_local_23 == 22) goto _label_13;
                                                    _local_4 = (_local_23 + -28);
                                                    if (!(uint(_local_4) < uint(2))) goto _label_20;
                                                    _local_4 = (_local_25 & 0x40);
                                                    _local_4 = ((_local_4 != 0) ? 1 : 0);
                                                    _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                                    _local_4 = (_local_4 & _local_9);
                                                    _local_4 = (_local_4 & 0x01);
                                                    _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                                    if (!(_local_26 == 0))
                                                    {
                                                        _local_9 = (_local_22 + _local_26);
                                                        _local_9 = (_local_9 + -1);
                                                        _local_19 = (_local_3 & 0xFF);
                                                        if (_local_9 >= _local_19) goto _label_25;
                                                    };
                                                    _local_9 = (_local_21 + -1);
                                                    if (!(_local_21 == 0)) goto _label_15;
                                                    _local_9 = 1;
                                                    _local_19 = (_local_24 << 2);
                                                    _local_19 = (_local_19 + _local_11);
                                                    _local_19 = li32(_local_19 + 4);
                                                    _local_16 = (_local_19 & 0x3F);
                                                    _local_16 = (_local_16 + -28);
                                                    _local_9 = (_local_9 << _local_16);
                                                    if (uint(_local_16) > uint(6)) goto _label_25;
                                                    _local_9 = (_local_9 & 0x47);
                                                    if (!(!(_local_9 == 0))) goto _label_25;
                                                    if (uint(_local_19) > uint(8388607)) goto _label_25;
                                                    goto _label_16;
                                                };
                                                if (_local_23 == 30) goto _label_17;
                                                _local_4 = (_local_23 + -31);
                                                if (!(uint(_local_4) < uint(2))) goto _label_20;
                                                _local_4 = (_local_25 & 0x40);
                                                _local_4 = ((_local_4 != 0) ? 1 : 0);
                                                _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                                _local_4 = (_local_4 & _local_9);
                                                _local_4 = (_local_4 & 0x01);
                                                _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                                _local_9 = (_local_3 & 0xFF);
                                                _local_19 = (_local_22 + 3);
                                                if (_local_19 >= _local_9) goto _label_25;
                                                goto _label_14;
                                            };
                                            if (!(_local_23 > 35))
                                            {
                                                if (_local_23 == 33) goto _label_12;
                                                if (!(_local_23 == 34)) goto _label_20;
                                                _local_4 = (_local_25 & 0x40);
                                                _local_4 = ((_local_4 != 0) ? 1 : 0);
                                                _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                                _local_4 = (_local_4 & _local_9);
                                                _local_4 = (_local_4 & 0x01);
                                                _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                                if (!(_local_26 < 1))
                                                {
                                                    _local_9 = (_local_3 & 0xFF);
                                                    _local_19 = (_local_26 + _local_22);
                                                    if (_local_19 >= _local_9) goto _label_25;
                                                };
                                                if (_local_21 == 0) goto _label_18;
                                                _local_9 = (_local_17 + _local_18);
                                                goto _label_21;
                                            };
                                            if (_local_23 == 36) goto _label_19;
                                            if (!(_local_23 == 37)) goto _label_20;
                                            _local_4 = (_local_25 & 0x40);
                                            _local_4 = ((_local_4 != 0) ? 1 : 0);
                                            _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                            _local_4 = (_local_4 & _local_9);
                                            _local_4 = (_local_4 & 0x01);
                                            _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                            _local_9 = (_local_10 & 0xFF);
                                            _local_19 = (_local_10 & 0x02);
                                            if (_local_19 == 0) goto _label_25;
                                            _local_9 = (_local_9 & 0x04);
                                            if (!(_local_9 == 0)) goto _label_25;
                                            _local_9 = (_local_26 + -1);
                                            if (!(!(_local_26 == 0)))
                                            {
                                                _local_19 = 1;
                                                _local_16 = (_local_24 << 2);
                                                _local_16 = (_local_16 + _local_11);
                                                _local_16 = li32(_local_16 + 4);
                                                _local_20 = (_local_16 & 0x3F);
                                                _local_20 = (_local_20 + -28);
                                                _local_19 = (_local_19 << _local_20);
                                                if (uint(_local_20) > uint(6)) goto _label_25;
                                                _local_19 = (_local_19 & 0x47);
                                                if (!(!(_local_19 == 0))) goto _label_25;
                                                if (uint(_local_16) > uint(8388607)) goto _label_25;
                                            };
                                            _local_9 = (_local_22 + _local_9);
                                            _local_9 = (_local_9 + -1);
                                            _local_19 = (_local_3 & 0xFF);
                                            if (_local_9 >= _local_19) goto _label_25;
                                            _local_9 = (_local_17 + _local_18);
                                            goto _label_21;
                                            
                                        _label_11: 
                                            _local_4 = (_local_25 & 0x40);
                                            _local_4 = ((_local_4 != 0) ? 1 : 0);
                                            _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                            _local_4 = (_local_4 & _local_9);
                                            _local_4 = (_local_4 & 0x01);
                                            _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                            if (!(_local_21 == 1))
                                            {
                                                _local_9 = (_local_17 + _local_18);
                                                goto _label_21;
                                            };
                                            _local_9 = (_local_24 + 2);
                                            if (_local_9 >= _local_2) goto _label_25;
                                            _local_9 = (_local_24 << 2);
                                            _local_9 = (_local_9 + _local_11);
                                            _local_9 = li32(_local_9 + 4);
                                            _local_19 = (_local_9 & 0x3F);
                                            if (!(_local_19 == 34))
                                            {
                                                _local_9 = (_local_17 + _local_18);
                                                goto _label_21;
                                            };
                                            _local_9 = (_local_9 & 0x7FC000);
                                            if (_local_9 == 0) goto _label_25;
                                            _local_9 = (_local_17 + _local_18);
                                            goto _label_21;
                                        };
                                        _local_4 = (_local_25 & 0x40);
                                        _local_4 = ((_local_4 != 0) ? 1 : 0);
                                        _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                        _local_4 = (_local_4 & _local_9);
                                        _local_4 = (_local_4 & 0x01);
                                        _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                        _local_9 = (_local_22 + 1);
                                        _local_19 = (_local_3 & 0xFF);
                                        if (_local_9 >= _local_19) goto _label_25;
                                        if (!(_local_9 == _local_6))
                                        {
                                            _local_9 = (_local_17 + _local_18);
                                        }
                                        else
                                        {
                                            _local_4 = (_local_17 + _local_18);
                                            _local_9 = (_local_24 + 1);
                                            continue;
                                            
                                        _label_12: 
                                            _local_4 = (_local_25 & 0x40);
                                            _local_4 = ((_local_4 != 0) ? 1 : 0);
                                            _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                            _local_4 = (_local_4 & _local_9);
                                            _local_4 = (_local_4 & 0x01);
                                            _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                            if (_local_21 < 1) goto _label_25;
                                            _local_9 = (_local_22 + 2);
                                            _local_19 = (_local_3 & 0xFF);
                                            _local_16 = (_local_9 + _local_21);
                                            if (_local_16 >= _local_19) goto _label_25;
                                            if (!(_local_9 <= _local_6))
                                            {
                                                _local_9 = (_local_17 + _local_18);
                                            }
                                            else
                                            {
                                                _local_4 = (_local_17 + _local_18);
                                                _local_9 = (_local_24 + 1);
                                                continue;
                                                
                                            _label_13: 
                                                _local_4 = (_local_25 & 0x40);
                                                _local_4 = ((_local_4 != 0) ? 1 : 0);
                                                _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                                _local_4 = (_local_4 & _local_9);
                                                _local_4 = (_local_4 & 0x01);
                                                _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                                
                                            _label_14: 
                                                _local_9 = (_local_24 + _local_26);
                                                _local_9 = (_local_9 + 1);
                                                _local_19 = ((_local_6 == 0xFF) ? 1 : 0);
                                                _local_16 = ((_local_24 >= _local_9) ? 1 : 0);
                                                _local_19 = (_local_16 | _local_19);
                                                if (!(_local_9 > _local_5))
                                                {
                                                    _local_19 = (_local_19 & 0x01);
                                                    if (!(!(_local_19 == 0))) continue;
                                                };
                                                _local_9 = (_local_17 + _local_18);
                                                goto _label_21;
                                                
                                            _label_15: 
                                                if (!(_local_21 == 1))
                                                {
                                                    _local_9 = (_local_22 + _local_9);
                                                    _local_9 = (_local_9 + -1);
                                                    _local_19 = (_local_3 & 0xFF);
                                                    if (_local_9 >= _local_19) goto _label_25;
                                                };
                                                
                                            _label_16: 
                                                if (!(_local_22 <= _local_6))
                                                {
                                                    _local_9 = (_local_17 + _local_18);
                                                }
                                                else
                                                {
                                                    _local_4 = (_local_17 + _local_18);
                                                    _local_9 = (_local_24 + 1);
                                                    continue;
                                                    
                                                _label_17: 
                                                    _local_4 = (_local_25 & 0x40);
                                                    _local_4 = ((_local_4 != 0) ? 1 : 0);
                                                    _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                                    _local_4 = (_local_4 & _local_9);
                                                    _local_4 = (_local_4 & 0x01);
                                                    _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                                    _local_9 = (_local_26 + -1);
                                                    if (!(_local_9 > 0))
                                                    {
                                                        _local_9 = (_local_17 + _local_18);
                                                    }
                                                    else
                                                    {
                                                        _local_9 = (_local_22 + _local_9);
                                                        _local_9 = (_local_9 + -1);
                                                        _local_19 = (_local_3 & 0xFF);
                                                        if (_local_9 >= _local_19) goto _label_25;
                                                        _local_9 = (_local_17 + _local_18);
                                                        goto _label_21;
                                                        
                                                    _label_18: 
                                                        _local_9 = (_local_24 + 1);
                                                        _local_19 = (_local_2 + -1);
                                                        if (_local_19 <= _local_9) goto _label_25;
                                                        goto _label_21;
                                                        
                                                    _label_19: 
                                                        _local_4 = (_local_25 & 0x40);
                                                        _local_4 = ((_local_4 != 0) ? 1 : 0);
                                                        _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                                        _local_4 = (_local_4 & _local_9);
                                                        _local_4 = (_local_4 & 0x01);
                                                        _local_9 = li32(_local_13);
                                                        _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                                        if (_local_9 <= _local_26) goto _label_25;
                                                        _local_9 = li32(_local_12);
                                                        _local_19 = (_local_26 << 2);
                                                        _local_9 = (_local_9 + _local_19);
                                                        _local_9 = li32(_local_9);
                                                        _local_9 = li8(_local_9 + 72);
                                                        _local_19 = (_local_9 + _local_24);
                                                        if (_local_19 >= _local_2) goto _label_25;
                                                        _local_19 = 1;
                                                        _local_16 = (_local_17 << 2);
                                                        _local_20 = (_local_18 << 2);
                                                        _local_16 = (_local_7 + _local_16);
                                                        _local_16 = (_local_16 + _local_20);
                                                        _local_16 = (_local_16 + 4);
                                                        while ((_local_19 = (_local_20 = _local_16)), ((_local_16 = _local_19) <= _local_9))
                                                        {
                                                            _local_19 = li32(_local_19);
                                                            _local_19 = (_local_19 & 0x3F);
                                                            if (!(_local_19 == 0))
                                                            {
                                                                if (!(_local_19 == 4)) goto _label_25;
                                                            };
                                                            _local_19 = (_local_20 + 4);
                                                            _local_20 = (_local_16 + 1);
                                                            _local_16 = _local_19;
                                                            _local_19 = _local_20;
                                                        };
                                                        if (!(!(_local_6 == 0xFF)))
                                                        {
                                                            _local_9 = (_local_17 + _local_18);
                                                        }
                                                        else
                                                        {
                                                            _local_9 = (_local_24 + _local_9);
                                                            _local_9 = (_local_9 + 1);
                                                            continue;
                                                            
                                                        _label_20: 
                                                            _local_4 = (_local_25 & 0x40);
                                                            _local_4 = ((_local_4 != 0) ? 1 : 0);
                                                            _local_9 = ((_local_22 == _local_6) ? 1 : 0);
                                                            _local_4 = (_local_4 & _local_9);
                                                            _local_4 = (_local_4 & 0x01);
                                                            _local_4 = ((_local_4 != 0) ? _local_24 : _local_19);
                                                            _local_9 = (_local_17 + _local_18);
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                        
                                    _label_21: 
                                        _local_9 = (_local_9 + 1);
                                    };
                                    goto _label_23;
                                    
                                _label_22: 
                                    _local_19 = (_local_17 + _local_19);
                                    _local_19 = (_local_19 + -1);
                                    
                                _label_23: 
                                    _local_1 = _local_19;
                                    _local_1 = (_local_1 << 2);
                                    _local_1 = (_local_11 + _local_1);
                                    _local_1 = li32(_local_1);
                                    goto _label_26;
                                    
                                _label_24: 
                                    _local_26 = li32(_local_15);
                                    if (_local_26 > _local_21) goto _label_3;
                                };
                            };
                        };
                    };
                };
            };
            
        _label_25: 
            _local_1 = 0;
            
        _label_26: 
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

