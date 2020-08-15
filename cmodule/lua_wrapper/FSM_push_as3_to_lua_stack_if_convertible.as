package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_push_as3_to_lua_stack_if_convertible extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 2;

        public var i10:int;
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
            var _local_1:FSM_push_as3_to_lua_stack_if_convertible;
            _local_1 = new (FSM_push_as3_to_lua_stack_if_convertible)();
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
                    this.i1 = li32(this.i0 + 8);
                    this.i2 = li32(this.i0 + 12);
                    this.i3 = li32(_Number_class);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = li32(public::mstate.ebp + 12);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_InstanceOf]());
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    this.i1 = (this.i1 - this.i2);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = (this.i1 / 12);
                    this.i2 = (this.i0 + 12);
                    this.i5 = (this.i0 + 8);
                    if (this.i3 == 0) goto _label_2;
                    this.i3 = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_NumberValue]());
                    return;
                case 2:
                    this.f0 = public::mstate.st0;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i4 = li32(this.i5);
                    sf64(this.f0, this.i4);
                    si32(this.i3, (this.i4 + 8));
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    this.i3 = li32(this.i2);
                    this.i4 = (this.i4 - this.i3);
                    this.i3 = (this.i1 + 1);
                    this.i4 = (this.i4 / 12);
                    if (!(this.i4 == this.i3)) goto _label_3;
                    
                _label_1: 
                    this.i0 = 1;
                    goto _label_31;
                    
                _label_2: 
                    this.i3 = li32(_int_class);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_InstanceOf]());
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i3 == 0) goto _label_11;
                    this.i3 = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_IntValue]());
                    return;
                case 4:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i6 = li32(this.i5);
                    this.f0 = Number(this.i4);
                    sf64(this.f0, this.i6);
                    si32(this.i3, (this.i6 + 8));
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    this.i3 = li32(this.i2);
                    this.i4 = (this.i4 - this.i3);
                    this.i3 = (this.i1 + 1);
                    this.i4 = (this.i4 / 12);
                    if (this.i4 == this.i3) goto _label_1;
                    
                _label_3: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i0 + 16);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    this.i6 = (this.i0 + 16);
                    if (uint(this.i4) < uint(this.i3)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i3 = __2E_str2144;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 7:
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
                    if (uint(this.i4) < uint(this.i3)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i3 = __2E_str1100;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 9:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i4);
                    this.i3 = 4;
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i4 = (this.i3 + 12);
                    si32(this.i4, this.i5);
                    this.i4 = 0x4074B000;
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
                    if (uint(this.i4) < uint(this.i3)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i3 = __2E_str2101;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 38;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 11:
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
                    if (uint(this.i4) < uint(this.i3)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i3 = __2E_str3102;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 13:
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
                    if (uint(this.i4) < uint(this.i3)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i3 = __2E_str4103;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 18;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 15:
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
                    if (uint(this.i3) < uint(this.i1)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i1 = __2E_str10143;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 17:
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
                    if (uint(this.i3) < uint(this.i1)) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
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
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 19:
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
                case 20:
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
                case 21:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i5);
                    this.i4 = this.i1;
                    this.i7 = (this.i1 + 12);
                    if (uint(this.i7) < uint(this.i3)) goto _label_27;
                    this.i1 = this.i3;
                    goto _label_29;
                    
                _label_11: 
                    this.i3 = li32(_String_class);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_InstanceOf]());
                    return;
                case 22:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i3 == 0) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_StringValue]());
                    return;
                case 23:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = li8(this.i4);
                    this.i6 = this.i4;
                    if (this.i3 == 0) goto _label_32;
                    this.i3 = this.i6;
                    do 
                    {
                        this.i7 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i8 = this.i3;
                        if (this.i7 == 0) goto _label_33;
                        this.i3 = this.i8;
                    } while (true);
                    
                _label_12: 
                    this.i3 = li32(_Boolean_class);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_InstanceOf]());
                    return;
                case 24:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i3 == 0) goto _label_13;
                    this.i3 = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_IntValue]());
                    return;
                case 25:
                    this.i4 = public::mstate.eax;
                    this.i4 = ((this.i4 != 0) ? 1 : 0);
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i6 = li32(this.i5);
                    this.i4 = (this.i4 & 0x01);
                    si32(this.i4, this.i6);
                    si32(this.i3, (this.i6 + 8));
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    this.i3 = li32(this.i2);
                    this.i4 = (this.i4 - this.i3);
                    this.i3 = (this.i1 + 1);
                    this.i4 = (this.i4 / 12);
                    if (this.i4 == this.i3) goto _label_1;
                    goto _label_3;
                    
                _label_13: 
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Undefined]());
                    return;
                case 26:
                    this.i3 = public::mstate.eax;
                    if (!(!(this.i3 == this.i4)))
                    {
                        this.i4 = 0;
                        this.i3 = li32(this.i5);
                        si32(this.i4, (this.i3 + 8));
                        this.i4 = li32(this.i5);
                        this.i4 = (this.i4 + 12);
                        si32(this.i4, this.i5);
                        this.i3 = li32(this.i2);
                        this.i4 = (this.i4 - this.i3);
                        this.i3 = (this.i1 + 1);
                        this.i4 = (this.i4 / 12);
                        if (this.i4 == this.i3) goto _label_1;
                        goto _label_3;
                    };
                    this.i3 = __2E_str2132;
                    this.i6 = li32(_getQualifiedClassName_method);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = 0;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_CallT]());
                    return;
                case 27:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_StringValue]());
                    return;
                case 28:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = __2E_str3133;
                    this.i6 = 5;
                    this.i8 = this.i4;
                    do 
                    {
                        this.i9 = (this.i3 + this.i7);
                        this.i10 = (this.i8 + this.i7);
                        this.i10 = li8(this.i10);
                        this.i9 = li8(this.i9);
                        if ((!(this.i10 == this.i9))) break;
                        this.i9 = (this.i10 & 0xFF);
                        if (this.i9 == 0) goto _label_15;
                        this.i6 = (this.i6 + -1);
                        this.i7 = (this.i7 + 1);
                        if (this.i6 == 1) goto _label_14;
                    } while (true);
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 30:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i5);
                    this.i3 = li32(this.i2);
                    this.i4 = (this.i4 - this.i3);
                    this.i4 = (this.i4 / 12);
                    if (!(this.i4 == this.i1)) goto _label_17;
                    this.i0 = 0;
                    goto _label_31;
                    
                _label_14: 
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 31:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_16;
                    
                _label_15: 
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 32:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_16: 
                    this.i3 = 0;
                    this.i4 = li32(this.i5);
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i4 = li32(this.i2);
                    this.i3 = (this.i3 - this.i4);
                    this.i4 = (this.i1 + 1);
                    this.i3 = (this.i3 / 12);
                    if (this.i3 == this.i4) goto _label_1;
                    goto _label_3;
                    
                _label_17: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i0 + 16);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    this.i6 = (this.i0 + 16);
                    if (uint(this.i4) < uint(this.i3)) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_18: 
                    this.i3 = __2E_str2144;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 35:
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
                    if (uint(this.i4) < uint(this.i3)) goto _label_19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 36:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_19: 
                    this.i3 = __2E_str1100;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 37:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i4);
                    this.i3 = 4;
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i5);
                    this.i4 = (this.i3 + 12);
                    si32(this.i4, this.i5);
                    this.i4 = 0x40746000;
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
                    if (uint(this.i4) < uint(this.i3)) goto _label_20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 38:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_20: 
                    this.i3 = __2E_str2101;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 38;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 39:
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
                    this.i1 = 3;
                    si32(this.i1, (this.i3 + 20));
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i5);
                    this.i1 = li32(this.i6);
                    this.i3 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i3) < uint(this.i1)) goto _label_21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 40:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_21: 
                    this.i1 = __2E_str3102;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 41:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i3);
                    this.i1 = 4;
                    si32(this.i1, (this.i3 + 8));
                    this.i1 = li32(this.i5);
                    this.i3 = (this.i1 + 12);
                    si32(this.i3, this.i5);
                    this.i4 = li32(this.i2);
                    this.i3 = (this.i3 - this.i4);
                    this.i3 = (this.i3 / 12);
                    this.i3 = (this.i3 + -7);
                    this.f1 = Number(this.i3);
                    sf64(this.f1, (this.i1 + 12));
                    this.i3 = 3;
                    si32(this.i3, (this.i1 + 20));
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i5);
                    this.i1 = li32(this.i6);
                    this.i3 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i3) < uint(this.i1)) goto _label_22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 42:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_22: 
                    this.i1 = __2E_str4103;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 18;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 43:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i3);
                    this.i1 = 4;
                    si32(this.i1, (this.i3 + 8));
                    this.i1 = li32(this.i5);
                    this.i3 = (this.i1 + 12);
                    si32(this.i3, this.i5);
                    sf64(this.f0, (this.i1 + 12));
                    this.i3 = 3;
                    si32(this.i3, (this.i1 + 20));
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i5);
                    this.i1 = li32(this.i6);
                    this.i3 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i3) < uint(this.i1)) goto _label_23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 44:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_23: 
                    this.i1 = __2E_str10143;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 45:
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
                    if (uint(this.i3) < uint(this.i1)) goto _label_24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 46;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 46:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_24: 
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
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 47:
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
                case 48:
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
                case 49:
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
                        
                    _label_25: 
                        this.f0 = lf64(this.i3 + 12);
                        sf64(this.f0, this.i3);
                        this.i4 = li32(this.i3 + 20);
                        si32(this.i4, (this.i3 + 8));
                        this.i3 = li32(this.i5);
                        this.i4 = (this.i1 + 12);
                        this.i7 = this.i1;
                        if (uint(this.i4) < uint(this.i3)) goto _label_35;
                        this.i1 = this.i3;
                    };
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i5);
                    this.i1 = li32(this.i6);
                    this.i3 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i3) < uint(this.i1)) goto _label_26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 50;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 50:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_26: 
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
                    state = 51;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 51:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 52;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 52:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = 0;
                    goto _label_31;
                    
                _label_27: 
                    this.i1 = (this.i1 + 12);
                    this.i3 = this.i4;
                    
                _label_28: 
                    this.f0 = lf64(this.i3 + 12);
                    sf64(this.f0, this.i3);
                    this.i4 = li32(this.i3 + 20);
                    si32(this.i4, (this.i3 + 8));
                    this.i3 = li32(this.i5);
                    this.i4 = (this.i1 + 12);
                    this.i7 = this.i1;
                    if (uint(this.i4) < uint(this.i3)) goto _label_36;
                    this.i1 = this.i3;
                    
                _label_29: 
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i5);
                    this.i1 = li32(this.i6);
                    this.i3 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i3) < uint(this.i1)) goto _label_30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 53;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 53:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_30: 
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
                    state = 54;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 54:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 55;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 55:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = 1;
                    
                _label_31: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_32: 
                    this.i3 = this.i4;
                    
                _label_33: 
                    this.i7 = li32(this.i0 + 16);
                    this.i8 = li32(this.i7 + 68);
                    this.i7 = li32(this.i7 + 64);
                    this.i3 = (this.i3 - this.i6);
                    if (uint(this.i8) < uint(this.i7)) goto _label_34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 56;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 56:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_34: 
                    this.i6 = 4;
                    this.i7 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 57;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 57:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i7);
                    si32(this.i6, (this.i7 + 8));
                    this.i3 = li32(this.i5);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 0;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 58;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 58:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i5);
                    this.i3 = li32(this.i2);
                    this.i4 = (this.i4 - this.i3);
                    this.i3 = (this.i1 + 1);
                    this.i4 = (this.i4 / 12);
                    if (this.i4 == this.i3) goto _label_1;
                    goto _label_3;
                    
                _label_35: 
                    this.i1 = this.i4;
                    this.i3 = this.i7;
                    goto _label_25;
                    
                _label_36: 
                    this.i1 = this.i4;
                    this.i3 = this.i7;
                    goto _label_28;
                default:
                    throw ("Invalid state in _push_as3_to_lua_stack_if_convertible");
            };
        }


    }
}

