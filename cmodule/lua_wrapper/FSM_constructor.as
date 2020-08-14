package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_constructor extends Machine 
    {

        public static const intRegCount:int = 32;
        public static const NumberRegCount:int = 1;

        public var i21:int;
        public var i30:int;
        public var i31:int;
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
        public var i29:int;


        public static function start():void
        {
            var _local_1:FSM_constructor;
            _local_1 = new (FSM_constructor)();
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
                    public::mstate.esp = (public::mstate.esp - 368);
                    this.i0 = 10;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 36);
                    this.i3 = li32(this.i2 + 12);
                    this.i4 = li32(this.i1 + 4);
                    this.i3 = li32(this.i3 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = 0;
                    si32(this.i3, (public::mstate.ebp + -336));
                    si32(this.i3, (public::mstate.ebp + -344));
                    si32(this.i3, (public::mstate.ebp + -340));
                    this.i5 = li32(public::mstate.ebp + 12);
                    si32(this.i5, (public::mstate.ebp + -348));
                    this.i6 = -1;
                    si32(this.i6, (this.i5 + 12));
                    si32(this.i6, (this.i5 + 16));
                    this.i7 = 11;
                    si32(this.i7, this.i5);
                    si32(this.i0, (this.i5 + 4));
                    si32(this.i6, (public::mstate.ebp + -356));
                    si32(this.i6, (public::mstate.ebp + -352));
                    si32(this.i3, (public::mstate.ebp + -368));
                    si32(this.i3, (public::mstate.ebp + -364));
                    this.i3 = li32(this.i1 + 36);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 123;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    this.i3 = (public::mstate.ebp + -368);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_checknext.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = (this.i1 + 28);
                    this.i6 = (this.i1 + 16);
                    this.i7 = (public::mstate.ebp + -240);
                    this.i8 = (public::mstate.ebp + -320);
                    this.i9 = (this.i1 + 8);
                    this.i10 = (public::mstate.ebp + -80);
                    this.i11 = (public::mstate.ebp + -160);
                    this.i12 = (this.i2 + 36);
                    this.i13 = (this.i1 + 24);
                    this.i14 = (this.i1 + 12);
                    this.i15 = (this.i3 + 4);
                    this.i16 = (this.i3 + 20);
                    this.i17 = (this.i3 + 28);
                    this.i18 = (this.i3 + 24);
                    this.i19 = (this.i3 + 32);
                    this.i20 = (this.i2 + 12);
                    this.i21 = (this.i1 + 4);
                    this.i22 = (this.i1 + 36);
                    this.i23 = this.i6;
                    this.i24 = this.i5;
                    this.i25 = this.i3;
                    
                _label_1: 
                    this.i26 = li32(this.i14);
                    if (this.i26 == 125) goto _label_13;
                    this.i26 = li32(this.i3);
                    if (this.i26 == 0) goto _label_4;
                    this.i26 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i26, this.i3);
                    this.i26 = li32(this.i19);
                    if (!(this.i26 == 50)) goto _label_4;
                    this.i27 = li32(this.i17);
                    this.i27 = (this.i27 + -1);
                    this.i28 = li32(this.i16);
                    this.i29 = li32(this.i20);
                    this.i28 = li32(this.i28 + 4);
                    this.i29 = li32(this.i29 + 8);
                    this.i30 = (this.i26 << 23);
                    this.i27 = (this.i27 / 50);
                    this.i26 = ((this.i26 == -1) ? 0 : this.i30);
                    this.i30 = (this.i28 << 6);
                    this.i28 = (this.i28 + 1);
                    this.i27 = (this.i27 + 1);
                    if (this.i27 > 511) goto _label_2;
                    this.i26 = (this.i30 | this.i26);
                    this.i27 = (this.i27 << 14);
                    this.i26 = (this.i26 | this.i27);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i26 = (this.i26 | 0x22);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i26, (public::mstate.esp + 4));
                    si32(this.i29, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 5:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_3;
                    
                _label_2: 
                    this.i26 = (this.i30 | this.i26);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i26 = (this.i26 | 0x22);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i26, (public::mstate.esp + 4));
                    si32(this.i29, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 6:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i26 = li32(this.i20);
                    this.i26 = li32(this.i26 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i27, (public::mstate.esp + 4));
                    si32(this.i26, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 7:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i26 = 0;
                    si32(this.i28, this.i12);
                    si32(this.i26, this.i19);
                    
                _label_4: 
                    this.i26 = li32(this.i14);
                    if (this.i26 == 91) goto _label_8;
                    if (!(this.i26 == 285)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 8:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i26, this.i13);
                    if (this.i26 == 61) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_expr.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i26 = li32(this.i17);
                    if (this.i26 < 2147483646) goto _label_6;
                    this.i26 = li32(this.i22);
                    this.i27 = li32(this.i26);
                    this.i27 = li32(this.i27 + 60);
                    this.i28 = li32(this.i26 + 16);
                    this.i26 = (this.i26 + 12);
                    if (!(this.i27 == 0)) goto _label_5;
                    this.i27 = __2E_str196;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i29 = __2E_str23117;
                    this.i30 = 2147483645;
                    si32(this.i28, public::mstate.esp);
                    si32(this.i27, (public::mstate.esp + 4));
                    si32(this.i30, (public::mstate.esp + 8));
                    si32(this.i29, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 10:
                    this.i27 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i26 = li32(this.i26);
                    this.i28 = li32(this.i26 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i29 = 80;
                    this.i28 = (this.i28 + 16);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i28, (public::mstate.esp + 4));
                    si32(this.i29, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 11:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i28 = li32(this.i26 + 4);
                    this.i29 = li32(this.i26 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i30 = __2E_str15272;
                    this.i31 = (public::mstate.ebp + -160);
                    si32(this.i29, public::mstate.esp);
                    si32(this.i30, (public::mstate.esp + 4));
                    si32(this.i31, (public::mstate.esp + 8));
                    si32(this.i28, (public::mstate.esp + 12));
                    si32(this.i27, (public::mstate.esp + 16));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 12:
                    this.i27 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i26 = li32(this.i26 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i27 = 3;
                    si32(this.i26, public::mstate.esp);
                    si32(this.i27, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_6;
                    
                _label_5: 
                    this.i29 = __2E_str297;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i30 = __2E_str23117;
                    this.i31 = 2147483645;
                    si32(this.i28, public::mstate.esp);
                    si32(this.i29, (public::mstate.esp + 4));
                    si32(this.i27, (public::mstate.esp + 8));
                    si32(this.i31, (public::mstate.esp + 12));
                    si32(this.i30, (public::mstate.esp + 16));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 14:
                    this.i27 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i26 = li32(this.i26);
                    this.i28 = li32(this.i26 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i29 = 80;
                    this.i28 = (this.i28 + 16);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i28, (public::mstate.esp + 4));
                    si32(this.i29, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 15:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i28 = li32(this.i26 + 4);
                    this.i29 = li32(this.i26 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i30 = __2E_str15272;
                    this.i31 = (public::mstate.ebp + -80);
                    si32(this.i29, public::mstate.esp);
                    si32(this.i30, (public::mstate.esp + 4));
                    si32(this.i31, (public::mstate.esp + 8));
                    si32(this.i28, (public::mstate.esp + 12));
                    si32(this.i27, (public::mstate.esp + 16));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 16:
                    this.i27 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i26 = li32(this.i26 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i27 = 3;
                    si32(this.i26, public::mstate.esp);
                    si32(this.i27, (public::mstate.esp + 4));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_6: 
                    this.i26 = li32(this.i17);
                    this.i26 = (this.i26 + 1);
                    si32(this.i26, this.i17);
                    this.i26 = li32(this.i19);
                    this.i26 = (this.i26 + 1);
                    si32(this.i26, this.i19);
                    this.i26 = li32(this.i14);
                    if (!(this.i26 == 44)) goto _label_12;
                    this.i26 = li32(this.i21);
                    si32(this.i26, this.i9);
                    this.i26 = li32(this.i13);
                    if (!(this.i26 == 287))
                    {
                        this.i27 = 287;
                        si32(this.i26, this.i14);
                        this.f0 = lf64(this.i24);
                        sf64(this.f0, this.i6);
                        si32(this.i27, this.i13);
                        goto _label_1;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i23, (public::mstate.esp + 4));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 18:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i26, this.i14);
                    goto _label_1;
                    
                _label_7: 
                    this.i26 = (public::mstate.ebp + -368);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i26, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_recfield.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i26 = li32(this.i14);
                    if (!(this.i26 == 44)) goto _label_12;
                    this.i26 = li32(this.i21);
                    si32(this.i26, this.i9);
                    this.i26 = li32(this.i13);
                    if (!(this.i26 == 287))
                    {
                        this.i27 = 287;
                        si32(this.i26, this.i14);
                        this.f0 = lf64(this.i24);
                        sf64(this.f0, this.i6);
                        si32(this.i27, this.i13);
                        goto _label_1;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i23, (public::mstate.esp + 4));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 20:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i26, this.i14);
                    goto _label_1;
                    
                _label_8: 
                    this.i26 = (public::mstate.ebp + -368);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i26, (public::mstate.esp + 4));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_recfield.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i26 = li32(this.i14);
                    if (!(this.i26 == 44)) goto _label_12;
                    this.i26 = li32(this.i21);
                    si32(this.i26, this.i9);
                    this.i26 = li32(this.i13);
                    if (!(this.i26 == 287))
                    {
                        this.i27 = 287;
                        si32(this.i26, this.i14);
                        this.f0 = lf64(this.i24);
                        sf64(this.f0, this.i6);
                        si32(this.i27, this.i13);
                        goto _label_1;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i23, (public::mstate.esp + 4));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 22:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i26, this.i14);
                    goto _label_1;
                    
                _label_9: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_expr.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i26 = li32(this.i17);
                    if (this.i26 < 2147483646) goto _label_11;
                    this.i26 = li32(this.i22);
                    this.i27 = li32(this.i26);
                    this.i27 = li32(this.i27 + 60);
                    this.i28 = li32(this.i26 + 16);
                    this.i26 = (this.i26 + 12);
                    if (!(this.i27 == 0)) goto _label_10;
                    this.i27 = __2E_str196;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i29 = __2E_str23117;
                    this.i30 = 2147483645;
                    si32(this.i28, public::mstate.esp);
                    si32(this.i27, (public::mstate.esp + 4));
                    si32(this.i30, (public::mstate.esp + 8));
                    si32(this.i29, (public::mstate.esp + 12));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 24:
                    this.i27 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i26 = li32(this.i26);
                    this.i28 = li32(this.i26 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i29 = 80;
                    this.i28 = (this.i28 + 16);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i28, (public::mstate.esp + 4));
                    si32(this.i29, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 25:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i28 = li32(this.i26 + 4);
                    this.i29 = li32(this.i26 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i30 = __2E_str15272;
                    this.i31 = (public::mstate.ebp + -320);
                    si32(this.i29, public::mstate.esp);
                    si32(this.i30, (public::mstate.esp + 4));
                    si32(this.i31, (public::mstate.esp + 8));
                    si32(this.i28, (public::mstate.esp + 12));
                    si32(this.i27, (public::mstate.esp + 16));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 26:
                    this.i27 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i26 = li32(this.i26 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i27 = 3;
                    si32(this.i26, public::mstate.esp);
                    si32(this.i27, (public::mstate.esp + 4));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_11;
                    
                _label_10: 
                    this.i29 = __2E_str297;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i30 = __2E_str23117;
                    this.i31 = 2147483645;
                    si32(this.i28, public::mstate.esp);
                    si32(this.i29, (public::mstate.esp + 4));
                    si32(this.i27, (public::mstate.esp + 8));
                    si32(this.i31, (public::mstate.esp + 12));
                    si32(this.i30, (public::mstate.esp + 16));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 28:
                    this.i27 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i26 = li32(this.i26);
                    this.i28 = li32(this.i26 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i29 = 80;
                    this.i28 = (this.i28 + 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i28, (public::mstate.esp + 4));
                    si32(this.i29, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 29:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i28 = li32(this.i26 + 4);
                    this.i29 = li32(this.i26 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i30 = __2E_str15272;
                    this.i31 = (public::mstate.ebp + -240);
                    si32(this.i29, public::mstate.esp);
                    si32(this.i30, (public::mstate.esp + 4));
                    si32(this.i31, (public::mstate.esp + 8));
                    si32(this.i28, (public::mstate.esp + 12));
                    si32(this.i27, (public::mstate.esp + 16));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 30:
                    this.i27 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i26 = li32(this.i26 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i27 = 3;
                    si32(this.i26, public::mstate.esp);
                    si32(this.i27, (public::mstate.esp + 4));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_11: 
                    this.i26 = li32(this.i17);
                    this.i26 = (this.i26 + 1);
                    si32(this.i26, this.i17);
                    this.i26 = li32(this.i19);
                    this.i26 = (this.i26 + 1);
                    si32(this.i26, this.i19);
                    this.i26 = li32(this.i14);
                    if (!(this.i26 == 44)) goto _label_12;
                    this.i26 = li32(this.i21);
                    si32(this.i26, this.i9);
                    this.i26 = li32(this.i13);
                    if (!(this.i26 == 287))
                    {
                        this.i27 = 287;
                        si32(this.i26, this.i14);
                        this.f0 = lf64(this.i24);
                        sf64(this.f0, this.i6);
                        si32(this.i27, this.i13);
                        goto _label_1;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i23, (public::mstate.esp + 4));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 32:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i26, this.i14);
                    goto _label_1;
                    
                _label_12: 
                    this.i26 = li32(this.i14);
                    if (!(this.i26 == 59)) goto _label_13;
                    this.i26 = li32(this.i21);
                    si32(this.i26, this.i9);
                    this.i26 = li32(this.i13);
                    if (!(this.i26 == 287))
                    {
                        this.i27 = 287;
                        si32(this.i26, this.i14);
                        this.f0 = lf64(this.i24);
                        sf64(this.f0, this.i6);
                        si32(this.i27, this.i13);
                        goto _label_1;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i23, (public::mstate.esp + 4));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 33:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i26, this.i14);
                    goto _label_1;
                    
                _label_13: 
                    this.i5 = 123;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = 125;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_check_match.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i19);
                    if (this.i1 == 0) goto _label_21;
                    this.i1 = li32(this.i3);
                    this.i3 = (this.i1 + -13);
                    if (uint(this.i3) > uint(1)) goto _label_17;
                    if (!(this.i1 == 14))
                    {
                        if (!(this.i1 == 13)) goto _label_14;
                        this.i1 = li32(this.i15);
                        this.i15 = li32(this.i2);
                        this.i15 = li32(this.i15 + 12);
                        this.i1 = (this.i1 << 2);
                        this.i1 = (this.i15 + this.i1);
                        this.i15 = li32(this.i1);
                        this.i15 = (this.i15 & 0xFF803FFF);
                        si32(this.i15, this.i1);
                        goto _label_14;
                    };
                    this.i1 = 1;
                    this.i19 = li32(this.i15);
                    this.i25 = li32(this.i2);
                    this.i25 = li32(this.i25 + 12);
                    this.i19 = (this.i19 << 2);
                    this.i19 = (this.i25 + this.i19);
                    this.i25 = li32(this.i19);
                    this.i25 = (this.i25 & 0x7FFFFF);
                    si32(this.i25, this.i19);
                    this.i19 = li32(this.i2);
                    this.i25 = li32(this.i15);
                    this.i19 = li32(this.i19 + 12);
                    this.i25 = (this.i25 << 2);
                    this.i3 = li32(this.i12);
                    this.i19 = (this.i19 + this.i25);
                    this.i25 = li32(this.i19);
                    this.i3 = (this.i3 << 6);
                    this.i3 = (this.i3 & 0x3FC0);
                    this.i25 = (this.i25 & 0xFFFFC03F);
                    this.i25 = (this.i3 | this.i25);
                    si32(this.i25, this.i19);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_checkstack.start();
                    return;
                case 35:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i12);
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, this.i12);
                    
                _label_14: 
                    this.i1 = li32(this.i17);
                    this.i1 = (this.i1 + -1);
                    this.i16 = li32(this.i16);
                    this.i19 = li32(this.i20);
                    this.i16 = li32(this.i16 + 4);
                    this.i19 = li32(this.i19 + 8);
                    this.i1 = (this.i1 / 50);
                    this.i25 = (this.i16 << 6);
                    this.i16 = (this.i16 + 1);
                    this.i1 = (this.i1 + 1);
                    if (this.i1 > 511) goto _label_15;
                    this.i1 = (this.i1 << 14);
                    this.i1 = (this.i25 | this.i1);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 | 0x22);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i19, (public::mstate.esp + 8));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 36:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_16;
                    
                _label_15: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i25 = (this.i25 | 0x22);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    si32(this.i19, (public::mstate.esp + 8));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 37:
                    this.i19 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i19 = li32(this.i20);
                    this.i19 = li32(this.i19 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i19, (public::mstate.esp + 8));
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 38:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_16: 
                    si32(this.i16, this.i12);
                    this.i1 = li32(this.i17);
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, this.i17);
                    goto _label_21;
                    
                _label_17: 
                    if (this.i1 == 0) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 39:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_18: 
                    this.i1 = li32(this.i17);
                    this.i3 = li32(this.i19);
                    this.i1 = (this.i1 + -1);
                    this.i4 = li32(this.i16);
                    this.i5 = li32(this.i20);
                    this.i4 = li32(this.i4 + 4);
                    this.i5 = li32(this.i5 + 8);
                    this.i6 = (this.i3 << 23);
                    this.i1 = (this.i1 / 50);
                    this.i3 = ((this.i3 == -1) ? 0 : this.i6);
                    this.i6 = (this.i4 << 6);
                    this.i4 = (this.i4 + 1);
                    this.i1 = (this.i1 + 1);
                    if (this.i1 > 511) goto _label_19;
                    this.i3 = (this.i6 | this.i3);
                    this.i1 = (this.i1 << 14);
                    this.i1 = (this.i3 | this.i1);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 | 0x22);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 40:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_20;
                    
                _label_19: 
                    this.i3 = (this.i6 | this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 | 0x22);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 41:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i20);
                    this.i3 = li32(this.i3 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 42:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_20: 
                    si32(this.i4, this.i12);
                    
                _label_21: 
                    this.i1 = li32(this.i2);
                    this.i1 = li32(this.i1 + 12);
                    this.i0 = (this.i0 << 2);
                    this.i1 = (this.i1 + this.i0);
                    this.i3 = li32(this.i1);
                    this.i4 = li32(this.i17);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_int2fb.start();
                case 43:
                    this.i4 = public::mstate.eax;
                    this.i4 = (this.i4 << 23);
                    this.i3 = (this.i3 & 0x7FFFFF);
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = (this.i4 | this.i3);
                    si32(this.i3, this.i1);
                    this.i1 = li32(this.i2);
                    this.i1 = li32(this.i1 + 12);
                    this.i0 = (this.i1 + this.i0);
                    this.i1 = li32(this.i0);
                    this.i2 = li32(this.i18);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_int2fb.start();
                case 44:
                    this.i2 = public::mstate.eax;
                    this.i2 = (this.i2 << 14);
                    this.i2 = (this.i2 & 0x7FC000);
                    this.i1 = (this.i1 & 0xFF803FFF);
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = (this.i2 | this.i1);
                    si32(this.i1, this.i0);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _constructor");
            };
        }


    }
} cmodule.lua_wrapper

