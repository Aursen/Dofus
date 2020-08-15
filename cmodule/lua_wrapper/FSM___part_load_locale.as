package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___part_load_locale extends Machine 
    {

        public static const intRegCount:int = 18;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
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
            var _local_1:FSM___part_load_locale;
            _local_1 = new (FSM___part_load_locale)();
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
                    this.i3 = li32(public::mstate.ebp + 20);
                    this.i4 = li32(public::mstate.ebp + 32);
                    this.i5 = li32(public::mstate.ebp + 12);
                    this.i6 = li32(public::mstate.ebp + 16);
                    this.i7 = li32(public::mstate.ebp + 24);
                    this.i8 = li32(public::mstate.ebp + 28);
                    this.i9 = this.i2;
                    if (!(this.i1 == 67))
                    {
                        this.i10 = __2E_str3149;
                        this.i11 = this.i1;
                    }
                    else
                    {
                        this.i10 = __2E_str3149;
                        this.i11 = 0;
                        this.i12 = this.i1;
                        do 
                        {
                            this.i13 = (this.i10 + this.i11);
                            this.i13 = (this.i13 + 1);
                            this.i12 = (this.i12 & 0xFF);
                            if (this.i12 == 0) goto _label_1;
                            this.i12 = (this.i9 + this.i11);
                            this.i12 = li8(this.i12 + 1);
                            this.i13 = li8(this.i13);
                            this.i11 = (this.i11 + 1);
                        } while (!(!(this.i12 == this.i13)));
                        this.i10 = __2E_str3149;
                        this.i10 = (this.i10 + this.i11);
                        this.i11 = this.i12;
                    };
                    this.i10 = li8(this.i10);
                    this.i11 = (this.i11 & 0xFF);
                    if (!(this.i11 == this.i10))
                    {
                        this.i10 = (this.i1 & 0xFF);
                        if (!(this.i10 == 80))
                        {
                            this.i10 = __2E_str4150;
                            this.i11 = this.i1;
                        }
                        else
                        {
                            this.i10 = __2E_str4150;
                            this.i11 = 0;
                            this.i12 = this.i1;
                            do 
                            {
                                this.i13 = (this.i10 + this.i11);
                                this.i13 = (this.i13 + 1);
                                this.i12 = (this.i12 & 0xFF);
                                if (this.i12 == 0) goto _label_1;
                                this.i12 = (this.i9 + this.i11);
                                this.i12 = li8(this.i12 + 1);
                                this.i13 = li8(this.i13);
                                this.i11 = (this.i11 + 1);
                            } while (!(!(this.i12 == this.i13)));
                            this.i10 = __2E_str4150;
                            this.i10 = (this.i10 + this.i11);
                            this.i11 = this.i12;
                        };
                        this.i10 = li8(this.i10);
                        this.i11 = (this.i11 & 0xFF);
                        if (!(this.i11 == this.i10)) goto _label_2;
                    };
                    
                _label_1: 
                    this.i0 = 0;
                    si32(this.i0, this.i5);
                    this.i0 = 1;
                    goto _label_24;
                    
                _label_2: 
                    this.i10 = li32(this.i6);
                    this.i11 = this.i10;
                    if (!(this.i10 == 0))
                    {
                        this.i12 = li8(this.i11);
                        this.i13 = (this.i1 & 0xFF);
                        if (!(this.i13 == this.i12))
                        {
                            this.i10 = this.i11;
                            this.i11 = this.i1;
                        }
                        else
                        {
                            this.i11 = 0;
                            this.i12 = this.i1;
                            do 
                            {
                                this.i13 = (this.i10 + this.i11);
                                this.i13 = (this.i13 + 1);
                                this.i12 = (this.i12 & 0xFF);
                                if (this.i12 == 0) goto _label_3;
                                this.i12 = (this.i9 + this.i11);
                                this.i12 = li8(this.i12 + 1);
                                this.i13 = li8(this.i13);
                                this.i11 = (this.i11 + 1);
                            } while (!(!(this.i12 == this.i13)));
                            this.i10 = (this.i10 + this.i11);
                            this.i11 = this.i12;
                        };
                        this.i10 = li8(this.i10);
                        this.i11 = (this.i11 & 0xFF);
                        if (!(!(this.i11 == this.i10)))
                        {
                            
                        _label_3: 
                            this.i0 = 1;
                            si32(this.i0, this.i5);
                            goto _label_24;
                        };
                    };
                    this.i1 = (this.i1 & 0xFF);
                    if (this.i1 == 0) goto _label_26;
                    this.i1 = this.i9;
                    do 
                    {
                        this.i10 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i11 = this.i1;
                        if (this.i10 == 0) goto _label_27;
                        this.i1 = this.i11;
                    } while (true);
                    
                _label_4: 
                    this.i1 = li8(this.i10);
                    if (this.i1 == 0) goto _label_28;
                    this.i1 = this.i0;
                    do 
                    {
                        this.i11 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i12 = this.i1;
                        if (this.i11 == 0) goto _label_29;
                        this.i1 = this.i12;
                    } while (true);
                    
                _label_5: 
                    this.i1 = this.i10;
                    
                _label_6: 
                    this.i11 = 0;
                    do 
                    {
                        this.i12 = (this.i9 + this.i11);
                        this.i12 = li8(this.i12);
                        this.i15 = (this.i1 + this.i11);
                        si8(this.i12, this.i15);
                        this.i11 = (this.i11 + 1);
                    } while (!(this.i12 == 0));
                    this.i1 = li8(this.i10);
                    if (this.i1 == 0) goto _label_30;
                    this.i1 = this.i0;
                    do 
                    {
                        this.i11 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i12 = this.i1;
                        if (this.i11 == 0) goto _label_31;
                        this.i1 = this.i12;
                    } while (true);
                    
                _label_7: 
                    this.i0 = this.i10;
                    
                _label_8: 
                    this.i1 = 0;
                    do 
                    {
                        this.i11 = (this.i3 + this.i1);
                        this.i11 = li8(this.i11);
                        this.i12 = (this.i0 + this.i1);
                        si8(this.i11, this.i12);
                        this.i1 = (this.i1 + 1);
                    } while (!(this.i11 == 0));
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_open.start();
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i3 < 0) goto _label_23;
                    if (!(this.i3 > 1))
                    {
                        this.i1 = 1;
                        this.i10 = this.i0;
                        goto _label_10;
                    };
                    this.i0 = this.i3;
                    state = 2;
                case 2:
                    this.i0 = public::mstate.system.fsize(this.i0);
                    if (this.i0 > -1) goto _label_9;
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = __2E_str251;
                    this.i10 = 59;
                    this.i11 = 2;
                    this.i12 = (public::mstate.ebp + -4096);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i10, (public::mstate.esp + 16));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i12;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i11, _val_2E_1440);
                    this.i1 = 0;
                    this.i10 = this.i0;
                    goto _label_10;
                    
                _label_9: 
                    this.i1 = 1;
                    this.i11 = (this.i0 >> 31);
                    this.i10 = this.i0;
                    this.i0 = this.i11;
                    
                _label_10: 
                    this.i11 = this.i0;
                    this.i0 = this.i1;
                    this.i0 = (this.i0 ^ 0x01);
                    this.i0 = (this.i0 & 0x01);
                    if (!(this.i0 == 0)) goto _label_21;
                    this.i0 = ((this.i11 > 0) ? 1 : 0);
                    this.i1 = ((this.i10 != 0) ? 1 : 0);
                    this.i12 = ((this.i11 == 0) ? 1 : 0);
                    this.i0 = ((this.i12 != 0) ? this.i1 : this.i0);
                    if (!(this.i0 == 0)) goto _label_12;
                    this.i2 = 79;
                    
                _label_11: 
                    si32(this.i2, _val_2E_1440);
                    this.i0 = this.i3;
                    state = 4;
                case 4:
                    this.i0 = public::mstate.system.close(this.i0);
                    this.i3 = this.i0;
                    si32(this.i2, _val_2E_1440);
                    this.i2 = -1;
                    public::mstate.eax = this.i2;
                    goto _label_25;
                    
                _label_12: 
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i12 = (this.i10 + this.i13);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 5:
                    this.i15 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i16 = this.i15;
                    this.i17 = this.i10;
                    if (!(!(this.i15 == 0)))
                    {
                        this.i2 = 12;
                        goto _label_11;
                    };
                    this.i0 = li8(this.i2);
                    si8(this.i0, this.i15);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = 1;
                        do 
                        {
                            this.i1 = (this.i9 + this.i0);
                            this.i1 = li8(this.i1);
                            this.i2 = (this.i16 + this.i0);
                            si8(this.i1, this.i2);
                            this.i0 = (this.i0 + 1);
                        } while (!(this.i1 == 0));
                    };
                    this.i1 = (this.i15 + this.i13);
                    this.i0 = this.i3;
                    this.i2 = this.i17;
                    state = 6;
                case 6:
                    this.i0 = public::mstate.system.read(this.i0, this.i1, this.i2);
                    this.i1 = (this.i0 >> 31);
                    this.i1 = (this.i1 ^ this.i11);
                    this.i0 = (this.i0 ^ this.i10);
                    this.i0 = (this.i0 | this.i1);
                    if (!(this.i0 == 0)) goto _label_20;
                    this.i0 = (this.i12 + this.i15);
                    this.i0 = li8(this.i0 + -1);
                    if (!(!(this.i0 == 10)))
                    {
                        if (this.i13 < this.i12) goto _label_13;
                        this.i9 = 0;
                        goto _label_15;
                    };
                    this.i9 = 79;
                    si32(this.i9, _val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 0;
                    si32(this.i15, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i9, _val_2E_1440);
                    this.i0 = this.i3;
                    state = 8;
                case 8:
                    this.i0 = public::mstate.system.close(this.i0);
                    si32(this.i9, _val_2E_1440);
                    this.i9 = -1;
                    public::mstate.eax = this.i9;
                    goto _label_25;
                    
                _label_13: 
                    this.i0 = 0;
                    this.i9 = (this.i14 - this.i9);
                    this.i9 = (this.i9 + 1);
                    
                _label_14: 
                    this.i1 = (this.i16 + this.i9);
                    this.i2 = li8(this.i1);
                    if ((this.i2 == 10))
                    {
                        this.i2 = 0;
                        si8(this.i2, this.i1);
                        this.i0 = (this.i0 + 1);
                    };
                    this.i9 = (this.i9 + 1);
                    if (this.i9 < this.i12) goto _label_32;
                    this.i9 = this.i0;
                    
                _label_15: 
                    this.i0 = this.i9;
                    if (!(this.i0 < this.i7))
                    {
                        this.i0 = this.i7;
                    }
                    else
                    {
                        if (this.i0 < this.i8) goto _label_22;
                        this.i0 = this.i8;
                    };
                    this.i1 = this.i0;
                    this.i0 = this.i3;
                    state = 9;
                case 9:
                    this.i0 = public::mstate.system.close(this.i0);
                    this.i3 = this.i0;
                    this.i3 = li32(this.i6);
                    //unresolved if
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 10:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i15, this.i6);
                    if (!(this.i1 < 1))
                    {
                        do 
                        {
                            this.i3 = 0;
                            this.i6 = this.i4;
                            this.i0 = this.i3;
                            
                        _label_16: 
                            this.i2 = (this.i15 + this.i3);
                            this.i8 = li8(this.i2);
                            this.i9 = this.i6;
                            if ((!(this.i8 == 0))) continue;
                            this.i8 = this.i2;
                        } while ((this.i2 = (this.i8 - this.i2)), (this.i3 = (this.i2 + this.i3)), (this.i3 = (this.i3 + 1)), (this.i2 = (this.i15 + this.i3)), si32(this.i2, this.i9), (this.i6 = (this.i6 + 4)), (this.i0 = (this.i0 + 1)), if (this.i0 >= this.i1) goto _label_17;
, goto _label_16, (this.i8 = (this.i3 + this.i16)), do 
                        {
                            this.i10 = li8(this.i8 + 1);
                            this.i8 = (this.i8 + 1);
                            this.i11 = this.i8;
                            //unresolved if
                            this.i8 = this.i11;
                        } while (true), (this.i3 = 0), (this.i15 = (this.i1 << 2)), (this.i4 = (this.i4 + this.i15)), (this.i1 = (this.i7 - this.i1)), do 
                        {
                            this.i7 = 0;
                            si32(this.i7, this.i4);
                            this.i4 = (this.i4 + 4);
                            this.i3 = (this.i3 + 1);
                            if (this.i3 == this.i1) goto _label_18;
                        } while (true), si32(this.i15, this.i6), (this.i1 > 0));
                    };
                    
                _label_17: 
                    //unresolved if
                    
                _label_18: 
                    this.i3 = 1;
                    si32(this.i3, this.i5);
                    this.i3 = 0;
                    
                _label_19: 
                    public::mstate.eax = this.i3;
                    goto _label_25;
                    
                _label_20: 
                    this.i0 = 0;
                    this.i1 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i1, _val_2E_1440);
                    this.i0 = this.i3;
                    state = 12;
                case 12:
                    this.i0 = public::mstate.system.close(this.i0);
                    this.i3 = this.i0;
                    si32(this.i1, _val_2E_1440);
                    this.i3 = -1;
                    goto _label_19;
                    
                _label_21: 
                    this.i1 = -1;
                    this.i2 = li32(_val_2E_1440);
                    this.i0 = this.i3;
                    state = 13;
                case 13:
                    this.i0 = public::mstate.system.close(this.i0);
                    si32(this.i2, _val_2E_1440);
                    public::mstate.eax = this.i1;
                    goto _label_25;
                    
                _label_22: 
                    this.i4 = 79;
                    si32(this.i4, _val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 0;
                    si32(this.i15, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 14:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i4, _val_2E_1440);
                    this.i0 = this.i3;
                    state = 15;
                case 15:
                    this.i0 = public::mstate.system.close(this.i0);
                    si32(this.i4, _val_2E_1440);
                    
                _label_23: 
                    this.i0 = -1;
                    
                _label_24: 
                    public::mstate.eax = this.i0;
                    
                _label_25: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_26: 
                    this.i1 = this.i2;
                    
                _label_27: 
                    this.i10 = (public::mstate.ebp + -5120);
                    this.i11 = li32(__PathLocale);
                    this.i12 = li8(this.i11);
                    this.i13 = (this.i1 - this.i9);
                    si8(this.i12, (public::mstate.ebp + -5120));
                    this.i13 = (this.i13 + 1);
                    this.i14 = this.i1;
                    if (this.i12 == 0) goto _label_4;
                    this.i1 = 1;
                    do 
                    {
                        this.i12 = (this.i11 + this.i1);
                        this.i12 = li8(this.i12);
                        this.i15 = (this.i0 + this.i1);
                        si8(this.i12, this.i15);
                        this.i1 = (this.i1 + 1);
                        if (this.i12 == 0) goto _label_4;
                    } while (true);
                    
                _label_28: 
                    this.i1 = this.i10;
                    
                _label_29: 
                    this.i11 = (public::mstate.ebp + -5120);
                    this.i1 = (this.i1 - this.i0);
                    this.i12 = 47;
                    this.i15 = 0;
                    this.i1 = (this.i11 + this.i1);
                    si8(this.i12, this.i1);
                    si8(this.i15, (this.i1 + 1));
                    this.i1 = li8(this.i10);
                    if (this.i1 == 0) goto _label_5;
                    this.i1 = this.i0;
                    do 
                    {
                        this.i11 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i12 = this.i1;
                        if (this.i11 == 0) goto _label_6;
                        this.i1 = this.i12;
                    } while (true);
                    
                _label_30: 
                    this.i1 = this.i10;
                    
                _label_31: 
                    this.i11 = (public::mstate.ebp + -5120);
                    this.i1 = (this.i1 - this.i0);
                    this.i12 = 47;
                    this.i15 = 0;
                    this.i1 = (this.i11 + this.i1);
                    si8(this.i12, this.i1);
                    si8(this.i15, (this.i1 + 1));
                    this.i1 = li8(this.i10);
                    if (this.i1 == 0) goto _label_7;
                    do 
                    {
                        this.i1 = li8(this.i0 + 1);
                        this.i0 = (this.i0 + 1);
                        this.i11 = this.i0;
                        if (this.i1 == 0) goto _label_8;
                        this.i0 = this.i11;
                    } while (true);
                    
                _label_32: 
                    goto _label_14;
                default:
                    throw ("Invalid state in ___part_load_locale");
            };
        }


    }
}

