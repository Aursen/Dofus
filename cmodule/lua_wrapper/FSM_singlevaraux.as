package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_singlevaraux extends Machine 
    {

        public static const intRegCount:int = 15;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
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
            var _local_1:FSM_singlevaraux;
            _local_1 = new (FSM_singlevaraux)();
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
                    public::mstate.esp = (public::mstate.esp - 160);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(public::mstate.ebp + 20);
                    this.i4 = this.i0;
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = -1;
                        si32(this.i0, (this.i2 + 12));
                        si32(this.i0, (this.i2 + 16));
                        this.i0 = 8;
                        si32(this.i0, this.i2);
                        this.i1 = 0xFF;
                        si32(this.i1, (this.i2 + 4));
                        goto _label_16;
                    };
                    this.i5 = li8(this.i0 + 50);
                    this.i6 = (this.i5 + -1);
                    if (!(this.i6 > -1))
                    {
                        
                    _label_1: 
                        this.i5 = -1;
                        
                    _label_2: 
                        if (this.i5 < 0) goto _label_7;
                        this.i1 = -1;
                        si32(this.i1, (this.i2 + 12));
                        si32(this.i1, (this.i2 + 16));
                        this.i1 = 6;
                        si32(this.i1, this.i2);
                        si32(this.i5, (this.i2 + 4));
                        if (this.i3 == 0) goto _label_4;
                        
                    _label_3: 
                        this.i0 = 6;
                        goto _label_16;
                    };
                    this.i5 = (this.i5 & 0xFF);
                    this.i6 = li32(this.i0);
                    this.i7 = (this.i5 << 1);
                    this.i6 = li32(this.i6 + 24);
                    this.i7 = (this.i4 + this.i7);
                    this.i7 = (this.i7 + 170);
                    this.i5 = (this.i5 + -1);
                    do 
                    {
                        this.i8 = li16(this.i7);
                        this.i8 = (this.i8 * 12);
                        this.i8 = (this.i6 + this.i8);
                        this.i8 = li32(this.i8);
                        if (!(!(this.i8 == this.i1))) goto _label_2;
                        this.i7 = (this.i7 + -2);
                        this.i5 = (this.i5 + -1);
                        if (this.i5 < 0) goto _label_1;
                    } while (true);
                    
                _label_4: 
                    this.i0 = li32(this.i0 + 20);
                    if ((this.i0 == 0))
                    {
                        goto _label_6;
                        
                    _label_5: 
                        this.i0 = li32(this.i0);
                        if (this.i0 == 0) goto _label_18;
                    };
                    this.i1 = li8(this.i0 + 8);
                    if (this.i1 > this.i5) goto _label_5;
                    
                _label_6: 
                    if (this.i0 == 0) goto _label_3;
                    this.i1 = 1;
                    si8(this.i1, (this.i0 + 9));
                    this.i0 = 6;
                    goto _label_16;
                    
                _label_7: 
                    this.i3 = 0;
                    this.i5 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_singlevaraux.start();
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(!(this.i3 == 8)))
                    {
                        this.i0 = 8;
                        goto _label_16;
                    };
                    this.i3 = li32(this.i0);
                    this.i5 = li32(this.i3 + 36);
                    this.i6 = li8(this.i3 + 72);
                    this.i7 = (this.i3 + 72);
                    this.i8 = (this.i3 + 36);
                    if (!(this.i6 < 1))
                    {
                        this.i9 = 0;
                        this.i10 = li32(this.i2);
                        this.i11 = (this.i2 + 4);
                        this.i12 = this.i2;
                        do 
                        {
                            this.i13 = li8(this.i4 + 51);
                            if (!(!(this.i13 == this.i10)))
                            {
                                this.i13 = li8(this.i4 + 52);
                                this.i14 = li32(this.i11);
                                if (this.i13 == this.i14) goto _label_15;
                            };
                            this.i4 = (this.i4 + 2);
                            this.i9 = (this.i9 + 1);
                        } while (!(this.i6 <= this.i9));
                    };
                    this.i9 = (this.i6 + 1);
                    if (this.i9 < 61) goto _label_9;
                    this.i9 = li32(this.i3 + 60);
                    this.i11 = li32(this.i0 + 16);
                    this.i12 = (this.i0 + 12);
                    if (!(this.i9 == 0)) goto _label_8;
                    this.i9 = __2E_str196;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = __2E_str6101;
                    this.i6 = 60;
                    si32(this.i11, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 2:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i11 = li32(this.i12);
                    this.i12 = li32(this.i11 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 80;
                    this.i6 = (public::mstate.ebp + -160);
                    this.i12 = (this.i12 + 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = li32(this.i11 + 4);
                    this.i4 = li32(this.i11 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i10 = __2E_str15272;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i12, (public::mstate.esp + 12));
                    si32(this.i9, (public::mstate.esp + 16));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 4:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i9 = li32(this.i11 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = 3;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_9;
                    
                _label_8: 
                    this.i4 = __2E_str297;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i6 = __2E_str6101;
                    this.i10 = 60;
                    si32(this.i11, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i10, (public::mstate.esp + 12));
                    si32(this.i6, (public::mstate.esp + 16));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 6:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i11 = li32(this.i12);
                    this.i12 = li32(this.i11 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 80;
                    this.i6 = (public::mstate.ebp + -80);
                    this.i12 = (this.i12 + 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = li32(this.i11 + 4);
                    this.i4 = li32(this.i11 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i10 = __2E_str15272;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i12, (public::mstate.esp + 12));
                    si32(this.i9, (public::mstate.esp + 16));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 8:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i9 = li32(this.i11 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = 3;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_9: 
                    this.i9 = li8(this.i7);
                    this.i11 = li32(this.i8);
                    this.i9 = (this.i9 + 1);
                    if (!(this.i9 > this.i11)) goto _label_11;
                    this.i9 = __2E_str45;
                    this.i11 = li32(this.i3 + 28);
                    this.i12 = li32(this.i0 + 16);
                    public::mstate.esp = (public::mstate.esp - 24);
                    this.i4 = 2147483645;
                    this.i6 = 4;
                    si32(this.i12, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    si32(this.i4, (public::mstate.esp + 16));
                    si32(this.i9, (public::mstate.esp + 20));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_growaux_.start();
                    return;
                case 10:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 24);
                    si32(this.i9, (this.i3 + 28));
                    this.i11 = li32(this.i8);
                    if (!(this.i11 > this.i5))
                    {
                        this.i5 = this.i9;
                        goto _label_12;
                        
                    _label_10: 
                        this.i9 = this.i11;
                    };
                    this.i11 = 0;
                    this.i12 = (this.i5 << 2);
                    this.i9 = (this.i9 + this.i12);
                    si32(this.i11, this.i9);
                    this.i5 = (this.i5 + 1);
                    
                _label_11: 
                    this.i9 = li32(this.i8);
                    this.i11 = li32(this.i3 + 28);
                    if (this.i9 > this.i5) goto _label_10;
                    this.i5 = this.i11;
                    
                _label_12: 
                    this.i9 = this.i5;
                    this.i11 = li8(this.i7);
                    this.i11 = (this.i11 << 2);
                    this.i9 = (this.i9 + this.i11);
                    si32(this.i1, this.i9);
                    this.i9 = li8(this.i1 + 5);
                    this.i9 = (this.i9 & 0x03);
                    if (this.i9 == 0) goto _label_14;
                    this.i9 = li8(this.i3 + 5);
                    this.i11 = (this.i3 + 5);
                    this.i12 = (this.i9 & 0x04);
                    if (this.i12 == 0) goto _label_14;
                    this.i12 = li32(this.i0 + 16);
                    this.i12 = li32(this.i12 + 16);
                    this.i3 = li8(this.i12 + 21);
                    if (!(this.i3 == 1)) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 11:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_14;
                    
                _label_13: 
                    this.i12 = li8(this.i12 + 20);
                    this.i9 = (this.i9 & 0xFFFFFFF8);
                    this.i12 = (this.i12 & 0x03);
                    this.i9 = (this.i12 | this.i9);
                    si8(this.i9, this.i11);
                    
                _label_14: 
                    this.i9 = 7;
                    this.i11 = li8(this.i7);
                    this.i12 = li8(this.i2);
                    this.i11 = (this.i11 << 1);
                    this.i0 = (this.i0 + 51);
                    this.i11 = (this.i0 + this.i11);
                    si8(this.i12, this.i11);
                    this.i11 = li8(this.i7);
                    this.i12 = li8(this.i2 + 4);
                    this.i11 = (this.i11 << 1);
                    this.i0 = (this.i0 + this.i11);
                    si8(this.i12, (this.i0 + 1));
                    this.i0 = li8(this.i7);
                    this.i11 = (this.i0 + 1);
                    si8(this.i11, this.i7);
                    si32(this.i0, (this.i2 + 4));
                    si32(this.i9, this.i2);
                    public::mstate.eax = this.i9;
                    goto _label_17;
                    
                _label_15: 
                    this.i0 = 7;
                    si32(this.i9, this.i11);
                    si32(this.i0, this.i12);
                    
                _label_16: 
                    public::mstate.eax = this.i0;
                    
                _label_17: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_18: 
                    goto _label_6;
                default:
                    throw ("Invalid state in _singlevaraux");
            };
        }


    }
} cmodule.lua_wrapper

