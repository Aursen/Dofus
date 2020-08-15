package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_ll_require extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var f0:Number;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_ll_require;
            _local_1 = new (FSM_ll_require)();
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
                    public::mstate.esp = (public::mstate.esp - 112);
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
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
                    this.i2 = li32(this.i1 + 12);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = (this.i1 + 12);
                    this.i5 = (this.i1 + 8);
                    this.i6 = this.i0;
                    this.i7 = (this.i2 + 12);
                    if (!(uint(this.i3) < uint(this.i7)))
                    {
                        this.i3 = this.i2;
                        goto _label_2;
                        
                    _label_1: 
                        this.i3 = this.i2;
                    };
                    this.i2 = 0;
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = (this.i3 + 12);
                    si32(this.i2, this.i5);
                    this.i7 = li32(this.i4);
                    if (this.i3 < this.i7) goto _label_1;
                    this.i3 = this.i7;
                    
                _label_2: 
                    this.i2 = this.i3;
                    this.i3 = -10000;
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = __2E_str13188331;
                    do 
                    {
                        this.i7 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i8 = this.i3;
                        if ((this.i7 == 0)) break;
                        this.i3 = this.i8;
                    } while (true);
                    this.i7 = __2E_str13188331;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -64));
                    this.i3 = 4;
                    si32(this.i3, (public::mstate.ebp + -56));
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = (public::mstate.ebp + -64);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li8(this.i0);
                    if (this.i3 == 0) goto _label_24;
                    this.i3 = this.i6;
                    do 
                    {
                        this.i7 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i8 = this.i3;
                        if (this.i7 == 0) goto _label_25;
                        this.i3 = this.i8;
                    } while (true);
                    
                _label_3: 
                    this.i4 = li32(this.i4);
                    this.i4 = (this.i4 + 20);
                    goto _label_5;
                    
                _label_4: 
                    this.i4 = li32(this.i4);
                    
                _label_5: 
                    this.i5 = _sentinel_;
                    if (!(this.i4 == this.i5)) goto _label_32;
                    this.i4 = __2E_str29498;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_32;
                    
                _label_6: 
                    this.i2 = -10001;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = __2E_str30499;
                    do 
                    {
                        this.i7 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i8 = this.i3;
                        if ((this.i7 == 0)) break;
                        this.i3 = this.i8;
                    } while (true);
                    this.i7 = __2E_str30499;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 8:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -16));
                    this.i3 = 4;
                    si32(this.i3, (public::mstate.ebp + -8));
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 10:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(this.i2 == this.i3))
                    {
                        this.i2 = li32(this.i2 + 8);
                        if (this.i2 == 5) goto _label_7;
                    };
                    this.i2 = __2E_str31500;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_7: 
                    this.i2 = li32(this.i1 + 16);
                    this.i3 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    this.i7 = (this.i1 + 16);
                    if (uint(this.i3) < uint(this.i2)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i2 = __2E_str45;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 13:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i3);
                    this.i2 = 4;
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 14:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 1;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 15:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i5);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i3);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 16:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(!(this.i2 == this.i3)))
                    {
                        
                    _label_9: 
                        this.i2 = 1;
                        goto _label_11;
                    };
                    this.i2 = li32(this.i2 + 8);
                    if (!(this.i2 == 0)) goto _label_9;
                    this.i2 = 1;
                    
                _label_10: 
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 17:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = __2E_str32501;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_11: 
                    this.i2 = (this.i2 + 1);
                    
                _label_12: 
                    this.i3 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 + -24);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 21:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = _luaO_nilobject_;
                    if (!(this.i3 == this.i8))
                    {
                        this.i3 = li32(this.i3 + 8);
                        if (this.i3 == 6) goto _label_17;
                    };
                    this.i3 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 22:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = _luaO_nilobject_;
                    if (!(!(this.i3 == this.i8)))
                    {
                        this.i3 = 0;
                    }
                    else
                    {
                        this.i3 = li32(this.i3 + 8);
                        this.i3 = (this.i3 + -3);
                        this.i3 = ((uint(this.i3) < uint(2)) ? 1 : 0);
                    };
                    this.i3 = (this.i3 ^ 0x01);
                    this.i3 = (this.i3 & 0x01);
                    if (!(this.i3 == 0)) goto _label_15;
                    this.i3 = li32(this.i7);
                    this.i8 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i8) < uint(this.i3)) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_13: 
                    this.i3 = 2;
                    this.i8 = li32(this.i5);
                    this.i9 = li32(this.i4);
                    this.i8 = (this.i8 - this.i9);
                    this.i8 = (this.i8 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 25:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 26:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i5);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i8);
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i8 + 8));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 27:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = _luaO_nilobject_;
                    if (this.i3 == this.i8) goto _label_16;
                    this.i3 = li32(this.i3 + 8);
                    if (!(this.i3 == 0)) goto _label_16;
                    
                _label_14: 
                    goto _label_10;
                    
                _label_15: 
                    this.i3 = -2;
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + -12);
                    si32(this.i8, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 28:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 29:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i5);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i8);
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i8 + 8));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 30:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = _luaO_nilobject_;
                    if (!(this.i3 == this.i8))
                    {
                        this.i3 = li32(this.i3 + 8);
                        if (this.i3 == 0) goto _label_14;
                    };
                    
                _label_16: 
                    this.i2 = (this.i2 + 1);
                    goto _label_12;
                    
                _label_17: 
                    this.i2 = _sentinel_;
                    this.i3 = li32(this.i5);
                    si32(this.i2, this.i3);
                    this.i2 = 2;
                    si32(this.i2, (this.i3 + 8));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 31:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li8(this.i0);
                    if (this.i3 == 0) goto _label_26;
                    this.i3 = this.i6;
                    do 
                    {
                        this.i4 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i7 = this.i3;
                        if (this.i4 == 0) goto _label_27;
                        this.i3 = this.i7;
                    } while (true);
                    
                _label_18: 
                    this.i3 = this.i0;
                    
                _label_19: 
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 32:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -80));
                    si32(this.i4, (public::mstate.ebp + -72));
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = (this.i3 + -12);
                    this.i4 = (public::mstate.ebp + -80);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i5);
                    
                _label_20: 
                    this.i2 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 34:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li8(this.i0);
                    if (this.i3 == 0) goto _label_28;
                    this.i3 = this.i6;
                    do 
                    {
                        this.i4 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i7 = this.i3;
                        if (this.i4 == 0) goto _label_29;
                        this.i3 = this.i7;
                    } while (true);
                    
                _label_21: 
                    this.i2 = li32(this.i2);
                    this.i2 = (this.i2 + 20);
                    goto _label_23;
                    
                _label_22: 
                    this.i2 = li32(this.i2);
                    
                _label_23: 
                    this.i3 = _sentinel_;
                    if (!(this.i2 == this.i3)) goto _label_32;
                    this.i2 = 1;
                    this.i3 = li32(this.i5);
                    si32(this.i2, this.i3);
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 35:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i5);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i3);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 36:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li8(this.i0);
                    if (this.i3 == 0) goto _label_30;
                    this.i3 = this.i6;
                    do 
                    {
                        this.i4 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i7 = this.i3;
                        if (this.i4 == 0) goto _label_31;
                        this.i3 = this.i7;
                    } while (true);
                    
                _label_24: 
                    this.i3 = this.i0;
                    
                _label_25: 
                    this.i7 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 37:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -32));
                    si32(this.i7, (public::mstate.ebp + -24));
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = (public::mstate.ebp + -32);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 38:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 39:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i2 + 8);
                    if (this.i3 == 0) goto _label_6;
                    if (!(!(this.i3 == 1)))
                    {
                        this.i2 = li32(this.i2);
                        if (this.i2 == 0) goto _label_6;
                    };
                    this.i4 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 40:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i4 + 8);
                    if (this.i5 == 2) goto _label_4;
                    if (this.i5 == 7) goto _label_3;
                    this.i4 = 0;
                    goto _label_5;
                    
                _label_26: 
                    this.i3 = this.i0;
                    
                _label_27: 
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 41:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -48));
                    si32(this.i4, (public::mstate.ebp + -40));
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = (this.i3 + -12);
                    this.i4 = (public::mstate.ebp + -48);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 42:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 43:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    this.i2 = (this.i2 + -24);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 44:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 45:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(this.i2 == this.i3))
                    {
                        this.i2 = li32(this.i2 + 8);
                        if (this.i2 == 0) goto _label_20;
                    };
                    this.i2 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 46:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li8(this.i0);
                    if (this.i3 == 0) goto _label_18;
                    this.i3 = this.i6;
                    do 
                    {
                        this.i4 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i7 = this.i3;
                        if (this.i4 == 0) goto _label_19;
                        this.i3 = this.i7;
                    } while (true);
                    
                _label_28: 
                    this.i3 = this.i0;
                    
                _label_29: 
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 47:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -96));
                    si32(this.i4, (public::mstate.ebp + -88));
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = (public::mstate.ebp + -96);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 48;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 48:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 49:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i2 + 8);
                    if (this.i3 == 2) goto _label_22;
                    if (this.i3 == 7) goto _label_21;
                    this.i2 = 0;
                    goto _label_23;
                    
                _label_30: 
                    this.i3 = this.i0;
                    
                _label_31: 
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 50;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 50:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, (public::mstate.ebp + -112));
                    si32(this.i4, (public::mstate.ebp + -104));
                    this.i0 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = (this.i0 + -12);
                    this.i3 = (public::mstate.ebp + -112);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 51;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 51:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i5);
                    
                _label_32: 
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _ll_require");
            };
        }


    }
}

