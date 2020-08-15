package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___any_on_D2A extends Machine 
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
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(_local_2 + 16);
            _local_4 = (_local_1 >> 5);
            if (!(_local_4 <= _local_3))
            {
                _local_1 = _local_3;
                
            _label_1: 
                if (_local_1 > 0) goto _label_5;
                
            _label_2: 
                _local_1 = 0;
                goto _label_4;
            };
            if (!(_local_4 < _local_3))
            {
                
            _label_3: 
                _local_1 = _local_4;
                goto _label_1;
            };
            _local_1 = (_local_1 & 0x1F);
            if (_local_1 == 0) goto _label_3;
            _local_3 = (_local_4 << 2);
            _local_3 = (_local_2 + _local_3);
            _local_3 = li32(_local_3 + 20);
            _local_5 = (_local_3 >>> _local_1);
            _local_1 = (_local_5 << _local_1);
            if (_local_1 == _local_3) goto _label_3;
            do 
            {
                _local_1 = 1;
                
            _label_4: 
                mstate.eax = _local_1;
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
                
            _label_5: 
                _local_3 = 0;
                continue;
            } while ((_local_4 = (_local_3 ^ 0xFFFFFFFF)), (_local_4 = (_local_1 + _local_4)), (_local_5 = (_local_4 << 2)), (_local_5 = (_local_2 + _local_5)), (_local_5 = li32(_local_5 + 20)), (!(_local_5 == 0)));
            _local_3 = (_local_3 + 1);
            if (_local_4 < 1) goto _label_2;
            //unresolved jump
        }


    }
}

