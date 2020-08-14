package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_os_setlocale extends Machine 
    {

        public static const intRegCount:int = 15;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_os_setlocale;
            _local_1 = new (FSM_os_setlocale)();
            gstate.gworker = _local_1;
        }


        final override public function work():void
        {
            switch (state)
            {
                case 0:
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(public::mstate.ebp, public::mstate.esp);
                    public::mstate.ebp = public::mstate.esp;
                    public::mstate.esp = (public::mstate.esp - 0);
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (!(!(this.i0 == this.i2)))
                    {
                        
                    _label_1: 
                        this.i0 = 0;
                        goto _label_2;
                    };
                    this.i0 = li32(this.i0 + 8);
                    if (this.i0 < 1) goto _label_1;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i2 = __2E_str26408;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = _catnames_2E_3382;
                    this.i4 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkoption.start();
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    this.i3 = _cat_2E_3381;
                    this.i2 = (this.i2 << 2);
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = (this.i3 + this.i2);
                    this.i2 = li32(this.i2);
                    this.i3 = this.i0;
                    if (!(uint(this.i2) < uint(7)))
                    {
                        this.i0 = 22;
                        si32(this.i0, _val_2E_1440);
                        this.i0 = 0;
                        goto _label_29;
                    };
                    if (!(this.i0 == 0))
                    {
                        this.i4 = li8(_current_categories + 32);
                        si8(this.i4, (_new_categories + 32));
                        if (!(this.i4 == 0))
                        {
                            this.i4 = _current_categories;
                            this.i5 = _new_categories;
                            this.i6 = 33;
                            do 
                            {
                                this.i7 = (this.i4 + this.i6);
                                this.i7 = li8(this.i7);
                                this.i8 = (this.i5 + this.i6);
                                si8(this.i7, this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(this.i7 == 0));
                        };
                        this.i4 = li8(_current_categories + 64);
                        si8(this.i4, (_new_categories + 64));
                        if (!(this.i4 == 0))
                        {
                            this.i4 = _current_categories;
                            this.i5 = _new_categories;
                            this.i6 = 65;
                            do 
                            {
                                this.i7 = (this.i4 + this.i6);
                                this.i7 = li8(this.i7);
                                this.i8 = (this.i5 + this.i6);
                                si8(this.i7, this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(this.i7 == 0));
                        };
                        this.i4 = li8(_current_categories + 96);
                        si8(this.i4, (_new_categories + 96));
                        if (!(this.i4 == 0))
                        {
                            this.i4 = _current_categories;
                            this.i5 = _new_categories;
                            this.i6 = 97;
                            do 
                            {
                                this.i7 = (this.i4 + this.i6);
                                this.i7 = li8(this.i7);
                                this.i8 = (this.i5 + this.i6);
                                si8(this.i7, this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(this.i7 == 0));
                        };
                        this.i4 = li8(_current_categories + 128);
                        si8(this.i4, (_new_categories + 128));
                        if (!(this.i4 == 0))
                        {
                            this.i4 = _current_categories;
                            this.i5 = _new_categories;
                            this.i6 = 129;
                            do 
                            {
                                this.i7 = (this.i4 + this.i6);
                                this.i7 = li8(this.i7);
                                this.i8 = (this.i5 + this.i6);
                                si8(this.i7, this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(this.i7 == 0));
                        };
                        this.i4 = li8(_current_categories + 160);
                        si8(this.i4, (_new_categories + 160));
                        if (!(this.i4 == 0))
                        {
                            this.i4 = _current_categories;
                            this.i5 = _new_categories;
                            this.i6 = 161;
                            do 
                            {
                                this.i7 = (this.i4 + this.i6);
                                this.i7 = li8(this.i7);
                                this.i8 = (this.i5 + this.i6);
                                si8(this.i7, this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(this.i7 == 0));
                        };
                        this.i4 = li8(_current_categories + 192);
                        si8(this.i4, (_new_categories + 192));
                        if (this.i4 == 0) goto _label_3;
                        this.i4 = _current_categories;
                        this.i5 = _new_categories;
                        this.i6 = 193;
                        do 
                        {
                            this.i7 = (this.i4 + this.i6);
                            this.i7 = li8(this.i7);
                            this.i8 = (this.i5 + this.i6);
                            si8(this.i7, this.i8);
                            this.i6 = (this.i6 + 1);
                            if (this.i7 == 0) goto _label_3;
                        } while (true);
                    };
                    if (!(this.i2 == 0))
                    {
                        this.i0 = _current_categories;
                        this.i2 = (this.i2 << 5);
                        this.i0 = (this.i0 + this.i2);
                        goto _label_29;
                    };
                    this.i0 = _current_locale_string;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_currentlocale.start();
                case 4:
                    goto _label_29;
                    
                _label_3: 
                    this.i4 = li8(this.i0);
                    if (!(this.i4 == 0)) goto _label_8;
                    if (!(this.i2 == 0)) goto _label_6;
                    this.i0 = _new_categories;
                    this.i3 = 1;
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___get_locale_env.start();
                case 5:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i5 = li8(this.i4);
                    this.i6 = this.i4;
                    if (this.i5 == 0) goto _label_30;
                    this.i4 = this.i6;
                    do 
                    {
                        this.i7 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i8 = this.i4;
                        if (this.i7 == 0) goto _label_30;
                        this.i4 = this.i8;
                    } while (true);
                    
                _label_5: 
                    si8(this.i5, (this.i0 + 32));
                    this.i4 = (this.i5 & 0xFF);
                    if (!(this.i4 == 0))
                    {
                        this.i4 = 0;
                        do 
                        {
                            this.i5 = (this.i6 + this.i4);
                            this.i5 = li8(this.i5 + 1);
                            this.i7 = (this.i0 + this.i4);
                            si8(this.i5, (this.i7 + 33));
                            this.i4 = (this.i4 + 1);
                        } while (!(this.i5 == 0));
                    };
                    this.i0 = (this.i0 + 32);
                    this.i3 = (this.i3 + 1);
                    if (this.i3 > 6) goto _label_20;
                    goto _label_4;
                    
                _label_6: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___get_locale_env.start();
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = li8(this.i0);
                    this.i4 = this.i0;
                    if (this.i3 == 0) goto _label_31;
                    this.i0 = this.i4;
                    do 
                    {
                        this.i5 = li8(this.i0 + 1);
                        this.i0 = (this.i0 + 1);
                        this.i6 = this.i0;
                        if (this.i5 == 0) goto _label_31;
                        this.i0 = this.i6;
                    } while (true);
                    
                _label_7: 
                    this.i0 = _new_categories;
                    this.i5 = (this.i2 << 5);
                    this.i0 = (this.i0 + this.i5);
                    si8(this.i3, this.i0);
                    this.i0 = (this.i3 & 0xFF);
                    if (this.i0 == 0) goto _label_23;
                    this.i0 = _new_categories;
                    this.i3 = (this.i2 << 5);
                    this.i5 = 1;
                    this.i0 = (this.i0 + this.i3);
                    this.i3 = this.i5;
                    do 
                    {
                        this.i5 = (this.i4 + this.i3);
                        this.i5 = li8(this.i5);
                        this.i6 = (this.i0 + this.i3);
                        si8(this.i5, this.i6);
                        this.i3 = (this.i3 + 1);
                        if (this.i5 == 0) goto _label_23;
                    } while (true);
                    
                _label_8: 
                    if (!(this.i2 == 0))
                    {
                        this.i5 = (this.i4 & 0xFF);
                        if (this.i5 == 0) goto _label_32;
                        this.i5 = this.i3;
                        do 
                        {
                            this.i6 = li8(this.i5 + 1);
                            this.i5 = (this.i5 + 1);
                            this.i7 = this.i5;
                            if (this.i6 == 0) goto _label_33;
                            this.i5 = this.i7;
                        } while (true);
                        
                    _label_9: 
                        this.i0 = _new_categories;
                        this.i5 = (this.i2 << 5);
                        this.i0 = (this.i0 + this.i5);
                        si8(this.i4, this.i0);
                        this.i0 = (this.i4 & 0xFF);
                        if (!(this.i0 == 0))
                        {
                            this.i0 = _new_categories;
                            this.i4 = (this.i2 << 5);
                            this.i5 = 1;
                            this.i0 = (this.i0 + this.i4);
                            this.i4 = this.i5;
                            do 
                            {
                                this.i5 = (this.i3 + this.i4);
                                this.i5 = li8(this.i5);
                                this.i6 = (this.i0 + this.i4);
                                si8(this.i5, this.i6);
                                this.i4 = (this.i4 + 1);
                            } while (!(this.i5 == 0));
                        };
                        if (this.i2 == 0) goto _label_21;
                        goto _label_24;
                    };
                    this.i5 = (this.i4 & 0xFF);
                    if (this.i5 == 47) goto _label_34;
                    this.i5 = this.i3;
                    do 
                    {
                        this.i6 = li8(this.i5);
                        if (!(!(this.i6 == 0)))
                        {
                            this.i5 = 0;
                            goto _label_35;
                        };
                        this.i6 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i7 = this.i5;
                        if (this.i6 == 47) goto _label_35;
                        this.i5 = this.i7;
                    } while (true);
                    
                _label_10: 
                    this.i5 = (this.i4 & 0xFF);
                    if (this.i5 == 0) goto _label_36;
                    this.i5 = this.i3;
                    do 
                    {
                        this.i6 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i7 = this.i5;
                        if (this.i6 == 0) goto _label_37;
                        this.i5 = this.i7;
                    } while (true);
                    
                _label_11: 
                    this.i5 = li8(this.i0);
                    si8(this.i5, (_new_categories + 64));
                    if (!(this.i5 == 0))
                    {
                        this.i5 = _new_categories;
                        this.i6 = 0;
                        do 
                        {
                            this.i4 = (this.i3 + this.i6);
                            this.i4 = li8(this.i4 + 1);
                            this.i7 = (this.i5 + this.i6);
                            si8(this.i4, (this.i7 + 65));
                            this.i6 = (this.i6 + 1);
                        } while (!(this.i4 == 0));
                    };
                    this.i5 = li8(this.i0);
                    si8(this.i5, (_new_categories + 96));
                    if (!(this.i5 == 0))
                    {
                        this.i5 = _new_categories;
                        this.i6 = 0;
                        do 
                        {
                            this.i4 = (this.i3 + this.i6);
                            this.i4 = li8(this.i4 + 1);
                            this.i7 = (this.i5 + this.i6);
                            si8(this.i4, (this.i7 + 97));
                            this.i6 = (this.i6 + 1);
                        } while (!(this.i4 == 0));
                    };
                    this.i5 = li8(this.i0);
                    si8(this.i5, (_new_categories + 128));
                    if (!(this.i5 == 0))
                    {
                        this.i5 = _new_categories;
                        this.i6 = 0;
                        do 
                        {
                            this.i4 = (this.i3 + this.i6);
                            this.i4 = li8(this.i4 + 1);
                            this.i7 = (this.i5 + this.i6);
                            si8(this.i4, (this.i7 + 129));
                            this.i6 = (this.i6 + 1);
                        } while (!(this.i4 == 0));
                    };
                    this.i5 = li8(this.i0);
                    si8(this.i5, (_new_categories + 160));
                    if (!(this.i5 == 0))
                    {
                        this.i5 = _new_categories;
                        this.i6 = 0;
                        do 
                        {
                            this.i4 = (this.i3 + this.i6);
                            this.i4 = li8(this.i4 + 1);
                            this.i7 = (this.i5 + this.i6);
                            si8(this.i4, (this.i7 + 161));
                            this.i6 = (this.i6 + 1);
                        } while (!(this.i4 == 0));
                    };
                    this.i0 = li8(this.i0);
                    si8(this.i0, (_new_categories + 192));
                    if (this.i0 == 0) goto _label_20;
                    this.i0 = _new_categories;
                    this.i5 = 0;
                    do 
                    {
                        this.i6 = (this.i3 + this.i5);
                        this.i6 = li8(this.i6 + 1);
                        this.i4 = (this.i0 + this.i5);
                        si8(this.i6, (this.i4 + 193));
                        this.i5 = (this.i5 + 1);
                        if (this.i6 == 0) goto _label_20;
                    } while (true);
                    
                _label_12: 
                    this.i0 = 22;
                    si32(this.i0, _val_2E_1440);
                    this.i0 = 0;
                    goto _label_29;
                    
                _label_13: 
                    this.i0 = 22;
                    si32(this.i0, _val_2E_1440);
                    this.i0 = 0;
                    goto _label_29;
                    
                _label_14: 
                    this.i4 = _new_categories;
                    this.i3 = (this.i3 + this.i5);
                    this.i3 = (this.i3 + -1);
                    this.i4 = (this.i4 + 32);
                    this.i5 = 0;
                    
                _label_15: 
                    this.i6 = this.i3;
                    this.i7 = this.i4;
                    this.i8 = (this.i5 + 1);
                    if (this.i8 == 7) goto _label_19;
                    this.i8 = (this.i6 - this.i0);
                    if (!(this.i8 < 32))
                    {
                        this.i0 = 22;
                        si32(this.i0, _val_2E_1440);
                        this.i0 = 0;
                        goto _label_29;
                    };
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 + 1);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strlcpy.start();
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li8(this.i3);
                    if (!(this.i0 == 47))
                    {
                        this.i0 = this.i3;
                    }
                    else
                    {
                        this.i0 = this.i6;
                        
                    _label_16: 
                        this.i3 = li8(this.i0 + 1);
                        this.i6 = (this.i0 + 1);
                        this.i0 = this.i6;
                        if (this.i3 == 47) goto _label_38;
                        this.i0 = this.i6;
                        this.i3 = this.i6;
                    };
                    while ((this.i6 = li8(this.i3)), (this.i7 = this.i3), if (this.i6 == 0) goto _label_17;
, (this.i6 = (this.i6 & 0xFF)), (!(this.i6 == 47)))
                    {
                        this.i3 = (this.i3 + 1);
                    };
                    
                _label_17: 
                    this.i3 = li8(this.i0);
                    if (!(this.i3 == 0))
                    {
                        this.i3 = (this.i4 + 32);
                        this.i5 = (this.i5 + 1);
                        this.i4 = this.i3;
                        this.i3 = this.i7;
                        goto _label_15;
                        
                    _label_18: 
                        this.i5 = _new_categories;
                        this.i3 = (this.i0 << 5);
                        this.i4 = 0;
                        this.i5 = (this.i5 + this.i3);
                        this.i0 = (7 - this.i0);
                        this.i3 = this.i4;
                        do 
                        {
                            this.i4 = li8(this.i5 + -32);
                            si8(this.i4, this.i5);
                            if (!(this.i4 == 0))
                            {
                                this.i4 = this.i5;
                                do 
                                {
                                    this.i6 = li8(this.i4 + -31);
                                    si8(this.i6, (this.i4 + 1));
                                    this.i4 = (this.i4 + 1);
                                } while (!(this.i6 == 0));
                            };
                            this.i5 = (this.i5 + 32);
                            this.i3 = (this.i3 + 1);
                            if (this.i3 == this.i0) goto _label_20;
                        } while (true);
                        
                    _label_19: 
                        this.i0 = (this.i5 + 1);
                    }
                    else
                    {
                        this.i0 = (this.i5 + 2);
                    };
                    if (this.i0 < 7) goto _label_18;
                    
                _label_20: 
                    if (!(this.i2 == 0)) goto _label_24;
                    
                _label_21: 
                    this.i0 = _saved_categories;
                    this.i2 = _current_categories;
                    this.i3 = 0;
                    this.i4 = this.i3;
                    
                _label_22: 
                    this.i5 = this.i4;
                    this.i4 = (this.i3 + 1);
                    if (this.i4 < 7) goto _label_25;
                    this.i0 = _current_locale_string;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_currentlocale.start();
                case 8:
                    goto _label_29;
                    
                _label_23: 
                    if (this.i2 == 0) goto _label_21;
                    
                _label_24: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_loadlocale.start();
                    return;
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    goto _label_29;
                    
                _label_25: 
                    this.i6 = (this.i2 + this.i5);
                    this.i6 = li8(this.i6 + 32);
                    this.i7 = (this.i0 + this.i5);
                    si8(this.i6, (this.i7 + 32));
                    if (!(this.i6 == 0))
                    {
                        this.i6 = _current_categories;
                        this.i7 = _saved_categories;
                        this.i8 = (this.i5 + 33);
                        do 
                        {
                            this.i9 = (this.i6 + this.i8);
                            this.i9 = li8(this.i9);
                            this.i10 = (this.i7 + this.i8);
                            si8(this.i9, this.i10);
                            this.i8 = (this.i8 + 1);
                        } while (!(this.i9 == 0));
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_loadlocale.start();
                    return;
                case 10:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i5 = (this.i5 + 32);
                    this.i3 = (this.i3 + 1);
                    if (!(this.i4 == 0))
                    {
                        this.i4 = this.i5;
                        goto _label_22;
                    };
                    this.i0 = li32(_val_2E_1440);
                    if (this.i3 < 2) goto _label_28;
                    this.i4 = _new_categories;
                    this.i2 = _saved_categories;
                    this.i5 = 0;
                    this.i6 = (this.i4 + 32);
                    this.i7 = this.i5;
                    
                _label_26: 
                    this.i8 = (this.i2 + this.i7);
                    this.i8 = li8(this.i8 + 32);
                    this.i9 = (this.i4 + this.i7);
                    si8(this.i8, (this.i9 + 32));
                    this.i9 = (this.i6 + this.i7);
                    this.i10 = (this.i5 + 1);
                    if (!(this.i8 == 0))
                    {
                        this.i8 = _saved_categories;
                        this.i11 = _new_categories;
                        this.i12 = (this.i7 + 33);
                        do 
                        {
                            this.i13 = (this.i8 + this.i12);
                            this.i13 = li8(this.i13);
                            this.i14 = (this.i11 + this.i12);
                            si8(this.i13, this.i14);
                            this.i12 = (this.i12 + 1);
                        } while (!(this.i13 == 0));
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i10, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_loadlocale.start();
                    return;
                case 11:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i8 == 0)) goto _label_27;
                    this.i8 = 67;
                    this.i11 = 0;
                    si8(this.i8, this.i9);
                    si8(this.i11, (this.i9 + 1));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i10, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_loadlocale.start();
                    return;
                case 12:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_27: 
                    this.i7 = (this.i7 + 32);
                    this.i5 = (this.i5 + 1);
                    this.i8 = (this.i3 + -1);
                    if (!(this.i5 == this.i8)) goto _label_26;
                    
                _label_28: 
                    this.i3 = 0;
                    si32(this.i0, _val_2E_1440);
                    this.i0 = this.i3;
                    
                _label_29: 
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.eax = this.i2;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_30: 
                    this.i4 = (this.i4 - this.i6);
                    if (uint(this.i4) < uint(32)) goto _label_5;
                    this.i0 = 22;
                    si32(this.i0, _val_2E_1440);
                    this.i0 = 0;
                    goto _label_29;
                    
                _label_31: 
                    this.i0 = (this.i0 - this.i4);
                    if (uint(this.i0) < uint(32)) goto _label_7;
                    this.i0 = 22;
                    si32(this.i0, _val_2E_1440);
                    this.i0 = 0;
                    goto _label_29;
                    
                _label_32: 
                    this.i5 = this.i0;
                    
                _label_33: 
                    this.i0 = (this.i5 - this.i0);
                    if (uint(this.i0) < uint(32)) goto _label_9;
                    this.i0 = 22;
                    si32(this.i0, _val_2E_1440);
                    this.i0 = 0;
                    goto _label_29;
                    
                _label_34: 
                    this.i5 = this.i0;
                    
                _label_35: 
                    this.i6 = this.i5;
                    if (this.i5 == 0) goto _label_10;
                    this.i3 = 0;
                    do 
                    {
                        this.i4 = (this.i6 + this.i3);
                        this.i4 = li8(this.i4 + 1);
                        this.i3 = (this.i3 + 1);
                        if (this.i4 == 0) goto _label_13;
                        this.i4 = (this.i4 & 0xFF);
                        if (!(this.i4 == 47)) goto _label_14;
                    } while (true);
                    
                _label_36: 
                    this.i5 = this.i0;
                    
                _label_37: 
                    this.i5 = (this.i5 - this.i3);
                    if (uint(this.i5) > uint(31)) goto _label_12;
                    si8(this.i4, (_new_categories + 32));
                    this.i5 = (this.i4 & 0xFF);
                    if (this.i5 == 0) goto _label_11;
                    this.i5 = _new_categories;
                    this.i6 = 0;
                    do 
                    {
                        this.i4 = (this.i3 + this.i6);
                        this.i4 = li8(this.i4 + 1);
                        this.i7 = (this.i5 + this.i6);
                        si8(this.i4, (this.i7 + 33));
                        this.i6 = (this.i6 + 1);
                        if (this.i4 == 0) goto _label_11;
                    } while (true);
                    
                _label_38: 
                    goto _label_16;
                default:
                    throw ("Invalid state in _os_setlocale");
            };
        }


    }
} cmodule.lua_wrapper

