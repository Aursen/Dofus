package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_thunk_callGlobal extends Machine 
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
            var _local_1:FSM_thunk_callGlobal;
            _local_1 = new (FSM_thunk_callGlobal)();
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
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = __2E_str16115;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = (public::mstate.ebp + -12);
                    this.i3 = (public::mstate.ebp + -8);
                    this.i4 = (public::mstate.ebp + -4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_ArrayValue]());
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = li32(public::mstate.ebp + -4);
                    this.i0 = li32(public::mstate.ebp + -12);
                    this.i2 = li32(public::mstate.ebp + -8);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_StringValue]());
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = (this.i3 - this.i4);
                    this.i4 = li8(this.i2);
                    this.i3 = (this.i3 / 12);
                    this.i5 = (this.i1 + 12);
                    this.i6 = (this.i1 + 8);
                    this.i7 = this.i2;
                    if (this.i4 == 0) goto _label_37;
                    this.i4 = this.i7;
                    do 
                    {
                        this.i8 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i9 = this.i4;
                        if (this.i8 == 0) goto _label_38;
                        this.i4 = this.i9;
                    } while (true);
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i10);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i0 = __2E_str2144;
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    this.i0 = __2E_str1100;
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i6);
                    this.i4 = (this.i0 + 12);
                    si32(this.i4, this.i6);
                    this.i4 = 0x404A0000;
                    this.i7 = 0;
                    si32(this.i7, (this.i0 + 12));
                    si32(this.i4, (this.i0 + 16));
                    this.i4 = 3;
                    si32(this.i4, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i0 = __2E_str2101;
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i6);
                    this.i4 = (this.i0 + 12);
                    si32(this.i4, this.i6);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i0 = __2E_str3102;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i6);
                    this.i4 = li32(this.i5);
                    this.i2 = (this.i2 - this.i4);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f1 = Number(this.i2);
                    sf64(this.f1, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i0 = __2E_str4103;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 13:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i6);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i0 = __2E_str10143;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
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
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i0 = 10;
                    this.i2 = li32(this.i6);
                    this.i4 = li32(this.i5);
                    this.i2 = (this.i2 - this.i4);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -108);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 18:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 19:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6);
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
                        
                    _label_9: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i4 = li32(this.i2 + 20);
                        si32(this.i4, (this.i2 + 8));
                        this.i2 = li32(this.i6);
                        this.i4 = (this.i0 + 12);
                        this.i7 = this.i0;
                        if (uint(this.i4) < uint(this.i2)) goto _label_40;
                        this.i0 = this.i2;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i0 = 2;
                    this.i2 = li32(this.i6);
                    this.i4 = li32(this.i5);
                    this.i2 = (this.i2 - this.i4);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = 0;
                    goto _label_23;
                    
                _label_11: 
                    this.i4 = __2E_str8150;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_GetS]());
                    return;
                case 23:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_IntValue]());
                    return;
                case 24:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i7 < 1) goto _label_13;
                    this.i4 = 0;
                    
                _label_12: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Int]());
                    return;
                case 26:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Get]());
                    return;
                case 27:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i8, public::mstate.esp);
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_as3_to_lua_stack.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i9, public::mstate.esp);
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i4 = (this.i4 + 1);
                    if (!(this.i4 == this.i7)) goto _label_12;
                    
                _label_13: 
                    this.i0 = li32(this.i6);
                    this.i4 = li32(this.i5);
                    this.i0 = (this.i0 - this.i4);
                    this.i4 = (this.i7 + this.i2);
                    this.i0 = (this.i0 / 12);
                    if (!(!(this.i0 == this.i4)))
                    {
                        this.i0 = this.i7;
                        goto _label_23;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i10);
                    this.i8 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i8) < uint(this.i0)) goto _label_14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_14: 
                    this.i0 = __2E_str2144;
                    this.i8 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 33:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i8);
                    this.i0 = 4;
                    si32(this.i0, (this.i8 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i8 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i8) < uint(this.i0)) goto _label_15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_15: 
                    this.i0 = __2E_str1100;
                    this.i8 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 35:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i8);
                    this.i0 = 4;
                    si32(this.i0, (this.i8 + 8));
                    this.i0 = li32(this.i6);
                    this.i8 = (this.i0 + 12);
                    si32(this.i8, this.i6);
                    this.i8 = 0x40510000;
                    this.i9 = 0;
                    si32(this.i9, (this.i0 + 12));
                    si32(this.i8, (this.i0 + 16));
                    this.i8 = 3;
                    si32(this.i8, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i8 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i8) < uint(this.i0)) goto _label_16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 36:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_16: 
                    this.i0 = __2E_str2101;
                    this.i8 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 37:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i8);
                    this.i0 = 4;
                    si32(this.i0, (this.i8 + 8));
                    this.i0 = li32(this.i6);
                    this.i8 = (this.i0 + 12);
                    si32(this.i8, this.i6);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 38:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_17: 
                    this.i0 = __2E_str3102;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 39:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i6);
                    this.i8 = li32(this.i5);
                    this.i2 = (this.i2 - this.i8);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 40:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_18: 
                    this.i0 = __2E_str4103;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 41:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i6);
                    this.f0 = Number(this.i4);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 42:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_19: 
                    this.i0 = __2E_str10143;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 43:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 44:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_20: 
                    this.i0 = 10;
                    this.i2 = li32(this.i6);
                    this.i4 = li32(this.i5);
                    this.i2 = (this.i2 - this.i4);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 45:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -108);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 46:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 47:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6);
                    this.i4 = this.i0;
                    this.i8 = (this.i0 + 12);
                    if (!(uint(this.i8) < uint(this.i2)))
                    {
                        this.i0 = this.i2;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i2 = this.i4;
                        
                    _label_21: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i4 = li32(this.i2 + 20);
                        si32(this.i4, (this.i2 + 8));
                        this.i2 = li32(this.i6);
                        this.i4 = (this.i0 + 12);
                        this.i8 = this.i0;
                        if (uint(this.i4) < uint(this.i2)) goto _label_41;
                        this.i0 = this.i2;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 48;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 48:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_22: 
                    this.i0 = 2;
                    this.i2 = li32(this.i6);
                    this.i4 = li32(this.i5);
                    this.i2 = (this.i2 - this.i4);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 49;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 49:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 50;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 50:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = this.i7;
                    
                _label_23: 
                    this.i2 = (this.i3 + this.i0);
                    this.i4 = li32(this.i6);
                    this.i7 = li32(this.i5);
                    this.i4 = (this.i4 - this.i7);
                    this.i2 = (this.i2 + 2);
                    this.i4 = (this.i4 / 12);
                    if (this.i4 == this.i2) goto _label_33;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 51;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 51:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i10);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 52;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 52:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_24: 
                    this.i0 = __2E_str99;
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 14;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 53;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 53:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 54;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 54:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_25: 
                    this.i0 = __2E_str1100;
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 55;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 55:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i6);
                    this.i4 = (this.i0 + 12);
                    si32(this.i4, this.i6);
                    this.i4 = 0x40761000;
                    this.i7 = 0;
                    si32(this.i7, (this.i0 + 12));
                    si32(this.i4, (this.i0 + 16));
                    this.i4 = 3;
                    si32(this.i4, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 56;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 56:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_26: 
                    this.i0 = __2E_str2101;
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 57;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 57:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i6);
                    this.i4 = (this.i0 + 12);
                    si32(this.i4, this.i6);
                    this.f0 = Number(this.i3);
                    sf64(this.f0, (this.i0 + 12));
                    this.i3 = 3;
                    si32(this.i3, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 58;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 58:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_27: 
                    this.i0 = __2E_str3102;
                    this.i3 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 59;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 59:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i6);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i6);
                    this.i4 = li32(this.i5);
                    this.i3 = (this.i3 - this.i4);
                    this.i3 = (this.i3 / 12);
                    this.i3 = (this.i3 + -7);
                    this.f0 = Number(this.i3);
                    sf64(this.f0, (this.i0 + 12));
                    this.i3 = 3;
                    si32(this.i3, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 60;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 60:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_28: 
                    this.i0 = __2E_str4103;
                    this.i3 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 61;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 61:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i6);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i6);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i3 = 3;
                    si32(this.i3, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 62;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 62:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_29: 
                    this.i0 = __2E_str10143;
                    this.i3 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 63;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 63:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 64;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 64:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_30: 
                    this.i0 = 10;
                    this.i3 = li32(this.i6);
                    this.i2 = li32(this.i5);
                    this.i3 = (this.i3 - this.i2);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 65;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 65:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -108);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 66:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i6);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i3);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 67:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i6);
                    this.i2 = this.i0;
                    this.i4 = (this.i0 + 12);
                    if (!(uint(this.i4) < uint(this.i3)))
                    {
                        this.i0 = this.i3;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i3 = this.i2;
                        
                    _label_31: 
                        this.f0 = lf64(this.i3 + 12);
                        sf64(this.f0, this.i3);
                        this.i2 = li32(this.i3 + 20);
                        si32(this.i2, (this.i3 + 8));
                        this.i3 = li32(this.i6);
                        this.i2 = (this.i0 + 12);
                        this.i4 = this.i0;
                        if (uint(this.i2) < uint(this.i3)) goto _label_42;
                        this.i0 = this.i3;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i10);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 68;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 68:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_32: 
                    this.i0 = 2;
                    this.i3 = li32(this.i6);
                    this.i5 = li32(this.i5);
                    this.i3 = (this.i3 - this.i5);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 69;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 69:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 0;
                    this.i3 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 70;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 70:
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
                    si32(this.i3, public::mstate.esp);
                    state = 71;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 71:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_33: 
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 72;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_do_pcall_with_traceback.start();
                    return;
                case 72:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i0 == 0) goto _label_34;
                    this.i0 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 73:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i6);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i4);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i4 + 8));
                    this.i2 = li32(this.i6);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 74;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 74:
                    this.i0 = public::mstate.eax;
                    this.i4 = __2E_str6105;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = __2E_str7106;
                    this.i4 = ((this.i0 == 0) ? this.i4 : this.i0);
                    this.i0 = this.i7;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i4;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = li32(this.i6);
                    this.i4 = (this.i0 + -12);
                    si32(this.i4, this.i6);
                    si32(this.i2, (this.i0 + -12));
                    this.i2 = 1;
                    si32(this.i2, (this.i0 + -4));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 75;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_replace.start();
                    return;
                case 75:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_34: 
                    this.i0 = 0;
                    this.i2 = li32(this.i6);
                    this.i4 = li32(this.i5);
                    this.i2 = (this.i2 - this.i4);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = (this.i3 + 1);
                    this.i2 = (this.i2 / 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 76;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_create_as3_value_from_lua_stack.start();
                    return;
                case 76:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i6);
                    this.i2 = li32(this.i5);
                    this.i4 = (this.i1 - this.i2);
                    this.i3 = (this.i3 + -1);
                    this.i4 = (this.i4 / 12);
                    this.i3 = (this.i3 - this.i4);
                    if (!(this.i3 < 0))
                    {
                        this.i4 = (this.i3 * 12);
                        this.i4 = (this.i2 + this.i4);
                        if (!(uint(this.i1) < uint(this.i4)))
                        {
                            this.i1 = this.i2;
                            goto _label_36;
                        };
                        
                    _label_35: 
                        this.i2 = 0;
                        si32(this.i2, (this.i1 + 8));
                        this.i1 = (this.i1 + 12);
                        si32(this.i1, this.i6);
                        this.i2 = li32(this.i5);
                        this.i4 = (this.i3 * 12);
                        this.i4 = (this.i2 + this.i4);
                        if (uint(this.i1) < uint(this.i4)) goto _label_35;
                        this.i1 = this.i2;
                        
                    _label_36: 
                        this.i3 = (this.i3 * 12);
                        this.i1 = (this.i1 + this.i3);
                    }
                    else
                    {
                        this.i2 = (this.i3 * 12);
                        this.i1 = (this.i2 + this.i1);
                        this.i1 = (this.i1 + 12);
                    };
                    si32(this.i1, this.i6);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_37: 
                    this.i4 = this.i2;
                    
                _label_38: 
                    this.i8 = 1;
                    this.i9 = li32(this.i6);
                    si32(this.i8, this.i9);
                    si32(this.i8, (this.i9 + 8));
                    this.i8 = li32(this.i6);
                    this.i8 = (this.i8 + 12);
                    si32(this.i8, this.i6);
                    this.i8 = li32(this.i1 + 16);
                    this.i9 = li32(this.i8 + 68);
                    this.i8 = li32(this.i8 + 64);
                    this.i10 = (this.i1 + 16);
                    this.i4 = (this.i4 - this.i7);
                    if (uint(this.i9) < uint(this.i8)) goto _label_39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 77;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 77:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_39: 
                    this.i7 = 4;
                    this.i8 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 78;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 78:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i8);
                    si32(this.i7, (this.i8 + 8));
                    this.i4 = li32(this.i6);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = 0;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 79;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 79:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -10002;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 80:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = (this.i4 + -12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 81;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 81:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i6);
                    this.i4 = li32(this.i5);
                    this.i7 = li32(_Array_class);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 82;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_InstanceOf]());
                    return;
                case 82:
                    this.i7 = public::mstate.eax;
                    this.i2 = (this.i2 - this.i4);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = (this.i2 / 12);
                    if (!(this.i7 == 0)) goto _label_11;
                    this.i0 = li32(this.i6);
                    this.i4 = li32(this.i5);
                    this.i0 = (this.i0 - this.i4);
                    this.i0 = (this.i0 / 12);
                    if (!(this.i0 == this.i2)) goto _label_1;
                    this.i0 = 0;
                    goto _label_23;
                    
                _label_40: 
                    this.i0 = this.i4;
                    this.i2 = this.i7;
                    goto _label_9;
                    
                _label_41: 
                    this.i0 = this.i4;
                    this.i2 = this.i8;
                    goto _label_21;
                    
                _label_42: 
                    this.i0 = this.i2;
                    this.i3 = this.i4;
                    goto _label_31;
                default:
                    throw ("Invalid state in _thunk_callGlobal");
            };
        }


    }
}

