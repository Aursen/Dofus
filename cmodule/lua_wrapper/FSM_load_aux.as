package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_load_aux extends Machine 
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
            var _local_8:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            if (!(_local_2 == 0))
            {
                _local_2 = 0;
                _local_3 = li32(_local_1 + 8);
                si32(_local_2, (_local_3 + 8));
                _local_2 = li32(_local_1 + 8);
                _local_2 = (_local_2 + 12);
                si32(_local_2, (_local_1 + 8));
                mstate.esp = (mstate.esp - 8);
                _local_2 = -2;
                si32(_local_1, mstate.esp);
                si32(_local_2, (mstate.esp + 4));
                mstate.esp = (mstate.esp - 4);
                FSM_index2adr.start();
                _local_2 = mstate.eax;
                mstate.esp = (mstate.esp + 8);
                _local_3 = li32(_local_1 + 8);
                _local_1 = (_local_1 + 8);
                _local_4 = _local_3;
                if (!(uint(_local_3) <= uint(_local_2)))
                {
                    _local_5 = 0;
                    do 
                    {
                        _local_6 = (_local_5 ^ 0xFFFFFFFF);
                        _local_6 = (_local_6 * 12);
                        _local_6 = (_local_4 + _local_6);
                        _local_8 = lf64(_local_6);
                        sf64(_local_8, _local_3);
                        _local_7 = li32(_local_6 + 8);
                        si32(_local_7, (_local_3 + 8));
                        _local_3 = (_local_3 + -12);
                        _local_5 = (_local_5 + 1);
                    } while (!(uint(_local_6) <= uint(_local_2)));
                };
                _local_3 = 2;
                _local_1 = li32(_local_1);
                _local_8 = lf64(_local_1);
                sf64(_local_8, _local_2);
                _local_1 = li32(_local_1 + 8);
                si32(_local_1, (_local_2 + 8));
                mstate.eax = _local_3;
            }
            else
            {
                _local_1 = 1;
                mstate.eax = _local_1;
            };
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

