package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_thunk_luaInitializeState extends Machine 
    {

        public static const intRegCount:int = 9;
        public static const NumberRegCount:int = 2;

        public var f1:Number;
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
            var _local_1:FSM_thunk_luaInitializeState;
            _local_1 = new (FSM_thunk_luaInitializeState)();
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
                    public::mstate.esp = (public::mstate.esp - 128);
                    this.i0 = __2E_str45;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_ArrayValue]());
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 348;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = 0;
                        goto _label_2;
                    };
                    this.i1 = 0;
                    si32(this.i1, this.i0);
                    this.i2 = 8;
                    si8(this.i2, (this.i0 + 4));
                    this.i2 = 33;
                    si8(this.i2, (this.i0 + 132));
                    this.i2 = 97;
                    si8(this.i2, (this.i0 + 5));
                    this.i2 = (this.i0 + 112);
                    si32(this.i2, (this.i0 + 16));
                    si32(this.i1, (this.i0 + 32));
                    si32(this.i1, (this.i0 + 44));
                    si32(this.i1, (this.i0 + 104));
                    si32(this.i1, (this.i0 + 68));
                    si8(this.i1, (this.i0 + 56));
                    si32(this.i1, (this.i0 + 60));
                    this.i2 = 1;
                    si8(this.i2, (this.i0 + 57));
                    this.i2 = li32(this.i0 + 60);
                    si32(this.i2, (this.i0 + 64));
                    si32(this.i1, (this.i0 + 96));
                    si32(this.i1, (this.i0 + 48));
                    si16(this.i1, (this.i0 + 54));
                    si16(this.i1, (this.i0 + 52));
                    si8(this.i1, (this.i0 + 6));
                    si32(this.i1, (this.i0 + 20));
                    si32(this.i1, (this.i0 + 40));
                    si32(this.i1, (this.i0 + 24));
                    si32(this.i1, (this.i0 + 108));
                    si32(this.i1, (this.i0 + 80));
                    this.i2 = _l_alloc;
                    si32(this.i2, (this.i0 + 124));
                    si32(this.i1, (this.i0 + 128));
                    si32(this.i0, (this.i0 + 216));
                    this.i2 = (this.i0 + 220);
                    si32(this.i2, (this.i0 + 232));
                    si32(this.i2, (this.i0 + 236));
                    si32(this.i1, (this.i0 + 176));
                    si32(this.i1, (this.i0 + 120));
                    si32(this.i1, (this.i0 + 116));
                    si32(this.i1, (this.i0 + 112));
                    this.i2 = li32(this.i0 + 16);
                    si32(this.i1, (this.i2 + 100));
                    si32(this.i1, (this.i0 + 164));
                    si32(this.i1, (this.i0 + 172));
                    si32(this.i1, (this.i0 + 200));
                    si8(this.i1, (this.i0 + 133));
                    si32(this.i0, (this.i0 + 140));
                    si32(this.i1, (this.i0 + 136));
                    this.i2 = (this.i0 + 140);
                    si32(this.i2, (this.i0 + 144));
                    si32(this.i1, (this.i0 + 148));
                    si32(this.i1, (this.i0 + 152));
                    si32(this.i1, (this.i0 + 156));
                    si32(this.i1, (this.i0 + 160));
                    this.i2 = 348;
                    si32(this.i2, (this.i0 + 180));
                    this.i2 = 200;
                    si32(this.i2, (this.i0 + 192));
                    si32(this.i2, (this.i0 + 196));
                    si32(this.i1, (this.i0 + 188));
                    si32(this.i1, (this.i0 + 244));
                    si32(this.i1, (this.i0 + 248));
                    si32(this.i1, (this.i0 + 252));
                    si32(this.i1, (this.i0 + 0x0100));
                    si32(this.i1, (this.i0 + 260));
                    si32(this.i1, (this.i0 + 264));
                    si32(this.i1, (this.i0 + 268));
                    si32(this.i1, (this.i0 + 272));
                    si32(this.i1, (this.i0 + 276));
                    si32(this.i1, (public::mstate.ebp + -76));
                    this.i1 = li32(this.i0 + 104);
                    this.i2 = (public::mstate.ebp + -128);
                    si32(this.i1, (public::mstate.ebp + -128));
                    si32(this.i2, (this.i0 + 104));
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i1 = (this.i2 + 4);
                    si32(this.i1, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[__setjmp]());
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = (this.i2 + 52);
                    this.i4 = (this.i0 + 104);
                    if (!(this.i1 == 0)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_f_luaopen391.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i1 = li32(this.i2);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i3);
                    if (!(!(this.i1 == 0))) goto _label_2;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_close_state.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = this.i1;
                    
                _label_2: 
                    if (this.i0 == 0) goto _label_47;
                    this.i1 = _panic;
                    this.i2 = li32(this.i0 + 16);
                    si32(this.i1, (this.i2 + 88));
                    this.i1 = li32(this.i0 + 16);
                    this.i2 = _panic_handler;
                    si32(this.i2, (this.i1 + 88));
                    this.i1 = li32(this.i0 + 8);
                    this.i2 = li32(this.i0 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_gc.start();
                    return;
                case 6:
                    this.i3 = public::mstate.eax;
                    this.i1 = (this.i1 - this.i2);
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = _lualibs;
                    this.i1 = (this.i1 / 12);
                    this.i3 = (this.i0 + 12);
                    this.i4 = (this.i0 + 8);
                    this.i5 = (this.i0 + 16);
                    
                _label_3: 
                    this.i6 = 0;
                    this.i7 = li32(this.i2 + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (this.i7 + -24);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i2 + 12);
                    this.i2 = (this.i2 + 8);
                    if (!(this.i6 == 0)) goto _label_3;
                    this.i2 = li32(this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    if (this.i2 == this.i1) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i2 = __2E_str99;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 14;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i2 = __2E_str1100;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 12);
                    si32(this.i6, this.i4);
                    this.i6 = 0x404B0000;
                    this.i7 = 0;
                    si32(this.i7, (this.i2 + 12));
                    si32(this.i6, (this.i2 + 16));
                    this.i6 = 3;
                    si32(this.i6, (this.i2 + 20));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i2 = __2E_str2101;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 38;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 16:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 12);
                    si32(this.i6, this.i4);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, (this.i2 + 12));
                    this.i1 = 3;
                    si32(this.i1, (this.i2 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i1 = __2E_str3102;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 18:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f1 = Number(this.i2);
                    sf64(this.f1, (this.i1 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i1 = __2E_str4103;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 18;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 20:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i4);
                    sf64(this.f0, (this.i1 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i1 = __2E_str10143;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 22:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i1 = 10;
                    this.i2 = li32(this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + -108);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 25:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i2);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 26:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.i6 = this.i1;
                    this.i7 = (this.i1 + 12);
                    if (!(uint(this.i7) < uint(this.i2)))
                    {
                        this.i1 = this.i2;
                    }
                    else
                    {
                        this.i1 = (this.i1 + 12);
                        this.i2 = this.i6;
                        
                    _label_11: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i6 = li32(this.i2 + 20);
                        si32(this.i6, (this.i2 + 8));
                        this.i2 = li32(this.i4);
                        this.i6 = (this.i1 + 12);
                        this.i7 = this.i1;
                        if (uint(this.i6) < uint(this.i2)) goto _label_48;
                        this.i1 = this.i2;
                    };
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i5 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i5) < uint(this.i1)) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_12: 
                    this.i1 = 2;
                    this.i5 = li32(this.i4);
                    this.i3 = li32(this.i3);
                    this.i3 = (this.i5 - this.i3);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = 0;
                    this.i3 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 29:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i4);
                    this.i0 = __2E_str157;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i1;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    goto _label_44;
                    
                _label_13: 
                    this.i2 = __2E_str185;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_newmetatable.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = _release_callback;
                    this.i6 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 32:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = __2E_str1186;
                    do 
                    {
                        this.i7 = li8(this.i6 + 1);
                        this.i6 = (this.i6 + 1);
                        this.i8 = this.i6;
                        if ((this.i7 == 0)) break;
                        this.i6 = this.i8;
                    } while (true);
                    this.i7 = __2E_str1186;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (this.i6 - this.i7);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 33:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, (public::mstate.ebp + -32));
                    this.i6 = 4;
                    si32(this.i6, (public::mstate.ebp + -24));
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (this.i6 + -12);
                    this.i7 = (public::mstate.ebp + -32);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + -24);
                    si32(this.i2, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 35:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -10000;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 36:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = __2E_str2187;
                    do 
                    {
                        this.i7 = li8(this.i6 + 1);
                        this.i6 = (this.i6 + 1);
                        this.i8 = this.i6;
                        if ((this.i7 == 0)) break;
                        this.i6 = this.i8;
                    } while (true);
                    this.i7 = __2E_str2187;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (this.i6 - this.i7);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 37:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, (public::mstate.ebp + -16));
                    this.i6 = 4;
                    si32(this.i6, (public::mstate.ebp + -8));
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (this.i6 + -12);
                    this.i7 = (public::mstate.ebp + -16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 38:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    if (this.i2 == this.i1) goto _label_23;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 39:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 40:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_14: 
                    this.i2 = __2E_str99;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 14;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 41:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 42:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_15: 
                    this.i2 = __2E_str1100;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 43:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 12);
                    si32(this.i6, this.i4);
                    this.i6 = 0x404D0000;
                    this.i7 = 0;
                    si32(this.i7, (this.i2 + 12));
                    si32(this.i6, (this.i2 + 16));
                    this.i6 = 3;
                    si32(this.i6, (this.i2 + 20));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 44:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_16: 
                    this.i2 = __2E_str2101;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 38;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 45:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 12);
                    si32(this.i6, this.i4);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, (this.i2 + 12));
                    this.i1 = 3;
                    si32(this.i1, (this.i2 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 46;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 46:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_17: 
                    this.i1 = __2E_str3102;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 47:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f1 = Number(this.i2);
                    sf64(this.f1, (this.i1 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 48;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 48:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_18: 
                    this.i1 = __2E_str4103;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 18;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 49;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 49:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i4);
                    sf64(this.f0, (this.i1 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 50;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 50:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_19: 
                    this.i1 = __2E_str10143;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 51;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 51:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 52;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 52:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_20: 
                    this.i1 = 10;
                    this.i2 = li32(this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 53;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 53:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + -108);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 54:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i2);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 55:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.i6 = this.i1;
                    this.i7 = (this.i1 + 12);
                    if (!(uint(this.i7) < uint(this.i2)))
                    {
                        this.i1 = this.i2;
                    }
                    else
                    {
                        this.i1 = (this.i1 + 12);
                        this.i2 = this.i6;
                        
                    _label_21: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i6 = li32(this.i2 + 20);
                        si32(this.i6, (this.i2 + 8));
                        this.i2 = li32(this.i4);
                        this.i6 = (this.i1 + 12);
                        this.i7 = this.i1;
                        if (uint(this.i6) < uint(this.i2)) goto _label_49;
                        this.i1 = this.i2;
                    };
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i5 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i5) < uint(this.i1)) goto _label_22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 56;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 56:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_22: 
                    goto _label_12;
                    
                _label_23: 
                    this.i2 = __2E_str1143;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 57;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_newmetatable.start();
                    return;
                case 57:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = _as3_release;
                    this.i6 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 58;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 58:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 59:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = __2E_str1186;
                    do 
                    {
                        this.i7 = li8(this.i6 + 1);
                        this.i6 = (this.i6 + 1);
                        this.i8 = this.i6;
                        if ((this.i7 == 0)) break;
                        this.i6 = this.i8;
                    } while (true);
                    this.i7 = __2E_str1186;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (this.i6 - this.i7);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 60;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 60:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, (public::mstate.ebp + -48));
                    this.i6 = 4;
                    si32(this.i6, (public::mstate.ebp + -40));
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (this.i6 + -12);
                    this.i7 = (public::mstate.ebp + -48);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 61;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 61:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + -24);
                    si32(this.i2, this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = __2E_str18175;
                    this.i6 = _AS3_LUA_LIB;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 62;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_register.start();
                    return;
                case 62:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    if (this.i2 == this.i1) goto _label_33;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 63;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 63:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 64;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 64:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_24: 
                    this.i2 = __2E_str99;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 14;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 65;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 65:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 66;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 66:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_25: 
                    this.i2 = __2E_str1100;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 67;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 67:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 12);
                    si32(this.i6, this.i4);
                    this.i6 = 0x404F0000;
                    this.i7 = 0;
                    si32(this.i7, (this.i2 + 12));
                    si32(this.i6, (this.i2 + 16));
                    this.i6 = 3;
                    si32(this.i6, (this.i2 + 20));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 68;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 68:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_26: 
                    this.i2 = __2E_str2101;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 38;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 69;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 69:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 12);
                    si32(this.i6, this.i4);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, (this.i2 + 12));
                    this.i1 = 3;
                    si32(this.i1, (this.i2 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 70;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 70:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_27: 
                    this.i1 = __2E_str3102;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 71;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 71:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f1 = Number(this.i2);
                    sf64(this.f1, (this.i1 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 72;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 72:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_28: 
                    this.i1 = __2E_str4103;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 18;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 73;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 73:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i4);
                    sf64(this.f0, (this.i1 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 74;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 74:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_29: 
                    this.i1 = __2E_str10143;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 75;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 75:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 76;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 76:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_30: 
                    this.i1 = 10;
                    this.i2 = li32(this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 77;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 77:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + -108);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 78:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i2);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 79:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.i6 = this.i1;
                    this.i7 = (this.i1 + 12);
                    if (!(uint(this.i7) < uint(this.i2)))
                    {
                        this.i1 = this.i2;
                    }
                    else
                    {
                        this.i1 = (this.i1 + 12);
                        this.i2 = this.i6;
                        
                    _label_31: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i6 = li32(this.i2 + 20);
                        si32(this.i6, (this.i2 + 8));
                        this.i2 = li32(this.i4);
                        this.i6 = (this.i1 + 12);
                        this.i7 = this.i1;
                        if (uint(this.i6) < uint(this.i2)) goto _label_50;
                        this.i1 = this.i2;
                    };
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i5 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i5) < uint(this.i1)) goto _label_32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 80;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 80:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_32: 
                    goto _label_22;
                    
                _label_33: 
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 81;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 81:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_34: 
                    this.i2 = __2E_str10109;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 6;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 82;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 82:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -10002;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 83:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = __2E_str11110;
                    do 
                    {
                        this.i7 = li8(this.i6 + 1);
                        this.i6 = (this.i6 + 1);
                        this.i8 = this.i6;
                        if ((this.i7 == 0)) break;
                        this.i6 = this.i8;
                    } while (true);
                    this.i7 = __2E_str11110;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (this.i6 - this.i7);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 84;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 84:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, (public::mstate.ebp + -64));
                    this.i6 = 4;
                    si32(this.i6, (public::mstate.ebp + -56));
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (this.i6 + -12);
                    this.i7 = (public::mstate.ebp + -64);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 85;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 85:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
                    this.i6 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 86;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_gc.start();
                    return;
                case 86:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    if (this.i2 == this.i1) goto _label_45;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 87;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 87:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 88;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 88:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_35: 
                    this.i2 = __2E_str99;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 14;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 89;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 89:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 90;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 90:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_36: 
                    this.i2 = __2E_str1100;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 91;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 91:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 12);
                    si32(this.i6, this.i4);
                    this.i6 = 0x40514000;
                    this.i7 = 0;
                    si32(this.i7, (this.i2 + 12));
                    si32(this.i6, (this.i2 + 16));
                    this.i6 = 3;
                    si32(this.i6, (this.i2 + 20));
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i2 = li32(this.i5);
                    this.i6 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i6) < uint(this.i2)) goto _label_37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 92;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 92:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_37: 
                    this.i2 = __2E_str2101;
                    this.i6 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 38;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 93;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 93:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 4;
                    si32(this.i2, (this.i6 + 8));
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 12);
                    si32(this.i6, this.i4);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, (this.i2 + 12));
                    this.i1 = 3;
                    si32(this.i1, (this.i2 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 94;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 94:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_38: 
                    this.i1 = __2E_str3102;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 95;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 95:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f1 = Number(this.i2);
                    sf64(this.f1, (this.i1 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 96;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 96:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_39: 
                    this.i1 = __2E_str4103;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 18;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 97;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 97:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i4);
                    sf64(this.f0, (this.i1 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 98;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 98:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_40: 
                    this.i1 = __2E_str10143;
                    this.i2 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 99;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 99:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 100;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 100:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_41: 
                    this.i1 = 10;
                    this.i2 = li32(this.i4);
                    this.i6 = li32(this.i3);
                    this.i2 = (this.i2 - this.i6);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 101;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 101:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + -108);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 102:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i2);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 103:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.i6 = this.i1;
                    this.i7 = (this.i1 + 12);
                    if (!(uint(this.i7) < uint(this.i2)))
                    {
                        this.i1 = this.i2;
                    }
                    else
                    {
                        this.i1 = (this.i1 + 12);
                        this.i2 = this.i6;
                        
                    _label_42: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i6 = li32(this.i2 + 20);
                        si32(this.i6, (this.i2 + 8));
                        this.i2 = li32(this.i4);
                        this.i6 = (this.i1 + 12);
                        this.i7 = this.i1;
                        if (uint(this.i6) < uint(this.i2)) goto _label_51;
                        this.i1 = this.i2;
                    };
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i4);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 104;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 104:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_43: 
                    this.i1 = 2;
                    this.i2 = li32(this.i4);
                    this.i3 = li32(this.i3);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 105;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 105:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = 0;
                    this.i2 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 106;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 106:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i4);
                    this.i0 = __2E_str157;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i1;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    
                _label_44: 
                    state = 107;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 107:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_45: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    
                _label_46: 
                    si32(this.i0, public::mstate.esp);
                    state = 108;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Int]());
                    return;
                case 108:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_47: 
                    this.i0 = __2E_str9108;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = 0;
                    goto _label_46;
                    
                _label_48: 
                    this.i1 = this.i6;
                    this.i2 = this.i7;
                    goto _label_11;
                    
                _label_49: 
                    this.i1 = this.i6;
                    this.i2 = this.i7;
                    goto _label_21;
                    
                _label_50: 
                    this.i1 = this.i6;
                    this.i2 = this.i7;
                    goto _label_31;
                    
                _label_51: 
                    this.i1 = this.i6;
                    this.i2 = this.i7;
                    goto _label_42;
                default:
                    throw ("Invalid state in _thunk_luaInitializeState");
            };
        }


    }
}

