package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_currentlocale extends Machine 
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
            mstate.esp = (mstate.esp - 4);
            si32(mstate.ebp, mstate.esp);
            mstate.ebp = mstate.esp;
            mstate.esp = (mstate.esp - 0);
            _local_1 = li8(_current_categories + 32);
            si8(_local_1, _current_locale_string);
            if (!(_local_1 == 0))
            {
                _local_2 = _current_categories;
                _local_3 = _current_locale_string;
                _local_4 = 0;
                do 
                {
                    _local_5 = (_local_2 + _local_4);
                    _local_5 = li8(_local_5 + 33);
                    _local_6 = (_local_3 + _local_4);
                    si8(_local_5, (_local_6 + 1));
                    _local_4 = (_local_4 + 1);
                } while (!(_local_5 == 0));
            };
            _local_2 = _current_categories;
            _local_3 = 2;
            _local_4 = 0;
            _local_5 = (_local_2 + 64);
            _loop_1:
            do 
            {
                _local_6 = (_local_2 + _local_4);
                _local_6 = li8(_local_6 + 64);
                _local_7 = (_local_1 & 0xFF);
                if (!(_local_7 == _local_6)) goto _label_12;
                _local_6 = _current_categories;
                _local_7 = _local_1;
                do 
                {
                    _local_8 = (_local_4 + _local_6);
                    _local_8 = (_local_8 + 65);
                    _local_7 = (_local_7 & 0xFF);
                    if ((_local_7 == 0)) continue _loop_1;
                    _local_7 = li8(_local_6 + 33);
                    _local_8 = li8(_local_8);
                    _local_6 = (_local_6 + 1);
                } while (!(!(_local_7 == _local_8)));
                _local_6 = (_local_4 + _local_6);
                _local_6 = (_local_6 + 64);
                
            _label_1: 
                _local_6 = li8(_local_6);
                _local_7 = (_local_7 & 0xFF);
                if (!(_local_7 == _local_6))
                {
                    _local_3 = li8(_current_locale_string);
                    if (_local_3 == 0) goto _label_13;
                    _local_3 = _current_locale_string;
                    do 
                    {
                        _local_4 = li8(_local_3 + 1);
                        _local_3 = (_local_3 + 1);
                        _local_1 = _local_3;
                        if (_local_4 == 0) goto _label_14;
                        _local_3 = _local_1;
                    } while (true);
                    
                _label_2: 
                    _local_3 = _current_locale_string;
                    
                _label_3: 
                    _local_4 = _current_categories;
                    _local_1 = 0;
                    do 
                    {
                        _local_2 = (_local_4 + _local_1);
                        _local_2 = li8(_local_2 + 64);
                        _local_5 = (_local_3 + _local_1);
                        si8(_local_2, _local_5);
                        _local_1 = (_local_1 + 1);
                    } while (!(_local_2 == 0));
                    _local_3 = li8(_current_locale_string);
                    if (_local_3 == 0) goto _label_15;
                    _local_3 = _current_locale_string;
                    do 
                    {
                        _local_4 = li8(_local_3 + 1);
                        _local_3 = (_local_3 + 1);
                        _local_1 = _local_3;
                        if (_local_4 == 0) goto _label_16;
                        _local_3 = _local_1;
                    } while (true);
                    
                _label_4: 
                    _local_3 = _current_locale_string;
                    
                _label_5: 
                    _local_4 = _current_categories;
                    _local_1 = 0;
                    do 
                    {
                        _local_2 = (_local_4 + _local_1);
                        _local_2 = li8(_local_2 + 96);
                        _local_5 = (_local_3 + _local_1);
                        si8(_local_2, _local_5);
                        _local_1 = (_local_1 + 1);
                    } while (!(_local_2 == 0));
                    _local_3 = li8(_current_locale_string);
                    if (_local_3 == 0) goto _label_17;
                    _local_3 = _current_locale_string;
                    do 
                    {
                        _local_4 = li8(_local_3 + 1);
                        _local_3 = (_local_3 + 1);
                        _local_1 = _local_3;
                        if (_local_4 == 0) goto _label_18;
                        _local_3 = _local_1;
                    } while (true);
                    
                _label_6: 
                    _local_3 = _current_locale_string;
                    
                _label_7: 
                    _local_4 = _current_categories;
                    _local_1 = 0;
                    do 
                    {
                        _local_2 = (_local_4 + _local_1);
                        _local_2 = li8(_local_2 + 128);
                        _local_5 = (_local_3 + _local_1);
                        si8(_local_2, _local_5);
                        _local_1 = (_local_1 + 1);
                    } while (!(_local_2 == 0));
                    _local_3 = li8(_current_locale_string);
                    if (_local_3 == 0) goto _label_19;
                    _local_3 = _current_locale_string;
                    do 
                    {
                        _local_4 = li8(_local_3 + 1);
                        _local_3 = (_local_3 + 1);
                        _local_1 = _local_3;
                        if (_local_4 == 0) goto _label_20;
                        _local_3 = _local_1;
                    } while (true);
                    
                _label_8: 
                    _local_3 = _current_locale_string;
                    
                _label_9: 
                    _local_4 = _current_categories;
                    _local_1 = 0;
                    do 
                    {
                        _local_2 = (_local_4 + _local_1);
                        _local_2 = li8(_local_2 + 160);
                        _local_5 = (_local_3 + _local_1);
                        si8(_local_2, _local_5);
                        _local_1 = (_local_1 + 1);
                    } while (!(_local_2 == 0));
                    _local_3 = li8(_current_locale_string);
                    if (_local_3 == 0) goto _label_21;
                    _local_3 = _current_locale_string;
                    do 
                    {
                        _local_4 = li8(_local_3 + 1);
                        _local_3 = (_local_3 + 1);
                        _local_1 = _local_3;
                        if (_local_4 == 0) goto _label_22;
                        _local_3 = _local_1;
                    } while (true);
                    
                _label_10: 
                    _local_3 = _current_locale_string;
                    
                _label_11: 
                    _local_4 = _current_categories;
                    _local_1 = 0;
                    do 
                    {
                        _local_2 = (_local_4 + _local_1);
                        _local_2 = li8(_local_2 + 192);
                        _local_5 = (_local_3 + _local_1);
                        si8(_local_2, _local_5);
                        _local_1 = (_local_1 + 1);
                        if ((_local_2 == 0)) break _loop_1;
                    } while (true);
                };
            } while ((_local_4 = (_local_4 + 32)), (_local_3 = (_local_3 + 1)), !(_local_3 > 6));
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp = (mstate.esp + 4);
            mstate.esp = (mstate.esp + 4);
            return;
            
        _label_12: 
            _local_6 = (_local_5 + _local_4);
            _local_7 = _local_1;
            goto _label_1;
            
        _label_13: 
            _local_3 = _current_locale_string;
            
        _label_14: 
            _local_4 = 47;
            _local_1 = 0;
            si8(_local_4, _local_3);
            si8(_local_1, (_local_3 + 1));
            _local_3 = li8(_current_locale_string);
            if (_local_3 == 0) goto _label_2;
            _local_3 = _current_locale_string;
            do 
            {
                _local_4 = li8(_local_3 + 1);
                _local_3 = (_local_3 + 1);
                _local_1 = _local_3;
                if (_local_4 == 0) goto _label_3;
                _local_3 = _local_1;
            } while (true);
            
        _label_15: 
            _local_3 = _current_locale_string;
            
        _label_16: 
            _local_4 = 47;
            _local_1 = 0;
            si8(_local_4, _local_3);
            si8(_local_1, (_local_3 + 1));
            _local_3 = li8(_current_locale_string);
            if (_local_3 == 0) goto _label_4;
            _local_3 = _current_locale_string;
            do 
            {
                _local_4 = li8(_local_3 + 1);
                _local_3 = (_local_3 + 1);
                _local_1 = _local_3;
                if (_local_4 == 0) goto _label_5;
                _local_3 = _local_1;
            } while (true);
            
        _label_17: 
            _local_3 = _current_locale_string;
            
        _label_18: 
            _local_4 = 47;
            _local_1 = 0;
            si8(_local_4, _local_3);
            si8(_local_1, (_local_3 + 1));
            _local_3 = li8(_current_locale_string);
            if (_local_3 == 0) goto _label_6;
            _local_3 = _current_locale_string;
            do 
            {
                _local_4 = li8(_local_3 + 1);
                _local_3 = (_local_3 + 1);
                _local_1 = _local_3;
                if (_local_4 == 0) goto _label_7;
                _local_3 = _local_1;
            } while (true);
            
        _label_19: 
            _local_3 = _current_locale_string;
            
        _label_20: 
            _local_4 = 47;
            _local_1 = 0;
            si8(_local_4, _local_3);
            si8(_local_1, (_local_3 + 1));
            _local_3 = li8(_current_locale_string);
            if (_local_3 == 0) goto _label_8;
            _local_3 = _current_locale_string;
            do 
            {
                _local_4 = li8(_local_3 + 1);
                _local_3 = (_local_3 + 1);
                _local_1 = _local_3;
                if (_local_4 == 0) goto _label_9;
                _local_3 = _local_1;
            } while (true);
            
        _label_21: 
            _local_3 = _current_locale_string;
            
        _label_22: 
            _local_4 = 47;
            _local_1 = 0;
            si8(_local_4, _local_3);
            si8(_local_1, (_local_3 + 1));
            _local_3 = li8(_current_locale_string);
            if (_local_3 == 0) goto _label_10;
            _local_3 = _current_locale_string;
            do 
            {
                _local_4 = li8(_local_3 + 1);
                _local_3 = (_local_3 + 1);
                _local_1 = _local_3;
                if (_local_4 == 0) goto _label_11;
                _local_3 = _local_1;
            } while (true);
        }


    }
}

