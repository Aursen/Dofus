package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___fixunssfdi extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_5 = 1.84467E19;
            _local_6 = lf32(mstate.ebp + 8);
            _local_7 = _local_6;
                
            outer_block:
            {

                if (!(_local_7 >= _local_5))
                {
                    _local_5 = 0;
                    _local_7 = _local_6;
                    if (!(_local_7 < _local_5))
                    {
                        _local_1 = 0;
                        _local_5 = _local_6;
                        _local_6 = (_local_5 + -2147480000);
                        _local_6 = (_local_6 * 2.32831E-10);
                        mstate.esp = (mstate.esp - 8);
                        _local_2 = uint(_local_6);
                        si32(_local_1, mstate.esp);
                        si32(_local_2, (mstate.esp + 4));
                        mstate.esp = (mstate.esp - 4);
                        (mstate.funcs[___floatdidf]());
                        _local_6 = mstate.st0;
                        _local_5 = (_local_5 - _local_6);
                        _local_6 = 0;
                        _local_7 = (_local_5 + 4294970000);
                        _local_7 = ((_local_5 < _local_6) ? _local_7 : _local_5);
                        _local_3 = (_local_2 + -1);
                        _local_8 = 4294970000;
                        _local_9 = (_local_7 - 4294970000);
                        _local_9 = ((_local_7 > _local_8) ? _local_9 : _local_7);
                        _local_2 = ((_local_5 >= _local_6) ? _local_2 : _local_3);
                        _local_1 = ((_local_5 >= _local_6) ? 0 : _local_1);
                        _local_3 = (_local_2 + 1);
                        _local_1 = ((_local_7 <= _local_8) ? _local_1 : _local_1);
                        _local_4 = uint(_local_9);
                        mstate.esp = (mstate.esp + 8);
                        _local_1 = (_local_1 | _local_4);
                        _local_2 = ((_local_7 <= _local_8) ? _local_2 : _local_3);
                        mstate.edx = _local_2;
                        break outer_block;
                    };
                };
                _local_1 = -1;
                mstate.edx = _local_1;
            
            }//outer_block
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

