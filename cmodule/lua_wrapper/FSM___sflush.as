package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___sflush extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;


        public static function start():void
        {
            var _local_1:FSM___sflush;
            _local_1 = new (FSM___sflush)();
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
                    this.i1 = sxi16(li16(this.i0 + 12));
                    this.i2 = (this.i0 + 12);
                    this.i3 = (this.i1 & 0x08);
                    if (this.i3 == 0) goto _label_2;
                    this.i3 = li32(this.i0 + 16);
                    if (this.i3 == 0) goto _label_2;
                    this.i4 = li32(this.i0);
                    si32(this.i3, this.i0);
                    this.i5 = (this.i0 + 8);
                    this.i6 = this.i3;
                    this.i1 = (this.i1 & 0x03);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = li32(this.i0 + 20);
                        si32(this.i1, this.i5);
                        this.i4 = (this.i4 - this.i6);
                        if (this.i4 < 1) goto _label_2;
                        this.i5 = 0;
                    }
                    else
                    {
                        this.i1 = 0;
                        si32(this.i1, this.i5);
                        this.i4 = (this.i4 - this.i6);
                        if (this.i4 < 1) goto _label_2;
                        this.i5 = 0;
                    };
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i3 + this.i5);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__swrite.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i1 > 0))
                    {
                        this.i4 = -1;
                        this.i5 = li16(this.i2);
                        this.i5 = (this.i5 | 0x40);
                        si16(this.i5, this.i2);
                        public::mstate.eax = this.i4;
                    }
                    else
                    {
                        this.i4 = (this.i4 - this.i1);
                        this.i5 = (this.i5 + this.i1);
                        if (!(this.i4 < 1)) goto _label_1;
                        
                    _label_2: 
                        this.i0 = 0;
                        public::mstate.eax = this.i0;
                    };
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___sflush");
            };
        }


    }
}

