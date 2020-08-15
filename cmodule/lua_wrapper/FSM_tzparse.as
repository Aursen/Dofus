package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_tzparse extends Machine 
    {

        public static const intRegCount:int = 18;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
        public var i16:int;
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
            var _local_1:FSM_tzparse;
            _local_1 = new (FSM_tzparse)();
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
                    public::mstate.esp = (public::mstate.esp - 72);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li8(this.i0);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = this.i0;
                    this.i4 = this.i2;
                    this.i5 = li32(public::mstate.ebp + 16);
                    if (!(this.i5 == 0))
                    {
                        this.i1 = (this.i1 & 0xFF);
                        if (this.i1 == 0) goto _label_31;
                        this.i1 = this.i3;
                        do 
                        {
                            this.i5 = li8(this.i1 + 1);
                            this.i1 = (this.i1 + 1);
                            this.i6 = this.i1;
                            if (this.i5 == 0) goto _label_32;
                            this.i1 = this.i6;
                        } while (true);
                        
                    _label_1: 
                        goto _label_10;
                    };
                    this.i5 = (this.i1 & 0xFF);
                    if (!(this.i5 == 0))
                    {
                        this.i0 = this.i3;
                    }
                    else
                    {
                        goto _label_3;
                        
                    _label_2: 
                        this.i1 = li8(this.i0 + 1);
                        this.i0 = (this.i0 + 1);
                        this.i5 = this.i0;
                        if (this.i1 == 0) goto _label_33;
                        this.i0 = this.i5;
                    };
                    this.i5 = (this.i1 << 24);
                    this.i5 = (this.i5 >> 24);
                    this.i6 = this.i0;
                    this.i5 = (this.i5 + -48);
                    this.i7 = (this.i1 & 0xFF);
                    if (!(this.i7 == 45))
                    {
                        this.i7 = (this.i1 & 0xFF);
                        if (!(this.i7 == 43))
                        {
                            this.i1 = (this.i1 & 0xFF);
                            if (!(this.i1 == 44))
                            {
                                if (uint(this.i5) > uint(9)) goto _label_2;
                            };
                        };
                    };
                    this.i0 = this.i6;
                    
                _label_3: 
                    this.i1 = (this.i0 - this.i3);
                    if (!(uint(this.i1) > uint(2)))
                    {
                        
                    _label_4: 
                        this.i0 = -1;
                        goto _label_30;
                    };
                    this.i5 = li8(this.i0);
                    if (this.i5 == 0) goto _label_4;
                    this.i6 = (this.i5 & 0xFF);
                    if (this.i6 == 43) goto _label_5;
                    this.i5 = (this.i5 & 0xFF);
                    if (!(this.i5 == 45)) goto _label_6;
                    this.i5 = (public::mstate.ebp + -72);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getsecs.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i0 == 0)) goto _label_7;
                    goto _label_8;
                    
                _label_5: 
                    this.i0 = (this.i0 + 1);
                    
                _label_6: 
                    this.i5 = (public::mstate.ebp + -72);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getsecs.start();
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_8;
                    
                _label_7: 
                    this.i5 = li32(public::mstate.ebp + -72);
                    this.i5 = (0 - this.i5);
                    si32(this.i5, (public::mstate.ebp + -72));
                    
                _label_8: 
                    this.i5 = this.i0;
                    if (this.i5 == 0) goto _label_4;
                    this.i0 = __2E_str3351;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tzload.start();
                    return;
                case 3:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i6 == 0) goto _label_34;
                    this.i0 = this.i1;
                    this.i1 = this.i5;
                    this.i5 = this.i6;
                    
                _label_9: 
                    this.i6 = 0;
                    si32(this.i6, this.i2);
                    
                _label_10: 
                    this.i6 = li8(this.i1);
                    this.i7 = this.i1;
                    if (this.i6 == 0) goto _label_27;
                    this.i8 = this.i7;
                    while ((this.i9 = (this.i6 << 24)), (this.i9 = (this.i9 >> 24)), (this.i10 = this.i8), (this.i9 = (this.i9 + -48)), (this.i11 = (this.i6 & 0xFF)), if (this.i11 == 45) goto _label_11;
, (this.i11 = (this.i6 & 0xFF)), if (this.i11 == 43) goto _label_11;
, (this.i6 = (this.i6 & 0xFF)), if (this.i6 == 44) goto _label_11;
, (uint(this.i9) > uint(9)))
                    {
                        this.i6 = li8(this.i8 + 1);
                        this.i8 = (this.i8 + 1);
                        this.i9 = this.i8;
                        if (this.i6 == 0) goto _label_35;
                        this.i8 = this.i9;
                    };
                    
                _label_11: 
                    this.i8 = this.i10;
                    
                _label_12: 
                    this.i6 = this.i8;
                    this.i8 = (this.i6 - this.i7);
                    if (uint(this.i8) < uint(3)) goto _label_4;
                    this.i9 = li8(this.i6);
                    this.i10 = (this.i9 << 24);
                    this.i10 = (this.i10 >> 24);
                    if (!(this.i10 > 43))
                    {
                        this.i10 = (this.i9 & 0xFF);
                        if (this.i10 == 0) goto _label_17;
                        this.i9 = (this.i9 & 0xFF);
                        if (!(this.i9 == 43)) goto _label_13;
                        this.i9 = (this.i6 + 1);
                        goto _label_14;
                    };
                    this.i10 = (this.i9 & 0xFF);
                    if (this.i10 == 44) goto _label_17;
                    this.i10 = (this.i9 & 0xFF);
                    if (this.i10 == 45) goto _label_15;
                    this.i9 = (this.i9 & 0xFF);
                    if (this.i9 == 59) goto _label_17;
                    
                _label_13: 
                    this.i9 = this.i6;
                    
                _label_14: 
                    this.i10 = (public::mstate.ebp + -68);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getsecs.start();
                case 4:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_16;
                    
                _label_15: 
                    this.i9 = (public::mstate.ebp + -68);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i10 = (this.i6 + 1);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getsecs.start();
                case 5:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if ((!(this.i9 == 0)))
                    {
                        this.i10 = li32(public::mstate.ebp + -68);
                        this.i10 = (0 - this.i10);
                        si32(this.i10, (public::mstate.ebp + -68));
                    };
                    
                _label_16: 
                    if (this.i9 == 0) goto _label_4;
                    goto _label_18;
                    
                _label_17: 
                    this.i9 = li32(public::mstate.ebp + -72);
                    this.i9 = (this.i9 + -3600);
                    si32(this.i9, (public::mstate.ebp + -68));
                    this.i9 = this.i6;
                    
                _label_18: 
                    this.i10 = __2E_str4352;
                    this.i11 = li8(this.i9);
                    this.i11 = ((this.i11 != 0) ? 1 : 0);
                    this.i5 = ((this.i5 == 0) ? 1 : 0);
                    this.i5 = (this.i11 | this.i5);
                    this.i5 = (this.i5 & 0x01);
                    this.i5 = ((this.i5 != 0) ? this.i9 : this.i10);
                    this.i9 = li8(this.i5);
                    if (this.i9 == 0) goto _label_22;
                    this.i1 = (this.i9 & 0xFF);
                    if (!(this.i1 == 44))
                    {
                        this.i1 = (this.i9 & 0xFF);
                        if (!(this.i1 == 59)) goto _label_4;
                    };
                    this.i1 = (public::mstate.ebp + -64);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = (this.i5 + 1);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getrule.start();
                case 6:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i1 == 0) goto _label_4;
                    this.i6 = li8(this.i1);
                    if (!(this.i6 == 44)) goto _label_4;
                    this.i6 = (public::mstate.ebp + -32);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getrule.start();
                case 7:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i1 == 0) goto _label_4;
                    this.i1 = li8(this.i1);
                    if (!(this.i1 == 0)) goto _label_4;
                    this.i1 = 2;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = 136;
                    si32(this.i1, (this.i2 + 4));
                    this.i1 = li32(public::mstate.ebp + -68);
                    this.i6 = (0 - this.i1);
                    si32(this.i6, (this.i2 + 1868));
                    this.i6 = 1;
                    si32(this.i6, (this.i2 + 1872));
                    this.i6 = (this.i0 + 1);
                    si32(this.i6, (this.i2 + 1876));
                    this.i6 = li32(public::mstate.ebp + -72);
                    this.i5 = (0 - this.i6);
                    si32(this.i5, (this.i2 + 1888));
                    this.i5 = 0;
                    si32(this.i5, (this.i2 + 1892));
                    si32(this.i5, (this.i2 + 1896));
                    this.i9 = this.i4;
                    this.i10 = this.i4;
                    this.i11 = this.i5;
                    
                _label_19: 
                    this.i12 = (public::mstate.ebp + -64);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i13 = (this.i11 + 1970);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_transtime.start();
                case 8:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i14 = (public::mstate.ebp + -32);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_transtime.start();
                case 9:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i15 = (this.i10 + 1496);
                    this.i16 = (this.i9 + 16);
                    if (!(this.i12 <= this.i14))
                    {
                        this.i17 = 1;
                        si32(this.i14, this.i16);
                        si8(this.i17, this.i15);
                        si32(this.i12, (this.i9 + 20));
                        this.i12 = 0;
                        si8(this.i12, (this.i10 + 1497));
                    }
                    else
                    {
                        this.i17 = 0;
                        si32(this.i12, this.i16);
                        si8(this.i17, this.i15);
                        si32(this.i14, (this.i9 + 20));
                        this.i12 = 1;
                        si8(this.i12, (this.i10 + 1497));
                    };
                    this.i12 = (this.i13 & 0x03);
                    if (!(!(this.i12 == 0)))
                    {
                        this.i12 = (this.i13 / 100);
                        this.i12 = (this.i12 * 100);
                        this.i12 = (this.i13 - this.i12);
                        if (!(this.i12 == 0))
                        {
                            
                        _label_20: 
                            this.i13 = 1;
                            goto _label_21;
                        };
                        this.i12 = (this.i13 / 400);
                        this.i12 = (this.i12 * 400);
                        this.i13 = (this.i13 - this.i12);
                        if (this.i13 == 0) goto _label_20;
                    };
                    this.i13 = 0;
                    
                _label_21: 
                    this.i12 = this.i13;
                    this.i13 = _year_lengths;
                    this.i12 = (this.i12 << 2);
                    this.i12 = (this.i13 + this.i12);
                    this.i12 = li32(this.i12);
                    this.i12 = (this.i12 * 86400);
                    this.i9 = (this.i9 + 8);
                    this.i10 = (this.i10 + 2);
                    this.i11 = (this.i11 + 1);
                    this.i5 = (this.i12 + this.i5);
                    if (!(this.i11 == 68)) goto _label_19;
                    this.i1 = this.i8;
                    goto _label_28;
                    
                _label_22: 
                    this.i5 = 0;
                    this.i9 = li32(this.i2 + 4);
                    while ((this.i9 > this.i5))
                    {
                        this.i10 = (this.i4 + this.i5);
                        this.i10 = li8(this.i10 + 1496);
                        this.i11 = (this.i10 * 20);
                        this.i11 = (this.i2 + this.i11);
                        this.i11 = li32(this.i11 + 1872);
                        if (!(!(this.i11 == 0)))
                        {
                            this.i5 = (this.i10 * 20);
                            this.i5 = (this.i2 + this.i5);
                            this.i5 = li32(this.i5 + 1868);
                            this.i5 = (0 - this.i5);
                            if (this.i9 > 0) goto _label_23;
                            goto _label_26;
                        };
                        this.i5 = (this.i5 + 1);
                    };
                    this.i5 = 0;
                    this.i10 = this.i5;
                    goto _label_25;
                    
                _label_23: 
                    this.i10 = 0;
                    
                _label_24: 
                    this.i11 = (this.i2 + this.i10);
                    this.i11 = li8(this.i11 + 1496);
                    this.i11 = (this.i11 * 20);
                    this.i11 = (this.i2 + this.i11);
                    this.i11 = li32(this.i11 + 1872);
                    if ((this.i11 == 0))
                    {
                        this.i11 = (this.i10 + 1);
                        this.i10 = this.i5;
                        this.i5 = this.i11;
                        
                    _label_25: 
                        this.i11 = this.i5;
                        if (this.i9 > this.i11) goto _label_36;
                        this.i5 = this.i10;
                    };
                    
                _label_26: 
                    if (!(this.i9 < 1))
                    {
                        this.i10 = 0;
                        this.i11 = li32(public::mstate.ebp + -72);
                        this.i12 = (this.i4 + 16);
                        do 
                        {
                            this.i13 = (this.i4 + this.i10);
                            this.i14 = li8(this.i13 + 1496);
                            this.i15 = (this.i14 * 20);
                            this.i15 = (this.i2 + this.i15);
                            this.i16 = li32(this.i15 + 1872);
                            si8(this.i16, (this.i13 + 1496));
                            this.i13 = li32(this.i15 + 1884);
                            this.i15 = this.i12;
                            if (!(!(this.i13 == 0)))
                            {
                                this.i13 = li32(this.i15);
                                this.i13 = (this.i13 - this.i5);
                                this.i13 = (this.i13 + this.i11);
                                si32(this.i13, this.i15);
                            };
                            this.i13 = (this.i14 * 20);
                            this.i13 = (this.i2 + this.i13);
                            this.i13 = li32(this.i13 + 1868);
                            this.i13 = (0 - this.i13);
                            this.i5 = ((this.i16 == 0) ? this.i13 : this.i5);
                            this.i12 = (this.i12 + 4);
                            this.i10 = (this.i10 + 1);
                        } while (!(this.i9 <= this.i10));
                    };
                    this.i5 = 0;
                    this.i9 = li32(public::mstate.ebp + -72);
                    this.i9 = (0 - this.i9);
                    si32(this.i9, (this.i2 + 1868));
                    si32(this.i5, (this.i2 + 1872));
                    si32(this.i5, (this.i2 + 1876));
                    this.i5 = li32(public::mstate.ebp + -68);
                    this.i5 = (0 - this.i5);
                    si32(this.i5, (this.i2 + 1888));
                    this.i5 = 1;
                    si32(this.i5, (this.i2 + 1892));
                    this.i5 = (this.i0 + 1);
                    si32(this.i5, (this.i2 + 1896));
                    this.i9 = 2;
                    si32(this.i9, (this.i2 + 8));
                    si32(this.i5, (this.i2 + 12));
                    if (!(this.i6 == this.i1))
                    {
                        this.i1 = this.i8;
                    }
                    else
                    {
                        this.i1 = this.i8;
                        goto _label_29;
                        
                    _label_27: 
                        this.i1 = 1;
                        si32(this.i1, (this.i2 + 8));
                        this.i1 = 0;
                        si32(this.i1, (this.i2 + 4));
                        this.i5 = li32(public::mstate.ebp + -72);
                        this.i5 = (0 - this.i5);
                        si32(this.i5, (this.i2 + 1868));
                        si32(this.i1, (this.i2 + 1872));
                        si32(this.i1, (this.i2 + 1876));
                        
                    _label_28: 
                        this.i5 = (this.i0 + 1);
                        si32(this.i5, (this.i2 + 12));
                        if (this.i1 == 0) goto _label_37;
                    };
                    this.i5 = li32(this.i2 + 12);
                    this.i5 = (this.i1 + this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i2 + 12));
                    
                _label_29: 
                    this.i5 = li32(this.i2 + 12);
                    if (uint(this.i5) > uint(0x0200)) goto _label_4;
                    if (!(this.i0 == 0))
                    {
                        this.i5 = 0;
                        this.i6 = this.i0;
                        _loop_1:
                        do 
                        {
                            this.i8 = (this.i3 + this.i5);
                            this.i8 = li8(this.i8);
                            this.i9 = (this.i4 + this.i5);
                            si8(this.i8, (this.i9 + 6988));
                            this.i9 = (this.i5 + 1);
                            if ((this.i8 == 0))
                            {
                                if ((this.i6 == 1)) break;
                                this.i5 = 0;
                                do 
                                {
                                    this.i3 = 0;
                                    this.i8 = (this.i9 + this.i5);
                                    this.i8 = (this.i2 + this.i8);
                                    si8(this.i3, (this.i8 + 6988));
                                    this.i3 = (this.i5 + 1);
                                    this.i5 = (this.i6 - this.i5);
                                    if ((this.i5 == 2)) break _loop_1;
                                    this.i5 = this.i3;
                                } while (true);
                            };
                            this.i8 = (this.i6 + -1);
                            this.i5 = (this.i5 + 1);
                            if ((this.i6 == 1)) break;
                            this.i6 = this.i8;
                        } while (true);
                    };
                    this.i3 = 0;
                    this.i5 = (this.i2 + this.i0);
                    si8(this.i3, (this.i5 + 6988));
                    this.i3 = (this.i0 + 1);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i0 = 0;
                    }
                    else
                    {
                        this.i5 = 0;
                        this.i0 = (this.i0 + this.i4);
                        this.i4 = this.i1;
                        _loop_2:
                        do 
                        {
                            this.i6 = (this.i7 + this.i5);
                            this.i6 = li8(this.i6);
                            this.i8 = (this.i0 + this.i5);
                            si8(this.i6, (this.i8 + 6989));
                            this.i8 = (this.i5 + 1);
                            if ((this.i6 == 0))
                            {
                                if ((this.i4 == 1)) break;
                                this.i0 = 0;
                                do 
                                {
                                    this.i5 = 0;
                                    this.i7 = (this.i8 + this.i0);
                                    this.i7 = (this.i3 + this.i7);
                                    this.i7 = (this.i2 + this.i7);
                                    si8(this.i5, (this.i7 + 6988));
                                    this.i5 = (this.i0 + 1);
                                    this.i0 = (this.i4 - this.i0);
                                    if ((this.i0 == 2)) break _loop_2;
                                    this.i0 = this.i5;
                                } while (true);
                            };
                            this.i6 = (this.i4 + -1);
                            this.i5 = (this.i5 + 1);
                            if ((this.i4 == 1)) break;
                            this.i4 = this.i6;
                        } while (true);
                        this.i0 = 0;
                        this.i1 = (this.i1 + this.i3);
                        this.i1 = (this.i2 + this.i1);
                        si8(this.i0, (this.i1 + 6988));
                    };
                    
                _label_30: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_31: 
                    this.i1 = this.i0;
                    
                _label_32: 
                    this.i5 = 0;
                    si32(this.i5, (public::mstate.ebp + -72));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = __2E_str3351;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tzload.start();
                    return;
                case 10:
                    this.i5 = public::mstate.eax;
                    this.i0 = (this.i1 - this.i0);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = ((uint(this.i0) > uint(511)) ? 511 : this.i0);
                    if (this.i5 == 0) goto _label_1;
                    goto _label_9;
                    
                _label_33: 
                    goto _label_3;
                    
                _label_34: 
                    this.i0 = this.i1;
                    this.i1 = this.i5;
                    this.i5 = this.i6;
                    goto _label_10;
                    
                _label_35: 
                    goto _label_12;
                    
                _label_36: 
                    this.i5 = this.i10;
                    this.i10 = this.i11;
                    goto _label_24;
                    
                _label_37: 
                    goto _label_29;
                default:
                    throw ("Invalid state in _tzparse");
            };
        }


    }
}

