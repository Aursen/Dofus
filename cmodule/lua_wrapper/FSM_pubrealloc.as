package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_pubrealloc extends Machine 
    {

        public static const intRegCount:int = 13;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
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
            var _local_1:FSM_pubrealloc;
            _local_1 = new (FSM_pubrealloc)();
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
                    public::mstate.esp = (public::mstate.esp - 0x1000);
                    this.i0 = li32(_malloc_active_2E_3509);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = li32(public::mstate.ebp + 12);
                    if (!(this.i0 < 1))
                    {
                        if (!(!(this.i0 == 1)))
                        {
                            this.i2 = 2;
                            si32(this.i2, _malloc_active_2E_3509);
                        };
                        this.i2 = 88;
                        si32(this.i2, _val_2E_1440);
                        this.i2 = 0;
                        
                    _label_1: 
                        public::mstate.eax = this.i2;
                        goto _label_35;
                    };
                    this.i0 = 1;
                    si32(this.i0, _malloc_active_2E_3509);
                    this.i0 = li8(_malloc_started_2E_3510_2E_b);
                    if (!(this.i0 == 0)) goto _label_19;
                    if (!(this.i2 == 0))
                    {
                        this.i2 = 0;
                        si32(this.i2, _malloc_active_2E_3509);
                        this.i3 = 88;
                        si32(this.i3, _val_2E_1440);
                        goto _label_1;
                    };
                    this.i0 = 0;
                    this.i4 = li32(_val_2E_1440);
                    this.i5 = (public::mstate.ebp + -4096);
                    
                _label_2: 
                    this.i6 = this.i0;
                    if (this.i6 == 1) goto _label_3;
                    if (!(this.i6 == 0)) goto _label_18;
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = __2E_str13;
                    this.i7 = 99;
                    this.i8 = 22;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i7, (public::mstate.esp + 16));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i5;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i8, _val_2E_1440);
                    goto _label_18;
                    
                _label_3: 
                    this.i0 = __2E_str876;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = __2E_str113335;
                    si32(this.i0, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getenv.start();
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i0 == 0))
                    {
                        this.i1 = li32(_malloc_cache);
                        this.i7 = li8(_malloc_hint_2E_b);
                        this.i8 = li8(_malloc_realloc_2E_b);
                        this.i9 = li8(_malloc_junk_2E_b);
                        this.i10 = li8(_malloc_sysv_2E_b);
                        this.i11 = li8(_malloc_zero_2E_b);
                        while ((this.i12 = this.i1), (this.i1 = li8(this.i0)), (!(this.i1 == 0)))
                        {
                            this.i1 = (this.i1 << 24);
                            this.i1 = (this.i1 >> 24);
                            if (!(this.i1 > 89))
                            {
                                if (!(this.i1 > 73))
                                {
                                    if (this.i1 == 60) goto _label_6;
                                    if (this.i1 == 62) goto _label_5;
                                    if (!(this.i1 == 72)) goto _label_4;
                                    this.i0 = (this.i0 + 1);
                                    if (this.i0 == 0) goto _label_8;
                                    this.i1 = 1;
                                    this.i7 = this.i1;
                                    this.i1 = this.i12;
                                    continue;
                                };
                                if (this.i1 == 74) goto _label_11;
                                if (this.i1 == 82) goto _label_9;
                                if (!(this.i1 == 86)) goto _label_4;
                                this.i0 = (this.i0 + 1);
                                if (this.i0 == 0) goto _label_13;
                                this.i1 = 1;
                                this.i10 = this.i1;
                                this.i1 = this.i12;
                                continue;
                            };
                            if (!(this.i1 > 113))
                            {
                                if (this.i1 == 90) goto _label_15;
                                if (this.i1 == 104) goto _label_7;
                                if (!(this.i1 == 106)) goto _label_4;
                                this.i0 = (this.i0 + 1);
                                if (this.i0 == 0) goto _label_10;
                                this.i1 = 0;
                                this.i9 = this.i1;
                                this.i1 = this.i12;
                                continue;
                            };
                            if (!(this.i1 == 114))
                            {
                                if (this.i1 == 118) goto _label_12;
                                if (this.i1 == 122) goto _label_14;
                                
                            _label_4: 
                                this.i1 = this.i11;
                                goto _label_16;
                                
                            _label_5: 
                                this.i0 = (this.i0 + 1);
                                this.i1 = (this.i12 << 1);
                                if (!(this.i0 == 0)) continue;
                                this.i0 = this.i11;
                                goto _label_17;
                                
                            _label_6: 
                                this.i0 = (this.i0 + 1);
                                this.i1 = (this.i12 >>> 1);
                                if (!(this.i0 == 0)) continue;
                                this.i0 = this.i11;
                                goto _label_17;
                                
                            _label_7: 
                                this.i0 = (this.i0 + 1);
                                if (!(this.i0 == 0))
                                {
                                    this.i1 = 0;
                                    this.i7 = this.i1;
                                    this.i1 = this.i12;
                                    continue;
                                };
                                this.i1 = 0;
                                this.i0 = this.i11;
                                this.i7 = this.i1;
                                this.i1 = this.i12;
                                goto _label_17;
                                
                            _label_8: 
                                this.i1 = 1;
                                this.i0 = this.i11;
                                this.i7 = this.i1;
                                this.i1 = this.i12;
                                goto _label_17;
                            };
                            this.i0 = (this.i0 + 1);
                            if (!(this.i0 == 0))
                            {
                                this.i1 = 0;
                                this.i8 = this.i1;
                                this.i1 = this.i12;
                            }
                            else
                            {
                                this.i1 = 0;
                                this.i0 = this.i11;
                                this.i8 = this.i1;
                                this.i1 = this.i12;
                                goto _label_17;
                                
                            _label_9: 
                                this.i0 = (this.i0 + 1);
                                if (!(this.i0 == 0))
                                {
                                    this.i1 = 1;
                                    this.i8 = this.i1;
                                    this.i1 = this.i12;
                                }
                                else
                                {
                                    this.i1 = 1;
                                    this.i0 = this.i11;
                                    this.i8 = this.i1;
                                    this.i1 = this.i12;
                                    goto _label_17;
                                    
                                _label_10: 
                                    this.i1 = 0;
                                    this.i0 = this.i11;
                                    this.i9 = this.i1;
                                    this.i1 = this.i12;
                                    goto _label_17;
                                    
                                _label_11: 
                                    this.i0 = (this.i0 + 1);
                                    if (!(this.i0 == 0))
                                    {
                                        this.i1 = 1;
                                        this.i9 = this.i1;
                                        this.i1 = this.i12;
                                    }
                                    else
                                    {
                                        this.i1 = 1;
                                        this.i0 = this.i11;
                                        this.i9 = this.i1;
                                        this.i1 = this.i12;
                                        goto _label_17;
                                        
                                    _label_12: 
                                        this.i0 = (this.i0 + 1);
                                        if (!(this.i0 == 0))
                                        {
                                            this.i1 = 0;
                                            this.i10 = this.i1;
                                            this.i1 = this.i12;
                                        }
                                        else
                                        {
                                            this.i1 = 0;
                                            this.i0 = this.i11;
                                            this.i10 = this.i1;
                                            this.i1 = this.i12;
                                            goto _label_17;
                                            
                                        _label_13: 
                                            this.i1 = 1;
                                            this.i0 = this.i11;
                                            this.i10 = this.i1;
                                            this.i1 = this.i12;
                                            goto _label_17;
                                            
                                        _label_14: 
                                            this.i0 = (this.i0 + 1);
                                            if (!(this.i0 == 0))
                                            {
                                                this.i1 = 0;
                                                this.i11 = this.i1;
                                                this.i1 = this.i12;
                                            }
                                            else
                                            {
                                                this.i0 = 0;
                                                this.i1 = this.i12;
                                                goto _label_17;
                                                
                                            _label_15: 
                                                this.i1 = 1;
                                                
                                            _label_16: 
                                                this.i0 = (this.i0 + 1);
                                                if (this.i0 == 0) goto _label_36;
                                                this.i11 = this.i1;
                                                this.i1 = this.i12;
                                            };
                                        };
                                    };
                                };
                            };
                        };
                        this.i0 = this.i11;
                        this.i1 = this.i12;
                        
                    _label_17: 
                        si32(this.i1, _malloc_cache);
                        si8(this.i7, _malloc_hint_2E_b);
                        si8(this.i8, _malloc_realloc_2E_b);
                        si8(this.i9, _malloc_junk_2E_b);
                        si8(this.i10, _malloc_sysv_2E_b);
                        si8(this.i0, _malloc_zero_2E_b);
                    };
                    
                _label_18: 
                    this.i0 = (this.i6 + 1);
                    if (!(this.i0 == 3)) goto _label_2;
                    this.i0 = li8(_malloc_zero_2E_b);
                    this.i0 = (this.i0 ^ 0x01);
                    this.i0 = (this.i0 & 0x01);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = 1;
                        si8(this.i0, _malloc_junk_2E_b);
                    };
                    this.i0 = __2E_str210;
                    this.i1 = 4;
                    this.i5 = 0;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = _sbrk(this.i5);
                    this.i0 = (this.i0 & 0x0FFF);
                    this.i0 = (0x1000 - this.i0);
                    this.i0 = (this.i0 & 0x0FFF);
                    this.i0 = _sbrk(this.i0);
                    this.i0 = 0x1000;
                    this.i0 = _sbrk(this.i0);
                    si32(this.i0, _page_dir);
                    this.i0 = this.i5;
                    this.i0 = _sbrk(this.i0);
                    this.i0 = (this.i0 + 4095);
                    this.i0 = (this.i0 >>> 12);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, _malloc_origo);
                    this.i0 = 0x0400;
                    si32(this.i0, _malloc_ninfo);
                    this.i0 = li32(_malloc_cache);
                    if ((this.i0 == 0))
                    {
                        this.i0 = (this.i0 + 1);
                        si32(this.i0, _malloc_cache);
                    };
                    this.i1 = 20;
                    this.i0 = (this.i0 << 12);
                    si32(this.i0, _malloc_cache);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_imalloc.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i0, _px);
                    si32(this.i4, _val_2E_1440);
                    this.i0 = 1;
                    si8(this.i0, _malloc_started_2E_3510_2E_b);
                    
                _label_19: 
                    this.i0 = li8(_malloc_sysv_2E_b);
                    this.i1 = ((this.i2 == 0x0800) ? 0 : this.i2);
                    this.i0 = (this.i0 ^ 0x01);
                    this.i0 = (this.i0 & 0x01);
                    if (!(this.i0 == 0)) goto _label_20;
                    if (!(this.i3 == 0)) goto _label_20;
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = 0;
                        this.i3 = this.i1;
                        goto _label_33;
                    };
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_ifree.start();
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i3, _malloc_active_2E_3509);
                    this.i1 = this.i3;
                    this.i0 = this.i1;
                    this.i1 = this.i3;
                    goto _label_34;
                    
                _label_20: 
                    if (!(this.i3 == 0)) goto _label_21;
                    if (!(!(this.i1 == 0)))
                    {
                        this.i3 = 0x0800;
                        this.i1 = 0;
                        goto _label_33;
                    };
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_ifree.start();
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i3, _malloc_active_2E_3509);
                    this.i1 = 0x0800;
                    this.i0 = this.i3;
                    goto _label_34;
                    
                _label_21: 
                    if (!(this.i1 == 0)) goto _label_22;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_imalloc.start();
                case 6:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = ((this.i3 == 0) ? 1 : 0);
                    si32(this.i1, _malloc_active_2E_3509);
                    this.i1 = (this.i0 & 0x01);
                    this.i0 = this.i1;
                    this.i1 = this.i3;
                    goto _label_34;
                    
                _label_22: 
                    this.i0 = li32(_malloc_origo);
                    this.i2 = (this.i1 >>> 12);
                    this.i4 = (this.i2 - this.i0);
                    this.i5 = this.i1;
                    if (!(uint(this.i4) > uint(11)))
                    {
                        
                    _label_23: 
                        this.i1 = 0;
                        goto _label_32;
                    };
                    this.i6 = li32(_last_index);
                    if (uint(this.i4) > uint(this.i6)) goto _label_23;
                    this.i6 = li32(_page_dir);
                    this.i7 = (this.i4 << 2);
                    this.i7 = (this.i6 + this.i7);
                    this.i7 = li32(this.i7);
                    this.i8 = this.i6;
                    if (!(this.i7 == 2)) goto _label_27;
                    this.i5 = (this.i5 & 0x0FFF);
                    if (!(this.i5 == 0)) goto _label_23;
                    this.i5 = (this.i4 << 2);
                    this.i5 = (this.i5 + this.i8);
                    this.i5 = li32(this.i5 + 4);
                    if (!(this.i5 == 3))
                    {
                        this.i0 = 0x1000;
                    }
                    else
                    {
                        this.i5 = -1;
                        this.i0 = (this.i2 - this.i0);
                        this.i0 = (this.i0 << 2);
                        this.i0 = (this.i0 + this.i6);
                        this.i0 = (this.i0 + 8);
                        do 
                        {
                            this.i7 = li32(this.i0);
                            this.i0 = (this.i0 + 4);
                            this.i5 = (this.i5 + 1);
                        } while (!(!(this.i7 == 3)));
                        this.i0 = (this.i5 << 12);
                        this.i0 = (this.i0 + 0x2000);
                    };
                    this.i5 = li8(_malloc_realloc_2E_b);
                    if (!(!(this.i5 == 0)))
                    {
                        if (uint(this.i0) >= uint(this.i3)) goto _label_25;
                    };
                    
                _label_24: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_imalloc.start();
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i1 = this.i2;
                        goto _label_32;
                        
                    _label_25: 
                        this.i5 = (this.i0 + -4096);
                        //unresolved if
                        this.i5 = li8(_malloc_junk_2E_b);
                        if (!(!(this.i5 == 0)))
                        {
                            
                        _label_26: 
                            goto _label_32;
                        };
                        this.i5 = -48;
                        this.i7 = (this.i1 + this.i3);
                        this.i0 = (this.i0 - this.i3);
                        this.i3 = ((this.i1 == 0) ? 1 : 0);
                        memset(this.i7, this.i5, this.i0);
                        this.i0 = 0;
                        si32(this.i0, _malloc_active_2E_3509);
                        this.i0 = (this.i3 & 0x01);
                        goto _label_34;
                        
                    _label_27: 
                        if (uint(this.i7) < uint(4)) goto _label_23;
                        this.i0 = li16(this.i7 + 8);
                        this.i2 = this.i0;
                        this.i4 = (this.i0 + -1);
                        this.i4 = (this.i4 & this.i5);
                        if (!(this.i4 == 0)) goto _label_23;
                        this.i4 = 1;
                        this.i6 = li16(this.i7 + 10);
                        this.i5 = (this.i5 & 0x0FFF);
                        this.i5 = (this.i5 >>> this.i6);
                        this.i6 = (this.i5 & 0xFFFFFFE0);
                        this.i6 = (this.i6 >>> 3);
                        this.i5 = (this.i5 & 0x1F);
                        this.i6 = (this.i7 + this.i6);
                        this.i6 = li32(this.i6 + 16);
                        this.i4 = (this.i4 << this.i5);
                        this.i4 = (this.i4 & this.i6);
                        if (!(this.i4 == 0)) goto _label_23;
                        this.i4 = li8(_malloc_realloc_2E_b);
                        if (!(uint(this.i2) < uint(this.i3)))
                        {
                            this.i4 = (this.i4 ^ 0x01);
                            this.i4 = (this.i4 & 0x01);
                            if (!(this.i4 == 0)) goto _label_29;
                        };
                        
                    _label_28: 
                        this.i0 = this.i2;
                        goto _label_24;
                        
                    _label_29: 
                        this.i4 = (this.i2 >>> 1);
                        if (!(uint(this.i4) < uint(this.i3)))
                        {
                            this.i0 = (this.i0 & 0xFFFF);
                            if (!(this.i0 == 16)) goto _label_28;
                        };
                        this.i0 = li8(_malloc_junk_2E_b);
                        this.i0 = (this.i0 ^ 0x01);
                        this.i0 = (this.i0 & 0x01);
                        if (!(this.i0 == 0)) goto _label_26;
                        this.i0 = -48;
                        this.i4 = (this.i1 + this.i3);
                        this.i3 = (this.i2 - this.i3);
                        this.i2 = ((this.i1 == 0) ? 1 : 0);
                        memset(this.i4, this.i0, this.i3);
                        this.i0 = 0;
                        si32(this.i0, _malloc_active_2E_3509);
                        this.i0 = (this.i2 & 0x01);
                        goto _label_34;
                    };
                    if (this.i0 == 0) goto _label_31;
                    if (this.i3 == 0) goto _label_31;
                    if (uint(this.i0) >= uint(this.i3)) goto _label_30;
                    this.i3 = 0;
                    this.i4 = this.i2;
                    this.i5 = this.i1;
                    memcpy(this.i4, this.i5, this.i0);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_ifree.start();
                case 8:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = ((this.i2 == 0) ? 1 : 0);
                    si32(this.i3, _malloc_active_2E_3509);
                    this.i1 = (this.i1 & 0x01);
                    this.i0 = this.i1;
                    this.i1 = this.i2;
                    goto _label_34;
                    
                _label_30: 
                    this.i0 = this.i2;
                    this.i4 = this.i1;
                    memcpy(this.i0, this.i4, this.i3);
                    
                _label_31: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_ifree.start();
                case 9:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = this.i2;
                    
                _label_32: 
                    this.i0 = this.i1;
                    this.i1 = ((this.i0 == 0) ? 1 : 0);
                    this.i1 = (this.i1 & 0x01);
                    this.i3 = this.i0;
                    
                _label_33: 
                    this.i0 = this.i1;
                    this.i1 = this.i3;
                    this.i2 = 0;
                    si32(this.i2, _malloc_active_2E_3509);
                    
                _label_34: 
                    if (!(this.i0 == 0))
                    {
                        this.i0 = 12;
                        si32(this.i0, _val_2E_1440);
                    };
                    public::mstate.eax = this.i1;
                    
                _label_35: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_36: 
                    this.i0 = this.i1;
                    this.i1 = this.i12;
                    goto _label_17;
                default:
                    throw ("Invalid state in _pubrealloc");
            };
        }


    }
}

