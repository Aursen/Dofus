package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___lshift_D2A extends Machine 
    {

        public static const intRegCount:int = 16;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM___lshift_D2A;
            _local_1 = new (FSM___lshift_D2A)();
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
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(this.i0 + 16);
                    this.i3 = (this.i1 >> 5);
                    this.i2 = (this.i2 + this.i3);
                    this.i4 = li32(this.i0 + 4);
                    this.i5 = li32(this.i0 + 8);
                    this.i6 = (this.i2 + 1);
                    this.i7 = (this.i0 + 16);
                    this.i8 = (this.i0 + 4);
                    this.i9 = this.i0;
                    if ((this.i6 > this.i5))
                    {
                        this.i10 = -1;
                        do 
                        {
                            this.i10 = (this.i10 + 1);
                            this.i5 = (this.i5 << 1);
                        } while (!(this.i6 <= this.i5));
                        this.i4 = (this.i10 + this.i4);
                        this.i4 = (this.i4 + 1);
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___Balloc_D2A.start();
                    return;
                case 1:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i5 = (this.i4 + 20);
                    this.i10 = this.i4;
                    if (!(this.i3 > 0))
                    {
                        this.i3 = this.i5;
                    }
                    else
                    {
                        this.i5 = 0;
                        this.i4 = (this.i4 + 20);
                        do 
                        {
                            this.i11 = 0;
                            si32(this.i11, this.i4);
                            this.i4 = (this.i4 + 4);
                            this.i5 = (this.i5 + 1);
                        } while (!(this.i5 == this.i3));
                        this.i3 = (this.i5 << 2);
                        this.i3 = (this.i10 + this.i3);
                        this.i3 = (this.i3 + 20);
                    };
                    this.i4 = li32(this.i7);
                    this.i1 = (this.i1 & 0x1F);
                    this.i5 = this.i3;
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = 0;
                        this.i3 = this.i1;
                        do 
                        {
                            this.i6 = (this.i9 + this.i3);
                            this.i6 = li32(this.i6 + 20);
                            this.i7 = (this.i5 + this.i3);
                            si32(this.i6, this.i7);
                            this.i3 = (this.i3 + 4);
                            this.i1 = (this.i1 + 1);
                            if (this.i1 >= this.i4) goto _label_3;
                        } while (true);
                    };
                    this.i7 = 0;
                    this.i11 = (32 - this.i1);
                    this.i12 = this.i7;
                    this.i13 = this.i7;
                    do 
                    {
                        this.i14 = (this.i9 + this.i12);
                        this.i15 = li32(this.i14 + 20);
                        this.i15 = (this.i15 << this.i1);
                        this.i7 = (this.i15 | this.i7);
                        this.i15 = (this.i5 + this.i12);
                        si32(this.i7, this.i15);
                        this.i7 = li32(this.i14 + 20);
                        this.i12 = (this.i12 + 4);
                        this.i13 = (this.i13 + 1);
                        this.i7 = (this.i7 >>> this.i11);
                    } while (!(this.i13 >= this.i4));
                    this.i1 = (this.i13 << 2);
                    this.i1 = (this.i3 + this.i1);
                    si32(this.i7, this.i1);
                    if (!(this.i7 == 0))
                    {
                        si32(this.i6, (this.i10 + 16));
                        if (!(this.i0 == 0))
                        {
                            
                        _label_1: 
                            this.i1 = _freelist;
                            this.i2 = li32(this.i8);
                            this.i2 = (this.i2 << 2);
                            this.i1 = (this.i1 + this.i2);
                            this.i2 = li32(this.i1);
                            si32(this.i2, this.i0);
                            si32(this.i0, this.i1);
                        };
                        
                    _label_2: 
                        public::mstate.eax = this.i10;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    
                _label_3: 
                    si32(this.i2, (this.i10 + 16));
                    if (this.i0 == 0) goto _label_2;
                    goto _label_1;
                default:
                    throw ("Invalid state in ___lshift_D2A");
            };
        }


    }
}

