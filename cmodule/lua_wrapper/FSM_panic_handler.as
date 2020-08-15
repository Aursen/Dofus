package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_panic_handler extends Machine 
    {

        public static const intRegCount:int = 3;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;


        public static function start():void
        {
            var _local_1:FSM_panic_handler;
            _local_1 = new (FSM_panic_handler)();
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
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = __2E_str157;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    if (!(this.i1 == 0))
                    {
                        this.i0 = __2E_str21178;
                        trace(public::mstate.gworker.stringFromPtr(this.i0));
                        this.i0 = this.i1;
                    }
                    else
                    {
                        this.i0 = __2E_str22179;
                    };
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = -1;
                    si32(this.i0, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                default:
                    throw ("Invalid state in _panic_handler");
            };
        }


    }
}

