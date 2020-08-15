package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaV_settable extends Machine 
    {

        public static const intRegCount:int = 16;
        public static const NumberRegCount:int = 2;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
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
        public var f1:Number;


        public static function start():void
        {
            var _local_1:FSM_luaV_settable;
            _local_1 = new (FSM_luaV_settable)();
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
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(public::mstate.ebp + 20);
                    this.i5 = (this.i2 + 8);
                    this.i6 = (this.i1 + 16);
                    this.i7 = this.i2;
                    
                _label_1: 
                    this.i8 = li32(this.i3 + 8);
                    this.i9 = (this.i3 + 8);
                    if (!(this.i8 == 5)) goto _label_8;
                    this.i8 = 0;
                    this.i10 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_get.start();
                case 1:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si8(this.i8, (this.i10 + 6));
                    this.i8 = this.i10;
                    this.i12 = _luaO_nilobject_;
                    if (!(this.i11 == this.i12)) goto _label_4;
                    this.i11 = li32(this.i5);
                    if (this.i11 == 3) goto _label_2;
                    if (!(this.i11 == 0)) goto _label_3;
                    this.i11 = __2E_str3127;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 3:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_4;
                    
                _label_2: 
                    this.f0 = 0;
                    this.f1 = lf64(this.i7);
                    if ((!(this.f1 == Number.NaN)) && (!(this.f0 == Number.NaN))) goto _label_3;
                    this.i11 = __2E_str4128;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 5:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_4;
                    
                _label_3: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 6:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_4: 
                    this.i12 = li32(this.i11 + 8);
                    this.i13 = (this.i11 + 8);
                    if (!(this.i12 == 0)) goto _label_7;
                    this.i12 = li32(this.i10 + 8);
                    if (!(!(this.i12 == 0)))
                    {
                        
                    _label_5: 
                        this.i12 = 0;
                        goto _label_6;
                    };
                    this.i14 = li8(this.i12 + 6);
                    this.i14 = (this.i14 & 0x02);
                    if (!(this.i14 == 0)) goto _label_5;
                    this.i14 = 1;
                    this.i15 = li32(this.i6);
                    this.i15 = li32(this.i15 + 172);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettm.start();
                case 7:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_6: 
                    if (!(this.i12 == 0))
                    {
                        this.i8 = this.i12;
                        goto _label_9;
                    };
                    
                _label_7: 
                    this.f0 = lf64(this.i4);
                    sf64(this.f0, this.i11);
                    this.i0 = li32(this.i4 + 8);
                    si32(this.i0, this.i13);
                    this.i0 = li32(this.i4 + 8);
                    if (this.i0 < 4) goto _label_13;
                    this.i0 = li32(this.i4);
                    this.i0 = li8(this.i0 + 5);
                    this.i0 = (this.i0 & 0x03);
                    if (this.i0 == 0) goto _label_13;
                    this.i0 = li8(this.i8 + 5);
                    this.i3 = (this.i8 + 5);
                    this.i1 = (this.i0 & 0x04);
                    if (this.i1 == 0) goto _label_13;
                    this.i1 = li32(this.i6);
                    this.i0 = (this.i0 & 0xFFFFFFFB);
                    si8(this.i0, this.i3);
                    this.i0 = li32(this.i1 + 40);
                    si32(this.i0, (this.i10 + 24));
                    si32(this.i8, (this.i1 + 40));
                    goto _label_13;
                    
                _label_8: 
                    this.i8 = 1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 8:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i10 = li32(this.i8 + 8);
                    if (!(this.i10 == 0)) goto _label_9;
                    this.i10 = __2E_str2167;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_typeerror.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_9: 
                    this.i10 = li32(this.i8 + 8);
                    this.i11 = (this.i8 + 8);
                    if (!(this.i10 == 6)) goto _label_12;
                    this.i0 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i8);
                    sf64(this.f0, this.i0);
                    this.i2 = li32(this.i11);
                    si32(this.i2, (this.i0 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = li32(this.i9);
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i7);
                    sf64(this.f0, (this.i0 + 24));
                    this.i2 = li32(this.i5);
                    si32(this.i2, (this.i0 + 32));
                    this.i0 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i4);
                    sf64(this.f0, (this.i0 + 36));
                    this.i2 = li32(this.i4 + 8);
                    si32(this.i2, (this.i0 + 44));
                    this.i0 = li32(this.i1 + 28);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = (this.i1 + 8);
                    this.i0 = (this.i0 - this.i2);
                    if (this.i0 > 48) goto _label_11;
                    this.i0 = li32(this.i1 + 44);
                    if (this.i0 < 4) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i0 << 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_11;
                    
                _label_10: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i0 + 4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_11: 
                    this.i0 = 0;
                    this.i2 = li32(this.i3);
                    this.i4 = (this.i2 + 48);
                    si32(this.i4, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_13;
                    
                _label_12: 
                    this.i0 = (this.i0 + 1);
                    if (!(this.i0 > 99))
                    {
                        this.i3 = this.i8;
                        goto _label_1;
                    };
                    this.i0 = __2E_str4169;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_13: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaV_settable");
            };
        }


    }
}

