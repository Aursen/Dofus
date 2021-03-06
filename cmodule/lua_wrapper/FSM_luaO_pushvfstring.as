package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaO_pushvfstring extends Machine 
    {

        public static const intRegCount:int = 17;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var f0:Number;
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
            var _local_1:FSM_luaO_pushvfstring;
            _local_1 = new (FSM_luaO_pushvfstring)();
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
                    public::mstate.esp = (public::mstate.esp - 48);
                    this.i0 = __2E_str45;
                    this.i1 = li32(public::mstate.ebp + 16);
                    si32(this.i1, (public::mstate.ebp + -4));
                    this.i1 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    this.i0 = (public::mstate.ebp + -48);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pushstr.start();
                    return;
                case 1:
                    this.i2 = (public::mstate.ebp + -6);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = (this.i1 + 44);
                    this.i4 = (this.i0 + 2);
                    this.i5 = (this.i0 + 1);
                    this.i6 = (public::mstate.ebp + -32);
                    this.i7 = (this.i2 + 1);
                    this.i8 = 1;
                    this.i9 = (this.i1 + 28);
                    this.i10 = (this.i1 + 8);
                    this.i11 = li32(public::mstate.ebp + 12);
                    
                _label_1: 
                    this.i12 = li8(this.i11);
                    this.i13 = this.i11;
                    if (this.i12 == 37) goto _label_21;
                    this.i12 = this.i13;
                    do 
                    {
                        this.i13 = li8(this.i12);
                        if (!(!(this.i13 == 0)))
                        {
                            this.i12 = 0;
                            goto _label_22;
                        };
                        this.i13 = li8(this.i12 + 1);
                        this.i12 = (this.i12 + 1);
                        this.i14 = this.i12;
                        if (this.i13 == 37) goto _label_22;
                        this.i12 = this.i14;
                    } while (true);
                    
                _label_2: 
                    goto _label_20;
                    
                _label_3: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = (this.i11 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_4: 
                    this.i11 = li32(this.i10);
                    this.i14 = (this.i11 + 12);
                    si32(this.i14, this.i10);
                    this.i14 = sxi8(li8(this.i12 + 1));
                    this.i16 = (this.i12 + 1);
                    if (this.i14 > 101) goto _label_5;
                    if (this.i14 == 37) goto _label_16;
                    if (this.i14 == 99) goto _label_7;
                    if (!(this.i14 == 100)) goto _label_17;
                    this.i16 = 3;
                    this.i14 = li32(public::mstate.ebp + -4);
                    this.i15 = (this.i14 + 4);
                    si32(this.i15, (public::mstate.ebp + -4));
                    this.i14 = li32(this.i14);
                    this.f0 = Number(this.i14);
                    sf64(this.f0, (this.i11 + 12));
                    si32(this.i16, (this.i11 + 20));
                    this.i11 = li32(this.i9);
                    this.i16 = li32(this.i10);
                    this.i13 = (this.i13 << 1);
                    this.i8 = (this.i13 + this.i8);
                    this.i11 = (this.i11 - this.i16);
                    if (this.i11 > 12) goto _label_10;
                    this.i11 = li32(this.i3);
                    if (this.i11 < 1) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = (this.i11 << 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_9;
                    
                _label_5: 
                    if (this.i14 == 102) goto _label_11;
                    if (this.i14 == 112) goto _label_15;
                    if (!(this.i14 == 115)) goto _label_17;
                    this.i11 = __2E_str522;
                    this.i16 = li32(public::mstate.ebp + -4);
                    this.i14 = (this.i16 + 4);
                    si32(this.i14, (public::mstate.ebp + -4));
                    this.i16 = li32(this.i16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = ((this.i16 == 0) ? this.i11 : this.i16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pushstr.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = li8(this.i12 + 2);
                    this.i12 = (this.i12 + 2);
                    if (this.i11 == 37) goto _label_24;
                    this.i11 = this.i15;
                    do 
                    {
                        this.i16 = li8(this.i11 + 2);
                        if (!(!(this.i16 == 0)))
                        {
                            this.i11 = 0;
                            goto _label_6;
                        };
                        this.i16 = li8(this.i11 + 3);
                        this.i11 = (this.i11 + 1);
                    } while (!(this.i16 == 37));
                    this.i11 = (this.i11 + 2);
                    
                _label_6: 
                    this.i16 = this.i11;
                    this.i11 = (this.i13 + 1);
                    if (this.i16 == 0) goto _label_19;
                    this.i13 = this.i11;
                    this.i11 = this.i12;
                    this.i12 = this.i16;
                    goto _label_23;
                    
                _label_7: 
                    this.i11 = 0;
                    this.i16 = li32(public::mstate.ebp + -4);
                    this.i14 = (this.i16 + 4);
                    si32(this.i14, (public::mstate.ebp + -4));
                    this.i16 = li8(this.i16);
                    si8(this.i16, this.i2);
                    si8(this.i11, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pushstr.start();
                    return;
                case 5:
                    this.i11 = (this.i13 << 1);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = (this.i11 + this.i8);
                    goto _label_18;
                    
                _label_8: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = (this.i11 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_9: 
                    this.i11 = li32(this.i10);
                    this.i11 = (this.i11 + 12);
                    si32(this.i11, this.i10);
                    this.i11 = this.i8;
                    goto _label_18;
                    
                _label_10: 
                    this.i11 = (this.i16 + 12);
                    si32(this.i11, this.i10);
                    this.i11 = this.i8;
                    goto _label_18;
                    
                _label_11: 
                    this.i16 = 3;
                    this.i14 = li32(public::mstate.ebp + -4);
                    this.i15 = (this.i14 + 8);
                    si32(this.i15, (public::mstate.ebp + -4));
                    this.f0 = lf64(this.i14);
                    sf64(this.f0, (this.i11 + 12));
                    si32(this.i16, (this.i11 + 20));
                    this.i11 = li32(this.i9);
                    this.i16 = li32(this.i10);
                    this.i13 = (this.i13 << 1);
                    this.i8 = (this.i13 + this.i8);
                    this.i11 = (this.i11 - this.i16);
                    if (this.i11 > 12) goto _label_14;
                    this.i11 = li32(this.i3);
                    if (this.i11 < 1) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = (this.i11 << 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_13;
                    
                _label_12: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = (this.i11 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_13: 
                    this.i11 = li32(this.i10);
                    this.i11 = (this.i11 + 12);
                    si32(this.i11, this.i10);
                    this.i11 = this.i8;
                    goto _label_18;
                    
                _label_14: 
                    this.i11 = (this.i16 + 12);
                    si32(this.i11, this.i10);
                    this.i11 = this.i8;
                    goto _label_18;
                    
                _label_15: 
                    this.i11 = __2E_str352305;
                    this.i16 = li32(public::mstate.ebp + -4);
                    this.i14 = (this.i16 + 4);
                    si32(this.i14, (public::mstate.ebp + -4));
                    this.i16 = li32(this.i16);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i16, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pushstr.start();
                    return;
                case 10:
                    this.i11 = (this.i13 << 1);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = (this.i11 + this.i8);
                    goto _label_18;
                    
                _label_16: 
                    this.i11 = __2E_str453306;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pushstr.start();
                    return;
                case 11:
                    this.i11 = (this.i13 << 1);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = (this.i11 + this.i8);
                    goto _label_18;
                    
                _label_17: 
                    this.i11 = 37;
                    si8(this.i11, this.i0);
                    this.i11 = li8(this.i16);
                    si8(this.i11, this.i5);
                    this.i11 = 0;
                    si8(this.i11, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pushstr.start();
                    return;
                case 12:
                    this.i11 = (this.i13 << 1);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = (this.i11 + this.i8);
                    
                _label_18: 
                    this.i8 = this.i11;
                    this.i11 = (this.i12 + 2);
                    this.i8 = (this.i8 + 2);
                    goto _label_1;
                    
                _label_19: 
                    this.i11 = (this.i11 << 1);
                    this.i8 = (this.i11 + this.i8);
                    this.i11 = this.i12;
                    
                _label_20: 
                    this.i0 = this.i8;
                    this.i2 = this.i11;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pushstr.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i10);
                    this.i3 = li32(this.i1 + 12);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i0 + 1);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = (0 - this.i0);
                    this.i0 = (this.i0 ^ 0xFFFFFFFF);
                    this.i2 = li32(this.i10);
                    this.i1 = (this.i1 * 12);
                    this.i0 = (this.i0 * 12);
                    this.i1 = (this.i2 + this.i1);
                    si32(this.i1, this.i10);
                    this.i0 = (this.i2 + this.i0);
                    this.i0 = li32(this.i0);
                    this.i0 = (this.i0 + 16);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_21: 
                    this.i12 = this.i11;
                    
                _label_22: 
                    if (this.i12 == 0) goto _label_2;
                    this.i13 = 0;
                    
                _label_23: 
                    this.i14 = 4;
                    this.i15 = li32(this.i10);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i16 = (this.i12 - this.i11);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i16, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 15:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i11, this.i15);
                    si32(this.i14, (this.i15 + 8));
                    this.i11 = li32(this.i9);
                    this.i14 = li32(this.i10);
                    this.i15 = this.i12;
                    this.i11 = (this.i11 - this.i14);
                    if (this.i11 > 12) goto _label_4;
                    this.i11 = li32(this.i3);
                    if (this.i11 < 1) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = (this.i11 << 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_4;
                    
                _label_24: 
                    this.i11 = this.i12;
                    goto _label_6;
                default:
                    throw ("Invalid state in _luaO_pushvfstring");
            };
        }


    }
}

