package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_need_value extends Machine 
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
            _local_2 = li32(mstate.ebp + 12);
            if (!(!(_local_2 == -1)))
            {
                
            _label_1: 
                _local_1 = 0;
                
            _label_2: 
                mstate.eax = _local_1;
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
            };
            _local_1 = li32(_local_1);
            _local_3 = li32(_local_1 + 12);
            do 
            {
                _local_4 = (_local_2 << 2);
                _local_4 = (_local_3 + _local_4);
                if ((_local_2 > 0))
                {
                    _local_5 = _luaP_opmodes;
                    _local_6 = (_local_2 << 2);
                    _local_6 = (_local_6 + _local_3);
                    _local_7 = li32(_local_6 + -4);
                    _local_7 = (_local_7 & 0x3F);
                    _local_5 = (_local_5 + _local_7);
                    _local_5 = li8(_local_5);
                    _local_5 = (_local_5 << 24);
                    _local_5 = (_local_5 >> 24);
                    _local_6 = (_local_6 + -4);
                    _local_4 = ((_local_5 > -1) ? _local_4 : _local_6);
                };
                _local_4 = li32(_local_4);
                _local_4 = (_local_4 & 0x3F);
                if (!(_local_4 == 27))
                {
                    _local_1 = 1;
                    goto _label_2;
                };
                _local_4 = li32(_local_1 + 12);
                _local_5 = (_local_2 << 2);
                _local_4 = (_local_4 + _local_5);
                _local_4 = li32(_local_4);
                _local_4 = (_local_4 >>> 14);
                _local_4 = (_local_4 + -131071);
                if (!(!(_local_4 == -1)))
                {
                    _local_2 = -1;
                }
                else
                {
                    _local_2 = (_local_2 + _local_4);
                    _local_2 = (_local_2 + 1);
                };
                if (_local_2 == -1) goto _label_1;
            } while (true);
        }


    }
}

