package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaD_precall extends Machine 
    {

        public static const intRegCount:int = 21;
        public static const NumberRegCount:int = 1;

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
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_luaD_precall;
            _local_1 = new (FSM_luaD_precall)();
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
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(this.i1 + 8);
                    if (!(!(this.i3 == 6))) goto _label_5;
                    this.i3 = 16;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i0 + 32);
                    this.i5 = li32(this.i3 + 8);
                    this.i6 = (this.i0 + 8);
                    this.i7 = (this.i3 + 8);
                    this.i4 = (this.i1 - this.i4);
                    this.i8 = (this.i0 + 32);
                    if (this.i5 == 6) goto _label_1;
                    this.i5 = __2E_str9216;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_typeerror.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(this.i6);
                    if (!(uint(this.i5) <= uint(this.i1)))
                    {
                        goto _label_2;
                        
                    _label_1: 
                        this.i5 = li32(this.i6);
                        if (!(uint(this.i5) <= uint(this.i1)))
                        {
                            
                        _label_2: 
                            this.i9 = 0;
                            this.i10 = this.i5;
                            do 
                            {
                                this.i11 = (this.i9 ^ 0xFFFFFFFF);
                                this.i11 = (this.i11 * 12);
                                this.i11 = (this.i5 + this.i11);
                                this.f0 = lf64(this.i11);
                                sf64(this.f0, this.i10);
                                this.i12 = li32(this.i11 + 8);
                                si32(this.i12, (this.i10 + 8));
                                this.i10 = (this.i10 + -12);
                                this.i9 = (this.i9 + 1);
                            } while (!(uint(this.i11) <= uint(this.i1)));
                        };
                    };
                    this.i1 = li32(this.i0 + 28);
                    this.i5 = li32(this.i6);
                    this.i1 = (this.i1 - this.i5);
                    if (this.i1 > 12) goto _label_4;
                    this.i1 = li32(this.i0 + 44);
                    if (this.i1 < 1) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_4;
                    
                _label_3: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 + 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_4: 
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i6);
                    this.i1 = li32(this.i8);
                    this.f0 = lf64(this.i3);
                    this.i1 = (this.i1 + this.i4);
                    sf64(this.f0, this.i1);
                    this.i3 = li32(this.i7);
                    si32(this.i3, (this.i1 + 8));
                    
                _label_5: 
                    this.i3 = li32(this.i0 + 32);
                    this.i4 = li32(this.i1);
                    this.i5 = li32(this.i0 + 20);
                    this.i6 = li32(this.i0 + 24);
                    si32(this.i6, (this.i5 + 12));
                    this.i5 = li8(this.i4 + 6);
                    this.i6 = (this.i0 + 24);
                    this.i7 = (this.i0 + 20);
                    this.i1 = (this.i1 - this.i3);
                    this.i3 = (this.i0 + 32);
                    if (!(this.i5 == 0)) goto _label_37;
                    this.i4 = li32(this.i4 + 16);
                    this.i5 = li8(this.i4 + 75);
                    this.i8 = li32(this.i0 + 28);
                    this.i9 = li32(this.i0 + 8);
                    this.i10 = (this.i4 + 75);
                    this.i11 = (this.i0 + 8);
                    this.i12 = (this.i5 * 12);
                    this.i8 = (this.i8 - this.i9);
                    if (this.i8 > this.i12) goto _label_7;
                    this.i8 = li32(this.i0 + 44);
                    if (this.i8 < this.i5) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i8 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_7;
                    
                _label_6: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i8 + this.i5);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_7: 
                    this.i5 = li32(this.i3);
                    this.i8 = li8(this.i4 + 74);
                    this.i5 = (this.i5 + this.i1);
                    this.i9 = (this.i4 + 74);
                    this.i12 = this.i5;
                    if (!(!(this.i8 == 0)))
                    {
                        this.i1 = li8(this.i4 + 73);
                        this.i1 = (this.i1 * 12);
                        this.i3 = li32(this.i11);
                        this.i1 = (this.i1 + this.i12);
                        this.i1 = (this.i1 + 12);
                        this.i5 = (this.i12 + 12);
                        if (!(uint(this.i3) > uint(this.i1)))
                        {
                            this.i1 = this.i5;
                            this.i5 = this.i12;
                            goto _label_28;
                        };
                        si32(this.i1, this.i11);
                        this.i1 = li32(this.i7);
                        this.i3 = li32(this.i0 + 36);
                        if (!(this.i1 == this.i3))
                        {
                            this.i3 = this.i12;
                            
                        _label_8: 
                            this.i9 = (this.i1 + 24);
                            this.i8 = this.i9;
                            this.i1 = this.i5;
                            this.i5 = this.i9;
                            goto _label_33;
                        };
                        this.i1 = this.i5;
                        this.i5 = this.i12;
                        goto _label_29;
                    };
                    this.i8 = li32(this.i11);
                    this.i5 = (this.i8 - this.i5);
                    this.i12 = li8(this.i4 + 73);
                    this.i5 = (this.i5 / 12);
                    this.i13 = (this.i5 + -1);
                    this.i14 = this.i12;
                    if (!(this.i13 < this.i12))
                    {
                        this.i5 = this.i8;
                        this.i8 = this.i13;
                    }
                    else
                    {
                        this.i13 = 0;
                        this.i5 = (this.i12 - this.i5);
                        this.i5 = (this.i5 + 1);
                        do 
                        {
                            this.i15 = 0;
                            si32(this.i15, (this.i8 + 8));
                            this.i8 = (this.i8 + 12);
                            si32(this.i8, this.i11);
                            this.i13 = (this.i13 + 1);
                        } while (!(this.i13 == this.i5));
                        this.i5 = this.i8;
                        this.i8 = this.i12;
                    };
                    this.i9 = li8(this.i9);
                    this.i9 = (this.i9 & 0x04);
                    if (this.i9 == 0) goto _label_25;
                    this.i5 = li32(this.i0 + 16);
                    this.i9 = li32(this.i5 + 68);
                    this.i13 = li32(this.i5 + 64);
                    this.i15 = (this.i5 + 68);
                    this.i16 = (this.i0 + 16);
                    this.i17 = (this.i8 - this.i12);
                    if (uint(this.i9) < uint(this.i13)) goto _label_16;
                    this.i5 = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i15 = li32(this.i16);
                    this.i9 = li32(this.i15 + 12);
                    this.i13 = li32(this.i15 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i18 = 0;
                    si32(this.i13, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i18, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i9]());
                    return;
                case 8:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i5 == 0)) goto _label_9;
                    this.i9 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_9: 
                    this.i9 = 5;
                    this.i13 = li32(this.i15 + 68);
                    this.i13 = (this.i13 + 32);
                    si32(this.i13, (this.i15 + 68));
                    this.i15 = li32(this.i16);
                    this.i13 = li32(this.i15 + 28);
                    si32(this.i13, this.i5);
                    si32(this.i5, (this.i15 + 28));
                    this.i15 = li8(this.i15 + 20);
                    this.i15 = (this.i15 & 0x03);
                    si8(this.i15, (this.i5 + 5));
                    si8(this.i9, (this.i5 + 4));
                    this.i15 = 0;
                    si32(this.i15, (this.i5 + 8));
                    this.i9 = -1;
                    si8(this.i9, (this.i5 + 6));
                    si32(this.i15, (this.i5 + 12));
                    si32(this.i15, (this.i5 + 28));
                    si8(this.i15, (this.i5 + 7));
                    this.i15 = _dummynode_;
                    si32(this.i15, (this.i5 + 16));
                    this.i15 = (this.i5 + 28);
                    this.i9 = (this.i5 + 12);
                    this.i13 = (this.i17 + 1);
                    if (uint(this.i13) > uint(357913941)) goto _label_11;
                    this.i13 = 0;
                    this.i16 = li32(this.i16);
                    this.i18 = li32(this.i16 + 12);
                    this.i19 = li32(this.i16 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i20 = (this.i17 * 12);
                    si32(this.i19, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i20, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i18]());
                    return;
                case 10:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i13 == 0)) goto _label_10;
                    if (this.i20 == 0) goto _label_10;
                    this.i18 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_10: 
                    this.i18 = li32(this.i16 + 68);
                    this.i18 = (this.i20 + this.i18);
                    si32(this.i18, (this.i16 + 68));
                    si32(this.i13, this.i9);
                    this.i16 = li32(this.i15);
                    if (this.i16 >= this.i17) goto _label_13;
                    goto _label_12;
                    
                _label_11: 
                    this.i16 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i16 = 0;
                    si32(this.i16, this.i9);
                    this.i16 = li32(this.i15);
                    if (!(this.i16 >= this.i17))
                    {
                        
                    _label_12: 
                        this.i13 = (this.i16 * 12);
                        this.i13 = (this.i13 + 8);
                        do 
                        {
                            this.i18 = 0;
                            this.i19 = li32(this.i9);
                            this.i19 = (this.i19 + this.i13);
                            si32(this.i18, this.i19);
                            this.i13 = (this.i13 + 12);
                            this.i16 = (this.i16 + 1);
                        } while (!(this.i16 >= this.i17));
                    };
                    
                _label_13: 
                    this.i16 = 1;
                    si32(this.i17, this.i15);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i16, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_setnodevector.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i17 > 0)) goto _label_24;
                    
                _label_14: 
                    this.i9 = (public::mstate.ebp + -16);
                    this.i13 = (this.i14 & 0xFF);
                    this.i13 = (this.i8 - this.i13);
                    this.i13 = (this.i13 * -12);
                    this.i14 = 0;
                    this.i15 = (this.i9 + 8);
                    
                _label_15: 
                    this.i16 = _luaO_nilobject_;
                    this.i18 = li32(this.i11);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i19 = (this.i14 + 1);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i19, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 14:
                    this.i20 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i20 == this.i16) goto _label_22;
                    this.i19 = this.i20;
                    goto _label_23;
                    
                _label_16: 
                    this.i9 = 32;
                    this.i13 = li32(this.i5 + 12);
                    this.i5 = li32(this.i5 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i18 = 0;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i18, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i13]());
                    return;
                case 15:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i5 == 0)) goto _label_17;
                    this.i9 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_17: 
                    this.i9 = 5;
                    this.i13 = li32(this.i15);
                    this.i13 = (this.i13 + 32);
                    si32(this.i13, this.i15);
                    this.i13 = li32(this.i16);
                    this.i15 = li32(this.i13 + 28);
                    si32(this.i15, this.i5);
                    si32(this.i5, (this.i13 + 28));
                    this.i13 = li8(this.i13 + 20);
                    this.i13 = (this.i13 & 0x03);
                    si8(this.i13, (this.i5 + 5));
                    si8(this.i9, (this.i5 + 4));
                    this.i9 = 0;
                    si32(this.i9, (this.i5 + 8));
                    this.i13 = -1;
                    si8(this.i13, (this.i5 + 6));
                    si32(this.i9, (this.i5 + 12));
                    si32(this.i9, (this.i5 + 28));
                    si8(this.i9, (this.i5 + 7));
                    this.i9 = _dummynode_;
                    si32(this.i9, (this.i5 + 16));
                    this.i9 = (this.i5 + 28);
                    this.i13 = (this.i5 + 12);
                    this.i15 = (this.i17 + 1);
                    if (uint(this.i15) > uint(357913941)) goto _label_19;
                    this.i15 = 0;
                    this.i16 = li32(this.i16);
                    this.i18 = li32(this.i16 + 12);
                    this.i19 = li32(this.i16 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i20 = (this.i17 * 12);
                    si32(this.i19, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    si32(this.i20, (public::mstate.esp + 12));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i18]());
                    return;
                case 17:
                    this.i15 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i15 == 0)) goto _label_18;
                    if (this.i20 == 0) goto _label_18;
                    this.i18 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_18: 
                    this.i18 = li32(this.i16 + 68);
                    this.i18 = (this.i20 + this.i18);
                    si32(this.i18, (this.i16 + 68));
                    si32(this.i15, this.i13);
                    this.i15 = li32(this.i9);
                    if (this.i15 >= this.i17) goto _label_21;
                    goto _label_20;
                    
                _label_19: 
                    this.i15 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i15 = 0;
                    si32(this.i15, this.i13);
                    this.i15 = li32(this.i9);
                    if (!(this.i15 >= this.i17))
                    {
                        
                    _label_20: 
                        this.i16 = (this.i15 * 12);
                        this.i16 = (this.i16 + 8);
                        do 
                        {
                            this.i18 = 0;
                            this.i19 = li32(this.i13);
                            this.i19 = (this.i19 + this.i16);
                            si32(this.i18, this.i19);
                            this.i16 = (this.i16 + 12);
                            this.i15 = (this.i15 + 1);
                        } while (!(this.i15 >= this.i17));
                    };
                    
                _label_21: 
                    this.i13 = 1;
                    si32(this.i17, this.i9);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_setnodevector.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i17 > 0) goto _label_14;
                    goto _label_24;
                    
                _label_22: 
                    this.i16 = 3;
                    this.f0 = Number(this.i19);
                    sf64(this.f0, this.i9);
                    si32(this.i16, this.i15);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i19 = (public::mstate.ebp + -16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i19, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 21:
                    this.i19 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_23: 
                    this.i16 = this.i19;
                    this.i18 = (this.i18 + this.i13);
                    this.f0 = lf64(this.i18);
                    sf64(this.f0, this.i16);
                    this.i18 = li32(this.i18 + 8);
                    si32(this.i18, (this.i16 + 8));
                    this.i13 = (this.i13 + 12);
                    this.i14 = (this.i14 + 1);
                    if (this.i14 < this.i17) goto _label_46;
                    
                _label_24: 
                    this.i9 = __2E_str515;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 22:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_setstr.start();
                    return;
                case 23:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.f0 = Number(this.i17);
                    sf64(this.f0, this.i9);
                    this.i13 = 3;
                    si32(this.i13, (this.i9 + 8));
                    this.i9 = li32(this.i11);
                    if (!(this.i12 > 0))
                    {
                        this.i8 = this.i5;
                        this.i5 = this.i9;
                    }
                    else
                    {
                        this.i13 = this.i9;
                        this.i14 = this.i5;
                        this.i5 = this.i9;
                        goto _label_26;
                        
                    _label_25: 
                        if (!(this.i12 > 0))
                        {
                            this.i8 = 0;
                        }
                        else
                        {
                            this.i14 = 0;
                            this.i13 = this.i5;
                            
                        _label_26: 
                            this.i9 = this.i13;
                            this.i13 = this.i14;
                            this.i14 = 0;
                            this.i8 = (this.i8 * -12);
                            this.i8 = (this.i9 + this.i8);
                            this.i9 = this.i14;
                            
                        _label_27: 
                            this.i14 = 0;
                            this.i15 = li32(this.i11);
                            this.i16 = (this.i15 + 12);
                            si32(this.i16, this.i11);
                            this.f0 = lf64(this.i8);
                            sf64(this.f0, this.i15);
                            this.i16 = li32(this.i8 + 8);
                            si32(this.i16, (this.i15 + 8));
                            si32(this.i14, (this.i8 + 8));
                            this.i8 = (this.i8 + 12);
                            this.i9 = (this.i9 + 1);
                            if (this.i9 < this.i12) goto _label_47;
                            this.i8 = this.i13;
                        };
                    };
                    if (!(this.i8 == 0))
                    {
                        this.i9 = 5;
                        this.i12 = li32(this.i11);
                        this.i13 = (this.i12 + 12);
                        si32(this.i13, this.i11);
                        si32(this.i8, this.i12);
                        si32(this.i9, (this.i12 + 8));
                    };
                    this.i3 = li32(this.i3);
                    this.i3 = (this.i3 + this.i1);
                    this.i1 = this.i5;
                    this.i5 = this.i3;
                    
                _label_28: 
                    this.i3 = this.i1;
                    this.i8 = this.i5;
                    this.i1 = li32(this.i7);
                    this.i5 = li32(this.i0 + 36);
                    if (!(this.i1 == this.i5))
                    {
                        this.i5 = this.i3;
                        this.i3 = this.i8;
                        goto _label_8;
                    };
                    this.i1 = this.i3;
                    this.i5 = this.i8;
                    
                _label_29: 
                    this.i3 = this.i5;
                    this.i5 = li32(this.i0 + 48);
                    this.i8 = (this.i0 + 48);
                    if (this.i5 < 20001) goto _label_31;
                    this.i1 = 5;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    
                _label_30: 
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_31: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i5 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocCI.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i8);
                    if (this.i5 < 20001) goto _label_32;
                    this.i5 = __2E_str313;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_32: 
                    this.i5 = li32(this.i7);
                    this.i5 = (this.i5 + 24);
                    this.i8 = this.i5;
                    
                _label_33: 
                    this.i9 = 0;
                    si32(this.i8, this.i7);
                    si32(this.i3, (this.i5 + 4));
                    si32(this.i1, this.i5);
                    si32(this.i1, (this.i0 + 12));
                    this.i3 = li8(this.i10);
                    this.i3 = (this.i3 * 12);
                    this.i1 = (this.i1 + this.i3);
                    si32(this.i1, (this.i5 + 8));
                    this.i1 = li32(this.i4 + 12);
                    si32(this.i1, this.i6);
                    si32(this.i9, (this.i5 + 20));
                    si32(this.i2, (this.i5 + 16));
                    this.i1 = li32(this.i11);
                    this.i2 = li32(this.i5 + 8);
                    this.i3 = (this.i5 + 8);
                    if (!(uint(this.i2) > uint(this.i1)))
                    {
                        this.i1 = this.i2;
                        goto _label_35;
                    };
                    
                _label_34: 
                    this.i2 = 0;
                    si32(this.i2, (this.i1 + 8));
                    this.i2 = li32(this.i3);
                    this.i1 = (this.i1 + 12);
                    if (uint(this.i2) > uint(this.i1)) goto _label_34;
                    this.i1 = this.i2;
                    
                _label_35: 
                    si32(this.i1, this.i11);
                    this.i1 = li8(this.i0 + 56);
                    this.i1 = (this.i1 & 0x01);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i0 = 0;
                        
                    _label_36: 
                        public::mstate.eax = this.i0;
                        goto _label_45;
                    };
                    this.i1 = -1;
                    this.i2 = li32(this.i6);
                    this.i2 = (this.i2 + 4);
                    si32(this.i2, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_callhook.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -4);
                    si32(this.i0, this.i6);
                    goto _label_44;
                    
                _label_37: 
                    this.i4 = li32(this.i0 + 28);
                    this.i5 = li32(this.i0 + 8);
                    this.i6 = (this.i0 + 8);
                    this.i4 = (this.i4 - this.i5);
                    if (this.i4 > 240) goto _label_39;
                    this.i4 = li32(this.i0 + 44);
                    if (this.i4 < 20) goto _label_38;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = (this.i4 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_39;
                    
                _label_38: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = (this.i4 + 20);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_39: 
                    this.i4 = li32(this.i7);
                    this.i5 = li32(this.i0 + 36);
                    if (!(this.i4 == this.i5)) goto _label_41;
                    this.i4 = li32(this.i0 + 48);
                    this.i5 = (this.i0 + 48);
                    if (!(this.i4 < 20001))
                    {
                        this.i4 = 5;
                        public::mstate.esp = (public::mstate.esp - 8);
                        si32(this.i0, public::mstate.esp);
                        si32(this.i4, (public::mstate.esp + 4));
                        goto _label_30;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = (this.i4 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocCI.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i5);
                    if (this.i4 < 20001) goto _label_40;
                    this.i4 = __2E_str313;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_40: 
                    this.i4 = li32(this.i7);
                    this.i4 = (this.i4 + 24);
                    this.i5 = this.i4;
                    goto _label_42;
                    
                _label_41: 
                    this.i4 = (this.i4 + 24);
                    this.i5 = this.i4;
                    
                _label_42: 
                    si32(this.i5, this.i7);
                    this.i3 = li32(this.i3);
                    this.i1 = (this.i3 + this.i1);
                    si32(this.i1, (this.i4 + 4));
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    si32(this.i1, (this.i0 + 12));
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + 240);
                    si32(this.i1, (this.i4 + 8));
                    si32(this.i2, (this.i4 + 16));
                    this.i1 = li8(this.i0 + 56);
                    this.i1 = (this.i1 & 0x01);
                    if (this.i1 == 0) goto _label_43;
                    this.i1 = -1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_callhook.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_43: 
                    this.i1 = li32(this.i7);
                    this.i1 = li32(this.i1 + 4);
                    this.i1 = li32(this.i1);
                    this.i1 = li32(this.i1 + 16);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i1]());
                    return;
                case 33:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i1 > -1))
                    {
                        this.i0 = 2;
                        goto _label_36;
                    };
                    this.i2 = 1;
                    this.i1 = (0 - this.i1);
                    this.i3 = li32(this.i6);
                    this.i1 = (this.i1 * 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i3 + this.i1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_poscall.start();
                    return;
                case 34:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_44: 
                    public::mstate.eax = this.i2;
                    
                _label_45: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_46: 
                    goto _label_15;
                    
                _label_47: 
                    goto _label_27;
                default:
                    throw ("Invalid state in _luaD_precall");
            };
        }


    }
}

