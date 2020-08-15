package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_rewind extends Machine 
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
            var _local_1:FSM_rewind;
            _local_1 = new (FSM_rewind)();
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
                    this.i0 = li32(_val_2E_1440);
                    this.i1 = li8(___sdidinit_2E_b);
                    this.i2 = li32(public::mstate.ebp + 8);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = _usual;
                        this.i3 = _usual_extra;
                        this.i4 = 0;
                        this.i1 = (this.i1 + 56);
                        do 
                        {
                            si32(this.i3, this.i1);
                            this.i3 = (this.i3 + 148);
                            this.i1 = (this.i1 + 88);
                            this.i4 = (this.i4 + 1);
                        } while (!(this.i4 == 17));
                        this.i1 = 1;
                        si8(this.i1, ___cleanup_2E_b);
                        si8(this.i1, ___sdidinit_2E_b);
                    };
                    this.i1 = 1;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i3 = 0;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i1, (public::mstate.esp + 16));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__fseeko.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = li16(this.i2 + 12);
                        this.i1 = (this.i1 & 0xFFFFFF9F);
                        si16(this.i1, (this.i2 + 12));
                        si32(this.i0, _val_2E_1440);
                    };
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _rewind");
            };
        }


    }
}

