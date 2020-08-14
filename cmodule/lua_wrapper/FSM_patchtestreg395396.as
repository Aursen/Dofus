package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_patchtestreg395396 extends Machine 
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
            _local_3 = (_local_1 << 2);
            _local_4 = li32(mstate.ebp + 16);
            _local_3 = (_local_2 + _local_3);
            if (!(_local_1 > 0))
            {
                _local_1 = _local_3;
            }
            else
            {
                _local_5 = _luaP_opmodes;
                _local_1 = (_local_1 << 2);
                _local_1 = (_local_1 + _local_2);
                _local_2 = li32(_local_1 + -4);
                _local_2 = (_local_2 & 0x3F);
                _local_2 = (_local_5 + _local_2);
                _local_2 = li8(_local_2);
                _local_2 = (_local_2 << 24);
                _local_2 = (_local_2 >> 24);
                _local_1 = (_local_1 + -4);
                _local_1 = ((_local_2 > -1) ? _local_3 : _local_1);
            };
            _local_2 = li32(_local_1);
            _local_3 = (_local_2 & 0x3F);
            if (!(!(_local_3 == 27)))
            {
                if (!(_local_4 == 0xFF))
                {
                    _local_3 = (_local_2 >>> 23);
                    if (!(_local_3 == _local_4))
                    {
                        _local_3 = 1;
                        _local_4 = (_local_4 << 6);
                        _local_4 = (_local_4 & 0x3FC0);
                        _local_2 = (_local_2 & 0xFFFFC03F);
                        _local_2 = (_local_2 | _local_4);
                        
                    _label_1: 
                        si32(_local_2, _local_1);
                        mstate.eax = _local_3;
                        goto _label_2;
                    };
                };
                _local_3 = 1;
                _local_4 = (_local_2 | 0x1A);
                _local_2 = (_local_2 >>> 17);
                _local_4 = (_local_4 & 0x7FC01A);
                _local_2 = (_local_2 & 0x7FC0);
                _local_2 = (_local_4 | _local_2);
                goto _label_1;
            };
            _local_1 = 0;
            mstate.eax = _local_1;
            
        _label_2: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

