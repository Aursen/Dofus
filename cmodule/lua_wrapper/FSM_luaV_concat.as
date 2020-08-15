package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaV_concat extends Machine 
    {

        public static const intRegCount:int = 25;
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
        public var i20:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_luaV_concat;
            _local_1 = new (FSM_luaV_concat)();
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
                    public::mstate.esp = (public::mstate.esp - 96);
                    this.i0 = (public::mstate.ebp + -96);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = (this.i1 + 44);
                    this.i5 = (this.i1 + 28);
                    this.i6 = (this.i1 + 8);
                    this.i7 = (this.i1 + 32);
                    this.i8 = (this.i1 + 16);
                    this.i9 = (this.i1 + 12);
                    this.i10 = (public::mstate.ebp + -64);
                    this.i11 = (public::mstate.ebp + -32);
                    this.i12 = this.i11;
                    this.i13 = this.i10;
                    this.i14 = this.i0;
                    
                _label_1: 
                    this.i15 = (this.i3 + -1);
                    this.i16 = li32(this.i9);
                    this.i17 = (this.i15 * 12);
                    this.i17 = (this.i16 + this.i17);
                    this.i18 = li32(this.i17 + 8);
                    this.i17 = (this.i17 + 8);
                    this.i19 = (this.i3 + 1);
                    this.i20 = this.i16;
                    this.i18 = (this.i18 + -3);
                    if (uint(this.i18) > uint(1)) goto _label_2;
                    this.i18 = (this.i3 * 12);
                    this.i18 = (this.i20 + this.i18);
                    this.i21 = li32(this.i18 + 8);
                    this.i18 = (this.i18 + 8);
                    if (this.i21 == 4) goto _label_22;
                    this.i22 = (this.i3 * 12);
                    this.i22 = (this.i20 + this.i22);
                    if (!(this.i21 == 3)) goto _label_2;
                    this.i21 = __2E_str1166;
                    this.i23 = (this.i3 * 12);
                    this.i23 = (this.i20 + this.i23);
                    this.f0 = lf64(this.i23);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    sf64(this.f0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i21 = li8(this.i14);
                    if (this.i21 == 0) goto _label_20;
                    this.i21 = this.i0;
                    do 
                    {
                        this.i23 = li8(this.i21 + 1);
                        this.i21 = (this.i21 + 1);
                        this.i24 = this.i21;
                        if (this.i23 == 0) goto _label_21;
                        this.i21 = this.i24;
                    } while (true);
                    
                _label_2: 
                    this.i16 = 15;
                    this.i18 = (this.i15 * 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i18 = (this.i20 + this.i18);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i16, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 2:
                    this.i16 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i21 = (this.i3 * 12);
                    this.i22 = li32(this.i16 + 8);
                    this.i21 = (this.i20 + this.i21);
                    if (!(this.i22 == 0)) goto _label_3;
                    this.i16 = 15;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i16, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 3:
                    this.i16 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i22 = li32(this.i16 + 8);
                    this.i23 = (this.i16 + 8);
                    if (this.i22 == 0) goto _label_6;
                    this.i21 = li32(this.i7);
                    this.i22 = li32(this.i6);
                    this.f0 = lf64(this.i16);
                    sf64(this.f0, this.i22);
                    this.i16 = li32(this.i23);
                    this.i15 = (this.i15 * 12);
                    si32(this.i16, (this.i22 + 8));
                    this.i15 = (this.i20 + this.i15);
                    this.i16 = li32(this.i6);
                    this.f0 = lf64(this.i15);
                    sf64(this.f0, (this.i16 + 12));
                    this.i15 = li32(this.i17);
                    this.i3 = (this.i3 * 12);
                    si32(this.i15, (this.i16 + 20));
                    this.i3 = (this.i20 + this.i3);
                    this.i15 = li32(this.i6);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, (this.i15 + 24));
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i15 + 32));
                    this.i3 = li32(this.i5);
                    this.i15 = li32(this.i6);
                    this.i16 = (this.i18 - this.i21);
                    this.i3 = (this.i3 - this.i15);
                    if (this.i3 > 36) goto _label_5;
                    this.i3 = li32(this.i4);
                    if (this.i3 < 3) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 << 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_5;
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 + 3);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_5: 
                    this.i3 = 1;
                    this.i15 = li32(this.i6);
                    this.i17 = (this.i15 + 36);
                    si32(this.i17, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i6);
                    this.i15 = li32(this.i7);
                    this.i17 = (this.i3 + -12);
                    si32(this.i17, this.i6);
                    this.f0 = lf64(this.i3 + -12);
                    this.i15 = (this.i15 + this.i16);
                    sf64(this.f0, this.i15);
                    this.i3 = li32(this.i3 + -4);
                    si32(this.i3, (this.i15 + 8));
                    this.i3 = 2;
                    goto _label_18;
                    
                _label_6: 
                    this.i3 = __2E_str2110;
                    this.i16 = li32(this.i17);
                    this.i16 = (this.i16 + -3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i16 = ((uint(this.i16) < uint(2)) ? this.i21 : this.i18);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_typeerror.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = (this.i2 + -1);
                    if (this.i2 < 2) goto _label_19;
                    this.i3 = this.i15;
                    goto _label_1;
                    
                _label_7: 
                    this.i16 = (this.i15 * 12);
                    this.i16 = (this.i20 + this.i16);
                    if (!(this.i3 == 3)) goto _label_25;
                    this.i3 = __2E_str1166;
                    this.i18 = (this.i15 * 12);
                    this.i18 = (this.i20 + this.i18);
                    this.f0 = lf64(this.i18);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    sf64(this.f0, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li8(this.i13);
                    if (this.i3 == 0) goto _label_23;
                    this.i3 = this.i10;
                    do 
                    {
                        this.i18 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i19 = this.i3;
                        if (this.i18 == 0) goto _label_24;
                        this.i3 = this.i19;
                    } while (true);
                    
                _label_8: 
                    if (this.i2 > 1) goto _label_10;
                    this.i15 = 1;
                    
                _label_9: 
                    this.i17 = this.i18;
                    this.i18 = li32(this.i8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i18 = (this.i18 + 52);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i17, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaZ_openspace.start();
                    return;
                case 9:
                    this.i17 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i15 > 0) goto _label_15;
                    this.i3 = 0;
                    goto _label_17;
                    
                _label_10: 
                    this.i15 = 1;
                    this.i17 = (this.i3 * 12);
                    this.i17 = (this.i16 + this.i17);
                    
                _label_11: 
                    this.i21 = li32(this.i17 + -4);
                    this.i22 = (this.i17 + -4);
                    if (!(this.i21 == 4))
                    {
                        goto _label_14;
                    };
                    
                _label_12: 
                    this.i21 = li32(this.i17 + -12);
                    this.i21 = li32(this.i21 + 12);
                    this.i22 = (-3 - this.i18);
                    if (uint(this.i22) > uint(this.i21)) goto _label_13;
                    this.i22 = __2E_str5170;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i22, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_13: 
                    this.i17 = (this.i17 + -12);
                    this.i15 = (this.i15 + 1);
                    this.i18 = (this.i21 + this.i18);
                    if (this.i15 < this.i2) goto _label_11;
                    goto _label_9;
                    
                _label_14: 
                    if (!(this.i21 == 3)) goto _label_9;
                    this.i21 = __2E_str1166;
                    this.f0 = lf64(this.i17 + -12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    sf64(this.f0, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i21 = li8(this.i12);
                    if (this.i21 == 0) goto _label_26;
                    this.i21 = this.i11;
                    do 
                    {
                        this.i23 = li8(this.i21 + 1);
                        this.i21 = (this.i21 + 1);
                        this.i24 = this.i21;
                        if (this.i23 == 0) goto _label_27;
                        this.i21 = this.i24;
                    } while (true);
                    
                _label_15: 
                    this.i18 = 0;
                    this.i3 = (this.i3 - this.i15);
                    this.i3 = (this.i3 * 12);
                    this.i3 = (this.i3 + this.i16);
                    this.i3 = (this.i3 + 12);
                    this.i16 = this.i15;
                    
                _label_16: 
                    this.i21 = li32(this.i3);
                    this.i22 = li32(this.i21 + 12);
                    this.i23 = (this.i17 + this.i18);
                    this.i21 = (this.i21 + 16);
                    memcpy(this.i23, this.i21, this.i22);
                    this.i3 = (this.i3 + 12);
                    this.i16 = (this.i16 + -1);
                    this.i18 = (this.i22 + this.i18);
                    if (this.i16 > 0) goto _label_28;
                    this.i3 = this.i18;
                    
                _label_17: 
                    this.i16 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i17, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    this.i3 = (this.i19 - this.i15);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
                    this.i17 = public::mstate.eax;
                    this.i3 = (this.i3 * 12);
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = (this.i20 + this.i3);
                    si32(this.i17, this.i3);
                    si32(this.i16, (this.i3 + 8));
                    this.i3 = this.i15;
                    
                _label_18: 
                    this.i2 = (this.i2 - this.i3);
                    this.i3 = (this.i19 - this.i3);
                    this.i2 = (this.i2 + 1);
                    if (!(this.i2 < 2))
                    {
                        goto _label_1;
                    };
                    
                _label_19: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_20: 
                    this.i21 = this.i14;
                    
                _label_21: 
                    this.i23 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i21 = (this.i21 - this.i0);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i21, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 13:
                    this.i21 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i21, this.i22);
                    si32(this.i23, this.i18);
                    
                _label_22: 
                    this.i18 = (this.i3 * 12);
                    this.i18 = (this.i20 + this.i18);
                    this.i18 = li32(this.i18);
                    this.i18 = li32(this.i18 + 12);
                    if (!(this.i18 == 0)) goto _label_8;
                    this.i3 = li32(this.i17);
                    if (!(this.i3 == 4)) goto _label_7;
                    this.i3 = 2;
                    goto _label_18;
                    
                _label_23: 
                    this.i3 = this.i13;
                    
                _label_24: 
                    this.i18 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i10);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i16);
                    si32(this.i18, this.i17);
                    
                _label_25: 
                    this.i2 = (this.i2 + -1);
                    if (this.i2 < 2) goto _label_19;
                    this.i3 = this.i15;
                    goto _label_1;
                    
                _label_26: 
                    this.i21 = this.i12;
                    
                _label_27: 
                    this.i23 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i21 = (this.i21 - this.i11);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i21, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 15:
                    this.i21 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i21, (this.i17 + -12));
                    si32(this.i23, this.i22);
                    goto _label_12;
                    
                _label_28: 
                    goto _label_16;
                default:
                    throw ("Invalid state in _luaV_concat");
            };
        }


    }
}

