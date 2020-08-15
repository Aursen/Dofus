package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_stack_init extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;


        public static function start():void
        {
            var _local_1:FSM_stack_init;
            _local_1 = new (FSM_stack_init)();
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
                    this.i0 = 192;
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(this.i1 + 16);
                    this.i3 = li32(this.i2 + 12);
                    this.i4 = li32(this.i2 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = 0;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i3]());
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = (this.i1 + 16);
                    this.i4 = li32(public::mstate.ebp + 8);
                    if (!(this.i0 == 0)) goto _label_1;
                    this.i5 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i5 = 8;
                    this.i6 = li32(this.i2 + 68);
                    this.i6 = (this.i6 + 192);
                    si32(this.i6, (this.i2 + 68));
                    si32(this.i0, (this.i4 + 40));
                    si32(this.i0, (this.i4 + 20));
                    si32(this.i5, (this.i4 + 48));
                    this.i0 = (this.i0 + 168);
                    si32(this.i0, (this.i4 + 36));
                    this.i0 = li32(this.i3);
                    this.i2 = li32(this.i0 + 12);
                    this.i3 = li32(this.i0 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = 0;
                    this.i6 = 540;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i2]());
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = (this.i4 + 20);
                    if (!(this.i2 == 0)) goto _label_2;
                    this.i5 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i1 = 45;
                    this.i5 = li32(this.i0 + 68);
                    this.i5 = (this.i5 + 540);
                    si32(this.i5, (this.i0 + 68));
                    si32(this.i2, (this.i4 + 32));
                    si32(this.i1, (this.i4 + 44));
                    si32(this.i2, (this.i4 + 8));
                    this.i0 = (this.i2 + 468);
                    si32(this.i0, (this.i4 + 28));
                    this.i0 = li32(this.i3);
                    si32(this.i2, (this.i0 + 4));
                    this.i0 = li32(this.i4 + 8);
                    this.i1 = 0;
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i4 + 8));
                    this.i1 = li32(this.i3);
                    si32(this.i0, this.i1);
                    si32(this.i0, (this.i4 + 12));
                    this.i0 = li32(this.i4 + 8);
                    this.i1 = li32(this.i3);
                    this.i0 = (this.i0 + 240);
                    si32(this.i0, (this.i1 + 8));
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _stack_init");
            };
        }


    }
}

