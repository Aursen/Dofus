package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaO_chunkid extends Machine 
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
            mstate.esp = (mstate.esp - 32);
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li8(_local_1);
            _local_3 = li32(mstate.ebp + 8);
            _local_4 = li32(mstate.ebp + 16);
            _local_5 = _local_3;
            _local_6 = _local_1;
            if (!(_local_2 == 64))
            {
                _local_7 = (_local_2 & 0xFF);
                if (!(_local_7 == 61))
                {
                    _local_7 = (_local_2 & 0xFF);
                    if (!(_local_7 == 0)) goto _label_4;
                    _local_2 = 0;
                    goto _label_6;
                };
                if (_local_4 == 0) goto _label_2;
                _local_2 = 0;
                _local_1 = _local_4;
                do 
                {
                    _local_7 = (_local_6 + _local_2);
                    _local_7 = li8(_local_7 + 1);
                    _local_8 = (_local_5 + _local_2);
                    si8(_local_7, _local_8);
                    _local_8 = (_local_2 + 1);
                    if ((_local_7 == 0))
                    {
                        if (_local_1 == 1) goto _label_2;
                        _local_2 = 0;
                        do 
                        {
                            _local_5 = 0;
                            _local_6 = (_local_8 + _local_2);
                            _local_6 = (_local_3 + _local_6);
                            si8(_local_5, _local_6);
                            _local_5 = (_local_2 + 1);
                            _local_2 = (_local_1 - _local_2);
                            if (_local_2 == 2) goto _label_2;
                            _local_2 = _local_5;
                        } while (true);
                    };
                    _local_7 = (_local_1 + -1);
                    _local_2 = (_local_2 + 1);
                    if (_local_1 == 1) goto _label_2;
                    _local_1 = _local_7;
                } while (true);
            };
            _local_2 = li8(_local_1 + 1);
            _local_7 = (_local_4 + -8);
            _local_1 = (_local_1 + 1);
            if (!(_local_2 == 0))
            {
                _local_2 = _local_6;
                do 
                {
                    _local_8 = li8(_local_2 + 2);
                    _local_2 = (_local_2 + 1);
                } while (!(_local_8 == 0));
                _local_2 = (_local_2 + 1);
                
            _label_1: 
                _local_8 = 0;
                si8(_local_8, _local_3);
                _local_8 = _local_1;
                _local_9 = _local_2;
                _local_2 = (_local_2 - _local_1);
                if (!(uint(_local_2) > uint(_local_7)))
                {
                    _local_2 = 0;
                    do 
                    {
                        _local_1 = (_local_6 + _local_2);
                        _local_1 = li8(_local_1 + 1);
                        _local_3 = (_local_5 + _local_2);
                        si8(_local_1, _local_3);
                        _local_2 = (_local_2 + 1);
                        //unresolved if
                    } while (true);
                };
                _local_2 = 46;
                _local_1 = 0;
                si8(_local_2, _local_3);
                si8(_local_2, (_local_3 + 1));
                si8(_local_2, (_local_3 + 2));
                si8(_local_1, (_local_3 + 3));
                _local_2 = li8(_local_3);
                if (_local_2 == 0) goto _label_13;
                _local_2 = _local_5;
                do 
                {
                    _local_1 = li8(_local_2 + 1);
                    _local_2 = (_local_2 + 1);
                    _local_3 = _local_2;
                    if (_local_1 == 0) goto _label_14;
                    _local_2 = _local_3;
                } while (true);
                
            _label_2: 
                _local_2 = 0;
                _local_1 = (_local_4 + _local_3);
                si8(_local_2, (_local_1 + -1));
                do 
                {
                    
                _label_3: 
                    mstate.esp = mstate.ebp;
                    mstate.ebp = li32(mstate.esp);
                    mstate.esp = (mstate.esp + 4);
                    mstate.esp = (mstate.esp + 4);
                    return;
                    
                _label_4: 
                    _local_7 = 1;
                    si32(_local_7, (mstate.ebp + -32));
                    _local_7 = 0;
                    si32(_local_7, (mstate.ebp + -28));
                    si32(_local_7, (mstate.ebp + -24));
                    si32(_local_7, (mstate.ebp + -20));
                    si32(_local_7, (mstate.ebp + -16));
                    si32(_local_7, (mstate.ebp + -12));
                    si32(_local_7, (mstate.ebp + -8));
                    si32(_local_7, (mstate.ebp + -4));
                    _local_7 = __2E_str655308;
                    do 
                    {
                        _local_8 = (mstate.ebp + -32);
                        _local_9 = li8(_local_7);
                        _local_10 = (_local_9 & 0xE0);
                        _local_10 = (_local_10 >>> 3);
                        _local_8 = (_local_8 + _local_10);
                        _local_10 = 1;
                        _local_9 = (_local_9 & 0x1F);
                        _local_11 = li32(_local_8);
                        _local_9 = (_local_10 << _local_9);
                        _local_9 = (_local_9 | _local_11);
                        si32(_local_9, _local_8);
                        _local_8 = li8(_local_7 + 1);
                        _local_7 = (_local_7 + 1);
                    } while (!(_local_8 == 0));
                    _local_7 = (mstate.ebp + -32);
                    _local_8 = (_local_2 & 0xE0);
                    _local_8 = (_local_8 >>> 3);
                    _local_7 = (_local_7 + _local_8);
                    _local_8 = 1;
                    _local_2 = (_local_2 & 0x1F);
                    _local_7 = li32(_local_7);
                    _local_2 = (_local_8 << _local_2);
                    _local_2 = (_local_2 & _local_7);
                    if (!(_local_2 == 0))
                    {
                        _local_2 = _local_1;
                    }
                    else
                    {
                        _local_2 = _local_6;
                        
                    _label_5: 
                        _local_7 = (mstate.ebp + -32);
                        _local_8 = li8(_local_2 + 1);
                        _local_9 = (_local_8 & 0xE0);
                        _local_9 = (_local_9 >>> 3);
                        _local_7 = (_local_7 + _local_9);
                        _local_7 = li32(_local_7);
                        _local_2 = (_local_2 + 1);
                        _local_8 = (_local_8 & 0x1F);
                        _local_9 = 1;
                        _local_8 = (_local_9 << _local_8);
                        _local_9 = _local_2;
                        _local_7 = (_local_8 & _local_7);
                        if (_local_7 == 0) goto _label_15;
                    };
                    _local_2 = (_local_2 - _local_6);
                    
                _label_6: 
                    _local_7 = __2E_str756;
                    _local_8 = _local_3;
                    _local_9 = 10;
                    _local_4 = (_local_4 + -17);
                    _local_2 = ((uint(_local_2) > uint(_local_4)) ? _local_4 : _local_2);
                    memcpy(_local_8, _local_7, _local_9);
                    _local_1 = (_local_1 + _local_2);
                    _local_1 = li8(_local_1);
                    if ((_local_1 == 0)) break;
                    if (!(_local_2 == 0))
                    {
                        _local_1 = li8(_local_3);
                        if (_local_1 == 0) goto _label_16;
                        _local_1 = _local_5;
                        do 
                        {
                            _local_4 = li8(_local_1 + 1);
                            _local_1 = (_local_1 + 1);
                            _local_7 = _local_1;
                            if (_local_4 == 0) goto _label_17;
                            _local_1 = _local_7;
                        } while (true);
                        
                    _label_7: 
                        _local_1 = (_local_1 + _local_4);
                        goto _label_9;
                        
                    _label_8: 
                        _local_1 = (_local_1 + _local_4);
                        
                    _label_9: 
                        _local_6 = _local_1;
                        _local_1 = 0;
                        si8(_local_1, _local_6);
                    };
                    _local_6 = li8(_local_3);
                    if (_local_6 == 0) goto _label_18;
                    _local_6 = _local_5;
                    do 
                    {
                        _local_1 = li8(_local_6 + 1);
                        _local_6 = (_local_6 + 1);
                        _local_2 = _local_6;
                        if (_local_1 == 0) goto _label_19;
                        _local_6 = _local_2;
                    } while (true);
                    
                _label_10: 
                    _local_5 = _local_3;
                    
                _label_11: 
                    _local_6 = 34;
                    _local_5 = (_local_5 - _local_1);
                    _local_1 = 93;
                    _local_2 = 0;
                    _local_3 = (_local_3 + _local_5);
                    si8(_local_6, _local_3);
                    si8(_local_1, (_local_3 + 1));
                    si8(_local_2, (_local_3 + 2));
                    continue;
                } while (true);
                _local_1 = li8(_local_3);
                if (_local_1 == 0) goto _label_20;
                _local_1 = _local_5;
                do 
                {
                    _local_2 = li8(_local_1 + 1);
                    _local_1 = (_local_1 + 1);
                    _local_4 = _local_1;
                    if (_local_2 == 0) goto _label_21;
                    _local_1 = _local_4;
                } while (true);
                
            _label_12: 
                _local_1 = li8(_local_3);
                if (_local_1 == 0) goto _label_22;
                _local_1 = _local_5;
                do 
                {
                    _local_2 = li8(_local_1 + 1);
                    _local_1 = (_local_1 + 1);
                    _local_4 = _local_1;
                    if (_local_2 == 0) goto _label_23;
                    _local_1 = _local_4;
                } while (true);
            };
            _local_2 = _local_1;
            goto _label_1;
            
        _label_13: 
            _local_2 = _local_3;
            
        _label_14: 
            _local_1 = 0;
            _local_3 = (_local_8 + _local_4);
            _local_4 = (_local_9 + _local_6);
            _local_3 = (_local_4 - _local_3);
            do 
            {
                _local_4 = (_local_3 + _local_1);
                _local_4 = li8(_local_4 + 9);
                _local_5 = (_local_2 + _local_1);
                si8(_local_4, _local_5);
                _local_1 = (_local_1 + 1);
                if (_local_4 == 0) goto _label_3;
            } while (true);
            
        _label_15: 
            _local_2 = _local_9;
            goto _label_5;
            
        _label_16: 
            _local_1 = _local_3;
            
        _label_17: 
            _local_4 = 0;
            _local_2 = (_local_2 + 1);
            do 
            {
                _local_7 = (_local_6 + _local_4);
                _local_7 = li8(_local_7);
                _local_8 = (_local_1 + _local_4);
                si8(_local_7, _local_8);
                if (_local_7 == 0) goto _label_8;
                _local_2 = (_local_2 + -1);
                _local_4 = (_local_4 + 1);
                if (_local_2 == 1) goto _label_7;
            } while (true);
            
        _label_18: 
            _local_6 = _local_3;
            
        _label_19: 
            _local_1 = 46;
            _local_2 = 0;
            si8(_local_1, _local_6);
            si8(_local_1, (_local_6 + 1));
            si8(_local_1, (_local_6 + 2));
            si8(_local_2, (_local_6 + 3));
            _local_6 = li8(_local_3);
            _local_1 = _local_3;
            if (_local_6 == 0) goto _label_10;
            do 
            {
                _local_6 = li8(_local_5 + 1);
                _local_5 = (_local_5 + 1);
                _local_2 = _local_5;
                if (_local_6 == 0) goto _label_11;
                _local_5 = _local_2;
            } while (true);
            
        _label_20: 
            _local_1 = _local_3;
            
        _label_21: 
            _local_2 = 0;
            do 
            {
                _local_4 = (_local_6 + _local_2);
                _local_4 = li8(_local_4);
                _local_7 = (_local_1 + _local_2);
                si8(_local_4, _local_7);
                _local_2 = (_local_2 + 1);
                if (_local_4 == 0) goto _label_12;
            } while (true);
            
        _label_22: 
            _local_1 = _local_3;
            
        _label_23: 
            _local_2 = 34;
            _local_1 = (_local_1 - _local_5);
            _local_4 = 93;
            _local_5 = 0;
            _local_1 = (_local_3 + _local_1);
            si8(_local_2, _local_1);
            si8(_local_4, (_local_1 + 1));
            si8(_local_5, (_local_1 + 2));
            //unresolved jump
        }


    }
}

