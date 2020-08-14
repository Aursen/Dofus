package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_thunk_luaClose extends Machine 
    {

        public static const intRegCount:int = 13;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
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
            var _local_1:FSM_thunk_luaClose;
            _local_1 = new (FSM_thunk_luaClose)();
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
                    public::mstate.esp = (public::mstate.esp - 68);
                    this.i0 = __2E_str12111;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = (public::mstate.ebp + -68);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_ArrayValue]());
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(public::mstate.ebp + -68);
                    this.i0 = __2E_str13112;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = li32(this.i1 + 16);
                    this.i0 = li32(this.i0 + 104);
                    this.i1 = li32(this.i0 + 32);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_close.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_separateudata.start();
                case 3:
                    this.i1 = public::mstate.eax;
                    this.i1 = (public::mstate.ebp + -64);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = 0;
                    si32(this.i2, (this.i0 + 108));
                    this.i2 = (this.i1 + 4);
                    this.i3 = (this.i0 + 104);
                    this.i4 = (this.i1 + 52);
                    this.i5 = (this.i0 + 52);
                    this.i6 = (this.i0 + 54);
                    this.i7 = (this.i0 + 12);
                    this.i8 = (this.i0 + 8);
                    this.i9 = (this.i0 + 20);
                    this.i10 = (this.i0 + 40);
                    
                _label_1: 
                    this.i11 = 0;
                    this.i12 = li32(this.i10);
                    si32(this.i12, this.i9);
                    this.i12 = li32(this.i12);
                    si32(this.i12, this.i8);
                    si32(this.i12, this.i7);
                    si16(this.i11, this.i6);
                    si16(this.i11, this.i5);
                    si32(this.i11, this.i4);
                    this.i11 = li32(this.i3);
                    si32(this.i11, this.i1);
                    this.i11 = (public::mstate.ebp + -64);
                    si32(this.i11, this.i3);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[__setjmp]());
                    return;
                case 4:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i11 == 0)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_callallgcTM392.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i11 = li32(this.i1);
                    si32(this.i11, this.i3);
                    this.i11 = li32(this.i4);
                    if (!(this.i11 == 0)) goto _label_1;
                    this.i1 = __2E_str14113;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_close_state.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = this.i1;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _thunk_luaClose");
            };
        }


    }
} cmodule.lua_wrapper

