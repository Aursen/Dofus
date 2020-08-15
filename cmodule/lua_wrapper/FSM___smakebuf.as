package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___smakebuf extends Machine 
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
            var _local_1:FSM___smakebuf;
            _local_1 = new (FSM___smakebuf)();
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
                    public::mstate.esp = (public::mstate.esp - 56);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li16(this.i0 + 12);
                    this.i2 = (this.i0 + 12);
                    this.i1 = (this.i1 & 0x02);
                    if (!(this.i1 == 0))
                    {
                        this.i2 = 1;
                        this.i1 = (this.i0 + 67);
                        si32(this.i1, this.i0);
                        si32(this.i1, (this.i0 + 16));
                        si32(this.i2, (this.i0 + 20));
                        goto _label_3;
                    };
                    this.i1 = (public::mstate.ebp + -52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (public::mstate.ebp + -56);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___swhatbuf.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(public::mstate.ebp + -56);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = 0;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 2:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(!(this.i4 == 0)))
                    {
                        this.i1 = 1;
                        this.i3 = li16(this.i2);
                        this.i3 = (this.i3 | 0x02);
                        si16(this.i3, this.i2);
                        this.i2 = (this.i0 + 67);
                        si32(this.i2, this.i0);
                        si32(this.i2, (this.i0 + 16));
                        si32(this.i1, (this.i0 + 20));
                        goto _label_3;
                    };
                    this.i5 = 1;
                    si8(this.i5, ___cleanup_2E_b);
                    si32(this.i4, this.i0);
                    si32(this.i4, (this.i0 + 16));
                    si32(this.i3, (this.i0 + 20));
                    this.i3 = li32(public::mstate.ebp + -52);
                    this.i4 = (this.i1 | 0x80);
                    if (!(!(this.i3 == 0)))
                    {
                        
                    _label_1: 
                        this.i0 = this.i4;
                        goto _label_2;
                    };
                    this.i3 = (public::mstate.ebp + -48);
                    this.i0 = sxi16(li16(this.i0 + 14));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_ioctl.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 == -1) goto _label_1;
                    this.i0 = (this.i1 | 0x81);
                    
                _label_2: 
                    this.i1 = li16(this.i2);
                    this.i0 = (this.i1 | this.i0);
                    si16(this.i0, this.i2);
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___smakebuf");
            };
        }


    }
}

