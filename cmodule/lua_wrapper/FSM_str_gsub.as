package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_str_gsub extends Machine 
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
            var _local_1:FSM_str_gsub;
            _local_1 = new (FSM_str_gsub)();
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
                    public::mstate.esp = (public::mstate.esp - 1332);
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
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 2;
                    this.i3 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = _luaO_nilobject_;
                    if (!(!(this.i3 == this.i4)))
                    {
                        this.i3 = -1;
                    }
                    else
                    {
                        this.i3 = li32(this.i3 + 8);
                    };
                    this.i4 = 4;
                    this.i5 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = (this.i5 + 1);
                    this.i6 = _luaO_nilobject_;
                    if (!(!(this.i4 == this.i6)))
                    {
                        
                    _label_1: 
                        this.i4 = this.i5;
                        goto _label_2;
                    };
                    this.i4 = li32(this.i4 + 8);
                    if (this.i4 < 1) goto _label_1;
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 5:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i5 = li8(this.i2);
                    if (!(this.i5 == 94))
                    {
                        this.i5 = 1;
                    }
                    else
                    {
                        this.i5 = 0;
                        this.i2 = (this.i2 + 1);
                    };
                    this.i6 = (this.i3 + -3);
                    this.i3 = (this.i3 + -5);
                    if (uint(this.i3) < uint(2)) goto _label_3;
                    if (uint(this.i6) < uint(2)) goto _label_3;
                    this.i3 = __2E_str38468;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i3 = (public::mstate.ebp + -1328);
                    si32(this.i1, (public::mstate.ebp + -1320));
                    this.i6 = (this.i3 + 12);
                    si32(this.i6, (public::mstate.ebp + -1328));
                    this.i6 = 0;
                    si32(this.i6, (public::mstate.ebp + -1324));
                    si32(this.i1, (public::mstate.ebp + -280));
                    si32(this.i0, (public::mstate.ebp + -288));
                    this.i6 = li32(public::mstate.ebp + -4);
                    this.i7 = (public::mstate.ebp + -288);
                    this.i6 = (this.i0 + this.i6);
                    si32(this.i6, (public::mstate.ebp + -284));
                    this.i6 = (this.i7 + 4);
                    this.i7 = (this.i7 + 8);
                    this.i8 = (this.i3 + 4);
                    this.i9 = (this.i3 + 8);
                    if (!(this.i4 > 0))
                    {
                        this.i2 = 0;
                        goto _label_26;
                    };
                    this.i10 = (public::mstate.ebp + -1328);
                    this.i11 = (public::mstate.ebp + -288);
                    this.i10 = (this.i10 + 1036);
                    this.i12 = 0;
                    this.i11 = (this.i11 + 12);
                    
                _label_4: 
                    this.i13 = 0;
                    si32(this.i13, this.i11);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = (public::mstate.ebp + -288);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 7:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i13 == 0))) goto _label_22;
                    this.i14 = 3;
                    this.i15 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i12 = (this.i12 + 1);
                    this.i16 = _luaO_nilobject_;
                    if (!(!(this.i14 == this.i16)))
                    {
                        this.i14 = -1;
                    }
                    else
                    {
                        this.i14 = li32(this.i14 + 8);
                    };
                    if (this.i14 == 6) goto _label_13;
                    if (this.i14 == 5) goto _label_15;
                    this.i14 = (this.i14 + -3);
                    if (uint(this.i14) > uint(1)) goto _label_16;
                    this.i15 = (public::mstate.ebp + -1332);
                    this.i14 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i16 = 3;
                    si32(this.i14, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 9:
                    this.i15 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = li32(public::mstate.ebp + -1332);
                    if (!(!(this.i14 == 0)))
                    {
                        
                    _label_5: 
                        goto _label_22;
                    };
                    this.i14 = 0;
                    this.i16 = (this.i13 - this.i0);
                    
                _label_6: 
                    this.i17 = (this.i15 + this.i14);
                    this.i18 = li8(this.i17);
                    if (this.i18 == 37) goto _label_8;
                    this.i18 = li32(this.i3);
                    if (uint(this.i18) < uint(this.i10)) goto _label_7;
                    this.i18 = (public::mstate.ebp + -1328);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i18, public::mstate.esp);
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 10:
                    this.i18 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i18 == 0) goto _label_7;
                    this.i18 = (public::mstate.ebp + -1328);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i18, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i18 = li32(this.i3);
                    this.i17 = li8(this.i17);
                    si8(this.i17, this.i18);
                    this.i17 = (this.i18 + 1);
                    si32(this.i17, this.i3);
                    this.i17 = li32(public::mstate.ebp + -1332);
                    this.i14 = (this.i14 + 1);
                    if (uint(this.i14) >= uint(this.i17)) goto _label_5;
                    goto _label_6;
                    
                _label_8: 
                    this.i17 = __DefaultRuneLocale;
                    this.i18 = (this.i14 + this.i15);
                    this.i19 = li8(this.i18 + 1);
                    this.i20 = (this.i19 << 2);
                    this.i17 = (this.i17 + this.i20);
                    this.i17 = li32(this.i17 + 52);
                    this.i18 = (this.i18 + 1);
                    this.i17 = (this.i17 & 0x0400);
                    if (!(this.i17 == 0)) goto _label_10;
                    this.i19 = li32(this.i3);
                    if (uint(this.i19) < uint(this.i10)) goto _label_9;
                    this.i19 = (public::mstate.ebp + -1328);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i19, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 12:
                    this.i19 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i19 == 0) goto _label_9;
                    this.i19 = (public::mstate.ebp + -1328);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i19, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i19 = li32(this.i3);
                    this.i17 = li8(this.i18);
                    si8(this.i17, this.i19);
                    this.i19 = (this.i19 + 1);
                    si32(this.i19, this.i3);
                    this.i19 = li32(public::mstate.ebp + -1332);
                    this.i14 = (this.i14 + 2);
                    if (uint(this.i14) >= uint(this.i19)) goto _label_5;
                    goto _label_6;
                    
                _label_10: 
                    this.i14 = (this.i14 + 2);
                    this.i17 = (this.i19 & 0xFF);
                    if (!(this.i17 == 48)) goto _label_12;
                    this.i19 = (public::mstate.ebp + -1328);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i19, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i16, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i19 = li32(public::mstate.ebp + -1332);
                    if (uint(this.i14) >= uint(this.i19)) goto _label_5;
                    
                _label_11: 
                    goto _label_6;
                    
                _label_12: 
                    this.i17 = (public::mstate.ebp + -288);
                    this.i18 = (this.i19 << 24);
                    this.i18 = (this.i18 >> 24);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i18 = (this.i18 + -49);
                    si32(this.i17, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_onecapture.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i17 = (public::mstate.ebp + -1328);
                    si32(this.i17, public::mstate.esp);
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addvalue.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i17 = li32(public::mstate.ebp + -1332);
                    if (uint(this.i14) < uint(this.i17)) goto _label_11;
                    goto _label_5;
                    
                _label_13: 
                    this.i14 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 17:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i16 = li32(this.i15 + 8);
                    this.f0 = lf64(this.i14);
                    sf64(this.f0, this.i16);
                    this.i14 = li32(this.i14 + 8);
                    si32(this.i14, (this.i16 + 8));
                    this.i14 = li32(this.i15 + 8);
                    this.i14 = (this.i14 + 12);
                    si32(this.i14, (this.i15 + 8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i14 = (public::mstate.ebp + -288);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_captures.start();
                    return;
                case 18:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = (this.i14 ^ 0xFFFFFFFF);
                    this.i16 = li32(this.i15 + 8);
                    this.i14 = (this.i14 * 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i17 = 1;
                    this.i14 = (this.i16 + this.i14);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i17, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i14 = -1;
                    si32(this.i15, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 20:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i16 = li32(this.i14 + 8);
                    if (this.i16 == 0) goto _label_17;
                    if (!(!(this.i16 == 1)))
                    {
                        this.i14 = li32(this.i14);
                        if (this.i14 == 0) goto _label_17;
                    };
                    
                _label_14: 
                    this.i14 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 21:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i16 = _luaO_nilobject_;
                    if (!(this.i14 == this.i16))
                    {
                        this.i14 = li32(this.i14 + 8);
                        this.i14 = (this.i14 + -3);
                        if (uint(this.i14) < uint(2)) goto _label_21;
                    };
                    this.i14 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 22:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i16 = _luaO_nilobject_;
                    if (!(this.i14 == this.i16)) goto _label_19;
                    this.i14 = -1;
                    goto _label_20;
                    
                _label_15: 
                    this.i14 = 0;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i16 = (public::mstate.ebp + -288);
                    si32(this.i16, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_onecapture.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i14 = 3;
                    si32(this.i15, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 24:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i16 = li32(this.i15 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i16 = (this.i16 + -12);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i16, (public::mstate.esp + 8));
                    si32(this.i16, (public::mstate.esp + 12));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_16: 
                    this.i14 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 26:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i16 = li32(this.i14 + 8);
                    if (!(this.i16 == 0))
                    {
                        if (!(this.i16 == 1)) goto _label_14;
                        this.i14 = li32(this.i14);
                        if (!(this.i14 == 0)) goto _label_14;
                    };
                    
                _label_17: 
                    this.i14 = li32(this.i15 + 8);
                    this.i14 = (this.i14 + -12);
                    si32(this.i14, (this.i15 + 8));
                    this.i14 = li32(this.i15 + 16);
                    this.i16 = li32(this.i14 + 68);
                    this.i14 = li32(this.i14 + 64);
                    this.i17 = (this.i13 - this.i0);
                    this.i18 = (this.i15 + 8);
                    if (uint(this.i16) < uint(this.i14)) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i15, public::mstate.esp);
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_18: 
                    this.i14 = 4;
                    this.i16 = li32(this.i18);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i17, (public::mstate.esp + 8));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 28:
                    this.i15 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i15, this.i16);
                    si32(this.i14, (this.i16 + 8));
                    this.i15 = li32(this.i18);
                    this.i15 = (this.i15 + 12);
                    si32(this.i15, this.i18);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i15 = (public::mstate.ebp + -1328);
                    si32(this.i15, public::mstate.esp);
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addvalue.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i13 == 0) goto _label_23;
                    if (!(uint(this.i13) > uint(this.i0))) goto _label_23;
                    this.i0 = this.i13;
                    goto _label_25;
                    
                _label_19: 
                    this.i14 = li32(this.i14 + 8);
                    
                _label_20: 
                    if (!(!(this.i14 == -1)))
                    {
                        this.i14 = __2E_str2251;
                    }
                    else
                    {
                        this.i16 = _luaT_typenames;
                        this.i14 = (this.i14 << 2);
                        this.i14 = (this.i16 + this.i14);
                        this.i14 = li32(this.i14);
                    };
                    this.i16 = __2E_str39469;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_21: 
                    this.i14 = (public::mstate.ebp + -1328);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addvalue.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_22: 
                    if (!(this.i13 == 0))
                    {
                        if (uint(this.i13) > uint(this.i0)) goto _label_27;
                    };
                    
                _label_23: 
                    this.i13 = li32(this.i6);
                    if (!(uint(this.i13) > uint(this.i0)))
                    {
                        this.i2 = this.i12;
                        goto _label_26;
                    };
                    this.i13 = li32(this.i3);
                    if (uint(this.i13) < uint(this.i10)) goto _label_24;
                    this.i13 = (public::mstate.ebp + -1328);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i13, public::mstate.esp);
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 32:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i13 == 0) goto _label_24;
                    this.i13 = (public::mstate.ebp + -1328);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i13, public::mstate.esp);
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_24: 
                    this.i13 = li32(this.i3);
                    this.i14 = li8(this.i0);
                    si8(this.i14, this.i13);
                    this.i13 = (this.i13 + 1);
                    si32(this.i13, this.i3);
                    this.i0 = (this.i0 + 1);
                    
                _label_25: 
                    this.i13 = ((this.i12 < this.i4) ? 1 : 0);
                    this.i13 = (this.i13 & this.i5);
                    this.i13 = (this.i13 & 0x01);
                    if (!(this.i13 == 0)) goto _label_28;
                    this.i2 = this.i12;
                    
                _label_26: 
                    this.i3 = (public::mstate.ebp + -1328);
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 - this.i0);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 35:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i8);
                    this.i3 = li32(this.i9);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 36:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i1 + 8);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, this.i0);
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = 2;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_27: 
                    this.i0 = this.i13;
                    goto _label_25;
                    
                _label_28: 
                    goto _label_4;
                default:
                    throw ("Invalid state in _str_gsub");
            };
        }


    }
} cmodule.lua_wrapper

