package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___lo0bits_D2A extends Machine 
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
            _local_2 = li32(_local_1);
            _local_3 = (_local_2 & 0x07);
            if (!(_local_3 == 0))
            {
                _local_3 = (_local_2 & 0x01);
                if (!(_local_3 == 0))
                {
                    _local_1 = 0;
                    goto _label_4;
                };
                _local_3 = (_local_2 & 0x02);
                if (_local_3 == 0) goto _label_1;
                _local_3 = 1;
                _local_2 = (_local_2 >>> 1);
                goto _label_2;
            };
            _local_3 = (_local_2 & 0xFFFF);
            _local_3 = ((_local_3 == 0) ? 16 : 0);
            _local_2 = (_local_2 >>> _local_3);
            _local_4 = (_local_2 & 0xFF);
            _local_4 = ((_local_4 == 0) ? 8 : 0);
            _local_2 = (_local_2 >>> _local_4);
            _local_5 = (_local_2 & 0x0F);
            _local_5 = ((_local_5 == 0) ? 4 : 0);
            _local_2 = (_local_2 >>> _local_5);
            _local_3 = (_local_4 | _local_3);
            _local_4 = (_local_2 & 0x03);
            _local_4 = ((_local_4 == 0) ? 2 : 0);
            _local_3 = (_local_3 | _local_5);
            _local_2 = (_local_2 >>> _local_4);
            _local_3 = (_local_3 | _local_4);
            _local_4 = (_local_2 & 0x01);
            if ((_local_4 == 0))
            {
                _local_4 = (_local_2 >>> 1);
                _local_3 = (_local_3 + 1);
                if (uint(_local_2) < uint(2)) goto _label_3;
                _local_2 = _local_4;
                goto _label_2;
                
            _label_1: 
                _local_3 = 2;
                _local_2 = (_local_2 >>> 2);
            };
            
        _label_2: 
            si32(_local_2, _local_1);
            mstate.eax = _local_3;
            goto _label_5;
            
        _label_3: 
            _local_1 = 32;
            
        _label_4: 
            mstate.eax = _local_1;
            
        _label_5: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

