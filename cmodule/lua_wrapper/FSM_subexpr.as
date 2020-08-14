package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_subexpr extends Machine 
    {

        public static const intRegCount:int = 13;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var f0:Number;
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
            var _local_1:FSM_subexpr;
            _local_1 = new (FSM_subexpr)();
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
                    public::mstate.esp = (public::mstate.esp - 0x0100);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 40);
                    this.i2 = li16(this.i1 + 52);
                    this.i2 = (this.i2 + 1);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(public::mstate.ebp + 16);
                    si16(this.i2, (this.i1 + 52));
                    this.i1 = (this.i0 + 40);
                    this.i2 = (this.i2 & 0xFFFF);
                    if (uint(this.i2) < uint(201)) goto _label_1;
                    this.i2 = 80;
                    this.i5 = li32(this.i0 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (public::mstate.ebp + -224);
                    this.i5 = (this.i5 + 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i0 + 4);
                    this.i5 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i7 = __2E_str15272;
                    this.i8 = __2E_str8103;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    si32(this.i8, (public::mstate.esp + 16));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i2 = li32(this.i0 + 12);
                    this.i5 = (this.i0 + 12);
                    if (!(this.i2 == 35))
                    {
                        if (!(this.i2 == 45))
                        {
                            if (!(this.i2 == 270)) goto _label_2;
                            this.i6 = 1;
                            goto _label_3;
                        };
                        this.i2 = 0;
                        goto _label_4;
                    };
                    this.i2 = 2;
                    goto _label_4;
                    
                _label_2: 
                    this.i6 = 3;
                    
                _label_3: 
                    if (this.i6 == 3) goto _label_29;
                    this.i2 = this.i6;
                    
                _label_4: 
                    this.i6 = li32(this.i0 + 4);
                    si32(this.i6, (this.i0 + 8));
                    this.i6 = li32(this.i0 + 24);
                    this.i7 = (this.i0 + 24);
                    if (!(this.i6 == 287))
                    {
                        this.i8 = 287;
                        si32(this.i6, this.i5);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i8, this.i7);
                        goto _label_5;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 4:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i6, this.i5);
                    
                _label_5: 
                    this.i6 = 8;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_subexpr.start();
                    return;
                case 5:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i0 + 36);
                    this.i7 = -1;
                    si32(this.i7, (public::mstate.ebp + -128));
                    si32(this.i7, (public::mstate.ebp + -132));
                    this.i7 = 5;
                    si32(this.i7, (public::mstate.ebp + -144));
                    this.i7 = 0;
                    si32(this.i7, (public::mstate.ebp + -140));
                    si32(this.i7, (public::mstate.ebp + -136));
                    if (this.i2 == 2) goto _label_18;
                    if (this.i2 == 1) goto _label_9;
                    if (!(this.i2 == 0)) goto _label_21;
                    this.i2 = li32(this.i3);
                    this.i7 = this.i3;
                    if (!(!(this.i2 == 5)))
                    {
                        this.i2 = li32(this.i3 + 12);
                        if (!(!(this.i2 == -1)))
                        {
                            this.i2 = li32(this.i3 + 16);
                            if (this.i2 == -1) goto _label_8;
                        };
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i7);
                    if (!(this.i2 == 12)) goto _label_6;
                    this.i2 = li32(this.i3 + 12);
                    this.i7 = li32(this.i3 + 16);
                    this.i8 = li32(this.i3 + 4);
                    if (this.i2 == this.i7) goto _label_7;
                    this.i2 = li8(this.i6 + 50);
                    if (this.i8 < this.i2) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exp2reg.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_7;
                    
                _label_6: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_7: 
                    this.i2 = (public::mstate.ebp + -144);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = 18;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codearith.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 16);
                    goto _label_21;
                    
                _label_8: 
                    this.i2 = (public::mstate.ebp + -144);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = 18;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codearith.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 16);
                    goto _label_21;
                    
                _label_9: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i3);
                    this.i7 = this.i3;
                    if (!(this.i2 > 3))
                    {
                        if (!(this.i2 == 1))
                        {
                            if (this.i2 == 2) goto _label_10;
                            if (!(this.i2 == 3)) goto _label_14;
                        };
                        this.i2 = 2;
                        si32(this.i2, this.i7);
                        goto _label_14;
                    };
                    if (!(this.i2 > 10))
                    {
                        this.i8 = (this.i2 + -4);
                        if (uint(this.i8) < uint(2)) goto _label_10;
                        if (!(this.i2 == 10)) goto _label_14;
                        this.i2 = li32(this.i3 + 4);
                        this.i7 = li32(this.i6);
                        this.i7 = li32(this.i7 + 12);
                        this.i8 = (this.i2 << 2);
                        this.i8 = (this.i7 + this.i8);
                        if (this.i2 > 0) goto _label_11;
                        this.i2 = this.i8;
                        goto _label_12;
                    };
                    if (!(this.i2 == 11))
                    {
                        if (this.i2 == 12) goto _label_13;
                        goto _label_14;
                        
                    _label_10: 
                        this.i2 = 3;
                        si32(this.i2, this.i7);
                        goto _label_14;
                        
                    _label_11: 
                        this.i9 = _luaP_opmodes;
                        this.i2 = (this.i2 << 2);
                        this.i2 = (this.i2 + this.i7);
                        this.i7 = li32(this.i2 + -4);
                        this.i7 = (this.i7 & 0x3F);
                        this.i7 = (this.i9 + this.i7);
                        this.i7 = li8(this.i7);
                        this.i7 = (this.i7 << 24);
                        this.i7 = (this.i7 >> 24);
                        this.i2 = (this.i2 + -4);
                        this.i2 = ((this.i7 > -1) ? this.i8 : this.i2);
                        
                    _label_12: 
                        this.i7 = li32(this.i2);
                        this.i8 = (this.i7 & 0x3FC0);
                        this.i8 = ((this.i8 == 0) ? 64 : 0);
                        this.i7 = (this.i7 & 0xFFFFC03F);
                        this.i7 = (this.i8 | this.i7);
                        si32(this.i7, this.i2);
                        goto _label_14;
                    };
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_checkstack.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6 + 36);
                    this.i8 = (this.i2 + 1);
                    si32(this.i8, (this.i6 + 36));
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_discharge2reg.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_13: 
                    this.i2 = li32(this.i7);
                    if (!(!(this.i2 == 12)))
                    {
                        this.i2 = li32(this.i3 + 4);
                        this.i8 = (this.i2 & 0x0100);
                        if (!(!(this.i8 == 0)))
                        {
                            this.i8 = li8(this.i6 + 50);
                            if (!(this.i8 > this.i2))
                            {
                                this.i2 = li32(this.i6 + 36);
                                this.i2 = (this.i2 + -1);
                                si32(this.i2, (this.i6 + 36));
                            };
                        };
                    };
                    this.i2 = 11;
                    this.i8 = li32(this.i6 + 12);
                    this.i9 = li32(this.i3 + 4);
                    this.i8 = li32(this.i8 + 8);
                    this.i9 = (this.i9 << 23);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = (this.i9 | 0x13);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 14:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, (this.i3 + 4));
                    si32(this.i2, this.i7);
                    
                _label_14: 
                    this.i2 = li32(this.i3 + 16);
                    this.i7 = li32(this.i3 + 12);
                    si32(this.i7, (this.i3 + 16));
                    si32(this.i2, (this.i3 + 12));
                    this.i2 = (this.i3 + 12);
                    if (this.i7 == -1) goto _label_16;
                    this.i8 = this.i6;
                    
                _label_15: 
                    this.i9 = 0xFF;
                    this.i10 = li32(this.i8);
                    this.i10 = li32(this.i10 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_patchtestreg395396.start();
                case 15:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i9 = li32(this.i8);
                    this.i9 = li32(this.i9 + 12);
                    this.i10 = (this.i7 << 2);
                    this.i9 = (this.i9 + this.i10);
                    this.i9 = li32(this.i9);
                    this.i9 = (this.i9 >>> 14);
                    this.i9 = (this.i9 + -131071);
                    if (!(!(this.i9 == -1)))
                    {
                        this.i7 = -1;
                    }
                    else
                    {
                        this.i7 = (this.i7 + this.i9);
                        this.i7 = (this.i7 + 1);
                    };
                    if (!(this.i7 == -1)) goto _label_15;
                    
                _label_16: 
                    this.i2 = li32(this.i2);
                    if (this.i2 == -1) goto _label_21;
                    
                _label_17: 
                    this.i7 = 0xFF;
                    this.i8 = li32(this.i6);
                    this.i8 = li32(this.i8 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_patchtestreg395396.start();
                case 16:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = li32(this.i6);
                    this.i7 = li32(this.i7 + 12);
                    this.i8 = (this.i2 << 2);
                    this.i7 = (this.i7 + this.i8);
                    this.i7 = li32(this.i7);
                    this.i7 = (this.i7 >>> 14);
                    this.i7 = (this.i7 + -131071);
                    if (!(!(this.i7 == -1)))
                    {
                        this.i2 = -1;
                    }
                    else
                    {
                        this.i2 = (this.i2 + this.i7);
                        this.i2 = (this.i2 + 1);
                    };
                    if (this.i2 == -1) goto _label_21;
                    goto _label_17;
                    
                _label_18: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i3);
                    if (!(this.i2 == 12)) goto _label_19;
                    this.i2 = li32(this.i3 + 12);
                    this.i7 = li32(this.i3 + 16);
                    this.i8 = li32(this.i3 + 4);
                    if (this.i2 == this.i7) goto _label_20;
                    this.i2 = li8(this.i6 + 50);
                    if (this.i8 < this.i2) goto _label_19;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exp2reg.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_20;
                    
                _label_19: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_20: 
                    this.i2 = (public::mstate.ebp + -144);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = 20;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codearith.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_21: 
                    this.i2 = li32(this.i5);
                    if (!(this.i2 > 93))
                    {
                        if (!(this.i2 > 44))
                        {
                            if (this.i2 == 37) goto _label_50;
                            if (this.i2 == 42) goto _label_49;
                            if (!(this.i2 == 43))
                            {
                                goto _label_28;
                            };
                            
                        _label_22: 
                            this.i2 = 0;
                            goto _label_83;
                        };
                        if (!(this.i2 > 59))
                        {
                            if (this.i2 == 45) goto _label_84;
                            if (!(this.i2 == 47))
                            {
                                goto _label_28;
                            };
                            
                        _label_23: 
                            this.i2 = 3;
                            goto _label_85;
                        };
                        if (this.i2 == 60) goto _label_53;
                        if (!(this.i2 == 62))
                        {
                            goto _label_28;
                        };
                        
                    _label_24: 
                        this.i2 = 11;
                        goto _label_85;
                    };
                    if (!(this.i2 > 279))
                    {
                        if (!(this.i2 > 270))
                        {
                            if (this.i2 == 94) goto _label_51;
                            if (!(this.i2 == 0x0101))
                            {
                                goto _label_28;
                            };
                            
                        _label_25: 
                            this.i2 = 13;
                            goto _label_85;
                        };
                        if (this.i2 == 271) goto _label_55;
                        if (!(this.i2 == 278))
                        {
                            goto _label_28;
                        };
                        
                    _label_26: 
                        this.i2 = 6;
                        goto _label_85;
                    };
                    if (!(this.i2 > 281))
                    {
                        if (this.i2 == 280) goto _label_52;
                        if (!(this.i2 == 281))
                        {
                            goto _label_28;
                        };
                        
                    _label_27: 
                        this.i2 = 12;
                        goto _label_85;
                    };
                    if (this.i2 == 282) goto _label_54;
                    if (this.i2 == 283) goto _label_32;
                    
                _label_28: 
                    this.i2 = 15;
                    goto _label_86;
                    
                _label_29: 
                    if (!(this.i2 > 274))
                    {
                        if (!(this.i2 > 264))
                        {
                            if (this.i2 == 123) goto _label_45;
                            if (!(this.i2 == 263)) goto _label_48;
                            this.i2 = -1;
                            si32(this.i2, (this.i3 + 12));
                            si32(this.i2, (this.i3 + 16));
                            this.i2 = 3;
                            si32(this.i2, this.i3);
                            this.i2 = 0;
                            si32(this.i2, (this.i3 + 4));
                            this.i2 = li32(this.i0 + 4);
                            si32(this.i2, (this.i0 + 8));
                            this.i2 = li32(this.i0 + 24);
                            this.i6 = (this.i0 + 24);
                            if (this.i2 == 287) goto _label_39;
                            this.i7 = 287;
                            si32(this.i2, this.i5);
                            this.f0 = lf64(this.i0 + 28);
                            sf64(this.f0, (this.i0 + 16));
                            si32(this.i7, this.i6);
                            goto _label_40;
                        };
                        if (this.i2 == 265) goto _label_46;
                        if (!(this.i2 == 269)) goto _label_48;
                        this.i2 = -1;
                        si32(this.i2, (this.i3 + 12));
                        si32(this.i2, (this.i3 + 16));
                        this.i2 = 1;
                        si32(this.i2, this.i3);
                        this.i2 = 0;
                        si32(this.i2, (this.i3 + 4));
                        this.i2 = li32(this.i0 + 4);
                        si32(this.i2, (this.i0 + 8));
                        this.i2 = li32(this.i0 + 24);
                        this.i6 = (this.i0 + 24);
                        if (this.i2 == 287) goto _label_35;
                        this.i7 = 287;
                        si32(this.i2, this.i5);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i7, this.i6);
                        goto _label_36;
                    };
                    if (this.i2 > 283) goto _label_30;
                    if (this.i2 == 275) goto _label_37;
                    if (!(this.i2 == 279)) goto _label_48;
                    this.i6 = li32(this.i0 + 36);
                    this.i7 = li32(this.i6);
                    this.i7 = li8(this.i7 + 74);
                    this.i8 = this.i6;
                    if (!(this.i7 == 0)) goto _label_43;
                    this.i7 = 80;
                    this.i9 = li32(this.i0 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = (public::mstate.ebp + -96);
                    this.i9 = (this.i9 + 16);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 21:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = li32(this.i0 + 4);
                    this.i9 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i11 = __2E_str15272;
                    this.i12 = __2E_str22116;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    si32(this.i12, (public::mstate.esp + 16));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 22:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    if (this.i2 == 0) goto _label_42;
                    this.i9 = (this.i2 + -284);
                    if (uint(this.i9) > uint(2)) goto _label_41;
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 48);
                    this.i2 = li32(this.i2);
                    this.i9 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = __2E_str35292;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 24:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_43;
                    
                _label_30: 
                    if (this.i2 == 286) goto _label_33;
                    if (!(this.i2 == 284)) goto _label_48;
                    this.i2 = -1;
                    si32(this.i2, (this.i3 + 12));
                    si32(this.i2, (this.i3 + 16));
                    this.i2 = 5;
                    si32(this.i2, this.i3);
                    this.i2 = 0;
                    si32(this.i2, (this.i3 + 4));
                    this.f0 = lf64(this.i0 + 16);
                    sf64(this.f0, (this.i3 + 4));
                    this.i2 = li32(this.i0 + 4);
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i0 + 24);
                    this.i6 = (this.i0 + 16);
                    this.i7 = (this.i0 + 24);
                    if (!(this.i2 == 287))
                    {
                        this.i8 = 287;
                        si32(this.i2, this.i5);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, this.i6);
                        si32(this.i8, this.i7);
                        goto _label_31;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 26:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i2, this.i5);
                    
                _label_31: 
                    this.i2 = li32(this.i5);
                    if (!(this.i2 > 93))
                    {
                        if (!(this.i2 > 44))
                        {
                            if (this.i2 == 37) goto _label_50;
                            if (this.i2 == 42) goto _label_49;
                            if (this.i2 == 43) goto _label_22;
                            goto _label_28;
                        };
                        if (!(this.i2 > 59))
                        {
                            if (this.i2 == 45) goto _label_84;
                            if (this.i2 == 47) goto _label_23;
                            goto _label_28;
                        };
                        if (this.i2 == 60) goto _label_53;
                        if (this.i2 == 62) goto _label_24;
                        goto _label_28;
                    };
                    if (!(this.i2 > 279))
                    {
                        if (!(this.i2 > 270))
                        {
                            if (this.i2 == 94) goto _label_51;
                            if (this.i2 == 0x0101) goto _label_25;
                            goto _label_28;
                        };
                        if (this.i2 == 271) goto _label_55;
                        if (this.i2 == 278) goto _label_26;
                        goto _label_28;
                    };
                    if (!(this.i2 > 281))
                    {
                        if (this.i2 == 280) goto _label_52;
                        if (this.i2 == 281) goto _label_27;
                        goto _label_28;
                    };
                    if (this.i2 == 282) goto _label_54;
                    if (!(this.i2 == 283))
                    {
                        goto _label_28;
                    };
                    
                _label_32: 
                    this.i2 = 7;
                    goto _label_85;
                    
                _label_33: 
                    this.i2 = 4;
                    this.i6 = li32(this.i0 + 16);
                    this.i7 = li32(this.i0 + 36);
                    si32(this.i6, (public::mstate.ebp + -112));
                    si32(this.i2, (public::mstate.ebp + -104));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (public::mstate.ebp + -112);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addk.start();
                    return;
                case 27:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = -1;
                    si32(this.i7, (this.i3 + 12));
                    si32(this.i7, (this.i3 + 16));
                    si32(this.i2, this.i3);
                    si32(this.i6, (this.i3 + 4));
                    this.i2 = li32(this.i0 + 4);
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i0 + 24);
                    this.i6 = (this.i0 + 16);
                    this.i7 = (this.i0 + 24);
                    if (!(this.i2 == 287))
                    {
                        this.i6 = 287;
                        si32(this.i2, this.i5);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i6, this.i7);
                        goto _label_34;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 28:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i2, this.i5);
                    
                _label_34: 
                    this.i2 = li32(this.i5);
                    if (!(this.i2 > 93))
                    {
                        if (!(this.i2 > 44))
                        {
                            if (this.i2 == 37) goto _label_50;
                            if (this.i2 == 42) goto _label_49;
                            if (this.i2 == 43) goto _label_22;
                            goto _label_28;
                        };
                        if (!(this.i2 > 59))
                        {
                            if (this.i2 == 45) goto _label_84;
                            if (this.i2 == 47) goto _label_23;
                            goto _label_28;
                        };
                        if (this.i2 == 60) goto _label_53;
                        if (this.i2 == 62) goto _label_24;
                        goto _label_28;
                    };
                    if (!(this.i2 > 279))
                    {
                        if (!(this.i2 > 270))
                        {
                            if (this.i2 == 94) goto _label_51;
                            if (this.i2 == 0x0101) goto _label_25;
                            goto _label_28;
                        };
                        if (this.i2 == 271) goto _label_55;
                        if (this.i2 == 278) goto _label_26;
                        goto _label_28;
                    };
                    if (!(this.i2 > 281))
                    {
                        if (this.i2 == 280) goto _label_52;
                        if (this.i2 == 281) goto _label_27;
                        goto _label_28;
                    };
                    if (this.i2 == 282) goto _label_54;
                    if (this.i2 == 283) goto _label_32;
                    goto _label_28;
                    
                _label_35: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 29:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i2, this.i5);
                    
                _label_36: 
                    this.i2 = li32(this.i5);
                    if (!(this.i2 > 93))
                    {
                        if (!(this.i2 > 44))
                        {
                            if (this.i2 == 37) goto _label_50;
                            if (this.i2 == 42) goto _label_49;
                            if (this.i2 == 43) goto _label_22;
                            goto _label_28;
                        };
                        if (!(this.i2 > 59))
                        {
                            if (this.i2 == 45) goto _label_84;
                            if (this.i2 == 47) goto _label_23;
                            goto _label_28;
                        };
                        if (this.i2 == 60) goto _label_53;
                        if (this.i2 == 62) goto _label_24;
                        goto _label_28;
                    };
                    if (!(this.i2 > 279))
                    {
                        if (!(this.i2 > 270))
                        {
                            if (this.i2 == 94) goto _label_51;
                            if (this.i2 == 0x0101) goto _label_25;
                            goto _label_28;
                        };
                        if (this.i2 == 271) goto _label_55;
                        if (this.i2 == 278) goto _label_26;
                        goto _label_28;
                    };
                    if (!(this.i2 > 281))
                    {
                        if (this.i2 == 280) goto _label_52;
                        if (this.i2 == 281) goto _label_27;
                        goto _label_28;
                    };
                    if (this.i2 == 282) goto _label_54;
                    if (this.i2 == 283) goto _label_32;
                    goto _label_28;
                    
                _label_37: 
                    this.i2 = -1;
                    si32(this.i2, (this.i3 + 12));
                    si32(this.i2, (this.i3 + 16));
                    this.i2 = 2;
                    si32(this.i2, this.i3);
                    this.i2 = 0;
                    si32(this.i2, (this.i3 + 4));
                    this.i2 = li32(this.i0 + 4);
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i0 + 24);
                    this.i6 = (this.i0 + 24);
                    if (!(this.i2 == 287))
                    {
                        this.i7 = 287;
                        si32(this.i2, this.i5);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i7, this.i6);
                        goto _label_38;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 30:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i2, this.i5);
                    
                _label_38: 
                    this.i2 = li32(this.i5);
                    if (!(this.i2 > 93))
                    {
                        if (!(this.i2 > 44))
                        {
                            if (this.i2 == 37) goto _label_50;
                            if (this.i2 == 42) goto _label_49;
                            if (this.i2 == 43) goto _label_22;
                            goto _label_28;
                        };
                        if (!(this.i2 > 59))
                        {
                            if (this.i2 == 45) goto _label_84;
                            if (this.i2 == 47) goto _label_23;
                            goto _label_28;
                        };
                        if (this.i2 == 60) goto _label_53;
                        if (this.i2 == 62) goto _label_24;
                        goto _label_28;
                    };
                    if (!(this.i2 > 279))
                    {
                        if (!(this.i2 > 270))
                        {
                            if (this.i2 == 94) goto _label_51;
                            if (this.i2 == 0x0101) goto _label_25;
                            goto _label_28;
                        };
                        if (this.i2 == 271) goto _label_55;
                        if (this.i2 == 278) goto _label_26;
                        goto _label_28;
                    };
                    if (!(this.i2 > 281))
                    {
                        if (this.i2 == 280) goto _label_52;
                        if (this.i2 == 281) goto _label_27;
                        goto _label_28;
                    };
                    if (this.i2 == 282) goto _label_54;
                    if (this.i2 == 283) goto _label_32;
                    goto _label_28;
                    
                _label_39: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 31:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i2, this.i5);
                    
                _label_40: 
                    this.i2 = li32(this.i5);
                    if (!(this.i2 > 93))
                    {
                        if (!(this.i2 > 44))
                        {
                            if (this.i2 == 37) goto _label_50;
                            if (this.i2 == 42) goto _label_49;
                            if (this.i2 == 43) goto _label_22;
                            goto _label_28;
                        };
                        if (!(this.i2 > 59))
                        {
                            if (this.i2 == 45) goto _label_84;
                            if (this.i2 == 47) goto _label_23;
                            goto _label_28;
                        };
                        if (this.i2 == 60) goto _label_53;
                        if (this.i2 == 62) goto _label_24;
                        goto _label_28;
                    };
                    if (!(this.i2 > 279))
                    {
                        if (!(this.i2 > 270))
                        {
                            if (this.i2 == 94) goto _label_51;
                            if (this.i2 == 0x0101) goto _label_25;
                            goto _label_28;
                        };
                        if (this.i2 == 271) goto _label_55;
                        if (this.i2 == 278) goto _label_26;
                        goto _label_28;
                    };
                    if (!(this.i2 > 281))
                    {
                        if (this.i2 == 280) goto _label_52;
                        if (this.i2 == 281) goto _label_27;
                        goto _label_28;
                    };
                    if (this.i2 == 282) goto _label_54;
                    if (this.i2 == 283) goto _label_32;
                    goto _label_28;
                    
                _label_41: 
                    this.i9 = __2E_str35292;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 32:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i10 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 33:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_43;
                    
                _label_42: 
                    this.i2 = 3;
                    this.i7 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 35:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_43: 
                    this.i2 = 0x800025;
                    this.i6 = li32(this.i6);
                    this.i7 = li8(this.i6 + 74);
                    this.i7 = (this.i7 & 0xFFFFFFFB);
                    si8(this.i7, (this.i6 + 74));
                    this.i6 = li32(this.i8 + 12);
                    this.i6 = li32(this.i6 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 36:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = -1;
                    si32(this.i6, (this.i3 + 12));
                    si32(this.i6, (this.i3 + 16));
                    this.i6 = 14;
                    si32(this.i6, this.i3);
                    si32(this.i2, (this.i3 + 4));
                    this.i2 = li32(this.i0 + 4);
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i0 + 24);
                    this.i6 = (this.i0 + 24);
                    if (!(this.i2 == 287))
                    {
                        this.i7 = 287;
                        si32(this.i2, this.i5);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i7, this.i6);
                        goto _label_44;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 37:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i2, this.i5);
                    
                _label_44: 
                    this.i2 = li32(this.i5);
                    if (!(this.i2 > 93))
                    {
                        if (!(this.i2 > 44))
                        {
                            if (this.i2 == 37) goto _label_50;
                            if (this.i2 == 42) goto _label_49;
                            if (this.i2 == 43) goto _label_22;
                            goto _label_28;
                        };
                        if (!(this.i2 > 59))
                        {
                            if (this.i2 == 45) goto _label_84;
                            if (this.i2 == 47) goto _label_23;
                            goto _label_28;
                        };
                        if (this.i2 == 60) goto _label_53;
                        if (this.i2 == 62) goto _label_24;
                        goto _label_28;
                    };
                    if (!(this.i2 > 279))
                    {
                        if (!(this.i2 > 270))
                        {
                            if (this.i2 == 94) goto _label_51;
                            if (this.i2 == 0x0101) goto _label_25;
                            goto _label_28;
                        };
                        if (this.i2 == 271) goto _label_55;
                        if (this.i2 == 278) goto _label_26;
                        goto _label_28;
                    };
                    if (!(this.i2 > 281))
                    {
                        if (this.i2 == 280) goto _label_52;
                        if (this.i2 == 281) goto _label_27;
                        goto _label_28;
                    };
                    if (this.i2 == 282) goto _label_54;
                    if (this.i2 == 283) goto _label_32;
                    goto _label_28;
                    
                _label_45: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_constructor.start();
                    return;
                case 38:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    if (!(this.i2 > 93))
                    {
                        if (!(this.i2 > 44))
                        {
                            if (this.i2 == 37) goto _label_50;
                            if (this.i2 == 42) goto _label_49;
                            if (this.i2 == 43) goto _label_22;
                            goto _label_28;
                        };
                        if (!(this.i2 > 59))
                        {
                            if (this.i2 == 45) goto _label_84;
                            if (this.i2 == 47) goto _label_23;
                            goto _label_28;
                        };
                        if (this.i2 == 60) goto _label_53;
                        if (this.i2 == 62) goto _label_24;
                        goto _label_28;
                    };
                    if (!(this.i2 > 279))
                    {
                        if (!(this.i2 > 270))
                        {
                            if (this.i2 == 94) goto _label_51;
                            if (this.i2 == 0x0101) goto _label_25;
                            goto _label_28;
                        };
                        if (this.i2 == 271) goto _label_55;
                        if (this.i2 == 278) goto _label_26;
                        goto _label_28;
                    };
                    if (!(this.i2 > 281))
                    {
                        if (this.i2 == 280) goto _label_52;
                        if (this.i2 == 281) goto _label_27;
                        goto _label_28;
                    };
                    if (this.i2 == 282) goto _label_54;
                    if (this.i2 == 283) goto _label_32;
                    goto _label_28;
                    
                _label_46: 
                    this.i2 = li32(this.i0 + 4);
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i0 + 24);
                    this.i6 = (this.i0 + 24);
                    this.i7 = (this.i0 + 4);
                    if (!(this.i2 == 287))
                    {
                        this.i8 = 287;
                        si32(this.i2, this.i5);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i8, this.i6);
                        goto _label_47;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 39:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i2, this.i5);
                    
                _label_47: 
                    this.i2 = 0;
                    this.i6 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_body.start();
                    return;
                case 40:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i5);
                    if (!(this.i2 > 93))
                    {
                        if (!(this.i2 > 44))
                        {
                            if (this.i2 == 37) goto _label_50;
                            if (this.i2 == 42) goto _label_49;
                            if (this.i2 == 43) goto _label_22;
                            goto _label_28;
                        };
                        if (!(this.i2 > 59))
                        {
                            if (this.i2 == 45) goto _label_84;
                            if (this.i2 == 47) goto _label_23;
                            goto _label_28;
                        };
                        if (this.i2 == 60) goto _label_53;
                        if (this.i2 == 62) goto _label_24;
                        goto _label_28;
                    };
                    if (!(this.i2 > 279))
                    {
                        if (!(this.i2 > 270))
                        {
                            if (this.i2 == 94) goto _label_51;
                            if (this.i2 == 0x0101) goto _label_25;
                            goto _label_28;
                        };
                        if (this.i2 == 271) goto _label_55;
                        if (this.i2 == 278) goto _label_26;
                        goto _label_28;
                    };
                    if (!(this.i2 > 281))
                    {
                        if (this.i2 == 280) goto _label_52;
                        if (this.i2 == 281) goto _label_27;
                        goto _label_28;
                    };
                    if (this.i2 == 282) goto _label_54;
                    if (this.i2 == 283) goto _label_32;
                    goto _label_28;
                    
                _label_48: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_primaryexp.start();
                    return;
                case 41:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    if (!(this.i2 > 93))
                    {
                        if (!(this.i2 > 44))
                        {
                            if (this.i2 == 37) goto _label_50;
                            if (this.i2 == 42) goto _label_49;
                            if (this.i2 == 43) goto _label_22;
                            goto _label_28;
                        };
                        if (!(this.i2 > 59))
                        {
                            if (this.i2 == 45) goto _label_84;
                            if (this.i2 == 47) goto _label_23;
                            goto _label_28;
                        };
                        if (this.i2 == 60) goto _label_53;
                        if (this.i2 == 62) goto _label_24;
                        goto _label_28;
                    };
                    if (!(this.i2 > 279))
                    {
                        if (!(this.i2 > 270))
                        {
                            if (this.i2 == 94) goto _label_51;
                            if (this.i2 == 0x0101) goto _label_25;
                            goto _label_28;
                        };
                        if (this.i2 == 271) goto _label_55;
                        if (this.i2 == 278) goto _label_26;
                        goto _label_28;
                    };
                    if (!(this.i2 > 281))
                    {
                        if (this.i2 == 280) goto _label_52;
                        if (this.i2 == 281) goto _label_27;
                        goto _label_28;
                    };
                    if (!(this.i2 == 282))
                    {
                        if (this.i2 == 283) goto _label_32;
                        goto _label_28;
                        
                    _label_49: 
                        this.i2 = 2;
                        goto _label_85;
                        
                    _label_50: 
                        this.i2 = 4;
                        goto _label_85;
                        
                    _label_51: 
                        this.i2 = 5;
                        goto _label_85;
                        
                    _label_52: 
                        this.i2 = 8;
                        goto _label_85;
                        
                    _label_53: 
                        this.i2 = 9;
                        goto _label_85;
                    };
                    
                _label_54: 
                    this.i2 = 10;
                    goto _label_85;
                    
                _label_55: 
                    this.i2 = 14;
                    goto _label_85;
                    
                _label_56: 
                    this.i6 = li32(this.i0 + 4);
                    si32(this.i6, (this.i0 + 8));
                    this.i6 = li32(this.i0 + 24);
                    this.i7 = (this.i0 + 24);
                    if (!(this.i6 == 287))
                    {
                        this.i8 = 287;
                        si32(this.i6, this.i5);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i8, this.i7);
                        goto _label_57;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 42:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i6, this.i5);
                    
                _label_57: 
                    this.i6 = li32(this.i0 + 36);
                    this.i7 = (this.i0 + 36);
                    if (this.i2 > 12) goto _label_58;
                    if (uint(this.i2) < uint(6)) goto _label_64;
                    if (!(this.i2 == 6)) goto _label_65;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 43:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_66;
                    
                _label_58: 
                    if (this.i2 == 14) goto _label_59;
                    if (!(this.i2 == 13)) goto _label_65;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_goiftrue.start();
                    return;
                case 44:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_66;
                    
                _label_59: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 45:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i3);
                    if (this.i8 > 2) goto _label_60;
                    if (this.i8 == 1) goto _label_61;
                    if (!(this.i8 == 2)) goto _label_62;
                    this.i8 = -1;
                    this.i9 = li32(this.i6 + 32);
                    si32(this.i8, (this.i6 + 32));
                    this.i8 = li32(this.i6 + 12);
                    this.i8 = li32(this.i8 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 2147450902;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 46;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 46:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, (public::mstate.ebp + -4));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (public::mstate.ebp + -4);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 47:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = li32(public::mstate.ebp + -4);
                    goto _label_63;
                    
                _label_60: 
                    if (!(this.i8 == 10))
                    {
                        if (!(this.i8 == 3)) goto _label_62;
                        
                    _label_61: 
                        this.i8 = -1;
                        goto _label_63;
                    };
                    this.i8 = li32(this.i3 + 4);
                    goto _label_63;
                    
                _label_62: 
                    this.i8 = 1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 48;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_jumponcond.start();
                    return;
                case 48:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_63: 
                    this.i9 = -1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = (this.i3 + 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 49;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 49:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = li32(this.i3 + 16);
                    this.i10 = li32(this.i6 + 24);
                    si32(this.i10, (this.i6 + 28));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = (this.i6 + 32);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 50;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 50:
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i9, (this.i3 + 16));
                    goto _label_66;
                    
                _label_64: 
                    this.i8 = li32(this.i3);
                    if (!(!(this.i8 == 5)))
                    {
                        this.i8 = li32(this.i3 + 12);
                        if (!(!(this.i8 == -1)))
                        {
                            this.i8 = li32(this.i3 + 16);
                            if (this.i8 == -1) goto _label_66;
                        };
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 51;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2RK.start();
                    return;
                case 51:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_66;
                    
                _label_65: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 52;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2RK.start();
                    return;
                case 52:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_66: 
                    this.i6 = _priority;
                    this.i8 = (this.i2 << 1);
                    this.i6 = (this.i6 + this.i8);
                    this.i6 = li8(this.i6 + 1);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (public::mstate.ebp + -256);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 53;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_subexpr.start();
                    return;
                case 53:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = li32(this.i7);
                    if (this.i2 > 6) goto _label_69;
                    if (this.i2 > 2) goto _label_67;
                    if (this.i2 == 0) goto _label_76;
                    if (this.i2 == 1) goto _label_77;
                    if (!(this.i2 == 2)) goto _label_73;
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = 14;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 54;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codearith.start();
                    return;
                case 54:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_67: 
                    if (this.i2 > 4) goto _label_68;
                    if (this.i2 == 3) goto _label_78;
                    if (!(this.i2 == 4)) goto _label_73;
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = 16;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 55;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codearith.start();
                    return;
                case 55:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_68: 
                    if (this.i2 == 5) goto _label_79;
                    if (!(this.i2 == 6)) goto _label_73;
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 56;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2val.start();
                    return;
                case 56:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(public::mstate.ebp + -256);
                    if (!(this.i2 == 11)) goto _label_75;
                    this.i2 = (public::mstate.ebp + -256);
                    this.i8 = li32(this.i7);
                    this.i9 = li32(public::mstate.ebp + -252);
                    this.i10 = li32(this.i8 + 12);
                    this.i9 = (this.i9 << 2);
                    this.i9 = (this.i10 + this.i9);
                    this.i9 = li32(this.i9);
                    this.i2 = (this.i2 + 4);
                    this.i8 = (this.i8 + 12);
                    this.i9 = (this.i9 & 0x3F);
                    if (!(this.i9 == 21)) goto _label_75;
                    this.i9 = li32(this.i3);
                    this.i10 = this.i3;
                    if (!(!(this.i9 == 12)))
                    {
                        this.i9 = li32(this.i3 + 4);
                        this.i11 = (this.i9 & 0x0100);
                        if (!(!(this.i11 == 0)))
                        {
                            this.i11 = li8(this.i7 + 50);
                            if (!(this.i11 > this.i9))
                            {
                                this.i9 = li32(this.i7 + 36);
                                this.i9 = (this.i9 + -1);
                                si32(this.i9, (this.i7 + 36));
                            };
                        };
                    };
                    this.i7 = 11;
                    this.i9 = li32(this.i2);
                    this.i8 = li32(this.i8);
                    this.i9 = (this.i9 << 2);
                    this.i8 = (this.i8 + this.i9);
                    this.i9 = li32(this.i8);
                    this.i11 = li32(this.i3 + 4);
                    this.i11 = (this.i11 << 23);
                    this.i9 = (this.i9 & 0x7FFFFF);
                    this.i9 = (this.i11 | this.i9);
                    si32(this.i9, this.i8);
                    si32(this.i7, this.i10);
                    this.i2 = li32(this.i2);
                    si32(this.i2, (this.i3 + 4));
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_69: 
                    if (this.i2 > 10) goto _label_71;
                    if (this.i2 > 8) goto _label_70;
                    if (this.i2 == 7) goto _label_80;
                    if (!(this.i2 == 8)) goto _label_73;
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = 1;
                    this.i9 = 23;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 57;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codecomp.start();
                    return;
                case 57:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_70: 
                    if (this.i2 == 9) goto _label_81;
                    if (!(this.i2 == 10)) goto _label_73;
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = 1;
                    this.i9 = 25;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 58;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codecomp.start();
                    return;
                case 58:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_71: 
                    if (this.i2 > 12) goto _label_72;
                    if (this.i2 == 11) goto _label_82;
                    if (!(this.i2 == 12)) goto _label_73;
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = 0;
                    this.i9 = 25;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 59;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codecomp.start();
                    return;
                case 59:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_72: 
                    if (!(this.i2 == 13))
                    {
                        if (this.i2 == 14) goto _label_74;
                        
                    _label_73: 
                        this.i2 = this.i6;
                        goto _label_83;
                    };
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 60;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 60:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i3 + 16);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 61;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 61:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(public::mstate.ebp + -256);
                    si32(this.i2, this.i3);
                    this.i2 = li32(public::mstate.ebp + -252);
                    si32(this.i2, (this.i3 + 4));
                    this.i2 = li32(public::mstate.ebp + -248);
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(public::mstate.ebp + -244);
                    si32(this.i2, (this.i3 + 12));
                    this.i2 = li32(public::mstate.ebp + -240);
                    si32(this.i2, (this.i3 + 16));
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_74: 
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 62;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 62:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i3 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 63;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 63:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(public::mstate.ebp + -256);
                    si32(this.i2, this.i3);
                    this.i2 = li32(public::mstate.ebp + -252);
                    si32(this.i2, (this.i3 + 4));
                    this.i2 = li32(public::mstate.ebp + -248);
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(public::mstate.ebp + -244);
                    si32(this.i2, (this.i3 + 12));
                    this.i2 = li32(public::mstate.ebp + -240);
                    si32(this.i2, (this.i3 + 16));
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_75: 
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 64;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 64:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = 21;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 65;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codearith.start();
                    return;
                case 65:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_76: 
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = 12;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 66;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codearith.start();
                    return;
                case 66:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_77: 
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = 13;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 67;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codearith.start();
                    return;
                case 67:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_78: 
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = 15;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 68;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codearith.start();
                    return;
                case 68:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_79: 
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = 17;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 69;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codearith.start();
                    return;
                case 69:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_80: 
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = 0;
                    this.i9 = 23;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 70;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codecomp.start();
                    return;
                case 70:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_81: 
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = 1;
                    this.i9 = 24;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 71;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codecomp.start();
                    return;
                case 71:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = this.i6;
                    goto _label_83;
                    
                _label_82: 
                    this.i2 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = 0;
                    this.i9 = 24;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 72;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_codecomp.start();
                    return;
                case 72:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = this.i6;
                    
                _label_83: 
                    if ((this.i2 == 15))
                    {
                        goto _label_86;
                        
                    _label_84: 
                        this.i2 = 1;
                    };
                    
                _label_85: 
                    this.i6 = _priority;
                    this.i7 = (this.i2 << 1);
                    this.i6 = (this.i6 + this.i7);
                    this.i6 = li8(this.i6);
                    if (uint(this.i6) > uint(this.i4)) goto _label_56;
                    
                _label_86: 
                    this.i0 = this.i2;
                    this.i1 = li32(this.i1);
                    this.i2 = li16(this.i1 + 52);
                    this.i2 = (this.i2 + -1);
                    si16(this.i2, (this.i1 + 52));
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _subexpr");
            };
        }


    }
} cmodule.lua_wrapper

