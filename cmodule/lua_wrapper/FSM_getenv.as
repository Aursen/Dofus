package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_getenv extends Machine 
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
            var _local_9:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            if (!(!(_local_1 == 0)))
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
            _local_2 = li32(_environ);
            _local_3 = _local_2;
            if (_local_2 == 0) goto _label_1;
            _local_4 = _local_1;
            while ((_local_6 = _local_4), if ((_local_5 = li8(_local_4)) == 0) goto _label_3;
, (_local_5 = (_local_5 & 0xFF)), (!(_local_5 == 61)))
            {
                _local_4 = (_local_4 + 1);
            };
            
        _label_3: 
            _local_3 = li32(_local_3);
            if (_local_3 == 0) goto _label_1;
            _local_2 = (_local_2 + 4);
            _local_4 = (_local_6 - _local_1);
            _loop_1:
            do 
            {
                _local_5 = 0;
                _local_6 = _local_2;
                while (if (_local_4 == _local_8) goto _label_5;
, !((_local_7 = li8(_local_7 = (_local_3 + _local_8))) == 0))
                {
                    _local_5 = li8(_local_5);
                    _local_9 = (_local_8 + 1);
                    _local_7 = (_local_7 & 0xFF);
                    if ((!(_local_7 == _local_5))) break _loop_1;
                    _local_5 = _local_9;
                };
                _local_3 = (_local_3 + _local_8);
                
            _label_4: 
                if (!(!(_local_4 == _local_8)))
                {
                    _local_5 = li8(_local_3);
                    _local_3 = (_local_3 + 1);
                    if (!(!(_local_5 == 61)))
                    {
                        _local_1 = _local_3;
                        goto _label_2;
                    };
                };
                _local_3 = li32(_local_6);
                _local_2 = (_local_2 + 4);
                if (_local_3 == 0) goto _label_1;
            } while (true);
            _local_3 = (_local_3 + _local_9);
            goto _label_4;
            
        _label_5: 
            _local_3 = (_local_3 + _local_8);
            goto _label_4;
        }


    }
}

