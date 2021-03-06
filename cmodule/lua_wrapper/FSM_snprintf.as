package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_snprintf extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_snprintf;
            _local_1 = new (FSM_snprintf)();
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
                    public::mstate.esp = (public::mstate.esp - 260);
                    this.i0 = (public::mstate.ebp + 20);
                    si32(this.i0, (public::mstate.ebp + -260));
                    this.i0 = -1;
                    this.i1 = li32(public::mstate.ebp + 12);
                    si16(this.i0, (public::mstate.ebp + -242));
                    this.i0 = 520;
                    this.i2 = (this.i1 + -1);
                    si16(this.i0, (public::mstate.ebp + -244));
                    this.i0 = li32(public::mstate.ebp + 8);
                    si32(this.i0, (public::mstate.ebp + -256));
                    this.i2 = ((this.i1 == 0) ? this.i1 : this.i2);
                    si32(this.i0, (public::mstate.ebp + -240));
                    this.i0 = ((this.i2 < 0) ? 2147483647 : this.i2);
                    si32(this.i0, (public::mstate.ebp + -248));
                    this.i2 = (public::mstate.ebp + -160);
                    si32(this.i0, (public::mstate.ebp + -236));
                    si32(this.i2, (public::mstate.ebp + -200));
                    this.i0 = 0;
                    si32(this.i0, (public::mstate.ebp + -160));
                    si32(this.i0, (public::mstate.ebp + -156));
                    si32(this.i0, (public::mstate.ebp + -152));
                    si32(this.i0, (public::mstate.ebp + -148));
                    si32(this.i0, (public::mstate.ebp + -144));
                    this.i2 = (this.i2 + 20);
                    this.i3 = 128;
                    memset(this.i2, this.i0, this.i3);
                    this.i0 = li32(public::mstate.ebp + -260);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = (public::mstate.ebp + -256);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___vfprintf.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = (public::mstate.ebp + -260);
                    if (!(this.i1 == 0))
                    {
                        this.i0 = 0;
                        this.i1 = li32(this.i3);
                        si8(this.i0, this.i1);
                    };
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _snprintf");
            };
        }


    }
}

