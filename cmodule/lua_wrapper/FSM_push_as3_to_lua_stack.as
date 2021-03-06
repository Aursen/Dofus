package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_push_as3_to_lua_stack extends Machine 
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
            var _local_1:FSM_push_as3_to_lua_stack;
            _local_1 = new (FSM_push_as3_to_lua_stack)();
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
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 8);
                    this.i2 = li32(this.i0 + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = li32(public::mstate.ebp + 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_as3_to_lua_stack_if_convertible.start();
                    return;
                case 1:
                    this.i4 = public::mstate.eax;
                    this.i1 = (this.i1 - this.i2);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = (this.i1 / 12);
                    this.i2 = (this.i0 + 12);
                    this.i5 = (this.i0 + 8);
                    if (!(this.i4 == 0)) goto _label_10;
                    this.i4 = 4;
                    this.i6 = li32(this.i5);
                    this.i7 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Acquire]());
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_newuserdata.start();
                    return;
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i3, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -10000;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i3 = public::mstate.eax;
                    this.i4 = (this.i6 - this.i7);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = __2E_str1143;
                    this.i4 = (this.i4 / 12);
                    do 
                    {
                        this.i7 = li8(this.i6 + 1);
                        this.i6 = (this.i6 + 1);
                        this.i8 = this.i6;
                        if ((this.i7 == 0)) break;
                        this.i6 = this.i8;
                    } while (true);
                    this.i7 = __2E_str1143;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (this.i6 - this.i7);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 5:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, (public::mstate.ebp + -16));
                    this.i6 = 4;
                    si32(this.i6, (public::mstate.ebp + -8));
                    this.i6 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = (public::mstate.ebp + -16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i5);
                    this.i6 = li32(this.i2);
                    this.i7 = (this.i4 + 1);
                    this.i3 = (this.i3 - this.i6);
                    this.i3 = (this.i3 / 12);
                    if (this.i3 == this.i7) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i0 + 16);
                    this.i6 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    this.i8 = (this.i0 + 16);
                    if (uint(this.i6) < uint(this.i3)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i3 = __2E_str2144;
                    this.i6 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 10:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i6);
                    this.i3 = 4;
                    si32(this.i3, (this.i6 + 8));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i8);
                    this.i6 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i6) < uint(this.i3)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i3 = __2E_str1100;
                    this.i6 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i6);
                    this.i3 = 4;
                    si32(this.i3, (this.i6 + 8));
                    this.i3 = li32(this.i5);
                    this.i6 = (this.i3 + 12);
                    si32(this.i6, this.i5);
                    this.i6 = 0x4070D000;
                    this.i9 = 0;
                    si32(this.i9, (this.i3 + 12));
                    si32(this.i6, (this.i3 + 16));
                    this.i6 = 3;
                    si32(this.i6, (this.i3 + 20));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i8);
                    this.i6 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i6) < uint(this.i3)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    this.i3 = __2E_str2101;
                    this.i6 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 38;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i6);
                    this.i3 = 4;
                    si32(this.i3, (this.i6 + 8));
                    this.i3 = li32(this.i5);
                    this.i6 = (this.i3 + 12);
                    si32(this.i6, this.i5);
                    this.f0 = Number(this.i4);
                    sf64(this.f0, (this.i3 + 12));
                    this.i4 = 3;
                    si32(this.i4, (this.i3 + 20));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i8);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i3 = __2E_str3102;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 16:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i4);
                    this.i3 = 4;
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i4 = (this.i3 + 12);
                    si32(this.i4, this.i5);
                    this.i6 = li32(this.i2);
                    this.i4 = (this.i4 - this.i6);
                    this.i4 = (this.i4 / 12);
                    this.i4 = (this.i4 + -7);
                    this.f0 = Number(this.i4);
                    sf64(this.f0, (this.i3 + 12));
                    this.i4 = 3;
                    si32(this.i4, (this.i3 + 20));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i8);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i3 = __2E_str4103;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 18;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 18:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i4);
                    this.i3 = 4;
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i4 = (this.i3 + 12);
                    si32(this.i4, this.i5);
                    this.f0 = Number(this.i7);
                    sf64(this.f0, (this.i3 + 12));
                    this.i4 = 3;
                    si32(this.i4, (this.i3 + 20));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i8);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i3 = __2E_str10143;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 20:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i4);
                    this.i3 = 4;
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i8);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i3 = 10;
                    this.i4 = li32(this.i5);
                    this.i6 = li32(this.i2);
                    this.i4 = (this.i4 - this.i6);
                    this.i4 = (this.i4 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + -108);
                    si32(this.i3, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 23:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i5);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i4);
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 24:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i5);
                    this.i6 = this.i3;
                    this.i7 = (this.i3 + 12);
                    if (!(uint(this.i7) < uint(this.i4)))
                    {
                        this.i3 = this.i4;
                    }
                    else
                    {
                        this.i3 = (this.i3 + 12);
                        this.i4 = this.i6;
                        
                    _label_8: 
                        this.f0 = lf64(this.i4 + 12);
                        sf64(this.f0, this.i4);
                        this.i6 = li32(this.i4 + 20);
                        si32(this.i6, (this.i4 + 8));
                        this.i4 = li32(this.i5);
                        this.i6 = (this.i3 + 12);
                        this.i7 = this.i3;
                        if (uint(this.i6) < uint(this.i4)) goto _label_22;
                        this.i3 = this.i4;
                    };
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i8);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i3 = 2;
                    this.i4 = li32(this.i5);
                    this.i6 = li32(this.i2);
                    this.i4 = (this.i4 - this.i6);
                    this.i4 = (this.i4 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = li32(this.i5);
                    this.i4 = li32(this.i2);
                    this.i3 = (this.i3 - this.i4);
                    this.i4 = (this.i1 + 1);
                    this.i3 = (this.i3 / 12);
                    if (this.i3 == this.i4) goto _label_21;
                    goto _label_11;
                    
                _label_10: 
                    this.i3 = li32(this.i5);
                    this.i4 = li32(this.i2);
                    this.i3 = (this.i3 - this.i4);
                    this.i4 = (this.i1 + 1);
                    this.i3 = (this.i3 / 12);
                    if (this.i3 == this.i4) goto _label_21;
                    
                _label_11: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i0 + 16);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    this.i6 = (this.i0 + 16);
                    if (uint(this.i4) < uint(this.i3)) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_12: 
                    this.i3 = __2E_str2144;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 30:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i4);
                    this.i3 = 4;
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i6);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_13: 
                    this.i3 = __2E_str1100;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 32:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i4);
                    this.i3 = 4;
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i4 = (this.i3 + 12);
                    si32(this.i4, this.i5);
                    this.i4 = 0x4075D000;
                    this.i7 = 0;
                    si32(this.i7, (this.i3 + 12));
                    si32(this.i4, (this.i3 + 16));
                    this.i4 = 3;
                    si32(this.i4, (this.i3 + 20));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i6);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_14: 
                    this.i3 = __2E_str2101;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 38;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 34:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i4);
                    this.i3 = 4;
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i4 = (this.i3 + 12);
                    si32(this.i4, this.i5);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, (this.i3 + 12));
                    this.i4 = 3;
                    si32(this.i4, (this.i3 + 20));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i6);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 35:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_15: 
                    this.i3 = __2E_str3102;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 36:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i4);
                    this.i3 = 4;
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i4 = (this.i3 + 12);
                    si32(this.i4, this.i5);
                    this.i7 = li32(this.i2);
                    this.i4 = (this.i4 - this.i7);
                    this.i4 = (this.i4 / 12);
                    this.i4 = (this.i4 + -7);
                    this.f0 = Number(this.i4);
                    sf64(this.f0, (this.i3 + 12));
                    this.i4 = 3;
                    si32(this.i4, (this.i3 + 20));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i6);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 37:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_16: 
                    this.i3 = __2E_str4103;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 18;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 38:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i4);
                    this.i3 = 4;
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i1 = (this.i1 + 1);
                    this.i4 = (this.i3 + 12);
                    si32(this.i4, this.i5);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, (this.i3 + 12));
                    this.i1 = 3;
                    si32(this.i1, (this.i3 + 20));
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i5);
                    this.i1 = li32(this.i6);
                    this.i3 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i3) < uint(this.i1)) goto _label_17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 39:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_17: 
                    this.i1 = __2E_str10143;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 40:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i3);
                    this.i1 = 4;
                    si32(this.i1, (this.i3 + 8));
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i5);
                    this.i1 = li32(this.i6);
                    this.i3 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i3) < uint(this.i1)) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 41:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_18: 
                    this.i1 = 10;
                    this.i3 = li32(this.i5);
                    this.i4 = li32(this.i2);
                    this.i3 = (this.i3 - this.i4);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 42:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + -108);
                    si32(this.i1, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 43:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i5);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i3);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i3 + 8));
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 44:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i5);
                    this.i4 = this.i1;
                    this.i7 = (this.i1 + 12);
                    if (!(uint(this.i7) < uint(this.i3)))
                    {
                        this.i1 = this.i3;
                    }
                    else
                    {
                        this.i1 = (this.i1 + 12);
                        this.i3 = this.i4;
                        
                    _label_19: 
                        this.f0 = lf64(this.i3 + 12);
                        sf64(this.f0, this.i3);
                        this.i4 = li32(this.i3 + 20);
                        si32(this.i4, (this.i3 + 8));
                        this.i3 = li32(this.i5);
                        this.i4 = (this.i1 + 12);
                        this.i7 = this.i1;
                        if (uint(this.i4) < uint(this.i3)) goto _label_23;
                        this.i1 = this.i3;
                    };
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i5);
                    this.i1 = li32(this.i6);
                    this.i3 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i3) < uint(this.i1)) goto _label_20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 45:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_20: 
                    this.i1 = 2;
                    this.i3 = li32(this.i5);
                    this.i2 = li32(this.i2);
                    this.i2 = (this.i3 - this.i2);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 46;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 46:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 47:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_21: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_22: 
                    this.i3 = this.i6;
                    this.i4 = this.i7;
                    goto _label_8;
                    
                _label_23: 
                    this.i1 = this.i4;
                    this.i3 = this.i7;
                    goto _label_19;
                default:
                    throw ("Invalid state in _push_as3_to_lua_stack");
            };
        }


    }
}

