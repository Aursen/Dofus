package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_rvOK extends Machine 
    {

        public static const intRegCount:int = 13;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var f0:Number;
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
            var _local_1:FSM_rvOK;
            _local_1 = new (FSM_rvOK)();
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
                    this.i0 = (public::mstate.ebp + -8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.f0 = lf64(public::mstate.ebp + 8);
                    this.i1 = (public::mstate.ebp + -4);
                    sf64(this.f0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___d2b_D2A.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(public::mstate.ebp + -8);
                    this.i2 = li32(_fpi_2E_3615);
                    this.i1 = (this.i1 - this.i2);
                    si32(this.i1, (public::mstate.ebp + -8));
                    this.i3 = li32(public::mstate.ebp + -4);
                    this.i3 = (this.i1 + this.i3);
                    si32(this.i3, (public::mstate.ebp + -4));
                    this.i3 = li32(public::mstate.ebp + 20);
                    this.i4 = li32(public::mstate.ebp + 16);
                    this.i5 = li32(public::mstate.ebp + 24);
                    this.i6 = li32(public::mstate.ebp + 28);
                    this.i7 = li32(public::mstate.ebp + 32);
                    this.i8 = this.i3;
                    if (!(this.i1 > 0))
                    {
                        if (this.i5 == 0) goto _label_2;
                        
                    _label_1: 
                        this.i6 = 0;
                        goto _label_4;
                    };
                    if (!(!(this.i2 == 53)))
                    {
                        if (!(this.i5 == 0))
                        {
                            this.i6 = li32(_fpi_2E_3615 + 12);
                            if (this.i6 == 1) goto _label_1;
                        };
                        
                    _label_2: 
                        this.i6 = this.i0;
                        
                    _label_3: 
                        this.i0 = this.i6;
                        if (!(this.i0 == 0))
                        {
                            this.i1 = _freelist;
                            this.i2 = li32(this.i0 + 4);
                            this.i2 = (this.i2 << 2);
                            this.i1 = (this.i1 + this.i2);
                            this.i2 = li32(this.i1);
                            si32(this.i2, this.i0);
                            si32(this.i0, this.i1);
                        };
                        this.i0 = 0;
                        public::mstate.eax = this.i0;
                        goto _label_18;
                    };
                    if (this.i6 == 1) goto _label_1;
                    if (!(this.i6 == 2))
                    {
                        this.i6 = (this.i1 + -1);
                        if (this.i6 < 0) goto _label_1;
                        if (!(!(this.i1 == 1)))
                        {
                            if (this.i5 == 0) goto _label_2;
                            this.i6 = li32(this.i0 + 20);
                            this.i6 = (this.i6 & 0x02);
                            if (this.i6 == 0) goto _label_1;
                        }
                        else
                        {
                            this.i9 = 1;
                            this.i10 = (this.i6 >> 5);
                            this.i10 = (this.i10 << 2);
                            this.i6 = (this.i6 & 0x1F);
                            this.i10 = (this.i0 + this.i10);
                            this.i10 = li32(this.i10 + 20);
                            this.i6 = (this.i9 << this.i6);
                            this.i6 = (this.i10 & this.i6);
                            if (this.i6 == 0) goto _label_1;
                        };
                    };
                    this.i6 = 1;
                    
                _label_4: 
                    if (this.i1 < 1) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___any_on_D2A.start();
                case 2:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___rshift_D2A.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = ((this.i9 == 0) ? 0 : 16);
                    this.i6 = (this.i6 & 0x01);
                    if (!(!(this.i6 == 0)))
                    {
                        this.i6 = this.i9;
                        goto _label_8;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___increment_D2A.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = li32(this.i0 + 16);
                    this.i1 = (this.i1 << 2);
                    this.i1 = (this.i1 + this.i0);
                    this.i1 = li32(this.i1 + 16);
                    this.i6 = ((uint(this.i1) < uint(0x10000)) ? 16 : 0);
                    this.i1 = (this.i1 << this.i6);
                    this.i10 = ((uint(this.i1) < uint(0x1000000)) ? 8 : 0);
                    this.i1 = (this.i1 << this.i10);
                    this.i11 = ((uint(this.i1) < uint(0x10000000)) ? 4 : 0);
                    this.i6 = (this.i10 | this.i6);
                    this.i1 = (this.i1 << this.i11);
                    this.i10 = (this.i2 & 0x1F);
                    this.i12 = ((uint(this.i1) < uint(0x40000000)) ? 2 : 0);
                    this.i6 = (this.i6 | this.i11);
                    this.i11 = (32 - this.i10);
                    this.i10 = ((this.i10 == 0) ? this.i10 : this.i11);
                    this.i6 = (this.i6 | this.i12);
                    this.i1 = (this.i1 << this.i12);
                    if (!(this.i1 > -1))
                    {
                        this.i1 = this.i6;
                    }
                    else
                    {
                        this.i1 = (this.i1 & 0x40000000);
                        this.i6 = (this.i6 + 1);
                        this.i1 = ((this.i1 == 0) ? 32 : this.i6);
                    };
                    if (!(!(this.i1 == this.i10)))
                    {
                        this.i1 = 32;
                        this.i6 = this.i9;
                        goto _label_8;
                    };
                    if (!(this.i9 == 0)) goto _label_6;
                    this.i1 = 1;
                    this.i6 = li32(this.i0 + 20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___rshift_D2A.start();
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -4);
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, (public::mstate.ebp + -4));
                    this.i9 = li32(_fpi_2E_3615 + 4);
                    this.i6 = (this.i6 & 0x01);
                    if (!(this.i9 > this.i1))
                    {
                        this.i6 = 32;
                        
                    _label_5: 
                        this.i5 = li32(_fpi_2E_3615 + 8);
                        if (this.i5 < this.i1) goto _label_13;
                        goto _label_14;
                    };
                    this.i10 = 32;
                    goto _label_9;
                    
                _label_6: 
                    this.i1 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___rshift_D2A.start();
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -4);
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, (public::mstate.ebp + -4));
                    this.i1 = 32;
                    this.i6 = this.i9;
                    goto _label_8;
                    
                _label_7: 
                    if (!(this.i1 < 0))
                    {
                        this.i1 = 0;
                        this.i6 = this.i1;
                        goto _label_8;
                    };
                    this.i9 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = (0 - this.i1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___lshift_D2A.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = this.i9;
                    this.i1 = this.i9;
                    
                _label_8: 
                    this.i10 = this.i1;
                    this.i1 = li32(_fpi_2E_3615 + 4);
                    this.i11 = li32(public::mstate.ebp + -4);
                    if (!(this.i1 > this.i11))
                    {
                        this.i1 = this.i11;
                        this.i6 = this.i10;
                        goto _label_5;
                    };
                    this.i9 = this.i1;
                    this.i1 = this.i11;
                    
                _label_9: 
                    si32(this.i9, (public::mstate.ebp + -4));
                    this.i1 = (this.i9 - this.i1);
                    if (!(this.i1 > this.i2))
                    {
                        this.i9 = li32(_fpi_2E_3615 + 16);
                        if (this.i9 == 0) goto _label_10;
                    };
                    this.i6 = 0;
                    si32(this.i6, (this.i0 + 16));
                    this.i1 = 80;
                    si32(this.i1, this.i7);
                    goto _label_14;
                    
                _label_10: 
                    this.i9 = (this.i1 + -1);
                    if (this.i9 < 1) goto _label_11;
                    if (!(this.i6 == 0)) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___any_on_D2A.start();
                case 8:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_11: 
                    if (!(!(this.i6 == 0)))
                    {
                        if (!(!(this.i5 == 0)))
                        {
                            this.i6 = this.i0;
                            goto _label_3;
                        };
                    };
                    this.i5 = 1;
                    this.i11 = (this.i9 >> 5);
                    this.i11 = (this.i11 << 2);
                    this.i11 = (this.i0 + this.i11);
                    this.i11 = li32(this.i11 + 20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___rshift_D2A.start();
                case 9:
                    this.i1 = (this.i9 & 0x1F);
                    this.i1 = (this.i5 << this.i1);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = 2;
                    si32(this.i5, this.i7);
                    this.i1 = (this.i11 & this.i1);
                    if (this.i1 == 0) goto _label_12;
                    this.i6 = 96;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___increment_D2A.start();
                    return;
                case 10:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    goto _label_14;
                    
                _label_12: 
                    this.i6 = (this.i1 | this.i6);
                    if (!(!(this.i6 == 0)))
                    {
                        this.i6 = this.i10;
                    }
                    else
                    {
                        this.i6 = 80;
                        goto _label_14;
                        
                    _label_13: 
                        this.i6 = 163;
                        this.i1 = (this.i5 + 1);
                        si32(this.i1, (public::mstate.ebp + -4));
                        si32(this.i6, this.i7);
                        this.i6 = 34;
                        si32(this.i6, _val_2E_1440);
                        this.i6 = 0;
                        si32(this.i6, (this.i0 + 16));
                    };
                    
                _label_14: 
                    this.i1 = (this.i2 + -1);
                    this.i1 = (this.i1 >> 5);
                    this.i2 = li32(public::mstate.ebp + -4);
                    this.i1 = (this.i1 << 2);
                    this.i1 = (this.i1 + this.i3);
                    si32(this.i2, this.i4);
                    this.i2 = li32(this.i0 + 16);
                    this.i1 = (this.i1 + 4);
                    this.i4 = this.i0;
                    if (!(this.i2 > 0))
                    {
                        this.i2 = this.i3;
                    }
                    else
                    {
                        this.i5 = 0;
                        this.i9 = this.i5;
                        do 
                        {
                            this.i10 = (this.i4 + this.i9);
                            this.i10 = li32(this.i10 + 20);
                            this.i11 = (this.i8 + this.i9);
                            si32(this.i10, this.i11);
                            this.i9 = (this.i9 + 4);
                            this.i5 = (this.i5 + 1);
                            if (this.i5 >= this.i2) goto _label_16;
                        } while (true);
                        do 
                        {
                            
                        _label_15: 
                            this.i3 = 0;
                            si32(this.i3, this.i2);
                            this.i2 = (this.i2 + 4);
                            if (uint(this.i2) >= uint(this.i1)) goto _label_17;
                        } while (true);
                        
                    _label_16: 
                        this.i2 = (this.i5 << 2);
                        this.i2 = (this.i3 + this.i2);
                    };
                    this.i3 = this.i2;
                    if (!(uint(this.i2) >= uint(this.i1)))
                    {
                        this.i2 = this.i3;
                        goto _label_15;
                    };
                    
                _label_17: 
                    this.i1 = li32(this.i7);
                    this.i6 = (this.i1 | this.i6);
                    si32(this.i6, this.i7);
                    if (!(this.i0 == 0))
                    {
                        this.i6 = _freelist;
                        this.i1 = li32(this.i0 + 4);
                        this.i1 = (this.i1 << 2);
                        this.i6 = (this.i6 + this.i1);
                        this.i1 = li32(this.i6);
                        si32(this.i1, this.i0);
                        si32(this.i0, this.i6);
                    };
                    this.i6 = 1;
                    public::mstate.eax = this.i6;
                    
                _label_18: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _rvOK");
            };
        }


    }
}

