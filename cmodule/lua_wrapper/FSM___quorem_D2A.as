package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___quorem_D2A extends Machine 
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
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 8);
            _local_2 = li32(mstate.ebp + 12);
            _local_3 = li32(_local_2 + 16);
            _local_4 = li32(_local_1 + 16);
            _local_5 = (_local_1 + 16);
            _local_6 = (_local_2 + 16);
            _local_7 = _local_2;
            _local_8 = _local_1;
            if (!(_local_4 >= _local_3))
            {
                _local_1 = 0;
                
            _label_1: 
                mstate.eax = _local_1;
                goto _label_7;
            };
            _local_9 = (_local_3 + -1);
            _local_10 = (_local_9 << 2);
            _local_11 = (_local_2 + _local_10);
            _local_11 = li32(_local_11 + 20);
            _local_10 = (_local_1 + _local_10);
            _local_12 = li32(_local_10 + 20);
            _local_11 = (_local_11 + 1);
            _local_10 = (_local_10 + 20);
            _local_11 = int((uint(_local_12) / uint(_local_11)));
            if (!(!(_local_11 == 0)))
            {
                
            _label_2: 
                _local_3 = _local_4;
                _local_4 = _local_9;
                goto _label_4;
            };
            _local_12 = 20;
            _local_13 = 0;
            _local_14 = _local_13;
            _local_15 = _local_13;
            _local_16 = _local_13;
            _local_17 = _local_11;
            _local_18 = _local_15;
            _local_19 = _local_14;
            do 
            {
                _local_20 = 0;
                _local_21 = (_local_7 + _local_12);
                mstate.esp = (mstate.esp - 16);
                _local_21 = li32(_local_21);
                si32(_local_21, mstate.esp);
                si32(_local_20, (mstate.esp + 4));
                si32(_local_17, (mstate.esp + 8));
                si32(_local_13, (mstate.esp + 12));
                mstate.esp = (mstate.esp - 4);
                (mstate.funcs[___muldi3]());
                _local_21 = mstate.eax;
                _local_22 = mstate.edx;
                _local_23 = (_local_8 + _local_12);
                _local_24 = li32(_local_23);
                _local_15 = __addc(_local_21, _local_15);
                _local_14 = __adde(_local_22, _local_14);
                _local_15 = __subc(_local_24, _local_15);
                _local_21 = __sube(_local_20, _local_20);
                _local_15 = __subc(_local_15, _local_18);
                _local_18 = __sube(_local_21, _local_19);
                si32(_local_15, _local_23);
                _local_15 = (_local_18 & 0x01);
                _local_12 = (_local_12 + 4);
                _local_16 = (_local_16 + 1);
                mstate.esp = (mstate.esp + 16);
                _local_19 = _local_20;
                if ((_local_16 > _local_9)) break;
                _local_18 = _local_15;
                _local_15 = _local_14;
                _local_14 = _local_20;
            } while (true);
            _local_10 = li32(_local_10);
            if (!(_local_10 == 0)) goto _label_2;
            _local_4 = (_local_3 + -2);
            if (!(_local_4 > 0))
            {
                _local_3 = _local_9;
            }
            else
            {
                _local_10 = 0;
                _local_12 = (_local_3 << 2);
                _local_12 = (_local_8 + _local_12);
                _local_12 = (_local_12 + 12);
                _local_3 = (_local_3 + -1);
                while ((_local_12 = _local_3), (_local_3 = _local_10), (_local_10 = li32(_local_13 = _local_12)), (_local_10 == 0))
                {
                    _local_10 = (_local_13 + -4);
                    _local_13 = (_local_12 + -1);
                    _local_14 = (_local_3 + 1);
                    _local_3 = (_local_3 ^ 0xFFFFFFFF);
                    _local_3 = (_local_4 + _local_3);
                    if (!(_local_3 > 0))
                    {
                        _local_3 = _local_13;
                        goto _label_3;
                    };
                    _local_12 = _local_10;
                    _local_3 = _local_13;
                    _local_10 = _local_14;
                };
                _local_3 = _local_12;
            };
            
        _label_3: 
            _local_4 = _local_3;
            si32(_local_4, _local_5);
            _local_3 = _local_4;
            
        _label_4: 
            _local_6 = li32(_local_6);
            _local_10 = (_local_3 - _local_6);
            if (!(_local_3 == _local_6))
            {
                _local_2 = _local_10;
            }
            else
            {
                _local_3 = 0;
                
            _label_5: 
                _local_10 = (_local_3 ^ 0xFFFFFFFF);
                _local_10 = (_local_6 + _local_10);
                _local_12 = (_local_10 << 2);
                _local_13 = (_local_1 + _local_12);
                _local_12 = (_local_2 + _local_12);
                _local_13 = li32(_local_13 + 20);
                _local_12 = li32(_local_12 + 20);
                if (!(_local_13 == _local_12))
                {
                    _local_2 = ((uint(_local_13) < uint(_local_12)) ? -1 : 1);
                }
                else
                {
                    _local_3 = (_local_3 + 1);
                    if (_local_10 > 0) goto _label_8;
                    _local_2 = 0;
                };
            };
            if (!(_local_2 > -1))
            {
                _local_1 = _local_11;
                goto _label_1;
            };
            _local_2 = 0;
            _local_3 = 20;
            _local_6 = (_local_11 + 1);
            _local_10 = _local_2;
            _local_11 = _local_2;
            _local_12 = _local_11;
            _local_13 = _local_10;
            do 
            {
                _local_14 = 0;
                _local_15 = (_local_7 + _local_3);
                _local_15 = li32(_local_15);
                _local_16 = (_local_8 + _local_3);
                _local_17 = li32(_local_16);
                _local_11 = __addc(_local_15, _local_11);
                _local_10 = __adde(_local_10, _local_14);
                _local_11 = __subc(_local_17, _local_11);
                _local_15 = __sube(_local_14, _local_14);
                _local_11 = __subc(_local_11, _local_12);
                _local_12 = __sube(_local_15, _local_13);
                si32(_local_11, _local_16);
                _local_11 = (_local_12 & 0x01);
                _local_3 = (_local_3 + 4);
                _local_2 = (_local_2 + 1);
                _local_13 = _local_14;
                if ((_local_2 > _local_9)) break;
                _local_12 = _local_11;
                _local_11 = _local_10;
                _local_10 = _local_14;
            } while (true);
            _local_2 = (_local_4 << 2);
            _local_2 = (_local_1 + _local_2);
            _local_2 = li32(_local_2 + 20);
            if (!(_local_2 == 0))
            {
                _local_1 = _local_6;
                goto _label_1;
            };
            _local_2 = 0;
            while (if ((_local_3 = (_local_4 + (_local_3 = (_local_2 ^ 0xFFFFFFFF)))) < 1) goto _label_6;
, ((_local_3 = li32((_local_3 = (_local_1 + (_local_3 = (_local_3 << 2)))) + 20)) == 0))
            {
                _local_2 = (_local_2 + 1);
            };
            
        _label_6: 
            _local_1 = (_local_4 - _local_2);
            si32(_local_1, _local_5);
            mstate.eax = _local_6;
            
        _label_7: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_8: 
            goto _label_5;
        }


    }
} cmodule.lua_wrapper

