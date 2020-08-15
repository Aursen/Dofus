package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___ULtod_D2A extends Machine 
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
            _local_1 = li32(mstate.ebp + 20);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(mstate.ebp + 12);
            _local_4 = li32(mstate.ebp + 16);
            _local_5 = (_local_1 & 0x07);
            if (!(_local_5 > 2))
            {
                if (_local_5 == 0) goto _label_2;
                if (_local_5 == 1) goto _label_3;
                if (!(_local_5 == 2)) goto _label_1;
                _local_4 = li32(_local_3);
                si32(_local_4, _local_2);
                _local_3 = li32(_local_3 + 4);
                si32(_local_3, (_local_2 + 4));
                _local_1 = (_local_1 & 0x08);
                if (_local_1 == 0) goto _label_6;
                goto _label_5;
            };
            if (!(_local_5 > 4))
            {
                if (_local_5 == 3) goto _label_4;
                if ((_local_5 == 4))
                {
                    _local_3 = 2147483647;
                    si32(_local_3, (_local_2 + 4));
                    _local_3 = -1;
                    si32(_local_3, _local_2);
                };
                
            _label_1: 
                _local_1 = (_local_1 & 0x08);
                if (_local_1 == 0) goto _label_6;
                goto _label_5;
            };
            if (!(_local_5 == 5))
            {
                if (!(_local_5 == 6)) goto _label_1;
                
            _label_2: 
                _local_3 = 0;
                si32(_local_3, (_local_2 + 4));
                si32(_local_3, _local_2);
                _local_1 = (_local_1 & 0x08);
                if (_local_1 == 0) goto _label_6;
            }
            else
            {
                
            _label_3: 
                _local_5 = li32(_local_3);
                si32(_local_5, _local_2);
                _local_3 = li32(_local_3 + 4);
                _local_4 = (_local_4 << 20);
                _local_4 = (_local_4 + 0x43300000);
                _local_3 = (_local_3 & 0xFFEFFFFF);
                _local_3 = (_local_3 | _local_4);
                si32(_local_3, (_local_2 + 4));
                _local_1 = (_local_1 & 0x08);
                if (_local_1 == 0) goto _label_6;
                goto _label_5;
                
            _label_4: 
                _local_3 = 0x7FF00000;
                si32(_local_3, (_local_2 + 4));
                _local_3 = 0;
                si32(_local_3, _local_2);
                _local_1 = (_local_1 & 0x08);
                if (_local_1 == 0) goto _label_6;
            };
            
        _label_5: 
            _local_1 = li32(_local_2 + 4);
            _local_1 = (_local_1 | 0x80000000);
            si32(_local_1, (_local_2 + 4));
            
        _label_6: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

