package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_os_clock extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;


        public static function start():void
        {
            var _local_1:FSM_os_clock;
            _local_1 = new (FSM_os_clock)();
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
                    public::mstate.esp = (public::mstate.esp - 0x1000);
                    this.i0 = __2E_str424;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i1 = __2E_str121;
                    this.i2 = 12;
                    this.i3 = 78;
                    this.i4 = (public::mstate.ebp + -4096);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = 3;
                    this.i0 = this.i4;
                    this.i1 = this.i2;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i3, _val_2E_1440);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 8);
                    this.i3 = 1098907647;
                    this.i4 = -2097152;
                    si32(this.i4, this.i1);
                    si32(this.i3, (this.i1 + 4));
                    si32(this.i2, (this.i1 + 8));
                    this.i1 = li32(this.i0 + 8);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _os_clock");
            };
        }


    }
} cmodule.lua_wrapper

