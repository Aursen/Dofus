package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_as3_newclass2 extends Machine 
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
            var _local_1:FSM_as3_newclass2;
            _local_1 = new (FSM_as3_newclass2)();
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
                    this.i0 = 1;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = (this.i2 - this.i3);
                    this.i3 = li32(this.i0 + 8);
                    this.i2 = (this.i2 / 12);
                    this.i4 = (this.i1 + 12);
                    this.i5 = (this.i1 + 8);
                    if (this.i3 == 0) goto _label_1;
                    if (!(!(this.i3 == 1)))
                    {
                        this.i0 = li32(this.i0);
                        if (this.i0 == 0) goto _label_1;
                    };
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li8(this.i0);
                    if ((this.i3 == 0))
                    {
                        
                    _label_1: 
                        this.i0 = 0;
                    };
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i6 = 0;
                        goto _label_2;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_String]());
                    return;
                case 4:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_NSGetS]());
                    return;
                case 5:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i6 == 0) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i6, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    if (!(this.i7 == 0)) goto _label_4;
                    this.i2 = 0;
                    this.i4 = li32(this.i5);
                    si32(this.i2, (this.i4 + 8));
                    this.i2 = li32(this.i5);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = __2E_str27234;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 7:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = 2;
                    public::mstate.eax = this.i1;
                    goto _label_15;
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_as3_lua_userdata.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i7, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i5);
                    this.i3 = li32(this.i4);
                    this.i6 = (this.i2 + 1);
                    this.i0 = (this.i0 - this.i3);
                    this.i0 = (this.i0 / 12);
                    if (this.i0 == this.i6) goto _label_14;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i1 + 16);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    this.i7 = (this.i1 + 16);
                    if (uint(this.i3) < uint(this.i0)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i0 = __2E_str19226;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 19;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
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
                    if (uint(this.i3) < uint(this.i0)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i0 = __2E_str1100;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i5);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i5);
                    this.i3 = 0x40608000;
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
                    if (uint(this.i3) < uint(this.i0)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i0 = __2E_str2101;
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 16:
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
                    if (uint(this.i2) < uint(this.i0)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i0 = __2E_str3102;
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 18:
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
                    if (uint(this.i2) < uint(this.i0)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i0 = __2E_str4103;
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 20:
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
                    if (uint(this.i2) < uint(this.i0)) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i0 = __2E_str10143;
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 22:
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
                    if (uint(this.i2) < uint(this.i0)) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_11: 
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
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 24:
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
                case 25:
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
                case 26:
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
                        
                    _label_12: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i3 = li32(this.i2 + 20);
                        si32(this.i3, (this.i2 + 8));
                        this.i2 = li32(this.i5);
                        this.i3 = (this.i0 + 12);
                        this.i6 = this.i0;
                        if (uint(this.i3) < uint(this.i2)) goto _label_16;
                        this.i0 = this.i2;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_13: 
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
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_14: 
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    
                _label_15: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_16: 
                    this.i0 = this.i3;
                    this.i2 = this.i6;
                    goto _label_12;
                default:
                    throw ("Invalid state in _as3_newclass2");
            };
        }


    }
}

