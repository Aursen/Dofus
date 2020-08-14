package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___ratio_D2A extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:Number;
            var _local_8:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 40);
            _local_1 = (mstate.ebp + -8);
            mstate.esp = (mstate.esp - 8);
            _local_2 = li32(mstate.ebp + 8);
            si32(_local_2, mstate.esp);
            si32(_local_1, (mstate.esp + 4));
            mstate.esp = (mstate.esp - 4);
            FSM___b2d_D2A.start();
            _local_7 = mstate.st0;
            mstate.esp = (mstate.esp + 8);
            mstate.esp = (mstate.esp - 8);
            _local_1 = li32(mstate.ebp + 12);
            _local_3 = (mstate.ebp + -4);
            si32(_local_1, mstate.esp);
            si32(_local_3, (mstate.esp + 4));
            mstate.esp = (mstate.esp - 4);
            FSM___b2d_D2A.start();
            _local_8 = mstate.st0;
            mstate.esp = (mstate.esp + 8);
            _local_2 = li32(_local_2 + 16);
            _local_1 = li32(_local_1 + 16);
            _local_1 = (_local_2 - _local_1);
            _local_2 = li32(mstate.ebp + -8);
            _local_3 = li32(mstate.ebp + -4);
            sf64(_local_7, (mstate.ebp + -16));
            sf64(_local_8, (mstate.ebp + -24));
            _local_1 = (_local_1 << 5);
            _local_2 = (_local_2 - _local_3);
            _local_3 = li32(mstate.ebp + -16);
            _local_4 = li32(mstate.ebp + -12);
            _local_5 = li32(mstate.ebp + -24);
            _local_6 = li32(mstate.ebp + -20);
            _local_1 = (_local_1 + _local_2);
            if (!(_local_1 < 1))
            {
                _local_1 = (_local_1 << 20);
                _local_1 = (_local_1 + _local_4);
                si32(_local_3, (mstate.ebp + -32));
                si32(_local_1, (mstate.ebp + -28));
                _local_7 = lf64(mstate.ebp + -32);
                
            _label_1: 
                _local_7 = (_local_7 / _local_8);
                mstate.st0 = _local_7;
                mstate.esp = mstate.ebp;
                mstate.ebp = li32(mstate.esp);
                mstate.esp = (mstate.esp + 4);
                mstate.esp = (mstate.esp + 4);
                return;
            };
            _local_1 = (_local_1 << 20);
            _local_1 = (_local_6 - _local_1);
            si32(_local_5, (mstate.ebp + -40));
            si32(_local_1, (mstate.ebp + -36));
            _local_8 = lf64(mstate.ebp + -40);
            goto _label_1;
        }


    }
} cmodule.lua_wrapper

