package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_doFileImpl extends Machine 
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
            var _local_1:FSM_doFileImpl;
            _local_1 = new (FSM_doFileImpl)();
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
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i1 = li32(public::mstate.ebp + 12);
                    si32(this.i1, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_StringValue]());
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    this.i2 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = li32(this.i2 + 8);
                    this.i4 = li32(this.i2 + 12);
                    si32(this.i0, this.i3);
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i2 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i2 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_loadfile.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    this.i1 = (this.i3 - this.i4);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = (this.i1 / 12);
                    this.i3 = (this.i2 + 12);
                    this.i4 = (this.i2 + 8);
                    this.i5 = sxi8(li8(public::mstate.ebp + 16));
                    if (!(this.i0 == 0))
                    {
                        this.i5 = this.i0;
                        goto _label_11;
                    };
                    this.i0 = li32(this.i4);
                    this.i6 = li32(this.i3);
                    this.i0 = (this.i0 - this.i6);
                    this.i6 = (this.i1 + 2);
                    this.i0 = (this.i0 / 12);
                    if (this.i0 == this.i6) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i2 + 16);
                    this.i0 = li32(this.i5 + 68);
                    this.i5 = li32(this.i5 + 64);
                    this.i7 = (this.i2 + 16);
                    if (uint(this.i0) < uint(this.i5)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i5 = __2E_str99;
                    this.i0 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 14;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 6:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, this.i0);
                    this.i5 = 4;
                    si32(this.i5, (this.i0 + 8));
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i4);
                    this.i5 = li32(this.i7);
                    this.i0 = li32(this.i5 + 68);
                    this.i5 = li32(this.i5 + 64);
                    if (uint(this.i0) < uint(this.i5)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i5 = __2E_str1100;
                    this.i0 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 1;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 8:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, this.i0);
                    this.i5 = 4;
                    si32(this.i5, (this.i0 + 8));
                    this.i5 = li32(this.i4);
                    this.i0 = (this.i5 + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 0x4066C000;
                    this.i8 = 0;
                    si32(this.i8, (this.i5 + 12));
                    si32(this.i0, (this.i5 + 16));
                    this.i0 = 3;
                    si32(this.i0, (this.i5 + 20));
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i4);
                    this.i5 = li32(this.i7);
                    this.i0 = li32(this.i5 + 68);
                    this.i5 = li32(this.i5 + 64);
                    if (uint(this.i0) < uint(this.i5)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    this.i5 = __2E_str2101;
                    this.i0 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 38;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 10:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, this.i0);
                    this.i5 = 4;
                    si32(this.i5, (this.i0 + 8));
                    this.i5 = li32(this.i4);
                    this.i0 = (this.i5 + 12);
                    si32(this.i0, this.i4);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, (this.i5 + 12));
                    this.i1 = 3;
                    si32(this.i1, (this.i5 + 20));
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i4);
                    this.i5 = li32(this.i7);
                    this.i1 = li32(this.i5 + 68);
                    this.i5 = li32(this.i5 + 64);
                    if (uint(this.i1) < uint(this.i5)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i5 = __2E_str3102;
                    this.i1 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 16;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 12:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, this.i1);
                    this.i5 = 4;
                    si32(this.i5, (this.i1 + 8));
                    this.i5 = li32(this.i4);
                    this.i1 = (this.i5 + 12);
                    si32(this.i1, this.i4);
                    this.i0 = li32(this.i3);
                    this.i1 = (this.i1 - this.i0);
                    this.i1 = (this.i1 / 12);
                    this.i1 = (this.i1 + -7);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, (this.i5 + 12));
                    this.i1 = 3;
                    si32(this.i1, (this.i5 + 20));
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i4);
                    this.i5 = li32(this.i7);
                    this.i1 = li32(this.i5 + 68);
                    this.i5 = li32(this.i5 + 64);
                    if (uint(this.i1) < uint(this.i5)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i5 = __2E_str4103;
                    this.i1 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 18;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, this.i1);
                    this.i5 = 4;
                    si32(this.i5, (this.i1 + 8));
                    this.i5 = li32(this.i4);
                    this.i1 = (this.i5 + 12);
                    si32(this.i1, this.i4);
                    this.f0 = Number(this.i6);
                    sf64(this.f0, (this.i5 + 12));
                    this.i1 = 3;
                    si32(this.i1, (this.i5 + 20));
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i4);
                    this.i5 = li32(this.i7);
                    this.i1 = li32(this.i5 + 68);
                    this.i5 = li32(this.i5 + 64);
                    if (uint(this.i1) < uint(this.i5)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i5 = __2E_str10143;
                    this.i1 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 1;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 16:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, this.i1);
                    this.i5 = 4;
                    si32(this.i5, (this.i1 + 8));
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i4);
                    this.i5 = li32(this.i7);
                    this.i1 = li32(this.i5 + 68);
                    this.i5 = li32(this.i5 + 64);
                    if (uint(this.i1) < uint(this.i5)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i5 = 10;
                    this.i1 = li32(this.i4);
                    this.i0 = li32(this.i3);
                    this.i1 = (this.i1 - this.i0);
                    this.i1 = (this.i1 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 + -1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + -108);
                    si32(this.i5, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = -2;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 19:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i4);
                    this.f0 = lf64(this.i5);
                    sf64(this.f0, this.i1);
                    this.i5 = li32(this.i5 + 8);
                    si32(this.i5, (this.i1 + 8));
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = -3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 20:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i4);
                    this.i0 = this.i5;
                    this.i6 = (this.i5 + 12);
                    if (!(uint(this.i6) < uint(this.i1)))
                    {
                        this.i5 = this.i1;
                    }
                    else
                    {
                        this.i5 = (this.i5 + 12);
                        this.i1 = this.i0;
                        
                    _label_8: 
                        this.f0 = lf64(this.i1 + 12);
                        sf64(this.f0, this.i1);
                        this.i0 = li32(this.i1 + 20);
                        si32(this.i0, (this.i1 + 8));
                        this.i1 = li32(this.i4);
                        this.i0 = (this.i5 + 12);
                        this.i6 = this.i5;
                        if (uint(this.i0) < uint(this.i1)) goto _label_15;
                        this.i5 = this.i1;
                    };
                    this.i5 = (this.i5 + -12);
                    si32(this.i5, this.i4);
                    this.i5 = li32(this.i7);
                    this.i1 = li32(this.i5 + 68);
                    this.i5 = li32(this.i5 + 64);
                    if (uint(this.i1) < uint(this.i5)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i5 = 2;
                    this.i1 = li32(this.i4);
                    this.i3 = li32(this.i3);
                    this.i1 = (this.i1 - this.i3);
                    this.i1 = (this.i1 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 + -1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + -12);
                    si32(this.i5, this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 0;
                    this.i1 = -1;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 23:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i4);
                    this.i2 = __2E_str157;
                    this.i0 = this.i2;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i5;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_do_pcall_with_traceback.start();
                    return;
                case 25:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_11: 
                    this.i0 = this.i5;
                    if (this.i0 == 0) goto _label_12;
                    this.i0 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 26:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i4);
                    this.f0 = lf64(this.i5);
                    sf64(this.f0, this.i6);
                    this.i5 = li32(this.i5 + 8);
                    si32(this.i5, (this.i6 + 8));
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 0;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 27:
                    this.i0 = public::mstate.eax;
                    this.i6 = __2E_str6105;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = __2E_str7106;
                    this.i6 = ((this.i0 == 0) ? this.i6 : this.i0);
                    this.i0 = this.i7;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i6;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = li32(this.i4);
                    this.i6 = (this.i0 + -12);
                    si32(this.i6, this.i4);
                    si32(this.i5, (this.i0 + -12));
                    this.i5 = 1;
                    si32(this.i5, (this.i0 + -4));
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_replace.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_12: 
                    this.i0 = 0;
                    this.i5 = li32(this.i4);
                    this.i6 = li32(this.i3);
                    this.i5 = (this.i5 - this.i6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (this.i1 + 1);
                    this.i5 = (this.i5 / 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_create_as3_value_from_lua_stack.start();
                    return;
                case 29:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i4);
                    this.i5 = li32(this.i3);
                    this.i6 = (this.i2 - this.i5);
                    this.i1 = (this.i1 + -1);
                    this.i6 = (this.i6 / 12);
                    this.i1 = (this.i1 - this.i6);
                    if (!(this.i1 < 0))
                    {
                        this.i6 = (this.i1 * 12);
                        this.i6 = (this.i5 + this.i6);
                        if (!(uint(this.i2) < uint(this.i6)))
                        {
                            this.i2 = this.i5;
                            goto _label_14;
                        };
                        
                    _label_13: 
                        this.i5 = 0;
                        si32(this.i5, (this.i2 + 8));
                        this.i2 = (this.i2 + 12);
                        si32(this.i2, this.i4);
                        this.i5 = li32(this.i3);
                        this.i6 = (this.i1 * 12);
                        this.i6 = (this.i5 + this.i6);
                        if (uint(this.i2) < uint(this.i6)) goto _label_13;
                        this.i2 = this.i5;
                        
                    _label_14: 
                        this.i1 = (this.i1 * 12);
                        this.i1 = (this.i2 + this.i1);
                    }
                    else
                    {
                        this.i1 = (this.i1 * 12);
                        this.i1 = (this.i1 + this.i2);
                        this.i1 = (this.i1 + 12);
                    };
                    si32(this.i1, this.i4);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_15: 
                    this.i5 = this.i0;
                    this.i1 = this.i6;
                    goto _label_8;
                default:
                    throw ("Invalid state in _doFileImpl");
            };
        }


    }
} cmodule.lua_wrapper

