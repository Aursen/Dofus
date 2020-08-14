package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___sfvwrite extends Machine 
    {

        public static const intRegCount:int = 20;
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


        public static function start():void
        {
            var _local_1:FSM___sfvwrite;
            _local_1 = new (FSM___sfvwrite)();
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
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = (this.i0 + 8);
                    if (!(!(this.i2 == 0)))
                    {
                        
                    _label_1: 
                        this.i0 = 0;
                        goto _label_20;
                    };
                    this.i2 = li16(this.i1 + 12);
                    this.i4 = (this.i1 + 12);
                    this.i5 = (this.i2 & 0x08);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = li32(this.i1 + 16);
                        if (!(this.i5 == 0)) goto _label_2;
                        this.i2 = (this.i2 & 0x0200);
                        if (!(this.i2 == 0)) goto _label_2;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___swsetup.start();
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i2 == 0))
                    {
                        this.i0 = -1;
                        goto _label_20;
                    };
                    
                _label_2: 
                    this.i0 = li32(this.i0);
                    this.i2 = li16(this.i4);
                    this.i5 = li32(this.i0);
                    this.i6 = li32(this.i0 + 4);
                    this.i7 = (this.i2 & 0x02);
                    if (this.i7 == 0) goto _label_3;
                    this.i2 = this.i5;
                    this.i5 = this.i6;
                    while ((this.i6 = 0), (this.i5 == 0))
                    {
                        this.i2 = li32(this.i0 + 8);
                        this.i5 = li32(this.i0 + 12);
                        this.i0 = (this.i0 + 8);
                    };
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = ((uint(this.i5) < uint(1025)) ? this.i5 : 0x0400);
                    this.i8 = (this.i2 + this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__swrite.start();
                    return;
                case 2:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i7 < 1) goto _label_19;
                    this.i8 = li32(this.i3);
                    this.i9 = (this.i8 - this.i7);
                    si32(this.i9, this.i3);
                    this.i5 = (this.i5 - this.i7);
                    this.i6 = (this.i6 + this.i7);
                    if (this.i8 == this.i7) goto _label_1;
                    //unresolved jump
                    
                _label_3: 
                    this.i7 = (this.i1 + 8);
                    this.i2 = (this.i2 & 0x01);
                    if (!(this.i2 == 0))
                    {
                        this.i2 = 0;
                        this.i8 = (this.i1 + 20);
                        this.i9 = (this.i1 + 16);
                        this.i10 = this.i1;
                        goto _label_9;
                    };
                    this.i2 = (this.i1 + 20);
                    this.i8 = (this.i1 + 16);
                    this.i9 = this.i1;
                    while ((this.i10 = 0), (this.i11 = (this.i5 + this.i10)), (this.i6 == 0))
                    {
                        this.i5 = li32(this.i0 + 8);
                        this.i6 = li32(this.i0 + 12);
                        this.i0 = (this.i0 + 8);
                    };
                    this.i12 = li16(this.i4);
                    this.i12 = (this.i12 & 0x4200);
                    if (!(this.i12 == 0x4200)) goto _label_5;
                    this.i12 = li32(this.i7);
                    if (uint(this.i12) >= uint(this.i6)) goto _label_5;
                    this.i12 = li32(this.i9);
                    this.i13 = li32(this.i8);
                    this.i14 = (this.i6 + 128);
                    this.i12 = (this.i12 - this.i13);
                    this.i15 = (this.i14 + this.i12);
                    si32(this.i14, this.i7);
                    si32(this.i15, this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i14 = (this.i15 + 1);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 3:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i14 == 0)) goto _label_4;
                    if (this.i13 == 0) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i13, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_free.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    si32(this.i14, this.i8);
                    if (this.i14 == 0) goto _label_19;
                    this.i12 = (this.i14 + this.i12);
                    si32(this.i12, this.i9);
                    
                _label_5: 
                    this.i12 = li16(this.i4);
                    this.i13 = li32(this.i7);
                    this.i12 = (this.i12 & 0x0200);
                    if (!(this.i12 == 0))
                    {
                        this.i13 = ((uint(this.i13) > uint(this.i6)) ? this.i6 : this.i13);
                        if (!(this.i13 > 0))
                        {
                            this.i13 = this.i6;
                            goto _label_8;
                        };
                        this.i12 = li32(this.i9);
                        this.i14 = this.i13;
                        memcpy(this.i12, this.i11, this.i14);
                        this.i11 = li32(this.i7);
                        this.i11 = (this.i11 - this.i13);
                        si32(this.i11, this.i7);
                        this.i11 = li32(this.i9);
                        this.i13 = (this.i11 + this.i13);
                        si32(this.i13, this.i9);
                        this.i13 = this.i6;
                        goto _label_8;
                    };
                    this.i12 = li32(this.i9);
                    this.i14 = li32(this.i8);
                    if (uint(this.i12) <= uint(this.i14)) goto _label_6;
                    if (uint(this.i13) >= uint(this.i6)) goto _label_6;
                    this.i14 = this.i13;
                    memcpy(this.i12, this.i11, this.i14);
                    this.i11 = li32(this.i9);
                    this.i11 = (this.i11 + this.i13);
                    si32(this.i11, this.i9);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fflush.start();
                    return;
                case 5:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i11 == 0)) goto _label_19;
                    goto _label_8;
                    
                _label_6: 
                    this.i13 = li32(this.i2);
                    if (uint(this.i13) > uint(this.i6)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__swrite.start();
                    return;
                case 6:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i11 < 1) goto _label_19;
                    this.i13 = this.i11;
                    goto _label_8;
                    
                _label_7: 
                    this.i13 = this.i12;
                    this.i12 = this.i6;
                    memcpy(this.i13, this.i11, this.i12);
                    this.i13 = li32(this.i7);
                    this.i13 = (this.i13 - this.i6);
                    si32(this.i13, this.i7);
                    this.i13 = li32(this.i9);
                    this.i13 = (this.i13 + this.i6);
                    si32(this.i13, this.i9);
                    this.i13 = this.i6;
                    
                _label_8: 
                    this.i11 = this.i13;
                    this.i12 = li32(this.i3);
                    this.i13 = (this.i12 - this.i11);
                    si32(this.i13, this.i3);
                    this.i6 = (this.i6 - this.i11);
                    this.i10 = (this.i10 + this.i11);
                    if (this.i12 == this.i11) goto _label_1;
                    //unresolved jump
                    do 
                    {
                        this.i5 = li32(this.i0 + 8);
                        this.i6 = li32(this.i0 + 12);
                        this.i0 = (this.i0 + 8);
                        
                    _label_9: 
                        this.i11 = 0;
                        this.i12 = this.i5;
                        this.i13 = this.i11;
                        
                    _label_10: 
                        this.i14 = (this.i5 + this.i13);
                    } while ((this.i6 == 0));
                    if ((this.i11 == 0))
                    {
                        if (!(!(this.i6 == 0)))
                        {
                            
                        _label_11: 
                            this.i2 = 0;
                            
                        _label_12: 
                            if (this.i2 == 0) goto _label_13;
                            this.i11 = 1;
                            this.i2 = (this.i2 + 1);
                            this.i2 = (this.i2 - this.i14);
                            goto _label_14;
                        };
                        this.i2 = (this.i6 + 1);
                        this.i11 = (this.i13 + this.i12);
                        do 
                        {
                            this.i15 = li8(this.i11);
                            this.i16 = this.i11;
                            if (!(!(this.i15 == 10)))
                            {
                                this.i2 = this.i16;
                                goto _label_12;
                            };
                            this.i2 = (this.i2 + -1);
                            this.i11 = (this.i11 + 1);
                            if (this.i2 == 1) goto _label_11;
                        } while (true);
                        
                    _label_13: 
                        this.i2 = 1;
                        this.i15 = (this.i6 + 1);
                        this.i11 = this.i2;
                        this.i2 = this.i15;
                    };
                    
                _label_14: 
                    this.i15 = li32(this.i7);
                    this.i16 = li32(this.i8);
                    this.i17 = li32(this.i10);
                    this.i18 = li32(this.i9);
                    this.i19 = ((uint(this.i2) <= uint(this.i6)) ? this.i2 : this.i6);
                    this.i15 = (this.i16 + this.i15);
                    if (uint(this.i17) <= uint(this.i18)) goto _label_15;
                    if (this.i19 <= this.i15) goto _label_15;
                    this.i16 = this.i17;
                    this.i17 = this.i15;
                    memcpy(this.i16, this.i14, this.i17);
                    this.i14 = li32(this.i10);
                    this.i14 = (this.i14 + this.i15);
                    si32(this.i14, this.i10);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fflush.start();
                    return;
                case 7:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i14 == 0)) goto _label_19;
                    this.i14 = this.i15;
                    goto _label_17;
                    
                _label_15: 
                    if (this.i16 > this.i19) goto _label_16;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i16, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__swrite.start();
                    return;
                case 8:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i14 < 1) goto _label_19;
                    goto _label_17;
                    
                _label_16: 
                    this.i15 = this.i17;
                    this.i16 = this.i19;
                    memcpy(this.i15, this.i14, this.i16);
                    this.i14 = li32(this.i7);
                    this.i14 = (this.i14 - this.i19);
                    si32(this.i14, this.i7);
                    this.i14 = li32(this.i10);
                    this.i14 = (this.i14 + this.i19);
                    si32(this.i14, this.i10);
                    this.i14 = this.i19;
                    
                _label_17: 
                    this.i15 = (this.i2 - this.i14);
                    if (!(this.i2 == this.i14))
                    {
                        this.i2 = this.i11;
                        goto _label_18;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fflush.start();
                    return;
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i2 = 0;
                        
                    _label_18: 
                        this.i11 = li32(this.i3);
                        this.i16 = (this.i11 - this.i14);
                        si32(this.i16, this.i3);
                        this.i6 = (this.i6 - this.i14);
                        this.i13 = (this.i13 + this.i14);
                        if (this.i11 == this.i14) goto _label_1;
                        this.i11 = this.i2;
                        this.i2 = this.i15;
                        goto _label_10;
                    };
                    
                _label_19: 
                    this.i0 = -1;
                    this.i1 = li16(this.i4);
                    this.i1 = (this.i1 | 0x40);
                    si16(this.i1, this.i4);
                    
                _label_20: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___sfvwrite");
            };
        }


    }
} cmodule.lua_wrapper

