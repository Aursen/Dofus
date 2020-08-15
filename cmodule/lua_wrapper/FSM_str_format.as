package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_str_format extends Machine 
    {

        public static const intRegCount:int = 21;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
        public var i19:int;
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
        public var i18:int;
        public var i20:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_str_format;
            _local_1 = new (FSM_str_format)();
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
                    public::mstate.esp = (public::mstate.esp - 1592);
                    this.i0 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = (public::mstate.ebp + -1040);
                    this.i3 = li32(public::mstate.ebp + -4);
                    si32(this.i1, (public::mstate.ebp + -1032));
                    this.i4 = (this.i2 + 12);
                    si32(this.i4, (public::mstate.ebp + -1040));
                    this.i4 = 0;
                    si32(this.i4, (public::mstate.ebp + -1036));
                    this.i4 = (this.i2 + 4);
                    this.i5 = (this.i2 + 8);
                    this.i3 = (this.i0 + this.i3);
                    this.i6 = (public::mstate.ebp + -1584);
                    this.i7 = (public::mstate.ebp + -1072);
                    if (uint(this.i0) >= uint(this.i3)) goto _label_26;
                    this.i8 = (public::mstate.ebp + -1040);
                    this.i8 = (this.i8 + 1036);
                    this.i9 = 1;
                    this.i10 = (this.i1 + 8);
                    this.i11 = (public::mstate.ebp + -1584);
                    this.i12 = (public::mstate.ebp + -1072);
                    
                _label_1: 
                    this.i13 = li8(this.i0);
                    this.i14 = this.i0;
                    if (this.i13 == 37) goto _label_3;
                    this.i14 = li32(this.i2);
                    if (uint(this.i14) < uint(this.i8)) goto _label_2;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 2:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i14 == 0) goto _label_2;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i14 = li32(this.i2);
                    this.i13 = li8(this.i0);
                    si8(this.i13, this.i14);
                    this.i14 = (this.i14 + 1);
                    si32(this.i14, this.i2);
                    this.i0 = (this.i0 + 1);
                    if (uint(this.i0) >= uint(this.i3)) goto _label_26;
                    goto _label_1;
                    
                _label_3: 
                    this.i13 = li8(this.i0 + 1);
                    this.i15 = (this.i0 + 1);
                    if (!(this.i13 == 37)) goto _label_5;
                    this.i13 = li32(this.i2);
                    if (uint(this.i13) < uint(this.i8)) goto _label_4;
                    this.i13 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i13, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 4:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i13 == 0) goto _label_4;
                    this.i13 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i13, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i13 = li32(this.i2);
                    this.i14 = li8(this.i15);
                    si8(this.i14, this.i13);
                    this.i13 = (this.i13 + 1);
                    si32(this.i13, this.i2);
                    this.i0 = (this.i0 + 2);
                    if (uint(this.i0) >= uint(this.i3)) goto _label_26;
                    goto _label_1;
                    
                _label_5: 
                    this.i9 = (this.i9 + 1);
                    this.i0 = (this.i13 & 0xFF);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = this.i14;
                    }
                    else
                    {
                        this.i0 = this.i15;
                        goto _label_8;
                        
                    _label_6: 
                        this.i13 = li8(this.i0 + 2);
                        this.i0 = (this.i0 + 1);
                        if (this.i13 == 0) goto _label_47;
                    };
                    this.i13 = __2E_str28458;
                    this.i16 = li8(this.i0 + 1);
                    this.i17 = 7;
                    do 
                    {
                        this.i18 = li8(this.i13);
                        this.i19 = (this.i16 & 0xFF);
                        this.i20 = this.i13;
                        if (!(!(this.i18 == this.i19)))
                        {
                            this.i13 = this.i20;
                            goto _label_7;
                        };
                        this.i17 = (this.i17 + -1);
                        this.i13 = (this.i13 + 1);
                    } while (!(this.i17 == 1));
                    this.i13 = 0;
                    
                _label_7: 
                    if (!(this.i13 == 0)) goto _label_6;
                    this.i0 = (this.i0 + 1);
                    
                _label_8: 
                    this.i13 = this.i15;
                    this.i15 = (this.i0 - this.i15);
                    if (uint(this.i15) < uint(6)) goto _label_9;
                    this.i15 = __2E_str29459;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_9: 
                    this.i15 = __DefaultRuneLocale;
                    this.i16 = li8(this.i0);
                    this.i16 = (this.i16 << 2);
                    this.i15 = (this.i15 + this.i16);
                    this.i15 = li32(this.i15 + 52);
                    this.i15 = (this.i15 & 0x0400);
                    if ((!(this.i15 == 0)))
                    {
                        this.i0 = (this.i0 + 1);
                    };
                    this.i15 = __DefaultRuneLocale;
                    this.i16 = li8(this.i0);
                    this.i16 = (this.i16 << 2);
                    this.i15 = (this.i15 + this.i16);
                    this.i15 = li32(this.i15 + 52);
                    this.i15 = (this.i15 & 0x0400);
                    if ((!(this.i15 == 0)))
                    {
                        this.i0 = (this.i0 + 1);
                    };
                    this.i15 = li8(this.i0);
                    if ((this.i15 == 46))
                    {
                        this.i15 = __DefaultRuneLocale;
                        this.i16 = li8(this.i0 + 1);
                        this.i16 = (this.i16 << 2);
                        this.i15 = (this.i15 + this.i16);
                        this.i15 = li32(this.i15 + 52);
                        this.i16 = (this.i0 + 1);
                        this.i15 = (this.i15 & 0x0400);
                        if (!(!(this.i15 == 0)))
                        {
                            this.i0 = this.i16;
                        }
                        else
                        {
                            this.i0 = (this.i0 + 2);
                        };
                        this.i15 = __DefaultRuneLocale;
                        this.i16 = li8(this.i0);
                        this.i16 = (this.i16 << 2);
                        this.i15 = (this.i15 + this.i16);
                        this.i15 = li32(this.i15 + 52);
                        this.i15 = (this.i15 & 0x0400);
                        if ((!(this.i15 == 0)))
                        {
                            this.i0 = (this.i0 + 1);
                        };
                    };
                    this.i15 = __DefaultRuneLocale;
                    this.i16 = li8(this.i0);
                    this.i16 = (this.i16 << 2);
                    this.i15 = (this.i15 + this.i16);
                    this.i15 = li32(this.i15 + 52);
                    this.i15 = (this.i15 & 0x0400);
                    if (this.i15 == 0) goto _label_10;
                    this.i15 = __2E_str30460;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_10: 
                    this.i15 = 37;
                    this.i16 = (1 - this.i13);
                    si8(this.i15, this.i12);
                    this.i15 = (this.i0 + this.i16);
                    if (!(this.i15 == 0))
                    {
                        this.i16 = 1;
                        _loop_1:
                        do 
                        {
                            this.i17 = (this.i14 + this.i16);
                            this.i17 = li8(this.i17);
                            this.i18 = (this.i7 + this.i16);
                            si8(this.i17, this.i18);
                            if ((this.i17 == 0))
                            {
                                if ((this.i15 == 1)) break;
                                this.i14 = 0;
                                do 
                                {
                                    this.i17 = (public::mstate.ebp + -1072);
                                    this.i18 = (this.i16 + this.i14);
                                    this.i17 = (this.i18 + this.i17);
                                    this.i18 = 0;
                                    si8(this.i18, (this.i17 + 1));
                                    this.i17 = (this.i14 + 1);
                                    this.i14 = (this.i15 - this.i14);
                                    if ((this.i14 == 2)) break _loop_1;
                                    this.i14 = this.i17;
                                } while (true);
                            };
                            this.i17 = (this.i15 + -1);
                            this.i16 = (this.i16 + 1);
                            if ((this.i15 == 1)) break;
                            this.i15 = this.i17;
                        } while (true);
                    };
                    this.i14 = (public::mstate.ebp + -1072);
                    this.i13 = (2 - this.i13);
                    this.i13 = (this.i0 + this.i13);
                    this.i15 = 0;
                    this.i13 = (this.i14 + this.i13);
                    si8(this.i15, this.i13);
                    this.i13 = sxi8(li8(this.i0));
                    this.i0 = (this.i0 + 1);
                    if (this.i13 > 104) goto _label_15;
                    if (this.i13 > 98) goto _label_13;
                    if (this.i13 == 69) goto _label_14;
                    if (this.i13 == 71) goto _label_14;
                    if (this.i13 == 88) goto _label_21;
                    
                _label_11: 
                    this.i4 = __2E_str33463;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = 0;
                    public::mstate.eax = this.i4;
                    
                _label_12: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_13: 
                    if (this.i13 == 99) goto _label_22;
                    if (this.i13 == 100) goto _label_23;
                    this.i14 = (this.i13 + -101);
                    if (!(uint(this.i14) < uint(3))) goto _label_11;
                    
                _label_14: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checknumber.start();
                    return;
                case 9:
                    this.f0 = public::mstate.st0;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    sf64(this.f0, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i13 = li8(this.i11);
                    if (this.i13 == 0) goto _label_29;
                    this.i13 = this.i6;
                    do 
                    {
                        this.i14 = li8(this.i13 + 1);
                        this.i13 = (this.i13 + 1);
                        this.i15 = this.i13;
                        if (this.i14 == 0) goto _label_30;
                        this.i13 = this.i15;
                    } while (true);
                    
                _label_15: 
                    if (this.i13 > 114) goto _label_20;
                    if (this.i13 == 105) goto _label_23;
                    if (this.i13 == 111) goto _label_21;
                    if (!(this.i13 == 113)) goto _label_11;
                    this.i13 = (public::mstate.ebp + -1588);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 11:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = li32(this.i2);
                    if (uint(this.i14) < uint(this.i8)) goto _label_16;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 12:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i14 == 0) goto _label_16;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_16: 
                    this.i14 = 34;
                    this.i15 = li32(this.i2);
                    si8(this.i14, this.i15);
                    this.i14 = (this.i15 + 1);
                    si32(this.i14, this.i2);
                    this.i15 = li32(public::mstate.ebp + -1588);
                    this.i16 = (this.i15 + -1);
                    si32(this.i16, (public::mstate.ebp + -1588));
                    if (this.i15 == 0) goto _label_31;
                    
                _label_17: 
                    this.i15 = sxi8(li8(this.i13));
                    this.i16 = this.i13;
                    if (this.i15 > 12) goto _label_32;
                    if (this.i15 == 0) goto _label_39;
                    if (this.i15 == 10) goto _label_33;
                    
                _label_18: 
                    if (uint(this.i14) < uint(this.i8)) goto _label_19;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 14:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i14 == 0) goto _label_19;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_19: 
                    this.i14 = li32(this.i2);
                    this.i15 = li8(this.i16);
                    si8(this.i15, this.i14);
                    this.i14 = (this.i14 + 1);
                    si32(this.i14, this.i2);
                    goto _label_42;
                    
                _label_20: 
                    if (this.i13 == 115) goto _label_45;
                    if (!(this.i13 == 117))
                    {
                        if (!(this.i13 == 120)) goto _label_11;
                    };
                    
                _label_21: 
                    this.i13 = li8(this.i12);
                    if (this.i13 == 0) goto _label_27;
                    this.i13 = this.i7;
                    do 
                    {
                        this.i14 = li8(this.i13 + 1);
                        this.i13 = (this.i13 + 1);
                        this.i15 = this.i13;
                        if (this.i14 == 0) goto _label_28;
                        this.i13 = this.i15;
                    } while (true);
                    
                _label_22: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checknumber.start();
                    return;
                case 16:
                    this.f0 = public::mstate.st0;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = int(this.f0);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i13 = li8(this.i11);
                    if (this.i13 == 0) goto _label_48;
                    this.i13 = this.i6;
                    do 
                    {
                        this.i14 = li8(this.i13 + 1);
                        this.i13 = (this.i13 + 1);
                        this.i15 = this.i13;
                        if (this.i14 == 0) goto _label_49;
                        this.i13 = this.i15;
                    } while (true);
                    
                _label_23: 
                    this.i13 = li8(this.i12);
                    if (this.i13 == 0) goto _label_51;
                    this.i13 = this.i7;
                    do 
                    {
                        this.i14 = li8(this.i13 + 1);
                        this.i13 = (this.i13 + 1);
                        this.i15 = this.i13;
                        if (this.i14 == 0) goto _label_52;
                        this.i13 = this.i15;
                    } while (true);
                    
                _label_24: 
                    this.i13 = this.i11;
                    
                _label_25: 
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = (this.i13 - this.i6);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (uint(this.i0) < uint(this.i3)) goto _label_50;
                    
                _label_26: 
                    this.i0 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 19:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i4);
                    this.i1 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    goto _label_12;
                    
                _label_27: 
                    this.i13 = this.i12;
                    
                _label_28: 
                    this.i14 = (public::mstate.ebp + -1072);
                    this.i13 = (this.i13 - this.i7);
                    this.i15 = (this.i13 + this.i14);
                    this.i16 = li8(this.i15 + -1);
                    this.i17 = 108;
                    this.i18 = 0;
                    si8(this.i17, (this.i15 + -1));
                    si8(this.i18, this.i15);
                    this.i13 = (this.i14 + this.i13);
                    si8(this.i16, this.i13);
                    si8(this.i18, (this.i15 + 1));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checknumber.start();
                    return;
                case 21:
                    this.f0 = public::mstate.st0;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = uint(this.f0);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i13 = li8(this.i11);
                    if (this.i13 == 0) goto _label_53;
                    this.i13 = this.i6;
                    do 
                    {
                        this.i14 = li8(this.i13 + 1);
                        this.i13 = (this.i13 + 1);
                        this.i15 = this.i13;
                        if (this.i14 == 0) goto _label_54;
                        this.i13 = this.i15;
                    } while (true);
                    
                _label_29: 
                    this.i13 = this.i11;
                    
                _label_30: 
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = (this.i13 - this.i6);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (uint(this.i0) < uint(this.i3)) goto _label_50;
                    goto _label_26;
                    
                _label_31: 
                    this.i13 = this.i14;
                    goto _label_43;
                    
                _label_32: 
                    if (this.i15 == 13) goto _label_36;
                    if (!(this.i15 == 34))
                    {
                        if (!(this.i15 == 92)) goto _label_18;
                    };
                    
                _label_33: 
                    if (uint(this.i14) < uint(this.i8)) goto _label_34;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 24:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i14 == 0) goto _label_34;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_34: 
                    this.i14 = 92;
                    this.i15 = li32(this.i2);
                    si8(this.i14, this.i15);
                    this.i14 = (this.i15 + 1);
                    si32(this.i14, this.i2);
                    if (uint(this.i14) < uint(this.i8)) goto _label_35;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 26:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i14 == 0) goto _label_35;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_35: 
                    this.i14 = li32(this.i2);
                    this.i16 = li8(this.i16);
                    si8(this.i16, this.i14);
                    this.i14 = (this.i14 + 1);
                    si32(this.i14, this.i2);
                    goto _label_42;
                    
                _label_36: 
                    this.i16 = __2E_str31461;
                    this.i15 = 0;
                    
                _label_37: 
                    this.i17 = (this.i16 + this.i15);
                    if (uint(this.i14) < uint(this.i8)) goto _label_38;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 28:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i14 == 0) goto _label_38;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_38: 
                    this.i14 = li32(this.i2);
                    this.i17 = li8(this.i17);
                    si8(this.i17, this.i14);
                    this.i14 = (this.i14 + 1);
                    si32(this.i14, this.i2);
                    this.i15 = (this.i15 + 1);
                    if (!(this.i15 == 2)) goto _label_37;
                    goto _label_42;
                    
                _label_39: 
                    this.i16 = __2E_str32462;
                    this.i15 = 0;
                    
                _label_40: 
                    this.i17 = (this.i16 + this.i15);
                    if (uint(this.i14) < uint(this.i8)) goto _label_41;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 30:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i14 == 0) goto _label_41;
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_41: 
                    this.i14 = li32(this.i2);
                    this.i17 = li8(this.i17);
                    si8(this.i17, this.i14);
                    this.i14 = (this.i14 + 1);
                    si32(this.i14, this.i2);
                    this.i15 = (this.i15 + 1);
                    if (!(this.i15 == 4)) goto _label_40;
                    
                _label_42: 
                    this.i15 = li32(public::mstate.ebp + -1588);
                    this.i16 = (this.i15 + -1);
                    si32(this.i16, (public::mstate.ebp + -1588));
                    this.i13 = (this.i13 + 1);
                    if (!(this.i15 == 0)) goto _label_17;
                    this.i13 = this.i14;
                    
                _label_43: 
                    if (uint(this.i13) < uint(this.i8)) goto _label_44;
                    this.i13 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i13, public::mstate.esp);
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 32:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i13 == 0) goto _label_44;
                    this.i13 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i13, public::mstate.esp);
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_44: 
                    this.i13 = 34;
                    this.i14 = li32(this.i2);
                    si8(this.i13, this.i14);
                    this.i13 = (this.i14 + 1);
                    si32(this.i13, this.i2);
                    if (uint(this.i0) < uint(this.i3)) goto _label_50;
                    goto _label_26;
                    
                _label_45: 
                    this.i13 = (public::mstate.ebp + -1592);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 34:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = li8(this.i12);
                    if (this.i14 == 46) goto _label_55;
                    this.i14 = this.i7;
                    do 
                    {
                        this.i15 = li8(this.i14);
                        if (!(!(this.i15 == 0)))
                        {
                            this.i14 = 0;
                            goto _label_56;
                        };
                        this.i15 = li8(this.i14 + 1);
                        this.i14 = (this.i14 + 1);
                        this.i16 = this.i14;
                        if (this.i15 == 46) goto _label_56;
                        this.i14 = this.i16;
                    } while (true);
                    
                _label_46: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 35:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i13 = li8(this.i11);
                    if (this.i13 == 0) goto _label_57;
                    this.i13 = this.i6;
                    do 
                    {
                        this.i14 = li8(this.i13 + 1);
                        this.i13 = (this.i13 + 1);
                        this.i15 = this.i13;
                        if (this.i14 == 0) goto _label_58;
                        this.i13 = this.i15;
                    } while (true);
                    
                _label_47: 
                    this.i0 = (this.i0 + 1);
                    goto _label_8;
                    
                _label_48: 
                    this.i13 = this.i11;
                    
                _label_49: 
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = (this.i13 - this.i6);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 36:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (uint(this.i0) >= uint(this.i3)) goto _label_26;
                    
                _label_50: 
                    goto _label_1;
                    
                _label_51: 
                    this.i13 = this.i12;
                    
                _label_52: 
                    this.i14 = (public::mstate.ebp + -1072);
                    this.i13 = (this.i13 - this.i7);
                    this.i15 = (this.i13 + this.i14);
                    this.i16 = li8(this.i15 + -1);
                    this.i17 = 108;
                    this.i18 = 0;
                    si8(this.i17, (this.i15 + -1));
                    si8(this.i18, this.i15);
                    this.i13 = (this.i14 + this.i13);
                    si8(this.i16, this.i13);
                    si8(this.i18, (this.i15 + 1));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checknumber.start();
                    return;
                case 37:
                    this.f0 = public::mstate.st0;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = int(this.f0);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 38:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i13 = li8(this.i11);
                    if (this.i13 == 0) goto _label_24;
                    this.i13 = this.i6;
                    do 
                    {
                        this.i14 = li8(this.i13 + 1);
                        this.i13 = (this.i13 + 1);
                        this.i15 = this.i13;
                        if (this.i14 == 0) goto _label_25;
                        this.i13 = this.i15;
                    } while (true);
                    
                _label_53: 
                    this.i13 = this.i11;
                    
                _label_54: 
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = (this.i13 - this.i6);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 39:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (uint(this.i0) < uint(this.i3)) goto _label_50;
                    goto _label_26;
                    
                _label_55: 
                    this.i14 = this.i12;
                    
                _label_56: 
                    if (!(this.i14 == 0)) goto _label_46;
                    this.i14 = li32(public::mstate.ebp + -1592);
                    if (uint(this.i14) < uint(100)) goto _label_46;
                    this.i13 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 40:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i15 = li32(this.i10);
                    this.f0 = lf64(this.i14);
                    sf64(this.f0, this.i15);
                    this.i14 = li32(this.i14 + 8);
                    si32(this.i14, (this.i15 + 8));
                    this.i14 = li32(this.i10);
                    this.i14 = (this.i14 + 12);
                    si32(this.i14, this.i10);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i13, public::mstate.esp);
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addvalue.start();
                    return;
                case 41:
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (uint(this.i0) < uint(this.i3)) goto _label_50;
                    goto _label_26;
                    
                _label_57: 
                    this.i13 = this.i11;
                    
                _label_58: 
                    this.i14 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = (this.i13 - this.i6);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 42:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (uint(this.i0) < uint(this.i3)) goto _label_50;
                    goto _label_26;
                default:
                    throw ("Invalid state in _str_format");
            };
        }


    }
}

