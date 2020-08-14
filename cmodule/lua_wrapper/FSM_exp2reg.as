package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_exp2reg extends Machine 
    {

        public static const intRegCount:int = 16;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
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
            var _local_1:FSM_exp2reg;
            _local_1 = new (FSM_exp2reg)();
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
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_discharge2reg.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i1);
                    this.i4 = this.i1;
                    if (!(this.i3 == 10)) goto _label_1;
                    this.i3 = li32(this.i1 + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i1 + 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i3 = li32(this.i1 + 12);
                    this.i5 = li32(this.i1 + 16);
                    this.i6 = (this.i1 + 16);
                    this.i7 = (this.i1 + 12);
                    if (this.i3 == this.i5) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_need_value.start();
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i3 == 0)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_need_value.start();
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(!(this.i3 == 0)))
                    {
                        this.i3 = -1;
                        this.i5 = this.i3;
                        goto _label_4;
                    };
                    
                _label_2: 
                    this.i3 = li32(this.i4);
                    if (!(!(this.i3 == 10)))
                    {
                        this.i3 = -1;
                        goto _label_3;
                    };
                    this.i3 = -1;
                    this.i5 = li32(this.i0 + 32);
                    si32(this.i3, (this.i0 + 32));
                    this.i3 = li32(this.i0 + 12);
                    this.i3 = li32(this.i3 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 2147450902;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 5:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -4));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (public::mstate.ebp + -4);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(public::mstate.ebp + -4);
                    
                _label_3: 
                    this.i5 = li32(this.i0 + 24);
                    si32(this.i5, (this.i0 + 28));
                    this.i5 = li32(this.i0 + 12);
                    this.i5 = li32(this.i5 + 8);
                    this.i8 = (this.i2 << 6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = (this.i8 | 0x4002);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 7:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i9 = li32(this.i0 + 24);
                    si32(this.i9, (this.i0 + 28));
                    this.i9 = li32(this.i0 + 12);
                    this.i9 = li32(this.i9 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 | 0x800002);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 8:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i9 = li32(this.i0 + 24);
                    si32(this.i9, (this.i0 + 28));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = (this.i0 + 32);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = this.i8;
                    
                _label_4: 
                    this.i8 = li32(this.i0 + 24);
                    si32(this.i8, (this.i0 + 28));
                    this.i9 = li32(this.i6);
                    if (this.i9 == -1) goto _label_8;
                    this.i10 = (this.i0 + 12);
                    this.i11 = this.i0;
                    
                _label_5: 
                    this.i12 = li32(this.i11);
                    this.i12 = li32(this.i12 + 12);
                    this.i13 = (this.i9 << 2);
                    this.i13 = (this.i12 + this.i13);
                    this.i13 = li32(this.i13);
                    this.i13 = (this.i13 >>> 14);
                    this.i13 = (this.i13 + -131071);
                    if (!(!(this.i13 == -1)))
                    {
                        this.i13 = -1;
                    }
                    else
                    {
                        this.i13 = (this.i9 + this.i13);
                        this.i13 = (this.i13 + 1);
                    };
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_patchtestreg395396.start();
                case 10:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = li32(this.i11);
                    this.i15 = li32(this.i10);
                    this.i14 = li32(this.i14 + 12);
                    if (this.i12 == 0) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fixjump393394.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i13 == -1) goto _label_8;
                    
                _label_6: 
                    this.i9 = this.i13;
                    goto _label_5;
                    
                _label_7: 
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fixjump393394.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i13 == -1)) goto _label_6;
                    
                _label_8: 
                    this.i5 = li32(this.i7);
                    if (this.i5 == -1) goto _label_12;
                    this.i9 = (this.i0 + 12);
                    
                _label_9: 
                    this.i10 = li32(this.i0);
                    this.i10 = li32(this.i10 + 12);
                    this.i11 = (this.i5 << 2);
                    this.i11 = (this.i10 + this.i11);
                    this.i11 = li32(this.i11);
                    this.i11 = (this.i11 >>> 14);
                    this.i11 = (this.i11 + -131071);
                    if (!(!(this.i11 == -1)))
                    {
                        this.i11 = -1;
                    }
                    else
                    {
                        this.i11 = (this.i5 + this.i11);
                        this.i11 = (this.i11 + 1);
                    };
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_patchtestreg395396.start();
                case 13:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = li32(this.i0);
                    this.i13 = li32(this.i9);
                    this.i12 = li32(this.i12 + 12);
                    if (this.i10 == 0) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fixjump393394.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i11 == -1) goto _label_12;
                    
                _label_10: 
                    this.i5 = this.i11;
                    goto _label_9;
                    
                _label_11: 
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fixjump393394.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i11 == -1)) goto _label_10;
                    
                _label_12: 
                    this.i0 = -1;
                    si32(this.i0, this.i7);
                    si32(this.i0, this.i6);
                    si32(this.i2, (this.i1 + 4));
                    this.i0 = 12;
                    si32(this.i0, this.i4);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _exp2reg");
            };
        }


    }
} cmodule.lua_wrapper

