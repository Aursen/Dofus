package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_freestack extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_freestack;
            _local_1 = new (FSM_freestack)();
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
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(this.i1 + 16);
                    this.i4 = li32(this.i2 + 48);
                    this.i5 = li32(this.i2 + 40);
                    this.i6 = li32(this.i3 + 12);
                    this.i7 = li32(this.i3 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = (this.i4 * 24);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 1:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i5 = li32(this.i3 + 68);
                    this.i4 = (this.i5 - this.i4);
                    si32(this.i4, (this.i3 + 68));
                    this.i1 = li32(this.i1 + 16);
                    this.i3 = li32(this.i2 + 44);
                    this.i2 = li32(this.i2 + 32);
                    this.i4 = li32(this.i1 + 12);
                    this.i5 = li32(this.i1 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = (this.i3 * 12);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i4]());
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i1 + 68);
                    this.i0 = (this.i0 - this.i3);
                    si32(this.i0, (this.i1 + 68));
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _freestack");
            };
        }


    }
}

