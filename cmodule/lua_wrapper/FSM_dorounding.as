package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_dorounding extends Machine 
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
            var _local_8:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = (_local_1 + _local_2);
            _local_3 = li8(_local_3);
            _local_4 = li32(mstate.ebp + 16);
            _local_5 = (_local_3 << 24);
            _local_6 = _local_1;
            _local_5 = (_local_5 >> 24);
            if (!(_local_5 > 8))
            {
                _local_3 = (_local_3 & 0xFF);
                if (!(_local_3 == 8)) goto _label_3;
                _local_3 = (_local_2 + _local_1);
                _local_3 = li8(_local_3 + -1);
                _local_3 = (_local_3 & 0x01);
                if (_local_3 == 0) goto _label_3;
            };
            _local_3 = (_local_2 + -1);
            _local_5 = (_local_1 + _local_3);
            _local_7 = li8(_local_5);
            if (!(_local_7 == 15))
            {
                _local_1 = _local_5;
            }
            else
            {
                _local_5 = 0;
                _local_2 = (_local_6 + _local_2);
                _local_2 = (_local_2 + -1);
                
            _label_1: 
                _local_6 = _local_2;
                if (_local_3 == _local_5) goto _label_2;
                _local_7 = li8(_local_6);
                _local_8 = (_local_5 ^ 0xFFFFFFFF);
                _local_7 = (_local_7 + 1);
                _local_8 = (_local_3 + _local_8);
                si8(_local_7, _local_6);
                _local_6 = (_local_1 + _local_8);
                _local_7 = li8(_local_6);
                _local_2 = (_local_2 + -1);
                _local_5 = (_local_5 + 1);
                if (_local_7 == 15) goto _label_4;
                _local_1 = _local_6;
            };
            _local_4 = _local_1;
            _local_6 = li8(_local_4);
            _local_6 = (_local_6 + 1);
            si8(_local_6, _local_4);
            goto _label_3;
            
        _label_2: 
            _local_1 = 1;
            si8(_local_1, _local_6);
            _local_1 = li32(_local_4);
            _local_1 = (_local_1 + 4);
            si32(_local_1, _local_4);
            
        _label_3: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_4: 
            goto _label_1;
        }


    }
}

