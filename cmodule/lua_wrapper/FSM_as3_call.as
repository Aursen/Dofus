package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_as3_call extends Machine 
    {

        public static const intRegCount:int = 13;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
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
            var _local_1:FSM_as3_call;
            _local_1 = new (FSM_as3_call)();
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
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    si32(this.i0, (this.i2 + 8));
                    this.i4 = li32(this.i1 + 8);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = __2E_str1143;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkudata.start();
                    return;
                case 1:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    this.i2 = (this.i2 - this.i3);
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = (this.i2 / 12);
                    this.i3 = (this.i1 + 12);
                    this.i5 = (this.i1 + 8);
                    if (!(this.i0 == 0)) goto _label_1;
                    this.i6 = __2E_str36243;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i6 = li32(this.i5);
                    this.i7 = li32(this.i3);
                    this.i6 = (this.i6 - this.i7);
                    this.i7 = (this.i2 + 1);
                    this.i6 = (this.i6 / 12);
                    if (this.i6 == this.i7) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i1 + 16);
                    this.i8 = li32(this.i6 + 68);
                    this.i6 = li32(this.i6 + 64);
                    this.i9 = (this.i1 + 16);
                    if (uint(this.i8) < uint(this.i6)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i6 = __2E_str19226;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 19;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 6:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, this.i8);
                    this.i6 = 4;
                    si32(this.i6, (this.i8 + 8));
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + 12);
                    si32(this.i6, this.i5);
                    this.i6 = li32(this.i9);
                    this.i8 = li32(this.i6 + 68);
                    this.i6 = li32(this.i6 + 64);
                    if (uint(this.i8) < uint(this.i6)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    this.i6 = __2E_str1100;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 8:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, this.i8);
                    this.i6 = 4;
                    si32(this.i6, (this.i8 + 8));
                    this.i6 = li32(this.i5);
                    this.i8 = (this.i6 + 12);
                    si32(this.i8, this.i5);
                    this.i8 = 0x407D8000;
                    this.i10 = 0;
                    si32(this.i10, (this.i6 + 12));
                    si32(this.i8, (this.i6 + 16));
                    this.i8 = 3;
                    si32(this.i8, (this.i6 + 20));
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + 12);
                    si32(this.i6, this.i5);
                    this.i6 = li32(this.i9);
                    this.i8 = li32(this.i6 + 68);
                    this.i6 = li32(this.i6 + 64);
                    if (uint(this.i8) < uint(this.i6)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i6 = __2E_str2101;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 10:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, this.i8);
                    this.i6 = 4;
                    si32(this.i6, (this.i8 + 8));
                    this.i6 = li32(this.i5);
                    this.i8 = (this.i6 + 12);
                    si32(this.i8, this.i5);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i6 + 12));
                    this.i8 = 3;
                    si32(this.i8, (this.i6 + 20));
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + 12);
                    si32(this.i6, this.i5);
                    this.i6 = li32(this.i9);
                    this.i8 = li32(this.i6 + 68);
                    this.i6 = li32(this.i6 + 64);
                    if (uint(this.i8) < uint(this.i6)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i6 = __2E_str3102;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, this.i8);
                    this.i6 = 4;
                    si32(this.i6, (this.i8 + 8));
                    this.i6 = li32(this.i5);
                    this.i8 = (this.i6 + 12);
                    si32(this.i8, this.i5);
                    this.i10 = li32(this.i3);
                    this.i8 = (this.i8 - this.i10);
                    this.i8 = (this.i8 / 12);
                    this.i8 = (this.i8 + -7);
                    this.f0 = Number(this.i8);
                    sf64(this.f0, (this.i6 + 12));
                    this.i8 = 3;
                    si32(this.i8, (this.i6 + 20));
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + 12);
                    si32(this.i6, this.i5);
                    this.i6 = li32(this.i9);
                    this.i8 = li32(this.i6 + 68);
                    this.i6 = li32(this.i6 + 64);
                    if (uint(this.i8) < uint(this.i6)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i6 = __2E_str4103;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, this.i8);
                    this.i6 = 4;
                    si32(this.i6, (this.i8 + 8));
                    this.i6 = li32(this.i5);
                    this.i8 = (this.i6 + 12);
                    si32(this.i8, this.i5);
                    this.f0 = Number(this.i7);
                    sf64(this.f0, (this.i6 + 12));
                    this.i8 = 3;
                    si32(this.i8, (this.i6 + 20));
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + 12);
                    si32(this.i6, this.i5);
                    this.i6 = li32(this.i9);
                    this.i8 = li32(this.i6 + 68);
                    this.i6 = li32(this.i6 + 64);
                    if (uint(this.i8) < uint(this.i6)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i6 = __2E_str10143;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 16:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i6, this.i8);
                    this.i6 = 4;
                    si32(this.i6, (this.i8 + 8));
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + 12);
                    si32(this.i6, this.i5);
                    this.i6 = li32(this.i9);
                    this.i8 = li32(this.i6 + 68);
                    this.i6 = li32(this.i6 + 64);
                    if (uint(this.i8) < uint(this.i6)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i6 = 10;
                    this.i8 = li32(this.i5);
                    this.i10 = li32(this.i3);
                    this.i8 = (this.i8 - this.i10);
                    this.i8 = (this.i8 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + -108);
                    si32(this.i6, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 19:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i5);
                    this.f0 = lf64(this.i6);
                    sf64(this.f0, this.i8);
                    this.i6 = li32(this.i6 + 8);
                    si32(this.i6, (this.i8 + 8));
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + 12);
                    si32(this.i6, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 20:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i5);
                    this.i10 = this.i6;
                    this.i11 = (this.i6 + 12);
                    if (!(uint(this.i11) < uint(this.i8)))
                    {
                        this.i6 = this.i8;
                    }
                    else
                    {
                        this.i6 = (this.i6 + 12);
                        this.i8 = this.i10;
                        
                    _label_9: 
                        this.f0 = lf64(this.i8 + 12);
                        sf64(this.f0, this.i8);
                        this.i10 = li32(this.i8 + 20);
                        si32(this.i10, (this.i8 + 8));
                        this.i8 = li32(this.i5);
                        this.i10 = (this.i6 + 12);
                        this.i11 = this.i6;
                        if (uint(this.i10) < uint(this.i8)) goto _label_43;
                        this.i6 = this.i8;
                    };
                    this.i6 = (this.i6 + -12);
                    si32(this.i6, this.i5);
                    this.i6 = li32(this.i9);
                    this.i8 = li32(this.i6 + 68);
                    this.i6 = li32(this.i6 + 64);
                    if (uint(this.i8) < uint(this.i6)) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i6 = 2;
                    this.i8 = li32(this.i5);
                    this.i9 = li32(this.i3);
                    this.i8 = (this.i8 - this.i9);
                    this.i8 = (this.i8 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i5);
                    this.i6 = (this.i6 + -12);
                    si32(this.i6, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_11: 
                    this.i6 = 0;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_create_as3_value_from_lua_stack.start();
                    return;
                case 24:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i8 = li32(this.i5);
                    this.i9 = li32(this.i3);
                    this.i8 = (this.i8 - this.i9);
                    this.i8 = (this.i8 / 12);
                    if (this.i8 == this.i7) goto _label_21;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i1 + 16);
                    this.i9 = li32(this.i8 + 68);
                    this.i8 = li32(this.i8 + 64);
                    this.i10 = (this.i1 + 16);
                    if (uint(this.i9) < uint(this.i8)) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_12: 
                    this.i8 = __2E_str19226;
                    this.i9 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i11 = 19;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 27:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, this.i9);
                    this.i8 = 4;
                    si32(this.i8, (this.i9 + 8));
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + 12);
                    si32(this.i8, this.i5);
                    this.i8 = li32(this.i10);
                    this.i9 = li32(this.i8 + 68);
                    this.i8 = li32(this.i8 + 64);
                    if (uint(this.i9) < uint(this.i8)) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_13: 
                    this.i8 = __2E_str1100;
                    this.i9 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i11 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 29:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, this.i9);
                    this.i8 = 4;
                    si32(this.i8, (this.i9 + 8));
                    this.i8 = li32(this.i5);
                    this.i9 = (this.i8 + 12);
                    si32(this.i9, this.i5);
                    this.i9 = 0x407DC000;
                    this.i11 = 0;
                    si32(this.i11, (this.i8 + 12));
                    si32(this.i9, (this.i8 + 16));
                    this.i9 = 3;
                    si32(this.i9, (this.i8 + 20));
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + 12);
                    si32(this.i8, this.i5);
                    this.i8 = li32(this.i10);
                    this.i9 = li32(this.i8 + 68);
                    this.i8 = li32(this.i8 + 64);
                    if (uint(this.i9) < uint(this.i8)) goto _label_14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_14: 
                    this.i8 = __2E_str2101;
                    this.i9 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i11 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 31:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, this.i9);
                    this.i8 = 4;
                    si32(this.i8, (this.i9 + 8));
                    this.i8 = li32(this.i5);
                    this.i9 = (this.i8 + 12);
                    si32(this.i9, this.i5);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i8 + 12));
                    this.i9 = 3;
                    si32(this.i9, (this.i8 + 20));
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + 12);
                    si32(this.i8, this.i5);
                    this.i8 = li32(this.i10);
                    this.i9 = li32(this.i8 + 68);
                    this.i8 = li32(this.i8 + 64);
                    if (uint(this.i9) < uint(this.i8)) goto _label_15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_15: 
                    this.i8 = __2E_str3102;
                    this.i9 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i11 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 33:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, this.i9);
                    this.i8 = 4;
                    si32(this.i8, (this.i9 + 8));
                    this.i8 = li32(this.i5);
                    this.i9 = (this.i8 + 12);
                    si32(this.i9, this.i5);
                    this.i11 = li32(this.i3);
                    this.i9 = (this.i9 - this.i11);
                    this.i9 = (this.i9 / 12);
                    this.i9 = (this.i9 + -7);
                    this.f0 = Number(this.i9);
                    sf64(this.f0, (this.i8 + 12));
                    this.i9 = 3;
                    si32(this.i9, (this.i8 + 20));
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + 12);
                    si32(this.i8, this.i5);
                    this.i8 = li32(this.i10);
                    this.i9 = li32(this.i8 + 68);
                    this.i8 = li32(this.i8 + 64);
                    if (uint(this.i9) < uint(this.i8)) goto _label_16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_16: 
                    this.i8 = __2E_str4103;
                    this.i9 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i11 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 35:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, this.i9);
                    this.i8 = 4;
                    si32(this.i8, (this.i9 + 8));
                    this.i8 = li32(this.i5);
                    this.i9 = (this.i8 + 12);
                    si32(this.i9, this.i5);
                    this.f0 = Number(this.i7);
                    sf64(this.f0, (this.i8 + 12));
                    this.i9 = 3;
                    si32(this.i9, (this.i8 + 20));
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + 12);
                    si32(this.i8, this.i5);
                    this.i8 = li32(this.i10);
                    this.i9 = li32(this.i8 + 68);
                    this.i8 = li32(this.i8 + 64);
                    if (uint(this.i9) < uint(this.i8)) goto _label_17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 36:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_17: 
                    this.i8 = __2E_str10143;
                    this.i9 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i11 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 37:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, this.i9);
                    this.i8 = 4;
                    si32(this.i8, (this.i9 + 8));
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + 12);
                    si32(this.i8, this.i5);
                    this.i8 = li32(this.i10);
                    this.i9 = li32(this.i8 + 68);
                    this.i8 = li32(this.i8 + 64);
                    if (uint(this.i9) < uint(this.i8)) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 38:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_18: 
                    this.i8 = 10;
                    this.i9 = li32(this.i5);
                    this.i11 = li32(this.i3);
                    this.i9 = (this.i9 - this.i11);
                    this.i9 = (this.i9 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = (this.i9 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 39:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + -108);
                    si32(this.i8, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 40:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = li32(this.i5);
                    this.f0 = lf64(this.i8);
                    sf64(this.f0, this.i9);
                    this.i8 = li32(this.i8 + 8);
                    si32(this.i8, (this.i9 + 8));
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + 12);
                    si32(this.i8, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 41:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = li32(this.i5);
                    this.i11 = this.i8;
                    this.i12 = (this.i8 + 12);
                    if (!(uint(this.i12) < uint(this.i9)))
                    {
                        this.i8 = this.i9;
                    }
                    else
                    {
                        this.i8 = (this.i8 + 12);
                        this.i9 = this.i11;
                        
                    _label_19: 
                        this.f0 = lf64(this.i9 + 12);
                        sf64(this.f0, this.i9);
                        this.i11 = li32(this.i9 + 20);
                        si32(this.i11, (this.i9 + 8));
                        this.i9 = li32(this.i5);
                        this.i11 = (this.i8 + 12);
                        this.i12 = this.i8;
                        if (uint(this.i11) < uint(this.i9)) goto _label_44;
                        this.i8 = this.i9;
                    };
                    this.i8 = (this.i8 + -12);
                    si32(this.i8, this.i5);
                    this.i8 = li32(this.i10);
                    this.i9 = li32(this.i8 + 68);
                    this.i8 = li32(this.i8 + 64);
                    if (uint(this.i9) < uint(this.i8)) goto _label_20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 42:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_20: 
                    this.i8 = 2;
                    this.i9 = li32(this.i5);
                    this.i10 = li32(this.i3);
                    this.i9 = (this.i9 - this.i10);
                    this.i9 = (this.i9 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = (this.i9 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 43:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + -12);
                    si32(this.i8, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 44:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_21: 
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_CallS]());
                    return;
                case 45:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i5);
                    this.i8 = li32(this.i3);
                    this.i4 = (this.i4 - this.i8);
                    this.i4 = (this.i4 + 11);
                    if (uint(this.i4) > uint(22)) goto _label_22;
                    this.i0 = __2E_str157;
                    this.i1 = __2E_str37244;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i1;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = -1;
                    si32(this.i0, public::mstate.esp);
                    state = 46;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 46:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_22: 
                    this.i4 = li32(this.i5);
                    this.i8 = li32(this.i3);
                    this.i4 = (this.i4 - this.i8);
                    this.i4 = (this.i4 / 12);
                    if (this.i4 == this.i7) goto _label_32;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 47:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i1 + 16);
                    this.i8 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    this.i9 = (this.i1 + 16);
                    if (uint(this.i8) < uint(this.i4)) goto _label_23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 48;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 48:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_23: 
                    this.i4 = __2E_str19226;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 19;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 49;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 49:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i8);
                    this.i4 = 4;
                    si32(this.i4, (this.i8 + 8));
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    this.i4 = li32(this.i9);
                    this.i8 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    if (uint(this.i8) < uint(this.i4)) goto _label_24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 50;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 50:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_24: 
                    this.i4 = __2E_str1100;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 51;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 51:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i8);
                    this.i4 = 4;
                    si32(this.i4, (this.i8 + 8));
                    this.i4 = li32(this.i5);
                    this.i8 = (this.i4 + 12);
                    si32(this.i8, this.i5);
                    this.i8 = 0x407EC000;
                    this.i10 = 0;
                    si32(this.i10, (this.i4 + 12));
                    si32(this.i8, (this.i4 + 16));
                    this.i8 = 3;
                    si32(this.i8, (this.i4 + 20));
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    this.i4 = li32(this.i9);
                    this.i8 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    if (uint(this.i8) < uint(this.i4)) goto _label_25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 52;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 52:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_25: 
                    this.i4 = __2E_str2101;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 53;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 53:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i8);
                    this.i4 = 4;
                    si32(this.i4, (this.i8 + 8));
                    this.i4 = li32(this.i5);
                    this.i8 = (this.i4 + 12);
                    si32(this.i8, this.i5);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i4 + 12));
                    this.i8 = 3;
                    si32(this.i8, (this.i4 + 20));
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    this.i4 = li32(this.i9);
                    this.i8 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    if (uint(this.i8) < uint(this.i4)) goto _label_26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 54;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 54:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_26: 
                    this.i4 = __2E_str3102;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 55;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 55:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i8);
                    this.i4 = 4;
                    si32(this.i4, (this.i8 + 8));
                    this.i4 = li32(this.i5);
                    this.i8 = (this.i4 + 12);
                    si32(this.i8, this.i5);
                    this.i10 = li32(this.i3);
                    this.i8 = (this.i8 - this.i10);
                    this.i8 = (this.i8 / 12);
                    this.i8 = (this.i8 + -7);
                    this.f0 = Number(this.i8);
                    sf64(this.f0, (this.i4 + 12));
                    this.i8 = 3;
                    si32(this.i8, (this.i4 + 20));
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    this.i4 = li32(this.i9);
                    this.i8 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    if (uint(this.i8) < uint(this.i4)) goto _label_27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 56;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 56:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_27: 
                    this.i4 = __2E_str4103;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 57;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 57:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i8);
                    this.i4 = 4;
                    si32(this.i4, (this.i8 + 8));
                    this.i4 = li32(this.i5);
                    this.i8 = (this.i4 + 12);
                    si32(this.i8, this.i5);
                    this.f0 = Number(this.i7);
                    sf64(this.f0, (this.i4 + 12));
                    this.i8 = 3;
                    si32(this.i8, (this.i4 + 20));
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    this.i4 = li32(this.i9);
                    this.i8 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    if (uint(this.i8) < uint(this.i4)) goto _label_28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 58;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 58:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_28: 
                    this.i4 = __2E_str10143;
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 59;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 59:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i8);
                    this.i4 = 4;
                    si32(this.i4, (this.i8 + 8));
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    this.i4 = li32(this.i9);
                    this.i8 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    if (uint(this.i8) < uint(this.i4)) goto _label_29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 60;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 60:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_29: 
                    this.i4 = 10;
                    this.i8 = li32(this.i5);
                    this.i10 = li32(this.i3);
                    this.i8 = (this.i8 - this.i10);
                    this.i8 = (this.i8 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 61;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 61:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + -108);
                    si32(this.i4, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 62:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i5);
                    this.f0 = lf64(this.i4);
                    sf64(this.f0, this.i8);
                    this.i4 = li32(this.i4 + 8);
                    si32(this.i4, (this.i8 + 8));
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 63:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i5);
                    this.i10 = this.i4;
                    this.i11 = (this.i4 + 12);
                    if (!(uint(this.i11) < uint(this.i8)))
                    {
                        this.i4 = this.i8;
                    }
                    else
                    {
                        this.i4 = (this.i4 + 12);
                        this.i8 = this.i10;
                        
                    _label_30: 
                        this.f0 = lf64(this.i8 + 12);
                        sf64(this.f0, this.i8);
                        this.i10 = li32(this.i8 + 20);
                        si32(this.i10, (this.i8 + 8));
                        this.i8 = li32(this.i5);
                        this.i10 = (this.i4 + 12);
                        this.i11 = this.i4;
                        if (uint(this.i10) < uint(this.i8)) goto _label_45;
                        this.i4 = this.i8;
                    };
                    this.i4 = (this.i4 + -12);
                    si32(this.i4, this.i5);
                    this.i4 = li32(this.i9);
                    this.i8 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    if (uint(this.i8) < uint(this.i4)) goto _label_31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 64;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 64:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_31: 
                    this.i4 = 2;
                    this.i8 = li32(this.i5);
                    this.i9 = li32(this.i3);
                    this.i8 = (this.i8 - this.i9);
                    this.i8 = (this.i8 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 65;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 65:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + -12);
                    si32(this.i4, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 66;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 66:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_32: 
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + -12);
                    si32(this.i4, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i6, public::mstate.esp);
                    state = 67;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 67:
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 68;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_as3_lua_userdata.start();
                    return;
                case 68:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 69;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 69:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i5);
                    this.i4 = li32(this.i3);
                    this.i0 = (this.i0 - this.i4);
                    this.i0 = (this.i0 / 12);
                    if (this.i0 == this.i7) goto _label_42;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 70;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 70:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i1 + 16);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    this.i6 = (this.i1 + 16);
                    if (uint(this.i4) < uint(this.i0)) goto _label_33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 71;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 71:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_33: 
                    this.i0 = __2E_str19226;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 19;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 72;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 72:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i6);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 73;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 73:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_34: 
                    this.i0 = __2E_str1100;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 74;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 74:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i5);
                    this.i4 = (this.i0 + 12);
                    si32(this.i4, this.i5);
                    this.i4 = 0x407F5000;
                    this.i8 = 0;
                    si32(this.i8, (this.i0 + 12));
                    si32(this.i4, (this.i0 + 16));
                    this.i4 = 3;
                    si32(this.i4, (this.i0 + 20));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i6);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 75;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 75:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_35: 
                    this.i0 = __2E_str2101;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 76;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 76:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i5);
                    this.i4 = (this.i0 + 12);
                    si32(this.i4, this.i5);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i6);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 77;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 77:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_36: 
                    this.i0 = __2E_str3102;
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 78;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 78:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i5);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i5);
                    this.i4 = li32(this.i3);
                    this.i2 = (this.i2 - this.i4);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i6);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 79;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 79:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_37: 
                    this.i0 = __2E_str4103;
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 80;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 80:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i5);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i5);
                    this.f0 = Number(this.i7);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i6);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 81;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 81:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_38: 
                    this.i0 = __2E_str10143;
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 82;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 82:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i6);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 83;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 83:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_39: 
                    this.i0 = 10;
                    this.i2 = li32(this.i5);
                    this.i4 = li32(this.i3);
                    this.i2 = (this.i2 - this.i4);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 84;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 84:
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
                case 85:
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
                case 86:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    this.i4 = this.i0;
                    this.i7 = (this.i0 + 12);
                    if (!(uint(this.i7) < uint(this.i2)))
                    {
                        this.i0 = this.i2;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i2 = this.i4;
                        
                    _label_40: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i4 = li32(this.i2 + 20);
                        si32(this.i4, (this.i2 + 8));
                        this.i2 = li32(this.i5);
                        this.i4 = (this.i0 + 12);
                        this.i7 = this.i0;
                        if (uint(this.i4) < uint(this.i2)) goto _label_46;
                        this.i0 = this.i2;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i6);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 87;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 87:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_41: 
                    this.i0 = 2;
                    this.i2 = li32(this.i5);
                    this.i3 = li32(this.i3);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 88;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 88:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 89;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 89:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_42: 
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_43: 
                    this.i6 = this.i10;
                    this.i8 = this.i11;
                    goto _label_9;
                    
                _label_44: 
                    this.i8 = this.i11;
                    this.i9 = this.i12;
                    goto _label_19;
                    
                _label_45: 
                    this.i4 = this.i10;
                    this.i8 = this.i11;
                    goto _label_30;
                    
                _label_46: 
                    this.i0 = this.i4;
                    this.i2 = this.i7;
                    goto _label_40;
                default:
                    throw ("Invalid state in _as3_call");
            };
        }


    }
} cmodule.lua_wrapper

