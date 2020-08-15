package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaC_step extends Machine 
    {

        public static const intRegCount:int = 9;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_luaC_step;
            _local_1 = new (FSM_luaC_step)();
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
                    this.i1 = li32(this.i0 + 16);
                    this.i2 = li32(this.i1 + 76);
                    this.i3 = li32(this.i1 + 68);
                    this.i4 = li32(this.i1 + 84);
                    this.i5 = li32(this.i1 + 64);
                    this.i2 = (this.i3 + this.i2);
                    this.i3 = (this.i4 * 10);
                    this.i2 = (this.i2 - this.i5);
                    si32(this.i2, (this.i1 + 76));
                    this.i2 = ((this.i3 == 0) ? 2147483646 : this.i3);
                    this.i3 = (this.i1 + 21);
                    this.i4 = (this.i1 + 64);
                    this.i5 = (this.i1 + 68);
                    this.i6 = (this.i1 + 76);
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_singlestep.start();
                    return;
                case 1:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i8 = li8(this.i3);
                    this.i2 = (this.i2 - this.i7);
                    if (!(this.i2 < 1))
                    {
                        this.i7 = (this.i8 & 0xFF);
                        if (!(this.i7 == 0)) goto _label_1;
                    };
                    this.i0 = (this.i8 & 0xFF);
                    if (!(this.i0 == 0))
                    {
                        this.i1 = li32(this.i6);
                        if (!(uint(this.i1) > uint(1023)))
                        {
                            this.i1 = li32(this.i5);
                            this.i1 = (this.i1 + 0x0400);
                            
                        _label_2: 
                            si32(this.i1, this.i4);
                            
                        _label_3: 
                            public::mstate.esp = public::mstate.ebp;
                            public::mstate.ebp = li32(public::mstate.esp);
                            public::mstate.esp = (public::mstate.esp + 4);
                            public::mstate.esp = (public::mstate.esp + 4);
                            public::mstate.gworker = caller;
                            return;
                        };
                        this.i1 = (this.i1 + -1024);
                        si32(this.i1, this.i6);
                        this.i1 = li32(this.i5);
                        goto _label_2;
                    };
                    this.i0 = li32(this.i1 + 72);
                    this.i1 = li32(this.i1 + 80);
                    this.i0 = (uint(this.i0) / uint(100));
                    this.i0 = (this.i1 * this.i0);
                    si32(this.i0, this.i4);
                    goto _label_3;
                default:
                    throw ("Invalid state in _luaC_step");
            };
        }


    }
}

