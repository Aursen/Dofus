package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_open extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;


        public static function start():void
        {
            var _local_1:FSM_open;
            _local_1 = new (FSM_open)();
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
                    public::mstate.esp = (public::mstate.esp - 4100);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i2 = (this.i1 & 0x0200);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i2 = 0;
                    }
                    else
                    {
                        this.i2 = (public::mstate.ebp + 16);
                        si32(this.i2, (public::mstate.ebp + -4100));
                        this.i2 = (public::mstate.ebp + 20);
                        si32(this.i2, (public::mstate.ebp + -4100));
                        this.i2 = li32(public::mstate.ebp + 16);
                    };
                    state = 1;
                case 1:
                    this.i0 = public::mstate.system.open(this.i0, this.i1, this.i2);
                    this.i2 = this.i0;
                    if (this.i2 > -1) goto _label_1;
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = __2E_str13;
                    this.i3 = 73;
                    this.i4 = 2;
                    this.i5 = (public::mstate.ebp + -4096);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i3, (public::mstate.esp + 16));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i5;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i4, _val_2E_1440);
                    
                _label_1: 
                    public::mstate.eax = this.i2;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _open");
            };
        }


    }
}

