package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM__fseeko extends Machine 
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
            var _local_1:FSM__fseeko;
            _local_1 = new (FSM__fseeko)();
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
                    public::mstate.esp = (public::mstate.esp - 8200);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i0 = li32(this.i2 + 40);
                    this.i1 = li32(public::mstate.ebp + 20);
                    this.i3 = li32(public::mstate.ebp + 24);
                    this.i4 = li32(public::mstate.ebp + 12);
                    this.i5 = li32(public::mstate.ebp + 16);
                    if (!(!(this.i0 == 0)))
                    {
                        
                    _label_1: 
                        this.i0 = 29;
                        
                    _label_2: 
                        si32(this.i0, _val_2E_1440);
                        this.i0 = -1;
                        
                    _label_3: 
                        goto _label_31;
                    };
                    if (this.i1 == 0) goto _label_8;
                    if (this.i1 == 2) goto _label_10;
                    if (!(this.i1 == 1)) goto _label_11;
                    this.i1 = (public::mstate.ebp + -8200);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__ftello.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i1 == 0))
                    {
                        
                    _label_4: 
                        this.i0 = -1;
                        goto _label_31;
                    };
                    this.i1 = li32(public::mstate.ebp + -8200);
                    this.i6 = li32(public::mstate.ebp + -8196);
                    if (!(this.i6 > -1)) goto _label_1;
                    this.i7 = ((this.i5 < 0) ? 1 : 0);
                    this.i8 = ((this.i4 == 0) ? 1 : 0);
                    this.i9 = ((this.i5 == 0) ? 1 : 0);
                    this.i7 = ((this.i9 != 0) ? this.i8 : this.i7);
                    if (!(!(this.i7 == 0)))
                    {
                        this.i7 = 2147483647;
                        this.i8 = -1;
                        this.i8 = __subc(this.i8, this.i4);
                        this.i7 = __sube(this.i7, this.i5);
                        this.i9 = ((this.i7 >= this.i6) ? 1 : 0);
                        this.i8 = ((uint(this.i8) >= uint(this.i1)) ? 1 : 0);
                        this.i7 = ((this.i7 == this.i6) ? 1 : 0);
                        this.i7 = ((this.i7 != 0) ? this.i8 : this.i9);
                        if (!(!(this.i7 == 0)))
                        {
                            
                        _label_5: 
                            this.i0 = 84;
                            goto _label_2;
                        };
                    };
                    this.i1 = __addc(this.i1, this.i4);
                    this.i4 = __adde(this.i6, this.i5);
                    if (!(this.i4 > -1))
                    {
                        
                    _label_6: 
                        this.i0 = 22;
                        goto _label_2;
                    };
                    this.i5 = ((this.i4 < 0) ? 1 : 0);
                    this.i6 = ((uint(this.i1) < uint(-2147483648)) ? 1 : 0);
                    this.i7 = ((this.i4 == 0) ? 1 : 0);
                    this.i5 = ((this.i7 != 0) ? this.i6 : this.i5);
                    if (!(!(this.i5 == 0)))
                    {
                        if (!(this.i3 == 0))
                        {
                            
                        _label_7: 
                            goto _label_5;
                            
                        _label_8: 
                            if (!(this.i5 > -1))
                            {
                                
                            _label_9: 
                                goto _label_6;
                            };
                            
                        _label_10: 
                            this.i6 = 0;
                            si32(this.i6, (public::mstate.ebp + -8200));
                            si32(this.i6, (public::mstate.ebp + -8196));
                            this.i6 = li32(this.i2 + 16);
                            if (!(this.i6 == 0))
                            {
                                this.i6 = 1;
                                this.i7 = this.i1;
                                this.i1 = this.i4;
                                this.i4 = this.i5;
                                goto _label_13;
                            };
                            this.i6 = 1;
                            this.i7 = this.i1;
                            this.i1 = this.i4;
                            this.i4 = this.i5;
                            goto _label_12;
                            
                        _label_11: 
                            this.i1 = 22;
                            si32(this.i1, _val_2E_1440);
                            this.i1 = -1;
                            public::mstate.eax = this.i1;
                            goto _label_32;
                        };
                    };
                    this.i6 = li32(this.i2 + 16);
                    if (!(this.i6 == 0))
                    {
                        this.i6 = 0;
                        this.i7 = this.i6;
                        goto _label_13;
                    };
                    this.i6 = 0;
                    this.i7 = this.i6;
                    
                _label_12: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___smakebuf.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_13: 
                    this.i5 = this.i6;
                    this.i6 = this.i7;
                    this.i7 = this.i1;
                    this.i1 = li16(this.i2 + 12);
                    this.i8 = (this.i2 + 12);
                    this.i9 = (this.i1 & 0x081A);
                    if (!(this.i9 == 0)) goto _label_27;
                    this.i1 = (this.i1 & 0x0400);
                    if (!(this.i1 == 0)) goto _label_15;
                    this.i5 = ___sseek;
                    if (!(this.i0 == this.i5)) goto _label_14;
                    this.i0 = li16(this.i2 + 14);
                    this.i5 = (this.i0 << 16);
                    this.i5 = (this.i5 >> 16);
                    if (this.i5 < 2) goto _label_14;
                    this.i0 = (this.i0 << 16);
                    this.i0 = (this.i0 >> 16);
                    state = 3;
                case 3:
                    this.i0 = public::mstate.system.fsize(this.i0);
                    if (this.i0 > -1) goto _label_14;
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i5 = __2E_str251;
                    this.i1 = 59;
                    this.i9 = 2;
                    this.i10 = (public::mstate.ebp + -4096);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i1, (public::mstate.esp + 16));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i5 = 3;
                    this.i0 = this.i10;
                    this.i1 = this.i5;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i9, _val_2E_1440);
                    
                _label_14: 
                    this.i0 = li16(this.i8);
                    this.i0 = (this.i0 | 0x0800);
                    si16(this.i0, this.i8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflush.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i0 == 0) goto _label_28;
                    goto _label_4;
                    
                _label_15: 
                    if (!(!(this.i6 == 0)))
                    {
                        this.i0 = this.i7;
                        this.i1 = this.i4;
                        goto _label_19;
                    };
                    this.i0 = li16(this.i2 + 14);
                    this.i1 = (this.i0 << 16);
                    this.i1 = (this.i1 >> 16);
                    if (!(this.i1 > 1))
                    {
                        this.i1 = 1;
                        this.i9 = this.i0;
                        goto _label_17;
                    };
                    this.i0 = (this.i0 << 16);
                    this.i0 = (this.i0 >> 16);
                    state = 6;
                case 6:
                    this.i0 = public::mstate.system.fsize(this.i0);
                    if (this.i0 > -1) goto _label_16;
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = __2E_str251;
                    this.i9 = 59;
                    this.i10 = 2;
                    this.i11 = (public::mstate.ebp + -8192);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i9, (public::mstate.esp + 16));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i11;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i10, _val_2E_1440);
                    this.i1 = 0;
                    this.i9 = this.i0;
                    goto _label_17;
                    
                _label_16: 
                    this.i1 = 1;
                    this.i10 = (this.i0 >> 31);
                    this.i9 = this.i0;
                    this.i0 = this.i10;
                    
                _label_17: 
                    this.i1 = (this.i1 ^ 0x01);
                    this.i1 = (this.i1 & 0x01);
                    if (!(this.i1 == 0)) goto _label_27;
                    this.i1 = ((this.i4 < 0) ? 1 : 0);
                    this.i10 = ((this.i7 == 0) ? 1 : 0);
                    this.i11 = ((this.i4 == 0) ? 1 : 0);
                    this.i1 = ((this.i11 != 0) ? this.i10 : this.i1);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = 2147483647;
                        this.i10 = -1;
                        this.i10 = __subc(this.i10, this.i7);
                        this.i1 = __sube(this.i1, this.i4);
                        this.i11 = ((this.i0 <= this.i1) ? 1 : 0);
                        this.i10 = ((uint(this.i9) <= uint(this.i10)) ? 1 : 0);
                        this.i1 = ((this.i0 == this.i1) ? 1 : 0);
                        this.i1 = ((this.i1 != 0) ? this.i10 : this.i11);
                        if (!(!(this.i1 == 0)))
                        {
                            
                        _label_18: 
                            goto _label_7;
                        };
                    };
                    this.i1 = __addc(this.i9, this.i7);
                    this.i9 = __adde(this.i0, this.i4);
                    if (!(this.i9 > -1)) goto _label_9;
                    this.i0 = ((this.i9 < 0) ? 1 : 0);
                    this.i10 = ((uint(this.i1) < uint(-2147483648)) ? 1 : 0);
                    this.i11 = ((this.i9 == 0) ? 1 : 0);
                    this.i0 = ((this.i11 != 0) ? this.i10 : this.i0);
                    if (!(!(this.i0 == 0)))
                    {
                        if (!(this.i3 == 0)) goto _label_33;
                    };
                    this.i0 = this.i1;
                    this.i1 = this.i9;
                    
                _label_19: 
                    this.i5 = (this.i5 ^ 0x01);
                    this.i5 = (this.i5 & 0x01);
                    if (!(this.i5 == 0)) goto _label_20;
                    this.i5 = (public::mstate.ebp + -8200);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__ftello.start();
                    return;
                case 8:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i5 == 0)) goto _label_27;
                    
                _label_20: 
                    this.i5 = li16(this.i8);
                    this.i5 = (this.i5 & 0x2000);
                    if (!(this.i5 == 0)) goto _label_23;
                    this.i5 = li32(this.i2 + 48);
                    this.i9 = (this.i2 + 48);
                    if (!(this.i5 == 0))
                    {
                        this.i10 = 0;
                        this.i11 = li32(this.i2 + 4);
                        this.i12 = li32(public::mstate.ebp + -8200);
                        this.i13 = li32(public::mstate.ebp + -8196);
                        this.i14 = (this.i11 >> 31);
                        this.i11 = __addc(this.i11, this.i12);
                        this.i12 = __adde(this.i14, this.i13);
                        si32(this.i11, (public::mstate.ebp + -8200));
                        si32(this.i12, (public::mstate.ebp + -8196));
                        this.i13 = li32(this.i2 + 56);
                        this.i13 = li32(this.i13);
                        this.i14 = li32(this.i2 + 16);
                        this.i13 = (this.i13 - this.i14);
                        this.i11 = __subc(this.i11, this.i13);
                        this.i10 = __sube(this.i12, this.i10);
                        si32(this.i11, (public::mstate.ebp + -8200));
                        si32(this.i10, (public::mstate.ebp + -8196));
                        this.i12 = (this.i2 + 60);
                        this.i14 = ((this.i1 < this.i10) ? 1 : 0);
                        this.i15 = ((uint(this.i0) < uint(this.i11)) ? 1 : 0);
                        this.i16 = ((this.i1 == this.i10) ? 1 : 0);
                        this.i14 = ((this.i16 != 0) ? this.i15 : this.i14);
                        if (!(this.i14 == 0)) goto _label_23;
                    }
                    else
                    {
                        this.i10 = 0;
                        this.i11 = li32(this.i2);
                        this.i12 = li32(this.i2 + 16);
                        this.i13 = li32(public::mstate.ebp + -8200);
                        this.i14 = li32(public::mstate.ebp + -8196);
                        this.i15 = (this.i11 - this.i12);
                        this.i11 = __subc(this.i13, this.i15);
                        this.i10 = __sube(this.i14, this.i10);
                        si32(this.i11, (public::mstate.ebp + -8200));
                        si32(this.i10, (public::mstate.ebp + -8196));
                        this.i12 = (this.i2 + 4);
                        this.i13 = ((this.i1 < this.i10) ? 1 : 0);
                        this.i14 = ((uint(this.i0) < uint(this.i11)) ? 1 : 0);
                        this.i16 = ((this.i1 == this.i10) ? 1 : 0);
                        this.i13 = ((this.i16 != 0) ? this.i14 : this.i13);
                        if (!(this.i13 == 0)) goto _label_23;
                        this.i13 = this.i15;
                    };
                    this.i14 = 0;
                    this.i12 = li32(this.i12);
                    this.i12 = (this.i12 + this.i13);
                    this.i13 = __addc(this.i12, this.i11);
                    this.i10 = __adde(this.i10, this.i14);
                    this.i14 = ((this.i10 <= this.i1) ? 1 : 0);
                    this.i13 = ((uint(this.i13) <= uint(this.i0)) ? 1 : 0);
                    this.i10 = ((this.i10 == this.i1) ? 1 : 0);
                    this.i10 = ((this.i10 != 0) ? this.i13 : this.i14);
                    if (!(this.i10 == 0)) goto _label_23;
                    this.i1 = li32(this.i2 + 16);
                    this.i0 = (this.i0 - this.i11);
                    this.i1 = (this.i1 + this.i0);
                    si32(this.i1, this.i2);
                    this.i0 = (this.i12 - this.i0);
                    si32(this.i0, (this.i2 + 4));
                    if (this.i5 == 0) goto _label_22;
                    this.i0 = (this.i2 + 64);
                    if (this.i5 == this.i0) goto _label_21;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_21: 
                    this.i0 = 0;
                    si32(this.i0, this.i9);
                    
                _label_22: 
                    this.i0 = 0;
                    this.i1 = li16(this.i8);
                    this.i1 = (this.i1 & 0xFFFFFFDF);
                    si16(this.i1, this.i8);
                    this.i1 = li32(this.i2 + 56);
                    this.i1 = (this.i1 + 20);
                    this.i2 = 128;
                    memset(this.i1, this.i0, this.i2);
                    goto _label_31;
                    
                _label_23: 
                    this.i5 = 0;
                    this.i9 = li32(this.i2 + 76);
                    this.i9 = (0 - this.i9);
                    this.i10 = (this.i9 >> 31);
                    this.i1 = (this.i10 & this.i1);
                    this.i9 = (this.i9 & this.i0);
                    si32(this.i9, (public::mstate.ebp + -8200));
                    si32(this.i1, (public::mstate.ebp + -8196));
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__sseek.start();
                    return;
                case 10:
                    this.i1 = public::mstate.eax;
                    this.i5 = public::mstate.edx;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = (this.i1 & this.i5);
                    if (this.i1 == -1) goto _label_27;
                    this.i1 = 0;
                    si32(this.i1, (this.i2 + 4));
                    this.i1 = li32(this.i2 + 16);
                    si32(this.i1, this.i2);
                    this.i1 = li32(this.i2 + 48);
                    this.i5 = (this.i2 + 48);
                    this.i9 = (this.i2 + 4);
                    this.i10 = this.i2;
                    if (this.i1 == 0) goto _label_25;
                    this.i11 = (this.i2 + 64);
                    if (this.i1 == this.i11) goto _label_24;
                    this.i11 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 11:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_24: 
                    this.i1 = 0;
                    si32(this.i1, this.i5);
                    
                _label_25: 
                    this.i1 = li32(public::mstate.ebp + -8200);
                    this.i5 = (this.i0 - this.i1);
                    if (this.i0 == this.i1) goto _label_26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___srefill.start();
                    return;
                case 12:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = li32(this.i9);
                        if (!(uint(this.i0) < uint(this.i5)))
                        {
                            this.i2 = 0;
                            this.i3 = li32(this.i10);
                            this.i3 = (this.i3 + this.i5);
                            si32(this.i3, this.i10);
                            this.i0 = (this.i0 - this.i5);
                            si32(this.i0, this.i9);
                            this.i0 = li16(this.i8);
                            this.i0 = (this.i0 & 0xFFFFFFDF);
                            si16(this.i0, this.i8);
                            public::mstate.eax = this.i2;
                            goto _label_32;
                            
                        _label_26: 
                            this.i0 = 0;
                            this.i2 = li16(this.i8);
                            this.i2 = (this.i2 & 0xFFFFFFDF);
                            si16(this.i2, this.i8);
                            goto _label_3;
                        };
                    };
                    
                _label_27: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflush.start();
                    return;
                case 13:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i0 == 0)) goto _label_4;
                    
                _label_28: 
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__sseek.start();
                    return;
                case 14:
                    this.i0 = public::mstate.eax;
                    this.i1 = public::mstate.edx;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i4 = (this.i0 & this.i1);
                    if (this.i4 == -1) goto _label_4;
                    this.i4 = li32(this.i2 + 48);
                    this.i5 = (this.i2 + 48);
                    if (this.i4 == 0) goto _label_30;
                    this.i6 = (this.i2 + 64);
                    if (this.i4 == this.i6) goto _label_29;
                    this.i6 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 15:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_29: 
                    this.i4 = 0;
                    si32(this.i4, this.i5);
                    
                _label_30: 
                    this.i4 = 0;
                    this.i5 = li32(this.i2 + 16);
                    si32(this.i5, this.i2);
                    si32(this.i4, (this.i2 + 4));
                    this.i5 = li16(this.i8);
                    this.i5 = (this.i5 & 0xFFFFFFDF);
                    si16(this.i5, this.i8);
                    this.i2 = li32(this.i2 + 56);
                    this.i2 = (this.i2 + 20);
                    this.i5 = 128;
                    this.i6 = ((this.i1 < 0) ? 1 : 0);
                    this.i0 = ((uint(this.i0) < uint(-2147483648)) ? 1 : 0);
                    this.i1 = ((this.i1 == 0) ? 1 : 0);
                    memset(this.i2, this.i4, this.i5);
                    this.i0 = ((this.i1 != 0) ? this.i0 : this.i6);
                    if( ((!(this.i0 == 0))) || (!(!(this.i3 == 0))) )
                    {
                        this.i0 = 0;
                        
                    _label_31: 
                        public::mstate.eax = this.i0;
                        
                    _label_32: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_33: 
                        goto _label_18;
                    };
                    this.i0 = 84;
                    this.i1 = li16(this.i8);
                    this.i1 = (this.i1 | 0x40);
                    si16(this.i1, this.i8);
                    goto _label_2;
                default:
                    throw ("Invalid state in __fseeko");
            };
        }


    }
} cmodule.lua_wrapper

