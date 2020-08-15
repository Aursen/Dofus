package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_funcargs extends Machine 
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
            var _local_1:FSM_funcargs;
            _local_1 = new (FSM_funcargs)();
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
                    public::mstate.esp = (public::mstate.esp - 208);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 36);
                    this.i2 = li32(this.i0 + 4);
                    this.i3 = li32(this.i0 + 12);
                    this.i4 = (this.i0 + 12);
                    this.i5 = (this.i0 + 4);
                    this.i6 = li32(public::mstate.ebp + 12);
                    if (this.i3 == 286) goto _label_7;
                    if (this.i3 == 123) goto _label_14;
                    if (!(this.i3 == 40)) goto _label_8;
                    this.i7 = li32(this.i0 + 8);
                    this.i8 = (this.i0 + 8);
                    if (this.i7 == this.i2) goto _label_3;
                    this.i7 = 80;
                    this.i9 = li32(this.i0 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = (public::mstate.ebp + -176);
                    this.i9 = (this.i9 + 16);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = li32(this.i5);
                    this.i9 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i11 = __2E_str15272;
                    this.i12 = __2E_str24118;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    si32(this.i12, (public::mstate.esp + 16));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 2:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i9 = (this.i0 + 40);
                    if (this.i3 == 0) goto _label_2;
                    this.i10 = (this.i3 + -284);
                    if (uint(this.i10) > uint(2)) goto _label_1;
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i0 + 48);
                    this.i3 = li32(this.i3);
                    this.i10 = li32(this.i9);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i11 = __2E_str35292;
                    si32(this.i10, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i9);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = 3;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_3;
                    
                _label_1: 
                    this.i10 = __2E_str35292;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 6:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = li32(this.i9);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 7:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i9);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i9 = 3;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_3;
                    
                _label_2: 
                    this.i3 = 3;
                    this.i7 = li32(this.i9);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i3 = li32(this.i5);
                    si32(this.i3, this.i8);
                    this.i3 = li32(this.i0 + 24);
                    this.i5 = (this.i0 + 24);
                    if (!(this.i3 == 287))
                    {
                        this.i7 = 287;
                        si32(this.i3, this.i4);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i7, this.i5);
                        goto _label_4;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 10:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i3, this.i4);
                    
                _label_4: 
                    this.i3 = li32(this.i4);
                    if (!(this.i3 == 41)) goto _label_5;
                    this.i3 = 0;
                    si32(this.i3, (public::mstate.ebp + -208));
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = 40;
                    this.i4 = 41;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_check_match.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 16);
                    goto _label_15;
                    
                _label_5: 
                    this.i3 = (public::mstate.ebp + -208);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_explist1.start();
                    return;
                case 12:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(public::mstate.ebp + -208);
                    if (!(this.i3 == 14))
                    {
                        if (!(this.i3 == 13)) goto _label_6;
                        this.i3 = li32(public::mstate.ebp + -204);
                        this.i4 = li32(this.i1);
                        this.i4 = li32(this.i4 + 12);
                        this.i3 = (this.i3 << 2);
                        this.i3 = (this.i4 + this.i3);
                        this.i4 = li32(this.i3);
                        this.i4 = (this.i4 & 0xFF803FFF);
                        si32(this.i4, this.i3);
                        goto _label_6;
                    };
                    this.i3 = 1;
                    this.i4 = li32(public::mstate.ebp + -204);
                    this.i5 = li32(this.i1);
                    this.i5 = li32(this.i5 + 12);
                    this.i4 = (this.i4 << 2);
                    this.i4 = (this.i5 + this.i4);
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 & 0x7FFFFF);
                    si32(this.i5, this.i4);
                    this.i4 = li32(this.i1);
                    this.i5 = li32(public::mstate.ebp + -204);
                    this.i4 = li32(this.i4 + 12);
                    this.i5 = (this.i5 << 2);
                    this.i7 = li32(this.i1 + 36);
                    this.i4 = (this.i4 + this.i5);
                    this.i5 = li32(this.i4);
                    this.i7 = (this.i7 << 6);
                    this.i7 = (this.i7 & 0x3FC0);
                    this.i5 = (this.i5 & 0xFFFFC03F);
                    this.i5 = (this.i7 | this.i5);
                    si32(this.i5, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_checkstack.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 36);
                    this.i3 = (this.i3 + 1);
                    si32(this.i3, (this.i1 + 36));
                    
                _label_6: 
                    this.i3 = 40;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = 41;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_check_match.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 16);
                    goto _label_15;
                    
                _label_7: 
                    this.i3 = 4;
                    this.i7 = li32(this.i0 + 16);
                    si32(this.i7, (public::mstate.ebp + -96));
                    si32(this.i3, (public::mstate.ebp + -88));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (public::mstate.ebp + -96);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addk.start();
                    return;
                case 15:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = -1;
                    si32(this.i8, (public::mstate.ebp + -196));
                    si32(this.i8, (public::mstate.ebp + -192));
                    si32(this.i3, (public::mstate.ebp + -208));
                    si32(this.i7, (public::mstate.ebp + -204));
                    this.i3 = li32(this.i5);
                    si32(this.i3, (this.i0 + 8));
                    this.i3 = li32(this.i0 + 24);
                    this.i5 = (this.i0 + 16);
                    this.i7 = (this.i0 + 24);
                    if (!(this.i3 == 287))
                    {
                        this.i5 = 287;
                        si32(this.i3, this.i4);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i5, this.i7);
                        goto _label_15;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 16:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, this.i4);
                    goto _label_15;
                    
                _label_8: 
                    this.i1 = 80;
                    this.i2 = li32(this.i0 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (public::mstate.ebp + -80);
                    this.i2 = (this.i2 + 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 17:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i4 = __2E_str15272;
                    this.i5 = __2E_str25119;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i5, (public::mstate.esp + 16));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 18:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = (this.i0 + 40);
                    if (this.i3 == 0) goto _label_10;
                    this.i6 = (this.i3 + -284);
                    if (uint(this.i6) > uint(1)) goto _label_9;
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0 + 48);
                    this.i0 = li32(this.i0);
                    this.i3 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = __2E_str35292;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 20:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    goto _label_12;
                    
                _label_9: 
                    this.i6 = __2E_str35292;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 21:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 22:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 3;
                    goto _label_11;
                    
                _label_10: 
                    this.i1 = 3;
                    this.i2 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    
                _label_11: 
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    
                _label_12: 
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_13: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_14: 
                    this.i3 = (public::mstate.ebp + -208);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_constructor.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_15: 
                    this.i0 = li32(public::mstate.ebp + -208);
                    this.i3 = li32(this.i6 + 4);
                    this.i4 = (this.i6 + 4);
                    this.i5 = (this.i0 + -13);
                    if (!(uint(this.i5) > uint(1)))
                    {
                        this.i0 = 0;
                        goto _label_17;
                    };
                    if (this.i0 == 0) goto _label_16;
                    this.i0 = (public::mstate.ebp + -208);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_16: 
                    this.i0 = li32(this.i1 + 36);
                    this.i0 = (this.i0 - this.i3);
                    this.i0 = (this.i0 << 23);
                    
                _label_17: 
                    this.i5 = -1;
                    this.i7 = li32(this.i1 + 12);
                    this.i7 = li32(this.i7 + 8);
                    this.i8 = (this.i3 << 6);
                    this.i0 = (this.i8 | this.i0);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 | 0x801C);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 26:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (this.i6 + 12));
                    si32(this.i5, (this.i6 + 16));
                    this.i5 = 13;
                    si32(this.i5, this.i6);
                    si32(this.i0, this.i4);
                    this.i0 = li32(this.i1);
                    this.i4 = li32(this.i1 + 24);
                    this.i0 = li32(this.i0 + 20);
                    this.i4 = (this.i4 << 2);
                    this.i0 = (this.i4 + this.i0);
                    si32(this.i2, (this.i0 + -4));
                    this.i0 = (this.i3 + 1);
                    si32(this.i0, (this.i1 + 36));
                    goto _label_13;
                default:
                    throw ("Invalid state in _funcargs");
            };
        }


    }
}

