package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_markroot extends Machine 
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
            _local_1 = 0;
            _local_2 = li32(mstate.ebp + 8);
            _local_3 = li32(_local_2 + 16);
            si32(_local_1, (_local_3 + 36));
            si32(_local_1, (_local_3 + 40));
            si32(_local_1, (_local_3 + 44));
            _local_1 = li32(_local_3 + 104);
            _local_4 = li8(_local_1 + 5);
            _local_5 = (_local_3 + 104);
            _local_2 = (_local_2 + 16);
            _local_6 = _local_3;
            _local_4 = (_local_4 & 0x03);
            if (!(_local_4 == 0))
            {
                mstate.esp = (mstate.esp - 8);
                si32(_local_6, mstate.esp);
                si32(_local_1, (mstate.esp + 4));
                mstate.esp = (mstate.esp - 4);
                FSM_reallymarkobject.start();
                mstate.esp = (mstate.esp + 8);
            };
            _local_1 = li32(_local_5);
            _local_4 = li32(_local_1 + 80);
            if (!(_local_4 < 4))
            {
                _local_1 = li32(_local_1 + 72);
                _local_4 = li8(_local_1 + 5);
                _local_4 = (_local_4 & 0x03);
                if (!(_local_4 == 0))
                {
                    mstate.esp = (mstate.esp - 8);
                    si32(_local_6, mstate.esp);
                    si32(_local_1, (mstate.esp + 4));
                    mstate.esp = (mstate.esp - 4);
                    FSM_reallymarkobject.start();
                    mstate.esp = (mstate.esp + 8);
                };
            };
            _local_1 = li32(_local_2);
            _local_2 = li32(_local_1 + 100);
            if (!(_local_2 < 4))
            {
                _local_1 = li32(_local_1 + 92);
                _local_2 = li8(_local_1 + 5);
                _local_2 = (_local_2 & 0x03);
                if (!(_local_2 == 0)) goto _label_1;
            };
            _local_1 = 0;
            _local_3 = (_local_3 + 132);
            do 
            {
                _local_2 = li32(_local_3);
                if (!(_local_2 == 0))
                {
                    _local_4 = li8(_local_2 + 5);
                    _local_4 = (_local_4 & 0x03);
                    if (!(_local_4 == 0))
                    {
                        mstate.esp = (mstate.esp - 8);
                        si32(_local_6, mstate.esp);
                        si32(_local_2, (mstate.esp + 4));
                        mstate.esp = (mstate.esp - 4);
                        FSM_reallymarkobject.start();
                        mstate.esp = (mstate.esp + 8);
                    };
                };
                _local_3 = (_local_3 + 4);
                _local_1 = (_local_1 + 1);
                if (_local_1 == 9) goto _label_2;
            } while (true);
            
        _label_1: 
            _local_2 = 0;
            mstate.esp = (mstate.esp - 8);
            si32(_local_6, mstate.esp);
            si32(_local_1, (mstate.esp + 4));
            mstate.esp = (mstate.esp - 4);
            FSM_reallymarkobject.start();
            mstate.esp = (mstate.esp + 8);
            _local_1 = (_local_3 + 132);
            _local_3 = _local_2;
            do 
            {
                _local_2 = li32(_local_1);
                if (!(_local_2 == 0))
                {
                    _local_4 = li8(_local_2 + 5);
                    _local_4 = (_local_4 & 0x03);
                    if (!(_local_4 == 0))
                    {
                        mstate.esp = (mstate.esp - 8);
                        si32(_local_6, mstate.esp);
                        si32(_local_2, (mstate.esp + 4));
                        mstate.esp = (mstate.esp - 4);
                        FSM_reallymarkobject.start();
                        mstate.esp = (mstate.esp + 8);
                    };
                };
                _local_1 = (_local_1 + 4);
                _local_3 = (_local_3 + 1);
            } while (!(_local_3 == 9));
            
        _label_2: 
            _local_1 = 1;
            si8(_local_1, (_local_6 + 21));
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
}

