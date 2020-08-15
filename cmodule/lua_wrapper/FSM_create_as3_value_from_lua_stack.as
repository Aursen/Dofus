package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_create_as3_value_from_lua_stack extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 2;

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
            var _local_1:FSM_create_as3_value_from_lua_stack;
            _local_1 = new (FSM_create_as3_value_from_lua_stack)();
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
                    this.i1 = (this.i1 - this.i2);
                    this.i2 = sxi8(li8(public::mstate.ebp + 20));
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(public::mstate.ebp + 16);
                    this.i1 = (this.i1 / 12);
                    this.i5 = (this.i0 + 12);
                    this.i6 = (this.i0 + 8);
                    this.i7 = (this.i2 & 0xFF);
                    if (!(this.i7 == 1)) goto _label_2;
                    if (this.i3 <= this.i4) goto _label_2;
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Null]());
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    this.i3 = li32(this.i6);
                    this.i4 = li32(this.i5);
                    this.i3 = (this.i3 - this.i4);
                    this.i3 = (this.i3 / 12);
                    if (!(this.i3 == this.i1)) goto _label_6;
                    this.i0 = this.i2;
                    
                _label_1: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_2: 
                    this.i2 = (this.i2 & 0xFF);
                    if (!(this.i2 == 1)) goto _label_3;
                    if (!(this.i3 == this.i4)) goto _label_3;
                    this.i4 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(!(this.i2 == this.i4)))
                    {
                        this.i2 = -1;
                    }
                    else
                    {
                        this.i2 = li32(this.i2 + 8);
                    };
                    this.i4 = this.i2;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_get_as3_value_from_lua_stack_type.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i6);
                    this.i2 = li32(this.i5);
                    this.i4 = (this.i4 - this.i2);
                    this.i4 = (this.i4 / 12);
                    if (!(this.i4 == this.i1)) goto _label_6;
                    this.i0 = this.i3;
                    goto _label_1;
                    
                _label_3: 
                    this.i2 = __2E_str45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Array]());
                    return;
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i3 > this.i4) goto _label_5;
                    
                _label_4: 
                    this.i7 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(!(this.i8 == this.i7)))
                    {
                        this.i8 = -1;
                    }
                    else
                    {
                        this.i8 = li32(this.i8 + 8);
                    };
                    this.i7 = this.i8;
                    this.i8 = __2E_str12154;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_get_as3_value_from_lua_stack_type.start();
                    return;
                case 6:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = __2E_str2132;
                    si32(this.i8, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_CallTS]());
                    return;
                case 7:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i8, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i7, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = (this.i3 + 1);
                    if (!(this.i3 > this.i4)) goto _label_4;
                    
                _label_5: 
                    this.i3 = li32(this.i6);
                    this.i4 = li32(this.i5);
                    this.i3 = (this.i3 - this.i4);
                    this.i3 = (this.i3 / 12);
                    if (!(!(this.i3 == this.i1)))
                    {
                        this.i0 = this.i2;
                        goto _label_1;
                    };
                    
                _label_6: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 16);
                    this.i3 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    this.i4 = (this.i0 + 16);
                    if (uint(this.i3) < uint(this.i2)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i2 = __2E_str2144;
                    this.i3 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 16;
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
                    si32(this.i2, this.i3);
                    this.i2 = 4;
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i6);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i6);
                    this.i2 = li32(this.i4);
                    this.i3 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i3) < uint(this.i2)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i2 = __2E_str1100;
                    this.i3 = li32(this.i6);
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
                    si32(this.i2, this.i3);
                    this.i2 = 4;
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i6);
                    this.i3 = (this.i2 + 12);
                    si32(this.i3, this.i6);
                    this.i3 = 0x406EC000;
                    this.i7 = 0;
                    si32(this.i7, (this.i2 + 12));
                    si32(this.i3, (this.i2 + 16));
                    this.i3 = 3;
                    si32(this.i3, (this.i2 + 20));
                    this.i2 = li32(this.i6);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i6);
                    this.i2 = li32(this.i4);
                    this.i3 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i3) < uint(this.i2)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i2 = __2E_str2101;
                    this.i3 = li32(this.i6);
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
                    si32(this.i2, this.i3);
                    this.i2 = 4;
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i6);
                    this.i3 = (this.i2 + 12);
                    si32(this.i3, this.i6);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, (this.i2 + 12));
                    this.i1 = 3;
                    si32(this.i1, (this.i2 + 20));
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i6);
                    this.i1 = li32(this.i4);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i1 = __2E_str3102;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 16;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
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
                    this.i1 = li32(this.i6);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i6);
                    this.i3 = li32(this.i5);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f1 = Number(this.i2);
                    sf64(this.f1, (this.i1 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i6);
                    this.i1 = li32(this.i4);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_11: 
                    this.i1 = __2E_str4103;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 18;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
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
                    this.i1 = li32(this.i6);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i6);
                    sf64(this.f0, (this.i1 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i6);
                    this.i1 = li32(this.i4);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_12: 
                    this.i1 = __2E_str10143;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
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
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i6);
                    this.i1 = li32(this.i4);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_13: 
                    this.i1 = 10;
                    this.i2 = li32(this.i6);
                    this.i3 = li32(this.i5);
                    this.i2 = (this.i2 - this.i3);
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
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + -108);
                    si32(this.i1, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 25:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i2);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 26:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6);
                    this.i3 = this.i1;
                    this.i7 = (this.i1 + 12);
                    if (!(uint(this.i7) < uint(this.i2)))
                    {
                        this.i1 = this.i2;
                    }
                    else
                    {
                        this.i1 = (this.i1 + 12);
                        this.i2 = this.i3;
                        
                    _label_14: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i3 = li32(this.i2 + 20);
                        si32(this.i3, (this.i2 + 8));
                        this.i2 = li32(this.i6);
                        this.i3 = (this.i1 + 12);
                        this.i7 = this.i1;
                        if (uint(this.i3) < uint(this.i2)) goto _label_16;
                        this.i1 = this.i2;
                    };
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i6);
                    this.i1 = li32(this.i4);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_15: 
                    this.i1 = 2;
                    this.i2 = li32(this.i6);
                    this.i3 = li32(this.i5);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = 0;
                    this.i2 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 29:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    this.i0 = __2E_str157;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i1;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_16: 
                    this.i1 = this.i3;
                    this.i2 = this.i7;
                    goto _label_14;
                default:
                    throw ("Invalid state in _create_as3_value_from_lua_stack");
            };
        }


    }
}

