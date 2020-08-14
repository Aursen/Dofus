package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_as3_flyield extends Machine 
    {

        public static const intRegCount:int = 9;
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


        public static function start():void
        {
            var _local_1:FSM_as3_flyield;
            _local_1 = new (FSM_as3_flyield)();
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
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i0 = li32(this.i1 + 8);
                    this.i2 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_get_async_state.start();
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    this.i0 = (this.i0 - this.i2);
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = (this.i0 / 12);
                    this.i4 = (this.i1 + 12);
                    this.i5 = (this.i1 + 8);
                    if (!(this.i3 == 0)) goto _label_12;
                    this.i0 = 0;
                    this.i3 = li32(this.i5);
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i1 + 16);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    this.i6 = (this.i1 + 16);
                    if (uint(this.i3) < uint(this.i0)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i0 = __2E_str18225;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 24;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i3 = li32(this.i4);
                    this.i7 = (this.i2 + 2);
                    this.i0 = (this.i0 - this.i3);
                    this.i0 = (this.i0 / 12);
                    if (!(!(this.i0 == this.i7)))
                    {
                        this.i1 = 2;
                        
                    _label_2: 
                        this.i0 = this.i1;
                        public::mstate.eax = this.i0;
                        goto _label_22;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i6);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    this.i0 = __2E_str19226;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 19;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i6);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i0 = __2E_str1100;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i5);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = 0x403F0000;
                    this.i8 = 0;
                    si32(this.i8, (this.i0 + 12));
                    si32(this.i3, (this.i0 + 16));
                    this.i3 = 3;
                    si32(this.i3, (this.i0 + 20));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i6);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i0 = __2E_str2101;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 10:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i5);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i5);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    this.i2 = li32(this.i6);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i2 = __2E_str3102;
                    this.i0 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i0);
                    this.i2 = 4;
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i5);
                    this.i0 = (this.i2 + 12);
                    si32(this.i0, this.i5);
                    this.i3 = li32(this.i4);
                    this.i0 = (this.i0 - this.i3);
                    this.i0 = (this.i0 / 12);
                    this.i0 = (this.i0 + -7);
                    this.f0 = Number(this.i0);
                    sf64(this.f0, (this.i2 + 12));
                    this.i0 = 3;
                    si32(this.i0, (this.i2 + 20));
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    this.i2 = li32(this.i6);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i2 = __2E_str4103;
                    this.i0 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i0);
                    this.i2 = 4;
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i5);
                    this.i0 = (this.i2 + 12);
                    si32(this.i0, this.i5);
                    this.f0 = Number(this.i7);
                    sf64(this.f0, (this.i2 + 12));
                    this.i0 = 3;
                    si32(this.i0, (this.i2 + 20));
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    this.i2 = li32(this.i6);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i2 = __2E_str10143;
                    this.i0 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 16:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i0);
                    this.i2 = 4;
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    this.i2 = li32(this.i6);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i2 = 10;
                    this.i0 = li32(this.i5);
                    this.i3 = li32(this.i4);
                    this.i0 = (this.i0 - this.i3);
                    this.i0 = (this.i0 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + -108);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 19:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i5);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i0);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 20:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i5);
                    this.i3 = this.i2;
                    this.i7 = (this.i2 + 12);
                    if (!(uint(this.i7) < uint(this.i0)))
                    {
                        this.i2 = this.i0;
                    }
                    else
                    {
                        this.i2 = (this.i2 + 12);
                        this.i0 = this.i3;
                        
                    _label_10: 
                        this.f0 = lf64(this.i0 + 12);
                        sf64(this.f0, this.i0);
                        this.i3 = li32(this.i0 + 20);
                        si32(this.i3, (this.i0 + 8));
                        this.i0 = li32(this.i5);
                        this.i3 = (this.i2 + 12);
                        this.i7 = this.i2;
                        if (uint(this.i3) < uint(this.i0)) goto _label_23;
                        this.i2 = this.i0;
                    };
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i5);
                    this.i2 = li32(this.i6);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_11: 
                    this.i2 = 2;
                    this.i0 = li32(this.i5);
                    this.i4 = li32(this.i4);
                    this.i4 = (this.i0 - this.i4);
                    this.i4 = (this.i4 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + -12);
                    si32(this.i4, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.eax = this.i2;
                    goto _label_22;
                    
                _label_12: 
                    this.i3 = 1;
                    this.i0 = this.i3;
                    state = 24;
                case 24:
                    if (this.i0)
                    {
                        this.i0 = 0;
                        throw (new AlchemyYield());
                    };
                    this.i0 = li32(this.i5);
                    si32(this.i3, this.i0);
                    si32(this.i3, (this.i0 + 8));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i3 = li32(this.i4);
                    this.i6 = (this.i2 + 1);
                    this.i0 = (this.i0 - this.i3);
                    this.i0 = (this.i0 / 12);
                    if (!(!(this.i0 == this.i6)))
                    {
                        this.i1 = 1;
                        goto _label_2;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i1 + 16);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    this.i7 = (this.i1 + 16);
                    if (uint(this.i3) < uint(this.i0)) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_13: 
                    this.i0 = __2E_str19226;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 19;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 27:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i7);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_14: 
                    this.i0 = __2E_str1100;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 29:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i5);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = 0x40428000;
                    this.i8 = 0;
                    si32(this.i8, (this.i0 + 12));
                    si32(this.i3, (this.i0 + 16));
                    this.i3 = 3;
                    si32(this.i3, (this.i0 + 20));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i7);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_15: 
                    this.i0 = __2E_str2101;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 31:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i5);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i5);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_16: 
                    this.i0 = __2E_str3102;
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 33:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i5);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i5);
                    this.i3 = li32(this.i4);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_17: 
                    this.i0 = __2E_str4103;
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 35:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i5);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i5);
                    this.f0 = Number(this.i6);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 36:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_18: 
                    this.i0 = __2E_str10143;
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 37:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 38:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_19: 
                    this.i0 = 10;
                    this.i2 = li32(this.i5);
                    this.i3 = li32(this.i4);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 39:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + -108);
                    si32(this.i0, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 40:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 41:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    this.i3 = this.i0;
                    this.i6 = (this.i0 + 12);
                    if (!(uint(this.i6) < uint(this.i2)))
                    {
                        this.i0 = this.i2;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i2 = this.i3;
                        
                    _label_20: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i3 = li32(this.i2 + 20);
                        si32(this.i3, (this.i2 + 8));
                        this.i2 = li32(this.i5);
                        this.i3 = (this.i0 + 12);
                        this.i6 = this.i0;
                        if (uint(this.i3) < uint(this.i2)) goto _label_24;
                        this.i0 = this.i2;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 42:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_21: 
                    this.i0 = 2;
                    this.i2 = li32(this.i5);
                    this.i3 = li32(this.i4);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 43:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 44:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = 1;
                    public::mstate.eax = this.i1;
                    
                _label_22: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_23: 
                    this.i2 = this.i3;
                    this.i0 = this.i7;
                    goto _label_10;
                    
                _label_24: 
                    this.i0 = this.i3;
                    this.i2 = this.i6;
                    goto _label_20;
                default:
                    throw ("Invalid state in _as3_flyield");
            };
        }


    }
} cmodule.lua_wrapper

