package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___wrap_setrunelocale extends Machine 
    {

        public static const intRegCount:int = 26;
        public static const NumberRegCount:int = 0;

        public var i21:int;
        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
        public var i19:int;
        public var i16:int;
        public var i18:int;
        public var i0:int;
        public var i1:int;
        public var i22:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i2:int;
        public var i23:int;
        public var i24:int;
        public var i25:int;
        public var i20:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM___wrap_setrunelocale;
            _local_1 = new (FSM___wrap_setrunelocale)();
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
                    public::mstate.esp = (public::mstate.esp - 0x1400);
                    this.i0 = (public::mstate.ebp + -5120);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i1 = li8(this.i2);
                    this.i3 = this.i2;
                    if (!(this.i1 == 67))
                    {
                        this.i4 = __2E_str3149;
                        this.i5 = this.i1;
                    }
                    else
                    {
                        this.i4 = __2E_str3149;
                        this.i5 = 0;
                        this.i6 = this.i1;
                        do 
                        {
                            this.i7 = (this.i4 + this.i5);
                            this.i7 = (this.i7 + 1);
                            this.i6 = (this.i6 & 0xFF);
                            if (this.i6 == 0) goto _label_1;
                            this.i6 = (this.i3 + this.i5);
                            this.i6 = li8(this.i6 + 1);
                            this.i7 = li8(this.i7);
                            this.i5 = (this.i5 + 1);
                        } while (!(!(this.i6 == this.i7)));
                        this.i4 = __2E_str3149;
                        this.i4 = (this.i4 + this.i5);
                        this.i5 = this.i6;
                    };
                    this.i4 = li8(this.i4);
                    this.i5 = (this.i5 & 0xFF);
                    if (!(this.i5 == this.i4))
                    {
                        this.i4 = (this.i1 & 0xFF);
                        if (!(this.i4 == 80))
                        {
                            this.i4 = __2E_str4150;
                            this.i5 = this.i1;
                        }
                        else
                        {
                            this.i4 = __2E_str4150;
                            this.i5 = 0;
                            this.i6 = this.i1;
                            do 
                            {
                                this.i7 = (this.i4 + this.i5);
                                this.i7 = (this.i7 + 1);
                                this.i6 = (this.i6 & 0xFF);
                                if (this.i6 == 0) goto _label_1;
                                this.i6 = (this.i3 + this.i5);
                                this.i6 = li8(this.i6 + 1);
                                this.i7 = li8(this.i7);
                                this.i5 = (this.i5 + 1);
                            } while (!(!(this.i6 == this.i7)));
                            this.i4 = __2E_str4150;
                            this.i4 = (this.i4 + this.i5);
                            this.i5 = this.i6;
                        };
                        this.i4 = li8(this.i4);
                        this.i5 = (this.i5 & 0xFF);
                        if (!(this.i5 == this.i4)) goto _label_3;
                    };
                    
                _label_1: 
                    this.i0 = 0;
                    do 
                    {
                        public::mstate.eax = this.i0;
                        
                    _label_2: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_3: 
                        this.i4 = li32(_CachedRuneLocale_2E_3155);
                        if ((this.i4 == 0)) break;
                        this.i5 = li8(_ctype_encoding_2E_3154);
                        this.i6 = (this.i1 & 0xFF);
                        if (!(this.i6 == this.i5))
                        {
                            this.i5 = _ctype_encoding_2E_3154;
                        }
                        else
                        {
                            this.i5 = _ctype_encoding_2E_3154;
                            this.i6 = 0;
                            do 
                            {
                                this.i7 = (this.i5 + this.i6);
                                this.i7 = (this.i7 + 1);
                                this.i1 = (this.i1 & 0xFF);
                                if (this.i1 == 0) goto _label_4;
                                this.i1 = (this.i3 + this.i6);
                                this.i1 = li8(this.i1 + 1);
                                this.i7 = li8(this.i7);
                                this.i6 = (this.i6 + 1);
                            } while (!(!(this.i1 == this.i7)));
                            this.i5 = _ctype_encoding_2E_3154;
                            this.i5 = (this.i5 + this.i6);
                        };
                        this.i5 = li8(this.i5);
                        this.i1 = (this.i1 & 0xFF);
                        if ((!(this.i1 == this.i5))) break;
                        
                    _label_4: 
                        this.i0 = 0;
                        si32(this.i4, __CurrentRuneLocale);
                        this.i2 = li32(_Cached__mb_cur_max_2E_3156);
                        si32(this.i2, ___mb_cur_max);
                        this.i2 = li32(_Cached__mbrtowc_2E_3161);
                        si32(this.i2, ___mbrtowc);
                        this.i2 = li32(_Cached__mbsinit_2E_3167);
                        si32(this.i2, ___mbsinit);
                        this.i2 = li32(_Cached__mbsnrtowcs_2E_3173);
                        si32(this.i2, ___mbsnrtowcs);
                        this.i2 = li32(_Cached__wcrtomb_2E_3165);
                        si32(this.i2, ___wcrtomb);
                        this.i2 = li32(_Cached__wcsnrtombs_2E_3179);
                        si32(this.i2, ___wcsnrtombs);
                    } while (true);
                    this.i1 = (public::mstate.ebp + -5120);
                    this.i4 = li32(__PathLocale);
                    this.i5 = li8(this.i4);
                    si8(this.i5, (public::mstate.ebp + -5120));
                    if (!(this.i5 == 0))
                    {
                        this.i5 = 1;
                        do 
                        {
                            this.i6 = (this.i4 + this.i5);
                            this.i6 = li8(this.i6);
                            this.i7 = (this.i0 + this.i5);
                            si8(this.i6, this.i7);
                            this.i5 = (this.i5 + 1);
                        } while (!(this.i6 == 0));
                    };
                    this.i4 = li8(this.i1);
                    if (this.i4 == 0) goto _label_41;
                    this.i4 = this.i0;
                    do 
                    {
                        this.i5 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i6 = this.i4;
                        if (this.i5 == 0) goto _label_42;
                        this.i4 = this.i6;
                    } while (true);
                    
                _label_5: 
                    this.i4 = this.i1;
                    
                _label_6: 
                    this.i5 = 0;
                    do 
                    {
                        this.i6 = (this.i3 + this.i5);
                        this.i6 = li8(this.i6);
                        this.i7 = (this.i4 + this.i5);
                        si8(this.i6, this.i7);
                        this.i5 = (this.i5 + 1);
                    } while (!(this.i6 == 0));
                    this.i4 = li8(this.i1);
                    if (this.i4 == 0) goto _label_43;
                    this.i4 = this.i0;
                    do 
                    {
                        this.i5 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i6 = this.i4;
                        if (this.i5 == 0) goto _label_44;
                        this.i4 = this.i6;
                    } while (true);
                    
                _label_7: 
                    this.i2 = 2;
                    
                _label_8: 
                    if (!(this.i2 == 0))
                    {
                        goto _label_40;
                    };
                    
                _label_9: 
                    goto _label_1;
                    
                _label_10: 
                    this.i0 = li16(this.i4 + 14);
                    this.i1 = (this.i0 << 16);
                    this.i1 = (this.i1 >> 16);
                    if (!(this.i1 > 1))
                    {
                        this.i0 = 0;
                        goto _label_11;
                    };
                    this.i0 = (this.i0 << 16);
                    this.i0 = (this.i0 >> 16);
                    state = 1;
                case 1:
                    this.i0 = public::mstate.system.fsize(this.i0);
                    if (!(this.i0 < 0))
                    {
                        this.i5 = 0;
                        this.i1 = this.i0;
                        this.i0 = this.i5;
                        goto _label_11;
                    };
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = __2E_str251;
                    this.i5 = 59;
                    this.i6 = 2;
                    this.i7 = (public::mstate.ebp + -4096);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i5, (public::mstate.esp + 16));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i7;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i6, _val_2E_1440);
                    this.i0 = 1;
                    
                _label_11: 
                    this.i0 = (this.i0 ^ 0x01);
                    this.i0 = (this.i0 & 0x01);
                    if (!(!(this.i0 == 0)))
                    {
                        
                    _label_12: 
                        this.i1 = 0;
                        goto _label_28;
                    };
                    if (!(uint(this.i1) > uint(3127)))
                    {
                        this.i1 = 79;
                        si32(this.i1, _val_2E_1440);
                        this.i1 = 0;
                        goto _label_28;
                    };
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 3:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = this.i5;
                    if (this.i5 == 0) goto _label_12;
                    this.i6 = 0;
                    si32(this.i6, _val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_rewind.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i6 = li32(_val_2E_1440);
                    if (this.i6 == 0) goto _label_13;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i6, _val_2E_1440);
                    goto _label_28;
                    
                _label_13: 
                    this.i6 = 1;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fread.start();
                    return;
                case 6:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i6 == 1) goto _label_14;
                    this.i1 = 0;
                    this.i0 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 7:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, _val_2E_1440);
                    goto _label_28;
                    
                _label_14: 
                    this.i6 = __2E_str29160;
                    this.i7 = 9;
                    this.i8 = (this.i5 + this.i1);
                    this.i1 = 0;
                    this.i9 = this.i5;
                    this.i10 = this.i5;
                    do 
                    {
                        this.i11 = (this.i6 + this.i1);
                        this.i12 = (this.i0 + this.i1);
                        this.i12 = li8(this.i12);
                        this.i11 = li8(this.i11);
                        if ((!(this.i12 == this.i11))) break;
                        this.i7 = (this.i7 + -1);
                        this.i1 = (this.i1 + 1);
                        if (this.i7 == 1) goto _label_15;
                    } while (true);
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 8:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = 79;
                    si32(this.i5, _val_2E_1440);
                    goto _label_28;
                    
                _label_15: 
                    this.i6 = __2E_str16;
                    this.i7 = 4;
                    this.i11 = 0;
                    this.i0 = this.i6;
                    this.i1 = this.i7;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i11, (this.i10 + 3124));
                    this.i0 = this.i6;
                    this.i1 = this.i7;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i11, (this.i10 + 3112));
                    this.i0 = this.i6;
                    this.i1 = this.i7;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i11, (this.i10 + 3116));
                    this.i0 = this.i6;
                    this.i1 = this.i7;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i11, (this.i10 + 3120));
                    this.i6 = (this.i10 + 3120);
                    this.i7 = (this.i10 + 3116);
                    this.i12 = (this.i10 + 3112);
                    this.i13 = (this.i10 + 3124);
                    this.i1 = this.i9;
                    this.i0 = this.i11;
                    do 
                    {
                        this.i11 = this.i1;
                        this.i14 = this.i0;
                        this.i15 = __2E_str16;
                        this.i16 = 4;
                        this.i17 = 0;
                        this.i0 = this.i15;
                        this.i1 = this.i16;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i17, (this.i11 + 40));
                        this.i0 = this.i15;
                        this.i1 = this.i16;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i17, (this.i11 + 1064));
                        this.i0 = this.i15;
                        this.i1 = this.i16;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i17, (this.i11 + 2088));
                        this.i1 = (this.i11 + 4);
                        this.i0 = (this.i14 + 1);
                    } while (!(this.i0 == 0x0100));
                    this.i11 = li32(this.i12);
                    this.i14 = (this.i5 + 3128);
                    this.i1 = (this.i11 * 12);
                    this.i15 = this.i14;
                    this.i1 = (this.i14 + this.i1);
                    if (uint(this.i1) <= uint(this.i8)) goto _label_16;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 9:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = 79;
                    si32(this.i5, _val_2E_1440);
                    goto _label_28;
                    
                _label_16: 
                    this.i16 = li32(this.i7);
                    this.i17 = (this.i16 + this.i11);
                    this.i1 = (this.i17 * 12);
                    this.i1 = (this.i15 + this.i1);
                    if (uint(this.i1) <= uint(this.i8)) goto _label_17;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 10:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = 79;
                    si32(this.i5, _val_2E_1440);
                    goto _label_28;
                    
                _label_17: 
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i17 + this.i1);
                    this.i1 = (this.i1 * 12);
                    this.i1 = (this.i15 + this.i1);
                    if (uint(this.i1) <= uint(this.i8)) goto _label_19;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 11:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = 79;
                    si32(this.i5, _val_2E_1440);
                    goto _label_28;
                    do 
                    {
                        this.i19 = this.i0;
                        this.i1 = this.i23;
                        this.i0 = this.i21;
                        
                    _label_18: 
                        this.i20 = this.i1;
                        this.i21 = this.i0;
                        this.i22 = __2E_str16;
                        this.i23 = 4;
                        this.i24 = 0;
                        this.i0 = this.i22;
                        this.i1 = this.i23;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i24, this.i19);
                        this.i0 = this.i22;
                        this.i1 = this.i23;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i24, (this.i19 + 4));
                        this.i0 = this.i22;
                        this.i1 = this.i23;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i24, (this.i19 + 8));
                        this.i1 = li32(this.i19 + 4);
                        this.i0 = li32(this.i19);
                        this.i22 = (this.i1 - this.i0);
                        this.i22 = (this.i22 + 1);
                        this.i23 = (this.i22 << 2);
                        this.i21 = (this.i22 + this.i21);
                        this.i23 = (this.i20 + this.i23);
                        if (uint(this.i23) > uint(this.i8)) goto _label_45;
                        if (!(this.i22 < 1))
                        {
                            this.i1 = (this.i1 - this.i0);
                            this.i0 = (this.i1 << 2);
                            this.i0 = (this.i20 + this.i0);
                            this.i1 = (this.i1 + 1);
                            do 
                            {
                                this.i20 = this.i0;
                                this.i22 = this.i1;
                                this.i1 = __2E_str16;
                                this.i24 = 4;
                                this.i25 = 0;
                                this.i0 = this.i1;
                                this.i1 = this.i24;
                                log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                                si32(this.i25, this.i20);
                                this.i1 = (this.i20 + -4);
                                this.i20 = (this.i22 + -1);
                                if ((this.i20 < 1)) break;
                                this.i0 = this.i1;
                                this.i1 = this.i20;
                            } while (true);
                        };
                        this.i1 = li32(this.i12);
                        this.i0 = (this.i19 + 12);
                        this.i18 = (this.i18 + 1);
                    } while ((this.i1 > this.i18));
                    this.i1 = this.i23;
                    this.i0 = this.i21;
                    do 
                    {
                        this.i19 = this.i1;
                        this.i18 = this.i0;
                        this.i1 = li32(this.i7);
                        if (this.i1 < 1) goto _label_21;
                        this.i0 = 0;
                        this.i1 = (this.i11 * 12);
                        this.i1 = (this.i14 + this.i1);
                        do 
                        {
                            this.i20 = this.i1;
                            this.i21 = this.i0;
                            this.i22 = __2E_str16;
                            this.i23 = 4;
                            this.i24 = 0;
                            this.i0 = this.i22;
                            this.i1 = this.i23;
                            log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                            si32(this.i24, this.i20);
                            this.i0 = this.i22;
                            this.i1 = this.i23;
                            log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                            si32(this.i24, (this.i20 + 4));
                            this.i0 = this.i22;
                            this.i1 = this.i23;
                            log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                            si32(this.i24, (this.i20 + 8));
                            this.i1 = li32(this.i7);
                            this.i0 = (this.i20 + 12);
                            this.i20 = (this.i21 + 1);
                            if (this.i1 <= this.i20) goto _label_21;
                            this.i1 = this.i0;
                            this.i0 = this.i20;
                        } while (true);
                        
                    _label_19: 
                        if ((this.i11 > 0)) break;
                        this.i0 = 0;
                    } while (true);
                    this.i0 = 0;
                    this.i19 = this.i14;
                    this.i18 = this.i0;
                    goto _label_18;
                    do 
                    {
                        this.i1 = this.i20;
                        
                    _label_20: 
                        this.i20 = this.i0;
                        this.i21 = this.i1;
                        this.i22 = __2E_str16;
                        this.i23 = 4;
                        this.i24 = 0;
                        this.i0 = this.i22;
                        this.i1 = this.i23;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i24, this.i20);
                        this.i0 = this.i22;
                        this.i1 = this.i23;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i24, (this.i20 + 4));
                        this.i0 = this.i22;
                        this.i1 = this.i23;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        si32(this.i24, (this.i20 + 8));
                        this.i1 = li32(this.i6);
                        this.i0 = (this.i20 + 12);
                        this.i20 = (this.i21 + 1);
                    } while ((this.i1 > this.i20));
                    this.i0 = this.i1;
                    goto _label_22;
                    
                _label_21: 
                    this.i0 = li32(this.i6);
                    if (this.i0 > 0) goto _label_46;
                    
                _label_22: 
                    this.i1 = this.i0;
                    this.i0 = li32(this.i13);
                    this.i19 = (this.i19 + this.i0);
                    if (uint(this.i19) <= uint(this.i8)) goto _label_23;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 12:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 79;
                    si32(this.i0, _val_2E_1440);
                    goto _label_28;
                    
                _label_23: 
                    this.i8 = 0;
                    this.i19 = li32(this.i12);
                    this.i20 = li32(this.i7);
                    this.i19 = (this.i20 + this.i19);
                    this.i1 = (this.i19 + this.i1);
                    this.i1 = (this.i1 << 2);
                    this.i1 = (this.i1 + this.i18);
                    this.i1 = (this.i1 << 2);
                    this.i1 = (this.i0 + this.i1);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 + 3156);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 13:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i1 == 0)) goto _label_24;
                    this.i1 = 0;
                    this.i6 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 14:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i6, _val_2E_1440);
                    goto _label_28;
                    
                _label_24: 
                    this.i0 = 82;
                    this.i8 = (this.i1 + 3156);
                    si32(this.i8, (this.i1 + 3148));
                    this.i8 = 117;
                    this.i18 = 110;
                    this.i19 = 101;
                    this.i20 = 77;
                    this.i21 = 97;
                    this.i22 = 103;
                    this.i23 = 105;
                    si8(this.i0, this.i1);
                    si8(this.i8, (this.i1 + 1));
                    si8(this.i18, (this.i1 + 2));
                    si8(this.i19, (this.i1 + 3));
                    si8(this.i20, (this.i1 + 4));
                    si8(this.i21, (this.i1 + 5));
                    si8(this.i22, (this.i1 + 6));
                    si8(this.i23, (this.i1 + 7));
                    this.i0 = (this.i1 + 8);
                    this.i8 = (this.i10 + 8);
                    this.i10 = 32;
                    memcpy(this.i0, this.i8, this.i10);
                    this.i0 = 0;
                    si32(this.i0, (this.i1 + 48));
                    this.i8 = li32(this.i13);
                    si32(this.i8, (this.i1 + 3152));
                    this.i8 = li32(this.i12);
                    si32(this.i8, (this.i1 + 3124));
                    this.i7 = li32(this.i7);
                    si32(this.i7, (this.i1 + 3132));
                    this.i6 = li32(this.i6);
                    si32(this.i6, (this.i1 + 3140));
                    this.i10 = (this.i1 + 3140);
                    this.i12 = (this.i1 + 3132);
                    this.i13 = (this.i1 + 3124);
                    this.i18 = (this.i1 + 3152);
                    this.i19 = (this.i1 + 3148);
                    this.i20 = this.i1;
                    this.i21 = this.i0;
                    do 
                    {
                        this.i22 = (this.i9 + this.i21);
                        this.i23 = li32(this.i22 + 40);
                        this.i24 = (this.i20 + this.i21);
                        si32(this.i23, (this.i24 + 52));
                        this.i23 = li32(this.i22 + 1064);
                        si32(this.i23, (this.i24 + 1076));
                        this.i22 = li32(this.i22 + 2088);
                        si32(this.i22, (this.i24 + 2100));
                        this.i21 = (this.i21 + 4);
                        this.i0 = (this.i0 + 1);
                    } while (!(this.i0 == 0x0100));
                    this.i0 = li32(this.i19);
                    this.i9 = (this.i7 + this.i6);
                    this.i7 = (this.i8 + this.i7);
                    this.i20 = (this.i8 << 4);
                    this.i9 = (this.i8 + this.i9);
                    this.i7 = (this.i7 << 4);
                    si32(this.i0, (this.i1 + 3128));
                    this.i20 = (this.i0 + this.i20);
                    this.i6 = (this.i17 + this.i6);
                    this.i9 = (this.i9 << 4);
                    si32(this.i20, (this.i1 + 3136));
                    this.i7 = (this.i0 + this.i7);
                    si32(this.i7, (this.i1 + 3144));
                    this.i7 = (this.i0 + this.i9);
                    this.i6 = (this.i6 * 12);
                    si32(this.i7, this.i19);
                    this.i7 = (this.i1 + 3128);
                    this.i9 = (this.i1 + 3136);
                    this.i17 = (this.i1 + 3144);
                    this.i6 = (this.i15 + this.i6);
                    if (!(this.i8 > 0))
                    {
                        this.i0 = this.i6;
                    }
                    else
                    {
                        this.i8 = 0;
                        this.i15 = this.i14;
                        
                    _label_25: 
                        this.i20 = li32(this.i15);
                        si32(this.i20, this.i0);
                        this.i21 = li32(this.i15 + 4);
                        si32(this.i21, (this.i0 + 4));
                        this.i22 = li32(this.i15 + 8);
                        si32(this.i22, (this.i0 + 8));
                        if (!(!(this.i22 == 0)))
                        {
                            this.i22 = (this.i21 - this.i20);
                            this.i22 = (this.i22 + 1);
                            this.i23 = li32(this.i19);
                            this.i24 = (this.i22 << 2);
                            si32(this.i23, (this.i0 + 12));
                            this.i23 = (this.i23 + this.i24);
                            si32(this.i23, this.i19);
                            this.i23 = (this.i0 + 12);
                            this.i24 = (this.i6 + this.i24);
                            if (!(this.i22 > 0))
                            {
                                
                            _label_26: 
                                this.i6 = this.i24;
                                goto _label_27;
                            };
                            this.i20 = (this.i21 - this.i20);
                            this.i21 = (this.i20 << 2);
                            this.i20 = (this.i20 + 1);
                            do 
                            {
                                this.i22 = (this.i6 + this.i21);
                                this.i25 = li32(this.i23);
                                this.i22 = li32(this.i22);
                                this.i25 = (this.i25 + this.i21);
                                si32(this.i22, this.i25);
                                this.i21 = (this.i21 + -4);
                                this.i20 = (this.i20 + -1);
                                if (this.i20 < 1) goto _label_26;
                            } while (true);
                        };
                        this.i20 = 0;
                        si32(this.i20, (this.i0 + 12));
                        
                    _label_27: 
                        this.i20 = li32(this.i13);
                        this.i0 = (this.i0 + 16);
                        this.i15 = (this.i15 + 12);
                        this.i8 = (this.i8 + 1);
                        if (this.i20 > this.i8) goto _label_47;
                        this.i0 = this.i6;
                    };
                    this.i6 = li32(this.i9);
                    this.i8 = li32(this.i12);
                    if (!(this.i8 < 1))
                    {
                        this.i8 = 0;
                        this.i15 = (this.i11 * 12);
                        this.i15 = (this.i14 + this.i15);
                        do 
                        {
                            this.i20 = li32(this.i15);
                            si32(this.i20, this.i6);
                            this.i20 = li32(this.i15 + 4);
                            si32(this.i20, (this.i6 + 4));
                            this.i20 = li32(this.i15 + 8);
                            si32(this.i20, (this.i6 + 8));
                            this.i20 = li32(this.i12);
                            this.i6 = (this.i6 + 16);
                            this.i15 = (this.i15 + 12);
                            this.i8 = (this.i8 + 1);
                        } while (!(this.i20 <= this.i8));
                    };
                    this.i6 = li32(this.i17);
                    this.i8 = li32(this.i10);
                    if (!(this.i8 < 1))
                    {
                        this.i8 = 0;
                        this.i11 = (this.i11 + this.i16);
                        this.i11 = (this.i11 * 12);
                        this.i11 = (this.i14 + this.i11);
                        do 
                        {
                            this.i14 = li32(this.i11);
                            si32(this.i14, this.i6);
                            this.i14 = li32(this.i11 + 4);
                            si32(this.i14, (this.i6 + 4));
                            this.i14 = li32(this.i11 + 8);
                            si32(this.i14, (this.i6 + 8));
                            this.i14 = li32(this.i10);
                            this.i6 = (this.i6 + 16);
                            this.i11 = (this.i11 + 12);
                            this.i8 = (this.i8 + 1);
                        } while (!(this.i14 <= this.i8));
                    };
                    this.i6 = 0;
                    this.i8 = li32(this.i18);
                    this.i11 = li32(this.i19);
                    memcpy(this.i11, this.i0, this.i8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 15:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i18);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = 0;
                        si32(this.i0, this.i19);
                    };
                    this.i0 = li32(this.i13);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = 0;
                        si32(this.i0, this.i7);
                    };
                    this.i0 = li32(this.i12);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = 0;
                        si32(this.i0, this.i9);
                    };
                    this.i0 = li32(this.i10);
                    if ((this.i0 == 0))
                    {
                        this.i0 = 0;
                        si32(this.i0, this.i17);
                    };
                    
                _label_28: 
                    this.i0 = this.i1;
                    this.i1 = this.i0;
                    if (!(this.i0 == 0)) goto _label_29;
                    this.i2 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 16:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == 0) ? 79 : this.i2);
                    goto _label_40;
                    
                _label_29: 
                    this.i5 = 0;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 17:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i5, ___mbrtowc);
                    si32(this.i5, ___mbsinit);
                    this.i4 = ___mbsnrtowcs_std;
                    si32(this.i4, ___mbsnrtowcs);
                    si32(this.i5, ___wcrtomb);
                    this.i4 = ___wcsnrtombs_std;
                    si32(this.i4, ___wcsnrtombs);
                    si32(this.i5, (this.i0 + 44));
                    si32(this.i5, (this.i0 + 40));
                    this.i4 = li8(this.i0 + 8);
                    if (!(this.i4 == 78))
                    {
                        this.i5 = __2E_str547;
                        this.i6 = this.i4;
                        goto _label_34;
                    };
                    this.i5 = __2E_str547;
                    this.i6 = 0;
                    this.i7 = this.i4;
                    
                _label_30: 
                    this.i8 = (this.i5 + this.i6);
                    this.i8 = (this.i8 + 1);
                    this.i7 = (this.i7 & 0xFF);
                    if (!(this.i7 == 0)) goto _label_33;
                    
                _label_31: 
                    this.i2 = -1;
                    
                _label_32: 
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 18:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_8;
                    
                _label_33: 
                    this.i7 = (this.i1 + this.i6);
                    this.i7 = li8(this.i7 + 9);
                    this.i8 = li8(this.i8);
                    this.i6 = (this.i6 + 1);
                    if (!(!(this.i7 == this.i8))) goto _label_30;
                    this.i5 = __2E_str547;
                    this.i5 = (this.i5 + this.i6);
                    this.i6 = this.i7;
                    
                _label_34: 
                    this.i5 = li8(this.i5);
                    this.i6 = (this.i6 & 0xFF);
                    if (this.i6 == this.i5) goto _label_31;
                    this.i5 = (this.i4 & 0xFF);
                    if (!(this.i5 == 85))
                    {
                        this.i5 = __2E_str648;
                        this.i6 = this.i4;
                    }
                    else
                    {
                        this.i5 = __2E_str648;
                        this.i6 = 0;
                        this.i7 = this.i4;
                        do 
                        {
                            this.i8 = (this.i5 + this.i6);
                            this.i8 = (this.i8 + 1);
                            this.i7 = (this.i7 & 0xFF);
                            if (this.i7 == 0) goto _label_35;
                            this.i7 = (this.i1 + this.i6);
                            this.i7 = li8(this.i7 + 9);
                            this.i8 = li8(this.i8);
                            this.i6 = (this.i6 + 1);
                        } while (!(!(this.i7 == this.i8)));
                        this.i5 = __2E_str648;
                        this.i5 = (this.i5 + this.i6);
                        this.i6 = this.i7;
                    };
                    this.i5 = li8(this.i5);
                    this.i6 = (this.i6 & 0xFF);
                    if (!(!(this.i6 == this.i5)))
                    {
                        
                    _label_35: 
                        this.i1 = __UTF8_mbrtowc;
                        si32(this.i1, ___mbrtowc);
                        this.i1 = __UTF8_wcrtomb;
                        si32(this.i1, ___wcrtomb);
                        this.i1 = __UTF8_mbsinit;
                        si32(this.i1, ___mbsinit);
                        this.i1 = __UTF8_mbsnrtowcs;
                        si32(this.i1, ___mbsnrtowcs);
                        this.i1 = __UTF8_wcsnrtombs;
                        si32(this.i1, ___wcsnrtombs);
                        si32(this.i0, __CurrentRuneLocale);
                        this.i0 = 6;
                        si32(this.i0, ___mb_cur_max);
                        this.i0 = 0;
                    }
                    else
                    {
                        this.i5 = (this.i4 & 0xFF);
                        if (!(this.i5 == 69))
                        {
                            this.i5 = __2E_str749;
                            this.i6 = this.i4;
                        }
                        else
                        {
                            this.i5 = __2E_str749;
                            this.i6 = 0;
                            this.i7 = this.i4;
                            do 
                            {
                                this.i8 = (this.i5 + this.i6);
                                this.i8 = (this.i8 + 1);
                                this.i7 = (this.i7 & 0xFF);
                                if (this.i7 == 0) goto _label_31;
                                this.i7 = (this.i1 + this.i6);
                                this.i7 = li8(this.i7 + 9);
                                this.i8 = li8(this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(!(this.i7 == this.i8)));
                            this.i5 = __2E_str749;
                            this.i5 = (this.i5 + this.i6);
                            this.i6 = this.i7;
                        };
                        this.i5 = li8(this.i5);
                        this.i6 = (this.i6 & 0xFF);
                        if (this.i6 == this.i5) goto _label_31;
                        this.i5 = (this.i4 & 0xFF);
                        if (!(this.i5 == 71))
                        {
                            this.i5 = __2E_str850;
                            this.i6 = this.i4;
                        }
                        else
                        {
                            this.i5 = __2E_str850;
                            this.i6 = 0;
                            this.i7 = this.i4;
                            do 
                            {
                                this.i8 = (this.i5 + this.i6);
                                this.i8 = (this.i8 + 1);
                                this.i7 = (this.i7 & 0xFF);
                                if (this.i7 == 0) goto _label_31;
                                this.i7 = (this.i1 + this.i6);
                                this.i7 = li8(this.i7 + 9);
                                this.i8 = li8(this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(!(this.i7 == this.i8)));
                            this.i5 = __2E_str850;
                            this.i5 = (this.i5 + this.i6);
                            this.i6 = this.i7;
                        };
                        this.i5 = li8(this.i5);
                        this.i6 = (this.i6 & 0xFF);
                        if (this.i6 == this.i5) goto _label_31;
                        this.i5 = (this.i4 & 0xFF);
                        if (!(this.i5 == 71))
                        {
                            this.i5 = __2E_str951;
                            this.i6 = this.i4;
                        }
                        else
                        {
                            this.i5 = __2E_str951;
                            this.i6 = 0;
                            this.i7 = this.i4;
                            do 
                            {
                                this.i8 = (this.i5 + this.i6);
                                this.i8 = (this.i8 + 1);
                                this.i7 = (this.i7 & 0xFF);
                                if (this.i7 == 0) goto _label_31;
                                this.i7 = (this.i1 + this.i6);
                                this.i7 = li8(this.i7 + 9);
                                this.i8 = li8(this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(!(this.i7 == this.i8)));
                            this.i5 = __2E_str951;
                            this.i5 = (this.i5 + this.i6);
                            this.i6 = this.i7;
                        };
                        this.i5 = li8(this.i5);
                        this.i6 = (this.i6 & 0xFF);
                        if (this.i6 == this.i5) goto _label_31;
                        this.i5 = (this.i4 & 0xFF);
                        if (!(this.i5 == 71))
                        {
                            this.i5 = __2E_str1052;
                            this.i6 = this.i4;
                        }
                        else
                        {
                            this.i5 = __2E_str1052;
                            this.i6 = 0;
                            this.i7 = this.i4;
                            do 
                            {
                                this.i8 = (this.i5 + this.i6);
                                this.i8 = (this.i8 + 1);
                                this.i7 = (this.i7 & 0xFF);
                                if (this.i7 == 0) goto _label_31;
                                this.i7 = (this.i1 + this.i6);
                                this.i7 = li8(this.i7 + 9);
                                this.i8 = li8(this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(!(this.i7 == this.i8)));
                            this.i5 = __2E_str1052;
                            this.i5 = (this.i5 + this.i6);
                            this.i6 = this.i7;
                        };
                        this.i5 = li8(this.i5);
                        this.i6 = (this.i6 & 0xFF);
                        if (this.i6 == this.i5) goto _label_31;
                        this.i5 = (this.i4 & 0xFF);
                        if (!(this.i5 == 66))
                        {
                            this.i5 = __2E_str1153;
                            this.i6 = this.i4;
                        }
                        else
                        {
                            this.i5 = __2E_str1153;
                            this.i6 = 0;
                            this.i7 = this.i4;
                            do 
                            {
                                this.i8 = (this.i5 + this.i6);
                                this.i8 = (this.i8 + 1);
                                this.i7 = (this.i7 & 0xFF);
                                if (this.i7 == 0) goto _label_31;
                                this.i7 = (this.i1 + this.i6);
                                this.i7 = li8(this.i7 + 9);
                                this.i8 = li8(this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(!(this.i7 == this.i8)));
                            this.i5 = __2E_str1153;
                            this.i5 = (this.i5 + this.i6);
                            this.i6 = this.i7;
                        };
                        this.i5 = li8(this.i5);
                        this.i6 = (this.i6 & 0xFF);
                        if (this.i6 == this.i5) goto _label_31;
                        this.i5 = (this.i4 & 0xFF);
                        if (!(this.i5 == 77))
                        {
                            this.i1 = __2E_str12163;
                        }
                        else
                        {
                            this.i5 = __2E_str12163;
                            this.i6 = 0;
                            do 
                            {
                                this.i7 = (this.i5 + this.i6);
                                this.i7 = (this.i7 + 1);
                                this.i4 = (this.i4 & 0xFF);
                                if (this.i4 == 0) goto _label_36;
                                this.i4 = (this.i1 + this.i6);
                                this.i4 = li8(this.i4 + 9);
                                this.i7 = li8(this.i7);
                                this.i6 = (this.i6 + 1);
                            } while (!(!(this.i4 == this.i7)));
                            this.i1 = __2E_str12163;
                            this.i1 = (this.i1 + this.i6);
                        };
                        this.i1 = li8(this.i1);
                        this.i4 = (this.i4 & 0xFF);
                        if (!(this.i4 == this.i1))
                        {
                            this.i1 = 79;
                        }
                        else
                        {
                            
                        _label_36: 
                            this.i1 = -1;
                        };
                        if (!(this.i1 == 0))
                        {
                            this.i2 = this.i1;
                            goto _label_32;
                        };
                        this.i0 = this.i1;
                    };
                    this.i1 = li32(_CachedRuneLocale_2E_3155);
                    this.i4 = this.i1;
                    if (this.i1 == 0) goto _label_39;
                    this.i5 = li8(this.i4 + 8);
                    if (!(this.i5 == 69))
                    {
                        this.i1 = __2E_str749;
                    }
                    else
                    {
                        this.i6 = __2E_str749;
                        this.i7 = 0;
                        do 
                        {
                            this.i8 = (this.i6 + this.i7);
                            this.i8 = (this.i8 + 1);
                            this.i5 = (this.i5 & 0xFF);
                            if (this.i5 == 0) goto _label_37;
                            this.i5 = (this.i1 + this.i7);
                            this.i5 = li8(this.i5 + 9);
                            this.i8 = li8(this.i8);
                            this.i7 = (this.i7 + 1);
                        } while (!(!(this.i5 == this.i8)));
                        this.i1 = __2E_str749;
                        this.i1 = (this.i1 + this.i7);
                    };
                    this.i1 = li8(this.i1);
                    this.i5 = (this.i5 & 0xFF);
                    if (!(this.i5 == this.i1)) goto _label_38;
                    
                _label_37: 
                    this.i1 = 0;
                    this.i5 = li32(this.i4 + 3148);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 19:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_38: 
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 20:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_39: 
                    this.i1 = li32(__CurrentRuneLocale);
                    si32(this.i1, _CachedRuneLocale_2E_3155);
                    this.i1 = li32(___mb_cur_max);
                    si32(this.i1, _Cached__mb_cur_max_2E_3156);
                    this.i1 = li32(___mbrtowc);
                    si32(this.i1, _Cached__mbrtowc_2E_3161);
                    this.i1 = li32(___mbsinit);
                    si32(this.i1, _Cached__mbsinit_2E_3167);
                    this.i1 = li32(___mbsnrtowcs);
                    si32(this.i1, _Cached__mbsnrtowcs_2E_3173);
                    this.i1 = li32(___wcrtomb);
                    si32(this.i1, _Cached__wcrtomb_2E_3165);
                    this.i1 = li32(___wcsnrtombs);
                    si32(this.i1, _Cached__wcsnrtombs_2E_3179);
                    this.i2 = li8(this.i2);
                    si8(this.i2, _ctype_encoding_2E_3154);
                    if (!(this.i2 == 0))
                    {
                        this.i2 = _ctype_encoding_2E_3154;
                        this.i1 = 1;
                        do 
                        {
                            this.i4 = (this.i3 + this.i1);
                            this.i4 = li8(this.i4);
                            this.i5 = (this.i2 + this.i1);
                            si8(this.i4, this.i5);
                            this.i1 = (this.i1 + 1);
                        } while (!(this.i4 == 0));
                    };
                    if (this.i0 == 0) goto _label_9;
                    this.i2 = this.i0;
                    
                _label_40: 
                    this.i0 = this.i2;
                    this.i1 = -1;
                    si32(this.i0, _val_2E_1440);
                    public::mstate.eax = this.i1;
                    goto _label_2;
                    
                _label_41: 
                    this.i4 = this.i1;
                    
                _label_42: 
                    this.i5 = (public::mstate.ebp + -5120);
                    this.i4 = (this.i4 - this.i0);
                    this.i6 = 47;
                    this.i7 = 0;
                    this.i4 = (this.i5 + this.i4);
                    si8(this.i6, this.i4);
                    si8(this.i7, (this.i4 + 1));
                    this.i4 = li8(this.i1);
                    if (this.i4 == 0) goto _label_5;
                    this.i4 = this.i0;
                    do 
                    {
                        this.i5 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i6 = this.i4;
                        if (this.i5 == 0) goto _label_6;
                        this.i4 = this.i6;
                    } while (true);
                    
                _label_43: 
                    this.i4 = this.i1;
                    
                _label_44: 
                    this.i5 = (public::mstate.ebp + -5120);
                    this.i0 = (this.i4 - this.i0);
                    this.i0 = (this.i5 + this.i0);
                    this.i4 = __2E_str345;
                    this.i5 = 10;
                    memcpy(this.i0, this.i4, this.i5);
                    this.i0 = li8(__2E_str19170 + 2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = 114;
                    this.i5 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fopen387.start();
                    return;
                case 21:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i4 == 0)) goto _label_10;
                    this.i2 = li32(_val_2E_1440);
                    if (this.i2 == 0) goto _label_7;
                    goto _label_40;
                    
                _label_45: 
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 22:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 79;
                    si32(this.i0, _val_2E_1440);
                    goto _label_28;
                    
                _label_46: 
                    this.i1 = 0;
                    this.i0 = (this.i11 + this.i16);
                    this.i0 = (this.i0 * 12);
                    this.i0 = (this.i14 + this.i0);
                    goto _label_20;
                    
                _label_47: 
                    goto _label_25;
                default:
                    throw ("Invalid state in ___wrap_setrunelocale");
            };
        }


    }
} cmodule.lua_wrapper

