package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_as3_trace extends Machine 
    {

        public static const intRegCount:int = 12;
        public static const NumberRegCount:int = 2;

        public var i10:int;
        public var i11:int;
        public var f0:Number;
        public var f1:Number;
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
            var _local_1:FSM_as3_trace;
            _local_1 = new (FSM_as3_trace)();
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
                    public::mstate.esp = (public::mstate.esp - 1040);
                    this.i0 = (public::mstate.ebp + -1040);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    si32(this.i1, (public::mstate.ebp + -1032));
                    this.i4 = (this.i0 + 12);
                    si32(this.i4, (public::mstate.ebp + -1040));
                    this.i4 = 0;
                    si32(this.i4, (public::mstate.ebp + -1036));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = _luaB_tostring;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 1:
                    this.i2 = (this.i2 - this.i3);
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = (this.i0 + 4);
                    this.i4 = (this.i0 + 8);
                    this.i5 = (this.i2 / 12);
                    this.i6 = (this.i1 + 12);
                    this.i7 = (this.i1 + 8);
                    if (this.i2 < 12) goto _label_5;
                    this.i2 = (public::mstate.ebp + -1040);
                    this.i2 = (this.i2 + 1036);
                    this.i8 = 1;
                    
                _label_1: 
                    if (this.i8 < 2) goto _label_3;
                    this.i9 = li32(this.i0);
                    if (uint(this.i9) < uint(this.i2)) goto _label_2;
                    this.i9 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i9, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 2:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i9 == 0) goto _label_2;
                    this.i9 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i9, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i9 = 32;
                    this.i10 = li32(this.i0);
                    si8(this.i9, this.i10);
                    this.i9 = (this.i10 + 1);
                    si32(this.i9, this.i0);
                    
                _label_3: 
                    this.i9 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = li32(this.i7);
                    this.f0 = lf64(this.i10);
                    sf64(this.f0, this.i11);
                    this.i10 = li32(this.i10 + 8);
                    si32(this.i10, (this.i11 + 8));
                    this.i10 = li32(this.i7);
                    this.i10 = (this.i10 + 12);
                    si32(this.i10, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = li32(this.i7);
                    this.f0 = lf64(this.i10);
                    sf64(this.f0, this.i11);
                    this.i10 = li32(this.i10 + 8);
                    si32(this.i10, (this.i11 + 8));
                    this.i10 = li32(this.i7);
                    this.i11 = (this.i10 + 12);
                    si32(this.i11, this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i11 = 1;
                    this.i10 = (this.i10 + -12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 7:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i9 == 0)) goto _label_4;
                    this.i8 = __2E_str40247;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = 0;
                    public::mstate.eax = this.i8;
                    goto _label_16;
                    
                _label_4: 
                    this.i9 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i9, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addvalue.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i8 = (this.i8 + 1);
                    if (!(this.i8 > this.i5)) goto _label_1;
                    
                _label_5: 
                    this.i0 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 10:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i3);
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = -1;
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 12:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + -24);
                    si32(this.i0, this.i7);
                    this.i2 = li32(this.i6);
                    this.i0 = (this.i0 - this.i2);
                    this.i0 = (this.i0 / 12);
                    if (this.i0 == this.i5) goto _label_15;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i1 + 16);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    this.i3 = (this.i1 + 16);
                    if (uint(this.i2) < uint(this.i0)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i0 = __2E_str19226;
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 19;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 15:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i3);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i0 = __2E_str1100;
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 17:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i7);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i7);
                    this.i2 = 0x4084E000;
                    this.i4 = 0;
                    si32(this.i4, (this.i0 + 12));
                    si32(this.i2, (this.i0 + 16));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i3);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i0 = __2E_str2101;
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 19:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i7);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i7);
                    this.f0 = Number(this.i5);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i3);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i0 = __2E_str3102;
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 21:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i7);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i7);
                    this.i4 = li32(this.i6);
                    this.i2 = (this.i2 - this.i4);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f1 = Number(this.i2);
                    sf64(this.f1, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i3);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i0 = __2E_str4103;
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 23:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i7);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i7);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i3);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_11: 
                    this.i0 = __2E_str10143;
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 25:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i3);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_12: 
                    this.i0 = 10;
                    this.i2 = li32(this.i7);
                    this.i4 = li32(this.i6);
                    this.i2 = (this.i2 - this.i4);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + -108);
                    si32(this.i0, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 28:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i7);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 29:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i7);
                    this.i4 = this.i0;
                    this.i5 = (this.i0 + 12);
                    if (!(uint(this.i5) < uint(this.i2)))
                    {
                        this.i0 = this.i2;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i2 = this.i4;
                        
                    _label_13: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i4 = li32(this.i2 + 20);
                        si32(this.i4, (this.i2 + 8));
                        this.i2 = li32(this.i7);
                        this.i4 = (this.i0 + 12);
                        this.i5 = this.i0;
                        if (uint(this.i4) < uint(this.i2)) goto _label_17;
                        this.i0 = this.i2;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i3);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_14: 
                    this.i0 = 2;
                    this.i2 = li32(this.i7);
                    this.i3 = li32(this.i6);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i7);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_15: 
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    
                _label_16: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_17: 
                    this.i0 = this.i4;
                    this.i2 = this.i5;
                    goto _label_13;
                default:
                    throw ("Invalid state in _as3_trace");
            };
        }


    }
} cmodule.lua_wrapper

