package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_findlocal extends Machine 
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
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(_local_1 + 4);
            _local_3 = li32(_local_2 + 8);
            _local_4 = li32(mstate.ebp + 8);
            _local_5 = li32(mstate.ebp + 16);
            if (!(_local_3 == 6))
            {
                
            _label_1: 
                _local_6 = 0;
                goto _label_2;
            };
            _local_6 = li32(_local_2);
            _local_7 = li8(_local_6 + 6);
            if (!(_local_7 == 0)) goto _label_1;
            _local_6 = li32(_local_6 + 16);
            
        _label_2: 
            if (!(_local_6 == 0))
            {
                if (!(_local_3 == 6))
                {
                    
                _label_3: 
                    _local_2 = -1;
                    goto _label_4;
                };
                _local_3 = li32(_local_2);
                _local_3 = li8(_local_3 + 6);
                if (!(_local_3 == 0)) goto _label_3;
                _local_3 = li32(_local_4 + 20);
                if (!(!(_local_3 == _local_1)))
                {
                    _local_3 = li32(_local_4 + 24);
                    si32(_local_3, (_local_1 + 12));
                };
                _local_2 = li32(_local_2);
                _local_2 = li32(_local_2 + 16);
                _local_3 = li32(_local_1 + 12);
                _local_2 = li32(_local_2 + 12);
                _local_2 = (_local_3 - _local_2);
                _local_2 = (_local_2 >> 2);
                _local_2 = (_local_2 + -1);
                
            _label_4: 
                _local_3 = li32(_local_6 + 24);
                _local_6 = li32(_local_6 + 56);
                mstate.esp = (mstate.esp - 16);
                si32(_local_3, mstate.esp);
                si32(_local_6, (mstate.esp + 4));
                si32(_local_5, (mstate.esp + 8));
                si32(_local_2, (mstate.esp + 12));
                mstate.esp = (mstate.esp - 4);
                FSM_luaF_getlocalname388.start();
                _local_2 = mstate.eax;
                mstate.esp = (mstate.esp + 16);
                if (!(_local_2 == 0)) goto _label_5;
            };
            _local_2 = li32(_local_4 + 20);
            if (!(!(_local_2 == _local_1)))
            {
                _local_2 = (_local_4 + 8);
            }
            else
            {
                _local_2 = (_local_1 + 28);
            };
            _local_3 = __2E_str5258;
            _local_2 = li32(_local_2);
            _local_1 = li32(_local_1);
            _local_2 = (_local_2 - _local_1);
            _local_2 = int((_local_2 / 12));
            _local_2 = ((_local_2 >= _local_5) ? 1 : 0);
            _local_1 = ((_local_5 > 0) ? 1 : 0);
            _local_2 = (_local_2 & _local_1);
            _local_2 = (_local_2 & 0x01);
            _local_2 = ((_local_2 != 0) ? _local_3 : 0);
            
        _label_5: 
            mstate.eax = _local_2;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

