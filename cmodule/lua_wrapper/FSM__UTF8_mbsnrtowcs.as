package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM__UTF8_mbsnrtowcs extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 4);
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(_local_1);
            _local_3 = li32(mstate.ebp + 24);
            _local_4 = li32(mstate.ebp + 8);
            _local_5 = li32(mstate.ebp + 16);
            _local_6 = li32(mstate.ebp + 20);
            _local_7 = _local_3;
            if (!(!(_local_4 == 0)))
            {
                if (!(_local_5 == 0))
                {
                    _local_1 = li32(_local_7 + 4);
                    if (!(_local_1 < 1))
                    {
                        _local_1 = li8(_local_2);
                        _local_1 = (_local_1 << 24);
                        _local_1 = (_local_1 >> 24);
                        if (!(_local_1 < 1))
                        {
                            
                        _label_1: 
                            _local_1 = 86;
                            si32(_local_1, _val_2E_1440);
                            
                        _label_2: 
                            _local_1 = -1;
                            goto _label_15;
                        };
                    };
                };
                if (_local_5 == 0) goto _label_13;
                _local_1 = 0;
                _local_4 = _local_5;
                do 
                {
                    _local_5 = li8(_local_2);
                    _local_5 = (_local_5 << 24);
                    _local_5 = (_local_5 >> 24);
                    if (_local_5 < 1) goto _label_14;
                    _local_5 = 1;
                    
                _label_3: 
                    _local_1 = (_local_1 + 1);
                    _local_6 = (_local_4 - _local_5);
                    _local_2 = (_local_2 + _local_5);
                    if ((_local_4 == _local_5)) break;
                    _local_4 = _local_6;
                } while (true);
                _local_4 = _local_6;
                goto _label_14;
            };
            _local_8 = ((_local_5 == 0) ? 1 : 0);
            if (!(_local_6 == 0))
            {
                _local_8 = (_local_8 ^ 0x01);
                _local_8 = (_local_8 & 0x01);
                if (!(_local_8 == 0)) goto _label_5;
            };
            
        _label_4: 
            _local_7 = 0;
            goto _label_8;
            
        _label_5: 
            _local_7 = li32(_local_7 + 4);
            if (_local_7 < 1) goto _label_4;
            _local_7 = li8(_local_2);
            _local_7 = (_local_7 << 24);
            _local_7 = (_local_7 >> 24);
            if (_local_7 < 1) goto _label_4;
            goto _label_1;
            do 
            {
                _local_11 = 0;
                _local_6 = (_local_2 + -1);
                _local_2 = _local_11;
                do 
                {
                    _local_11 = (_local_5 + _local_2);
                    _local_12 = _local_4;
                    if ((_local_8 == _local_2)) break;
                    _local_13 = li8(_local_11);
                    _local_14 = (_local_13 << 24);
                    _local_14 = (_local_14 >> 24);
                    if ((_local_14 < 1)) break;
                    _local_11 = (_local_13 << 24);
                    _local_11 = (_local_11 >> 24);
                    si32(_local_11, _local_12);
                    _local_4 = (_local_4 + 4);
                    _local_11 = (_local_2 + 1);
                    if (_local_6 == _local_2) goto _label_9;
                    _local_2 = _local_11;
                } while (true);
                mstate.esp = (mstate.esp - 16);
                _local_4 = (_local_8 - _local_2);
                si32(_local_12, mstate.esp);
                si32(_local_11, (mstate.esp + 4));
                si32(_local_4, (mstate.esp + 8));
                si32(_local_3, (mstate.esp + 12));
                mstate.esp = (mstate.esp - 4);
                FSM__UTF8_mbrtowc.start();
                _local_5 = mstate.eax;
                mstate.esp = (mstate.esp + 16);
                _local_10 = (_local_2 + _local_10);
                _local_6 = (_local_6 - _local_2);
                if (!(_local_5 == -2))
                {
                    if (_local_5 == 0) goto _label_6;
                    if (!(_local_5 == -1)) goto _label_7;
                    _local_2 = -1;
                    si32(_local_11, _local_1);
                    goto _label_11;
                };
                _local_2 = (_local_9 + _local_8);
                do 
                {
                    si32(_local_2, _local_1);
                    mstate.eax = _local_10;
                    goto _label_12;
                    
                _label_6: 
                    _local_2 = 0;
                } while (true);
                
            _label_7: 
                _local_8 = (_local_2 << 2);
                _local_7 = (_local_8 + _local_7);
                _local_2 = (_local_2 + _local_5);
                _local_8 = (_local_7 + 4);
                _local_7 = (_local_10 + 1);
                _local_4 = (_local_4 - _local_5);
                _local_2 = (_local_9 + _local_2);
                _local_5 = _local_4;
                _local_4 = _local_8;
                
            _label_8: 
                _local_10 = _local_7;
                _local_9 = _local_2;
                _local_2 = _local_6;
                _local_8 = _local_5;
                _local_7 = _local_4;
                _local_5 = _local_9;
                _local_4 = _local_7;
            } while ((!(_local_2 == 0)));
            _local_2 = _local_10;
            _local_4 = _local_9;
            goto _label_10;
            
        _label_9: 
            _local_2 = (_local_11 + _local_10);
            _local_4 = (_local_9 + _local_11);
            
        _label_10: 
            _local_3 = _local_4;
            si32(_local_3, _local_1);
            
        _label_11: 
            mstate.eax = _local_2;
            do 
            {
                
            _label_12: 
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
                
            _label_13: 
                _local_1 = 0;
                _local_4 = _local_5;
                
            _label_14: 
                _local_5 = (mstate.ebp + -4);
                mstate.esp = (mstate.esp - 16);
                si32(_local_5, mstate.esp);
                si32(_local_2, (mstate.esp + 4));
                si32(_local_4, (mstate.esp + 8));
                si32(_local_3, (mstate.esp + 12));
                mstate.esp = (mstate.esp - 4);
                FSM__UTF8_mbrtowc.start();
                _local_5 = mstate.eax;
                mstate.esp = (mstate.esp + 16);
                if (!(_local_5 == -2))
                {
                    if (_local_5 == -1) goto _label_2;
                    if (!(_local_5 == 0)) goto _label_3;
                };
                
            _label_15: 
                mstate.eax = _local_1;
            } while (true);
        }


    }
}

