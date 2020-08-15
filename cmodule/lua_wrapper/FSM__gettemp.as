package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM__gettemp extends Machine 
    {

        public static const intRegCount:int = 21;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
        public var i19:int;
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
        public var i18:int;
        public var i20:int;


        public static function start():void
        {
            var _local_1:FSM__gettemp;
            _local_1 = new (FSM__gettemp)();
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
                    public::mstate.esp = (public::mstate.esp - 10368);
                    this.i3 = li32(public::mstate.ebp + 8);
                    this.i0 = li8(this.i3);
                    this.i4 = li32(public::mstate.ebp + 12);
                    this.i1 = this.i3;
                    if (this.i0 == 0) goto _label_19;
                    this.i0 = this.i1;
                    do 
                    {
                        this.i1 = li8(this.i0 + 1);
                        this.i0 = (this.i0 + 1);
                        this.i2 = this.i0;
                        if (this.i1 == 0) goto _label_20;
                        this.i0 = this.i2;
                    } while (true);
                    
                _label_1: 
                    this.i0 = 22;
                    
                _label_2: 
                    si32(this.i0, _val_2E_1440);
                    this.i0 = 0;
                    goto _label_10;
                    
                _label_3: 
                    this.i0 = li8(_rs_initialized_2E_b);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = _rs_2E_2;
                        this.i1 = 0;
                        this.i2 = this.i1;
                        do 
                        {
                            this.i14 = (this.i0 + this.i2);
                            si8(this.i1, this.i14);
                            this.i1 = (this.i1 + 1);
                            this.i2 = (this.i2 + 1);
                        } while (!(this.i2 == 0x0100));
                        this.i0 = 0;
                        si8(this.i0, _rs_2E_0);
                        si8(this.i0, _rs_2E_1);
                        this.i0 = 1;
                        si8(this.i0, _rs_initialized_2E_b);
                    };
                    this.i0 = li8(_rs_stired_2E_b);
                    if (!(this.i0 == 0)) goto _label_5;
                    this.i1 = __2E_str977;
                    this.i0 = public::mstate.gworker.getSecsSetMS();
                    this.i2 = this.i0;
                    this.i0 = Machine.sMS;
                    si32(this.i2, this.i11);
                    this.i0 = (this.i0 * 1000);
                    si32(this.i0, this.i10);
                    this.i2 = 4;
                    this.i14 = 1;
                    this.i0 = this.i1;
                    this.i1 = this.i2;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i14, this.i9);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 0;
                    this.i1 = __2E_str468;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_open.start();
                    return;
                case 1:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i14 < 0) goto _label_4;
                    this.i2 = 116;
                    this.i0 = this.i14;
                    this.i1 = this.i8;
                    state = 2;
                case 2:
                    this.i0 = public::mstate.system.read(this.i0, this.i1, this.i2);
                    this.i0 = this.i14;
                    state = 3;
                case 3:
                    this.i0 = public::mstate.system.close(this.i0);
                    
                _label_4: 
                    this.i0 = 0;
                    this.i1 = li8(_rs_2E_0);
                    this.i2 = (this.i1 + -1);
                    si8(this.i2, _rs_2E_0);
                    this.i14 = li8(_rs_2E_1);
                    this.i15 = this.i1;
                    do 
                    {
                        this.i16 = _rs_2E_2;
                        this.i17 = (this.i0 >> 31);
                        this.i17 = (this.i17 >>> 25);
                        this.i17 = (this.i0 + this.i17);
                        this.i18 = (this.i15 & 0xFF);
                        this.i17 = (this.i17 & 0xFFFFFF80);
                        this.i17 = (this.i0 - this.i17);
                        this.i18 = (this.i16 + this.i18);
                        this.i19 = li8(this.i18);
                        this.i17 = (this.i7 + this.i17);
                        this.i17 = li8(this.i17);
                        this.i14 = (this.i14 + this.i19);
                        this.i14 = (this.i14 + this.i17);
                        this.i17 = (this.i14 & 0xFF);
                        this.i16 = (this.i16 + this.i17);
                        this.i17 = li8(this.i16);
                        si8(this.i17, this.i18);
                        si8(this.i19, this.i16);
                        this.i15 = (this.i15 + 1);
                        this.i0 = (this.i0 + 1);
                    } while (!(this.i0 == 0x0100));
                    this.i0 = 0;
                    si8(this.i2, _rs_2E_0);
                    si8(this.i14, _rs_2E_1);
                    this.i15 = this.i1;
                    this.i1 = this.i14;
                    do 
                    {
                        this.i14 = this.i15;
                        this.i15 = _rs_2E_2;
                        this.i16 = (this.i14 & 0xFF);
                        this.i16 = (this.i15 + this.i16);
                        this.i17 = li8(this.i16);
                        this.i1 = (this.i1 + this.i17);
                        this.i18 = (this.i1 & 0xFF);
                        this.i15 = (this.i15 + this.i18);
                        this.i18 = li8(this.i15);
                        si8(this.i18, this.i16);
                        si8(this.i17, this.i15);
                        this.i14 = (this.i14 + 1);
                        this.i0 = (this.i0 + 1);
                        if ((this.i0 == 0x0400)) break;
                        this.i15 = this.i14;
                    } while (true);
                    this.i0 = 1;
                    si8(this.i2, _rs_2E_0);
                    si8(this.i1, _rs_2E_1);
                    si8(this.i0, _rs_stired_2E_b);
                    
                _label_5: 
                    this.i0 = _rs_2E_2;
                    this.i1 = li8(_rs_2E_0);
                    this.i2 = (this.i1 + 1);
                    this.i2 = (this.i2 & 0xFF);
                    this.i2 = (this.i0 + this.i2);
                    this.i14 = li8(_rs_2E_1);
                    this.i15 = li8(this.i2);
                    this.i14 = (this.i14 + this.i15);
                    this.i16 = (this.i14 & 0xFF);
                    this.i16 = (this.i0 + this.i16);
                    this.i17 = li8(this.i16);
                    this.i18 = (this.i1 + 2);
                    si8(this.i17, this.i2);
                    this.i2 = (this.i18 & 0xFF);
                    si8(this.i15, this.i16);
                    this.i2 = (this.i0 + this.i2);
                    this.i16 = li8(this.i2);
                    this.i14 = (this.i14 + this.i16);
                    this.i15 = (this.i17 + this.i15);
                    this.i17 = (this.i14 & 0xFF);
                    this.i15 = (this.i15 & 0xFF);
                    this.i17 = (this.i0 + this.i17);
                    this.i15 = (this.i0 + this.i15);
                    this.i15 = li8(this.i15);
                    this.i18 = li8(this.i17);
                    this.i19 = (this.i1 + 3);
                    si8(this.i18, this.i2);
                    this.i2 = (this.i19 & 0xFF);
                    si8(this.i16, this.i17);
                    this.i2 = (this.i0 + this.i2);
                    this.i17 = li8(this.i2);
                    this.i14 = (this.i14 + this.i17);
                    this.i16 = (this.i18 + this.i16);
                    this.i18 = (this.i14 & 0xFF);
                    this.i16 = (this.i16 & 0xFF);
                    this.i18 = (this.i0 + this.i18);
                    this.i16 = (this.i0 + this.i16);
                    this.i16 = li8(this.i16);
                    this.i19 = li8(this.i18);
                    this.i20 = (this.i19 + this.i17);
                    si8(this.i19, this.i2);
                    this.i2 = (this.i20 & 0xFF);
                    this.i1 = (this.i1 + 4);
                    si8(this.i17, this.i18);
                    this.i2 = (this.i0 + this.i2);
                    this.i2 = li8(this.i2);
                    this.i17 = (this.i1 & 0xFF);
                    si8(this.i1, _rs_2E_0);
                    this.i1 = (this.i0 + this.i17);
                    this.i17 = li8(this.i1);
                    this.i14 = (this.i14 + this.i17);
                    this.i18 = (this.i14 & 0xFF);
                    si8(this.i14, _rs_2E_1);
                    this.i14 = (this.i0 + this.i18);
                    this.i18 = li8(this.i14);
                    this.i19 = (this.i18 + this.i17);
                    si8(this.i18, this.i1);
                    this.i1 = (this.i19 & 0xFF);
                    this.i16 = (this.i16 << 16);
                    this.i15 = (this.i15 << 24);
                    si8(this.i17, this.i14);
                    this.i0 = (this.i0 + this.i1);
                    this.i1 = (this.i16 | this.i15);
                    this.i2 = (this.i2 << 8);
                    this.i0 = li8(this.i0);
                    this.i1 = (this.i1 | this.i2);
                    this.i0 = (this.i1 | this.i0);
                    this.i1 = (uint(this.i0) / uint(62));
                    this.i1 = (this.i1 * 62);
                    this.i2 = _padchar;
                    this.i0 = (this.i0 - this.i1);
                    this.i0 = (this.i2 + this.i0);
                    this.i0 = li8(this.i0);
                    si8(this.i0, this.i12);
                    this.i0 = (this.i13 + 1);
                    
                _label_6: 
                    this.i13 = this.i0;
                    this.i2 = (this.i13 ^ 0xFFFFFFFF);
                    this.i12 = (this.i5 + this.i2);
                    if (!(uint(this.i12) < uint(this.i3)))
                    {
                        this.i0 = li8(this.i12);
                        if (this.i0 == 88) goto _label_3;
                    };
                    if (this.i4 == 0) goto _label_15;
                    this.i0 = (this.i2 + this.i6);
                    goto _label_12;
                    
                _label_7: 
                    this.i1 = li8(this.i7);
                    if (!(this.i1 == 47)) goto _label_11;
                    this.i0 = 0;
                    si8(this.i0, this.i7);
                    this.i0 = this.i3;
                    state = 4;
                case 4:
                    this.i0 = public::mstate.system.psize(this.i0);
                    if (!(this.i0 < 0))
                    {
                        this.i0 = 1;
                        this.i1 = 0;
                        goto _label_8;
                    };
                    this.i0 = __2E_str655;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = 0x0400;
                    this.i8 = (public::mstate.ebp + -5120);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_snprintf.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = 0;
                    si8(this.i0, (public::mstate.ebp + -4097));
                    this.i0 = this.i8;
                    state = 6;
                case 6:
                    this.i0 = public::mstate.system.psize(this.i0);
                    if (!(this.i0 < 0))
                    {
                        this.i0 = 1;
                        this.i1 = this.i0;
                        goto _label_8;
                    };
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = __2E_str251;
                    this.i8 = 28;
                    this.i9 = 2;
                    this.i10 = (public::mstate.ebp + -4096);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i8, (public::mstate.esp + 16));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i10;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i9, _val_2E_1440);
                    this.i0 = 0;
                    this.i1 = this.i0;
                    
                _label_8: 
                    this.i8 = 47;
                    si8(this.i8, this.i7);
                    this.i0 = (this.i0 & 0x01);
                    if (!(!(this.i0 == 0)))
                    {
                        
                    _label_9: 
                        this.i0 = 0;
                        
                    _label_10: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i0 = (this.i1 & 0x01);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = 20;
                        goto _label_2;
                        
                    _label_11: 
                        this.i0 = (this.i0 + -1);
                        
                    _label_12: 
                        this.i7 = this.i0;
                        if (uint(this.i0) > uint(this.i3)) goto _label_7;
                    };
                    if (this.i4 == 0) goto _label_15;
                    
                _label_13: 
                    this.i0 = 384;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = 2562;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_open.start();
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    if (this.i0 < 0) goto _label_16;
                    this.i0 = 1;
                    goto _label_10;
                    
                _label_14: 
                    si8(this.i1, this.i7);
                    if (!(this.i4 == 0)) goto _label_13;
                    
                _label_15: 
                    this.i0 = this.i3;
                    state = 9;
                case 9:
                    this.i0 = public::mstate.system.psize(this.i0);
                    if (this.i0 > -1) goto _label_17;
                    this.i0 = __2E_str655;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = 0x0400;
                    this.i7 = (public::mstate.ebp + -10368);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_snprintf.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = 0;
                    si8(this.i0, (public::mstate.ebp + -9345));
                    this.i0 = this.i7;
                    state = 11;
                case 11:
                    this.i0 = public::mstate.system.psize(this.i0);
                    if (this.i0 > -1) goto _label_17;
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i2 = __2E_str251;
                    this.i3 = 28;
                    this.i4 = 2;
                    this.i5 = (public::mstate.ebp + -9344);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    si32(this.i3, (public::mstate.esp + 16));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = 3;
                    this.i0 = this.i5;
                    this.i1 = this.i2;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i4, _val_2E_1440);
                    this.i0 = 1;
                    goto _label_10;
                    
                _label_16: 
                    this.i0 = li32(_val_2E_1440);
                    if (!(this.i0 == 17)) goto _label_9;
                    
                _label_17: 
                    this.i0 = (this.i5 - this.i13);
                    this.i0 = li8(this.i0);
                    if (this.i0 == 0) goto _label_9;
                    if (this.i13 == 0) goto _label_9;
                    this.i0 = this.i2;
                    do 
                    {
                        this.i1 = _padchar;
                        this.i7 = (this.i6 + this.i0);
                        this.i8 = li8(this.i7 + 1);
                        this.i9 = 64;
                        this.i7 = (this.i7 + 1);
                        do 
                        {
                            this.i10 = li8(this.i1);
                            this.i11 = (this.i8 & 0xFF);
                            this.i12 = this.i1;
                            if (!(!(this.i10 == this.i11)))
                            {
                                this.i1 = this.i12;
                                goto _label_18;
                            };
                            this.i9 = (this.i9 + -1);
                            this.i1 = (this.i1 + 1);
                        } while (!(this.i9 == 1));
                        this.i1 = 0;
                        
                    _label_18: 
                        if (!(this.i1 == 0))
                        {
                            this.i1 = li8(this.i1 + 1);
                            if (!(this.i1 == 0)) goto _label_14;
                        };
                        this.i1 = 48;
                        si8(this.i1, this.i7);
                        this.i1 = (this.i6 + this.i0);
                        this.i1 = li8(this.i1 + 2);
                        this.i7 = (this.i0 + 1);
                        this.i0 = (this.i0 + 2);
                        if (this.i1 == 0) goto _label_9;
                        if (this.i0 == 0) goto _label_9;
                        this.i0 = this.i7;
                    } while (true);
                    
                _label_19: 
                    this.i0 = this.i3;
                    
                _label_20: 
                    this.i5 = this.i0;
                    this.i6 = this.i5;
                    this.i0 = (this.i5 + -1);
                    if (uint(this.i0) < uint(this.i3)) goto _label_1;
                    this.i7 = (public::mstate.ebp + -5248);
                    this.i0 = 0;
                    this.i8 = (this.i7 + 12);
                    this.i9 = (this.i7 + 8);
                    this.i10 = (this.i7 + 4);
                    this.i11 = this.i7;
                    goto _label_6;
                default:
                    throw ("Invalid state in __gettemp");
            };
        }


    }
}

