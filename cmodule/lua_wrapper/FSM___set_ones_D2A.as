package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___set_ones_D2A extends Machine 
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
            var _local_1:FSM___set_ones_D2A;
            _local_1 = new (FSM___set_ones_D2A)();
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
                    this.i1 = (this.i0 + 31);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = li32(this.i2 + 4);
                    this.i1 = (this.i1 >> 5);
                    if (!(this.i3 < this.i1))
                    {
                        this.i1 = this.i2;
                        goto _label_1;
                    };
                    if (!(this.i2 == 0))
                    {
                        this.i4 = _freelist;
                        this.i3 = (this.i3 << 2);
                        this.i3 = (this.i4 + this.i3);
                        this.i4 = li32(this.i3);
                        si32(this.i4, this.i2);
                        si32(this.i2, this.i3);
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___Balloc_D2A.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i2 = (this.i0 & 0x1F);
                    this.i3 = ((this.i2 != 0) ? 1 : 0);
                    this.i3 = (this.i3 & 0x01);
                    this.i0 = (this.i0 >> 5);
                    this.i0 = (this.i3 + this.i0);
                    si32(this.i0, (this.i1 + 16));
                    this.i3 = (this.i1 + 20);
                    this.i4 = this.i1;
                    if (!(this.i0 > 0))
                    {
                        this.i0 = this.i3;
                    }
                    else
                    {
                        this.i3 = 0;
                        this.i4 = (this.i4 + 20);
                        do 
                        {
                            this.i5 = -1;
                            si32(this.i5, this.i4);
                            this.i4 = (this.i4 + 4);
                            this.i3 = (this.i3 + 1);
                        } while (!(this.i3 >= this.i0));
                        this.i0 = (this.i3 << 2);
                        this.i0 = (this.i1 + this.i0);
                        this.i0 = (this.i0 + 20);
                    };
                    if (!(this.i2 == 0))
                    {
                        this.i3 = li32(this.i0 + -4);
                        this.i2 = (32 - this.i2);
                        this.i2 = (this.i3 >>> this.i2);
                        si32(this.i2, (this.i0 + -4));
                    };
                    public::mstate.eax = this.i1;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___set_ones_D2A");
            };
        }


    }
} cmodule.lua_wrapper

