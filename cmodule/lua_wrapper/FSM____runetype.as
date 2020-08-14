package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM____runetype extends Machine 
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
            _local_1 = li32(__CurrentRuneLocale);
            _local_2 = li32(mstate.ebp + 8);
                
            outer_block:
            {

                if (!(_local_2 < 0))
                {
                    _local_3 = li32(_local_1 + 3128);
                    _local_1 = li32(_local_1 + 3124);
                    if (!(_local_1 == 0))
                    {
                        do 
                        {
                            _local_4 = (_local_1 & 0x1FFFFFFE);
                            _local_4 = (_local_4 << 3);
                            _local_4 = (_local_3 + _local_4);
                            _local_4 = li32(_local_4);
                            _local_5 = (_local_1 >>> 1);
                            if (!(_local_4 > _local_2))
                            {
                                _local_6 = (_local_5 << 4);
                                _local_6 = (_local_3 + _local_6);
                                _local_6 = li32(_local_6 + 4);
                                if (!(_local_6 < _local_2))
                                {
                                    _local_1 = (_local_5 << 4);
                                    _local_1 = (_local_3 + _local_1);
                                    _local_1 = li32(_local_1 + 12);
                                    if (!(_local_1 == 0))
                                    {
                                        _local_3 = (_local_2 - _local_4);
                                        _local_3 = (_local_3 << 2);
                                        _local_1 = (_local_1 + _local_3);
                                        _local_1 = li32(_local_1);
                                        break outer_block;
                                    };
                                    _local_1 = (_local_5 << 4);
                                    _local_1 = (_local_3 + _local_1);
                                    _local_1 = li32(_local_1 + 8);
                                    break outer_block;
                                };
                            };
                            _local_4 = (_local_5 << 4);
                            _local_4 = (_local_3 + _local_4);
                            _local_4 = li32(_local_4 + 4);
                            if ((_local_4 < _local_2))
                            {
                                _local_4 = (_local_5 << 4);
                                _local_3 = (_local_4 + _local_3);
                                _local_3 = (_local_3 + 16);
                                _local_1 = (_local_1 + -1);
                            };
                            _local_4 = (_local_1 >>> 1);
                            if ((uint(_local_1) < uint(2))) break;
                            _local_1 = _local_4;
                        } while (true);
                    };
                };
                _local_1 = 0;
            
            }//outer_block
            mstate.eax = _local_1;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
        }


    }
} cmodule.lua_wrapper

