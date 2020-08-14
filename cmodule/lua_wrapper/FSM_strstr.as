package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_strstr extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li8(_local_1);
            _local_3 = li32(mstate.ebp + 8);
            _local_4 = (_local_1 + 1);
            _local_5 = _local_3;
            if (!(!(_local_2 == 0)))
            {
                _local_1 = _local_3;
                
            _label_1: 
                mstate.eax = _local_1;
                goto _label_4;
            };
            _local_3 = li8(_local_4);
            if (!(_local_3 == 0))
            {
                _local_3 = _local_1;
                do 
                {
                    _local_6 = li8(_local_3 + 2);
                    _local_3 = (_local_3 + 1);
                } while (!(_local_6 == 0));
                _local_3 = (_local_3 + 1);
                
            _label_2: 
                _local_6 = _local_4;
                _local_7 = _local_3;
                do 
                {
                    _local_8 = li8(_local_5);
                    _local_9 = _local_5;
                    if (!(!(_local_8 == 0)))
                    {
                        _local_1 = 0;
                        goto _label_1;
                    };
                    _local_10 = (_local_2 & 0xFF);
                    _local_8 = (_local_8 & 0xFF);
                    if ((_local_8 == _local_10)) break;
                    
                _label_3: 
                    _local_5 = (_local_5 + 1);
                } while (true);
                if (!(_local_3 == _local_4))
                {
                    _local_8 = 1;
                    _local_10 = (_local_7 - _local_6);
                    do 
                    {
                        _local_11 = (_local_1 + _local_8);
                        _local_12 = (_local_5 + _local_8);
                        _local_12 = li8(_local_12);
                        _local_11 = li8(_local_11);
                        if (!(_local_12 == _local_11)) goto _label_3;
                        _local_11 = (_local_10 + -1);
                        _local_8 = (_local_8 + 1);
                        _local_12 = (_local_12 & 0xFF);
                        if ((_local_12 == 0)) break;
                        if ((_local_10 == 1)) break;
                        _local_10 = _local_11;
                    } while (true);
                };
                mstate.eax = _local_9;
                
            _label_4: 
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
            };
            _local_3 = _local_4;
            goto _label_2;
        }


    }
} cmodule.lua_wrapper

