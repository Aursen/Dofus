package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_findtable extends Machine 
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
            var _local_1:FSM_luaL_findtable;
            _local_1 = new (FSM_luaL_findtable)();
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
                    public::mstate.esp = (public::mstate.esp - 0);
                    this.i0 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i2);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i0 + 8);
                    this.i1 = (this.i1 + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(public::mstate.ebp + 20);
                    si32(this.i1, (this.i0 + 8));
                    this.i1 = (this.i0 + 16);
                    this.i4 = (this.i0 + 8);
                    
                _label_1: 
                    this.i5 = li8(this.i2);
                    this.i6 = this.i2;
                    if (this.i5 == 46) goto _label_13;
                    this.i7 = this.i6;
                    do 
                    {
                        this.i8 = li8(this.i7);
                        if (!(!(this.i8 == 0)))
                        {
                            this.i7 = 0;
                            goto _label_14;
                        };
                        this.i8 = li8(this.i7 + 1);
                        this.i7 = (this.i7 + 1);
                        this.i9 = this.i7;
                        if (this.i8 == 46) goto _label_14;
                        this.i7 = this.i9;
                    } while (true);
                    
                _label_2: 
                    this.i5 = (this.i5 & 0xFF);
                    if (this.i5 == 0) goto _label_17;
                    this.i5 = this.i6;
                    do 
                    {
                        this.i7 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i8 = this.i5;
                        if (this.i7 == 0) goto _label_15;
                        this.i5 = this.i8;
                    } while (true);
                    
                _label_3: 
                    this.i7 = li32(this.i7 + 8);
                    this.i7 = ((this.i7 == 0) ? 1 : 0);
                    
                _label_4: 
                    this.i7 = (this.i7 ^ 0x01);
                    this.i8 = (this.i5 + 1);
                    this.i7 = (this.i7 & 0x01);
                    if (!(this.i7 == 0)) goto _label_8;
                    this.i7 = li32(this.i4);
                    this.i7 = (this.i7 + -12);
                    si32(this.i7, this.i4);
                    this.i7 = li8(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = ((this.i7 == 46) ? 1 : this.i3);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i1);
                    this.i9 = li32(this.i7 + 68);
                    this.i7 = li32(this.i7 + 64);
                    if (uint(this.i9) < uint(this.i7)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i7 = 4;
                    this.i9 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i9);
                    si32(this.i7, (this.i9 + 8));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i4);
                    this.f0 = lf64(this.i6);
                    sf64(this.f0, this.i7);
                    this.i6 = li32(this.i6 + 8);
                    si32(this.i6, (this.i7 + 8));
                    this.i6 = li32(this.i4);
                    this.i6 = (this.i6 + 12);
                    si32(this.i6, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = -4;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 6:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (this.i7 + -24);
                    this.i7 = (this.i7 + -12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i6 = li32(this.i4);
                    this.i6 = (this.i6 + -24);
                    si32(this.i6, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i4);
                    this.i7 = this.i2;
                    this.i9 = (this.i2 + 12);
                    if (!(uint(this.i9) < uint(this.i6)))
                    {
                        this.i2 = this.i6;
                    }
                    else
                    {
                        this.i2 = (this.i2 + 12);
                        this.i6 = this.i7;
                        
                    _label_6: 
                        this.f0 = lf64(this.i6 + 12);
                        sf64(this.f0, this.i6);
                        this.i7 = li32(this.i6 + 20);
                        si32(this.i7, (this.i6 + 8));
                        this.i6 = li32(this.i4);
                        this.i7 = (this.i2 + 12);
                        this.i9 = this.i2;
                        if (uint(this.i7) < uint(this.i6)) goto _label_18;
                        this.i2 = this.i6;
                    };
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i4);
                    this.i2 = li8(this.i5);
                    if (!(this.i2 == 46)) goto _label_11;
                    
                _label_7: 
                    this.i2 = this.i8;
                    goto _label_1;
                    
                _label_8: 
                    this.i6 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 9:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = _luaO_nilobject_;
                    if (!(this.i6 == this.i7))
                    {
                        this.i6 = li32(this.i6 + 8);
                        if (this.i6 == 5) goto _label_9;
                    };
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + -24);
                    si32(this.i0, this.i4);
                    public::mstate.eax = this.i2;
                    goto _label_12;
                    
                _label_9: 
                    this.i2 = -2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 10:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i4);
                    this.i7 = this.i2;
                    this.i9 = (this.i2 + 12);
                    if (!(uint(this.i9) < uint(this.i6)))
                    {
                        this.i2 = this.i6;
                    }
                    else
                    {
                        this.i2 = (this.i2 + 12);
                        this.i6 = this.i7;
                        
                    _label_10: 
                        this.f0 = lf64(this.i6 + 12);
                        sf64(this.f0, this.i6);
                        this.i7 = li32(this.i6 + 20);
                        si32(this.i7, (this.i6 + 8));
                        this.i6 = li32(this.i4);
                        this.i7 = (this.i2 + 12);
                        this.i9 = this.i2;
                        if (uint(this.i7) < uint(this.i6)) goto _label_19;
                        this.i2 = this.i6;
                    };
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i4);
                    this.i2 = li8(this.i5);
                    if (this.i2 == 46) goto _label_7;
                    
                _label_11: 
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    
                _label_12: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_13: 
                    this.i7 = this.i2;
                    
                _label_14: 
                    if (this.i7 == 0) goto _label_2;
                    this.i5 = this.i7;
                    
                _label_15: 
                    this.i7 = li32(this.i1);
                    this.i8 = li32(this.i7 + 68);
                    this.i7 = li32(this.i7 + 64);
                    this.i6 = (this.i5 - this.i6);
                    if (uint(this.i8) < uint(this.i7)) goto _label_16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_16: 
                    this.i7 = 4;
                    this.i8 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i9, this.i8);
                    si32(this.i7, (this.i8 + 8));
                    this.i7 = li32(this.i4);
                    this.i7 = (this.i7 + 12);
                    si32(this.i7, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 13:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i4);
                    this.i7 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i9 = (this.i8 + -12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_get.start();
                case 14:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f0 = lf64(this.i7);
                    sf64(this.f0, (this.i8 + -12));
                    this.i7 = li32(this.i7 + 8);
                    si32(this.i7, (this.i8 + -4));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 15:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = _luaO_nilobject_;
                    if (!(this.i7 == this.i8)) goto _label_3;
                    this.i7 = 0;
                    goto _label_4;
                    
                _label_17: 
                    this.i5 = this.i2;
                    goto _label_15;
                    
                _label_18: 
                    this.i2 = this.i7;
                    this.i6 = this.i9;
                    goto _label_6;
                    
                _label_19: 
                    this.i2 = this.i7;
                    this.i6 = this.i9;
                    goto _label_10;
                default:
                    throw ("Invalid state in _luaL_findtable");
            };
        }


    }
} cmodule.lua_wrapper

