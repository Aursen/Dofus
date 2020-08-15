package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_ioctl extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_ioctl;
            _local_1 = new (FSM_ioctl)();
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
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = (public::mstate.ebp + 12);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i0, (public::mstate.ebp + -4));
                    this.i0 = (public::mstate.ebp + -4);
                    if (!(this.i1 == 0)) goto _label_1;
                    this.i1 = ___sF;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = __2E_str7403;
                    this.i2 = 1076655123;
                    this.i1 = (this.i1 + 176);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fprintf.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = -1;
                    public::mstate.eax = this.i1;
                    goto _label_2;
                    
                _label_1: 
                    this.i2 = 1076655123;
                    this.i3 = li32(public::mstate.ebp + -4);
                    this.i0 = this.i1;
                    this.i1 = this.i2;
                    this.i2 = this.i3;
                    state = 2;
                case 2:
                    this.i0 = public::mstate.system.ioctl(this.i0, this.i1, this.i2);
                    public::mstate.eax = this.i0;
                    
                _label_2: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _ioctl");
            };
        }


    }
}

