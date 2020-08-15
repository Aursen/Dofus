package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_register extends Machine 
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
            var _local_1:FSM_luaL_register;
            _local_1 = new (FSM_luaL_register)();
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
                    public::mstate.esp = (public::mstate.esp - 48);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = this.i2;
                    this.i4 = this.i1;
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = this.i2;
                        goto _label_10;
                    };
                    this.i5 = li32(this.i2);
                    this.i6 = this.i2;
                    if (!(!(this.i5 == 0)))
                    {
                        this.i3 = 0;
                    }
                    else
                    {
                        this.i5 = 0;
                        this.i3 = (this.i3 + 8);
                        do 
                        {
                            this.i7 = li32(this.i3);
                            this.i3 = (this.i3 + 8);
                            this.i5 = (this.i5 + 1);
                        } while (!(this.i7 == 0));
                        this.i3 = this.i5;
                    };
                    this.i5 = __2E_str13188331;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = 1;
                    this.i8 = -10000;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_findtable.start();
                    return;
                case 1:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li8(this.i1);
                    if (this.i7 == 0) goto _label_13;
                    this.i7 = this.i4;
                    do 
                    {
                        this.i8 = li8(this.i7 + 1);
                        this.i7 = (this.i7 + 1);
                        this.i9 = this.i7;
                        if (this.i8 == 0) goto _label_14;
                        this.i7 = this.i9;
                    } while (true);
                    
                _label_1: 
                    this.i5 = this.i1;
                    
                _label_2: 
                    this.i8 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i5 - this.i4);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, (public::mstate.ebp + -16));
                    si32(this.i8, (public::mstate.ebp + -8));
                    this.i1 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = (this.i1 + -12);
                    this.i4 = (public::mstate.ebp + -16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i7);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i7);
                    this.i4 = this.i1;
                    this.i5 = (this.i1 + 12);
                    if (!(uint(this.i5) < uint(this.i3)))
                    {
                        this.i1 = this.i3;
                    }
                    else
                    {
                        this.i1 = (this.i1 + 12);
                        this.i3 = this.i4;
                        
                    _label_3: 
                        this.f0 = lf64(this.i3 + 12);
                        sf64(this.f0, this.i3);
                        this.i4 = li32(this.i3 + 20);
                        si32(this.i4, (this.i3 + 8));
                        this.i3 = li32(this.i7);
                        this.i4 = (this.i1 + 12);
                        this.i5 = this.i1;
                        if (uint(this.i4) < uint(this.i3)) goto _label_16;
                        this.i1 = this.i3;
                    };
                    this.i3 = -1;
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 6:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i7);
                    this.i4 = this.i3;
                    if (!(uint(this.i3) <= uint(this.i1)))
                    {
                        this.i5 = 0;
                        do 
                        {
                            this.i8 = (this.i5 ^ 0xFFFFFFFF);
                            this.i8 = (this.i8 * 12);
                            this.i8 = (this.i4 + this.i8);
                            this.f0 = lf64(this.i8);
                            sf64(this.f0, this.i3);
                            this.i9 = li32(this.i8 + 8);
                            si32(this.i9, (this.i3 + 8));
                            this.i3 = (this.i3 + -12);
                            this.i5 = (this.i5 + 1);
                        } while (!(uint(this.i8) <= uint(this.i1)));
                    };
                    this.i7 = li32(this.i7);
                    this.f0 = lf64(this.i7);
                    sf64(this.f0, this.i1);
                    this.i7 = li32(this.i7 + 8);
                    si32(this.i7, (this.i1 + 8));
                    this.i1 = li32(this.i6);
                    if (this.i1 == 0) goto _label_12;
                    
                _label_4: 
                    this.i1 = this.i2;
                    
                _label_5: 
                    this.i2 = 0;
                    this.i3 = li32(this.i1 + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li8(this.i2);
                    this.i5 = this.i2;
                    if (this.i4 == 0) goto _label_8;
                    this.i4 = this.i2;
                    do 
                    {
                        this.i6 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i7 = this.i4;
                        if (this.i6 == 0) goto _label_9;
                        this.i4 = this.i7;
                    } while (true);
                    
                _label_6: 
                    this.i1 = -2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 9:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i7);
                    this.i4 = this.i1;
                    this.i5 = (this.i1 + 12);
                    if (!(uint(this.i5) < uint(this.i3)))
                    {
                        this.i1 = this.i3;
                    }
                    else
                    {
                        this.i1 = (this.i1 + 12);
                        this.i3 = this.i4;
                        
                    _label_7: 
                        this.f0 = lf64(this.i3 + 12);
                        sf64(this.f0, this.i3);
                        this.i4 = li32(this.i3 + 20);
                        si32(this.i4, (this.i3 + 8));
                        this.i3 = li32(this.i7);
                        this.i4 = (this.i1 + 12);
                        this.i5 = this.i1;
                        if (uint(this.i4) < uint(this.i3)) goto _label_17;
                        this.i1 = this.i3;
                    };
                    this.i3 = -1;
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 10:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i7);
                    this.i4 = this.i3;
                    if (uint(this.i3) <= uint(this.i1)) goto _label_11;
                    this.i5 = 0;
                    do 
                    {
                        this.i8 = (this.i5 ^ 0xFFFFFFFF);
                        this.i8 = (this.i8 * 12);
                        this.i8 = (this.i4 + this.i8);
                        this.f0 = lf64(this.i8);
                        sf64(this.f0, this.i3);
                        this.i9 = li32(this.i8 + 8);
                        si32(this.i9, (this.i3 + 8));
                        this.i3 = (this.i3 + -12);
                        this.i5 = (this.i5 + 1);
                        if (uint(this.i8) <= uint(this.i1)) goto _label_11;
                    } while (true);
                    
                _label_8: 
                    this.i4 = this.i5;
                    
                _label_9: 
                    this.i6 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i4 - this.i2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 11:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -32));
                    si32(this.i6, (public::mstate.ebp + -24));
                    this.i2 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i4 = (public::mstate.ebp + -32);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i0 + 8);
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, (this.i0 + 8));
                    this.i1 = (this.i1 + 8);
                    
                _label_10: 
                    this.i2 = li32(this.i1);
                    if (!(this.i2 == 0))
                    {
                        goto _label_5;
                        
                    _label_11: 
                        this.i3 = li32(this.i7);
                        this.f0 = lf64(this.i3);
                        sf64(this.f0, this.i1);
                        this.i3 = li32(this.i3 + 8);
                        si32(this.i3, (this.i1 + 8));
                        this.i1 = li32(this.i6);
                        if (!(this.i1 == 0)) goto _label_4;
                    };
                    
                _label_12: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_13: 
                    this.i7 = this.i1;
                    
                _label_14: 
                    this.i8 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (this.i7 - this.i4);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 13:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i7, (public::mstate.ebp + -48));
                    si32(this.i8, (public::mstate.ebp + -40));
                    this.i7 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -48);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i5 = li32(this.i0 + 8);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, (this.i0 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 15:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = (this.i0 + 8);
                    this.i8 = _luaO_nilobject_;
                    if (!(this.i5 == this.i8))
                    {
                        this.i5 = li32(this.i5 + 8);
                        if (this.i5 == 5) goto _label_6;
                    };
                    this.i5 = -10002;
                    this.i8 = li32(this.i7);
                    this.i8 = (this.i8 + -12);
                    si32(this.i8, this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_findtable.start();
                    return;
                case 16:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i3 == 0) goto _label_15;
                    this.i3 = __2E_str14189332;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_15: 
                    this.i3 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 18:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i7);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i5);
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i5 + 8));
                    this.i3 = li32(this.i7);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 19:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li8(this.i1);
                    if (this.i5 == 0) goto _label_1;
                    this.i5 = this.i4;
                    do 
                    {
                        this.i8 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i9 = this.i5;
                        if (this.i8 == 0) goto _label_2;
                        this.i5 = this.i9;
                    } while (true);
                    
                _label_16: 
                    this.i1 = this.i4;
                    this.i3 = this.i5;
                    goto _label_3;
                    
                _label_17: 
                    this.i1 = this.i4;
                    this.i3 = this.i5;
                    goto _label_7;
                default:
                    throw ("Invalid state in _luaL_register");
            };
        }


    }
}

