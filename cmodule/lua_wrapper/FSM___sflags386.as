package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___sflags386 extends Machine 
    {


        public static function start():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = sxi8(li8(mstate.ebp + 12));
            _local_2 = sxi8(li8(mstate.ebp + 16));
            _local_3 = li32(mstate.ebp + 20);
            _local_4 = sxi8(li8(mstate.ebp + 8));
            if (!(_local_4 == 97))
            {
                if (_local_4 == 114) goto _label_2;
                if (!(_local_4 == 119)) goto _label_1;
                _local_4 = (_local_1 & 0xFF);
                if (!(_local_4 == 43))
                {
                    _local_4 = 8;
                    _local_5 = 0x0600;
                    _local_6 = 1;
                    goto _label_3;
                };
                _local_1 = 0x0600;
                goto _label_4;
            };
            _local_4 = (_local_1 & 0xFF);
            if (!(_local_4 == 43))
            {
                _local_4 = 8;
                _local_5 = 520;
                _local_6 = 1;
            }
            else
            {
                _local_1 = 520;
                goto _label_4;
                
            _label_1: 
                _local_1 = 22;
                si32(_local_1, _val_2E_1440);
                _local_1 = 0;
                mstate.eax = _local_1;
                goto _label_5;
                
            _label_2: 
                _local_4 = (_local_1 & 0xFF);
                if (_local_4 == 43) goto _label_6;
                _local_4 = 4;
                _local_5 = 0;
                _local_6 = _local_5;
            };
            
        _label_3: 
            _local_1 = (_local_1 & 0xFF);
            if (!(!(_local_1 == 98)))
            {
                _local_1 = (_local_2 & 0xFF);
                if (!(!(_local_1 == 43)))
                {
                    _local_1 = _local_5;
                    
                _label_4: 
                    _local_4 = _local_1;
                    _local_5 = 16;
                    _local_4 = (_local_4 | 0x02);
                    si32(_local_4, _local_3);
                    mstate.eax = _local_5;
                    goto _label_5;
                };
            };
            _local_1 = (_local_5 | _local_6);
            si32(_local_1, _local_3);
            mstate.eax = _local_4;
            
        _label_5: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_6: 
            _local_1 = 0;
            goto _label_4;
        }


    }
} cmodule.lua_wrapper

