package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_restore_stack_limit extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 0;

        public var i10:int;
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
            var _local_1:FSM_restore_stack_limit;
            _local_1 = new (FSM_restore_stack_limit)();
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
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 48);
                    this.i2 = (this.i0 + 48);
                    if (this.i1 < 20001) goto _label_2;
                    this.i3 = li32(this.i0 + 20);
                    this.i4 = li32(this.i0 + 40);
                    this.i3 = (this.i3 - this.i4);
                    this.i5 = (this.i0 + 40);
                    this.i6 = (this.i0 + 20);
                    this.i3 = (this.i3 / 24);
                    this.i7 = this.i4;
                    this.i3 = (this.i3 + 1);
                    if (this.i3 > 19999) goto _label_2;
                    this.i3 = 480000;
                    this.i8 = li32(this.i0 + 16);
                    this.i9 = li32(this.i8 + 12);
                    this.i10 = li32(this.i8 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = (this.i1 * 24);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i9]());
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i3 == 0)) goto _label_1;
                    this.i7 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i7 = 20000;
                    this.i9 = li32(this.i8 + 68);
                    this.i1 = (480000 - this.i1);
                    this.i1 = (this.i1 + this.i9);
                    si32(this.i1, (this.i8 + 68));
                    si32(this.i3, this.i5);
                    si32(this.i7, this.i2);
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 - this.i4);
                    this.i1 = (this.i1 / 24);
                    this.i1 = (this.i1 * 24);
                    this.i1 = (this.i3 + this.i1);
                    si32(this.i1, this.i6);
                    this.i1 = (this.i3 + 479976);
                    si32(this.i1, (this.i0 + 36));
                    
                _label_2: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _restore_stack_limit");
            };
        }


    }
} cmodule.lua_wrapper

