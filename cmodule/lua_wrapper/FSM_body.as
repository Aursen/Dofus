package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_body extends Machine 
    {

        public static const intRegCount:int = 27;
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
        public var i20:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_body;
            _local_1 = new (FSM_body)();
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
                    public::mstate.esp = (public::mstate.esp - 656);
                    this.i0 = (public::mstate.ebp + -656);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_open_func.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(public::mstate.ebp + 20);
                    this.i3 = li32(public::mstate.ebp + -656);
                    si32(this.i2, (this.i3 + 60));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 40;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_checknext.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = this.i0;
                    this.i5 = li32(public::mstate.ebp + 16);
                    if (this.i5 == 0) goto _label_1;
                    this.i5 = __2E_str18112;
                    this.i6 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 4;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = li32(this.i1 + 36);
                    this.i7 = li32(this.i7 + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_setstr.start();
                    return;
                case 4:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = li32(this.i6 + 8);
                    this.i8 = (this.i6 + 8);
                    this.i9 = (this.i1 + 36);
                    if (!(!(this.i7 == 0)))
                    {
                        this.i7 = 1;
                        si32(this.i7, this.i6);
                        si32(this.i7, this.i8);
                    };
                    this.i6 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_new_localvar.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(this.i9);
                    this.i7 = li8(this.i5 + 50);
                    this.i7 = (this.i7 + 1);
                    si8(this.i7, (this.i5 + 50));
                    this.i7 = (this.i5 + 24);
                    this.i8 = (this.i5 + 50);
                    this.i9 = this.i5;
                    do 
                    {
                        this.i10 = li8(this.i8);
                        this.i10 = (this.i6 + this.i10);
                        this.i10 = (this.i10 << 1);
                        this.i10 = (this.i10 + this.i5);
                        this.i10 = li16(this.i10 + 170);
                        this.i11 = li32(this.i9);
                        this.i11 = li32(this.i11 + 24);
                        this.i12 = li32(this.i7);
                        this.i10 = (this.i10 * 12);
                        this.i10 = (this.i11 + this.i10);
                        si32(this.i12, (this.i10 + 4));
                        this.i10 = (this.i6 + 1);
                        if ((this.i6 == 0)) break;
                        this.i6 = this.i10;
                    } while (true);
                    
                _label_1: 
                    this.i5 = 0;
                    this.i6 = li32(this.i1 + 36);
                    this.i7 = li32(this.i6);
                    si8(this.i5, (this.i7 + 74));
                    this.i5 = li32(this.i1 + 12);
                    this.i8 = (this.i1 + 12);
                    this.i9 = (this.i7 + 74);
                    this.i10 = (this.i1 + 36);
                    if (!(!(this.i5 == 41)))
                    {
                        this.i8 = 0;
                        
                    _label_2: 
                        this.i5 = this.i8;
                        this.i8 = li32(this.i10);
                        this.i11 = li8(this.i8 + 50);
                        this.i11 = (this.i11 + this.i5);
                        si8(this.i11, (this.i8 + 50));
                        this.i11 = (this.i8 + 50);
                        if (this.i5 == 0) goto _label_12;
                        this.i12 = 0;
                        this.i13 = (0 - this.i5);
                        this.i14 = (this.i8 + 24);
                        this.i15 = this.i8;
                        do 
                        {
                            this.i16 = li8(this.i11);
                            this.i17 = (this.i13 + this.i12);
                            this.i16 = (this.i17 + this.i16);
                            this.i16 = (this.i16 << 1);
                            this.i16 = (this.i8 + this.i16);
                            this.i16 = li16(this.i16 + 172);
                            this.i17 = li32(this.i15);
                            this.i17 = li32(this.i17 + 24);
                            this.i18 = li32(this.i14);
                            this.i16 = (this.i16 * 12);
                            this.i16 = (this.i17 + this.i16);
                            si32(this.i18, (this.i16 + 4));
                            this.i12 = (this.i12 + 1);
                            if (this.i12 == this.i5) goto _label_12;
                        } while (true);
                    };
                    this.i5 = 0;
                    this.i11 = (this.i1 + 16);
                    this.i12 = (this.i1 + 28);
                    this.i13 = (this.i1 + 24);
                    this.i14 = (this.i1 + 8);
                    this.i15 = (this.i1 + 48);
                    this.i16 = (this.i1 + 40);
                    this.i17 = (this.i1 + 4);
                    this.i18 = (public::mstate.ebp + -80);
                    this.i19 = (this.i1 + 52);
                    this.i20 = this.i11;
                    
                _label_3: 
                    this.i21 = li32(this.i8);
                    if (this.i21 == 279) goto _label_5;
                    if (!(this.i21 == 285)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_str_checkname.start();
                    return;
                case 6:
                    this.i21 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_new_localvar.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i21 = li8(this.i9);
                    this.i5 = (this.i5 + 1);
                    if (!(this.i21 == 0))
                    {
                        this.i8 = this.i5;
                        goto _label_2;
                    };
                    
                _label_4: 
                    this.i21 = li32(this.i8);
                    if (this.i21 == 44) goto _label_11;
                    this.i8 = this.i5;
                    goto _label_2;
                    
                _label_5: 
                    this.i15 = li32(this.i17);
                    si32(this.i15, this.i14);
                    this.i14 = li32(this.i13);
                    if (!(this.i14 == 287))
                    {
                        this.i15 = 287;
                        si32(this.i14, this.i8);
                        this.f0 = lf64(this.i12);
                        sf64(this.f0, this.i11);
                        si32(this.i15, this.i13);
                        goto _label_6;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 8:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i11, this.i8);
                    
                _label_6: 
                    this.i8 = __2E_str19113;
                    this.i11 = li32(this.i16);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i12 = 3;
                    si32(this.i11, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 9:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = li32(this.i10);
                    this.i12 = li32(this.i12 + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_setstr.start();
                    return;
                case 10:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = li32(this.i11 + 8);
                    this.i13 = (this.i11 + 8);
                    this.i14 = (this.i5 + 1);
                    if (!(!(this.i12 == 0)))
                    {
                        this.i12 = 1;
                        si32(this.i12, this.i11);
                        si32(this.i12, this.i13);
                    };
                    this.i11 = 7;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_new_localvar.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 12);
                    si8(this.i11, this.i9);
                    this.i8 = this.i14;
                    goto _label_2;
                    
                _label_7: 
                    this.i22 = 80;
                    this.i23 = li32(this.i19);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i23 = (this.i23 + 16);
                    si32(this.i18, public::mstate.esp);
                    si32(this.i23, (public::mstate.esp + 4));
                    si32(this.i22, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 12:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i22 = li32(this.i17);
                    this.i23 = li32(this.i16);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i24 = __2E_str15272;
                    this.i25 = __2E_str20114;
                    this.i26 = (public::mstate.ebp + -80);
                    si32(this.i23, public::mstate.esp);
                    si32(this.i24, (public::mstate.esp + 4));
                    si32(this.i26, (public::mstate.esp + 8));
                    si32(this.i22, (public::mstate.esp + 12));
                    si32(this.i25, (public::mstate.esp + 16));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 13:
                    this.i22 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    if (this.i21 == 0) goto _label_9;
                    if (!(this.i21 == 284))
                    {
                        if (!(this.i21 == 286)) goto _label_8;
                    };
                    this.i21 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i21 = li32(this.i15);
                    this.i21 = li32(this.i21);
                    this.i23 = li32(this.i16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i24 = __2E_str35292;
                    si32(this.i23, public::mstate.esp);
                    si32(this.i24, (public::mstate.esp + 4));
                    si32(this.i22, (public::mstate.esp + 8));
                    si32(this.i21, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 15:
                    this.i21 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i21 = li32(this.i16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i22 = 3;
                    si32(this.i21, public::mstate.esp);
                    si32(this.i22, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_10;
                    
                _label_8: 
                    this.i23 = __2E_str35292;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 17:
                    this.i21 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i24 = li32(this.i16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i24, public::mstate.esp);
                    si32(this.i23, (public::mstate.esp + 4));
                    si32(this.i22, (public::mstate.esp + 8));
                    si32(this.i21, (public::mstate.esp + 12));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 18:
                    this.i21 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i21 = li32(this.i16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i22 = 3;
                    si32(this.i21, public::mstate.esp);
                    si32(this.i22, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_10;
                    
                _label_9: 
                    this.i21 = 3;
                    this.i22 = li32(this.i16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i22, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_10: 
                    this.i21 = li8(this.i9);
                    if (this.i21 == 0) goto _label_4;
                    this.i8 = this.i5;
                    goto _label_2;
                    
                _label_11: 
                    this.i21 = li32(this.i17);
                    si32(this.i21, this.i14);
                    this.i21 = li32(this.i13);
                    if (!(this.i21 == 287))
                    {
                        this.i22 = 287;
                        si32(this.i21, this.i8);
                        this.f0 = lf64(this.i12);
                        sf64(this.f0, this.i11);
                        si32(this.i22, this.i13);
                        goto _label_3;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 21:
                    this.i21 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i21, this.i8);
                    goto _label_3;
                    
                _label_12: 
                    this.i5 = 41;
                    this.i8 = li8(this.i9);
                    this.i9 = li8(this.i6 + 50);
                    this.i8 = (this.i8 & 0x01);
                    this.i8 = (this.i9 - this.i8);
                    si8(this.i8, (this.i7 + 73));
                    this.i7 = li8(this.i6 + 50);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_checkstack.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i6 + 36);
                    this.i7 = (this.i8 + this.i7);
                    si32(this.i7, (this.i6 + 36));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_checknext.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_chunk.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i5 = li32(this.i0);
                    this.i6 = li32(this.i1 + 4);
                    si32(this.i6, (this.i5 + 64));
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = 265;
                    this.i6 = 262;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_check_match.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_close_func.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = li32(this.i10);
                    this.i5 = li32(this.i2);
                    this.i6 = li32(this.i2 + 44);
                    this.i7 = li32(this.i5 + 52);
                    this.i8 = (this.i2 + 44);
                    this.i9 = (this.i5 + 52);
                    this.i6 = (this.i6 + 1);
                    if (!(this.i6 > this.i7)) goto _label_14;
                    this.i6 = __2E_str32256;
                    this.i10 = li32(this.i5 + 16);
                    this.i11 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 24);
                    this.i12 = 0x3FFFF;
                    this.i13 = 4;
                    si32(this.i11, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    si32(this.i12, (public::mstate.esp + 16));
                    si32(this.i6, (public::mstate.esp + 20));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_growaux_.start();
                    return;
                case 27:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 24);
                    si32(this.i6, (this.i5 + 16));
                    this.i10 = li32(this.i9);
                    if (!(this.i10 > this.i7))
                    {
                        this.i7 = this.i6;
                        goto _label_15;
                        
                    _label_13: 
                        this.i6 = this.i10;
                    };
                    this.i10 = 0;
                    this.i11 = (this.i7 << 2);
                    this.i6 = (this.i6 + this.i11);
                    si32(this.i10, this.i6);
                    this.i7 = (this.i7 + 1);
                    
                _label_14: 
                    this.i6 = li32(this.i9);
                    this.i10 = li32(this.i5 + 16);
                    if (this.i6 > this.i7) goto _label_13;
                    this.i7 = this.i10;
                    
                _label_15: 
                    this.i6 = this.i7;
                    this.i7 = li32(this.i8);
                    this.i9 = li32(this.i0);
                    this.i10 = (this.i7 << 2);
                    this.i6 = (this.i6 + this.i10);
                    si32(this.i9, this.i6);
                    this.i6 = (this.i7 + 1);
                    si32(this.i6, this.i8);
                    this.i6 = li32(this.i0);
                    this.i9 = li8(this.i6 + 5);
                    this.i9 = (this.i9 & 0x03);
                    if (this.i9 == 0) goto _label_18;
                    this.i9 = li8(this.i5 + 5);
                    this.i5 = (this.i5 + 5);
                    this.i10 = (this.i9 & 0x04);
                    if (this.i10 == 0) goto _label_18;
                    this.i7 = li32(this.i1 + 40);
                    this.i7 = li32(this.i7 + 16);
                    this.i1 = li8(this.i7 + 21);
                    if (!(this.i1 == 1)) goto _label_16;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 28:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_17;
                    
                _label_16: 
                    this.i7 = li8(this.i7 + 20);
                    this.i1 = (this.i9 & 0xFFFFFFF8);
                    this.i7 = (this.i7 & 0x03);
                    this.i7 = (this.i7 | this.i1);
                    si8(this.i7, this.i5);
                    
                _label_17: 
                    this.i7 = -1;
                    this.i1 = li32(this.i8);
                    this.i5 = li32(this.i2 + 12);
                    this.i5 = li32(this.i5 + 8);
                    this.i1 = (this.i1 << 14);
                    this.i1 = (this.i1 + -16384);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 | 0x24);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 29:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i7, (this.i3 + 12));
                    si32(this.i7, (this.i3 + 16));
                    this.i7 = 11;
                    si32(this.i7, this.i3);
                    si32(this.i1, (this.i3 + 4));
                    goto _label_19;
                    
                _label_18: 
                    this.i1 = -1;
                    this.i5 = li32(this.i2 + 12);
                    this.i5 = li32(this.i5 + 8);
                    this.i6 = (this.i7 << 14);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (this.i6 | 0x24);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 30:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, (this.i3 + 12));
                    si32(this.i1, (this.i3 + 16));
                    this.i1 = 11;
                    si32(this.i1, this.i3);
                    si32(this.i5, (this.i3 + 4));
                    
                _label_19: 
                    this.i1 = li32(this.i0);
                    this.i1 = li8(this.i1 + 72);
                    if (this.i1 < 1) goto _label_21;
                    this.i1 = 0;
                    this.i3 = (this.i2 + 12);
                    
                _label_20: 
                    this.i5 = li32(this.i3);
                    this.i6 = li8(this.i4 + 51);
                    this.i7 = li8(this.i4 + 52);
                    this.i5 = li32(this.i5 + 8);
                    this.i6 = ((this.i6 == 6) ? 0 : 4);
                    this.i7 = (this.i7 << 23);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (this.i6 | this.i7);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 31:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(this.i0);
                    this.i5 = li8(this.i5 + 72);
                    this.i4 = (this.i4 + 2);
                    this.i1 = (this.i1 + 1);
                    if (!(this.i5 <= this.i1)) goto _label_20;
                    
                _label_21: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _body");
            };
        }


    }
} cmodule.lua_wrapper

