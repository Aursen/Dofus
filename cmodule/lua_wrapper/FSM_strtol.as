package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_strtol extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = 0;
            _local_2 = li32(__CurrentRuneLocale);
            _local_3 = li32(mstate.ebp + 8);
            _local_4 = _local_3;
            do 
            {
                _local_5 = (_local_4 + _local_1);
                _local_5 = li8(_local_5);
                _local_6 = (_local_5 << 2);
                _local_6 = (_local_2 + _local_6);
                _local_6 = li32(_local_6 + 52);
                _local_1 = (_local_1 + 1);
                _local_6 = (_local_6 & 0x4000);
            } while (!(_local_6 == 0));
            _local_2 = (_local_3 + _local_1);
            _local_4 = (_local_5 & 0xFF);
            if (!(_local_4 == 43))
            {
                _local_4 = (_local_5 & 0xFF);
                if (!(_local_4 == 45))
                {
                    _local_1 = 1;
                    _local_3 = _local_5;
                }
                else
                {
                    _local_4 = 0;
                    _local_1 = (_local_1 << 0);
                    _local_1 = (_local_1 + _local_3);
                    _local_3 = li8(_local_2);
                    _local_2 = (_local_1 + 1);
                    _local_1 = _local_4;
                };
            }
            else
            {
                _local_4 = 1;
                _local_1 = (_local_1 << 0);
                _local_1 = (_local_1 + _local_3);
                _local_3 = li8(_local_2);
                _local_2 = (_local_1 + 1);
                _local_1 = _local_4;
            };
            _local_4 = 0;
            _local_5 = (_local_1 & 0x01);
            _local_5 = ((_local_5 != 0) ? 2147483647 : -2147483648);
            _local_6 = int((uint(_local_5) / uint(10)));
            _local_7 = (_local_6 * 10);
            _local_7 = (_local_5 - _local_7);
            _local_8 = _local_4;
            do 
            {
                _local_9 = (_local_3 + -48);
                _local_9 = (_local_9 & 0xFF);
                if (!(uint(_local_9) < uint(10)))
                {
                    
                _label_1: 
                    _local_9 = (_local_3 + -65);
                    _local_9 = (_local_9 & 0xFF);
                    if (uint(_local_9) > uint(25)) goto _label_6;
                    _local_3 = (_local_3 + -55);
                    _local_9 = (_local_3 << 24);
                    _local_9 = (_local_9 >> 24);
                    if (_local_9 < 10) goto _label_5;
                    
                _label_2: 
                    _local_2 = _local_8;
                    _local_3 = _local_4;
                    goto _label_4;
                    
                _label_3: 
                    _local_9 = 1;
                    _local_8 = _local_3;
                    _local_3 = _local_4;
                    _local_4 = _local_9;
                };
                _local_3 = (_local_3 + -48);
                _local_9 = (_local_3 << 24);
                _local_9 = (_local_9 >> 24);
                if (!(_local_9 < 10))
                {
                    _local_2 = _local_8;
                    _local_3 = _local_4;
                    
                _label_4: 
                    if ((_local_3 > -1)) break;
                    _local_1 = 34;
                    si32(_local_1, _val_2E_1440);
                    mstate.eax = _local_5;
                    goto _label_9;
                };
                goto _label_7;
                
            _label_5: 
                goto _label_7;
                
            _label_6: 
                _local_9 = (_local_3 + -97);
                _local_9 = (_local_9 & 0xFF);
                if (uint(_local_9) > uint(25)) goto _label_2;
                _local_3 = (_local_3 + -87);
                _local_9 = (_local_3 << 24);
                _local_9 = (_local_9 >> 24);
                if (_local_9 > 9) goto _label_2;
                
            _label_7: 
                if (!(_local_4 < 0))
                {
                    if (!(uint(_local_8) > uint(_local_6)))
                    {
                        if (!(!(_local_8 == _local_6)))
                        {
                            _local_4 = (_local_3 << 24);
                            _local_4 = (_local_4 >> 24);
                            if (_local_4 > _local_7) goto _label_8;
                        };
                        _local_3 = (_local_3 << 24);
                        _local_3 = (_local_3 >> 24);
                        _local_8 = (_local_8 * 10);
                        _local_4 = li8(_local_2);
                        _local_2 = (_local_2 + 1);
                        _local_3 = (_local_8 + _local_3);
                        _local_8 = (_local_4 + -48);
                        _local_8 = (_local_8 & 0xFF);
                        if (uint(_local_8) < uint(10)) goto _label_3;
                        _local_9 = 1;
                        _local_8 = _local_3;
                        _local_3 = _local_4;
                        _local_4 = _local_9;
                        goto _label_1;
                    };
                };
                
            _label_8: 
                _local_4 = -1;
                _local_3 = li8(_local_2);
                _local_2 = (_local_2 + 1);
            } while (true);
            if (!(!(_local_3 == 0)))
            {
                _local_1 = 22;
                si32(_local_1, _val_2E_1440);
                mstate.eax = _local_2;
                
            _label_9: 
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
            };
            _local_1 = (_local_1 & 0x01);
            _local_3 = (0 - _local_2);
            _local_1 = ((_local_1 != 0) ? _local_2 : _local_3);
            mstate.eax = _local_1;
            goto _label_9;
        }


    }
} cmodule.lua_wrapper

