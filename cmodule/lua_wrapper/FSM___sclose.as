package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___sclose extends Machine 
    {

        public static const intRegCount:int = 1;
        public static const NumberRegCount:int = 0;

        public var i0:int;


        public static function start():void
        {
            var _local_1:FSM___sclose;
            _local_1 = new (FSM___sclose)();
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
                    this.i0 = sxi16(li16(this.i0 + 14));
                    state = 1;
                case 1:
                    this.i0 = public::mstate.system.close(this.i0);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___sclose");
            };
        }


    }
} cmodule.lua_wrapper

