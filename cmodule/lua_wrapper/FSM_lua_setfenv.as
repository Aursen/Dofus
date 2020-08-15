package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_setfenv extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            mstate.esp = (mstate.esp - 8);
            _local_2 = li32(mstate.ebp + 12);
            si32(_local_1, mstate.esp);
            si32(_local_2, (mstate.esp + 4));
            mstate.esp = (mstate.esp - 4);
            FSM_index2adr.start();
            _local_2 = mstate.eax;
            mstate.esp = (mstate.esp + 8);
            _local_3 = li32(_local_2 + 8);
            if (!(_local_3 == 6))
            {
                if (!(_local_3 == 7))
                {
                    if (_local_3 == 8) goto _label_1;
                    _local_3 = 0;
                    goto _label_2;
                };
                _local_3 = 1;
                _local_4 = li32(_local_1 + 8);
                _local_5 = li32(_local_2);
                _local_4 = li32(_local_4 + -12);
                si32(_local_4, (_local_5 + 12));
                goto _label_3;
                
            _label_1: 
                _local_3 = 5;
                _local_4 = li32(_local_1 + 8);
                _local_5 = li32(_local_2);
                _local_4 = li32(_local_4 + -12);
                si32(_local_4, (_local_5 + 72));
                si32(_local_3, (_local_5 + 80));
                _local_3 = 1;
                
            _label_2: 
                if (!(_local_3 == 0)) goto _label_3;
                _local_2 = _local_3;
                goto _label_5;
            };
            _local_3 = 1;
            _local_4 = li32(_local_1 + 8);
            _local_5 = li32(_local_2);
            _local_4 = li32(_local_4 + -12);
            si32(_local_4, (_local_5 + 12));
            
        _label_3: 
            _local_4 = li32(_local_1 + 8);
            _local_4 = li32(_local_4 + -12);
            _local_5 = li8(_local_4 + 5);
            _local_5 = (_local_5 & 0x03);
            if (!(!(_local_5 == 0)))
            {
                
            _label_4: 
                _local_2 = _local_3;
                goto _label_5;
            };
            _local_2 = li32(_local_2);
            _local_5 = li8(_local_2 + 5);
            _local_2 = (_local_2 + 5);
            _local_6 = (_local_5 & 0x04);
            if (_local_6 == 0) goto _label_4;
            _local_6 = li32(_local_1 + 16);
            _local_7 = li8(_local_6 + 21);
            if (!(!(_local_7 == 1)))
            {
                mstate.esp = (mstate.esp - 8);
                si32(_local_6, mstate.esp);
                si32(_local_4, (mstate.esp + 4));
                mstate.esp = (mstate.esp - 4);
                FSM_reallymarkobject.start();
                mstate.esp = (mstate.esp + 8);
                _local_2 = _local_3;
            }
            else
            {
                _local_4 = li8(_local_6 + 20);
                _local_5 = (_local_5 & 0xFFFFFFF8);
                _local_4 = (_local_4 & 0x03);
                _local_4 = (_local_4 | _local_5);
                si8(_local_4, _local_2);
                _local_2 = _local_3;
            };
            
        _label_5: 
            _local_3 = li32(_local_1 + 8);
            _local_3 = (_local_3 + -12);
            si32(_local_3, (_local_1 + 8));
            mstate.eax = _local_2;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

