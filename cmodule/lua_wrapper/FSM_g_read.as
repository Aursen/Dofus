package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_g_read extends Machine 
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
            var _local_1:FSM_g_read;
            _local_1 = new (FSM_g_read)();
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li16(this.i1 + 12);
                    this.i3 = li32(this.i0 + 8);
                    this.i4 = li32(this.i0 + 12);
                    this.i3 = (this.i3 - this.i4);
                    this.i2 = (this.i2 & 0xFFFFFF9F);
                    this.i4 = li32(public::mstate.ebp + 16);
                    si16(this.i2, (this.i1 + 12));
                    this.i2 = (this.i1 + 12);
                    this.i5 = (this.i3 / 12);
                    this.i6 = (this.i0 + 8);
                    this.i3 = (this.i3 + -12);
                    if (uint(this.i3) > uint(11)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_read_line.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = this.i4;
                    goto _label_14;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i5 + 19);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_checkstack.start();
                    return;
                case 2:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i3 == 0)) goto _label_2;
                    this.i3 = __2E_str10185328;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = __2E_str28331;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i3 = 0;
                    this.i7 = (this.i0 + 16);
                    this.i5 = (this.i5 + -2);
                    this.i8 = (this.i1 + 4);
                    this.i9 = this.i1;
                    
                _label_3: 
                    this.i10 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = (this.i4 + this.i3);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i12 == this.i10) goto _label_7;
                    this.i10 = li32(this.i12 + 8);
                    if (!(this.i10 == 3)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tointeger.start();
                    return;
                case 5:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i11 == 0)) goto _label_12;
                    this.i11 = li32(this.i8);
                    this.i11 = (this.i11 + -1);
                    si32(this.i11, this.i8);
                    if (this.i11 > -1) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___srefill.start();
                    return;
                case 6:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i11 == 0))
                    {
                        this.i11 = -1;
                    }
                    else
                    {
                        this.i11 = li32(this.i8);
                        this.i11 = (this.i11 + -1);
                        si32(this.i11, this.i8);
                        this.i11 = li32(this.i9);
                        this.i10 = li8(this.i11);
                        this.i11 = (this.i11 + 1);
                        si32(this.i11, this.i9);
                        this.i11 = this.i10;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_ungetc.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i10 = li32(this.i7);
                    this.i12 = li32(this.i10 + 68);
                    this.i10 = li32(this.i10 + 64);
                    if (uint(this.i12) < uint(this.i10)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i10 = 0;
                    this.i12 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 9:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i10, this.i12);
                    this.i10 = 4;
                    si32(this.i10, (this.i12 + 8));
                    this.i10 = li32(this.i6);
                    this.i11 = ((this.i11 != -1) ? 1 : 0);
                    this.i10 = (this.i10 + 12);
                    si32(this.i10, this.i6);
                    this.i11 = (this.i11 & 0x01);
                    goto _label_13;
                    
                _label_5: 
                    this.i11 = li32(this.i9);
                    this.i10 = li8(this.i11);
                    this.i11 = (this.i11 + 1);
                    si32(this.i11, this.i9);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_ungetc.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = li32(this.i7);
                    this.i10 = li32(this.i11 + 68);
                    this.i11 = li32(this.i11 + 64);
                    if (uint(this.i10) < uint(this.i11)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i11 = 0;
                    this.i10 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i11, this.i10);
                    this.i11 = 4;
                    si32(this.i11, (this.i10 + 8));
                    this.i11 = li32(this.i6);
                    this.i11 = (this.i11 + 12);
                    si32(this.i11, this.i6);
                    this.i11 = 1;
                    goto _label_13;
                    
                _label_7: 
                    this.i10 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 13:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i10 == 0))
                    {
                        this.i12 = li8(this.i10);
                        if (this.i12 == 42) goto _label_8;
                    };
                    this.i12 = __2E_str19269;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_8: 
                    this.i10 = sxi8(li8(this.i10 + 1));
                    if (this.i10 == 97) goto _label_10;
                    if (this.i10 == 108) goto _label_9;
                    if (!(this.i10 == 110)) goto _label_11;
                    this.i11 = (public::mstate.ebp + -8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fscanf.start();
                    return;
                case 15:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i11 == 1))
                    {
                        this.i11 = 0;
                        goto _label_13;
                    };
                    this.i11 = 3;
                    this.f0 = lf64(public::mstate.ebp + -8);
                    this.i10 = li32(this.i6);
                    sf64(this.f0, this.i10);
                    si32(this.i11, (this.i10 + 8));
                    this.i11 = li32(this.i6);
                    this.i11 = (this.i11 + 12);
                    si32(this.i11, this.i6);
                    this.i11 = 1;
                    goto _label_13;
                    
                _label_9: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_read_line.start();
                    return;
                case 16:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_13;
                    
                _label_10: 
                    this.i11 = -1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_read_chars.start();
                    return;
                case 17:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i11 = 1;
                    goto _label_13;
                    
                _label_11: 
                    this.i1 = __2E_str31334;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = 0;
                    public::mstate.eax = this.i1;
                    goto _label_17;
                    
                _label_12: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_read_chars.start();
                    return;
                case 19:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_13: 
                    this.i10 = this.i11;
                    this.i11 = (this.i3 + 1);
                    if (!(this.i10 == 0))
                    {
                        if (!(this.i5 == this.i3))
                        {
                            this.i3 = this.i11;
                            goto _label_3;
                        };
                    };
                    this.i1 = (this.i4 + this.i11);
                    this.i1 = (this.i1 + -1);
                    this.i5 = this.i1;
                    this.i1 = this.i10;
                    
                _label_14: 
                    this.i3 = this.i5;
                    this.i2 = li16(this.i2);
                    this.i3 = (this.i3 + 1);
                    this.i2 = (this.i2 & 0x40);
                    if (this.i2 == 0) goto _label_15;
                    this.i1 = 0;
                    this.i3 = li32(_val_2E_1440);
                    this.i4 = li32(this.i6);
                    si32(this.i1, (this.i4 + 8));
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = _ebuf_2E_1986;
                    this.i4 = 0x0800;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strerror_r.start();
                case 20:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i1 == 0))
                    {
                        this.i1 = 22;
                        si32(this.i1, _val_2E_1440);
                    };
                    this.i1 = __2E_str54344;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = _ebuf_2E_1986;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 21:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i6);
                    this.f0 = Number(this.i3);
                    sf64(this.f0, this.i1);
                    this.i3 = 3;
                    si32(this.i3, (this.i1 + 8));
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i6);
                    goto _label_16;
                    
                _label_15: 
                    if (!(!(this.i1 == 0)))
                    {
                        this.i0 = 0;
                        this.i1 = li32(this.i6);
                        this.i2 = (this.i1 + -12);
                        si32(this.i2, this.i6);
                        si32(this.i0, (this.i1 + -4));
                        this.i0 = li32(this.i6);
                        this.i0 = (this.i0 + 12);
                        si32(this.i0, this.i6);
                        this.i3 = (this.i3 - this.i4);
                        
                    _label_16: 
                        public::mstate.eax = this.i3;
                        
                    _label_17: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i0 = (this.i3 - this.i4);
                    public::mstate.eax = this.i0;
                    goto _label_17;
                default:
                    throw ("Invalid state in _g_read");
            };
        }


    }
}

