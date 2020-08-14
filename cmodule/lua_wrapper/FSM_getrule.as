package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_getrule extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li8(_local_1);
            _local_3 = li32(mstate.ebp + 12);
            if (!(_local_2 == 77))
            {
                _local_4 = (_local_2 & 0xFF);
                if (!(_local_4 == 74)) goto _label_1;
                _local_2 = 0;
                si32(_local_2, _local_3);
                mstate.esp = (mstate.esp - 16);
                _local_2 = 365;
                _local_4 = (_local_3 + 4);
                _local_1 = (_local_1 + 1);
                _local_5 = 1;
                si32(_local_1, mstate.esp);
                si32(_local_4, (mstate.esp + 4));
                si32(_local_5, (mstate.esp + 8));
                si32(_local_2, (mstate.esp + 12));
                mstate.esp = (mstate.esp - 4);
                FSM_getnum.start();
                _local_1 = mstate.eax;
                mstate.esp = (mstate.esp + 16);
                if (_local_1 == 0) goto _label_3;
                goto _label_2;
            };
            _local_2 = 2;
            si32(_local_2, _local_3);
            mstate.esp = (mstate.esp - 16);
            _local_2 = (_local_3 + 12);
            _local_4 = 12;
            _local_1 = (_local_1 + 1);
            _local_5 = 1;
            si32(_local_1, mstate.esp);
            si32(_local_2, (mstate.esp + 4));
            si32(_local_5, (mstate.esp + 8));
            si32(_local_4, (mstate.esp + 12));
            mstate.esp = (mstate.esp - 4);
            FSM_getnum.start();
            _local_1 = mstate.eax;
            mstate.esp = (mstate.esp + 16);
            if (!(_local_1 == 0))
            {
                _local_2 = li8(_local_1);
                if (!(!(_local_2 == 46)))
                {
                    _local_2 = 5;
                    mstate.esp = (mstate.esp - 16);
                    _local_4 = (_local_3 + 8);
                    _local_1 = (_local_1 + 1);
                    _local_5 = 1;
                    si32(_local_1, mstate.esp);
                    si32(_local_4, (mstate.esp + 4));
                    si32(_local_5, (mstate.esp + 8));
                    si32(_local_2, (mstate.esp + 12));
                    mstate.esp = (mstate.esp - 4);
                    FSM_getnum.start();
                    _local_1 = mstate.eax;
                    mstate.esp = (mstate.esp + 16);
                    if (!(_local_1 == 0))
                    {
                        _local_2 = li8(_local_1);
                        if (!(!(_local_2 == 46)))
                        {
                            _local_2 = 6;
                            mstate.esp = (mstate.esp - 16);
                            _local_4 = 0;
                            _local_5 = (_local_3 + 4);
                            _local_1 = (_local_1 + 1);
                            si32(_local_1, mstate.esp);
                            si32(_local_5, (mstate.esp + 4));
                            si32(_local_4, (mstate.esp + 8));
                            si32(_local_2, (mstate.esp + 12));
                            mstate.esp = (mstate.esp - 4);
                            FSM_getnum.start();
                            _local_1 = mstate.eax;
                            mstate.esp = (mstate.esp + 16);
                            if (!(_local_1 == 0))
                            {
                                goto _label_2;
                                
                            _label_1: 
                                _local_2 = (_local_2 << 24);
                                _local_2 = (_local_2 >> 24);
                                _local_2 = (_local_2 + -48);
                                if (!(uint(_local_2) > uint(9)))
                                {
                                    _local_2 = 1;
                                    si32(_local_2, _local_3);
                                    mstate.esp = (mstate.esp - 16);
                                    _local_2 = 365;
                                    _local_4 = 0;
                                    _local_5 = (_local_3 + 4);
                                    si32(_local_1, mstate.esp);
                                    si32(_local_5, (mstate.esp + 4));
                                    si32(_local_4, (mstate.esp + 8));
                                    si32(_local_2, (mstate.esp + 12));
                                    mstate.esp = (mstate.esp - 4);
                                    FSM_getnum.start();
                                    _local_1 = mstate.eax;
                                    mstate.esp = (mstate.esp + 16);
                                    if (!(_local_1 == 0))
                                    {
                                        
                                    _label_2: 
                                        _local_2 = li8(_local_1);
                                        if (!(!(_local_2 == 47)))
                                        {
                                            mstate.esp = (mstate.esp - 8);
                                            _local_3 = (_local_3 + 16);
                                            _local_1 = (_local_1 + 1);
                                            si32(_local_1, mstate.esp);
                                            si32(_local_3, (mstate.esp + 4));
                                            mstate.esp = (mstate.esp - 4);
                                            FSM_getsecs.start();
                                            _local_1 = mstate.eax;
                                            mstate.esp = (mstate.esp + 8);
                                            goto _label_4;
                                        };
                                        _local_2 = 7200;
                                        si32(_local_2, (_local_3 + 16));
                                        goto _label_4;
                                    };
                                };
                            };
                        };
                    };
                };
            };
            
        _label_3: 
            _local_1 = 0;
            
        _label_4: 
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

