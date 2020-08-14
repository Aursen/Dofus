package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaDoStringImpl extends Machine 
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
            var _local_1:FSM_luaDoStringImpl;
            _local_1 = new (FSM_luaDoStringImpl)();
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
                    public::mstate.esp = (public::mstate.esp - 72);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i0 = li32(this.i1 + 8);
                    this.i2 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i3 = li32(public::mstate.ebp + 12);
                    si32(this.i3, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_StringValue]());
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = (this.i0 - this.i2);
                    this.i2 = li8(this.i3);
                    this.i4 = (this.i0 / 12);
                    this.i5 = (this.i1 + 12);
                    this.i6 = (this.i1 + 8);
                    this.i0 = sxi8(li8(public::mstate.ebp + 16));
                    this.i7 = this.i3;
                    if (this.i2 == 0) goto _label_16;
                    this.i2 = this.i7;
                    do 
                    {
                        this.i8 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i9 = this.i2;
                        if (this.i8 == 0) goto _label_17;
                        this.i2 = this.i9;
                    } while (true);
                    
                _label_1: 
                    this.i3 = li32(this.i6);
                    this.i7 = li32(this.i5);
                    this.i3 = (this.i3 - this.i7);
                    this.i7 = (this.i4 + 2);
                    this.i3 = (this.i3 / 12);
                    if (this.i3 == this.i7) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i2);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i0 = __2E_str99;
                    this.i3 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 14;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i2);
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
                    this.i0 = __2E_str1100;
                    this.i3 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 1;
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
                    this.i0 = li32(this.i6);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i6);
                    this.i3 = 0x40700000;
                    this.i8 = 0;
                    si32(this.i8, (this.i0 + 12));
                    si32(this.i3, (this.i0 + 16));
                    this.i3 = 3;
                    si32(this.i3, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i2);
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
                    this.i0 = __2E_str2101;
                    this.i3 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 38;
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
                    this.i0 = li32(this.i6);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i6);
                    this.f0 = Number(this.i4);
                    sf64(this.f0, (this.i0 + 12));
                    this.i4 = 3;
                    si32(this.i4, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i2);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i0 = __2E_str3102;
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 10:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i6);
                    this.i4 = (this.i0 + 12);
                    si32(this.i4, this.i6);
                    this.i3 = li32(this.i5);
                    this.i4 = (this.i4 - this.i3);
                    this.i4 = (this.i4 / 12);
                    this.i4 = (this.i4 + -7);
                    this.f0 = Number(this.i4);
                    sf64(this.f0, (this.i0 + 12));
                    this.i4 = 3;
                    si32(this.i4, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i2);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i0 = __2E_str4103;
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i6);
                    this.i4 = (this.i0 + 12);
                    si32(this.i4, this.i6);
                    this.f0 = Number(this.i7);
                    sf64(this.f0, (this.i0 + 12));
                    this.i4 = 3;
                    si32(this.i4, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i2);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i0 = __2E_str10143;
                    this.i4 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i2);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i0 = 10;
                    this.i4 = li32(this.i6);
                    this.i3 = li32(this.i5);
                    this.i4 = (this.i4 - this.i3);
                    this.i4 = (this.i4 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 16:
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
                case 17:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i6);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i4);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 18:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i6);
                    this.i3 = this.i0;
                    this.i7 = (this.i0 + 12);
                    if (!(uint(this.i7) < uint(this.i4)))
                    {
                        this.i0 = this.i4;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i4 = this.i3;
                        
                    _label_9: 
                        this.f0 = lf64(this.i4 + 12);
                        sf64(this.f0, this.i4);
                        this.i3 = li32(this.i4 + 20);
                        si32(this.i3, (this.i4 + 8));
                        this.i4 = li32(this.i6);
                        this.i3 = (this.i0 + 12);
                        this.i7 = this.i0;
                        if (uint(this.i3) < uint(this.i4)) goto _label_18;
                        this.i0 = this.i4;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i2);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i0 = 2;
                    this.i4 = li32(this.i6);
                    this.i5 = li32(this.i5);
                    this.i4 = (this.i4 - this.i5);
                    this.i4 = (this.i4 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 0;
                    this.i4 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 21:
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
                    si32(this.i4, public::mstate.esp);
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_11: 
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_do_pcall_with_traceback.start();
                    return;
                case 23:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_12: 
                    if (this.i0 == 0) goto _label_13;
                    this.i0 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 24:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i6);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i3);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i6);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 25:
                    this.i0 = public::mstate.eax;
                    this.i3 = __2E_str6105;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = __2E_str7106;
                    this.i3 = ((this.i0 == 0) ? this.i3 : this.i0);
                    this.i0 = this.i7;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i3;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = li32(this.i6);
                    this.i3 = (this.i0 + -12);
                    si32(this.i3, this.i6);
                    si32(this.i2, (this.i0 + -12));
                    this.i2 = 1;
                    si32(this.i2, (this.i0 + -4));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_replace.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_13: 
                    this.i0 = 0;
                    this.i2 = li32(this.i6);
                    this.i3 = li32(this.i5);
                    this.i2 = (this.i2 - this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = (this.i4 + 1);
                    this.i2 = (this.i2 / 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_create_as3_value_from_lua_stack.start();
                    return;
                case 27:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i6);
                    this.i2 = li32(this.i5);
                    this.i3 = (this.i1 - this.i2);
                    this.i4 = (this.i4 + -1);
                    this.i3 = (this.i3 / 12);
                    this.i3 = (this.i4 - this.i3);
                    if (!(this.i3 < 0))
                    {
                        this.i4 = (this.i3 * 12);
                        this.i4 = (this.i2 + this.i4);
                        if (!(uint(this.i1) < uint(this.i4)))
                        {
                            this.i1 = this.i2;
                            goto _label_15;
                        };
                        
                    _label_14: 
                        this.i2 = 0;
                        si32(this.i2, (this.i1 + 8));
                        this.i1 = (this.i1 + 12);
                        si32(this.i1, this.i6);
                        this.i2 = li32(this.i5);
                        this.i4 = (this.i3 * 12);
                        this.i4 = (this.i2 + this.i4);
                        if (uint(this.i1) < uint(this.i4)) goto _label_14;
                        this.i1 = this.i2;
                        
                    _label_15: 
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
                    
                _label_16: 
                    this.i2 = this.i3;
                    
                _label_17: 
                    this.i8 = 1;
                    this.i9 = li32(this.i6);
                    si32(this.i8, this.i9);
                    si32(this.i8, (this.i9 + 8));
                    this.i8 = li32(this.i6);
                    this.i8 = (this.i8 + 12);
                    si32(this.i8, this.i6);
                    si32(this.i3, (public::mstate.ebp + -72));
                    this.i2 = (this.i2 - this.i7);
                    si32(this.i2, (public::mstate.ebp + -68));
                    si32(this.i1, (public::mstate.ebp + -48));
                    this.i2 = _getS;
                    si32(this.i2, (public::mstate.ebp + -56));
                    this.i2 = (public::mstate.ebp + -72);
                    si32(this.i2, (public::mstate.ebp + -52));
                    this.i2 = 0;
                    si32(this.i2, (public::mstate.ebp + -64));
                    si32(this.i2, (public::mstate.ebp + -60));
                    this.i7 = (public::mstate.ebp + -64);
                    si32(this.i7, (public::mstate.ebp + -32));
                    this.i7 = __2E_str18117;
                    si32(this.i7, (public::mstate.ebp + -16));
                    si32(this.i2, (public::mstate.ebp + -28));
                    si32(this.i2, (public::mstate.ebp + -20));
                    this.i7 = li32(this.i1 + 32);
                    this.i9 = li32(this.i1 + 108);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i10 = _f_parser;
                    this.i7 = (this.i8 - this.i7);
                    this.i8 = (public::mstate.ebp + -32);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    si32(this.i9, (public::mstate.esp + 16));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_pcall.start();
                    return;
                case 28:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i8 = li32(this.i1 + 16);
                    this.i9 = li32(public::mstate.ebp + -20);
                    this.i10 = li32(public::mstate.ebp + -28);
                    this.i11 = li32(this.i8 + 12);
                    this.i12 = li32(this.i8 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 29:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i10 = li32(this.i8 + 68);
                    this.i9 = (this.i10 - this.i9);
                    si32(this.i9, (this.i8 + 68));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 30:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = (this.i1 + 16);
                    if (this.i7 == 0) goto _label_1;
                    this.i0 = this.i7;
                    goto _label_12;
                    
                _label_18: 
                    this.i0 = this.i3;
                    this.i4 = this.i7;
                    goto _label_9;
                default:
                    throw ("Invalid state in _luaDoStringImpl");
            };
        }


    }
} cmodule.lua_wrapper

