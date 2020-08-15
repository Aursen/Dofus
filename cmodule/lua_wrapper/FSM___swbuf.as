package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___swbuf extends Machine 
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
            var _local_1:FSM___swbuf;
            _local_1 = new (FSM___swbuf)();
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
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(this.i0 + 24);
                    si32(this.i1, (this.i0 + 8));
                    this.i1 = li16(this.i0 + 12);
                    this.i2 = (this.i0 + 12);
                    this.i3 = (this.i0 + 8);
                    this.i4 = li32(public::mstate.ebp + 8);
                    this.i5 = (this.i1 & 0x08);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = li32(this.i0 + 16);
                        if (!(this.i5 == 0)) goto _label_2;
                        this.i1 = (this.i1 & 0x0200);
                        if (!(this.i1 == 0)) goto _label_2;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___swsetup.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i1 == 0))
                    {
                        
                    _label_1: 
                        this.i0 = -1;
                        goto _label_5;
                    };
                    
                _label_2: 
                    this.i1 = li32(this.i0 + 56);
                    this.i5 = li32(this.i1 + 16);
                    this.i1 = (this.i1 + 16);
                    this.i6 = (this.i4 & 0xFF);
                    if (!(!(this.i5 == 0)))
                    {
                        this.i5 = -1;
                        si32(this.i5, this.i1);
                    };
                    this.i1 = li32(this.i0);
                    this.i5 = li32(this.i0 + 16);
                    this.i7 = li32(this.i0 + 20);
                    this.i8 = (this.i0 + 20);
                    this.i1 = (this.i1 - this.i5);
                    this.i5 = this.i0;
                    if (!(this.i7 <= this.i1)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fflush.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i1 == 0)) goto _label_1;
                    this.i1 = 0;
                    
                _label_3: 
                    this.i7 = li32(this.i3);
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i3);
                    this.i3 = li32(this.i5);
                    si8(this.i4, this.i3);
                    this.i3 = (this.i3 + 1);
                    si32(this.i3, this.i5);
                    this.i3 = li32(this.i8);
                    this.i1 = (this.i1 + 1);
                    if (!(this.i1 == this.i3))
                    {
                        this.i1 = li16(this.i2);
                        this.i1 = (this.i1 & 0x01);
                        if (!(this.i1 == 0))
                        {
                            this.i1 = (this.i4 & 0xFF);
                            if (this.i1 == 10) goto _label_4;
                        };
                        this.i0 = this.i6;
                        goto _label_5;
                    };
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fflush.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = ((this.i0 == 0) ? this.i6 : -1);
                    
                _label_5: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___swbuf");
            };
        }


    }
}

