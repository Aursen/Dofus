package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_strlcpy extends Machine 
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
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = _local_2;
            _local_5 = _local_1;
            if (!(!(_local_3 == 0)))
            {
                _local_5 = _local_3;
            }
            else
            {
                _local_6 = (_local_3 + -1);
                if (_local_3 == 1) goto _label_5;
                _local_6 = 0;
                _local_7 = _local_3;
                do 
                {
                    _local_8 = (_local_4 + _local_6);
                    _local_8 = li8(_local_8);
                    _local_9 = (_local_5 + _local_6);
                    si8(_local_8, _local_9);
                    _local_9 = (_local_6 + 1);
                    if (_local_8 == 0) goto _label_1;
                    _local_7 = (_local_7 + -1);
                    _local_6 = (_local_6 + 1);
                } while (!(_local_7 == 1));
                _local_5 = (_local_7 + -1);
                goto _label_2;
                
            _label_1: 
                _local_5 = (_local_7 + -1);
                
            _label_2: 
                _local_2 = (_local_2 + _local_9);
                _local_1 = (_local_1 + _local_9);
            };
            
        _label_3: 
            _local_6 = _local_2;
            if (!(_local_5 == 0))
            {
                _local_1 = _local_2;
            }
            else
            {
                if (!(!(_local_3 == 0)))
                {
                    _local_1 = 0;
                }
                else
                {
                    _local_3 = 0;
                    si8(_local_3, _local_1);
                    _local_1 = _local_3;
                };
                
            _label_4: 
                _local_3 = (_local_6 + _local_1);
                _local_3 = li8(_local_3);
                _local_1 = (_local_1 + 1);
                if (!(_local_3 == 0)) goto _label_4;
                _local_1 = (_local_2 + _local_1);
            };
            _local_2 = (_local_4 ^ 0xFFFFFFFF);
            _local_1 = (_local_1 + _local_2);
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_5: 
            _local_5 = _local_6;
            goto _label_3;
        }


    }
} cmodule.lua_wrapper

