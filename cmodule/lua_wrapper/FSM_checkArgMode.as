package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_checkArgMode extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 16);
            if (!(_local_3 == 3))
            {
                if (!(_local_3 == 2))
                {
                    if (!(_local_3 == 0)) goto _label_3;
                    _local_1 = ((_local_2 == 0) ? 1 : 0);
                    goto _label_2;
                };
                
            _label_1: 
                _local_1 = li8(_local_1 + 75);
                _local_1 = ((_local_1 > _local_2) ? 1 : 0);
                
            _label_2: 
                _local_1 = (_local_1 & 0x01);
                goto _label_4;
            };
            _local_3 = (_local_2 & 0x0100);
            if (_local_3 == 0) goto _label_1;
            _local_1 = li32(_local_1 + 40);
            _local_2 = (_local_2 & 0xFFFFFEFF);
            _local_1 = ((_local_2 < _local_1) ? 1 : 0);
            goto _label_2;
            
        _label_3: 
            _local_1 = 1;
            
        _label_4: 
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

