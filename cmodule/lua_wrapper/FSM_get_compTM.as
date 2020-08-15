package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_get_compTM extends Machine 
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
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 16);
            if (!(!(_local_2 == 0)))
            {
                
            _label_1: 
                _local_4 = 0;
                goto _label_2;
            };
            _local_4 = li8(_local_2 + 6);
            _local_4 = (_local_4 & 0x10);
            if (!(_local_4 == 0)) goto _label_1;
            _local_4 = 4;
            _local_5 = li32(_local_1 + 16);
            _local_5 = li32(_local_5 + 184);
            mstate.esp = (mstate.esp - 12);
            si32(_local_2, mstate.esp);
            si32(_local_4, (mstate.esp + 4));
            si32(_local_5, (mstate.esp + 8));
            mstate.esp = (mstate.esp - 4);
            FSM_luaT_gettm.start();
            _local_4 = mstate.eax;
            mstate.esp = (mstate.esp + 12);
            
        _label_2: 
            if (!(!(_local_4 == 0)))
            {
                
            _label_3: 
                _local_1 = 0;
                goto _label_6;
            };
            if (!(!(_local_2 == _local_3)))
            {
                _local_1 = _local_4;
            }
            else
            {
                if (!(!(_local_3 == 0)))
                {
                    
                _label_4: 
                    _local_1 = 0;
                    goto _label_5;
                };
                _local_2 = li8(_local_3 + 6);
                _local_2 = (_local_2 & 0x10);
                if (!(_local_2 == 0)) goto _label_4;
                _local_2 = 4;
                _local_1 = li32(_local_1 + 16);
                _local_1 = li32(_local_1 + 184);
                mstate.esp = (mstate.esp - 12);
                si32(_local_3, mstate.esp);
                si32(_local_2, (mstate.esp + 4));
                si32(_local_1, (mstate.esp + 8));
                mstate.esp = (mstate.esp - 4);
                FSM_luaT_gettm.start();
                _local_1 = mstate.eax;
                mstate.esp = (mstate.esp + 12);
                
            _label_5: 
                if (_local_1 == 0) goto _label_3;
                mstate.esp = (mstate.esp - 8);
                si32(_local_4, mstate.esp);
                si32(_local_1, (mstate.esp + 4));
                mstate.esp = (mstate.esp - 4);
                FSM_luaO_rawequalObj.start();
                _local_1 = mstate.eax;
                mstate.esp = (mstate.esp + 8);
                _local_1 = ((_local_1 == 0) ? 0 : _local_4);
            };
            
        _label_6: 
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

