package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_findfile extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 1;

        public var i10:int;
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
            var _local_1:FSM_findfile;
            _local_1 = new (FSM_findfile)();
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
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = __2E_str20159;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = __2E_str5151;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_gsub.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -10001;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    this.i3 = li32(public::mstate.ebp + 16);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li8(this.i3);
                    this.i5 = this.i3;
                    if (this.i4 == 0) goto _label_14;
                    this.i4 = this.i5;
                    do 
                    {
                        this.i6 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i7 = this.i4;
                        if (this.i6 == 0) goto _label_15;
                        this.i4 = this.i7;
                    } while (true);
                    
                _label_1: 
                    this.i3 = li32(this.i1 + 16);
                    this.i5 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i5) < uint(this.i3)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i3 = __2E_str45;
                    this.i5 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i5);
                    this.i3 = 4;
                    si32(this.i3, (this.i5 + 8));
                    this.i3 = li32(this.i4);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i4);
                    this.i3 = li8(this.i2);
                    if (!(this.i3 == 59))
                    {
                        goto _label_17;
                    };
                    
                _label_3: 
                    this.i3 = li8(this.i2 + 1);
                    this.i2 = (this.i2 + 1);
                    this.i5 = this.i2;
                    if (this.i3 == 59) goto _label_12;
                    goto _label_17;
                    
                _label_4: 
                    this.i6 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 5:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = __2E_str6354;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_gsub.start();
                    return;
                case 6:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i4);
                    this.i9 = this.i7;
                    this.i10 = (this.i7 + 12);
                    if (!(uint(this.i10) < uint(this.i8)))
                    {
                        this.i7 = this.i8;
                    }
                    else
                    {
                        this.i7 = (this.i7 + 12);
                        this.i8 = this.i9;
                        
                    _label_5: 
                        this.f0 = lf64(this.i8 + 12);
                        sf64(this.f0, this.i8);
                        this.i9 = li32(this.i8 + 20);
                        si32(this.i9, (this.i8 + 8));
                        this.i8 = li32(this.i4);
                        this.i9 = (this.i7 + 12);
                        this.i10 = this.i7;
                        if (uint(this.i9) < uint(this.i8)) goto _label_18;
                        this.i7 = this.i8;
                    };
                    this.i8 = 114;
                    this.i7 = (this.i7 + -12);
                    si32(this.i7, this.i4);
                    this.i7 = li8(__2E_str19170 + 2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = 0;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fopen387.start();
                    return;
                case 8:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i7 == 0) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i7, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.eax = this.i6;
                    goto _label_11;
                    
                _label_6: 
                    this.i7 = __2E_str16487;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 10:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 11:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i4);
                    this.i8 = this.i6;
                    this.i9 = (this.i6 + 12);
                    if (!(uint(this.i9) < uint(this.i7)))
                    {
                        this.i6 = this.i7;
                    }
                    else
                    {
                        this.i6 = (this.i6 + 12);
                        this.i7 = this.i8;
                        
                    _label_7: 
                        this.f0 = lf64(this.i7 + 12);
                        sf64(this.f0, this.i7);
                        this.i8 = li32(this.i7 + 20);
                        si32(this.i8, (this.i7 + 8));
                        this.i7 = li32(this.i4);
                        this.i8 = (this.i6 + 12);
                        this.i9 = this.i6;
                        if (uint(this.i8) < uint(this.i7)) goto _label_19;
                        this.i6 = this.i7;
                    };
                    this.i6 = (this.i6 + -12);
                    si32(this.i6, this.i4);
                    this.i6 = li32(this.i5);
                    this.i7 = li32(this.i6 + 68);
                    this.i6 = li32(this.i6 + 64);
                    if (uint(this.i7) < uint(this.i6)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i6 = 2;
                    this.i7 = li32(this.i4);
                    this.i8 = li32(this.i3);
                    this.i7 = (this.i7 - this.i8);
                    this.i7 = (this.i7 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (this.i7 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i4);
                    this.i6 = (this.i6 + -12);
                    si32(this.i6, this.i4);
                    this.i6 = li8(this.i2);
                    if (this.i6 == 59) goto _label_3;
                    
                _label_9: 
                    this.i6 = li8(this.i2);
                    this.i7 = this.i2;
                    if (!(!(this.i6 == 0)))
                    {
                        this.i2 = 0;
                        
                    _label_10: 
                        if (!(this.i2 == 0)) goto _label_4;
                        this.i0 = 0;
                        public::mstate.eax = this.i0;
                        
                    _label_11: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_12: 
                        this.i2 = this.i5;
                        goto _label_3;
                    };
                    this.i8 = (this.i6 & 0xFF);
                    if (this.i8 == 59) goto _label_20;
                    this.i8 = this.i7;
                    do 
                    {
                        this.i9 = li8(this.i8);
                        if (!(!(this.i9 == 0)))
                        {
                            this.i8 = 0;
                            goto _label_21;
                        };
                        this.i9 = li8(this.i8 + 1);
                        this.i8 = (this.i8 + 1);
                        this.i10 = this.i8;
                        if (this.i9 == 59) goto _label_21;
                        this.i8 = this.i10;
                    } while (true);
                    
                _label_13: 
                    this.i6 = (this.i6 & 0xFF);
                    if (this.i6 == 0) goto _label_24;
                    this.i6 = this.i7;
                    do 
                    {
                        this.i8 = li8(this.i6 + 1);
                        this.i6 = (this.i6 + 1);
                        this.i9 = this.i6;
                        if (this.i8 == 0) goto _label_22;
                        this.i6 = this.i9;
                    } while (true);
                    
                _label_14: 
                    this.i4 = this.i3;
                    
                _label_15: 
                    this.i6 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 - this.i5);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, (public::mstate.ebp + -16));
                    si32(this.i6, (public::mstate.ebp + -8));
                    this.i4 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = -1;
                    this.i4 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 16:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = (this.i1 + 8);
                    if (!(this.i2 == 0)) goto _label_1;
                    this.i5 = __2E_str12483;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i1 + 16);
                    this.i5 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i5) < uint(this.i3)) goto _label_16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_16: 
                    this.i3 = __2E_str45;
                    this.i5 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 19:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i5);
                    this.i3 = 4;
                    si32(this.i3, (this.i5 + 8));
                    this.i3 = li32(this.i4);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i4);
                    this.i3 = li8(this.i2);
                    //unresolved if
                    
                _label_17: 
                    this.i3 = (this.i1 + 12);
                    this.i5 = (this.i1 + 16);
                    goto _label_9;
                    
                _label_18: 
                    this.i7 = this.i9;
                    this.i8 = this.i10;
                    goto _label_5;
                    
                _label_19: 
                    this.i6 = this.i8;
                    this.i7 = this.i9;
                    goto _label_7;
                    
                _label_20: 
                    this.i8 = this.i2;
                    
                _label_21: 
                    if (this.i8 == 0) goto _label_13;
                    this.i6 = this.i8;
                    
                _label_22: 
                    this.i8 = li32(this.i5);
                    this.i9 = li32(this.i8 + 68);
                    this.i8 = li32(this.i8 + 64);
                    this.i7 = (this.i6 - this.i7);
                    if (uint(this.i9) < uint(this.i8)) goto _label_23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_23: 
                    this.i8 = 4;
                    this.i9 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 21:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i9);
                    si32(this.i8, (this.i9 + 8));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i2 = this.i6;
                    goto _label_10;
                    
                _label_24: 
                    this.i6 = this.i2;
                    goto _label_22;
                default:
                    throw ("Invalid state in _findfile");
            };
        }


    }
} cmodule.lua_wrapper

