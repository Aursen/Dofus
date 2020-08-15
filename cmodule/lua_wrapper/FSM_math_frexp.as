package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_math_frexp extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;
        public var i4:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_math_frexp;
            _local_1 = new (FSM_math_frexp)();
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
                    public::mstate.esp = (public::mstate.esp - 32);
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checknumber.start();
                    return;
                case 1:
                    this.f0 = public::mstate.st0;
                    sf64(this.f0, (public::mstate.ebp + -8));
                    this.i0 = li32(public::mstate.ebp + -4);
                    this.i2 = (this.i0 >>> 20);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(public::mstate.ebp + -8);
                    this.i2 = (this.i2 & 0x07FF);
                    this.i4 = this.i0;
                    if (!(this.i2 == 0))
                    {
                        if (!(this.i2 == 2047)) goto _label_1;
                        goto _label_2;
                    };
                    this.i0 = (this.i4 & 0x0FFFFF);
                    this.i0 = (this.i0 | this.i3);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = 0;
                    }
                    else
                    {
                        this.f0 = (this.f0 * 5.36312E154);
                        sf64(this.f0, (public::mstate.ebp + -16));
                        this.i0 = li32(public::mstate.ebp + -12);
                        this.i2 = (this.i0 | 0x3FE00000);
                        this.i3 = li32(public::mstate.ebp + -16);
                        this.i2 = (this.i2 & 0xBFEFFFFF);
                        this.i0 = (this.i0 >>> 20);
                        si32(this.i3, (public::mstate.ebp + -24));
                        si32(this.i2, (public::mstate.ebp + -20));
                        this.i0 = (this.i0 & 0x07FF);
                        this.f0 = lf64(public::mstate.ebp + -24);
                        this.i0 = (this.i0 + -1536);
                        goto _label_2;
                        
                    _label_1: 
                        this.i0 = (this.i0 | 0x3FE00000);
                        this.i0 = (this.i0 & 0xBFEFFFFF);
                        si32(this.i3, (public::mstate.ebp + -32));
                        si32(this.i0, (public::mstate.ebp + -28));
                        this.f0 = lf64(public::mstate.ebp + -32);
                        this.i0 = (this.i2 + -1022);
                    };
                    
                _label_2: 
                    this.i2 = 3;
                    this.i3 = li32(this.i1 + 8);
                    sf64(this.f0, this.i3);
                    si32(this.i2, (this.i3 + 8));
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = (this.i3 + 12);
                    si32(this.i4, (this.i1 + 8));
                    this.f0 = Number(this.i0);
                    sf64(this.f0, (this.i3 + 12));
                    si32(this.i2, (this.i3 + 20));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = 2;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _math_frexp");
            };
        }


    }
}

