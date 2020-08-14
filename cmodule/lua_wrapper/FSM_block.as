package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_block extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_block;
            _local_1 = new (FSM_block)();
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
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = -1;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 36);
                    si32(this.i0, (public::mstate.ebp + -12));
                    this.i0 = 0;
                    si8(this.i0, (public::mstate.ebp + -6));
                    this.i3 = li8(this.i2 + 50);
                    si8(this.i3, (public::mstate.ebp + -8));
                    si8(this.i0, (public::mstate.ebp + -7));
                    this.i0 = li32(this.i2 + 20);
                    si32(this.i0, (public::mstate.ebp + -16));
                    this.i0 = (public::mstate.ebp + -16);
                    si32(this.i0, (this.i2 + 20));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_chunk.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_leaveblock.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _block");
            };
        }


    }
} cmodule.lua_wrapper

