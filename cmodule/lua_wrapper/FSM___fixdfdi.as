package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___fixdfdi extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:Number;
            var _local_5:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_4 = 0;
            _local_5 = lf64(mstate.ebp + 8);
            if (!(_local_5 >= _local_4))
            {
                _local_4 = -9223370000000000000;
                if (_local_5 > _local_4) goto _label_1;
                _local_1 = -2147483648;
                _local_2 = 0;
                goto _label_2;
            };
            _local_4 = 9223370000000000000;
            if (!(_local_5 < _local_4))
            {
                _local_1 = 2147483647;
                _local_2 = -1;
            }
            else
            {
                mstate.esp = (mstate.esp - 8);
                sf64(_local_5, mstate.esp);
                mstate.esp = (mstate.esp - 4);
                (mstate.funcs[___fixunsdfdi]());
                _local_1 = mstate.eax;
                _local_2 = mstate.edx;
                mstate.esp = (mstate.esp + 8);
                mstate.edx = _local_2;
                mstate.eax = _local_1;
                goto _label_3;
                
            _label_1: 
                _local_1 = 0;
                mstate.esp = (mstate.esp - 8);
                _local_5 = -(_local_5);
                sf64(_local_5, mstate.esp);
                mstate.esp = (mstate.esp - 4);
                (mstate.funcs[___fixunsdfdi]());
                _local_2 = mstate.eax;
                _local_3 = mstate.edx;
                mstate.esp = (mstate.esp + 8);
                _local_2 = __subc(_local_1, _local_2);
                _local_1 = __sube(_local_1, _local_3);
            };
            
        _label_2: 
            mstate.edx = _local_1;
            mstate.eax = _local_2;
            
        _label_3: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

