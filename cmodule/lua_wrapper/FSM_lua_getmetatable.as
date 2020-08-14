package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_getmetatable extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
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
            if (!(_local_3 == 7))
            {
                if (!(_local_3 == 5)) goto _label_1;
                _local_2 = li32(_local_2);
                _local_2 = li32(_local_2 + 8);
                if (_local_2 == 0) goto _label_3;
                goto _label_2;
            };
            _local_2 = li32(_local_2);
            _local_2 = li32(_local_2 + 8);
            if (!(_local_2 == 0))
            {
                goto _label_2;
                
            _label_1: 
                _local_2 = li32(_local_1 + 16);
                _local_3 = (_local_3 << 2);
                _local_2 = (_local_2 + _local_3);
                _local_2 = li32(_local_2 + 132);
                if (!(_local_2 == 0))
                {
                    
                _label_2: 
                    _local_3 = 5;
                    _local_4 = li32(_local_1 + 8);
                    si32(_local_2, _local_4);
                    si32(_local_3, (_local_4 + 8));
                    _local_2 = li32(_local_1 + 8);
                    _local_2 = (_local_2 + 12);
                    si32(_local_2, (_local_1 + 8));
                    _local_1 = 1;
                    goto _label_4;
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

