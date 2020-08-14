package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_propagatemark extends Machine 
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
            var _local_1:FSM_propagatemark;
            _local_1 = new (FSM_propagatemark)();
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
                    this.i1 = li32(this.i0 + 36);
                    this.i2 = li8(this.i1 + 5);
                    this.i2 = (this.i2 | 0x04);
                    si8(this.i2, (this.i1 + 5));
                    this.i2 = li8(this.i1 + 4);
                    this.i3 = (this.i1 + 5);
                    this.i4 = (this.i0 + 36);
                    if (this.i2 > 7) goto _label_4;
                    if (this.i2 == 5) goto _label_8;
                    if (!(this.i2 == 6)) goto _label_52;
                    this.i3 = li32(this.i1 + 8);
                    si32(this.i3, this.i4);
                    this.i3 = li32(this.i1 + 12);
                    this.i4 = li8(this.i3 + 5);
                    this.i2 = (this.i1 + 6);
                    this.i5 = this.i1;
                    this.i6 = this.i1;
                    this.i4 = (this.i4 & 0x03);
                    if (this.i4 == 0) goto _label_26;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li8(this.i2);
                    if (this.i3 == 0) goto _label_27;
                    
                _label_1: 
                    this.i4 = li8(this.i6 + 7);
                    this.i3 = (this.i6 + 7);
                    if (this.i4 < 1) goto _label_31;
                    this.i4 = 0;
                    
                _label_2: 
                    this.i7 = li32(this.i5 + 28);
                    if (this.i7 < 4) goto _label_3;
                    this.i7 = li32(this.i5 + 20);
                    this.i8 = li8(this.i7 + 5);
                    this.i8 = (this.i8 & 0x03);
                    if (this.i8 == 0) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i7 = li8(this.i3);
                    this.i5 = (this.i5 + 12);
                    this.i4 = (this.i4 + 1);
                    if (this.i7 <= this.i4) goto _label_31;
                    goto _label_2;
                    
                _label_4: 
                    if (this.i2 == 8) goto _label_34;
                    if (!(this.i2 == 9)) goto _label_52;
                    this.i2 = li32(this.i1 + 68);
                    si32(this.i2, this.i4);
                    this.i2 = li32(this.i1 + 32);
                    if (this.i2 == 0) goto _label_45;
                    this.i3 = li8(this.i2 + 5);
                    this.i3 = (this.i3 & 0xFFFFFFFC);
                    si8(this.i3, (this.i2 + 5));
                    this.i2 = li32(this.i1 + 40);
                    if (this.i2 < 1) goto _label_46;
                    
                _label_5: 
                    this.i2 = 0;
                    this.i3 = (this.i1 + 40);
                    this.i4 = (this.i1 + 8);
                    this.i5 = this.i2;
                    
                _label_6: 
                    this.i6 = li32(this.i4);
                    this.i7 = (this.i6 + this.i5);
                    this.i7 = li32(this.i7 + 8);
                    if (this.i7 < 4) goto _label_7;
                    this.i6 = (this.i6 + this.i5);
                    this.i6 = li32(this.i6);
                    this.i7 = li8(this.i6 + 5);
                    this.i7 = (this.i7 & 0x03);
                    if (this.i7 == 0) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_7: 
                    this.i6 = li32(this.i3);
                    this.i5 = (this.i5 + 12);
                    this.i2 = (this.i2 + 1);
                    if (this.i6 <= this.i2) goto _label_46;
                    goto _label_6;
                    
                _label_8: 
                    this.i2 = li32(this.i1 + 24);
                    si32(this.i2, this.i4);
                    this.i4 = li32(this.i1 + 8);
                    this.i2 = (this.i1 + 8);
                    this.i5 = (this.i1 + 24);
                    this.i6 = this.i1;
                    if (this.i4 == 0) goto _label_9;
                    this.i7 = li8(this.i4 + 5);
                    this.i7 = (this.i7 & 0x03);
                    if (this.i7 == 0) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_9: 
                    this.i4 = li32(this.i2);
                    if (!(!(this.i4 == 0)))
                    {
                        
                    _label_10: 
                        this.i4 = 0;
                        goto _label_11;
                    };
                    this.i2 = li8(this.i4 + 6);
                    this.i2 = (this.i2 & 0x08);
                    if (!(this.i2 == 0)) goto _label_10;
                    this.i2 = 3;
                    this.i7 = li32(this.i0 + 180);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettm.start();
                case 5:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_11: 
                    if (!(!(this.i4 == 0)))
                    {
                        
                    _label_12: 
                        this.i4 = 0;
                        this.i1 = this.i4;
                        goto _label_17;
                    };
                    this.i2 = li32(this.i4 + 8);
                    if (!(this.i2 == 4)) goto _label_12;
                    this.i4 = li32(this.i4);
                    this.i2 = li8(this.i4 + 16);
                    this.i4 = (this.i4 + 16);
                    this.i7 = this.i4;
                    if (this.i2 == 107) goto _label_53;
                    this.i8 = this.i4;
                    do 
                    {
                        this.i9 = li8(this.i8);
                        if (!(!(this.i9 == 0)))
                        {
                            this.i8 = 0;
                            goto _label_54;
                        };
                        this.i9 = li8(this.i8 + 1);
                        this.i8 = (this.i8 + 1);
                        this.i10 = this.i8;
                        if (this.i9 == 107) goto _label_54;
                        this.i8 = this.i10;
                    } while (true);
                    
                _label_13: 
                    this.i4 = this.i7;
                    do 
                    {
                        
                    _label_14: 
                        this.i2 = ((this.i4 != 0) ? 1 : 0);
                        this.i2 = (this.i2 & 0x01);
                        if (!(this.i4 == 0)) goto _label_16;
                        if (!(this.i8 == 0)) goto _label_16;
                        this.i1 = this.i2;
                        this.i4 = this.i9;
                        goto _label_17;
                        
                    _label_15: 
                        this.i2 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i7 = this.i4;
                    } while ((this.i2 == 118));
                    this.i4 = this.i7;
                    goto _label_55;
                    
                _label_16: 
                    this.i4 = li8(this.i6 + 5);
                    this.i7 = (this.i2 << 4);
                    this.i8 = (this.i9 << 3);
                    this.i4 = (this.i4 & 0xFFFFFFE7);
                    this.i7 = (this.i7 | this.i8);
                    this.i4 = (this.i4 | this.i7);
                    si8(this.i4, (this.i6 + 5));
                    this.i4 = li32(this.i0 + 44);
                    si32(this.i4, this.i5);
                    si32(this.i1, (this.i0 + 44));
                    this.i1 = this.i2;
                    this.i4 = this.i9;
                    
                _label_17: 
                    if (!(this.i4 == 0))
                    {
                        if (!(this.i1 == 0)) goto _label_25;
                    };
                    if (!(this.i1 == 0)) goto _label_20;
                    this.i2 = li32(this.i6 + 28);
                    if (this.i2 == 0) goto _label_20;
                    this.i5 = 0;
                    this.i7 = (this.i2 * 12);
                    this.i8 = (this.i6 + 12);
                    
                _label_18: 
                    this.i9 = li32(this.i8);
                    this.i10 = (this.i9 + this.i7);
                    this.i10 = li32(this.i10 + -4);
                    if (this.i10 < 4) goto _label_19;
                    this.i9 = (this.i9 + this.i7);
                    this.i9 = li32(this.i9 + -12);
                    this.i10 = li8(this.i9 + 5);
                    this.i10 = (this.i10 & 0x03);
                    if (this.i10 == 0) goto _label_19;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_19: 
                    this.i7 = (this.i7 + -12);
                    this.i5 = (this.i5 + 1);
                    if (!(this.i5 == this.i2)) goto _label_18;
                    
                _label_20: 
                    this.i2 = 1;
                    this.i5 = li8(this.i6 + 7);
                    this.i2 = (this.i2 << this.i5);
                    this.i5 = (this.i2 + -1);
                    if (this.i2 == 0) goto _label_24;
                    this.i2 = (this.i6 + 16);
                    do 
                    {
                        
                    _label_21: 
                        this.i7 = li32(this.i2);
                        this.i8 = (this.i5 * 28);
                        this.i8 = (this.i7 + this.i8);
                        this.i9 = li32(this.i8 + 8);
                        this.i10 = (this.i8 + 8);
                        if ((!(this.i9 == 0))) break;
                        this.i8 = (this.i5 * 28);
                        this.i7 = (this.i7 + this.i8);
                        this.i8 = li32(this.i7 + 20);
                        this.i7 = (this.i7 + 20);
                        if (!(this.i8 < 4))
                        {
                            this.i8 = 11;
                            si32(this.i8, this.i7);
                        };
                        this.i7 = (this.i5 + -1);
                        if (this.i5 == 0) goto _label_24;
                        this.i5 = this.i7;
                    } while (true);
                    if (!(this.i4 == 0)) goto _label_22;
                    this.i9 = (this.i5 * 28);
                    this.i9 = (this.i7 + this.i9);
                    this.i9 = li32(this.i9 + 20);
                    if (this.i9 < 4) goto _label_22;
                    this.i9 = (this.i5 * 28);
                    this.i7 = (this.i7 + this.i9);
                    this.i7 = li32(this.i7 + 12);
                    this.i9 = li8(this.i7 + 5);
                    this.i9 = (this.i9 & 0x03);
                    if (this.i9 == 0) goto _label_22;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_22: 
                    if (!(this.i1 == 0)) goto _label_23;
                    this.i7 = li32(this.i10);
                    if (this.i7 < 4) goto _label_23;
                    this.i7 = li32(this.i8);
                    this.i8 = li8(this.i7 + 5);
                    this.i8 = (this.i8 & 0x03);
                    if (this.i8 == 0) goto _label_23;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_23: 
                    this.i7 = (this.i5 + -1);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = this.i7;
                        goto _label_21;
                    };
                    
                _label_24: 
                    this.i0 = (this.i4 | this.i1);
                    if (!(this.i0 == 0))
                    {
                        
                    _label_25: 
                        this.i0 = li8(this.i3);
                        this.i0 = (this.i0 & 0xFFFFFFFB);
                        si8(this.i0, this.i3);
                    };
                    this.i0 = 28;
                    this.i1 = li32(this.i6 + 28);
                    this.i3 = li8(this.i6 + 7);
                    this.i0 = (this.i0 << this.i3);
                    this.i1 = (this.i1 * 12);
                    this.i0 = (this.i1 + this.i0);
                    this.i0 = (this.i0 + 32);
                    goto _label_33;
                    
                _label_26: 
                    this.i3 = li8(this.i2);
                    if (!(this.i3 == 0)) goto _label_1;
                    
                _label_27: 
                    this.i3 = li32(this.i1 + 16);
                    this.i4 = li8(this.i3 + 5);
                    this.i5 = this.i1;
                    this.i4 = (this.i4 & 0x03);
                    if (!(!(this.i4 == 0)))
                    {
                        this.i3 = 0;
                        goto _label_30;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li8(this.i5 + 7);
                    if (this.i3 < 1) goto _label_31;
                    this.i3 = 0;
                    
                _label_28: 
                    this.i4 = (this.i3 << 2);
                    this.i4 = (this.i5 + this.i4);
                    this.i4 = li32(this.i4 + 20);
                    this.i7 = li8(this.i4 + 5);
                    this.i7 = (this.i7 & 0x03);
                    if (this.i7 == 0) goto _label_29;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_29: 
                    this.i3 = (this.i3 + 1);
                    
                _label_30: 
                    this.i4 = li8(this.i5 + 7);
                    if (!(this.i4 <= this.i3)) goto _label_28;
                    
                _label_31: 
                    this.i0 = li8(this.i2);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = li8(this.i6 + 7);
                        this.i0 = (this.i0 * 12);
                        
                    _label_32: 
                        this.i0 = (this.i0 + 20);
                        
                    _label_33: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i0 = li8(this.i1 + 7);
                    this.i0 = (this.i0 << 2);
                    goto _label_32;
                    
                _label_34: 
                    this.i2 = li32(this.i1 + 100);
                    si32(this.i2, this.i4);
                    this.i4 = li32(this.i0 + 40);
                    si32(this.i4, (this.i1 + 100));
                    si32(this.i1, (this.i0 + 40));
                    this.i4 = li8(this.i3);
                    this.i4 = (this.i4 & 0xFFFFFFFB);
                    si8(this.i4, this.i3);
                    this.i4 = li32(this.i1 + 80);
                    this.i2 = this.i1;
                    if (this.i4 < 4) goto _label_38;
                    this.i4 = li32(this.i1 + 72);
                    this.i3 = li8(this.i4 + 5);
                    this.i3 = (this.i3 & 0x03);
                    if (this.i3 == 0) goto _label_38;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 11:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 40);
                    this.i5 = li32(this.i1 + 20);
                    if (!(uint(this.i5) < uint(this.i3)))
                    {
                        
                    _label_35: 
                        this.i5 = li32(this.i3 + 8);
                        this.i4 = ((uint(this.i5) > uint(this.i4)) ? this.i5 : this.i4);
                        this.i3 = (this.i3 + 24);
                    }
                    else
                    {
                        
                    _label_36: 
                        this.i3 = li32(this.i1 + 32);
                        this.i5 = li32(this.i1 + 8);
                        this.i6 = (this.i1 + 8);
                        this.i7 = (this.i1 + 32);
                        this.i8 = this.i3;
                        if (uint(this.i5) > uint(this.i3)) goto _label_39;
                        this.i0 = this.i8;
                        
                    _label_37: 
                        this.i3 = this.i0;
                        if (uint(this.i0) > uint(this.i4)) goto _label_41;
                        this.i0 = this.i3;
                        do 
                        {
                            this.i3 = 0;
                            si32(this.i3, (this.i0 + 8));
                            this.i0 = (this.i0 + 12);
                            if (uint(this.i0) > uint(this.i4)) goto _label_41;
                        } while (true);
                        
                    _label_38: 
                        this.i4 = li32(this.i1 + 8);
                        this.i3 = li32(this.i1 + 40);
                    };
                    this.i5 = li32(this.i1 + 20);
                    if (uint(this.i5) < uint(this.i3)) goto _label_36;
                    goto _label_35;
                    
                _label_39: 
                    this.i5 = li32(this.i3 + 8);
                    this.i8 = this.i3;
                    if (this.i5 < 4) goto _label_40;
                    this.i5 = li32(this.i8);
                    this.i8 = li8(this.i5 + 5);
                    this.i8 = (this.i8 & 0x03);
                    if (this.i8 == 0) goto _label_40;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_40: 
                    this.i5 = li32(this.i6);
                    this.i3 = (this.i3 + 12);
                    this.i8 = this.i3;
                    if (uint(this.i5) > uint(this.i3)) goto _label_39;
                    this.i0 = this.i8;
                    goto _label_37;
                    
                _label_41: 
                    this.i0 = li32(this.i7);
                    this.i3 = li32(this.i1 + 48);
                    this.i0 = (this.i4 - this.i0);
                    this.i4 = (this.i1 + 48);
                    this.i0 = (this.i0 / 12);
                    if (this.i3 > 20000) goto _label_43;
                    this.i5 = li32(this.i1 + 20);
                    this.i6 = li32(this.i1 + 40);
                    this.i5 = (this.i5 - this.i6);
                    this.i5 = (this.i5 / 24);
                    this.i5 = (this.i5 << 2);
                    if (this.i5 >= this.i3) goto _label_42;
                    if (this.i3 < 17) goto _label_42;
                    this.i5 = (this.i3 >>> 31);
                    this.i3 = (this.i3 + this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 >> 1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocCI.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_42: 
                    this.i3 = li32(this.i1 + 44);
                    this.i0 = (this.i0 << 2);
                    if (this.i0 >= this.i3) goto _label_43;
                    if (this.i3 < 91) goto _label_43;
                    this.i0 = (this.i3 >>> 31);
                    this.i0 = (this.i3 + this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i0 >> 1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_43: 
                    this.i0 = li32(this.i1 + 44);
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 * 24);
                    this.i0 = (this.i0 * 12);
                    this.i0 = (this.i0 + this.i1);
                    this.i0 = (this.i0 + 112);
                    goto _label_33;
                    
                _label_44: 
                    this.i6 = li32(this.i3);
                    this.i6 = (this.i6 + this.i2);
                    this.i6 = li32(this.i6);
                    if (!(this.i6 == 0))
                    {
                        this.i7 = li8(this.i6 + 5);
                        this.i7 = (this.i7 & 0xFFFFFFFC);
                        si8(this.i7, (this.i6 + 5));
                    };
                    this.i6 = li32(this.i4);
                    this.i2 = (this.i2 + 4);
                    this.i5 = (this.i5 + 1);
                    if (this.i6 <= this.i5) goto _label_49;
                    goto _label_44;
                    
                _label_45: 
                    this.i2 = li32(this.i1 + 40);
                    if (this.i2 > 0) goto _label_5;
                    
                _label_46: 
                    this.i2 = li32(this.i1 + 36);
                    this.i4 = (this.i1 + 36);
                    if (this.i2 < 1) goto _label_49;
                    this.i5 = 0;
                    this.i3 = (this.i1 + 28);
                    this.i2 = this.i5;
                    goto _label_44;
                    
                _label_47: 
                    this.i7 = li32(this.i5);
                    this.i7 = (this.i7 + this.i6);
                    this.i7 = li32(this.i7);
                    if (this.i7 == 0) goto _label_48;
                    this.i8 = li8(this.i7 + 5);
                    this.i8 = (this.i8 & 0x03);
                    if (this.i8 == 0) goto _label_48;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 15:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_48: 
                    this.i7 = li32(this.i3);
                    this.i6 = (this.i6 + 4);
                    this.i2 = (this.i2 + 1);
                    if (!(this.i7 <= this.i2))
                    {
                        goto _label_47;
                        
                    _label_49: 
                        this.i2 = li32(this.i1 + 52);
                        this.i3 = (this.i1 + 52);
                        if (!(this.i2 < 1))
                        {
                            this.i2 = 0;
                            this.i5 = (this.i1 + 16);
                            this.i6 = this.i2;
                            goto _label_47;
                            
                        _label_50: 
                            this.i2 = 0;
                            this.i5 = (this.i1 + 24);
                            this.i6 = this.i2;
                            do 
                            {
                                this.i7 = li32(this.i5);
                                this.i7 = (this.i7 + this.i6);
                                this.i7 = li32(this.i7);
                                if (!(this.i7 == 0))
                                {
                                    this.i8 = li8(this.i7 + 5);
                                    this.i8 = (this.i8 & 0xFFFFFFFC);
                                    si8(this.i8, (this.i7 + 5));
                                };
                                this.i7 = li32(this.i0);
                                this.i6 = (this.i6 + 12);
                                this.i2 = (this.i2 + 1);
                                if (!(this.i7 > this.i2))
                                {
                                    this.i2 = this.i7;
                                    goto _label_51;
                                };
                            } while (true);
                        };
                    };
                    this.i2 = li32(this.i1 + 56);
                    this.i0 = (this.i1 + 56);
                    if (this.i2 > 0) goto _label_50;
                    
                _label_51: 
                    this.i0 = this.i2;
                    this.i2 = li32(this.i1 + 44);
                    this.i3 = li32(this.i3);
                    this.i5 = li32(this.i1 + 40);
                    this.i1 = li32(this.i1 + 48);
                    this.i2 = (this.i3 + this.i2);
                    this.i3 = li32(this.i4);
                    this.i1 = (this.i2 + this.i1);
                    this.i0 = (this.i5 + this.i0);
                    this.i1 = (this.i1 + this.i3);
                    this.i0 = (this.i0 * 3);
                    this.i0 = (this.i1 + this.i0);
                    this.i0 = (this.i0 << 2);
                    this.i0 = (this.i0 + 76);
                    goto _label_33;
                    
                _label_52: 
                    this.i0 = 0;
                    goto _label_33;
                    
                _label_53: 
                    this.i8 = this.i7;
                    
                _label_54: 
                    this.i9 = ((this.i8 != 0) ? 1 : 0);
                    this.i9 = (this.i9 & 0x01);
                    this.i2 = (this.i2 & 0xFF);
                    if (this.i2 == 118) goto _label_13;
                    
                _label_55: 
                    this.i2 = li8(this.i4);
                    if (!(this.i2 == 0)) goto _label_15;
                    this.i4 = 0;
                    goto _label_14;
                default:
                    throw ("Invalid state in _propagatemark");
            };
        }


    }
} cmodule.lua_wrapper

