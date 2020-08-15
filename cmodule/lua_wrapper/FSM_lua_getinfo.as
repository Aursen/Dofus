package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_getinfo extends Machine 
    {

        public static const intRegCount:int = 31;
        public static const NumberRegCount:int = 1;

        public var i21:int;
        public var i30:int;
        public var f0:Number;
        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
        public var i17:int;
        public var i19:int;
        public var i16:int;
        public var i18:int;
        public var i0:int;
        public var i1:int;
        public var i22:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i2:int;
        public var i23:int;
        public var i24:int;
        public var i25:int;
        public var i26:int;
        public var i27:int;
        public var i20:int;
        public var i9:int;
        public var i28:int;
        public var i29:int;


        public static function start():void
        {
            var _local_1:FSM_lua_getinfo;
            _local_1 = new (FSM_lua_getinfo)();
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
                    this.i3 = li8(this.i1);
                    if (!(!(this.i3 == 62)))
                    {
                        this.i3 = li32(this.i0 + 8);
                        this.i4 = li32(this.i3 + -12);
                        this.i3 = (this.i3 + -12);
                        si32(this.i3, (this.i0 + 8));
                        this.i1 = (this.i1 + 1);
                        if (this.i4 == 0) goto _label_3;
                        this.i3 = 0;
                        this.i5 = this.i1;
                    }
                    else
                    {
                        this.i3 = li32(this.i2 + 96);
                        if (!(!(this.i3 == 0)))
                        {
                            this.i3 = 0;
                            this.i4 = this.i3;
                        }
                        else
                        {
                            this.i4 = li32(this.i0 + 40);
                            this.i3 = (this.i3 * 24);
                            this.i3 = (this.i4 + this.i3);
                            this.i4 = li32(this.i3 + 4);
                            this.i4 = li32(this.i4);
                        };
                        if (this.i4 == 0) goto _label_34;
                        this.i5 = this.i1;
                    };
                    this.i6 = 1;
                    this.i7 = (this.i3 + -20);
                    this.i8 = (this.i3 + -12);
                    this.i9 = (this.i0 + 24);
                    this.i10 = (this.i0 + 20);
                    this.i11 = (this.i2 + 8);
                    this.i12 = (this.i3 + -24);
                    this.i13 = (this.i3 + 20);
                    this.i14 = (this.i3 + 4);
                    this.i15 = (this.i2 + 4);
                    this.i16 = (this.i2 + 24);
                    this.i17 = (this.i4 + 7);
                    this.i18 = (this.i2 + 20);
                    this.i19 = (this.i4 + 16);
                    this.i20 = (this.i2 + 12);
                    this.i21 = (this.i2 + 32);
                    this.i22 = (this.i2 + 28);
                    this.i23 = (this.i2 + 36);
                    this.i2 = (this.i2 + 16);
                    this.i24 = (this.i4 + 6);
                    this.i25 = this.i5;
                    
                _label_1: 
                    this.i26 = li8(this.i1);
                    if (this.i26 == 0) goto _label_19;
                    
                _label_2: 
                    this.i26 = sxi8(li8(this.i1));
                    if (this.i26 > 107) goto _label_6;
                    if (this.i26 == 76) goto _label_8;
                    if (this.i26 == 83) goto _label_9;
                    if (this.i26 == 102) goto _label_8;
                    goto _label_7;
                    
                _label_3: 
                    this.i3 = this.i4;
                    
                _label_4: 
                    this.i4 = __2E_str45;
                    si32(this.i4, (this.i2 + 8));
                    si32(this.i4, (this.i2 + 4));
                    this.i4 = __2E_str9266;
                    si32(this.i4, (this.i2 + 12));
                    this.i4 = -1;
                    si32(this.i4, (this.i2 + 20));
                    si32(this.i4, (this.i2 + 28));
                    si32(this.i4, (this.i2 + 32));
                    this.i4 = __2E_str10267;
                    si32(this.i4, (this.i2 + 16));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 60;
                    this.i6 = (this.i2 + 36);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = 0;
                    si32(this.i4, (this.i2 + 24));
                    this.i2 = li8(this.i1);
                    this.i4 = this.i1;
                    if (this.i2 == 102) goto _label_35;
                    this.i2 = this.i4;
                    do 
                    {
                        this.i4 = li8(this.i2);
                        if (!(!(this.i4 == 0)))
                        {
                            this.i2 = 0;
                            goto _label_36;
                        };
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if (this.i4 == 102) goto _label_36;
                        this.i2 = this.i5;
                    } while (true);
                    
                _label_5: 
                    this.i2 = 1;
                    goto _label_25;
                    
                _label_6: 
                    if (this.i26 == 108) goto _label_11;
                    if (this.i26 == 110) goto _label_14;
                    if (this.i26 == 117) goto _label_13;
                    
                _label_7: 
                    this.i6 = 0;
                    
                _label_8: 
                    this.i1 = (this.i1 + 1);
                    goto _label_1;
                    
                _label_9: 
                    this.i26 = li8(this.i24);
                    if (this.i26 == 0) goto _label_10;
                    this.i26 = __2E_str11268;
                    si32(this.i26, this.i2);
                    this.i27 = -1;
                    si32(this.i27, this.i22);
                    si32(this.i27, this.i21);
                    this.i27 = __2E_str3149;
                    si32(this.i27, this.i20);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i27 = 60;
                    si32(this.i23, public::mstate.esp);
                    si32(this.i26, (public::mstate.esp + 4));
                    si32(this.i27, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i26 = li8(this.i1 + 1);
                    this.i1 = (this.i1 + 1);
                    if (this.i26 == 0) goto _label_19;
                    goto _label_2;
                    
                _label_10: 
                    this.i26 = __2E_str13270;
                    this.i27 = li32(this.i19);
                    this.i27 = li32(this.i27 + 32);
                    this.i27 = (this.i27 + 16);
                    si32(this.i27, this.i2);
                    this.i28 = li32(this.i19);
                    this.i28 = li32(this.i28 + 60);
                    si32(this.i28, this.i22);
                    this.i29 = li32(this.i19);
                    this.i29 = li32(this.i29 + 64);
                    this.i30 = __2E_str14271;
                    si32(this.i29, this.i21);
                    this.i26 = ((this.i28 == 0) ? this.i26 : this.i30);
                    si32(this.i26, this.i20);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i26 = 60;
                    si32(this.i23, public::mstate.esp);
                    si32(this.i27, (public::mstate.esp + 4));
                    si32(this.i26, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i26 = li8(this.i1 + 1);
                    this.i1 = (this.i1 + 1);
                    if (this.i26 == 0) goto _label_19;
                    goto _label_2;
                    
                _label_11: 
                    if (this.i3 == 0) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_currentline.start();
                case 4:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i26, this.i18);
                    this.i26 = li8(this.i1 + 1);
                    this.i1 = (this.i1 + 1);
                    if (this.i26 == 0) goto _label_19;
                    goto _label_2;
                    
                _label_12: 
                    this.i26 = -1;
                    si32(this.i26, this.i18);
                    this.i26 = li8(this.i1 + 1);
                    this.i1 = (this.i1 + 1);
                    if (this.i26 == 0) goto _label_19;
                    goto _label_2;
                    
                _label_13: 
                    this.i26 = li8(this.i17);
                    si32(this.i26, this.i16);
                    this.i26 = li8(this.i1 + 1);
                    this.i1 = (this.i1 + 1);
                    if (this.i26 == 0) goto _label_19;
                    goto _label_2;
                    
                _label_14: 
                    if (!(!(this.i3 == 0)))
                    {
                        
                    _label_15: 
                        this.i26 = 0;
                        goto _label_18;
                    };
                    this.i26 = li32(this.i14);
                    this.i27 = li32(this.i26 + 8);
                    if (!(!(this.i27 == 6)))
                    {
                        this.i26 = li32(this.i26);
                        this.i26 = li8(this.i26 + 6);
                        if (!(!(this.i26 == 0)))
                        {
                            this.i26 = li32(this.i13);
                            if (this.i26 > 0) goto _label_15;
                        };
                    };
                    this.i26 = li32(this.i7);
                    this.i27 = li32(this.i26 + 8);
                    if (!(this.i27 == 6)) goto _label_15;
                    this.i28 = li32(this.i26);
                    this.i29 = li8(this.i28 + 6);
                    if (!(this.i29 == 0)) goto _label_15;
                    this.i28 = li32(this.i28 + 16);
                    this.i28 = li32(this.i28 + 12);
                    if (!(!(this.i27 == 6)))
                    {
                        this.i27 = (this.i29 & 0xFF);
                        if (this.i27 == 0) goto _label_16;
                    };
                    this.i26 = -1;
                    goto _label_17;
                    
                _label_16: 
                    this.i27 = li32(this.i10);
                    if (!(!(this.i27 == this.i12)))
                    {
                        this.i27 = li32(this.i9);
                        si32(this.i27, this.i8);
                    };
                    this.i26 = li32(this.i26);
                    this.i26 = li32(this.i26 + 16);
                    this.i27 = li32(this.i8);
                    this.i26 = li32(this.i26 + 12);
                    this.i26 = (this.i27 - this.i26);
                    this.i26 = (this.i26 >> 2);
                    this.i26 = (this.i26 + -1);
                    
                _label_17: 
                    this.i26 = (this.i26 << 2);
                    this.i26 = (this.i28 + this.i26);
                    this.i26 = li32(this.i26);
                    this.i27 = (this.i26 & 0x3F);
                    this.i28 = (this.i27 + -28);
                    if (!(uint(this.i28) < uint(2)))
                    {
                        if (!(this.i27 == 33)) goto _label_15;
                    };
                    this.i26 = (this.i26 >>> 6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i26 = (this.i26 & 0xFF);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i26, (public::mstate.esp + 8));
                    si32(this.i15, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getobjname.start();
                case 5:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_18: 
                    si32(this.i26, this.i11);
                    if (!(this.i26 == 0)) goto _label_8;
                    this.i26 = __2E_str45;
                    si32(this.i26, this.i11);
                    this.i26 = 0;
                    si32(this.i26, this.i15);
                    this.i26 = li8(this.i1 + 1);
                    this.i1 = (this.i1 + 1);
                    if (!(this.i26 == 0)) goto _label_2;
                    
                _label_19: 
                    this.i1 = li8(this.i5);
                    if (this.i1 == 102) goto _label_37;
                    this.i1 = this.i25;
                    do 
                    {
                        this.i2 = li8(this.i1);
                        if (!(!(this.i2 == 0)))
                        {
                            this.i1 = 0;
                            goto _label_38;
                        };
                        this.i2 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i3 = this.i1;
                        if (this.i2 == 102) goto _label_38;
                        this.i1 = this.i3;
                    } while (true);
                    
                _label_20: 
                    this.i3 = this.i4;
                    this.i1 = this.i5;
                    this.i2 = this.i6;
                    goto _label_25;
                    
                _label_21: 
                    this.i6 = 6;
                    si32(this.i3, this.i4);
                    si32(this.i6, (this.i4 + 8));
                    
                _label_22: 
                    this.i4 = li32(this.i0 + 28);
                    this.i6 = li32(this.i5);
                    this.i4 = (this.i4 - this.i6);
                    if (this.i4 > 12) goto _label_24;
                    this.i4 = li32(this.i0 + 44);
                    if (this.i4 < 1) goto _label_23;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = (this.i4 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_24;
                    
                _label_23: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = (this.i4 + 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_24: 
                    this.i4 = li32(this.i5);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i5);
                    
                _label_25: 
                    this.i4 = li8(this.i1);
                    this.i5 = this.i1;
                    //unresolved if
                    this.i1 = this.i5;
                    do 
                    {
                        this.i4 = li8(this.i1);
                        if (!(!(this.i4 == 0)))
                        {
                            this.i1 = 0;
                            //unresolved jump
                        };
                        this.i4 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i5 = this.i1;
                        //unresolved if
                        this.i1 = this.i5;
                    } while (true);
                    
                _label_26: 
                    this.i1 = 32;
                    this.i4 = li32(this.i0 + 16);
                    this.i5 = li32(this.i4 + 12);
                    this.i6 = li32(this.i4 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = 0;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 8:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i5 = (this.i0 + 16);
                    if (!(this.i1 == 0)) goto _label_27;
                    this.i6 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_27: 
                    this.i6 = 5;
                    this.i7 = li32(this.i4 + 68);
                    this.i7 = (this.i7 + 32);
                    si32(this.i7, (this.i4 + 68));
                    this.i4 = li32(this.i5);
                    this.i7 = li32(this.i4 + 28);
                    si32(this.i7, this.i1);
                    si32(this.i1, (this.i4 + 28));
                    this.i4 = li8(this.i4 + 20);
                    this.i4 = (this.i4 & 0x03);
                    si8(this.i4, (this.i1 + 5));
                    si8(this.i6, (this.i1 + 4));
                    this.i4 = 0;
                    si32(this.i4, (this.i1 + 8));
                    this.i6 = -1;
                    si8(this.i6, (this.i1 + 6));
                    si32(this.i4, (this.i1 + 12));
                    si32(this.i4, (this.i1 + 28));
                    si8(this.i4, (this.i1 + 7));
                    this.i6 = _dummynode_;
                    si32(this.i6, (this.i1 + 16));
                    this.i5 = li32(this.i5);
                    this.i6 = li32(this.i5 + 12);
                    this.i5 = li32(this.i5 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 10:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i4, (this.i1 + 12));
                    this.i4 = li32(this.i1 + 28);
                    this.i5 = (this.i1 + 28);
                    this.i6 = (this.i1 + 12);
                    this.i7 = this.i1;
                    if (!(this.i4 > -1))
                    {
                        this.i8 = (this.i4 * 12);
                        this.i8 = (this.i8 + 8);
                        do 
                        {
                            this.i9 = 0;
                            this.i10 = li32(this.i6);
                            this.i10 = (this.i10 + this.i8);
                            si32(this.i9, this.i10);
                            this.i8 = (this.i8 + 12);
                            this.i4 = (this.i4 + 1);
                        } while (!(this.i4 > -1));
                    };
                    this.i4 = 0;
                    si32(this.i4, this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_setnodevector.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i3 + 16);
                    this.i5 = li32(this.i4 + 20);
                    this.i4 = li32(this.i4 + 48);
                    this.i3 = (this.i3 + 16);
                    if (this.i4 < 1) goto _label_30;
                    this.i4 = (public::mstate.ebp + -16);
                    this.i6 = 0;
                    this.i8 = (this.i4 + 8);
                    
                _label_28: 
                    this.i9 = _luaO_nilobject_;
                    this.i10 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 12:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i11 == this.i9))
                    {
                        this.i10 = this.i11;
                        goto _label_29;
                    };
                    this.i9 = 3;
                    this.f0 = Number(this.i10);
                    sf64(this.f0, this.i4);
                    si32(this.i9, this.i8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = (public::mstate.ebp + -16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 13:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_29: 
                    this.i9 = this.i10;
                    this.i10 = 1;
                    si32(this.i10, this.i9);
                    si32(this.i10, (this.i9 + 8));
                    this.i9 = li32(this.i3);
                    this.i9 = li32(this.i9 + 48);
                    this.i5 = (this.i5 + 4);
                    this.i6 = (this.i6 + 1);
                    if (!(this.i9 <= this.i6)) goto _label_28;
                    
                _label_30: 
                    this.i1 = 5;
                    this.i3 = li32(this.i0 + 8);
                    si32(this.i7, this.i3);
                    si32(this.i1, (this.i3 + 8));
                    
                _label_31: 
                    this.i1 = li32(this.i0 + 28);
                    this.i3 = li32(this.i0 + 8);
                    this.i4 = (this.i0 + 8);
                    this.i1 = (this.i1 - this.i3);
                    if (this.i1 > 12) goto _label_33;
                    this.i1 = li32(this.i0 + 44);
                    if (this.i1 < 1) goto _label_32;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_33;
                    
                _label_32: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 + 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_33: 
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i4);
                    do 
                    {
                        public::mstate.eax = this.i2;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_34: 
                        this.i3 = this.i4;
                        goto _label_4;
                        
                    _label_35: 
                        this.i2 = this.i1;
                        
                    _label_36: 
                        if (this.i2 == 0) goto _label_5;
                        this.i2 = 1;
                        do 
                        {
                            this.i4 = li32(this.i0 + 8);
                            this.i5 = (this.i0 + 8);
                            if (!(this.i3 == 0)) goto _label_21;
                            this.i6 = 0;
                            si32(this.i6, (this.i4 + 8));
                            goto _label_22;
                            
                        _label_37: 
                            this.i1 = this.i5;
                            
                        _label_38: 
                            if (this.i1 == 0) goto _label_20;
                            this.i3 = this.i4;
                            this.i1 = this.i5;
                            this.i2 = this.i6;
                        } while (true);
                    } while ((this.i1 == 0));
                    if (!(this.i3 == 0))
                    {
                        this.i1 = li8(this.i3 + 6);
                        if (this.i1 == 0) goto _label_26;
                    };
                    this.i3 = 0;
                    this.i1 = li32(this.i0 + 8);
                    si32(this.i3, (this.i1 + 8));
                    goto _label_31;
                default:
                    throw ("Invalid state in _lua_getinfo");
            };
        }


    }
}

