package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___gethex_D2A extends Machine 
    {

        public static const intRegCount:int = 17;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i16:int;
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
            var _local_1:FSM___gethex_D2A;
            _local_1 = new (FSM___gethex_D2A)();
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
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(public::mstate.ebp + 20);
                    this.i4 = li32(public::mstate.ebp + 24);
                    this.i5 = li8(___mlocale_changed_2E_b);
                    if (!(!(this.i5 == 0)))
                    {
                        this.i5 = 1;
                        si8(this.i5, ___mlocale_changed_2E_b);
                    };
                    this.i5 = li8(___nlocale_changed_2E_b);
                    if (!(!(this.i5 == 0)))
                    {
                        this.i5 = __C_numeric_locale;
                        this.i6 = li32(__numeric_using_locale);
                        this.i7 = __numeric_locale;
                        this.i5 = ((this.i6 == 0) ? this.i5 : this.i7);
                        this.i6 = li32(this.i5);
                        si32(this.i6, _ret_2E_1494_2E_0);
                        this.i6 = li32(this.i5 + 4);
                        si32(this.i6, _ret_2E_1494_2E_1);
                        this.i5 = li32(this.i5 + 8);
                        si32(this.i5, _ret_2E_1494_2E_2);
                        this.i5 = 1;
                        si8(this.i5, ___nlocale_changed_2E_b);
                    };
                    this.i5 = li32(_ret_2E_1494_2E_0);
                    this.i5 = li8(this.i5);
                    this.i6 = li8(___hexdig_D2A + 48);
                    if (!(this.i6 == 0)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___hexdig_init_D2A.start();
                case 1:
                    this.i6 = li32(this.i0);
                    this.i7 = li8(this.i6 + 2);
                    if (!(this.i7 == 48))
                    {
                        this.i7 = 0;
                        goto _label_3;
                        
                    _label_1: 
                        this.i6 = 0;
                        this.i7 = li32(this.i0);
                    }
                    else
                    {
                        this.i7 = 0;
                        
                    _label_2: 
                        this.i8 = (this.i7 + 1);
                        this.i7 = this.i6;
                        this.i6 = this.i8;
                    };
                    this.i8 = this.i6;
                    this.i6 = (this.i8 + this.i7);
                    this.i6 = li8(this.i6 + 2);
                    if (this.i6 == 48) goto _label_37;
                    this.i6 = this.i7;
                    this.i7 = this.i8;
                    
                _label_3: 
                    this.i8 = ___hexdig_D2A;
                    this.i9 = (this.i7 + this.i6);
                    this.i10 = li8(this.i9 + 2);
                    this.i8 = (this.i8 + this.i10);
                    this.i8 = li8(this.i8);
                    this.i9 = (this.i9 + 2);
                    this.i11 = this.i6;
                    if (!(this.i8 == 0))
                    {
                        this.i6 = 0;
                        this.i7 = this.i9;
                    }
                    else
                    {
                        this.i8 = (this.i5 & 0xFF);
                        this.i10 = (this.i10 & 0xFF);
                        if (!(this.i10 == this.i8))
                        {
                            this.i6 = this.i7;
                            this.i7 = this.i9;
                            
                        _label_4: 
                            si32(this.i7, this.i0);
                            this.i7 = ((this.i6 == 0) ? 6 : 0);
                            public::mstate.eax = this.i7;
                            goto _label_33;
                        };
                        this.i9 = ___hexdig_D2A;
                        this.i6 = (this.i7 + this.i6);
                        this.i8 = li8(this.i6 + 3);
                        this.i9 = (this.i9 + this.i8);
                        this.i9 = li8(this.i9);
                        this.i10 = (this.i6 + 3);
                        if (!(!(this.i9 == 0)))
                        {
                            this.i6 = this.i7;
                            this.i7 = this.i10;
                            goto _label_4;
                        };
                        this.i6 = (this.i8 & 0xFF);
                        if (!(this.i6 == 48))
                        {
                            this.i7 = this.i10;
                        }
                        else
                        {
                            this.i7 = (this.i7 + this.i11);
                            do 
                            {
                                this.i6 = li8(this.i7 + 4);
                                this.i7 = (this.i7 + 1);
                            } while (!(!(this.i6 == 48)));
                            this.i7 = (this.i7 + 3);
                        };
                        this.i9 = this.i7;
                        this.i6 = ___hexdig_D2A;
                        this.i7 = li8(this.i9);
                        this.i6 = (this.i6 + this.i7);
                        this.i6 = li8(this.i6);
                        if (this.i6 == 0) goto _label_38;
                        this.i7 = this.i9;
                        this.i6 = this.i10;
                    };
                    this.i8 = this.i9;
                    this.i9 = ___hexdig_D2A;
                    this.i10 = li8(this.i7);
                    this.i9 = (this.i9 + this.i10);
                    this.i9 = li8(this.i9);
                    this.i10 = this.i7;
                    if (this.i9 == 0) goto _label_39;
                    this.i7 = this.i10;
                    do 
                    {
                        this.i9 = ___hexdig_D2A;
                        this.i10 = li8(this.i7 + 1);
                        this.i9 = (this.i9 + this.i10);
                        this.i9 = li8(this.i9);
                        this.i7 = (this.i7 + 1);
                        this.i10 = this.i7;
                        if (this.i9 == 0) goto _label_39;
                        this.i7 = this.i10;
                    } while (true);
                    
                _label_5: 
                    this.i6 = ___hexdig_D2A;
                    this.i9 = li8(this.i7 + 1);
                    this.i6 = (this.i6 + this.i9);
                    this.i6 = li8(this.i6);
                    this.i9 = (this.i7 + 1);
                    if (this.i6 == 0) goto _label_40;
                    this.i7 = this.i11;
                    do 
                    {
                        this.i11 = ___hexdig_D2A;
                        this.i6 = li8(this.i7 + 2);
                        this.i11 = (this.i11 + this.i6);
                        this.i11 = li8(this.i11);
                        this.i7 = (this.i7 + 1);
                    } while (!(this.i11 == 0));
                    this.i7 = (this.i7 + 1);
                    this.i11 = this.i9;
                    
                _label_6: 
                    this.i6 = this.i7;
                    this.i7 = this.i11;
                    if (!(!(this.i7 == 0)))
                    {
                        this.i7 = 0;
                    }
                    else
                    {
                        this.i7 = (this.i6 - this.i7);
                        this.i7 = (this.i7 << 2);
                        this.i7 = (0 - this.i7);
                    };
                    this.i9 = li8(this.i6);
                    if( ((this.i9 == 80)) || (!(!(this.i9 == 112))) )
                    {
                        this.i9 = li8(this.i6 + 1);
                        this.i10 = (this.i6 + 1);
                        if (!(this.i9 == 45))
                        {
                            if (!(!(this.i9 == 43)))
                            {
                                this.i10 = 0;
                                goto _label_7;
                            };
                            this.i9 = 0;
                            goto _label_8;
                        };
                        this.i10 = 1;
                        
                    _label_7: 
                        this.i9 = this.i10;
                        this.i10 = (this.i6 + 2);
                        
                    _label_8: 
                        this.i11 = ___hexdig_D2A;
                        this.i12 = li8(this.i10);
                        this.i11 = (this.i11 + this.i12);
                        this.i11 = li8(this.i11);
                        this.i12 = this.i10;
                        this.i13 = this.i11;
                        if (!(this.i11 > 25))
                        {
                            this.i13 = (this.i13 & 0xFF);
                            if (!(this.i13 == 0))
                            {
                                this.i13 = ___hexdig_D2A;
                                this.i14 = li8(this.i10 + 1);
                                this.i13 = (this.i13 + this.i14);
                                this.i13 = li8(this.i13);
                                this.i10 = (this.i10 + 1);
                                this.i14 = (this.i11 + -16);
                                this.i15 = this.i13;
                                if (!(this.i13 > 25))
                                {
                                    this.i15 = (this.i15 & 0xFF);
                                    if (!(this.i15 == 0)) goto _label_9;
                                };
                                this.i12 = this.i10;
                                this.i13 = this.i14;
                                this.i14 = this.i11;
                                goto _label_10;
                                
                            _label_9: 
                                this.i10 = ___hexdig_D2A;
                                this.i11 = li8(this.i12 + 2);
                                this.i10 = (this.i10 + this.i11);
                                this.i14 = (this.i14 * 10);
                                this.i10 = li8(this.i10);
                                this.i14 = (this.i13 + this.i14);
                                this.i12 = (this.i12 + 1);
                                this.i11 = (this.i14 + -16);
                                this.i13 = this.i10;
                                if (!(this.i10 > 25))
                                {
                                    this.i13 = (this.i13 & 0xFF);
                                    if (!(this.i13 == 0))
                                    {
                                        this.i13 = this.i10;
                                        this.i14 = this.i11;
                                        goto _label_9;
                                    };
                                };
                                this.i12 = (this.i12 + 1);
                                this.i13 = this.i11;
                                
                            _label_10: 
                                this.i10 = this.i12;
                                this.i11 = this.i13;
                                this.i12 = this.i14;
                                this.i12 = (16 - this.i12);
                                this.i13 = (this.i6 - this.i8);
                                this.i9 = ((this.i9 == 0) ? this.i11 : this.i12);
                                si32(this.i10, this.i0);
                                this.i0 = (this.i13 + -1);
                                this.i7 = (this.i9 + this.i7);
                                if (!(this.i0 > 7))
                                {
                                    this.i0 = 0;
                                    goto _label_13;
                                };
                                
                            _label_11: 
                                this.i9 = 0;
                                
                            _label_12: 
                                this.i9 = (this.i9 + 1);
                                this.i0 = (this.i0 >> 1);
                                if (this.i0 > 7) goto _label_41;
                                this.i0 = this.i9;
                                goto _label_13;
                            };
                        };
                    };
                    this.i9 = (this.i6 - this.i8);
                    si32(this.i6, this.i0);
                    this.i0 = (this.i9 + -1);
                    if (this.i0 > 7) goto _label_11;
                    this.i0 = 0;
                    
                _label_13: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___Balloc_D2A.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i9 = (this.i0 + 20);
                    if (!(uint(this.i6) > uint(this.i8)))
                    {
                        this.i5 = 0;
                        this.i6 = this.i9;
                    }
                    else
                    {
                        this.i10 = 0;
                        this.i11 = this.i10;
                        this.i12 = this.i10;
                        this.i13 = this.i9;
                        
                    _label_14: 
                        this.i14 = (this.i11 ^ 0xFFFFFFFF);
                        this.i14 = (this.i6 + this.i14);
                        this.i15 = li8(this.i14);
                        this.i16 = (this.i5 & 0xFF);
                        if ((!(this.i15 == this.i16)))
                        {
                            if ((this.i12 == 32))
                            {
                                this.i15 = 0;
                                si32(this.i10, this.i13);
                                this.i13 = (this.i13 + 4);
                                this.i12 = this.i15;
                                this.i10 = this.i15;
                            };
                            this.i15 = ___hexdig_D2A;
                            this.i16 = li8(this.i14);
                            this.i15 = (this.i15 + this.i16);
                            this.i15 = li8(this.i15);
                            this.i15 = (this.i15 & 0x0F);
                            this.i15 = (this.i15 << this.i12);
                            this.i12 = (this.i12 + 4);
                            this.i10 = (this.i15 | this.i10);
                        };
                        this.i11 = (this.i11 + 1);
                        if (uint(this.i14) > uint(this.i8)) goto _label_42;
                        this.i5 = this.i10;
                        this.i6 = this.i13;
                    };
                    this.i8 = ((uint(this.i5) < uint(0x10000)) ? 16 : 0);
                    this.i10 = (this.i5 << this.i8);
                    this.i11 = ((uint(this.i10) < uint(0x1000000)) ? 8 : 0);
                    this.i10 = (this.i10 << this.i11);
                    this.i12 = ((uint(this.i10) < uint(0x10000000)) ? 4 : 0);
                    this.i13 = (this.i0 + 20);
                    this.i14 = (this.i6 + 4);
                    this.i13 = (this.i14 - this.i13);
                    this.i8 = (this.i11 | this.i8);
                    this.i10 = (this.i10 << this.i12);
                    this.i11 = ((uint(this.i10) < uint(0x40000000)) ? 2 : 0);
                    this.i8 = (this.i8 | this.i12);
                    this.i12 = (this.i13 << 3);
                    si32(this.i5, this.i6);
                    this.i5 = (this.i13 >> 2);
                    si32(this.i5, (this.i0 + 16));
                    this.i5 = (this.i8 | this.i11);
                    this.i6 = (this.i10 << this.i11);
                    this.i8 = (this.i12 & 0xFFFFFFE0);
                    if ((this.i6 > -1))
                    {
                        this.i6 = (this.i6 & 0x40000000);
                        this.i5 = (this.i5 + 1);
                        this.i5 = ((this.i6 == 0) ? 32 : this.i5);
                    };
                    this.i6 = li32(this.i1);
                    this.i5 = (this.i8 - this.i5);
                    this.i8 = this.i1;
                    if (this.i5 <= this.i6) goto _label_19;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i5 - this.i6);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___any_on_D2A.start();
                case 3:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i10 == 0)) goto _label_16;
                    this.i10 = 0;
                    
                _label_15: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___rshift_D2A.start();
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = (this.i5 + this.i7);
                    goto _label_20;
                    
                _label_16: 
                    this.i10 = 1;
                    this.i11 = (this.i5 + -1);
                    this.i12 = (this.i11 >> 5);
                    this.i12 = (this.i12 << 2);
                    this.i13 = (this.i11 & 0x1F);
                    this.i12 = (this.i0 + this.i12);
                    this.i12 = li32(this.i12 + 20);
                    this.i10 = (this.i10 << this.i13);
                    this.i10 = (this.i12 & this.i10);
                    if (!(!(this.i10 == 0)))
                    {
                        this.i10 = 1;
                        goto _label_15;
                    };
                    if (!(this.i11 > 1))
                    {
                        
                    _label_17: 
                        this.i10 = 2;
                        goto _label_15;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i10 = (this.i5 + -2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___any_on_D2A.start();
                case 5:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i10 == 0) goto _label_17;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___rshift_D2A.start();
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i10 = li32(this.i1 + 8);
                    this.i5 = (this.i5 + this.i7);
                    if (!(this.i10 < this.i5))
                    {
                        this.i7 = 3;
                        
                    _label_18: 
                        this.i10 = li32(this.i1 + 4);
                        this.i11 = (this.i1 + 4);
                        if (this.i10 > this.i5) goto _label_22;
                        this.i10 = 1;
                        goto _label_29;
                    };
                    this.i5 = this.i0;
                    goto _label_21;
                    
                _label_19: 
                    if (!(this.i5 < this.i6))
                    {
                        this.i5 = 0;
                        this.i10 = this.i5;
                        this.i5 = this.i7;
                        goto _label_20;
                    };
                    this.i9 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i6 - this.i5);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___lshift_D2A.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = (this.i0 + 20);
                    this.i5 = (this.i7 - this.i5);
                    this.i10 = this.i9;
                    this.i9 = this.i11;
                    
                _label_20: 
                    this.i7 = this.i10;
                    this.i10 = li32(this.i1 + 8);
                    if (!(this.i10 < this.i5)) goto _label_18;
                    this.i5 = this.i0;
                    
                _label_21: 
                    if (!(this.i5 == 0))
                    {
                        this.i0 = _freelist;
                        this.i1 = li32(this.i5 + 4);
                        this.i1 = (this.i1 << 2);
                        this.i0 = (this.i0 + this.i1);
                        this.i1 = li32(this.i0);
                        si32(this.i1, this.i5);
                        si32(this.i5, this.i0);
                    };
                    this.i5 = 0;
                    si32(this.i5, this.i3);
                    this.i5 = 163;
                    goto _label_26;
                    
                _label_22: 
                    this.i5 = (this.i10 - this.i5);
                    if (this.i5 < this.i6) goto _label_27;
                    this.i7 = li32(this.i1 + 12);
                    if (this.i7 == 3) goto _label_23;
                    //unresolved if
                    if (!(this.i7 == 1)) goto _label_25;
                    if (!(this.i5 == this.i6)) goto _label_25;
                    if (this.i5 < 2) goto _label_24;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i5 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___any_on_D2A.start();
                case 8:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i5 == 0))
                    {
                        goto _label_24;
                        
                    _label_23: 
                        if (!(this.i4 == 0))
                        {
                            do 
                            {
                                
                            _label_24: 
                                this.i5 = 1;
                                si32(this.i10, this.i2);
                                si32(this.i5, (this.i0 + 16));
                                si32(this.i5, this.i9);
                                si32(this.i0, this.i3);
                                this.i5 = 98;
                                goto _label_26;
                            } while ((this.i4 == 0));
                        };
                    };
                    
                _label_25: 
                    if (!(this.i0 == 0))
                    {
                        this.i5 = _freelist;
                        this.i6 = li32(this.i0 + 4);
                        this.i6 = (this.i6 << 2);
                        this.i5 = (this.i5 + this.i6);
                        this.i6 = li32(this.i5);
                        si32(this.i6, this.i0);
                        si32(this.i0, this.i5);
                    };
                    this.i5 = 0;
                    si32(this.i5, this.i3);
                    this.i5 = 80;
                    
                _label_26: 
                    public::mstate.eax = this.i5;
                    goto _label_33;
                    
                _label_27: 
                    this.i10 = (this.i5 + -1);
                    if (!(this.i7 == 0))
                    {
                        this.i7 = 1;
                        goto _label_28;
                    };
                    if (!(this.i10 > 0)) goto _label_28;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___any_on_D2A.start();
                case 9:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_28: 
                    this.i12 = 1;
                    this.i13 = (this.i10 >> 5);
                    this.i13 = (this.i13 << 2);
                    this.i13 = (this.i9 + this.i13);
                    this.i13 = li32(this.i13);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i10 = (this.i10 & 0x1F);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    this.i10 = (this.i12 << this.i10);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___rshift_D2A.start();
                case 10:
                    this.i10 = (this.i13 & this.i10);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i10 = ((this.i10 == 0) ? 0 : 2);
                    this.i11 = li32(this.i11);
                    this.i5 = (this.i6 - this.i5);
                    this.i7 = (this.i10 | this.i7);
                    this.i6 = 2;
                    this.i10 = this.i6;
                    this.i6 = this.i5;
                    this.i5 = this.i11;
                    
                _label_29: 
                    if (this.i7 == 0) goto _label_36;
                    this.i11 = li32(this.i1 + 12);
                    if (!(this.i11 == 3))
                    {
                        if (this.i11 == 2) goto _label_34;
                        if (!(this.i11 == 1)) goto _label_35;
                        this.i4 = (this.i7 & 0x02);
                        if (this.i4 == 0) goto _label_35;
                        this.i4 = li32(this.i9);
                        this.i4 = (this.i4 | this.i7);
                        this.i4 = (this.i4 & 0x01);
                        if (this.i4 == 0) goto _label_35;
                    }
                    else
                    {
                        if (this.i4 == 0) goto _label_35;
                    };
                    
                _label_30: 
                    this.i4 = li32(this.i0 + 16);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___increment_D2A.start();
                    return;
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(!(this.i10 == 2)))
                    {
                        this.i1 = li32(this.i8);
                        this.i1 = (this.i1 + -1);
                        if (!(this.i1 == this.i6))
                        {
                            
                        _label_31: 
                            goto _label_32;
                        };
                        this.i1 = 1;
                        this.i4 = (this.i6 >> 5);
                        this.i4 = (this.i4 << 2);
                        this.i6 = (this.i6 & 0x1F);
                        this.i4 = (this.i0 + this.i4);
                        this.i4 = li32(this.i4 + 20);
                        this.i1 = (this.i1 << this.i6);
                        this.i1 = (this.i4 & this.i1);
                        if (this.i1 == 0) goto _label_31;
                        this.i1 = 33;
                        si32(this.i0, this.i3);
                        si32(this.i5, this.i2);
                        public::mstate.eax = this.i1;
                        goto _label_33;
                    };
                    this.i7 = li32(this.i0 + 16);
                    if (!(this.i7 > this.i4))
                    {
                        this.i6 = (this.i6 & 0x1F);
                        if (this.i6 == 0) goto _label_31;
                        this.i4 = (this.i4 << 2);
                        this.i4 = (this.i4 + this.i0);
                        this.i4 = li32(this.i4 + 16);
                        this.i7 = ((uint(this.i4) < uint(0x10000)) ? 16 : 0);
                        this.i4 = (this.i4 << this.i7);
                        this.i8 = ((uint(this.i4) < uint(0x1000000)) ? 8 : 0);
                        this.i4 = (this.i4 << this.i8);
                        this.i9 = ((uint(this.i4) < uint(0x10000000)) ? 4 : 0);
                        this.i7 = (this.i8 | this.i7);
                        this.i4 = (this.i4 << this.i9);
                        this.i8 = ((uint(this.i4) < uint(0x40000000)) ? 2 : 0);
                        this.i7 = (this.i7 | this.i9);
                        this.i7 = (this.i7 | this.i8);
                        this.i4 = (this.i4 << this.i8);
                        if (!(this.i4 > -1))
                        {
                            this.i4 = this.i7;
                        }
                        else
                        {
                            this.i4 = (this.i4 & 0x40000000);
                            this.i7 = (this.i7 + 1);
                            this.i4 = ((this.i4 == 0) ? 32 : this.i7);
                        };
                        this.i6 = (32 - this.i6);
                        if (this.i4 >= this.i6) goto _label_31;
                    };
                    this.i4 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___rshift_D2A.start();
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i1 + 8);
                    this.i5 = (this.i5 + 1);
                    if (!(this.i5 > this.i1))
                    {
                        
                    _label_32: 
                        si32(this.i0, this.i3);
                        si32(this.i5, this.i2);
                        this.i0 = (this.i10 | 0x20);
                        do 
                        {
                            public::mstate.eax = this.i0;
                            
                        _label_33: 
                            public::mstate.esp = public::mstate.ebp;
                            public::mstate.ebp = li32(public::mstate.esp);
                            public::mstate.esp = (public::mstate.esp + 4);
                            public::mstate.esp = (public::mstate.esp + 4);
                            public::mstate.gworker = caller;
                            return;
                            
                        _label_34: 
                            if (!(this.i4 == 1)) goto _label_30;
                            
                        _label_35: 
                            si32(this.i0, this.i3);
                            si32(this.i5, this.i2);
                            this.i0 = (this.i10 | 0x10);
                        } while (true);
                        
                    _label_36: 
                        si32(this.i0, this.i3);
                        si32(this.i5, this.i2);
                        public::mstate.eax = this.i10;
                        goto _label_33;
                        
                    _label_37: 
                        this.i6 = this.i7;
                        this.i7 = this.i8;
                        goto _label_2;
                        
                    _label_38: 
                        this.i6 = 1;
                        this.i7 = this.i9;
                        goto _label_4;
                        
                    _label_39: 
                        this.i9 = li8(this.i7);
                        this.i10 = (this.i5 & 0xFF);
                        this.i11 = this.i7;
                        if (!(!(this.i9 == this.i10)))
                        {
                            if (this.i6 == 0) goto _label_5;
                        };
                        this.i11 = this.i6;
                        goto _label_6;
                        
                    _label_40: 
                        this.i7 = this.i9;
                        this.i11 = this.i9;
                        goto _label_6;
                        
                    _label_41: 
                        goto _label_12;
                        
                    _label_42: 
                        goto _label_14;
                    };
                    this.i5 = this.i0;
                    goto _label_21;
                default:
                    throw ("Invalid state in ___gethex_D2A");
            };
        }


    }
} cmodule.lua_wrapper

