package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_reallymarkobject extends Machine 
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
            _local_2 = li32(mstate.ebp + 12);
            do 
            {
                _local_3 = li8(_local_2 + 5);
                _local_3 = (_local_3 & 0xFFFFFFFC);
                si8(_local_3, (_local_2 + 5));
                _local_4 = li8(_local_2 + 4);
                _local_5 = (_local_2 + 5);
                if ((_local_4 > 7)) break;
                if (_local_4 == 5) goto _label_2;
                if (_local_4 == 6) goto _label_1;
                if (!(_local_4 == 7)) goto _label_4;
                _local_4 = li32(_local_2 + 8);
                _local_3 = (_local_3 | 0x04);
                si8(_local_3, _local_5);
                if (!(_local_4 == 0))
                {
                    _local_5 = li8(_local_4 + 5);
                    _local_5 = (_local_5 & 0x03);
                    if (!(_local_5 == 0))
                    {
                        mstate.esp = (mstate.esp - 8);
                        si32(_local_1, mstate.esp);
                        si32(_local_4, (mstate.esp + 4));
                        mstate.esp = (mstate.esp - 4);
                        FSM_reallymarkobject.start();
                        mstate.esp = (mstate.esp + 8);
                    };
                };
                _local_2 = li32(_local_2 + 12);
                _local_5 = li8(_local_2 + 5);
                _local_5 = (_local_5 & 0x03);
                if (_local_5 == 0) goto _label_4;
            } while (true);
            if (!(_local_4 == 8))
            {
                if (_local_4 == 9) goto _label_5;
                if (!(_local_4 == 10)) goto _label_4;
                _local_3 = li32(_local_2 + 8);
                _local_4 = li32(_local_3 + 8);
                _local_6 = (_local_2 + 8);
                if (!(_local_4 < 4))
                {
                    _local_3 = li32(_local_3);
                    _local_4 = li8(_local_3 + 5);
                    _local_4 = (_local_4 & 0x03);
                    if (!(_local_4 == 0))
                    {
                        mstate.esp = (mstate.esp - 8);
                        si32(_local_1, mstate.esp);
                        si32(_local_3, (mstate.esp + 4));
                        mstate.esp = (mstate.esp - 4);
                        FSM_reallymarkobject.start();
                        mstate.esp = (mstate.esp + 8);
                    };
                };
                _local_1 = li32(_local_6);
                _local_2 = (_local_2 + 12);
                if (!(_local_1 == _local_2)) goto _label_4;
                _local_1 = li8(_local_5);
                _local_1 = (_local_1 | 0x04);
                si8(_local_1, _local_5);
                goto _label_4;
                
            _label_1: 
                _local_3 = li32(_local_1 + 36);
                si32(_local_3, (_local_2 + 8));
                goto _label_3;
                
            _label_2: 
                _local_3 = li32(_local_1 + 36);
                si32(_local_3, (_local_2 + 24));
            }
            else
            {
                _local_3 = li32(_local_1 + 36);
                si32(_local_3, (_local_2 + 100));
            };
            
        _label_3: 
            si32(_local_2, (_local_1 + 36));
            
        _label_4: 
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_5: 
            _local_3 = li32(_local_1 + 36);
            si32(_local_3, (_local_2 + 68));
            goto _label_3;
        }


    }
} cmodule.lua_wrapper

