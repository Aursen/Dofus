package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_match384 extends Machine 
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
            var _local_1:FSM_match384;
            _local_1 = new (FSM_match384)();
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
                    this.i3 = (this.i0 + 12);
                    this.i4 = (this.i0 + 8);
                    this.i5 = (this.i0 + 4);
                    this.i6 = this.i0;
                    this.i7 = this.i0;
                    
                _label_1: 
                    this.i8 = sxi8(li8(this.i2));
                    this.i9 = this.i2;
                    if (!(this.i8 > 36))
                    {
                        if (this.i8 == 0) goto _label_43;
                        if (!(this.i8 == 36)) goto _label_3;
                        
                    _label_2: 
                        this.i9 = li8(this.i2 + 1);
                        if (this.i9 == 0) goto _label_26;
                        goto _label_29;
                    };
                    if (this.i8 == 37) goto _label_15;
                    if (!(this.i8 == 40))
                    {
                        if (!(this.i8 == 41)) goto _label_3;
                        goto _label_13;
                    };
                    goto _label_5;
                    
                _label_3: 
                    goto _label_29;
                    
                _label_4: 
                    this.i1 = (this.i9 + this.i1);
                    this.i2 = this.i1;
                    this.i1 = this.i10;
                    
                _label_5: 
                    this.i5 = li8(this.i2 + 1);
                    this.i6 = (this.i2 + 1);
                    if (!(this.i5 == 41)) goto _label_10;
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 + 2);
                    if (this.i6 < 32) goto _label_6;
                    this.i5 = __2E_str23453;
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_6: 
                    this.i4 = -2;
                    this.i5 = (this.i6 << 3);
                    this.i5 = (this.i0 + this.i5);
                    si32(this.i1, (this.i5 + 16));
                    si32(this.i4, (this.i5 + 20));
                    this.i6 = (this.i6 + 1);
                    si32(this.i6, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i1 == 0)))
                    {
                        
                    _label_7: 
                        this.i2 = li32(this.i3);
                        this.i2 = (this.i2 + -1);
                        si32(this.i2, this.i3);
                        //unresolved jump
                    };
                    
                _label_8: 
                    public::mstate.eax = this.i1;
                    
                _label_9: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_10: 
                    this.i2 = li32(this.i3);
                    if (this.i2 < 32) goto _label_11;
                    this.i5 = __2E_str23453;
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_11: 
                    this.i4 = -1;
                    this.i5 = (this.i2 << 3);
                    this.i5 = (this.i0 + this.i5);
                    si32(this.i1, (this.i5 + 16));
                    si32(this.i4, (this.i5 + 20));
                    this.i2 = (this.i2 + 1);
                    si32(this.i2, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 4:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i1 == 0)) goto _label_27;
                    goto _label_7;
                    
                _label_12: 
                    this.i1 = (this.i9 + this.i1);
                    this.i2 = this.i1;
                    this.i1 = this.i10;
                    
                _label_13: 
                    this.i3 = li32(this.i3);
                    this.i2 = (this.i2 + 1);
                    this.i5 = (this.i3 + -1);
                    if (!(this.i5 < 0))
                    {
                        this.i5 = (this.i3 << 3);
                        this.i5 = (this.i7 + this.i5);
                        this.i5 = (this.i5 + 12);
                        this.i3 = (this.i3 + -1);
                        do 
                        {
                            this.i6 = li32(this.i5);
                            if (!(!(this.i6 == -1))) goto _label_14;
                            this.i5 = (this.i5 + -8);
                            this.i3 = (this.i3 + -1);
                        } while (!(this.i3 < 0));
                    };
                    this.i3 = __2E_str34464;
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = 0;
                    
                _label_14: 
                    this.i3 = (this.i3 << 3);
                    this.i3 = (this.i0 + this.i3);
                    this.i4 = li32(this.i3 + 16);
                    this.i4 = (this.i1 - this.i4);
                    si32(this.i4, (this.i3 + 20));
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 6:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = (this.i3 + 20);
                    if (!(this.i1 == 0)) goto _label_43;
                    this.i0 = -1;
                    si32(this.i0, this.i2);
                    //unresolved jump
                    
                _label_15: 
                    this.i8 = 0;
                    
                _label_16: 
                    this.i10 = (this.i9 + this.i8);
                    this.i10 = li8(this.i10 + 1);
                    this.i11 = (this.i10 << 24);
                    this.i11 = (this.i11 >> 24);
                    this.i12 = this.i1;
                    if (this.i11 == 102) goto _label_20;
                    if (!(this.i11 == 98)) goto _label_22;
                    this.i10 = (this.i9 + this.i8);
                    this.i11 = li8(this.i10 + 2);
                    this.i10 = (this.i10 + 2);
                    if (!(this.i11 == 0))
                    {
                        this.i11 = (this.i9 + this.i8);
                        this.i11 = li8(this.i11 + 3);
                        if (!(this.i11 == 0)) goto _label_17;
                    };
                    this.i11 = __2E_str35465;
                    this.i13 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_17: 
                    this.i11 = li8(this.i1);
                    this.i10 = li8(this.i10);
                    if (!(this.i11 == this.i10))
                    {
                        
                    _label_18: 
                        this.i1 = 0;
                        goto _label_43;
                    };
                    this.i11 = (this.i9 + this.i8);
                    this.i11 = li8(this.i11 + 3);
                    this.i13 = li32(this.i5);
                    this.i14 = (this.i1 + 1);
                    if (uint(this.i14) >= uint(this.i13)) goto _label_18;
                    this.i14 = 1;
                    this.i12 = (this.i12 + 1);
                    do 
                    {
                        this.i15 = li8(this.i12);
                        this.i16 = this.i12;
                        this.i17 = (this.i11 & 0xFF);
                        if (!(!(this.i15 == this.i17)))
                        {
                            this.i15 = (this.i14 + -1);
                            if ((this.i14 == 1)) break;
                            this.i1 = this.i15;
                        }
                        else
                        {
                            this.i1 = (this.i10 & 0xFF);
                            this.i15 = (this.i15 & 0xFF);
                            if (!(this.i15 == this.i1))
                            {
                                this.i1 = this.i14;
                            }
                            else
                            {
                                this.i1 = (this.i14 + 1);
                            };
                        };
                        this.i14 = this.i1;
                        this.i1 = (this.i12 + 1);
                        if (uint(this.i1) >= uint(this.i13)) goto _label_18;
                        this.i12 = this.i1;
                        this.i1 = this.i16;
                    } while (true);
                    this.i10 = (this.i1 + 2);
                    if (this.i10 == 0) goto _label_18;
                    this.i1 = (this.i9 + this.i8);
                    this.i12 = sxi8(li8(this.i1 + 4));
                    this.i1 = (this.i8 + 4);
                    if (!(this.i12 > 36))
                    {
                        if (this.i12 == 0) goto _label_19;
                        if (!(this.i12 == 36)) goto _label_28;
                        this.i1 = (this.i9 + this.i1);
                        this.i2 = this.i1;
                        this.i1 = this.i10;
                        goto _label_2;
                    };
                    if (this.i12 == 41) goto _label_12;
                    if (this.i12 == 40) goto _label_4;
                    if (!(this.i12 == 37)) goto _label_28;
                    this.i8 = this.i1;
                    this.i1 = this.i10;
                    goto _label_16;
                    
                _label_19: 
                    this.i1 = this.i10;
                    goto _label_43;
                    
                _label_20: 
                    this.i10 = (this.i8 | 0x02);
                    this.i2 = (this.i2 + this.i10);
                    this.i10 = li8(this.i2);
                    if (this.i10 == 91) goto _label_21;
                    this.i10 = __2E_str36466;
                    this.i8 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_21: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_classend.start();
                    return;
                case 9:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i6);
                    if (!(!(this.i8 == this.i1)))
                    {
                        this.i8 = 0;
                    }
                    else
                    {
                        this.i8 = li8(this.i1 + -1);
                    };
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = (this.i10 + -1);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_matchbracketclass.start();
                case 10:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i8 == 0)) goto _label_18;
                    this.i8 = li8(this.i1);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_matchbracketclass.start();
                case 11:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i2 == 0) goto _label_18;
                    this.i2 = this.i10;
                    goto _label_1;
                    
                _label_22: 
                    this.i9 = __DefaultRuneLocale;
                    this.i10 = (this.i10 & 0xFF);
                    this.i11 = (this.i10 << 2);
                    this.i9 = (this.i9 + this.i11);
                    this.i9 = li32(this.i9 + 52);
                    this.i11 = (this.i2 + this.i8);
                    this.i9 = (this.i9 & 0x0400);
                    if (!(!(this.i9 == 0)))
                    {
                        this.i2 = this.i11;
                        goto _label_29;
                    };
                    this.i9 = (this.i10 + -49);
                    if (!(this.i9 < 0))
                    {
                        this.i10 = li32(this.i3);
                        if (!(this.i10 <= this.i9))
                        {
                            this.i10 = (this.i9 << 3);
                            this.i10 = (this.i0 + this.i10);
                            this.i10 = li32(this.i10 + 20);
                            if (!(this.i10 == -1)) goto _label_23;
                        };
                    };
                    this.i9 = __2E_str21451;
                    this.i10 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = 0;
                    
                _label_23: 
                    this.i10 = (this.i9 << 3);
                    this.i10 = (this.i0 + this.i10);
                    this.i10 = li32(this.i10 + 20);
                    this.i11 = li32(this.i5);
                    this.i11 = (this.i11 - this.i12);
                    if (!(uint(this.i11) >= uint(this.i10)))
                    {
                        
                    _label_24: 
                        this.i1 = 0;
                        goto _label_25;
                    };
                    this.i9 = (this.i9 << 3);
                    this.i9 = (this.i0 + this.i9);
                    this.i9 = li32(this.i9 + 16);
                    if (!(this.i10 == 0))
                    {
                        this.i11 = 0;
                        this.i13 = (this.i10 + 1);
                        do 
                        {
                            this.i14 = (this.i12 + this.i11);
                            this.i15 = (this.i9 + this.i11);
                            this.i15 = li8(this.i15);
                            this.i14 = li8(this.i14);
                            if (!(this.i15 == this.i14)) goto _label_24;
                            this.i13 = (this.i13 + -1);
                            this.i11 = (this.i11 + 1);
                        } while (!(this.i13 == 1));
                    };
                    this.i1 = (this.i1 + this.i10);
                    
                _label_25: 
                    if (this.i1 == 0) goto _label_18;
                    this.i9 = (this.i8 | 0x02);
                    this.i2 = (this.i2 + this.i9);
                    goto _label_1;
                    
                _label_26: 
                    this.i2 = li32(this.i5);
                    this.i1 = ((this.i2 == this.i1) ? this.i1 : 0);
                    
                _label_27: 
                    goto _label_8;
                    
                _label_28: 
                    this.i1 = (this.i9 + this.i1);
                    this.i2 = this.i1;
                    this.i1 = this.i10;
                    
                _label_29: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_classend.start();
                    return;
                case 13:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = li32(this.i5);
                    this.i10 = this.i1;
                    if (uint(this.i9) <= uint(this.i1)) goto _label_33;
                    this.i9 = li8(this.i2);
                    this.i11 = li8(this.i1);
                    this.i12 = (this.i9 << 24);
                    this.i12 = (this.i12 >> 24);
                    this.i13 = this.i11;
                    if (!(this.i12 == 37))
                    {
                        if (this.i12 == 91) goto _label_30;
                        if (!(this.i12 == 46)) goto _label_31;
                        this.i9 = 1;
                        goto _label_32;
                    };
                    this.i9 = li8(this.i2 + 1);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match_class.start();
                case 14:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_32;
                    
                _label_30: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = (this.i8 + -1);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_matchbracketclass.start();
                case 15:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_32;
                    
                _label_31: 
                    this.i11 = (this.i11 & 0xFF);
                    this.i9 = (this.i9 & 0xFF);
                    this.i9 = ((this.i9 == this.i11) ? 1 : 0);
                    this.i9 = (this.i9 & 0x01);
                    
                _label_32: 
                    if (!(this.i9 == 0))
                    {
                        this.i9 = 1;
                    }
                    else
                    {
                        
                    _label_33: 
                        this.i9 = 0;
                    };
                    this.i11 = sxi8(li8(this.i8));
                    if (!(this.i11 > 44))
                    {
                        if (this.i11 == 42) goto _label_35;
                        if (!(this.i11 == 43)) goto _label_42;
                        if (this.i9 == 0) goto _label_18;
                        public::mstate.esp = (public::mstate.esp - 16);
                        this.i1 = (this.i1 + 1);
                        goto _label_36;
                    };
                    if (this.i11 == 45) goto _label_37;
                    if (!(this.i11 == 63)) goto _label_42;
                    if (this.i9 == 0) goto _label_34;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i1 + 1);
                    this.i9 = (this.i8 + 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 16:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i2 == 0))
                    {
                        this.i1 = this.i2;
                        goto _label_43;
                    };
                    
                _label_34: 
                    this.i2 = (this.i8 + 1);
                    goto _label_1;
                    
                _label_35: 
                    public::mstate.esp = (public::mstate.esp - 16);
                    
                _label_36: 
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_max_expand.start();
                    return;
                case 17:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    goto _label_27;
                    
                _label_37: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i8 + 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 18:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i1 == 0)) goto _label_43;
                    this.i1 = (this.i8 + -1);
                    this.i4 = (this.i2 + 1);
                    this.i6 = this.i10;
                    
                _label_38: 
                    this.i7 = li32(this.i5);
                    this.i8 = this.i6;
                    if (uint(this.i7) <= uint(this.i6)) goto _label_18;
                    this.i7 = li8(this.i2);
                    this.i8 = li8(this.i8);
                    this.i9 = (this.i7 << 24);
                    this.i9 = (this.i9 >> 24);
                    this.i10 = this.i8;
                    if (!(this.i9 == 37))
                    {
                        if (this.i9 == 91) goto _label_39;
                        if (!(this.i9 == 46)) goto _label_40;
                        this.i7 = 1;
                        goto _label_41;
                    };
                    this.i7 = li8(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match_class.start();
                case 19:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_41;
                    
                _label_39: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_matchbracketclass.start();
                case 20:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_41;
                    
                _label_40: 
                    this.i8 = (this.i8 & 0xFF);
                    this.i7 = (this.i7 & 0xFF);
                    this.i7 = ((this.i7 == this.i8) ? 1 : 0);
                    this.i7 = (this.i7 & 0x01);
                    
                _label_41: 
                    if (this.i7 == 0) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (this.i6 + 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 21:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i7 == 0))
                    {
                        this.i1 = this.i7;
                    }
                    else
                    {
                        goto _label_38;
                        
                    _label_42: 
                        if (this.i9 == 0) goto _label_18;
                        this.i1 = (this.i1 + 1);
                        this.i2 = this.i8;
                        goto _label_1;
                    };
                    
                _label_43: 
                    this.i0 = this.i1;
                    public::mstate.eax = this.i0;
                    goto _label_9;
                default:
                    throw ("Invalid state in _match384");
            };
        }


    }
}

