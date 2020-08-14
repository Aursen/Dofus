package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_mainposition extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Number;
            var _local_7:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 8);
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(_local_1 + 8);
            _local_3 = li32(mstate.ebp + 8);
            if (!(_local_2 > 2))
            {
                if (_local_2 == 1) goto _label_1;
                if (!(_local_2 == 2)) goto _label_5;
                _local_2 = 1;
                _local_4 = li8(_local_3 + 7);
                _local_2 = (_local_2 << _local_4);
                _local_2 = (_local_2 + -1);
                _local_1 = li32(_local_1);
                _local_2 = (_local_2 | 0x01);
                _local_1 = (uint(_local_1) % uint(_local_2));
                goto _label_3;
            };
            if (!(_local_2 == 4))
            {
                if (!(_local_2 == 3)) goto _label_5;
                _local_6 = 0;
                _local_7 = lf64(_local_1);
                sf64(_local_7, (mstate.ebp + -8));
                _local_1 = li32(mstate.ebp + -8);
                _local_2 = li32(mstate.ebp + -4);
                if (!(!(_local_7 == _local_6)))
                {
                    _local_1 = li32(_local_3 + 16);
                    goto _label_4;
                };
                _local_4 = 1;
                _local_5 = li8(_local_3 + 7);
                _local_4 = (_local_4 << _local_5);
                _local_4 = (_local_4 + -1);
                _local_4 = (_local_4 | 0x01);
                _local_1 = (_local_2 + _local_1);
                _local_1 = (uint(_local_1) % uint(_local_4));
            }
            else
            {
                _local_2 = 1;
                _local_4 = li8(_local_3 + 7);
                _local_2 = (_local_2 << _local_4);
                _local_1 = li32(_local_1);
                _local_1 = li32(_local_1 + 8);
                goto _label_2;
                
            _label_1: 
                _local_2 = 1;
                _local_4 = li8(_local_3 + 7);
                _local_2 = (_local_2 << _local_4);
                _local_1 = li32(_local_1);
                
            _label_2: 
                _local_2 = (_local_2 + -1);
                _local_1 = (_local_2 & _local_1);
            };
            
        _label_3: 
            _local_3 = li32(_local_3 + 16);
            _local_1 = (_local_1 * 28);
            _local_1 = (_local_3 + _local_1);
            do 
            {
                
            _label_4: 
                mstate.eax = _local_1;
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
                
            _label_5: 
                _local_2 = 1;
                _local_4 = li8(_local_3 + 7);
                _local_2 = (_local_2 << _local_4);
                _local_2 = (_local_2 + -1);
                _local_1 = li32(_local_1);
                _local_2 = (_local_2 | 0x01);
                _local_1 = (uint(_local_1) % uint(_local_2));
                _local_2 = li32(_local_3 + 16);
                _local_1 = (_local_1 * 28);
                _local_1 = (_local_2 + _local_1);
            } while (true);
        }


    }
} cmodule.lua_wrapper

