package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___d2b_D2A extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM___d2b_D2A;
            _local_1 = new (FSM___d2b_D2A)();
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = li32(_freelist + 4);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = li32(public::mstate.ebp + 20);
                    if (!(this.i0 == 0))
                    {
                        this.i5 = li32(this.i0);
                        si32(this.i5, (_freelist + 4));
                        goto _label_1;
                    };
                    this.i0 = _private_mem;
                    this.i5 = li32(_pmem_next);
                    this.i0 = (this.i5 - this.i0);
                    this.i0 = (this.i0 >> 3);
                    this.i0 = (this.i0 + 4);
                    if (!(uint(this.i0) > uint(288)))
                    {
                        this.i0 = 1;
                        this.i6 = (this.i5 + 32);
                        si32(this.i6, _pmem_next);
                        si32(this.i0, (this.i5 + 4));
                        this.i0 = 2;
                        si32(this.i0, (this.i5 + 8));
                        this.i0 = this.i5;
                        goto _label_1;
                    };
                    this.i0 = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_malloc.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i5 = 1;
                    si32(this.i5, (this.i0 + 4));
                    this.i5 = 2;
                    si32(this.i5, (this.i0 + 8));
                    
                _label_1: 
                    this.i5 = 0;
                    this.i6 = (this.i2 & 0x7FFFFFFF);
                    si32(this.i5, (this.i0 + 16));
                    this.i7 = ((uint(this.i6) < uint(0x100000)) ? 0 : 0x100000);
                    this.i2 = (this.i2 & 0x0FFFFF);
                    si32(this.i5, (this.i0 + 12));
                    this.i2 = (this.i2 | this.i7);
                    si32(this.i2, (public::mstate.ebp + -4));
                    si32(this.i1, (public::mstate.ebp + -8));
                    this.i2 = (this.i6 >>> 20);
                    this.i5 = (this.i0 + 20);
                    this.i7 = (this.i0 + 16);
                    if (this.i1 == 0) goto _label_2;
                    this.i1 = (public::mstate.ebp + -8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___lo0bits_D2A.start();
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i1 == 0))
                    {
                        this.i8 = li32(public::mstate.ebp + -4);
                        this.i9 = (32 - this.i1);
                        this.i10 = li32(public::mstate.ebp + -8);
                        this.i8 = (this.i8 << this.i9);
                        this.i8 = (this.i8 | this.i10);
                        si32(this.i8, this.i5);
                        this.i5 = li32(public::mstate.ebp + -4);
                        this.i5 = (this.i5 >>> this.i1);
                        si32(this.i5, (public::mstate.ebp + -4));
                    }
                    else
                    {
                        this.i8 = li32(public::mstate.ebp + -8);
                        si32(this.i8, this.i5);
                    };
                    this.i5 = li32(public::mstate.ebp + -4);
                    si32(this.i5, (this.i0 + 24));
                    this.i5 = ((this.i5 == 0) ? 1 : 2);
                    si32(this.i5, this.i7);
                    if (uint(this.i6) < uint(0x100000)) goto _label_4;
                    this.i5 = this.i1;
                    goto _label_3;
                    
                _label_2: 
                    this.i1 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___lo0bits_D2A.start();
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i8 = li32(public::mstate.ebp + -4);
                    si32(this.i8, this.i5);
                    this.i5 = 1;
                    si32(this.i5, this.i7);
                    this.i1 = (this.i1 + 32);
                    if (!(uint(this.i6) < uint(0x100000)))
                    {
                        this.i5 = this.i1;
                        
                    _label_3: 
                        this.i2 = (this.i2 + this.i5);
                        this.i2 = (this.i2 + -1075);
                        si32(this.i2, this.i3);
                        this.i2 = (53 - this.i5);
                        si32(this.i2, this.i4);
                        goto _label_6;
                        
                    _label_4: 
                        this.i6 = this.i1;
                        
                    _label_5: 
                        this.i1 = this.i5;
                        this.i5 = this.i6;
                        this.i2 = (this.i2 + this.i5);
                        this.i2 = (this.i2 + -1074);
                        this.i5 = (this.i1 << 2);
                        si32(this.i2, this.i3);
                        this.i2 = (this.i5 + this.i0);
                        this.i2 = li32(this.i2 + 16);
                        this.i3 = ((uint(this.i2) < uint(0x10000)) ? 16 : 0);
                        this.i2 = (this.i2 << this.i3);
                        this.i5 = ((uint(this.i2) < uint(0x1000000)) ? 8 : 0);
                        this.i2 = (this.i2 << this.i5);
                        this.i6 = ((uint(this.i2) < uint(0x10000000)) ? 4 : 0);
                        this.i3 = (this.i5 | this.i3);
                        this.i2 = (this.i2 << this.i6);
                        this.i5 = ((uint(this.i2) < uint(0x40000000)) ? 2 : 0);
                        this.i3 = (this.i3 | this.i6);
                        this.i3 = (this.i3 | this.i5);
                        this.i2 = (this.i2 << this.i5);
                        if (!(this.i2 > -1))
                        {
                            this.i2 = this.i3;
                        }
                        else
                        {
                            this.i2 = (this.i2 & 0x40000000);
                            this.i3 = (this.i3 + 1);
                            this.i2 = ((this.i2 == 0) ? 32 : this.i3);
                        };
                        this.i1 = (this.i1 << 5);
                        this.i1 = (this.i1 - this.i2);
                        si32(this.i1, this.i4);
                        
                    _label_6: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i5 = 1;
                    this.i6 = this.i1;
                    goto _label_5;
                default:
                    throw ("Invalid state in ___d2b_D2A");
            };
        }


    }
} cmodule.lua_wrapper

