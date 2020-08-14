package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_bcopy extends Machine 
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
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = _local_1;
            _local_5 = _local_2;
            if (!(_local_3 == 0))
            {
                if (!(_local_2 == _local_1))
                {
                    if (!(uint(_local_2) >= uint(_local_1)))
                    {
                        _local_6 = (_local_5 | _local_4);
                        _local_6 = (_local_6 & 0x03);
                        if ((!(_local_6 == 0)))
                        {
                            _local_6 = (_local_5 ^ _local_4);
                            _local_6 = (_local_6 & 0x03);
                            if( ((!(_local_6 == 0))) || (!(uint(_local_3) > uint(3))) )
                            {
                                _local_6 = _local_3;
                                goto _label_1;
                            };
                            _local_6 = (_local_4 & 0x03);
                            _local_6 = (4 - _local_6);
                            
                        _label_1: 
                            _local_7 = 0;
                            _local_3 = (_local_3 - _local_6);
                            do 
                            {
                                _local_8 = (_local_4 + _local_7);
                                _local_8 = li8(_local_8);
                                _local_9 = (_local_5 + _local_7);
                                si8(_local_8, _local_9);
                                _local_7 = (_local_7 + 1);
                            } while (!(_local_7 == _local_6));
                            _local_1 = (_local_1 + _local_7);
                            _local_2 = (_local_2 + _local_7);
                        };
                        _local_4 = (_local_3 >>> 2);
                        _local_5 = _local_1;
                        _local_6 = _local_2;
                        if ((uint(_local_3) > uint(3)))
                        {
                            _local_7 = 0;
                            _local_8 = _local_7;
                            do 
                            {
                                _local_9 = (_local_5 + _local_8);
                                _local_9 = li32(_local_9);
                                _local_10 = (_local_6 + _local_8);
                                si32(_local_9, _local_10);
                                _local_8 = (_local_8 + 4);
                                _local_7 = (_local_7 + 1);
                            } while (!(_local_7 == _local_4));
                            _local_2 = (_local_2 + _local_8);
                            _local_1 = (_local_1 + _local_8);
                        };
                        _local_3 = (_local_3 & 0x03);
                        if (_local_3 == 0) goto _label_2;
                        _local_4 = 0;
                        do 
                        {
                            _local_5 = (_local_1 + _local_4);
                            _local_5 = li8(_local_5);
                            _local_6 = (_local_2 + _local_4);
                            si8(_local_5, _local_6);
                            _local_4 = (_local_4 + 1);
                            if (_local_4 == _local_3) goto _label_2;
                        } while (true);
                    };
                    _local_4 = (_local_2 + _local_3);
                    _local_5 = (_local_1 + _local_3);
                    _local_6 = (_local_5 | _local_4);
                    _local_7 = _local_4;
                    _local_8 = _local_5;
                    _local_6 = (_local_6 & 0x03);
                    if (!(!(_local_6 == 0)))
                    {
                        _local_1 = _local_3;
                        _local_2 = _local_8;
                        _local_3 = _local_7;
                    }
                    else
                    {
                        _local_6 = 0;
                        _local_4 = (_local_5 ^ _local_4);
                        _local_4 = (_local_4 & 0x03);
                        _local_4 = ((_local_4 != 0) ? 1 : 0);
                        _local_7 = ((uint(_local_3) < uint(5)) ? 1 : 0);
                        _local_4 = (_local_4 | _local_7);
                        _local_4 = (_local_4 & 0x01);
                        _local_5 = (_local_5 & 0x03);
                        _local_4 = ((_local_4 != 0) ? _local_3 : _local_5);
                        _local_5 = (_local_3 - _local_4);
                        do 
                        {
                            _local_7 = (_local_6 ^ 0xFFFFFFFF);
                            _local_7 = (_local_7 + _local_3);
                            _local_8 = (_local_1 + _local_7);
                            _local_9 = li8(_local_8);
                            _local_7 = (_local_2 + _local_7);
                            si8(_local_9, _local_7);
                            _local_6 = (_local_6 + 1);
                        } while (!(_local_6 == _local_4));
                        _local_1 = _local_5;
                        _local_2 = _local_8;
                        _local_3 = _local_7;
                    };
                    _local_4 = (_local_1 >>> 2);
                    _local_5 = _local_3;
                    _local_6 = _local_2;
                    if (!(uint(_local_1) > uint(3)))
                    {
                        _local_4 = _local_2;
                        _local_5 = _local_3;
                    }
                    else
                    {
                        _local_2 = 0;
                        _local_3 = _local_2;
                        do 
                        {
                            _local_7 = (_local_6 + _local_3);
                            _local_7 = li32(_local_7 + -4);
                            _local_8 = (_local_5 + _local_3);
                            si32(_local_7, (_local_8 + -4));
                            _local_3 = (_local_3 + -4);
                            _local_2 = (_local_2 + 1);
                        } while (!(_local_2 == _local_4));
                        _local_5 = (_local_5 + _local_3);
                        _local_4 = (_local_6 + _local_3);
                    };
                    _local_2 = _local_4;
                    _local_3 = _local_5;
                    _local_1 = (_local_1 & 0x03);
                    if (!(_local_1 == 0))
                    {
                        _local_4 = 0;
                        do 
                        {
                            _local_5 = (_local_4 ^ 0xFFFFFFFF);
                            _local_6 = (_local_2 + _local_5);
                            _local_6 = li8(_local_6);
                            _local_5 = (_local_3 + _local_5);
                            si8(_local_6, _local_5);
                            _local_4 = (_local_4 + 1);
                        } while (!(_local_4 == _local_1));
                    };
                };
            };
            
        _label_2: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

