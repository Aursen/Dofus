package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_matchbracketclass extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = li8(_local_1 + 1);
            _local_5 = (_local_1 + 1);
            if (!(_local_4 == 94))
            {
                _local_5 = 1;
            }
            else
            {
                _local_1 = (_local_1 + 2);
                if (!(uint(_local_1) < uint(_local_3)))
                {
                    _local_1 = 0;
                    goto _label_4;
                };
                _local_4 = 0;
                
            _label_1: 
                _local_6 = li8(_local_1);
                _local_7 = li8(_local_5 + 2);
                _local_8 = (_local_5 + 2);
                if (!(!(_local_6 == 37)))
                {
                    mstate.esp = (mstate.esp - 8);
                    _local_1 = (_local_7 & 0xFF);
                    si32(_local_2, mstate.esp);
                    si32(_local_1, (mstate.esp + 4));
                    mstate.esp = (mstate.esp - 4);
                    FSM_match_class.start();
                    _local_1 = mstate.eax;
                    mstate.esp = (mstate.esp + 8);
                    if (!(_local_1 == 0)) goto _label_5;
                    _local_1 = _local_8;
                    _local_5 = _local_4;
                }
                else
                {
                    _local_7 = (_local_7 & 0xFF);
                    if (!(!(_local_7 == 45)))
                    {
                        _local_7 = (_local_5 + 3);
                        if (!(uint(_local_7) >= uint(_local_3)))
                        {
                            _local_1 = li8(_local_5 + 1);
                            if (!(_local_1 <= _local_2))
                            {
                                
                            _label_2: 
                                _local_1 = _local_7;
                                _local_5 = _local_4;
                                goto _label_3;
                            };
                            _local_1 = li8(_local_7);
                            if (_local_1 < _local_2) goto _label_2;
                            goto _label_5;
                        };
                    };
                    _local_5 = (_local_6 & 0xFF);
                    if (_local_5 == _local_2) goto _label_5;
                    _local_5 = _local_4;
                };
            };
            
        _label_3: 
            _local_4 = _local_5;
            _local_6 = (_local_1 + 1);
            if (!(uint(_local_6) < uint(_local_3)))
            {
                _local_1 = _local_4;
                
            _label_4: 
                _local_4 = _local_1;
                _local_4 = ((_local_4 == 0) ? 1 : 0);
                _local_4 = (_local_4 & 0x01);
                
            _label_5: 
                mstate.eax = _local_4;
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
            };
            _local_5 = _local_1;
            _local_1 = _local_6;
            goto _label_1;
        }


    }
} cmodule.lua_wrapper

