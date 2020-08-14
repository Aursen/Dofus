package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_strtod extends Machine 
    {

        public static const intRegCount:int = 23;
        public static const NumberRegCount:int = 4;

        public var i21:int;
        public var f0:Number;
        public var f1:Number;
        public var f2:Number;
        public var f3:Number;
        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
        public var i19:int;
        public var i16:int;
        public var i18:int;
        public var i0:int;
        public var i1:int;
        public var i22:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i2:int;
        public var i20:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_strtod;
            _local_1 = new (FSM_strtod)();
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
                    this.i0 = 0;
                    si32(this.i0, (public::mstate.ebp + -32));
                    si32(this.i0, (public::mstate.ebp + -28));
                    this.i0 = li32(public::mstate.ebp + 8);
                    si32(this.i0, (public::mstate.ebp + -36));
                    this.i1 = sxi8(li8(this.i0));
                    this.i2 = (public::mstate.ebp + -16);
                    this.i3 = li32(public::mstate.ebp + 12);
                    if (!(this.i1 > 31))
                    {
                        if (this.i1 == 0) goto _label_38;
                        this.i1 = (this.i1 + -9);
                        if (!(uint(this.i1) < uint(5)))
                        {
                            goto _label_90;
                        };
                        
                    _label_1: 
                        this.i1 = this.i0;
                        do 
                        {
                            this.i4 = (this.i1 + 1);
                            si32(this.i4, (public::mstate.ebp + -36));
                            this.i1 = sxi8(li8(this.i1 + 1));
                            if (this.i1 > 31) goto _label_4;
                            if (this.i1 == 0) goto _label_38;
                            this.i1 = (this.i1 + -9);
                            if (!(uint(this.i1) < uint(5)))
                            {
                                goto _label_5;
                            };
                            
                        _label_2: 
                            this.i1 = this.i4;
                        } while (true);
                    };
                    if (this.i1 == 32) goto _label_1;
                    if (!(this.i1 == 43))
                    {
                        if (!(this.i1 == 45)) goto _label_90;
                        this.i1 = this.i0;
                        
                    _label_3: 
                        this.i4 = (this.i1 + 1);
                        si32(this.i4, (public::mstate.ebp + -36));
                        this.i1 = li8(this.i1 + 1);
                        if (this.i1 == 0) goto _label_38;
                        this.i1 = 1;
                        goto _label_6;
                    };
                    this.i1 = this.i0;
                    do 
                    {
                        this.i4 = (this.i1 + 1);
                        si32(this.i4, (public::mstate.ebp + -36));
                        this.i1 = li8(this.i1 + 1);
                        if (this.i1 == 0) goto _label_38;
                        this.i1 = 0;
                        goto _label_6;
                        
                    _label_4: 
                        if (this.i1 == 32) goto _label_2;
                        if (!(this.i1 == 43))
                        {
                            if ((!(this.i1 == 45))) break;
                            this.i1 = this.i4;
                            goto _label_3;
                        };
                        this.i1 = this.i4;
                    } while (true);
                    
                _label_5: 
                    this.i1 = 0;
                    
                _label_6: 
                    this.i5 = li8(this.i4);
                    if (!(this.i5 == 48))
                    {
                        this.i2 = 0;
                        goto _label_16;
                    };
                    this.i5 = sxi8(li8(this.i4 + 1));
                    if (!(this.i5 == 88))
                    {
                        if (!(this.i5 == 120))
                        {
                            this.i2 = this.i4;
                            do 
                            {
                                this.i4 = (this.i2 + 1);
                                si32(this.i4, (public::mstate.ebp + -36));
                                this.i2 = li8(this.i2 + 1);
                                if (this.i2 == 0) goto _label_89;
                                this.i2 = (this.i2 & 0xFF);
                                if (!(this.i2 == 48)) goto _label_15;
                                this.i2 = this.i4;
                            } while (true);
                        };
                    };
                    this.i4 = _fpi_2E_3700;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i5 = (public::mstate.ebp + -24);
                    this.i6 = (public::mstate.ebp + -20);
                    this.i7 = (public::mstate.ebp + -36);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i1, (public::mstate.esp + 16));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___gethex_D2A.start();
                    return;
                case 1:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i5 = (this.i4 & 0x07);
                    if (this.i5 == 0) goto _label_89;
                    if (!(!(this.i5 == 6)))
                    {
                        si32(this.i0, (public::mstate.ebp + -36));
                        if (this.i3 == 0) goto _label_40;
                        
                    _label_7: 
                        this.i2 = 0;
                        
                    _label_8: 
                        this.i0 = li32(public::mstate.ebp + -36);
                        si32(this.i0, this.i3);
                        goto _label_41;
                    };
                    this.i0 = (public::mstate.ebp + -16);
                    this.i5 = li32(public::mstate.ebp + -24);
                    this.i6 = (public::mstate.ebp + -32);
                    this.i7 = this.i5;
                    if (this.i5 == 0) goto _label_13;
                    this.i8 = (public::mstate.ebp + -16);
                    this.i9 = li32(_fpi_2E_3700);
                    this.i9 = (this.i9 + -1);
                    this.i9 = (this.i9 >> 5);
                    this.i9 = (this.i9 << 2);
                    this.i7 = li32(this.i7 + 16);
                    this.i8 = (this.i9 + this.i8);
                    this.i8 = (this.i8 + 4);
                    if (!(this.i7 > 0))
                    {
                        this.i2 = this.i0;
                    }
                    else
                    {
                        this.i9 = 0;
                        this.i10 = this.i9;
                        do 
                        {
                            this.i11 = (this.i5 + this.i10);
                            this.i11 = li32(this.i11 + 20);
                            this.i12 = (this.i2 + this.i10);
                            si32(this.i11, this.i12);
                            this.i10 = (this.i10 + 4);
                            this.i9 = (this.i9 + 1);
                            if (this.i9 >= this.i7) goto _label_10;
                        } while (true);
                        do 
                        {
                            
                        _label_9: 
                            this.i9 = 0;
                            si32(this.i9, this.i2);
                            this.i2 = (this.i2 + 4);
                            if (uint(this.i2) >= uint(this.i8)) goto _label_11;
                        } while (true);
                        
                    _label_10: 
                        this.i2 = (public::mstate.ebp + -16);
                        this.i5 = (this.i9 << 2);
                        this.i2 = (this.i2 + this.i5);
                    };
                    this.i5 = this.i2;
                    if (!(uint(this.i2) >= uint(this.i8)))
                    {
                        this.i2 = this.i5;
                        goto _label_9;
                    };
                    
                _label_11: 
                    this.i2 = li32(public::mstate.ebp + -24);
                    if (!(this.i2 == 0))
                    {
                        this.i5 = _freelist;
                        this.i7 = li32(this.i2 + 4);
                        this.i7 = (this.i7 << 2);
                        this.i5 = (this.i5 + this.i7);
                        this.i7 = li32(this.i5);
                        si32(this.i7, this.i2);
                        si32(this.i2, this.i5);
                    };
                    this.i2 = li32(public::mstate.ebp + -20);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___ULtod_D2A.start();
                case 2:
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i3 == 0) goto _label_14;
                    
                _label_12: 
                    this.i2 = this.i1;
                    goto _label_8;
                    
                _label_13: 
                    this.i2 = li32(public::mstate.ebp + -20);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___ULtod_D2A.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i3 == 0))
                    {
                        goto _label_12;
                    };
                    
                _label_14: 
                    this.i2 = this.i1;
                    goto _label_41;
                    
                _label_15: 
                    this.i2 = 1;
                    
                _label_16: 
                    this.i5 = li8(this.i4);
                    this.i6 = (this.i5 << 24);
                    this.i6 = (this.i6 >> 24);
                    this.i7 = (this.i5 + -48);
                    this.i7 = (this.i7 & 0xFF);
                    if (!(uint(this.i7) < uint(10)))
                    {
                        this.i7 = 0;
                        this.i8 = this.i7;
                        this.i9 = this.i7;
                    }
                    else
                    {
                        this.i5 = 0;
                        this.i7 = this.i5;
                        this.i8 = this.i4;
                        this.i9 = this.i5;
                        
                    _label_17: 
                        if (!(this.i7 > 8))
                        {
                            this.i9 = (this.i9 * 10);
                            this.i6 = (this.i9 + this.i6);
                            this.i6 = (this.i6 + -48);
                        }
                        else
                        {
                            if (!(this.i7 < 16))
                            {
                                this.i6 = this.i9;
                            }
                            else
                            {
                                this.i5 = (this.i5 * 10);
                                this.i5 = (this.i6 + this.i5);
                                this.i5 = (this.i5 + -48);
                                this.i6 = this.i9;
                            };
                        };
                        this.i9 = (this.i8 + 1);
                        si32(this.i9, (public::mstate.ebp + -36));
                        this.i10 = li8(this.i8 + 1);
                        this.i8 = (this.i10 << 24);
                        this.i11 = (this.i8 >> 24);
                        this.i7 = (this.i7 + 1);
                        this.i8 = (this.i10 + -48);
                        this.i8 = (this.i8 & 0xFF);
                        if (uint(this.i8) < uint(10)) goto _label_91;
                        this.i8 = this.i6;
                        this.i9 = this.i5;
                        this.i5 = this.i10;
                        this.i6 = this.i11;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_localeconv.start();
                case 4:
                    this.i10 = li32(_ret_2E_1494_2E_0);
                    this.i10 = li8(this.i10);
                    this.i5 = (this.i5 & 0xFF);
                    if (!(this.i10 == this.i5))
                    {
                        this.i5 = 0;
                        this.i10 = this.i7;
                        this.i11 = this.i5;
                    }
                    else
                    {
                        this.i5 = li32(public::mstate.ebp + -36);
                        this.i6 = (this.i5 + 1);
                        si32(this.i6, (public::mstate.ebp + -36));
                        this.i5 = li8(this.i5 + 1);
                        this.i10 = (this.i5 << 24);
                        this.i10 = (this.i10 >> 24);
                        if (!(this.i7 == 0))
                        {
                            this.i5 = 0;
                            this.i11 = this.i7;
                            this.i12 = this.i5;
                        }
                        else
                        {
                            this.i5 = (this.i5 & 0xFF);
                            if (!(this.i5 == 48))
                            {
                                this.i5 = 0;
                            }
                            else
                            {
                                this.i5 = 0;
                                do 
                                {
                                    this.i10 = (this.i6 + 1);
                                    si32(this.i10, (public::mstate.ebp + -36));
                                    this.i6 = li8(this.i6 + 1);
                                    this.i5 = (this.i5 + 1);
                                    if ((!(this.i6 == 48))) break;
                                    this.i6 = this.i10;
                                } while (true);
                                this.i6 = (this.i6 << 24);
                                this.i11 = (this.i6 >> 24);
                                this.i6 = this.i10;
                                this.i10 = this.i11;
                            };
                            this.i11 = (this.i10 + -49);
                            if (!(uint(this.i11) < uint(9)))
                            {
                                this.i11 = 0;
                                this.i6 = this.i10;
                                this.i10 = this.i7;
                                goto _label_20;
                            };
                            this.i4 = 0;
                            this.i11 = this.i6;
                            this.i12 = this.i7;
                            
                        _label_18: 
                            this.i13 = this.i6;
                            this.i6 = this.i8;
                            this.i8 = this.i9;
                            this.i9 = this.i11;
                            this.i11 = this.i12;
                            do 
                            {
                                this.i12 = (this.i10 + -48);
                                this.i14 = (this.i4 + 1);
                                if (!(!(this.i10 == 48)))
                                {
                                    this.i4 = this.i11;
                                    this.i11 = this.i14;
                                    goto _label_19;
                                };
                                this.i10 = ((this.i11 < 9) ? 1 : 0);
                                this.i5 = (this.i14 + this.i5);
                                if (!(this.i14 > 1))
                                {
                                    this.i4 = this.i6;
                                    this.i6 = this.i8;
                                    this.i8 = this.i10;
                                }
                                else
                                {
                                    this.i14 = 0;
                                    this.i15 = (this.i11 + 1);
                                    do 
                                    {
                                        this.i10 = (this.i10 ^ 0x01);
                                        this.i16 = (this.i15 + this.i14);
                                        this.i10 = (this.i10 & 0x01);
                                        if (!(!(this.i10 == 0)))
                                        {
                                            this.i6 = (this.i6 * 10);
                                        }
                                        else
                                        {
                                            if ((this.i16 < 17))
                                            {
                                                this.i8 = (this.i8 * 10);
                                            };
                                        };
                                        this.i10 = ((this.i16 < 9) ? 1 : 0);
                                        this.i14 = (this.i14 + 1);
                                    } while (!(this.i14 == this.i4));
                                    this.i11 = (this.i4 + this.i11);
                                    this.i4 = this.i6;
                                    this.i6 = this.i8;
                                    this.i8 = this.i10;
                                };
                                this.i10 = this.i4;
                                this.i14 = this.i6;
                                this.i4 = this.i8;
                                this.i6 = this.i11;
                                this.i4 = (this.i4 ^ 0x01);
                                this.i8 = (this.i6 + 1);
                                this.i4 = (this.i4 & 0x01);
                                if ((!(this.i4 == 0))) break;
                                this.i4 = (this.i9 + 1);
                                si32(this.i4, (public::mstate.ebp + -36));
                                this.i6 = (this.i10 * 10);
                                this.i10 = sxi8(li8(this.i9 + 1));
                                this.i12 = (this.i6 + this.i12);
                                this.i6 = (this.i10 + -48);
                                if (!(uint(this.i6) < uint(10)))
                                {
                                    this.i4 = 0;
                                    this.i6 = this.i10;
                                    this.i10 = this.i8;
                                    this.i11 = this.i5;
                                    this.i5 = this.i4;
                                    this.i4 = this.i13;
                                    this.i8 = this.i12;
                                    this.i9 = this.i14;
                                    goto _label_20;
                                };
                                this.i6 = 0;
                                this.i9 = this.i4;
                                this.i11 = this.i8;
                                this.i4 = this.i6;
                                this.i6 = this.i12;
                                this.i8 = this.i14;
                            } while (true);
                            if (!(this.i8 < 17))
                            {
                                this.i6 = 0;
                                this.i4 = this.i8;
                                this.i11 = this.i6;
                                this.i6 = this.i10;
                                this.i8 = this.i14;
                            }
                            else
                            {
                                this.i6 = 0;
                                this.i4 = (this.i14 * 10);
                                this.i12 = (this.i4 + this.i12);
                                this.i4 = this.i8;
                                this.i11 = this.i6;
                                this.i6 = this.i10;
                                this.i8 = this.i12;
                            };
                            
                        _label_19: 
                            this.i14 = this.i11;
                            this.i15 = this.i6;
                            this.i16 = this.i8;
                            this.i6 = (this.i9 + 1);
                            si32(this.i6, (public::mstate.ebp + -36));
                            this.i8 = sxi8(li8(this.i9 + 1));
                            this.i10 = this.i8;
                            this.i11 = this.i4;
                            this.i12 = this.i5;
                            this.i5 = this.i14;
                            this.i4 = this.i13;
                            this.i8 = this.i15;
                            this.i9 = this.i16;
                        };
                        this.i13 = this.i11;
                        this.i14 = this.i12;
                        this.i15 = this.i5;
                        this.i16 = this.i4;
                        this.i4 = (this.i10 + -48);
                        if (uint(this.i4) < uint(10)) goto _label_92;
                        this.i6 = this.i10;
                        this.i10 = this.i13;
                        this.i11 = this.i14;
                        this.i5 = this.i15;
                        this.i4 = this.i16;
                    };
                    
                _label_20: 
                    if (!(this.i6 == 69))
                    {
                        if (!(this.i6 == 101))
                        {
                            this.i12 = 0;
                            
                        _label_21: 
                            if (this.i10 == 0) goto _label_28;
                            this.i2 = this.i12;
                            goto _label_27;
                        };
                    };
                    if (!(!(this.i10 == 0)))
                    {
                        if (!(!(this.i2 == 0)))
                        {
                            if (this.i5 == 0) goto _label_38;
                        };
                    };
                    this.i0 = li32(public::mstate.ebp + -36);
                    this.i6 = (this.i0 + 1);
                    si32(this.i6, (public::mstate.ebp + -36));
                    this.i12 = sxi8(li8(this.i0 + 1));
                    if (!(this.i12 == 45))
                    {
                        if (!(this.i12 == 43)) goto _label_23;
                        this.i6 = 0;
                    }
                    else
                    {
                        this.i6 = 1;
                    };
                    this.i12 = (this.i0 + 2);
                    si32(this.i12, (public::mstate.ebp + -36));
                    this.i13 = sxi8(li8(this.i0 + 2));
                    this.i14 = (this.i13 + -48);
                    if (!(uint(this.i14) < uint(10)))
                    {
                        this.i6 = this.i13;
                        
                    _label_22: 
                        this.i12 = 0;
                        si32(this.i0, (public::mstate.ebp + -36));
                        goto _label_21;
                    };
                    this.i14 = this.i12;
                    this.i12 = this.i13;
                    goto _label_24;
                    
                _label_23: 
                    this.i14 = (this.i12 + -48);
                    if (!(uint(this.i14) < uint(10)))
                    {
                        this.i6 = this.i12;
                        goto _label_22;
                    };
                    this.i13 = 0;
                    this.i14 = this.i6;
                    this.i6 = this.i13;
                    
                _label_24: 
                    this.i13 = this.i14;
                    if ((this.i12 == 48))
                    {
                        this.i12 = this.i13;
                        do 
                        {
                            this.i13 = (this.i12 + 1);
                            si32(this.i13, (public::mstate.ebp + -36));
                            this.i12 = li8(this.i12 + 1);
                            if ((!(this.i12 == 48))) break;
                            this.i12 = this.i13;
                        } while (true);
                        this.i12 = (this.i12 << 24);
                        this.i12 = (this.i12 >> 24);
                    };
                    this.i14 = (this.i12 + -49);
                    if (!(uint(this.i14) < uint(9)))
                    {
                        this.i13 = 0;
                        this.i6 = this.i12;
                        this.i12 = this.i13;
                        goto _label_21;
                    };
                    this.i14 = (this.i13 + 1);
                    si32(this.i14, (public::mstate.ebp + -36));
                    this.i15 = li8(this.i13 + 1);
                    this.i16 = (this.i15 << 24);
                    this.i16 = (this.i16 >> 24);
                    this.i12 = (this.i12 + -48);
                    this.i15 = (this.i15 + -48);
                    this.i15 = (this.i15 & 0xFF);
                    if (!(uint(this.i15) < uint(10)))
                    {
                        goto _label_26;
                        
                    _label_25: 
                        this.i14 = this.i15;
                    };
                    this.i15 = (this.i14 + 1);
                    si32(this.i15, (public::mstate.ebp + -36));
                    this.i14 = li8(this.i14 + 1);
                    this.i12 = (this.i12 * 10);
                    this.i17 = (this.i14 << 24);
                    this.i12 = (this.i16 + this.i12);
                    this.i16 = (this.i17 >> 24);
                    this.i12 = (this.i12 + -48);
                    this.i14 = (this.i14 + -48);
                    this.i14 = (this.i14 & 0xFF);
                    if (uint(this.i14) < uint(10)) goto _label_25;
                    this.i14 = this.i15;
                    
                _label_26: 
                    this.i15 = this.i16;
                    this.i13 = (this.i14 - this.i13);
                    this.i13 = ((this.i13 > 8) ? 1 : 0);
                    this.i14 = ((this.i12 > 19999) ? 1 : 0);
                    this.i13 = (this.i13 | this.i14);
                    this.i13 = (this.i13 & 0x01);
                    this.i12 = ((this.i13 != 0) ? 19999 : this.i12);
                    if (!(!(this.i6 == 0)))
                    {
                        this.i6 = this.i15;
                        goto _label_21;
                    };
                    this.i6 = (0 - this.i12);
                    if (!(this.i10 == 0))
                    {
                        this.i2 = this.i6;
                        
                    _label_27: 
                        this.f0 = Number(uint(this.i8));
                        sf64(this.f0, (public::mstate.ebp + -32));
                        this.i0 = ((this.i7 == 0) ? this.i10 : this.i7);
                        this.i5 = ((this.i10 < 17) ? this.i10 : 16);
                        this.i6 = (this.i2 - this.i11);
                        if (this.i5 > 9) goto _label_42;
                        this.f1 = this.f0;
                        goto _label_43;
                    };
                    this.i6 = this.i15;
                    
                _label_28: 
                    this.i4 = this.i6;
                    this.i7 = this.i0;
                    if (!(this.i5 == 0)) goto _label_89;
                    if (!(this.i2 == 0)) goto _label_89;
                    if (!(this.i4 > 104))
                    {
                        if (this.i4 == 73) goto _label_32;
                        if (!(this.i4 == 78))
                        {
                            goto _label_31;
                        };
                        
                    _label_29: 
                        this.i2 = __2E_str237;
                        this.i4 = li32(public::mstate.ebp + -36);
                        this.i8 = 97;
                        this.i9 = 0;
                        this.i10 = this.i4;
                        
                    _label_30: 
                        this.i11 = (this.i10 + this.i9);
                        this.i11 = li8(this.i11 + 1);
                        this.i0 = (this.i11 << 24);
                        this.i0 = (this.i0 >> 24);
                        this.i11 = (this.i11 + -65);
                        this.i8 = (this.i8 << 24);
                        this.i11 = (this.i11 & 0xFF);
                        this.i5 = (this.i0 + 32);
                        this.i11 = ((uint(this.i11) > uint(25)) ? this.i0 : this.i5);
                        this.i8 = (this.i8 >> 24);
                        if (this.i11 == this.i8) goto _label_35;
                        this.i2 = 1;
                        this.i9 = this.i4;
                        goto _label_36;
                    };
                    if (!(this.i4 == 105))
                    {
                        if (this.i4 == 110) goto _label_29;
                        
                    _label_31: 
                        this.i1 = this.i7;
                        goto _label_39;
                    };
                    
                _label_32: 
                    this.i2 = __2E_str3562;
                    this.i4 = li32(public::mstate.ebp + -36);
                    this.i8 = 110;
                    this.i9 = 0;
                    this.i10 = this.i4;
                    do 
                    {
                        this.i11 = (this.i10 + this.i9);
                        this.i11 = li8(this.i11 + 1);
                        this.i0 = (this.i11 << 24);
                        this.i0 = (this.i0 >> 24);
                        this.i11 = (this.i11 + -65);
                        this.i8 = (this.i8 << 24);
                        this.i11 = (this.i11 & 0xFF);
                        this.i5 = (this.i0 + 32);
                        this.i11 = ((uint(this.i11) > uint(25)) ? this.i0 : this.i5);
                        this.i8 = (this.i8 >> 24);
                        if (!(this.i11 == this.i8))
                        {
                            this.i2 = 1;
                            this.i9 = this.i4;
                            goto _label_33;
                        };
                        this.i8 = (this.i2 + this.i9);
                        this.i8 = li8(this.i8 + 1);
                        this.i9 = (this.i9 + 1);
                    } while (!(this.i8 == 0));
                    this.i2 = 0;
                    this.i9 = (this.i9 << 0);
                    this.i9 = (this.i9 + this.i4);
                    this.i9 = (this.i9 + 1);
                    si32(this.i9, (public::mstate.ebp + -36));
                    
                _label_33: 
                    this.i4 = this.i9;
                    this.i2 = (this.i2 & 0x01);
                    this.i8 = this.i4;
                    if (!(this.i2 == 0)) goto _label_31;
                    this.i2 = __2E_str136;
                    this.i7 = (this.i4 + -1);
                    si32(this.i7, (public::mstate.ebp + -36));
                    this.i9 = 105;
                    this.i10 = 0;
                    do 
                    {
                        this.i11 = (this.i8 + this.i10);
                        this.i11 = li8(this.i11);
                        this.i0 = (this.i11 << 24);
                        this.i0 = (this.i0 >> 24);
                        this.i11 = (this.i11 + -65);
                        this.i9 = (this.i9 << 24);
                        this.i11 = (this.i11 & 0xFF);
                        this.i5 = (this.i0 + 32);
                        this.i11 = ((uint(this.i11) > uint(25)) ? this.i0 : this.i5);
                        this.i9 = (this.i9 >> 24);
                        if (!(this.i11 == this.i9))
                        {
                            this.i2 = 1;
                            goto _label_34;
                        };
                        this.i9 = (this.i2 + this.i10);
                        this.i9 = li8(this.i9 + 1);
                        this.i10 = (this.i10 + 1);
                    } while (!(this.i9 == 0));
                    this.i2 = 0;
                    this.i7 = (this.i4 + this.i10);
                    si32(this.i7, (public::mstate.ebp + -36));
                    
                _label_34: 
                    this.i4 = (public::mstate.ebp + -32);
                    this.i8 = (this.i4 + 4);
                    this.i2 = (this.i2 ^ 0x01);
                    this.i2 = (this.i2 & 0x01);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i2 = 0x7FF00000;
                        this.i7 = (this.i7 + 1);
                        si32(this.i7, (public::mstate.ebp + -36));
                        si32(this.i2, this.i8);
                        this.i2 = 0;
                        si32(this.i2, this.i4);
                        if (this.i3 == 0) goto _label_14;
                        goto _label_12;
                    };
                    this.i2 = 0x7FF00000;
                    si32(this.i2, this.i8);
                    this.i2 = 0;
                    si32(this.i2, this.i4);
                    if (this.i3 == 0) goto _label_14;
                    goto _label_12;
                    
                _label_35: 
                    this.i8 = (this.i2 + this.i9);
                    this.i8 = li8(this.i8 + 1);
                    this.i9 = (this.i9 + 1);
                    if (!(this.i8 == 0)) goto _label_30;
                    this.i2 = 0;
                    this.i9 = (this.i9 << 0);
                    this.i9 = (this.i9 + this.i4);
                    this.i9 = (this.i9 + 1);
                    si32(this.i9, (public::mstate.ebp + -36));
                    
                _label_36: 
                    this.i4 = this.i9;
                    this.i2 = (this.i2 & 0x01);
                    if (!(this.i2 == 0)) goto _label_31;
                    this.i2 = li8(this.i4);
                    if (!(this.i2 == 40)) goto _label_37;
                    this.i2 = _fpinan_2E_3736;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (public::mstate.ebp + -36);
                    this.i7 = (public::mstate.ebp + -8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___hexnan_D2A.start();
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i2 == 5)))
                    {
                        this.i2 = li32(public::mstate.ebp + -4);
                        this.i2 = (this.i2 | 0x7FF00000);
                        si32(this.i2, (public::mstate.ebp + -28));
                        this.i2 = li32(this.i7);
                        si32(this.i2, (public::mstate.ebp + -32));
                        if (this.i3 == 0) goto _label_14;
                        goto _label_12;
                    };
                    
                _label_37: 
                    this.i2 = 0x7FF80000;
                    si32(this.i2, (public::mstate.ebp + -28));
                    this.i2 = 0;
                    si32(this.i2, (public::mstate.ebp + -32));
                    if (this.i3 == 0) goto _label_14;
                    goto _label_12;
                    
                _label_38: 
                    this.i1 = this.i0;
                    
                _label_39: 
                    this.i2 = this.i1;
                    si32(this.i2, (public::mstate.ebp + -36));
                    if (!(this.i3 == 0))
                    {
                        goto _label_7;
                    };
                    
                _label_40: 
                    this.i2 = 0;
                    do 
                    {
                        
                    _label_41: 
                        this.i0 = this.i2;
                        this.f0 = lf64(public::mstate.ebp + -32);
                        if (!(this.i0 == 0))
                        {
                            this.f0 = -(this.f0);
                        };
                        public::mstate.st0 = this.f0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_42: 
                        this.i7 = ___tens_D2A;
                        this.i12 = (this.i5 << 3);
                        this.i7 = (this.i12 + this.i7);
                        this.f1 = lf64(this.i7 + -72);
                        this.f2 = Number(uint(this.i9));
                        this.f0 = (this.f1 * this.f0);
                        this.f0 = (this.f0 + this.f2);
                        sf64(this.f0, (public::mstate.ebp + -32));
                        this.f1 = this.f0;
                        
                    _label_43: 
                        if ((this.i10 > 15)) break;
                        if (this.i2 == this.i11) goto _label_89;
                        if (!(this.i6 < 1))
                        {
                            if (!(this.i6 > 22))
                            {
                                this.i2 = ___tens_D2A;
                                this.i0 = (this.i6 << 3);
                                this.i2 = (this.i2 + this.i0);
                                if (!(this.i1 == 0))
                                {
                                    this.f1 = lf64(this.i2);
                                    this.f0 = -(this.f0);
                                    this.f0 = (this.f1 * this.f0);
                                    sf64(this.f0, (public::mstate.ebp + -32));
                                    if (this.i3 == 0) goto _label_40;
                                    goto _label_7;
                                };
                                this.f1 = lf64(this.i2);
                                this.f0 = (this.f0 * this.f1);
                                sf64(this.f0, (public::mstate.ebp + -32));
                                if (this.i3 == 0) goto _label_14;
                                goto _label_12;
                            };
                            this.i2 = (15 - this.i10);
                            this.i7 = (37 - this.i10);
                            if ((this.i7 < this.i6)) break;
                            if (!(!(this.i1 == 0)))
                            {
                                this.i0 = this.i1;
                            }
                            else
                            {
                                this.i0 = 0;
                                this.f0 = -(this.f0);
                                sf64(this.f0, (public::mstate.ebp + -32));
                            };
                            this.i1 = ___tens_D2A;
                            this.i4 = (this.i2 << 3);
                            this.i2 = (this.i6 - this.i2);
                            this.i2 = (this.i2 << 3);
                            this.i4 = (this.i1 + this.i4);
                            this.f1 = lf64(this.i4);
                            this.i2 = (this.i1 + this.i2);
                            this.f2 = lf64(this.i2);
                            this.f0 = (this.f0 * this.f1);
                            this.f0 = (this.f0 * this.f2);
                            sf64(this.f0, (public::mstate.ebp + -32));
                            if (!(this.i3 == 0))
                            {
                                this.i2 = this.i0;
                                goto _label_8;
                            };
                            this.i2 = this.i0;
                            continue;
                        };
                        if ((this.i6 < -22)) break;
                        if (!(!(this.i1 == 0)))
                        {
                            this.i2 = this.i1;
                        }
                        else
                        {
                            this.i2 = 0;
                            this.f0 = -(this.f0);
                            sf64(this.f0, (public::mstate.ebp + -32));
                        };
                        this.f1 = this.f0;
                        this.i0 = ___tens_D2A;
                        this.i1 = (0 - this.i6);
                        this.i1 = (this.i1 << 3);
                        this.i0 = (this.i0 + this.i1);
                        this.f0 = lf64(this.i0);
                        this.f1 = (this.f1 / this.f0);
                        sf64(this.f1, (public::mstate.ebp + -32));
                        if (!(this.i3 == 0)) goto _label_8;
                    } while (true);
                    this.i2 = (this.i10 - this.i5);
                    this.i2 = (this.i6 + this.i2);
                    if (this.i2 < 1) goto _label_52;
                    this.i5 = (this.i2 & 0x0F);
                    if ((!(this.i5 == 0)))
                    {
                        this.i7 = ___tens_D2A;
                        this.i5 = (this.i5 << 3);
                        this.i5 = (this.i7 + this.i5);
                        this.f0 = lf64(this.i5);
                        this.f1 = (this.f1 * this.f0);
                        sf64(this.f1, (public::mstate.ebp + -32));
                    };
                    this.i5 = (this.i2 & 0xFFFFFFF0);
                    if (uint(this.i2) > uint(15)) goto _label_46;
                    
                _label_44: 
                    this.i2 = 0;
                    
                _label_45: 
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___s2b_D2A.start();
                    return;
                case 6:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = this.i2;
                    this.i2 = this.i4;
                    goto _label_49;
                    
                _label_46: 
                    if (!(this.i5 < 309))
                    {
                        
                    _label_47: 
                        this.i2 = 0;
                        this.i4 = this.i0;
                        this.i5 = this.i0;
                        
                    _label_48: 
                        this.i6 = 34;
                        si32(this.i6, _val_2E_1440);
                        this.i6 = 0x7FF00000;
                        si32(this.i6, (public::mstate.ebp + -28));
                        this.i6 = 0;
                        si32(this.i6, (public::mstate.ebp + -32));
                        if (this.i2 == 0) goto _label_89;
                        goto _label_88;
                    };
                    this.i2 = (this.i5 >> 4);
                    if (!(this.i2 > 1))
                    {
                        this.i2 = 0;
                    }
                    else
                    {
                        this.i5 = ___bigtens_D2A;
                        this.i7 = 0;
                        do 
                        {
                            this.i9 = this.i5;
                            this.i11 = (this.i2 & 0x01);
                            if ((!(this.i11 == 0)))
                            {
                                this.f0 = lf64(this.i9);
                                this.f1 = (this.f1 * this.f0);
                            };
                            this.i5 = (this.i5 + 8);
                            this.i7 = (this.i7 + 1);
                            this.i2 = (this.i2 >> 1);
                        } while (!(this.i2 < 2));
                        sf64(this.f1, (public::mstate.ebp + -32));
                        this.i2 = this.i7;
                    };
                    this.i5 = ___bigtens_D2A;
                    this.i7 = li32(public::mstate.ebp + -28);
                    this.i2 = (this.i2 << 3);
                    this.i7 = (this.i7 + -55574528);
                    si32(this.i7, (public::mstate.ebp + -28));
                    this.i2 = (this.i5 + this.i2);
                    this.f1 = lf64(public::mstate.ebp + -32);
                    this.f0 = lf64(this.i2);
                    this.f1 = (this.f1 * this.f0);
                    sf64(this.f1, (public::mstate.ebp + -32));
                    this.i2 = li32(public::mstate.ebp + -28);
                    this.i5 = (public::mstate.ebp + -32);
                    this.i7 = (this.i2 & 0x7FF00000);
                    this.i5 = (this.i5 + 4);
                    if (uint(this.i7) > uint(0x7CA00000)) goto _label_47;
                    if (uint(this.i7) < uint(0x7C900001)) goto _label_51;
                    this.i2 = 2146435071;
                    si32(this.i2, this.i5);
                    this.i2 = -1;
                    si32(this.i2, (public::mstate.ebp + -32));
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___s2b_D2A.start();
                    return;
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = 0;
                    
                _label_49: 
                    this.i4 = (public::mstate.ebp + -32);
                    this.i5 = (this.i4 + 4);
                    this.i7 = (0 - this.i6);
                    this.i8 = (this.i2 + 12);
                    this.i9 = (this.i2 + 16);
                    this.i10 = (this.i2 + 4);
                    
                _label_50: 
                    this.i11 = (public::mstate.ebp + -40);
                    this.i12 = li32(this.i10);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i12, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___Balloc_D2A.start();
                    return;
                case 8:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i13 = li32(this.i9);
                    this.i14 = (this.i12 + 12);
                    this.i13 = (this.i13 << 2);
                    this.i15 = this.i8;
                    this.i13 = (this.i13 + 8);
                    memcpy(this.i14, this.i15, this.i13);
                    this.f0 = lf64(public::mstate.ebp + -32);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i13 = (public::mstate.ebp + -44);
                    sf64(this.f0, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i11, (public::mstate.esp + 12));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___d2b_D2A.start();
                    return;
                case 9:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i11, (public::mstate.ebp + -24));
                    this.i11 = li32(_freelist + 4);
                    if (this.i11 == 0) goto _label_56;
                    this.i13 = li32(this.i11);
                    si32(this.i13, (_freelist + 4));
                    goto _label_57;
                    
                _label_51: 
                    this.i7 = 0;
                    this.i2 = (this.i2 + 55574528);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___s2b_D2A.start();
                    return;
                case 10:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = this.i7;
                    goto _label_49;
                    
                _label_52: 
                    if (this.i2 > -1) goto _label_44;
                    this.i2 = (0 - this.i2);
                    this.i5 = (this.i2 & 0x0F);
                    if ((!(this.i5 == 0)))
                    {
                        this.i7 = ___tens_D2A;
                        this.i5 = (this.i5 << 3);
                        this.i5 = (this.i7 + this.i5);
                        this.f0 = lf64(this.i5);
                        this.f1 = (this.f1 / this.f0);
                        sf64(this.f1, (public::mstate.ebp + -32));
                    };
                    this.f0 = this.f1;
                    this.i5 = (this.i2 >> 4);
                    if (uint(this.i2) < uint(16)) goto _label_44;
                    if (!(this.i5 < 32))
                    {
                        
                    _label_53: 
                        this.i2 = 0;
                        this.i4 = this.i0;
                        this.i5 = this.i0;
                        
                    _label_54: 
                        this.i6 = 0;
                        si32(this.i6, (public::mstate.ebp + -32));
                        si32(this.i6, (public::mstate.ebp + -28));
                        this.i6 = 34;
                        si32(this.i6, _val_2E_1440);
                        if (this.i2 == 0) goto _label_89;
                        goto _label_88;
                    };
                    this.i2 = (this.i5 & 0x10);
                    this.i2 = ((this.i2 == 0) ? 0 : 106);
                    if (!(this.i5 < 1))
                    {
                        this.i7 = _tinytens;
                        do 
                        {
                            this.i9 = this.i7;
                            this.i11 = (this.i5 & 0x01);
                            if ((!(this.i11 == 0)))
                            {
                                this.f1 = lf64(this.i9);
                                this.f0 = (this.f0 * this.f1);
                            };
                            this.i7 = (this.i7 + 8);
                            this.i5 = (this.i5 >> 1);
                        } while (!(this.i5 < 1));
                        sf64(this.f0, (public::mstate.ebp + -32));
                    };
                    if (!(this.i2 == 0))
                    {
                        this.i5 = (public::mstate.ebp + -32);
                        this.i7 = li32(public::mstate.ebp + -28);
                        this.i9 = (this.i7 >>> 20);
                        this.i9 = (this.i9 & 0x07FF);
                        this.i9 = (107 - this.i9);
                        this.i5 = (this.i5 + 4);
                        if (!(this.i9 < 1))
                        {
                            this.i11 = (public::mstate.ebp + -32);
                            if (!(this.i9 < 32))
                            {
                                this.i12 = 0;
                                si32(this.i12, this.i11);
                                if (!(this.i9 < 53))
                                {
                                    this.i7 = 57671680;
                                    si32(this.i7, this.i5);
                                    this.f0 = lf64(public::mstate.ebp + -32);
                                    this.f1 = 0;
                                    if (this.f0 == this.f1) goto _label_53;
                                    
                                _label_55: 
                                    goto _label_45;
                                };
                                this.i11 = -1;
                                this.i9 = (this.i9 + -32);
                                this.i9 = (this.i11 << this.i9);
                                this.i9 = (this.i7 & this.i9);
                                si32(this.i9, this.i5);
                                this.f0 = lf64(public::mstate.ebp + -32);
                                this.f1 = 0;
                                if (this.f0 == this.f1) goto _label_53;
                                goto _label_55;
                            };
                            this.i5 = -1;
                            this.i7 = li32(this.i11);
                            this.i5 = (this.i5 << this.i9);
                            this.i5 = (this.i7 & this.i5);
                            si32(this.i5, this.i11);
                        };
                    };
                    this.f0 = 0;
                    this.f1 = lf64(public::mstate.ebp + -32);
                    if (this.f1 == this.f0) goto _label_53;
                    goto _label_55;
                    
                _label_56: 
                    this.i11 = _private_mem;
                    this.i13 = li32(_pmem_next);
                    this.i11 = (this.i13 - this.i11);
                    this.i11 = (this.i11 >> 3);
                    this.i11 = (this.i11 + 4);
                    if (!(uint(this.i11) > uint(288)))
                    {
                        this.i11 = 1;
                        this.i14 = (this.i13 + 32);
                        si32(this.i14, _pmem_next);
                        si32(this.i11, (this.i13 + 4));
                        this.i11 = 2;
                        si32(this.i11, (this.i13 + 8));
                        this.i11 = this.i13;
                        goto _label_57;
                    };
                    this.i11 = 32;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i13 = 0;
                    si32(this.i13, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 11:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i13 = 1;
                    si32(this.i13, (this.i11 + 4));
                    this.i13 = 2;
                    si32(this.i13, (this.i11 + 8));
                    
                _label_57: 
                    this.i13 = 0;
                    si32(this.i13, (this.i11 + 12));
                    this.i13 = 1;
                    si32(this.i13, (this.i11 + 20));
                    si32(this.i13, (this.i11 + 16));
                    if (!(this.i6 < 0))
                    {
                        this.i13 = 0;
                        this.i14 = this.i13;
                        this.i15 = this.i6;
                        this.i16 = this.i6;
                    }
                    else
                    {
                        this.i16 = 0;
                        this.i14 = this.i7;
                        this.i13 = this.i7;
                        this.i15 = this.i16;
                    };
                    this.i17 = li32(public::mstate.ebp + -44);
                    this.i18 = li32(public::mstate.ebp + -40);
                    this.i19 = (this.i17 - this.i0);
                    this.i20 = (this.i18 + this.i19);
                    this.i15 = (this.i15 + this.i0);
                    this.i21 = (this.i15 - this.i17);
                    this.i22 = (this.i14 + this.i17);
                    this.i20 = (this.i20 + -1);
                    this.i19 = (this.i19 + 1075);
                    this.i18 = (54 - this.i18);
                    this.i14 = ((this.i17 < 0) ? this.i14 : this.i22);
                    this.i18 = ((this.i20 < -1022) ? this.i19 : this.i18);
                    this.i15 = ((this.i17 > -1) ? this.i15 : this.i21);
                    this.i15 = (this.i15 + this.i18);
                    this.i17 = (this.i18 + this.i14);
                    this.i18 = ((this.i15 <= this.i17) ? this.i15 : this.i17);
                    this.i18 = ((this.i18 > this.i14) ? this.i14 : this.i18);
                    this.i18 = ((this.i18 > 0) ? this.i18 : 0);
                    this.i14 = (this.i14 - this.i18);
                    this.i15 = (this.i15 - this.i18);
                    this.i17 = (this.i17 - this.i18);
                    if (!(this.i13 > 0)) goto _label_58;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___pow5mult_D2A.start();
                    return;
                case 12:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i13 = li32(public::mstate.ebp + -24);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___mult_D2A.start();
                    return;
                case 13:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i18 = li32(public::mstate.ebp + -24);
                    if (!(this.i18 == 0))
                    {
                        this.i19 = _freelist;
                        this.i20 = li32(this.i18 + 4);
                        this.i20 = (this.i20 << 2);
                        this.i19 = (this.i19 + this.i20);
                        this.i20 = li32(this.i19);
                        si32(this.i20, this.i18);
                        si32(this.i18, this.i19);
                    };
                    si32(this.i13, (public::mstate.ebp + -24));
                    
                _label_58: 
                    if (this.i17 < 1) goto _label_59;
                    this.i13 = li32(public::mstate.ebp + -24);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i17, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___lshift_D2A.start();
                    return;
                case 14:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i13, (public::mstate.ebp + -24));
                    
                _label_59: 
                    if (!(this.i16 > 0)) goto _label_60;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___pow5mult_D2A.start();
                    return;
                case 15:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_60: 
                    if (!(this.i15 > 0)) goto _label_61;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___lshift_D2A.start();
                    return;
                case 16:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_61: 
                    if (!(this.i14 > 0)) goto _label_62;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___lshift_D2A.start();
                    return;
                case 17:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_62: 
                    this.i13 = 0;
                    this.i14 = li32(public::mstate.ebp + -24);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___diff_D2A.start();
                    return;
                case 18:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i15 = li32(this.i14 + 12);
                    si32(this.i13, (this.i14 + 12));
                    this.i13 = li32(this.i14 + 16);
                    this.i16 = li32(this.i11 + 16);
                    this.i17 = (this.i13 - this.i16);
                    this.i18 = (this.i11 + 16);
                    if (!(this.i13 == this.i16))
                    {
                        this.i16 = this.i17;
                    }
                    else
                    {
                        this.i17 = 0;
                        
                    _label_63: 
                        this.i19 = (this.i17 ^ 0xFFFFFFFF);
                        this.i19 = (this.i16 + this.i19);
                        this.i20 = (this.i19 << 2);
                        this.i21 = (this.i14 + this.i20);
                        this.i20 = (this.i11 + this.i20);
                        this.i21 = li32(this.i21 + 20);
                        this.i20 = li32(this.i20 + 20);
                        if (!(this.i21 == this.i20))
                        {
                            this.i16 = ((uint(this.i21) < uint(this.i20)) ? -1 : 1);
                        }
                        else
                        {
                            this.i17 = (this.i17 + 1);
                            if (this.i19 > 0) goto _label_93;
                            this.i16 = 0;
                        };
                    };
                    if (this.i16 > -1) goto _label_66;
                    if (!(this.i15 == 0))
                    {
                        
                    _label_64: 
                        this.i6 = this.i14;
                        goto _label_85;
                    };
                    this.i6 = li32(this.i4);
                    if (!(this.i6 == 0)) goto _label_64;
                    this.i6 = li32(this.i5);
                    this.i7 = (this.i6 & 0x0FFFFF);
                    if (!(this.i7 == 0)) goto _label_64;
                    this.i6 = (this.i6 & 0x7FF00000);
                    if (uint(this.i6) < uint(112197633)) goto _label_64;
                    this.i6 = li32(this.i14 + 20);
                    if (!(!(this.i6 == 0)))
                    {
                        if (this.i13 < 2) goto _label_64;
                    };
                    this.i6 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___lshift_D2A.start();
                    return;
                case 19:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i6 + 16);
                    this.i8 = li32(this.i18);
                    this.i9 = (this.i7 - this.i8);
                    if (!(this.i7 == this.i8))
                    {
                        this.i8 = this.i9;
                    }
                    else
                    {
                        this.i7 = 0;
                        
                    _label_65: 
                        this.i9 = (this.i7 ^ 0xFFFFFFFF);
                        this.i9 = (this.i8 + this.i9);
                        this.i10 = (this.i9 << 2);
                        this.i14 = (this.i6 + this.i10);
                        this.i10 = (this.i11 + this.i10);
                        this.i14 = li32(this.i14 + 20);
                        this.i10 = li32(this.i10 + 20);
                        if (!(this.i14 == this.i10))
                        {
                            this.i7 = ((uint(this.i14) < uint(this.i10)) ? -1 : 1);
                            this.i8 = this.i7;
                        }
                        else
                        {
                            this.i7 = (this.i7 + 1);
                            if (this.i9 > 0) goto _label_94;
                            this.i7 = 0;
                            this.i8 = this.i7;
                        };
                    };
                    this.i7 = this.i8;
                    if (!(this.i7 > 0)) goto _label_85;
                    goto _label_70;
                    
                _label_66: 
                    if (!(this.i16 == 0)) goto _label_74;
                    this.i6 = li32(this.i5);
                    this.i7 = (this.i6 & 0x0FFFFF);
                    if (!(this.i15 == 0))
                    {
                        if (!(this.i7 == 0xFFFFF)) goto _label_71;
                        this.i7 = li32(this.i4);
                        if (!(!(this.i0 == 0)))
                        {
                            
                        _label_67: 
                            this.i8 = -1;
                            goto _label_68;
                        };
                        this.i8 = (this.i6 & 0x7FF00000);
                        if (uint(this.i8) > uint(111149056)) goto _label_67;
                        this.i9 = -1;
                        this.i8 = (this.i8 >>> 20);
                        this.i8 = (107 - this.i8);
                        this.i8 = (this.i9 << this.i8);
                        
                    _label_68: 
                        if (!(this.i7 == this.i8)) goto _label_71;
                        this.i7 = 0;
                        this.i6 = (this.i6 & 0x7FF00000);
                        this.i6 = (this.i6 + 0x100000);
                        si32(this.i6, this.i5);
                        si32(this.i7, this.i4);
                        if (this.i0 == 0) goto _label_72;
                        
                    _label_69: 
                        this.i0 = this.i14;
                        goto _label_86;
                    };
                    if (!(!(this.i7 == 0)))
                    {
                        this.i6 = li32(this.i4);
                        if (!(!(this.i6 == 0)))
                        {
                            this.i6 = this.i14;
                            
                        _label_70: 
                            this.i7 = li32(this.i5);
                            this.i7 = (this.i7 & 0x7FF00000);
                            if (!(this.i0 == 0))
                            {
                                if (!(this.i7 > 112197632))
                                {
                                    if (this.i7 > 57671680) goto _label_85;
                                    this.i4 = this.i12;
                                    this.i5 = this.i11;
                                    this.i0 = this.i6;
                                    goto _label_54;
                                };
                                this.i8 = -1;
                                this.i7 = (this.i7 + -1048576);
                                this.i7 = (this.i7 | 0x0FFFFF);
                                si32(this.i7, this.i5);
                                si32(this.i8, this.i4);
                                if (!(this.i0 == 0))
                                {
                                    this.i0 = this.i6;
                                    goto _label_86;
                                };
                                this.i4 = this.i12;
                                this.i5 = this.i11;
                                this.i0 = this.i6;
                                goto _label_88;
                            };
                            this.i0 = -1;
                            this.i7 = (this.i7 + -1048576);
                            this.i7 = (this.i7 | 0x0FFFFF);
                            si32(this.i7, this.i5);
                            si32(this.i0, this.i4);
                            this.i4 = this.i12;
                            this.i5 = this.i11;
                            this.i0 = this.i6;
                            goto _label_88;
                        };
                    };
                    
                _label_71: 
                    this.i6 = li32(this.i4);
                    this.i6 = (this.i6 & 0x01);
                    if (this.i6 == 0) goto _label_64;
                    this.f0 = lf64(public::mstate.ebp + -32);
                    public::mstate.esp = (public::mstate.esp - 8);
                    sf64(this.f0, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___ulp_D2A.start();
                case 20:
                    this.f1 = public::mstate.st0;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i15 == 0))
                    {
                        this.f0 = (this.f0 + this.f1);
                        sf64(this.f0, (public::mstate.ebp + -32));
                        if (!(this.i0 == 0)) goto _label_69;
                        
                    _label_72: 
                        this.i4 = this.i12;
                        this.i5 = this.i11;
                        this.i0 = this.i14;
                        goto _label_88;
                    };
                    this.f2 = 0;
                    this.f0 = (this.f0 - this.f1);
                    sf64(this.f0, (public::mstate.ebp + -32));
                    if (!(this.f0 == this.f2)) goto _label_64;
                    
                _label_73: 
                    this.i4 = this.i12;
                    this.i5 = this.i11;
                    this.i0 = this.i14;
                    goto _label_54;
                    
                _label_74: 
                    this.f0 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___ratio_D2A.start();
                case 21:
                    this.f1 = public::mstate.st0;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.f1 > this.f0))
                    {
                        if (!(this.i15 == 0))
                        {
                            this.f1 = 1;
                            this.i13 = 0x3FF00000;
                            this.i16 = 0;
                            goto _label_78;
                        };
                        this.i13 = li32(this.i4);
                        if (!(this.i13 == 0))
                        {
                            if (this.i13 == 1) goto _label_76;
                            
                        _label_75: 
                            this.f1 = 1;
                            this.i13 = -1074790400;
                            this.i16 = 0;
                            goto _label_78;
                        };
                        this.i16 = li32(this.i5);
                        this.i17 = (this.i16 & 0x0FFFFF);
                        if (!(this.i17 == 0))
                        {
                            if (!(this.i13 == 1)) goto _label_75;
                            
                        _label_76: 
                            this.i16 = li32(this.i5);
                            if (this.i16 == 0) goto _label_73;
                            goto _label_75;
                        };
                        this.f0 = 1;
                        if (!(this.f1 >= this.f0))
                        {
                            this.f1 = 0.5;
                            this.i13 = -1075838976;
                            this.i16 = 0;
                            goto _label_78;
                        };
                        this.f1 = (this.f1 * 0.5);
                        this.f0 = -(this.f1);
                        sf64(this.f0, (public::mstate.ebp + -56));
                        this.i13 = li32(public::mstate.ebp + -56);
                        this.i17 = li32(public::mstate.ebp + -52);
                        this.i18 = (this.i16 & 0x7FF00000);
                        if (!(this.i18 == 0x7FE00000))
                        {
                            this.i16 = this.i17;
                            this.i17 = this.i18;
                            
                        _label_77: 
                            if (!(uint(this.i17) > uint(111149056)))
                            {
                                if (!(this.i0 == 0)) goto _label_80;
                            };
                            goto _label_81;
                        };
                        goto _label_79;
                    };
                    this.f1 = (this.f1 * 0.5);
                    this.f0 = -(this.f1);
                    this.f0 = ((this.i15 == 0) ? this.f0 : this.f1);
                    sf64(this.f0, (public::mstate.ebp + -64));
                    this.i13 = li32(public::mstate.ebp + -64);
                    this.i17 = li32(public::mstate.ebp + -60);
                    this.i16 = this.i13;
                    this.i13 = this.i17;
                    
                _label_78: 
                    this.i17 = this.i16;
                    this.i18 = this.i13;
                    this.i13 = li32(this.i5);
                    this.i19 = (this.i13 & 0x7FF00000);
                    if (!(this.i19 == 0x7FE00000))
                    {
                        this.i13 = this.i17;
                        this.i16 = this.i18;
                        this.i17 = this.i19;
                        goto _label_77;
                    };
                    this.i16 = this.i13;
                    this.i13 = this.i17;
                    this.i17 = this.i18;
                    this.i18 = this.i19;
                    
                _label_79: 
                    this.i19 = li32(public::mstate.ebp + -32);
                    this.i20 = li32(public::mstate.ebp + -28);
                    this.i16 = (this.i16 + -55574528);
                    si32(this.i16, this.i5);
                    this.f0 = lf64(public::mstate.ebp + -32);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i13, (public::mstate.ebp + -72));
                    si32(this.i17, (public::mstate.ebp + -68));
                    sf64(this.f0, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___ulp_D2A.start();
                case 22:
                    this.f2 = public::mstate.st0;
                    this.f3 = lf64(public::mstate.ebp + -72);
                    this.f2 = (this.f2 * this.f3);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f0 = (this.f0 + this.f2);
                    sf64(this.f0, (public::mstate.ebp + -32));
                    this.i13 = li32(this.i5);
                    this.i16 = (this.i13 & 0x7FF00000);
                    if (!(uint(this.i16) < uint(0x7CA00000)))
                    {
                        if (!(!(this.i20 == 2146435071)))
                        {
                            if (!(!(this.i19 == -1)))
                            {
                                this.i4 = this.i12;
                                this.i5 = this.i11;
                                this.i0 = this.i14;
                                goto _label_48;
                            };
                        };
                        this.i13 = 2146435071;
                        si32(this.i13, this.i5);
                        this.i13 = -1;
                        si32(this.i13, this.i4);
                        this.i13 = li32(public::mstate.ebp + -24);
                        if (!(this.i13 == 0))
                        {
                            this.i15 = _freelist;
                            this.i16 = li32(this.i13 + 4);
                            this.i16 = (this.i16 << 2);
                            this.i15 = (this.i15 + this.i16);
                            this.i16 = li32(this.i15);
                            si32(this.i16, this.i13);
                            si32(this.i13, this.i15);
                        };
                        if (!(this.i12 == 0))
                        {
                            this.i13 = _freelist;
                            this.i15 = li32(this.i12 + 4);
                            this.i15 = (this.i15 << 2);
                            this.i13 = (this.i13 + this.i15);
                            this.i15 = li32(this.i13);
                            si32(this.i15, this.i12);
                            si32(this.i12, this.i13);
                        };
                        if (!(this.i11 == 0))
                        {
                            this.i13 = _freelist;
                            this.i12 = li32(this.i11 + 4);
                            this.i12 = (this.i12 << 2);
                            this.i13 = (this.i13 + this.i12);
                            this.i12 = li32(this.i13);
                            si32(this.i12, this.i11);
                            si32(this.i11, this.i13);
                        };
                        if (this.i14 == 0) goto _label_50;
                        this.i13 = _freelist;
                        this.i11 = li32(this.i14 + 4);
                        this.i11 = (this.i11 << 2);
                        this.i13 = (this.i13 + this.i11);
                        this.i11 = li32(this.i13);
                        si32(this.i11, this.i14);
                        si32(this.i14, this.i13);
                        goto _label_50;
                    };
                    this.i13 = (this.i13 + 55574528);
                    si32(this.i13, this.i5);
                    if (!(this.i0 == 0)) goto _label_84;
                    this.i13 = this.i18;
                    goto _label_82;
                    
                _label_80: 
                    this.f0 = 2147480000;
                    if ((this.f1 <= this.f0))
                    {
                        this.f0 = 1;
                        this.i13 = uint(this.f1);
                        this.f1 = Number(uint(this.i13));
                        this.f1 = ((this.i13 == 0) ? this.f0 : this.f1);
                        this.f0 = -(this.f1);
                        this.f0 = ((this.i15 == 0) ? this.f0 : this.f1);
                        sf64(this.f0, (public::mstate.ebp + -80));
                        this.i13 = li32(public::mstate.ebp + -80);
                        this.i16 = li32(public::mstate.ebp + -76);
                    };
                    this.i18 = (112197632 - this.i17);
                    this.i16 = (this.i18 + this.i16);
                    
                _label_81: 
                    this.f0 = lf64(public::mstate.ebp + -32);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i13, (public::mstate.ebp + -88));
                    si32(this.i16, (public::mstate.ebp + -84));
                    sf64(this.f0, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___ulp_D2A.start();
                case 23:
                    this.f2 = public::mstate.st0;
                    this.f3 = lf64(public::mstate.ebp + -88);
                    this.f2 = (this.f2 * this.f3);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f0 = (this.f0 + this.f2);
                    sf64(this.f0, (public::mstate.ebp + -32));
                    if (!(!(this.i0 == 0)))
                    {
                        this.i13 = this.i17;
                        
                    _label_82: 
                        this.f0 = this.f1;
                        this.i16 = li32(this.i5);
                        this.i17 = (this.i16 & 0x7FF00000);
                        if (!(!(this.i13 == this.i17)))
                        {
                            this.i13 = int(this.f0);
                            this.f1 = Number(this.i13);
                            this.f0 = (this.f0 - this.f1);
                            if (!(!(this.i15 == 0)))
                            {
                                this.i13 = li32(this.i4);
                                if (!(!(this.i13 == 0)))
                                {
                                    this.i13 = (this.i16 & 0x0FFFFF);
                                    if (this.i13 == 0) goto _label_83;
                                };
                            };
                            this.f1 = 0.5;
                            if (this.f0 < this.f1) goto _label_64;
                            this.f1 = 0.5;
                            if (this.f0 > this.f1) goto _label_64;
                            goto _label_84;
                            
                        _label_83: 
                            this.f1 = 0.25;
                            if (this.f0 < this.f1) goto _label_64;
                        };
                    };
                    
                _label_84: 
                    this.i13 = li32(public::mstate.ebp + -24);
                    if (!(this.i13 == 0))
                    {
                        this.i15 = _freelist;
                        this.i16 = li32(this.i13 + 4);
                        this.i16 = (this.i16 << 2);
                        this.i15 = (this.i15 + this.i16);
                        this.i16 = li32(this.i15);
                        si32(this.i16, this.i13);
                        si32(this.i13, this.i15);
                    };
                    if (!(this.i12 == 0))
                    {
                        this.i13 = _freelist;
                        this.i15 = li32(this.i12 + 4);
                        this.i15 = (this.i15 << 2);
                        this.i13 = (this.i13 + this.i15);
                        this.i15 = li32(this.i13);
                        si32(this.i15, this.i12);
                        si32(this.i12, this.i13);
                    };
                    if (!(this.i11 == 0))
                    {
                        this.i12 = _freelist;
                        this.i13 = li32(this.i11 + 4);
                        this.i13 = (this.i13 << 2);
                        this.i12 = (this.i12 + this.i13);
                        this.i13 = li32(this.i12);
                        si32(this.i13, this.i11);
                        si32(this.i11, this.i12);
                    };
                    if (this.i14 == 0) goto _label_50;
                    this.i11 = _freelist;
                    this.i12 = li32(this.i14 + 4);
                    this.i12 = (this.i12 << 2);
                    this.i11 = (this.i11 + this.i12);
                    this.i12 = li32(this.i11);
                    si32(this.i12, this.i14);
                    si32(this.i14, this.i11);
                    goto _label_50;
                    
                _label_85: 
                    if (!(this.i0 == 0))
                    {
                        this.i0 = this.i6;
                        
                    _label_86: 
                        this.f0 = lf64(public::mstate.ebp + -32);
                        this.f0 = (this.f0 * 1.2326E-32);
                        sf64(this.f0, (public::mstate.ebp + -32));
                        this.i5 = li32(this.i5);
                        if (!(this.i5 == 0))
                        {
                            
                        _label_87: 
                            this.i4 = this.i12;
                            this.i5 = this.i11;
                            goto _label_88;
                        };
                        this.i4 = li32(this.i4);
                        if (!(this.i4 == 0)) goto _label_87;
                        this.i4 = 34;
                        si32(this.i4, _val_2E_1440);
                        this.i4 = this.i12;
                        this.i5 = this.i11;
                        
                    _label_88: 
                        this.i6 = li32(public::mstate.ebp + -24);
                        if (!(this.i6 == 0))
                        {
                            this.i7 = _freelist;
                            this.i8 = li32(this.i6 + 4);
                            this.i8 = (this.i8 << 2);
                            this.i7 = (this.i7 + this.i8);
                            this.i8 = li32(this.i7);
                            si32(this.i8, this.i6);
                            si32(this.i6, this.i7);
                        };
                        if (!(this.i4 == 0))
                        {
                            this.i6 = _freelist;
                            this.i7 = li32(this.i4 + 4);
                            this.i7 = (this.i7 << 2);
                            this.i6 = (this.i6 + this.i7);
                            this.i7 = li32(this.i6);
                            si32(this.i7, this.i4);
                            si32(this.i4, this.i6);
                        };
                        if (!(this.i5 == 0))
                        {
                            this.i4 = _freelist;
                            this.i6 = li32(this.i5 + 4);
                            this.i6 = (this.i6 << 2);
                            this.i4 = (this.i4 + this.i6);
                            this.i6 = li32(this.i4);
                            si32(this.i6, this.i5);
                            si32(this.i5, this.i4);
                        };
                        if (!(this.i2 == 0))
                        {
                            this.i4 = _freelist;
                            this.i5 = li32(this.i2 + 4);
                            this.i5 = (this.i5 << 2);
                            this.i4 = (this.i4 + this.i5);
                            this.i5 = li32(this.i4);
                            si32(this.i5, this.i2);
                            si32(this.i2, this.i4);
                        };
                        if (!(this.i0 == 0))
                        {
                            this.i2 = _freelist;
                            this.i4 = li32(this.i0 + 4);
                            this.i4 = (this.i4 << 2);
                            this.i2 = (this.i2 + this.i4);
                            this.i4 = li32(this.i2);
                            si32(this.i4, this.i0);
                            si32(this.i0, this.i2);
                        };
                        
                    _label_89: 
                        if (this.i3 == 0) goto _label_14;
                        goto _label_12;
                        
                    _label_90: 
                        this.i1 = 0;
                        this.i4 = this.i0;
                        goto _label_6;
                        
                    _label_91: 
                        this.i8 = this.i9;
                        this.i9 = this.i6;
                        this.i6 = this.i11;
                        goto _label_17;
                        
                    _label_92: 
                        this.i11 = this.i6;
                        this.i12 = this.i13;
                        this.i5 = this.i14;
                        this.i4 = this.i15;
                        this.i6 = this.i16;
                        goto _label_18;
                        
                    _label_93: 
                        goto _label_63;
                        
                    _label_94: 
                        goto _label_65;
                    };
                    this.i4 = this.i12;
                    this.i5 = this.i11;
                    this.i0 = this.i6;
                    goto _label_88;
                default:
                    throw ("Invalid state in _strtod");
            };
        }


    }
} cmodule.lua_wrapper

