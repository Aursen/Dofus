package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_assignment extends Machine 
    {

        public static const intRegCount:int = 12;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
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
            var _local_1:FSM_assignment;
            _local_1 = new (FSM_assignment)();
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
                    public::mstate.esp = (public::mstate.esp - 304);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(this.i1 + 4);
                    this.i3 = (this.i3 + -6);
                    if (uint(this.i3) < uint(4)) goto _label_3;
                    this.i3 = 80;
                    this.i4 = li32(this.i0 + 52);
                    this.i5 = li32(this.i0 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (public::mstate.ebp + -240);
                    this.i4 = (this.i4 + 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i0 + 4);
                    this.i4 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i7 = __2E_str15272;
                    this.i8 = __2E_str27121;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i8, (public::mstate.esp + 16));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 2:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i4 = (this.i0 + 40);
                    if (this.i5 == 0) goto _label_2;
                    this.i6 = (this.i5 + -284);
                    if (uint(this.i6) > uint(2)) goto _label_1;
                    this.i5 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i0 + 48);
                    this.i5 = li32(this.i5);
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = __2E_str35292;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = 3;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_3;
                    
                _label_1: 
                    this.i6 = __2E_str35292;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 6:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 7:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 3;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_3;
                    
                _label_2: 
                    this.i3 = 3;
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i3 = li32(this.i0 + 12);
                    this.i4 = (this.i0 + 12);
                    if (!(this.i3 == 44)) goto _label_8;
                    this.i3 = li32(this.i0 + 4);
                    si32(this.i3, (this.i0 + 8));
                    this.i3 = li32(this.i0 + 24);
                    this.i5 = (this.i0 + 24);
                    if (!(this.i3 == 287))
                    {
                        this.i6 = 287;
                        si32(this.i3, this.i4);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i6, this.i5);
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
                    this.i3 = (public::mstate.ebp + -304);
                    si32(this.i1, (public::mstate.ebp + -304));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 + 4);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_primaryexp.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(public::mstate.ebp + -300);
                    if (!(this.i3 == 6)) goto _label_5;
                    this.i3 = li32(this.i0 + 36);
                    this.i4 = li32(this.i3 + 36);
                    this.i5 = (this.i3 + 36);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i4 = 0;
                    }
                    else
                    {
                        this.i6 = (public::mstate.ebp + -304);
                        this.i6 = (this.i6 + 8);
                        this.i7 = 0;
                        this.i8 = this.i1;
                        do 
                        {
                            this.i9 = li32(this.i8 + 4);
                            if ((this.i9 == 9))
                            {
                                this.i9 = li32(this.i8 + 8);
                                this.i10 = li32(this.i6);
                                this.i11 = (this.i8 + 8);
                                if ((this.i9 == this.i10))
                                {
                                    this.i7 = 1;
                                    si32(this.i4, this.i11);
                                };
                                this.i9 = li32(this.i8 + 12);
                                this.i10 = li32(this.i6);
                                this.i11 = (this.i8 + 12);
                                if ((this.i9 == this.i10))
                                {
                                    this.i7 = 1;
                                    si32(this.i4, this.i11);
                                };
                            };
                            this.i8 = li32(this.i8);
                        } while (!(this.i8 == 0));
                        this.i4 = this.i7;
                    };
                    if (this.i4 == 0) goto _label_5;
                    this.i4 = 1;
                    this.i6 = li32(this.i3 + 12);
                    this.i7 = li32(public::mstate.ebp + -296);
                    this.i8 = li32(this.i5);
                    this.i6 = li32(this.i6 + 8);
                    this.i7 = (this.i7 << 23);
                    this.i8 = (this.i8 << 6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (this.i8 | this.i7);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 12:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_checkstack.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 1);
                    si32(this.i3, this.i5);
                    
                _label_5: 
                    this.i3 = li32(this.i0 + 40);
                    this.i3 = li16(this.i3 + 52);
                    this.i4 = (this.i2 + 1);
                    this.i3 = (200 - this.i3);
                    if (this.i3 >= this.i2) goto _label_11;
                    this.i2 = li32(this.i0 + 36);
                    this.i5 = li32(this.i2);
                    this.i5 = li32(this.i5 + 60);
                    this.i6 = li32(this.i2 + 16);
                    this.i2 = (this.i2 + 12);
                    if (!(this.i5 == 0)) goto _label_6;
                    this.i5 = __2E_str196;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = __2E_str28122;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 14:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i2);
                    this.i5 = li32(this.i2 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 80;
                    this.i7 = (public::mstate.ebp + -160);
                    this.i5 = (this.i5 + 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 15:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(this.i2 + 4);
                    this.i6 = li32(this.i2 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = __2E_str15272;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i3, (public::mstate.esp + 16));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 16:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i2 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_7;
                    
                _label_6: 
                    this.i7 = __2E_str297;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = __2E_str28122;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i8, (public::mstate.esp + 16));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 18:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i2);
                    this.i5 = li32(this.i2 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 80;
                    this.i7 = (public::mstate.ebp + -80);
                    this.i5 = (this.i5 + 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 19:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(this.i2 + 4);
                    this.i6 = li32(this.i2 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = __2E_str15272;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i3, (public::mstate.esp + 16));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 20:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i2 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_7: 
                    this.i2 = (public::mstate.ebp + -304);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_assignment.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_12;
                    
                _label_8: 
                    this.i3 = 61;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_checknext.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (public::mstate.ebp + -272);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_explist1.start();
                    return;
                case 24:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i0 + 36);
                    this.i5 = (this.i0 + 36);
                    if (this.i3 == this.i2) goto _label_9;
                    this.i6 = (public::mstate.ebp + -272);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjust_assign397.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i3 <= this.i2) goto _label_12;
                    this.i4 = li32(this.i5);
                    this.i5 = li32(this.i4 + 36);
                    this.i2 = (this.i2 - this.i3);
                    this.i5 = (this.i2 + this.i5);
                    si32(this.i5, (this.i4 + 36));
                    goto _label_12;
                    
                _label_9: 
                    this.i0 = (public::mstate.ebp + -272);
                    this.i2 = li32(public::mstate.ebp + -272);
                    if (!(this.i2 == 14))
                    {
                        if (!(!(this.i2 == 13)))
                        {
                            this.i2 = 12;
                            si32(this.i2, this.i0);
                            this.i0 = li32(this.i4);
                            this.i4 = li32(public::mstate.ebp + -268);
                            this.i0 = li32(this.i0 + 12);
                            this.i4 = (this.i4 << 2);
                            this.i0 = (this.i0 + this.i4);
                            this.i0 = li32(this.i0);
                            this.i0 = (this.i0 >>> 6);
                            this.i0 = (this.i0 & 0xFF);
                            si32(this.i0, (public::mstate.ebp + -268));
                        };
                    }
                    else
                    {
                        this.i2 = 11;
                        this.i3 = li32(public::mstate.ebp + -268);
                        this.i4 = li32(this.i4);
                        this.i4 = li32(this.i4 + 12);
                        this.i3 = (this.i3 << 2);
                        this.i3 = (this.i4 + this.i3);
                        this.i4 = li32(this.i3);
                        this.i4 = (this.i4 | 0x01000000);
                        this.i4 = (this.i4 & 0x017FFFFF);
                        si32(this.i4, this.i3);
                        si32(this.i2, this.i0);
                    };
                    this.i0 = (public::mstate.ebp + -272);
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 + 4);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    
                _label_10: 
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_storevar.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_11: 
                    this.i2 = (public::mstate.ebp + -304);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_assignment.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_12: 
                    this.i2 = -1;
                    this.i0 = li32(this.i0 + 36);
                    this.i3 = li32(this.i0 + 36);
                    si32(this.i2, (public::mstate.ebp + -260));
                    si32(this.i2, (public::mstate.ebp + -256));
                    this.i2 = 12;
                    si32(this.i2, (public::mstate.ebp + -272));
                    this.i2 = (this.i3 + -1);
                    si32(this.i2, (public::mstate.ebp + -268));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 + 4);
                    this.i2 = (public::mstate.ebp + -272);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    goto _label_10;
                default:
                    throw ("Invalid state in _assignment");
            };
        }


    }
}

