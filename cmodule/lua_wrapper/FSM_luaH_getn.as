package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaH_getn extends Machine 
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
            _local_2 = li32(_local_1 + 28);
            if (!(_local_2 == 0))
            {
                _local_3 = li32(_local_1 + 12);
                _local_4 = (_local_2 * 12);
                _local_4 = (_local_4 + _local_3);
                _local_4 = li32(_local_4 + -4);
                if (!(!(_local_4 == 0)))
                {
                    _local_1 = 0;
                    do 
                    {
                        _local_4 = _local_1;
                        _local_1 = _local_2;
                        _local_2 = (_local_1 - _local_4);
                        if (uint(_local_2) > uint(1)) goto _label_3;
                        _local_1 = _local_4;
                        goto _label_4;
                        
                    _label_1: 
                        _local_2 = _local_4;
                        
                    _label_2: 
                        _local_4 = (_local_2 + _local_1);
                        _local_4 = (_local_4 >>> 1);
                        _local_5 = (_local_4 * 12);
                        _local_5 = (_local_5 + _local_3);
                        _local_5 = li32(_local_5 + -4);
                        if ((!(_local_5 == 0))) break;
                        _local_1 = _local_2;
                        _local_2 = _local_4;
                    } while (true);
                    _local_2 = (_local_1 - _local_4);
                    if (uint(_local_2) > uint(1)) goto _label_1;
                    _local_1 = _local_4;
                    goto _label_4;
                    
                _label_3: 
                    _local_2 = _local_4;
                    goto _label_2;
                };
            };
            _local_3 = _dummynode_;
            _local_4 = li32(_local_1 + 16);
            if (!(!(_local_4 == _local_3)))
            {
                _local_1 = _local_2;
            }
            else
            {
                mstate.esp = (mstate.esp - 8);
                _local_3 = (_local_2 + 1);
                si32(_local_1, mstate.esp);
                si32(_local_3, (mstate.esp + 4));
                mstate.esp = (mstate.esp - 4);
                FSM_luaH_getnum.start();
                _local_4 = mstate.eax;
                mstate.esp = (mstate.esp + 8);
                _local_4 = li32(_local_4 + 8);
                if (_local_4 == 0) goto _label_5;
                _local_2 = _local_3;
                do 
                {
                    _local_3 = (_local_2 << 1);
                    if ((uint(_local_3) > uint(2147483645)))
                    {
                        _local_2 = 1;
                        mstate.esp = (mstate.esp - 8);
                        si32(_local_1, mstate.esp);
                        si32(_local_2, (mstate.esp + 4));
                        mstate.esp = (mstate.esp - 4);
                        FSM_luaH_getnum.start();
                        _local_2 = mstate.eax;
                        mstate.esp = (mstate.esp + 8);
                        _local_2 = li32(_local_2 + 8);
                        if (!(_local_2 == 0))
                        {
                            _local_2 = 0;
                            do 
                            {
                                mstate.esp = (mstate.esp - 8);
                                _local_3 = (_local_2 + 2);
                                si32(_local_1, mstate.esp);
                                si32(_local_3, (mstate.esp + 4));
                                mstate.esp = (mstate.esp - 4);
                                FSM_luaH_getnum.start();
                                _local_3 = mstate.eax;
                                mstate.esp = (mstate.esp + 8);
                                _local_3 = li32(_local_3 + 8);
                                _local_2 = (_local_2 + 1);
                            } while (!(_local_3 == 0));
                            _local_1 = _local_2;
                            goto _label_4;
                        };
                        _local_2 = 0;
                        _local_1 = _local_2;
                        goto _label_4;
                    };
                    mstate.esp = (mstate.esp - 8);
                    si32(_local_1, mstate.esp);
                    si32(_local_3, (mstate.esp + 4));
                    mstate.esp = (mstate.esp - 4);
                    FSM_luaH_getnum.start();
                    _local_4 = mstate.eax;
                    mstate.esp = (mstate.esp + 8);
                    _local_4 = li32(_local_4 + 8);
                    if ((_local_4 == 0)) break;
                    _local_2 = _local_3;
                } while (true);
                while ((uint((_local_4 = (_local_3 - _local_2))) > uint(1)))
                {
                    _local_4 = (_local_2 + _local_3);
                    mstate.esp = (mstate.esp - 8);
                    _local_4 = (_local_4 >>> 1);
                    si32(_local_1, mstate.esp);
                    si32(_local_4, (mstate.esp + 4));
                    mstate.esp = (mstate.esp - 4);
                    FSM_luaH_getnum.start();
                    _local_5 = mstate.eax;
                    mstate.esp = (mstate.esp + 8);
                    _local_5 = li32(_local_5 + 8);
                    if (!(_local_5 == 0))
                    {
                        _local_2 = _local_4;
                    }
                    else
                    {
                        _local_3 = _local_4;
                        continue;
                    };
                };
                _local_1 = _local_2;
            };
            
        _label_4: 
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_5: 
            //unresolved jump
        }


    }
}

