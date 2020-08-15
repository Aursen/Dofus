package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaH_get extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Number;
            var _local_6:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(_local_1 + 8);
            _local_3 = li32(mstate.ebp + 8);
            if (!(_local_2 == 0))
            {
                if (_local_2 == 3) goto _label_2;
                if (!(_local_2 == 4)) goto _label_3;
                _local_2 = 1;
                _local_4 = li8(_local_3 + 7);
                _local_2 = (_local_2 << _local_4);
                _local_1 = li32(_local_1);
                _local_4 = li32(_local_1 + 8);
                _local_2 = (_local_2 + -1);
                _local_2 = (_local_2 & _local_4);
                _local_3 = li32(_local_3 + 16);
                _local_2 = (_local_2 * 28);
                _local_3 = (_local_3 + _local_2);
                do 
                {
                    _local_2 = li32(_local_3 + 20);
                    if (!(!(_local_2 == 4)))
                    {
                        _local_2 = li32(_local_3 + 12);
                        if (!(!(_local_2 == _local_1)))
                        {
                            mstate.eax = _local_3;
                            goto _label_4;
                        };
                    };
                    _local_3 = li32(_local_3 + 24);
                    if ((_local_3 == 0)) break;
                } while (true);
            };
            
        _label_1: 
            _local_1 = _luaO_nilobject_;
            do 
            {
                mstate.eax = _local_1;
                goto _label_4;
                
            _label_2: 
                _local_5 = lf64(_local_1);
                _local_2 = int(_local_5);
                _local_6 = Number(_local_2);
                if ((!(_local_6 == _local_5))) break;
                mstate.esp = (mstate.esp - 8);
                si32(_local_3, mstate.esp);
                si32(_local_2, (mstate.esp + 4));
                mstate.esp = (mstate.esp - 4);
                FSM_luaH_getnum.start();
                _local_1 = mstate.eax;
                mstate.esp = (mstate.esp + 8);
            } while (true);
            
        _label_3: 
            mstate.esp = (mstate.esp - 8);
            si32(_local_3, mstate.esp);
            si32(_local_1, (mstate.esp + 4));
            mstate.esp = (mstate.esp - 4);
            FSM_mainposition.start();
            _local_2 = mstate.eax;
            mstate.esp = (mstate.esp + 8);
            do 
            {
                mstate.esp = (mstate.esp - 8);
                _local_3 = (_local_2 + 12);
                si32(_local_3, mstate.esp);
                si32(_local_1, (mstate.esp + 4));
                mstate.esp = (mstate.esp - 4);
                FSM_luaO_rawequalObj.start();
                _local_3 = mstate.eax;
                mstate.esp = (mstate.esp + 8);
                if (!(_local_3 == 0))
                {
                    mstate.eax = _local_2;
                    
                _label_4: 
                    mstate.esp = mstate.ebp;
                    mstate.ebp = li32(mstate.esp);
                    mstate.esp = (mstate.esp + 4);
                    mstate.esp = (mstate.esp + 4);
                    return;
                };
                _local_2 = li32(_local_2 + 24);
                if (_local_2 == 0) goto _label_1;
            } while (true);
        }


    }
}

