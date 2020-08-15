package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_math_ldexp extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_math_ldexp;
            _local_1 = new (FSM_math_ldexp)();
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
                    public::mstate.esp = (public::mstate.esp - 88);
                    this.i0 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checknumber.start();
                    return;
                case 2:
                    this.f0 = public::mstate.st0;
                    sf64(this.f0, (public::mstate.ebp + -8));
                    this.i2 = li32(public::mstate.ebp + -4);
                    this.i3 = (this.i2 >>> 20);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(public::mstate.ebp + -8);
                    this.i3 = (this.i3 & 0x07FF);
                    this.i5 = this.i2;
                    this.i2 = (this.i2 & 0x7FF00000);
                    if (!(this.i2 == 0))
                    {
                        this.i4 = this.i5;
                        this.i5 = this.i3;
                    }
                    else
                    {
                        this.i5 = (this.i5 & 0x7FFFFFFF);
                        this.i4 = (this.i5 | this.i4);
                        if (!(!(this.i4 == 0))) goto _label_1;
                        this.f0 = (this.f0 * 18014400000000000);
                        sf64(this.f0, (public::mstate.ebp + -16));
                        this.i4 = li32(public::mstate.ebp + -12);
                        this.i5 = (this.i4 >>> 20);
                        this.i5 = (this.i5 & 0x07FF);
                        this.i5 = (this.i5 + -54);
                        if (this.i0 < -50000) goto _label_2;
                    };
                    this.i2 = this.i4;
                    this.i3 = this.i5;
                    if (!(!(this.i3 == 2047)))
                    {
                        this.f0 = (this.f0 + this.f0);
                    }
                    else
                    {
                        this.i3 = (this.i3 + this.i0);
                        if (!(this.i3 < 2047))
                        {
                            this.i0 = -2013235812;
                            sf64(this.f0, (public::mstate.ebp + -24));
                            this.i2 = li32(public::mstate.ebp + -20);
                            this.i2 = (this.i2 | 0x7E37E43C);
                            this.i2 = (this.i2 & 0xFE37E43C);
                            si32(this.i0, (public::mstate.ebp + -32));
                            si32(this.i2, (public::mstate.ebp + -28));
                            this.f0 = lf64(public::mstate.ebp + -32);
                            this.f0 = (this.f0 * 1E300);
                        }
                        else
                        {
                            if (!(this.i3 < 1))
                            {
                                sf64(this.f0, (public::mstate.ebp + -40));
                                this.i0 = (this.i3 << 20);
                                this.i2 = (this.i2 & 0x800FFFFF);
                                this.i3 = li32(public::mstate.ebp + -40);
                                this.i0 = (this.i0 | this.i2);
                                si32(this.i3, (public::mstate.ebp + -48));
                                si32(this.i0, (public::mstate.ebp + -44));
                                this.f0 = lf64(public::mstate.ebp + -48);
                            }
                            else
                            {
                                if (!(this.i3 > -54))
                                {
                                    sf64(this.f0, (public::mstate.ebp + -56));
                                    this.i2 = li32(public::mstate.ebp + -56);
                                    this.i2 = li32(public::mstate.ebp + -52);
                                    if (!(this.i0 < 50001))
                                    {
                                        this.i3 = -2013235812;
                                        this.i2 = (this.i2 | 0x7E37E43C);
                                        this.i2 = (this.i2 & 0xFE37E43C);
                                        si32(this.i3, (public::mstate.ebp + -64));
                                        si32(this.i2, (public::mstate.ebp + -60));
                                        this.f0 = lf64(public::mstate.ebp + -64);
                                        this.f0 = (this.f0 * 1E300);
                                    }
                                    else
                                    {
                                        this.i3 = -1023872167;
                                        this.i2 = (this.i2 | 0x01A56E1F);
                                        this.i2 = (this.i2 & 0x81A56E1F);
                                        si32(this.i3, (public::mstate.ebp + -72));
                                        si32(this.i2, (public::mstate.ebp + -68));
                                        this.f0 = lf64(public::mstate.ebp + -72);
                                        this.f0 = (this.f0 * 1E-300);
                                    };
                                }
                                else
                                {
                                    this.i0 = (this.i3 << 20);
                                    sf64(this.f0, (public::mstate.ebp + -80));
                                    this.i0 = (this.i0 + 56623104);
                                    this.i2 = (this.i2 & 0x800FFFFF);
                                    this.i3 = li32(public::mstate.ebp + -80);
                                    this.i0 = (this.i0 | this.i2);
                                    si32(this.i3, (public::mstate.ebp + -88));
                                    si32(this.i0, (public::mstate.ebp + -84));
                                    this.f0 = lf64(public::mstate.ebp + -88);
                                    this.f0 = (this.f0 * 5.55112E-17);
                                };
                            };
                        };
                    };
                    
                _label_1: 
                    this.i0 = 3;
                    this.i2 = li32(this.i1 + 8);
                    sf64(this.f0, this.i2);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_2: 
                    this.f0 = (this.f0 * 1E-300);
                    goto _label_1;
                default:
                    throw ("Invalid state in _math_ldexp");
            };
        }


    }
}

