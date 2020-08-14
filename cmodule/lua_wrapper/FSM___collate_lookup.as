package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___collate_lookup extends Machine 
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
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = 1;
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 20);
            si32(_local_1, _local_2);
            _local_1 = 0;
            _local_4 = li32(mstate.ebp + 16);
            si32(_local_1, _local_3);
            si32(_local_1, _local_4);
            _local_1 = li32(___collate_chain_pri_table);
            _local_5 = li8(_local_1);
            _local_6 = li32(mstate.ebp + 8);
            _local_7 = _local_1;
            _local_8 = _local_6;
            if (!(_local_5 == 0))
            {
                _local_5 = 0;
                _local_9 = li8(_local_6);
                do 
                {
                    _local_10 = li8(_local_1);
                    _local_11 = _local_1;
                    _local_12 = (_local_9 & 0xFF);
                    if ((!(_local_12 == _local_10))) continue;
                    _local_12 = (_local_10 & 0xFF);
                    if (_local_12 == 0) goto _label_3;
                    _local_12 = _local_1;
                    do 
                    {
                        _local_13 = li8(_local_12 + 1);
                        _local_12 = (_local_12 + 1);
                        _local_14 = _local_12;
                        if (_local_13 == 0) goto _label_4;
                        _local_12 = _local_14;
                    } while (true);
                    
                _label_1: 
                    _local_1 = (_local_10 & 0xFF);
                    if (_local_1 == 0) goto _label_5;
                    _local_1 = 1;
                    do 
                    {
                        _local_6 = (_local_5 * 20);
                        _local_6 = (_local_7 + _local_6);
                        _local_6 = (_local_6 + _local_1);
                        _local_8 = li8(_local_6);
                        _local_1 = (_local_1 + 1);
                    } while (!(_local_8 == 0));
                    _local_1 = _local_6;
                    
                _label_2: 
                    _local_5 = (_local_5 * 20);
                    _local_1 = (_local_1 - _local_13);
                    si32(_local_1, _local_2);
                    _local_1 = (_local_7 + _local_5);
                    _local_5 = li32(_local_1 + 12);
                    si32(_local_5, _local_4);
                    _local_1 = li32(_local_1 + 16);
                } while (si32(_local_1, _local_3), (mstate.esp = mstate.ebp), (mstate.ebp = li32(mstate.esp)), (mstate.esp = (mstate.esp + 4)), (mstate.esp = (mstate.esp + 4)), return, (_local_10 = li8(_local_1 + 20)), (_local_5 = (_local_5 + 1)), (_local_1 = (_local_1 + 20)), !(_local_10 == 0));
            };
            _local_1 = li8(_local_6);
            _local_2 = li32(___collate_char_pri_table_ptr);
            _local_1 = (_local_1 << 3);
            _local_1 = (_local_2 + _local_1);
            _local_1 = li32(_local_1);
            si32(_local_1, _local_4);
            _local_1 = li8(_local_6);
            _local_1 = (_local_1 << 3);
            _local_1 = (_local_2 + _local_1);
            _local_1 = li32(_local_1 + 4);
            //unresolved jump
            
        _label_3: 
            _local_12 = _local_11;
            
        _label_4: 
            _local_13 = _local_11;
            _local_14 = _local_12;
            if (_local_12 == _local_11) goto _label_1;
            _local_12 = 0;
            _local_14 = (_local_14 - _local_13);
            _local_14 = (_local_14 + 1);
            do 
            {
                _local_15 = (_local_1 + _local_12);
                _local_16 = (_local_8 + _local_12);
                _local_16 = li8(_local_16);
                _local_15 = li8(_local_15);
                //unresolved if
                _local_15 = (_local_16 & 0xFF);
                if (_local_15 == 0) goto _label_1;
                _local_14 = (_local_14 + -1);
                _local_12 = (_local_12 + 1);
                if (_local_14 == 1) goto _label_1;
            } while (true);
            
        _label_5: 
            _local_1 = _local_11;
            goto _label_2;
        }


    }
} cmodule.lua_wrapper

