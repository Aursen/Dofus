package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_close_state extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_close_state;
            _local_1 = new (FSM_close_state)();
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
                    this.i0 = 67;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 16);
                    this.i3 = li32(this.i1 + 32);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_close.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 16);
                    si8(this.i0, (this.i3 + 20));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = -3;
                    this.i4 = (this.i3 + 28);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sweeplist.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i3 + 8);
                    this.i4 = (this.i3 + 8);
                    this.i5 = (this.i1 + 32);
                    this.i6 = (this.i1 + 16);
                    if (this.i0 < 1) goto _label_2;
                    this.i0 = 0;
                    this.i7 = this.i0;
                    
                _label_1: 
                    this.i8 = -3;
                    this.i9 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = (this.i9 + this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sweeplist.start();
                    return;
                case 3:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = li32(this.i4);
                    this.i7 = (this.i7 + 4);
                    this.i0 = (this.i0 + 1);
                    if (!(this.i8 <= this.i0)) goto _label_1;
                    
                _label_2: 
                    this.i0 = 0;
                    this.i3 = li32(this.i6);
                    this.i4 = li32(this.i3 + 8);
                    this.i7 = li32(this.i3);
                    this.i8 = li32(this.i3 + 12);
                    this.i9 = li32(this.i3 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = (this.i4 << 2);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 4:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i7 = li32(this.i3 + 68);
                    this.i4 = (this.i7 - this.i4);
                    si32(this.i4, (this.i3 + 68));
                    this.i3 = li32(this.i6);
                    this.i4 = li32(this.i2 + 60);
                    this.i7 = li32(this.i2 + 52);
                    this.i8 = li32(this.i3 + 12);
                    this.i9 = li32(this.i3 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 5:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i8 = li32(this.i3 + 68);
                    this.i4 = (this.i8 - this.i4);
                    si32(this.i4, (this.i3 + 68));
                    si32(this.i7, (this.i2 + 52));
                    si32(this.i0, (this.i2 + 60));
                    this.i3 = li32(this.i6);
                    this.i4 = li32(this.i1 + 48);
                    this.i7 = li32(this.i1 + 40);
                    this.i8 = li32(this.i3 + 12);
                    this.i9 = li32(this.i3 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = (this.i4 * 24);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 6:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i7 = li32(this.i3 + 68);
                    this.i4 = (this.i7 - this.i4);
                    si32(this.i4, (this.i3 + 68));
                    this.i3 = li32(this.i6);
                    this.i4 = li32(this.i1 + 44);
                    this.i5 = li32(this.i5);
                    this.i6 = li32(this.i3 + 12);
                    this.i7 = li32(this.i3 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = (this.i4 * 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 7:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i5 = li32(this.i3 + 68);
                    this.i4 = (this.i5 - this.i4);
                    si32(this.i4, (this.i3 + 68));
                    this.i3 = li32(this.i2 + 12);
                    this.i2 = li32(this.i2 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = 348;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i3]());
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _close_state");
            };
        }


    }
} cmodule.lua_wrapper

