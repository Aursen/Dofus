package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_getobjname extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li32(mstate.ebp + 12);
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(mstate.ebp + 16);
            _local_4 = li32(mstate.ebp + 20);
            _local_5 = (_local_1 + 12);
            _local_6 = (_local_2 + 24);
            _local_2 = (_local_2 + 20);
            _local_7 = (_local_1 + 4);
            do 
            {
                _local_8 = li32(_local_7);
                _local_9 = li32(_local_8 + 8);
                if (!(_local_9 == 6))
                {
                    
                _label_1: 
                    _local_3 = 0;
                    
                _label_2: 
                    _local_1 = _local_3;
                    goto _label_14;
                };
                _local_10 = li32(_local_8);
                _local_11 = li8(_local_10 + 6);
                if (!(_local_11 == 0)) goto _label_1;
                _local_10 = li32(_local_10 + 16);
                if (!(!(_local_9 == 6)))
                {
                    _local_9 = (_local_11 & 0xFF);
                    if (_local_9 == 0) goto _label_3;
                };
                _local_8 = -1;
                goto _label_4;
                
            _label_3: 
                _local_9 = li32(_local_2);
                if (!(!(_local_9 == _local_1)))
                {
                    _local_9 = li32(_local_6);
                    si32(_local_9, _local_5);
                };
                _local_8 = li32(_local_8);
                _local_8 = li32(_local_8 + 16);
                _local_9 = li32(_local_5);
                _local_8 = li32(_local_8 + 12);
                _local_8 = (_local_9 - _local_8);
                _local_8 = (_local_8 >> 2);
                _local_8 = (_local_8 + -1);
                
            _label_4: 
                _local_9 = li32(_local_10 + 24);
                _local_11 = li32(_local_10 + 56);
                mstate.esp = (mstate.esp - 16);
                _local_12 = (_local_3 + 1);
                si32(_local_9, mstate.esp);
                si32(_local_11, (mstate.esp + 4));
                si32(_local_12, (mstate.esp + 8));
                si32(_local_8, (mstate.esp + 12));
                mstate.esp = (mstate.esp - 4);
                FSM_luaF_getlocalname388.start();
                _local_9 = mstate.eax;
                mstate.esp = (mstate.esp + 16);
                si32(_local_9, _local_4);
                if (!(_local_9 == 0))
                {
                    _local_3 = __2E_str37260;
                    goto _label_2;
                };
                mstate.esp = (mstate.esp - 12);
                si32(_local_10, mstate.esp);
                si32(_local_8, (mstate.esp + 4));
                si32(_local_3, (mstate.esp + 8));
                mstate.esp = (mstate.esp - 4);
                FSM_symbexec.start();
                _local_3 = mstate.eax;
                mstate.esp = (mstate.esp + 12);
                _local_8 = (_local_3 & 0x3F);
                if (!(_local_8 > 4))
                {
                    if (_local_8 == 0) goto _label_6;
                    if (!(_local_8 == 4)) goto _label_1;
                    _local_10 = li32(_local_10 + 28);
                    if (_local_10 == 0) goto _label_9;
                    _local_1 = __2E_str6263;
                    _local_3 = (_local_3 & 0xFF800000);
                    _local_3 = (_local_3 >>> 21);
                    _local_3 = (_local_10 + _local_3);
                    
                _label_5: 
                    _local_3 = li32(_local_3);
                    _local_3 = (_local_3 + 16);
                    goto _label_13;
                };
                if (_local_8 == 11) goto _label_10;
                if ((_local_8 == 6)) break;
                if (!(_local_8 == 5)) goto _label_1;
                _local_1 = __2E_str48261;
                _local_3 = (_local_3 >>> 14);
                _local_2 = li32(_local_10 + 8);
                _local_3 = (_local_3 * 12);
                _local_3 = (_local_2 + _local_3);
                goto _label_5;
                
            _label_6: 
                _local_10 = (_local_3 >>> 6);
                _local_3 = (_local_3 >>> 23);
                _local_10 = (_local_10 & 0xFF);
                if (_local_3 >= _local_10) goto _label_1;
            } while (true);
            _local_3 = (_local_3 >>> 14);
            _local_1 = (_local_3 & 0x0100);
            if (!(!(_local_1 == 0)))
            {
                
            _label_7: 
                _local_3 = __2E_str6354;
                goto _label_8;
            };
            _local_3 = (_local_3 & 0xFF);
            _local_10 = li32(_local_10 + 8);
            _local_1 = (_local_3 * 12);
            _local_1 = (_local_10 + _local_1);
            _local_1 = li32(_local_1 + 8);
            if (!(_local_1 == 4)) goto _label_7;
            _local_3 = (_local_3 * 12);
            _local_3 = (_local_10 + _local_3);
            _local_3 = li32(_local_3);
            _local_3 = (_local_3 + 16);
            
        _label_8: 
            _local_10 = __2E_str59262;
            si32(_local_3, _local_4);
            mstate.eax = _local_10;
            goto _label_15;
            
        _label_9: 
            _local_3 = __2E_str6354;
            si32(_local_3, _local_4);
            _local_3 = __2E_str6263;
            mstate.eax = _local_3;
            goto _label_15;
            
        _label_10: 
            _local_3 = (_local_3 >>> 14);
            _local_1 = (_local_3 & 0x0100);
            if (!(!(_local_1 == 0)))
            {
                
            _label_11: 
                _local_3 = __2E_str6354;
                goto _label_12;
            };
            _local_3 = (_local_3 & 0xFF);
            _local_1 = li32(_local_10 + 8);
            _local_2 = (_local_3 * 12);
            _local_2 = (_local_1 + _local_2);
            _local_2 = li32(_local_2 + 8);
            if (!(_local_2 == 4)) goto _label_11;
            _local_3 = (_local_3 * 12);
            _local_3 = (_local_1 + _local_3);
            _local_3 = li32(_local_3);
            _local_3 = (_local_3 + 16);
            
        _label_12: 
            _local_1 = __2E_str7264;
            
        _label_13: 
            si32(_local_3, _local_4);
            
        _label_14: 
            mstate.eax = _local_1;
            
        _label_15: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

