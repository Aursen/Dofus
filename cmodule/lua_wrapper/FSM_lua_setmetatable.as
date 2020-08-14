package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_setmetatable extends Machine 
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
            _local_1 = li32(mstate.ebp + 8);
            mstate.esp = (mstate.esp - 8);
            _local_2 = li32(mstate.ebp + 12);
            si32(_local_1, mstate.esp);
            si32(_local_2, (mstate.esp + 4));
            mstate.esp = (mstate.esp - 4);
            FSM_index2adr.start();
            _local_2 = mstate.eax;
            mstate.esp = (mstate.esp + 8);
            _local_3 = li32(_local_1 + 8);
            _local_4 = li32(_local_3 + -4);
            _local_5 = (_local_1 + 8);
            if (!(!(_local_4 == 0)))
            {
                _local_3 = 0;
            }
            else
            {
                _local_3 = li32(_local_3 + -12);
            };
            _local_4 = li32(_local_2 + 8);
            if (!(_local_4 == 7))
            {
                if (!(_local_4 == 5)) goto _label_2;
                _local_4 = li32(_local_2);
                si32(_local_3, (_local_4 + 8));
                if (_local_3 == 0) goto _label_3;
                _local_3 = li8(_local_3 + 5);
                _local_3 = (_local_3 & 0x03);
                if (_local_3 == 0) goto _label_3;
                _local_2 = li32(_local_2);
                _local_3 = li8(_local_2 + 5);
                _local_4 = (_local_2 + 5);
                _local_6 = (_local_3 & 0x04);
                if (_local_6 == 0) goto _label_3;
                _local_1 = li32(_local_1 + 16);
                _local_3 = (_local_3 & 0xFFFFFFFB);
                si8(_local_3, _local_4);
                _local_3 = li32(_local_1 + 40);
                si32(_local_3, (_local_2 + 24));
                si32(_local_2, (_local_1 + 40));
            }
            else
            {
                _local_4 = li32(_local_2);
                si32(_local_3, (_local_4 + 8));
                _local_4 = _local_2;
                if (_local_3 == 0) goto _label_3;
                _local_2 = li8(_local_3 + 5);
                _local_2 = (_local_2 & 0x03);
                if (_local_2 == 0) goto _label_3;
                _local_4 = li32(_local_4);
                _local_2 = li8(_local_4 + 5);
                _local_4 = (_local_4 + 5);
                _local_6 = (_local_2 & 0x04);
                if (_local_6 == 0) goto _label_3;
                _local_1 = li32(_local_1 + 16);
                _local_6 = li8(_local_1 + 21);
                if (!(!(_local_6 == 1)))
                {
                    mstate.esp = (mstate.esp - 8);
                    si32(_local_1, mstate.esp);
                    si32(_local_3, (mstate.esp + 4));
                    mstate.esp = (mstate.esp - 4);
                    FSM_reallymarkobject.start();
                    mstate.esp = (mstate.esp + 8);
                }
                else
                {
                    _local_1 = li8(_local_1 + 20);
                    _local_3 = (_local_2 & 0xFFFFFFF8);
                    _local_1 = (_local_1 & 0x03);
                    _local_1 = (_local_1 | _local_3);
                    si8(_local_1, _local_4);
                };
            };
            
        _label_1: 
            _local_1 = li32(_local_5);
            _local_1 = (_local_1 + -12);
            si32(_local_1, _local_5);
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_2: 
            _local_1 = li32(_local_1 + 16);
            _local_2 = (_local_4 << 2);
            _local_1 = (_local_1 + _local_2);
            si32(_local_3, (_local_1 + 132));
            
        _label_3: 
            goto _label_1;
        }


    }
} cmodule.lua_wrapper

