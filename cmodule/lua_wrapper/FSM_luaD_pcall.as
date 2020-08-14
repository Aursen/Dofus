package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaD_pcall extends Machine 
    {

        public static const intRegCount:int = 18;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
        public var f0:Number;
        public var i16:int;
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
            var _local_1:FSM_luaD_pcall;
            _local_1 = new (FSM_luaD_pcall)();
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
                    public::mstate.esp = (public::mstate.esp - 64);
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li16(this.i1 + 52);
                    this.i3 = li32(this.i1 + 20);
                    this.i4 = li32(this.i1 + 40);
                    this.i5 = li8(this.i1 + 57);
                    this.i6 = li32(this.i1 + 108);
                    this.i7 = li32(public::mstate.ebp + 24);
                    si32(this.i7, (this.i1 + 108));
                    si32(this.i0, (public::mstate.ebp + -12));
                    this.i0 = li32(this.i1 + 104);
                    this.i7 = (public::mstate.ebp + -64);
                    si32(this.i0, (public::mstate.ebp + -64));
                    si32(this.i7, (this.i1 + 104));
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = (this.i7 + 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[__setjmp]());
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i8 = (this.i1 + 104);
                    this.i9 = (this.i7 + 52);
                    this.i10 = (this.i1 + 108);
                    this.i11 = (this.i1 + 57);
                    this.i12 = (this.i1 + 40);
                    this.i13 = (this.i1 + 20);
                    this.i14 = (this.i1 + 52);
                    this.i15 = li32(public::mstate.ebp + 12);
                    this.i16 = li32(public::mstate.ebp + 16);
                    this.i17 = li32(public::mstate.ebp + 20);
                    if (!(this.i0 == 0)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i15]());
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i0 = li32(this.i7);
                    si32(this.i0, this.i8);
                    this.i0 = li32(this.i9);
                    if (this.i0 == 0) goto _label_6;
                    this.i7 = li32(this.i1 + 32);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = (this.i7 + this.i17);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_close.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = (this.i3 - this.i4);
                    this.i4 = this.i7;
                    this.i8 = (this.i0 + -2);
                    if (uint(this.i8) < uint(2)) goto _label_3;
                    if (this.i0 == 5) goto _label_2;
                    if (!(this.i0 == 4)) goto _label_4;
                    this.i8 = __2E_str111;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 17;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 4:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, this.i7);
                    this.i7 = 4;
                    si32(this.i7, (this.i4 + 8));
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (this.i1 + 8));
                    goto _label_5;
                    
                _label_2: 
                    this.i8 = __2E_str212;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 23;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 5:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, this.i7);
                    this.i7 = 4;
                    si32(this.i7, (this.i4 + 8));
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (this.i1 + 8));
                    goto _label_5;
                    
                _label_3: 
                    this.i8 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i8 + -12);
                    sf64(this.f0, this.i7);
                    this.i7 = li32(this.i8 + -4);
                    si32(this.i7, (this.i4 + 8));
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (this.i1 + 8));
                    goto _label_5;
                    
                _label_4: 
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (this.i1 + 8));
                    
                _label_5: 
                    si16(this.i2, this.i14);
                    this.i2 = li32(this.i12);
                    this.i2 = (this.i2 + this.i3);
                    si32(this.i2, this.i13);
                    this.i3 = li32(this.i2);
                    si32(this.i3, (this.i1 + 12));
                    this.i2 = li32(this.i2 + 12);
                    si32(this.i2, (this.i1 + 24));
                    si8(this.i5, this.i11);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_restore_stack_limit.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    si32(this.i6, this.i10);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaD_pcall");
            };
        }


    }
} cmodule.lua_wrapper

