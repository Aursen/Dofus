package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_resize extends Machine 
    {

        public static const intRegCount:int = 19;
        public static const NumberRegCount:int = 2;

        public var f1:Number;
        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
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
        public var i18:int;


        public static function start():void
        {
            var _local_1:FSM_resize;
            _local_1 = new (FSM_resize)();
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
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(this.i0 + 28);
                    this.i2 = li8(this.i0 + 7);
                    this.i3 = li32(this.i0 + 16);
                    this.i4 = (this.i0 + 28);
                    this.i5 = li32(public::mstate.ebp + 8);
                    this.i6 = li32(public::mstate.ebp + 16);
                    this.i7 = li32(public::mstate.ebp + 20);
                    this.i8 = this.i3;
                    if (this.i1 >= this.i6) goto _label_4;
                    this.i9 = (this.i0 + 12);
                    this.i10 = (this.i6 + 1);
                    if (uint(this.i10) > uint(357913941)) goto _label_1;
                    this.i10 = li32(this.i9);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i11 = (this.i1 * 12);
                    this.i12 = (this.i6 * 12);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    si32(this.i12, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 1:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i10, this.i9);
                    this.i10 = li32(this.i4);
                    if (this.i10 >= this.i6) goto _label_3;
                    goto _label_2;
                    
                _label_1: 
                    this.i10 = 0;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i5, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_toobig.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i10, this.i9);
                    this.i10 = li32(this.i4);
                    if (!(this.i10 >= this.i6))
                    {
                        
                    _label_2: 
                        this.i11 = (this.i10 * 12);
                        this.i11 = (this.i11 + 8);
                        do 
                        {
                            this.i12 = 0;
                            this.i13 = li32(this.i9);
                            this.i13 = (this.i13 + this.i11);
                            si32(this.i12, this.i13);
                            this.i11 = (this.i11 + 12);
                            this.i10 = (this.i10 + 1);
                        } while (!(this.i10 >= this.i6));
                    };
                    
                _label_3: 
                    si32(this.i6, this.i4);
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_setnodevector.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i1 <= this.i6) goto _label_10;
                    this.i7 = (public::mstate.ebp + -16);
                    si32(this.i6, this.i4);
                    this.i4 = 0;
                    this.i9 = (this.i6 * 12);
                    this.i10 = (this.i6 + 1);
                    this.i11 = (this.i7 + 8);
                    this.i12 = (this.i1 - this.i6);
                    this.i13 = (this.i0 + 12);
                    
                _label_5: 
                    this.i14 = li32(this.i13);
                    this.i15 = (this.i14 + this.i9);
                    this.i16 = li32(this.i15 + 8);
                    this.i15 = (this.i15 + 8);
                    if (this.i16 == 0) goto _label_7;
                    this.i16 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i17 = (this.i10 + this.i4);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i17, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 4:
                    this.i18 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i18 == this.i16))
                    {
                        this.i17 = this.i18;
                        goto _label_6;
                    };
                    this.i16 = 3;
                    this.f0 = Number(this.i17);
                    sf64(this.f0, this.i7);
                    si32(this.i16, this.i11);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i17 = (public::mstate.ebp + -16);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i17, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 5:
                    this.i17 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_6: 
                    this.i16 = this.i17;
                    this.i14 = (this.i14 + this.i9);
                    this.f0 = lf64(this.i14);
                    sf64(this.f0, this.i16);
                    this.i14 = li32(this.i15);
                    si32(this.i14, (this.i16 + 8));
                    
                _label_7: 
                    this.i9 = (this.i9 + 12);
                    this.i4 = (this.i4 + 1);
                    if (!(this.i4 == this.i12)) goto _label_5;
                    this.i4 = (this.i6 + 1);
                    if (uint(this.i4) > uint(357913941)) goto _label_9;
                    this.i4 = li32(this.i5 + 16);
                    this.i7 = li32(this.i13);
                    this.i9 = li32(this.i4 + 12);
                    this.i10 = li32(this.i4 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = (this.i1 * 12);
                    this.i6 = (this.i6 * 12);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i9]());
                    return;
                case 6:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i7 == 0)) goto _label_8;
                    if (this.i6 == 0) goto _label_8;
                    this.i9 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_8: 
                    this.i9 = 1;
                    this.i10 = li32(this.i4 + 68);
                    this.i1 = (this.i6 - this.i1);
                    this.i1 = (this.i1 + this.i10);
                    this.i6 = (this.i9 << this.i2);
                    si32(this.i1, (this.i4 + 68));
                    si32(this.i7, this.i13);
                    this.i13 = (this.i6 + -1);
                    if (this.i13 < 0) goto _label_17;
                    goto _label_11;
                    
                _label_9: 
                    this.i1 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 8:
                    this.i1 = 1;
                    this.i1 = (this.i1 << this.i2);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = 0;
                    si32(this.i4, this.i13);
                    this.i13 = (this.i1 + -1);
                    if (this.i13 < 0) goto _label_17;
                    goto _label_11;
                    
                _label_10: 
                    this.i13 = 1;
                    this.i13 = (this.i13 << this.i2);
                    this.i13 = (this.i13 + -1);
                    if (this.i13 < 0) goto _label_17;
                    
                _label_11: 
                    this.i1 = this.i13;
                    this.i4 = (this.i1 * 28);
                    this.i3 = (this.i3 + this.i4);
                    this.i4 = (this.i0 + 6);
                    
                _label_12: 
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = (this.i3 + 8);
                    this.i9 = this.i3;
                    if (this.i6 == 0) goto _label_16;
                    this.i6 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i10 = (this.i3 + 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_get.start();
                case 9:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si8(this.i6, this.i4);
                    this.i6 = _luaO_nilobject_;
                    if (!(this.i11 == this.i6))
                    {
                        this.i10 = this.i11;
                        goto _label_15;
                    };
                    this.i6 = li32(this.i10 + 8);
                    if (this.i6 == 3) goto _label_13;
                    if (!(this.i6 == 0)) goto _label_14;
                    this.i6 = __2E_str3127;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 11:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_15;
                    
                _label_13: 
                    this.f0 = 0;
                    this.f1 = lf64(this.i3 + 12);
                    if ((!(this.f1 == Number.NaN)) && (!(this.f0 == Number.NaN))) goto _label_14;
                    this.i6 = __2E_str4128;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 13:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_15;
                    
                _label_14: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 14:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_15: 
                    this.i6 = this.i10;
                    this.f0 = lf64(this.i9);
                    sf64(this.f0, this.i6);
                    this.i7 = li32(this.i7);
                    si32(this.i7, (this.i6 + 8));
                    
                _label_16: 
                    this.i3 = (this.i3 + -28);
                    this.i1 = (this.i1 + -1);
                    if (!(this.i1 < 0)) goto _label_12;
                    
                _label_17: 
                    this.i0 = _dummynode_;
                    if (this.i8 == this.i0) goto _label_18;
                    this.i0 = 28;
                    this.i1 = li32(this.i5 + 16);
                    this.i3 = li32(this.i1 + 12);
                    this.i4 = li32(this.i1 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = 0;
                    this.i0 = (this.i0 << this.i2);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i3]());
                    return;
                case 15:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i1 + 68);
                    this.i0 = (this.i2 - this.i0);
                    si32(this.i0, (this.i1 + 68));
                    
                _label_18: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _resize");
            };
        }


    }
} cmodule.lua_wrapper

