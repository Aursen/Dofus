package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_getstack390 extends Machine 
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
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = li32(mstate.ebp + 20);
            _local_5 = _local_1;
            if (!(_local_3 < 1))
            {
                _local_6 = 0;
            }
            else
            {
                goto _label_2;
                
            _label_1: 
                _local_7 = li32(_local_5 + 4);
                _local_7 = li32(_local_7);
                _local_7 = li8(_local_7 + 6);
                _local_3 = (_local_3 + -1);
                if ((_local_7 == 0))
                {
                    _local_7 = li32(_local_5 + 20);
                    _local_3 = (_local_3 - _local_7);
                };
                _local_7 = (_local_6 ^ 0xFFFFFFFF);
                _local_7 = (_local_7 * 24);
                _local_5 = (_local_5 + -24);
                _local_6 = (_local_6 + 1);
                _local_7 = (_local_1 + _local_7);
                if (_local_3 < 1) goto _label_4;
            };
            _local_7 = _local_5;
            if (uint(_local_5) > uint(_local_2)) goto _label_1;
            _local_1 = _local_7;
            do 
            {
                
            _label_2: 
                if (!(!(_local_3 == 0)))
                {
                    if (!(uint(_local_1) <= uint(_local_2)))
                    {
                        _local_3 = 1;
                        _local_1 = (_local_1 - _local_2);
                        _local_1 = int((_local_1 / 24));
                        si32(_local_1, (_local_4 + 96));
                        mstate.eax = _local_3;
                        goto _label_3;
                    };
                };
                if (!(_local_3 > -1))
                {
                    _local_1 = 0;
                    si32(_local_1, (_local_4 + 96));
                    _local_1 = 1;
                }
                else
                {
                    _local_1 = 0;
                };
                mstate.eax = _local_1;
                
            _label_3: 
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
                
            _label_4: 
                _local_1 = _local_7;
            } while (true);
        }


    }
}

