package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_primaryexp extends Machine 
    {

        public static const intRegCount:int = 29;
        public static const NumberRegCount:int = 1;

        public var i21:int;
        public var f0:Number;
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
        public var i26:int;
        public var i27:int;
        public var i20:int;
        public var i9:int;
        public var i28:int;


        public static function start():void
        {
            var _local_1:FSM_primaryexp;
            _local_1 = new (FSM_primaryexp)();
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
                    public::mstate.esp = (public::mstate.esp - 176);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 36);
                    this.i2 = li32(this.i0 + 12);
                    this.i3 = (this.i0 + 12);
                    this.i4 = (this.i0 + 36);
                    this.i5 = li32(public::mstate.ebp + 12);
                    if (this.i2 == 285) goto _label_4;
                    if (!(this.i2 == 40)) goto _label_6;
                    this.i2 = li32(this.i0 + 4);
                    si32(this.i2, (this.i0 + 8));
                    this.i6 = li32(this.i0 + 24);
                    this.i7 = (this.i0 + 24);
                    if (!(this.i6 == 287))
                    {
                        this.i8 = 287;
                        si32(this.i6, this.i3);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i8, this.i7);
                        goto _label_1;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 1:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i6, this.i3);
                    
                _label_1: 
                    this.i6 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_subexpr.start();
                    return;
                case 2:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = 40;
                    this.i7 = 41;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_check_match.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i3);
                    if (!(this.i2 > 90))
                    {
                        if (this.i2 == 40) goto _label_20;
                        if (this.i2 == 46) goto _label_10;
                        if (!(this.i2 == 58))
                        {
                            goto _label_21;
                        };
                        
                    _label_2: 
                        this.i2 = (public::mstate.ebp + -176);
                        this.i6 = (public::mstate.ebp + -16);
                        this.i7 = (this.i0 + 16);
                        this.i8 = (this.i0 + 28);
                        this.i9 = (this.i1 + 12);
                        this.i10 = (this.i1 + 36);
                        this.i11 = (this.i1 + 50);
                        this.i12 = (this.i5 + 4);
                        this.i13 = (this.i5 + 16);
                        this.i14 = (this.i5 + 12);
                        this.i15 = (this.i2 + 4);
                        this.i16 = (this.i2 + 16);
                        this.i17 = (this.i2 + 12);
                        this.i18 = (this.i6 + 8);
                        this.i19 = (this.i0 + 24);
                        this.i20 = (this.i0 + 8);
                        this.i21 = (this.i0 + 4);
                        this.i22 = this.i5;
                        this.i23 = this.i7;
                        
                    _label_3: 
                        this.i24 = li32(this.i21);
                        si32(this.i24, this.i20);
                        this.i24 = li32(this.i19);
                        if (this.i24 == 287) goto _label_16;
                        this.i25 = 287;
                        si32(this.i24, this.i3);
                        this.f0 = lf64(this.i8);
                        sf64(this.f0, this.i7);
                        si32(this.i25, this.i19);
                        goto _label_17;
                    };
                    if (this.i2 == 91) goto _label_11;
                    if (this.i2 == 123) goto _label_20;
                    if (this.i2 == 286) goto _label_20;
                    goto _label_21;
                    
                _label_4: 
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_str_checkname.start();
                    return;
                case 5:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i7 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_singlevaraux.start();
                    return;
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i2 == 8)) goto _label_5;
                    this.i2 = 4;
                    si32(this.i6, (public::mstate.ebp + -112));
                    si32(this.i2, (public::mstate.ebp + -104));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (public::mstate.ebp + -112);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addk.start();
                    return;
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (this.i5 + 4));
                    
                _label_5: 
                    this.i2 = li32(this.i3);
                    if (!(this.i2 > 90))
                    {
                        if (this.i2 == 40) goto _label_20;
                        if (this.i2 == 46) goto _label_10;
                        if (this.i2 == 58) goto _label_2;
                        goto _label_21;
                    };
                    if (this.i2 == 91) goto _label_11;
                    if (this.i2 == 123) goto _label_20;
                    if (this.i2 == 286) goto _label_20;
                    goto _label_21;
                    
                _label_6: 
                    this.i6 = 80;
                    this.i7 = li32(this.i0 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (public::mstate.ebp + -96);
                    this.i7 = (this.i7 + 16);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 8:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i0 + 4);
                    this.i7 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i9 = __2E_str15272;
                    this.i10 = __2E_str26120;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    si32(this.i10, (public::mstate.esp + 16));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 9:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i7 = (this.i0 + 40);
                    if (this.i2 == 0) goto _label_8;
                    if (!(this.i2 == 284))
                    {
                        if (!(this.i2 == 286)) goto _label_7;
                    };
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 48);
                    this.i2 = li32(this.i2);
                    this.i8 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = __2E_str35292;
                    si32(this.i8, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 11:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_9;
                    
                _label_7: 
                    this.i8 = __2E_str35292;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 13:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 14:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i7 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 3;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_9;
                    
                _label_8: 
                    this.i2 = 3;
                    this.i6 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_9: 
                    this.i2 = li32(this.i3);
                    if (!(this.i2 > 90))
                    {
                        if (this.i2 == 40) goto _label_20;
                        if (this.i2 == 46) goto _label_10;
                        if (this.i2 == 58) goto _label_2;
                        goto _label_21;
                    };
                    if (this.i2 == 91) goto _label_11;
                    if (this.i2 == 123) goto _label_20;
                    if (this.i2 == 286) goto _label_20;
                    goto _label_21;
                    
                _label_10: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_field.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i3);
                    if (!(this.i2 > 90))
                    {
                        if (this.i2 == 40) goto _label_20;
                        if (this.i2 == 46) goto _label_10;
                        if (this.i2 == 58) goto _label_2;
                        goto _label_21;
                    };
                    if (this.i2 == 286) goto _label_20;
                    if (this.i2 == 123) goto _label_20;
                    if (!(this.i2 == 91)) goto _label_21;
                    
                _label_11: 
                    this.i2 = (this.i0 + 16);
                    this.i6 = (this.i0 + 28);
                    this.i7 = (this.i5 + 8);
                    this.i8 = (this.i0 + 24);
                    this.i9 = (this.i0 + 8);
                    this.i10 = (this.i0 + 4);
                    this.i11 = (this.i1 + 50);
                    this.i12 = (this.i5 + 4);
                    this.i13 = (this.i5 + 16);
                    this.i14 = (this.i5 + 12);
                    this.i15 = this.i2;
                    this.i16 = this.i5;
                    
                _label_12: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i17 = li32(this.i16);
                    if (!(this.i17 == 12)) goto _label_13;
                    this.i17 = li32(this.i14);
                    this.i18 = li32(this.i13);
                    this.i19 = li32(this.i12);
                    if (this.i17 == this.i18) goto _label_14;
                    this.i17 = li8(this.i11);
                    if (this.i19 < this.i17) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i19, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exp2reg.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_14;
                    
                _label_13: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_14: 
                    this.i17 = li32(this.i10);
                    si32(this.i17, this.i9);
                    this.i17 = li32(this.i8);
                    if (!(this.i17 == 287))
                    {
                        this.i18 = 287;
                        si32(this.i17, this.i3);
                        this.f0 = lf64(this.i6);
                        sf64(this.f0, this.i2);
                        si32(this.i18, this.i8);
                        goto _label_15;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 21:
                    this.i17 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i17, this.i3);
                    
                _label_15: 
                    this.i17 = (public::mstate.ebp + -144);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i17, (public::mstate.esp + 4));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_expr.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i18 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i18, public::mstate.esp);
                    si32(this.i17, (public::mstate.esp + 4));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2val.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i18 = 93;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_checknext.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i17, (public::mstate.esp + 4));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2RK.start();
                    return;
                case 25:
                    this.i17 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i17, this.i7);
                    this.i17 = 9;
                    si32(this.i17, this.i16);
                    this.i17 = li32(this.i3);
                    if (!(this.i17 > 90))
                    {
                        if (this.i17 == 40) goto _label_20;
                        if (this.i17 == 46) goto _label_10;
                        if (this.i17 == 58) goto _label_2;
                        goto _label_21;
                    };
                    if (this.i17 == 91) goto _label_12;
                    if (this.i17 == 123) goto _label_20;
                    if (this.i17 == 286) goto _label_20;
                    goto _label_21;
                    
                _label_16: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i23, (public::mstate.esp + 4));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 26:
                    this.i24 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i24, this.i3);
                    
                _label_17: 
                    this.i24 = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_str_checkname.start();
                    return;
                case 27:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i26 = li32(this.i4);
                    si32(this.i25, this.i6);
                    si32(this.i24, this.i18);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i25 = (public::mstate.ebp + -16);
                    si32(this.i26, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    si32(this.i25, (public::mstate.esp + 8));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addk.start();
                    return;
                case 28:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i26 = -1;
                    si32(this.i26, this.i17);
                    si32(this.i26, this.i16);
                    si32(this.i24, this.i2);
                    si32(this.i25, this.i15);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i24 = li32(this.i22);
                    if (!(this.i24 == 12)) goto _label_18;
                    this.i24 = li32(this.i14);
                    this.i25 = li32(this.i13);
                    this.i26 = li32(this.i12);
                    if (this.i24 == this.i25) goto _label_19;
                    this.i24 = li8(this.i11);
                    if (this.i26 < this.i24) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i26, (public::mstate.esp + 8));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exp2reg.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_19;
                    
                _label_18: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_19: 
                    this.i24 = li32(this.i22);
                    if (!(!(this.i24 == 12)))
                    {
                        this.i24 = li32(this.i12);
                        this.i25 = (this.i24 & 0x0100);
                        if (!(!(this.i25 == 0)))
                        {
                            this.i25 = li8(this.i11);
                            if (!(this.i25 > this.i24))
                            {
                                this.i24 = li32(this.i10);
                                this.i24 = (this.i24 + -1);
                                si32(this.i24, this.i10);
                            };
                        };
                    };
                    this.i24 = 2;
                    this.i25 = li32(this.i10);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i24, (public::mstate.esp + 4));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_checkstack.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i24 = li32(this.i10);
                    this.i24 = (this.i24 + 2);
                    si32(this.i24, this.i10);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i24 = (public::mstate.ebp + -176);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i24, (public::mstate.esp + 4));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2RK.start();
                    return;
                case 33:
                    this.i24 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i26 = li32(this.i12);
                    this.i27 = li32(this.i9);
                    this.i26 = (this.i26 << 23);
                    this.i28 = (this.i25 << 6);
                    this.i27 = li32(this.i27 + 8);
                    this.i26 = (this.i28 | this.i26);
                    this.i24 = (this.i24 << 14);
                    this.i24 = (this.i26 | this.i24);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i24 = (this.i24 | 0x0B);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i24, (public::mstate.esp + 4));
                    si32(this.i27, (public::mstate.esp + 8));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 34:
                    this.i24 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i24 = li32(this.i2);
                    if (!(!(this.i24 == 12)))
                    {
                        this.i24 = li32(this.i15);
                        this.i26 = (this.i24 & 0x0100);
                        if (!(!(this.i26 == 0)))
                        {
                            this.i26 = li8(this.i11);
                            if (!(this.i26 > this.i24))
                            {
                                this.i24 = li32(this.i10);
                                this.i24 = (this.i24 + -1);
                                si32(this.i24, this.i10);
                            };
                        };
                    };
                    this.i24 = 12;
                    si32(this.i25, this.i12);
                    si32(this.i24, this.i22);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_funcargs.start();
                    return;
                case 35:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i24 = li32(this.i3);
                    if (!(this.i24 > 90))
                    {
                        if (this.i24 == 40) goto _label_20;
                        if (this.i24 == 46) goto _label_10;
                        if (this.i24 == 58) goto _label_3;
                        goto _label_21;
                    };
                    if (this.i24 == 91) goto _label_11;
                    if (!(this.i24 == 123))
                    {
                        if (!(this.i24 == 286)) goto _label_21;
                    };
                    
                _label_20: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 36:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_funcargs.start();
                    return;
                case 37:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i3);
                    if (!(this.i2 > 90))
                    {
                        if (this.i2 == 40) goto _label_20;
                        if (this.i2 == 46) goto _label_10;
                        if (this.i2 == 58) goto _label_2;
                    }
                    else
                    {
                        if (this.i2 == 91) goto _label_11;
                        if (this.i2 == 123) goto _label_20;
                        if (this.i2 == 286) goto _label_20;
                    };
                    
                _label_21: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _primaryexp");
            };
        }


    }
}

