package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaV_execute extends Machine 
    {

        public static const intRegCount:int = 32;
        public static const NumberRegCount:int = 5;

        public var i21:int;
        public var i30:int;
        public var i31:int;
        public var f0:Number;
        public var f1:Number;
        public var f3:Number;
        public var f2:Number;
        public var f4:Number;
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
            var _local_1:FSM_luaV_execute;
            _local_1 = new (FSM_luaV_execute)();
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
                    public::mstate.esp = (public::mstate.esp - 172);
                    this.i0 = (public::mstate.ebp + -16);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = (public::mstate.ebp + -80);
                    si32(this.i2, (public::mstate.ebp + -99));
                    this.i2 = (public::mstate.ebp + -64);
                    si32(this.i2, (public::mstate.ebp + -117));
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = (this.i1 + 44);
                    si32(this.i3, (public::mstate.ebp + -108));
                    this.i3 = (this.i0 + 8);
                    this.i4 = (this.i1 + 32);
                    si32(this.i4, (public::mstate.ebp + -171));
                    this.i4 = (this.i1 + 96);
                    this.i5 = (this.i1 + 28);
                    this.i6 = (this.i1 + 8);
                    this.i7 = (this.i1 + 16);
                    this.i8 = li32(public::mstate.ebp + -99);
                    this.i8 = (this.i8 + 8);
                    si32(this.i8, (public::mstate.ebp + -126));
                    this.i8 = li32(public::mstate.ebp + -117);
                    this.i8 = (this.i8 + 8);
                    si32(this.i8, (public::mstate.ebp + -135));
                    this.i8 = (this.i1 + 6);
                    si32(this.i8, (public::mstate.ebp + -144));
                    this.i8 = (this.i1 + 60);
                    si32(this.i8, (public::mstate.ebp + -153));
                    this.i8 = (this.i1 + 64);
                    this.i9 = (this.i1 + 56);
                    si32(this.i9, (public::mstate.ebp + -162));
                    this.i9 = (this.i1 + 12);
                    this.i10 = (this.i1 + 20);
                    this.i11 = (this.i1 + 24);
                    
                _label_1: 
                    si32(this.i2, (public::mstate.ebp + -90));
                    
                _label_2: 
                    this.i2 = li32(this.i10);
                    this.i2 = li32(this.i2 + 4);
                    this.i2 = li32(this.i2);
                    this.i12 = li32(this.i2 + 16);
                    this.i13 = li32(this.i11);
                    this.i14 = li32(this.i9);
                    this.i12 = li32(this.i12 + 8);
                    this.i15 = (this.i2 + 12);
                    this.i16 = (this.i2 + 16);
                    
                _label_3: 
                    this.i17 = li32(public::mstate.ebp + -162);
                    this.i17 = li8(this.i17);
                    this.i18 = li32(this.i13);
                    this.i19 = (this.i13 + 4);
                    this.i20 = this.i13;
                    this.i21 = (this.i17 & 0x0C);
                    if (!(!(this.i21 == 0)))
                    {
                        
                    _label_4: 
                        goto _label_8;
                    };
                    this.i21 = li32(this.i8);
                    this.i21 = (this.i21 + -1);
                    si32(this.i21, this.i8);
                    if (!(this.i21 == 0))
                    {
                        this.i22 = (this.i17 & 0x04);
                        if (this.i22 == 0) goto _label_4;
                    };
                    this.i14 = li32(this.i11);
                    si32(this.i19, this.i11);
                    this.i21 = ((this.i21 != 0) ? 1 : 0);
                    this.i22 = (this.i17 & 0x08);
                    if (this.i22 == 0) goto _label_5;
                    this.i21 = (this.i21 & 0x01);
                    if (!(this.i21 == 0)) goto _label_5;
                    this.i21 = -1;
                    this.i22 = li32(public::mstate.ebp + -153);
                    this.i22 = li32(this.i22);
                    si32(this.i22, this.i8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i22 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i22, (public::mstate.esp + 4));
                    si32(this.i21, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_callhook.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_5: 
                    this.i17 = (this.i17 & 0x04);
                    if (this.i17 == 0) goto _label_6;
                    this.i17 = li32(this.i10);
                    this.i17 = li32(this.i17 + 4);
                    this.i17 = li32(this.i17);
                    this.i17 = li32(this.i17 + 16);
                    this.i21 = li32(this.i17 + 12);
                    this.i17 = li32(this.i17 + 20);
                    this.i22 = (this.i19 - this.i21);
                    this.i22 = (this.i22 >> 2);
                    if (!(!(this.i17 == 0)))
                    {
                        this.i23 = 0;
                    }
                    else
                    {
                        this.i23 = (this.i22 << 2);
                        this.i23 = (this.i23 + this.i17);
                        this.i23 = li32(this.i23 + -4);
                    };
                    if (!(this.i22 == 1))
                    {
                        if (!(uint(this.i19) <= uint(this.i14)))
                        {
                            if (!(!(this.i17 == 0)))
                            {
                                this.i14 = 0;
                            }
                            else
                            {
                                this.i14 = (this.i14 - this.i21);
                                this.i14 = (this.i14 & 0xFFFFFFFC);
                                this.i14 = (this.i14 + this.i17);
                                this.i14 = li32(this.i14 + -4);
                            };
                            if (this.i14 == this.i23) goto _label_6;
                        };
                    };
                    this.i14 = 2;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i23, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_callhook.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_6: 
                    this.i14 = li32(public::mstate.ebp + -144);
                    this.i14 = li8(this.i14);
                    if (!(!(this.i14 == 1)))
                    {
                        si32(this.i13, this.i11);
                        
                    _label_7: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i14 = li32(this.i9);
                    
                _label_8: 
                    this.i17 = (this.i18 >>> 6);
                    this.i17 = (this.i17 & 0xFF);
                    this.i21 = (this.i17 * 12);
                    this.i22 = (this.i18 & 0x3F);
                    this.i21 = (this.i14 + this.i21);
                    this.i23 = this.i14;
                    if (this.i22 > 18) goto _label_11;
                    if (this.i22 > 8) goto _label_10;
                    if (!(this.i22 > 3))
                    {
                        if (!(this.i22 > 1))
                        {
                            if (this.i22 == 0) goto _label_21;
                            if (!(this.i22 == 1)) goto _label_20;
                            this.i13 = (this.i18 >>> 14);
                            this.i13 = (this.i13 * 12);
                            this.i17 = (this.i17 * 12);
                            this.i13 = (this.i12 + this.i13);
                            this.f0 = lf64(this.i13);
                            this.i17 = (this.i14 + this.i17);
                            sf64(this.f0, this.i17);
                            this.i13 = li32(this.i13 + 8);
                            si32(this.i13, (this.i17 + 8));
                            this.i13 = this.i19;
                            goto _label_3;
                        };
                        if (this.i22 == 2) goto _label_22;
                        if (!(this.i22 == 3)) goto _label_20;
                        this.i13 = 0;
                        this.i18 = (this.i18 >>> 23);
                        this.i20 = (this.i18 * 12);
                        this.i20 = (this.i14 + this.i20);
                        si32(this.i13, (this.i20 + 8));
                        this.i13 = (this.i18 + -1);
                        if (this.i13 < this.i17) goto _label_20;
                        this.i20 = 0;
                        this.i18 = (this.i18 * 12);
                        this.i18 = (this.i23 + this.i18);
                        this.i18 = (this.i18 + -4);
                        do 
                        {
                            this.i21 = 0;
                            si32(this.i21, this.i18);
                            this.i18 = (this.i18 + -12);
                            this.i21 = (this.i20 + 1);
                            this.i20 = (this.i20 ^ 0xFFFFFFFF);
                            this.i20 = (this.i13 + this.i20);
                            if (this.i20 < this.i17) goto _label_20;
                            this.i20 = this.i21;
                        } while (true);
                    };
                    if (this.i22 > 5) goto _label_9;
                    if (this.i22 == 4) goto _label_23;
                    if (!(this.i22 == 5)) goto _label_20;
                    this.i13 = 5;
                    this.i14 = li32(this.i15);
                    this.i17 = li32(public::mstate.ebp + -117);
                    si32(this.i14, this.i17);
                    this.i14 = (this.i18 >>> 14);
                    this.i17 = li32(public::mstate.ebp + -135);
                    si32(this.i13, this.i17);
                    si32(this.i19, this.i11);
                    this.i13 = (this.i14 * 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i14 = (public::mstate.ebp + -64);
                    this.i13 = (this.i12 + this.i13);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i21, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_9: 
                    if (this.i22 == 6) goto _label_24;
                    if (this.i22 == 7) goto _label_26;
                    if (!(this.i22 == 8)) goto _label_20;
                    this.i13 = (this.i18 & 0xFF800000);
                    this.i13 = (this.i13 >>> 21);
                    this.i13 = (this.i2 + this.i13);
                    this.i17 = (this.i17 * 12);
                    this.i13 = li32(this.i13 + 20);
                    this.i17 = (this.i14 + this.i17);
                    this.i18 = li32(this.i13 + 8);
                    this.f0 = lf64(this.i17);
                    sf64(this.f0, this.i18);
                    this.i20 = li32(this.i17 + 8);
                    si32(this.i20, (this.i18 + 8));
                    this.i17 = li32(this.i17 + 8);
                    if (this.i17 < 4) goto _label_20;
                    this.i17 = li32(this.i21);
                    this.i18 = li8(this.i17 + 5);
                    this.i18 = (this.i18 & 0x03);
                    if (this.i18 == 0) goto _label_20;
                    this.i18 = li8(this.i13 + 5);
                    this.i13 = (this.i13 + 5);
                    this.i20 = (this.i18 & 0x04);
                    if (this.i20 == 0) goto _label_20;
                    this.i20 = li32(this.i7);
                    this.i21 = li8(this.i20 + 21);
                    if (!(this.i21 == 1)) goto _label_27;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i20, public::mstate.esp);
                    si32(this.i17, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_10: 
                    if (!(this.i22 > 13))
                    {
                        if (!(this.i22 > 10))
                        {
                            if (this.i22 == 9) goto _label_28;
                            if (!(this.i22 == 10)) goto _label_20;
                            this.i13 = (this.i18 >>> 14);
                            this.i13 = (this.i13 & 0x01FF);
                            this.i20 = (this.i13 >>> 3);
                            this.i20 = (this.i20 & 0x1F);
                            this.i23 = (this.i18 >>> 23);
                            if (!(this.i20 == 0)) goto _label_30;
                            goto _label_31;
                        };
                        if (this.i22 == 11) goto _label_33;
                        if (this.i22 == 12) goto _label_35;
                        if (!(this.i22 == 13)) goto _label_20;
                        this.i13 = (this.i18 >>> 14);
                        this.i20 = (this.i18 & 0x400000);
                        this.i23 = (this.i18 >>> 23);
                        this.i18 = (this.i18 >>> 31);
                        if (this.i18 == 0) goto _label_37;
                        this.i23 = (this.i23 & 0xFF);
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i12 + this.i23);
                        if (this.i20 == 0) goto _label_39;
                        goto _label_38;
                    };
                    if (!(this.i22 > 15))
                    {
                        if (this.i22 == 14) goto _label_40;
                        if (!(this.i22 == 15)) goto _label_20;
                        this.i13 = (this.i18 >>> 14);
                        this.i20 = (this.i18 & 0x400000);
                        this.i23 = (this.i18 >>> 23);
                        this.i18 = (this.i18 >>> 31);
                        if (this.i18 == 0) goto _label_42;
                        this.i23 = (this.i23 & 0xFF);
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i12 + this.i23);
                        if (this.i20 == 0) goto _label_44;
                        goto _label_43;
                    };
                    if (this.i22 == 16) goto _label_45;
                    if (this.i22 == 17) goto _label_47;
                    if (!(this.i22 == 18)) goto _label_20;
                    this.i13 = (this.i18 >>> 23);
                    this.i18 = (this.i13 * 12);
                    this.i18 = (this.i14 + this.i18);
                    this.i20 = li32(this.i18 + 8);
                    if (!(this.i20 == 3)) goto _label_49;
                    this.i18 = 3;
                    this.i13 = (this.i13 * 12);
                    this.i13 = (this.i14 + this.i13);
                    this.f0 = lf64(this.i13);
                    this.i13 = (this.i17 * 12);
                    this.i13 = (this.i14 + this.i13);
                    this.f0 = -(this.f0);
                    sf64(this.f0, this.i13);
                    si32(this.i18, (this.i13 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_11: 
                    if (this.i22 > 27) goto _label_15;
                    if (this.i22 > 22) goto _label_13;
                    if (this.i22 > 20) goto _label_12;
                    if (this.i22 == 19) goto _label_50;
                    if (!(this.i22 == 20)) goto _label_20;
                    this.i13 = (this.i18 >>> 23);
                    this.i13 = (this.i13 * 12);
                    this.i13 = (this.i14 + this.i13);
                    this.i18 = li32(this.i13 + 8);
                    if (this.i18 == 4) goto _label_52;
                    if (!(this.i18 == 5)) goto _label_53;
                    this.i18 = 3;
                    this.i13 = li32(this.i13);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i13, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getn.start();
                case 5:
                    this.i13 = public::mstate.eax;
                    this.i17 = (this.i17 * 12);
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i17 = (this.i14 + this.i17);
                    this.f0 = Number(this.i13);
                    sf64(this.f0, this.i17);
                    si32(this.i18, (this.i17 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_12: 
                    if (this.i22 == 21) goto _label_56;
                    if (!(this.i22 == 22)) goto _label_20;
                    this.i17 = (this.i18 & 0xFFFFC000);
                    this.i17 = (this.i17 >>> 12);
                    this.i13 = (this.i17 + this.i13);
                    this.i13 = (this.i13 + -524280);
                    goto _label_3;
                    
                _label_13: 
                    if (!(this.i22 > 24))
                    {
                        if (this.i22 == 23) goto _label_58;
                        if (!(this.i22 == 24)) goto _label_20;
                        si32(this.i19, this.i11);
                        this.i20 = (this.i18 >>> 23);
                        this.i21 = (this.i18 >>> 31);
                        this.i23 = (this.i18 >>> 14);
                        this.i18 = (this.i18 & 0x400000);
                        if (this.i18 == 0) goto _label_70;
                        this.i23 = (this.i23 & 0xFF);
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i12 + this.i23);
                        this.i21 = (this.i21 & 0xFF);
                        if (this.i21 == 0) goto _label_73;
                        goto _label_71;
                    };
                    if (this.i22 == 25) goto _label_75;
                    if (this.i22 == 26) goto _label_86;
                    if (!(this.i22 == 27)) goto _label_20;
                    this.i20 = (this.i18 >>> 23);
                    this.i21 = (this.i20 * 12);
                    this.i21 = (this.i14 + this.i21);
                    this.i21 = li32(this.i21 + 8);
                    if (this.i21 == 1) goto _label_90;
                    if (!(this.i21 == 0)) goto _label_91;
                    
                _label_14: 
                    this.i23 = 1;
                    goto _label_92;
                    
                _label_15: 
                    if (this.i22 > 32) goto _label_19;
                    if (this.i22 > 29) goto _label_17;
                    if (this.i22 == 28) goto _label_93;
                    if (!(this.i22 == 29)) goto _label_20;
                    if (!(uint(this.i18) < uint(0x800000)))
                    {
                        this.i13 = (this.i18 >>> 23);
                        this.i13 = (this.i17 + this.i13);
                        this.i13 = (this.i13 * 12);
                        this.i13 = (this.i14 + this.i13);
                        si32(this.i13, this.i6);
                    };
                    this.i13 = -1;
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_precall.start();
                    return;
                case 6:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i13 == 1) goto _label_97;
                    if (!(this.i13 == 0)) goto _label_7;
                    this.i2 = li32(this.i10);
                    this.i13 = li32(this.i2 + -20);
                    this.i14 = li32(this.i2 + 4);
                    this.i12 = li32(this.i4);
                    this.i15 = (this.i2 + -20);
                    this.i16 = this.i14;
                    this.i17 = this.i13;
                    if (this.i12 == 0) goto _label_16;
                    this.i12 = li32(this.i2 + -24);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_close.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_16: 
                    this.i12 = li32(this.i2);
                    this.i12 = (this.i12 - this.i14);
                    this.i12 = (this.i12 / 12);
                    this.i15 = li32(this.i15);
                    this.i12 = (this.i12 * 12);
                    this.i12 = (this.i15 + this.i12);
                    si32(this.i12, (this.i2 + -24));
                    si32(this.i12, this.i9);
                    this.i12 = li32(this.i6);
                    if (uint(this.i16) < uint(this.i12)) goto _label_94;
                    this.i13 = 0;
                    goto _label_96;
                    
                _label_17: 
                    if (this.i22 == 30) goto _label_98;
                    if (this.i22 == 31) goto _label_100;
                    if (!(this.i22 == 32)) goto _label_20;
                    this.i20 = (this.i17 + 2);
                    this.i23 = (this.i17 + 1);
                    this.i22 = (this.i17 * 12);
                    this.i22 = (this.i14 + this.i22);
                    si32(this.i19, this.i11);
                    this.i19 = (this.i20 * 12);
                    this.i24 = (this.i23 * 12);
                    this.i25 = li32(this.i22 + 8);
                    this.i22 = (this.i22 + 8);
                    this.i19 = (this.i14 + this.i19);
                    this.i24 = (this.i14 + this.i24);
                    if (this.i25 == 3) goto _label_101;
                    if (!(this.i25 == 4)) goto _label_18;
                    this.i25 = (public::mstate.ebp + -24);
                    this.i26 = li32(this.i21);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i26 = (this.i26 + 16);
                    si32(this.i26, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_str2d.start();
                    return;
                case 8:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i25 == 0))
                    {
                        this.i25 = 3;
                        this.i26 = (this.i17 * 12);
                        this.f0 = lf64(public::mstate.ebp + -24);
                        this.i26 = (this.i14 + this.i26);
                        sf64(this.f0, this.i26);
                        si32(this.i25, this.i22);
                        if (!(this.i21 == 0)) goto _label_101;
                    };
                    
                _label_18: 
                    this.i20 = __2E_str7172;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_106;
                    
                _label_19: 
                    if (!(this.i22 > 34))
                    {
                        if (this.i22 == 33) goto _label_107;
                        if (!(this.i22 == 34)) goto _label_20;
                        this.i20 = (this.i18 >>> 14);
                        this.i20 = (this.i20 & 0x01FF);
                        this.i22 = (this.i18 >>> 23);
                        if (uint(this.i18) < uint(0x800000)) goto _label_108;
                        this.i18 = this.i22;
                        goto _label_109;
                    };
                    if (this.i22 == 35) goto _label_117;
                    if (this.i22 == 36) goto _label_118;
                    if (this.i22 == 37) goto _label_127;
                    do 
                    {
                        
                    _label_20: 
                        this.i13 = this.i19;
                        goto _label_3;
                        
                    _label_21: 
                        this.i13 = (this.i18 >>> 23);
                        this.i13 = (this.i13 * 12);
                        this.i17 = (this.i17 * 12);
                        this.i13 = (this.i14 + this.i13);
                        this.f0 = lf64(this.i13);
                        this.i17 = (this.i14 + this.i17);
                        sf64(this.f0, this.i17);
                        this.i13 = li32(this.i13 + 8);
                        si32(this.i13, (this.i17 + 8));
                        this.i13 = this.i19;
                        goto _label_3;
                        
                    _label_22: 
                        this.i20 = 1;
                        this.i17 = (this.i17 * 12);
                        this.i23 = (this.i18 >>> 23);
                        si32(this.i23, this.i21);
                        this.i17 = (this.i14 + this.i17);
                        si32(this.i20, (this.i17 + 8));
                        this.i17 = (this.i18 & 0x7FC000);
                    } while ((this.i17 == 0));
                    this.i13 = (this.i13 + 8);
                    goto _label_3;
                    
                _label_23: 
                    this.i13 = (this.i18 & 0xFF800000);
                    this.i13 = (this.i13 >>> 21);
                    this.i13 = (this.i2 + this.i13);
                    this.i13 = li32(this.i13 + 20);
                    this.i13 = li32(this.i13 + 8);
                    this.f0 = lf64(this.i13);
                    this.i17 = (this.i17 * 12);
                    this.i17 = (this.i14 + this.i17);
                    sf64(this.f0, this.i17);
                    this.i13 = li32(this.i13 + 8);
                    si32(this.i13, (this.i17 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_24: 
                    this.i13 = (this.i18 >>> 23);
                    this.i13 = (this.i13 * 12);
                    si32(this.i19, this.i11);
                    this.i13 = (this.i14 + this.i13);
                    this.i17 = (this.i18 >>> 14);
                    this.i18 = (this.i18 & 0x400000);
                    if (this.i18 == 0) goto _label_25;
                    this.i14 = (this.i17 & 0xFF);
                    this.i14 = (this.i14 * 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i14 = (this.i12 + this.i14);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i21, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_25: 
                    this.i17 = (this.i17 & 0x01FF);
                    this.i17 = (this.i17 * 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i14 = (this.i14 + this.i17);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i21, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_26: 
                    this.i13 = 5;
                    this.i14 = li32(this.i15);
                    this.i17 = li32(public::mstate.ebp + -99);
                    si32(this.i14, this.i17);
                    this.i14 = (this.i18 >>> 14);
                    this.i17 = li32(public::mstate.ebp + -126);
                    si32(this.i13, this.i17);
                    si32(this.i19, this.i11);
                    this.i13 = (this.i14 * 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i14 = (public::mstate.ebp + -80);
                    this.i13 = (this.i12 + this.i13);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i21, (public::mstate.esp + 12));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_27: 
                    this.i17 = li8(this.i20 + 20);
                    this.i18 = (this.i18 & 0xFFFFFFF8);
                    this.i17 = (this.i17 & 0x03);
                    this.i17 = (this.i17 | this.i18);
                    si8(this.i17, this.i13);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_28: 
                    si32(this.i19, this.i11);
                    this.i13 = (this.i18 >>> 23);
                    this.i17 = (this.i18 >>> 31);
                    this.i20 = (this.i18 >>> 14);
                    this.i18 = (this.i18 & 0x400000);
                    if (!(this.i18 == 0))
                    {
                        this.i20 = (this.i20 & 0xFF);
                        this.i20 = (this.i20 * 12);
                        this.i20 = (this.i12 + this.i20);
                        this.i17 = (this.i17 & 0xFF);
                        if (this.i17 == 0) goto _label_29;
                    }
                    else
                    {
                        this.i20 = (this.i20 & 0x01FF);
                        this.i20 = (this.i20 * 12);
                        this.i20 = (this.i14 + this.i20);
                        this.i17 = (this.i17 & 0xFF);
                        if (this.i17 == 0) goto _label_132;
                    };
                    this.i14 = this.i20;
                    this.i13 = (this.i13 & 0xFF);
                    this.i13 = (this.i13 * 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i13 = (this.i12 + this.i13);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i14, (public::mstate.esp + 12));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_29: 
                    this.i17 = this.i20;
                    this.i13 = (this.i13 * 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i13 = (this.i14 + this.i13);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i17, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_30: 
                    this.i13 = (this.i13 | 0x08);
                    this.i20 = (this.i20 + -1);
                    this.i13 = (this.i13 & 0x0F);
                    this.i13 = (this.i13 << this.i20);
                    
                _label_31: 
                    this.i18 = (this.i18 >>> 26);
                    this.i18 = (this.i18 & 0x1F);
                    if (!(!(this.i18 == 0)))
                    {
                        this.i18 = this.i23;
                    }
                    else
                    {
                        this.i20 = (this.i23 | 0x08);
                        this.i18 = (this.i18 + -1);
                        this.i20 = (this.i20 & 0x0F);
                        this.i18 = (this.i20 << this.i18);
                    };
                    this.i20 = 32;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i23 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i23, (public::mstate.esp + 4));
                    si32(this.i23, (public::mstate.esp + 8));
                    si32(this.i20, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 15:
                    this.i20 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i22 = li32(this.i7);
                    this.i24 = li32(this.i22 + 28);
                    si32(this.i24, this.i20);
                    si32(this.i20, (this.i22 + 28));
                    this.i22 = li8(this.i22 + 20);
                    this.i22 = (this.i22 & 0x03);
                    si8(this.i22, (this.i20 + 5));
                    this.i22 = 5;
                    si8(this.i22, (this.i20 + 4));
                    si32(this.i23, (this.i20 + 8));
                    this.i24 = -1;
                    si8(this.i24, (this.i20 + 6));
                    si32(this.i23, (this.i20 + 12));
                    si32(this.i23, (this.i20 + 28));
                    si8(this.i23, (this.i20 + 7));
                    this.i23 = _dummynode_;
                    si32(this.i23, (this.i20 + 16));
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    si32(this.i18, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_setarrayvector.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_setnodevector.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i13 = (this.i17 * 12);
                    si32(this.i20, this.i21);
                    this.i13 = (this.i14 + this.i13);
                    si32(this.i22, (this.i13 + 8));
                    si32(this.i19, this.i11);
                    this.i13 = li32(this.i7);
                    this.i14 = li32(this.i13 + 68);
                    this.i13 = li32(this.i13 + 64);
                    if (uint(this.i14) < uint(this.i13)) goto _label_32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_32: 
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_33: 
                    this.i13 = (this.i18 >>> 23);
                    this.i13 = (this.i13 * 12);
                    this.i17 = (this.i17 * 12);
                    this.i13 = (this.i14 + this.i13);
                    this.f0 = lf64(this.i13);
                    this.i17 = (this.i17 + this.i14);
                    sf64(this.f0, (this.i17 + 12));
                    this.i20 = li32(this.i13 + 8);
                    si32(this.i20, (this.i17 + 20));
                    si32(this.i19, this.i11);
                    this.i17 = (this.i18 >>> 14);
                    this.i18 = (this.i18 & 0x400000);
                    if (this.i18 == 0) goto _label_34;
                    this.i14 = (this.i17 & 0xFF);
                    this.i14 = (this.i14 * 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i14 = (this.i12 + this.i14);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i21, (public::mstate.esp + 12));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_34: 
                    this.i17 = (this.i17 & 0x01FF);
                    this.i17 = (this.i17 * 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i14 = (this.i14 + this.i17);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i21, (public::mstate.esp + 12));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_35: 
                    this.i13 = (this.i18 >>> 14);
                    this.i20 = (this.i18 & 0x400000);
                    this.i23 = (this.i18 >>> 23);
                    this.i18 = (this.i18 >>> 31);
                    if (!(this.i18 == 0))
                    {
                        this.i23 = (this.i23 & 0xFF);
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i12 + this.i23);
                        if (this.i20 == 0) goto _label_36;
                    }
                    else
                    {
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i14 + this.i23);
                        if (this.i20 == 0) goto _label_133;
                    };
                    this.i13 = (this.i13 & 0xFF);
                    this.i13 = (this.i13 * 12);
                    this.i18 = li32(this.i23 + 8);
                    this.i13 = (this.i12 + this.i13);
                    if ((this.i18 == 3))
                    {
                        do 
                        {
                            this.i18 = li32(this.i13 + 8);
                            if (this.i18 == 3) goto _label_134;
                            break;
                            
                        _label_36: 
                            continue;
                        } while ((this.i13 = (this.i13 & 0x01FF)), (this.i13 = (this.i13 * 12)), (this.i18 = li32(this.i23 + 8)), (this.i13 = (this.i14 + this.i13)), (this.i18 == 3));
                    };
                    this.i14 = this.i23;
                    this.i17 = 5;
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    si32(this.i17, (public::mstate.esp + 16));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_Arith.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_37: 
                    this.i23 = (this.i23 * 12);
                    this.i23 = (this.i14 + this.i23);
                    if (this.i20 == 0) goto _label_135;
                    
                _label_38: 
                    this.i13 = (this.i13 & 0xFF);
                    this.i13 = (this.i13 * 12);
                    this.i18 = li32(this.i23 + 8);
                    this.i13 = (this.i12 + this.i13);
                    if ((this.i18 == 3))
                    {
                        do 
                        {
                            this.i18 = li32(this.i13 + 8);
                            if (this.i18 == 3) goto _label_136;
                            break;
                            
                        _label_39: 
                            continue;
                        } while ((this.i13 = (this.i13 & 0x01FF)), (this.i13 = (this.i13 * 12)), (this.i18 = li32(this.i23 + 8)), (this.i13 = (this.i14 + this.i13)), (this.i18 == 3));
                    };
                    this.i14 = this.i23;
                    this.i17 = 6;
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    si32(this.i17, (public::mstate.esp + 16));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_Arith.start();
                    return;
                case 22:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_40: 
                    this.i13 = (this.i18 >>> 14);
                    this.i20 = (this.i18 & 0x400000);
                    this.i23 = (this.i18 >>> 23);
                    this.i18 = (this.i18 >>> 31);
                    if (!(this.i18 == 0))
                    {
                        this.i23 = (this.i23 & 0xFF);
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i12 + this.i23);
                        if (this.i20 == 0) goto _label_41;
                    }
                    else
                    {
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i14 + this.i23);
                        if (this.i20 == 0) goto _label_137;
                    };
                    this.i13 = (this.i13 & 0xFF);
                    this.i13 = (this.i13 * 12);
                    this.i18 = li32(this.i23 + 8);
                    this.i13 = (this.i12 + this.i13);
                    if ((this.i18 == 3))
                    {
                        do 
                        {
                            this.i18 = li32(this.i13 + 8);
                            if (this.i18 == 3) goto _label_138;
                            break;
                            
                        _label_41: 
                            continue;
                        } while ((this.i13 = (this.i13 & 0x01FF)), (this.i13 = (this.i13 * 12)), (this.i18 = li32(this.i23 + 8)), (this.i13 = (this.i14 + this.i13)), (this.i18 == 3));
                    };
                    this.i14 = this.i23;
                    this.i17 = 7;
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    si32(this.i17, (public::mstate.esp + 16));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_Arith.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_42: 
                    this.i23 = (this.i23 * 12);
                    this.i23 = (this.i14 + this.i23);
                    if (this.i20 == 0) goto _label_139;
                    
                _label_43: 
                    this.i13 = (this.i13 & 0xFF);
                    this.i13 = (this.i13 * 12);
                    this.i18 = li32(this.i23 + 8);
                    this.i13 = (this.i12 + this.i13);
                    if ((this.i18 == 3))
                    {
                        do 
                        {
                            this.i18 = li32(this.i13 + 8);
                            if (this.i18 == 3) goto _label_140;
                            break;
                            
                        _label_44: 
                            continue;
                        } while ((this.i13 = (this.i13 & 0x01FF)), (this.i13 = (this.i13 * 12)), (this.i18 = li32(this.i23 + 8)), (this.i13 = (this.i14 + this.i13)), (this.i18 == 3));
                    };
                    this.i14 = this.i23;
                    this.i17 = 8;
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    si32(this.i17, (public::mstate.esp + 16));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_Arith.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_45: 
                    this.i13 = (this.i18 >>> 14);
                    this.i20 = (this.i18 & 0x400000);
                    this.i23 = (this.i18 >>> 23);
                    this.i18 = (this.i18 >>> 31);
                    if (!(this.i18 == 0))
                    {
                        this.i23 = (this.i23 & 0xFF);
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i12 + this.i23);
                        if (this.i20 == 0) goto _label_46;
                    }
                    else
                    {
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i14 + this.i23);
                        if (this.i20 == 0) goto _label_141;
                    };
                    this.i13 = (this.i13 & 0xFF);
                    this.i13 = (this.i13 * 12);
                    this.i18 = li32(this.i23 + 8);
                    this.i13 = (this.i12 + this.i13);
                    if ((this.i18 == 3))
                    {
                        do 
                        {
                            this.i18 = li32(this.i13 + 8);
                            if (this.i18 == 3) goto _label_142;
                            break;
                            
                        _label_46: 
                            continue;
                        } while ((this.i13 = (this.i13 & 0x01FF)), (this.i13 = (this.i13 * 12)), (this.i18 = li32(this.i23 + 8)), (this.i13 = (this.i14 + this.i13)), (this.i18 == 3));
                    };
                    this.i14 = this.i23;
                    this.i17 = 9;
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    si32(this.i17, (public::mstate.esp + 16));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_Arith.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_47: 
                    this.i13 = (this.i18 >>> 14);
                    this.i20 = (this.i18 & 0x400000);
                    this.i23 = (this.i18 >>> 23);
                    this.i18 = (this.i18 >>> 31);
                    if (!(this.i18 == 0))
                    {
                        this.i23 = (this.i23 & 0xFF);
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i12 + this.i23);
                        if (this.i20 == 0) goto _label_48;
                    }
                    else
                    {
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i14 + this.i23);
                        if (this.i20 == 0) goto _label_143;
                    };
                    this.i13 = (this.i13 & 0xFF);
                    this.i13 = (this.i13 * 12);
                    this.i18 = li32(this.i23 + 8);
                    this.i13 = (this.i12 + this.i13);
                    if ((this.i18 == 3))
                    {
                        do 
                        {
                            this.i18 = li32(this.i13 + 8);
                            if (this.i18 == 3) goto _label_144;
                            break;
                            
                        _label_48: 
                            continue;
                        } while ((this.i13 = (this.i13 & 0x01FF)), (this.i13 = (this.i13 * 12)), (this.i18 = li32(this.i23 + 8)), (this.i13 = (this.i14 + this.i13)), (this.i18 == 3));
                    };
                    this.i14 = this.i23;
                    this.i17 = 10;
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    si32(this.i17, (public::mstate.esp + 16));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_Arith.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_49: 
                    this.i13 = 11;
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i18, (public::mstate.esp + 8));
                    si32(this.i18, (public::mstate.esp + 12));
                    si32(this.i13, (public::mstate.esp + 16));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_Arith.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_50: 
                    this.i13 = (this.i18 >>> 23);
                    this.i18 = (this.i13 * 12);
                    this.i18 = (this.i14 + this.i18);
                    this.i18 = li32(this.i18 + 8);
                    if (!(this.i18 == 0))
                    {
                        if (!(!(this.i18 == 1)))
                        {
                            this.i13 = (this.i13 * 12);
                            this.i13 = (this.i14 + this.i13);
                            this.i13 = li32(this.i13);
                            if (this.i13 == 0) goto _label_51;
                        };
                        this.i13 = 0;
                        this.i17 = (this.i17 * 12);
                        si32(this.i13, this.i21);
                        this.i13 = 1;
                        this.i17 = (this.i14 + this.i17);
                        si32(this.i13, (this.i17 + 8));
                        this.i13 = this.i19;
                        goto _label_3;
                    };
                    
                _label_51: 
                    this.i13 = 1;
                    this.i17 = (this.i17 * 12);
                    si32(this.i13, this.i21);
                    this.i17 = (this.i14 + this.i17);
                    si32(this.i13, (this.i17 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_52: 
                    this.i18 = 3;
                    this.i13 = li32(this.i13);
                    this.i13 = li32(this.i13 + 12);
                    this.i17 = (this.i17 * 12);
                    this.i17 = (this.i14 + this.i17);
                    this.f0 = Number(uint(this.i13));
                    sf64(this.f0, this.i17);
                    si32(this.i18, (this.i17 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_53: 
                    this.i14 = 12;
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 28:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i17 = li32(this.i14 + 8);
                    if (!(this.i17 == 0)) goto _label_54;
                    this.i14 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i17 = 12;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i17, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 29:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_54: 
                    this.i17 = li32(this.i14 + 8);
                    if (this.i17 == 0) goto _label_55;
                    this.i17 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    si32(this.i17, (public::mstate.esp + 16));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_callTMres.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_55: 
                    this.i14 = __2E_str6171;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_typeerror.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_56: 
                    this.i13 = (this.i18 >>> 14);
                    this.i14 = (this.i18 >>> 23);
                    si32(this.i19, this.i11);
                    this.i18 = (1 - this.i14);
                    this.i13 = (this.i13 & 0x01FF);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i18 = (this.i18 + this.i13);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i13 = li32(this.i7);
                    this.i18 = li32(this.i13 + 68);
                    this.i13 = li32(this.i13 + 64);
                    if (uint(this.i18) < uint(this.i13)) goto _label_57;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_57: 
                    this.i18 = li32(this.i9);
                    this.i13 = (this.i14 * 12);
                    this.i13 = (this.i18 + this.i13);
                    this.f0 = lf64(this.i13);
                    this.i14 = (this.i17 * 12);
                    this.i14 = (this.i18 + this.i14);
                    sf64(this.f0, this.i14);
                    this.i13 = li32(this.i13 + 8);
                    si32(this.i13, (this.i14 + 8));
                    this.i13 = this.i19;
                    this.i14 = this.i18;
                    goto _label_3;
                    
                _label_58: 
                    this.i20 = (this.i18 >>> 14);
                    this.i21 = (this.i18 & 0x400000);
                    this.i23 = (this.i18 >>> 23);
                    this.i18 = (this.i18 >>> 31);
                    if (!(this.i18 == 0))
                    {
                        this.i23 = (this.i23 & 0xFF);
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i12 + this.i23);
                        if (this.i21 == 0) goto _label_59;
                    }
                    else
                    {
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i14 + this.i23);
                        if (this.i21 == 0) goto _label_145;
                    };
                    this.i14 = this.i23;
                    this.i20 = (this.i20 & 0xFF);
                    this.i20 = (this.i20 * 12);
                    this.i20 = (this.i12 + this.i20);
                    goto _label_60;
                    
                _label_59: 
                    this.i18 = this.i23;
                    this.i20 = (this.i20 & 0x01FF);
                    this.i20 = (this.i20 * 12);
                    this.i20 = (this.i14 + this.i20);
                    this.i14 = this.i18;
                    
                _label_60: 
                    this.i18 = this.i20;
                    si32(this.i19, this.i11);
                    this.i20 = li32(this.i14 + 8);
                    this.i21 = li32(this.i18 + 8);
                    this.i23 = (this.i18 + 8);
                    this.i22 = (this.i14 + 8);
                    if (!(this.i20 == this.i21)) goto _label_69;
                    if (!(this.i20 > 2))
                    {
                        if (this.i20 == 0) goto _label_61;
                        if (this.i20 == 1) goto _label_62;
                        if (!(this.i20 == 2)) goto _label_146;
                        this.i14 = li32(this.i14);
                        this.i18 = li32(this.i18);
                        this.i14 = ((this.i14 == this.i18) ? 1 : 0);
                        this.i14 = (this.i14 & 0x01);
                        goto _label_68;
                    };
                    if (!(this.i20 == 3))
                    {
                        if (this.i20 == 5) goto _label_64;
                        if (!(this.i20 == 7)) goto _label_146;
                        this.i20 = li32(this.i14);
                        this.i21 = li32(this.i18);
                        if (!(this.i20 == this.i21))
                        {
                            goto _label_63;
                        };
                        
                    _label_61: 
                        this.i14 = 1;
                        goto _label_68;
                    };
                    this.f0 = lf64(this.i14);
                    this.f1 = lf64(this.i18);
                    this.i14 = ((this.f0 == this.f1) ? 1 : 0);
                    this.i14 = (this.i14 & 0x01);
                    goto _label_68;
                    
                _label_62: 
                    this.i14 = li32(this.i14);
                    this.i18 = li32(this.i18);
                    this.i14 = ((this.i14 == this.i18) ? 1 : 0);
                    this.i14 = (this.i14 & 0x01);
                    goto _label_68;
                    
                _label_63: 
                    this.i21 = li32(this.i21 + 8);
                    this.i20 = li32(this.i20 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    si32(this.i21, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_get_compTM.start();
                case 34:
                    this.i20 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i20 == 0) goto _label_67;
                    goto _label_65;
                    
                _label_64: 
                    this.i20 = li32(this.i14);
                    this.i21 = li32(this.i18);
                    if (this.i20 == this.i21) goto _label_61;
                    this.i21 = li32(this.i21 + 8);
                    this.i20 = li32(this.i20 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    si32(this.i21, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_get_compTM.start();
                case 35:
                    this.i20 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i20 == 0) goto _label_67;
                    
                _label_65: 
                    this.i21 = li32(this.i6);
                    this.i24 = li32(public::mstate.ebp + -171);
                    this.i24 = li32(this.i24);
                    this.f0 = lf64(this.i20);
                    sf64(this.f0, this.i21);
                    this.i20 = li32(this.i20 + 8);
                    si32(this.i20, (this.i21 + 8));
                    this.i20 = li32(this.i6);
                    this.f0 = lf64(this.i14);
                    sf64(this.f0, (this.i20 + 12));
                    this.i14 = li32(this.i22);
                    si32(this.i14, (this.i20 + 20));
                    this.i14 = li32(this.i6);
                    this.f0 = lf64(this.i18);
                    sf64(this.f0, (this.i14 + 24));
                    this.i18 = li32(this.i23);
                    si32(this.i18, (this.i14 + 32));
                    this.i14 = li32(this.i5);
                    this.i18 = li32(this.i6);
                    this.i20 = (this.i21 - this.i24);
                    this.i14 = (this.i14 - this.i18);
                    if (this.i14 > 36) goto _label_66;
                    this.i14 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_growstack.start();
                    return;
                case 36:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_66: 
                    this.i14 = 1;
                    this.i18 = li32(this.i6);
                    this.i21 = (this.i18 + 36);
                    si32(this.i21, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 37:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = li32(this.i6);
                    this.i18 = li32(public::mstate.ebp + -171);
                    this.i18 = li32(this.i18);
                    this.i21 = (this.i14 + -12);
                    si32(this.i21, this.i6);
                    this.f0 = lf64(this.i14 + -12);
                    this.i18 = (this.i18 + this.i20);
                    sf64(this.f0, this.i18);
                    this.i14 = li32(this.i14 + -4);
                    si32(this.i14, (this.i18 + 8));
                    this.i14 = li32(this.i6);
                    this.i18 = li32(this.i14 + 8);
                    if (!(this.i18 == 0))
                    {
                        if (!(this.i18 == 1)) goto _label_61;
                        this.i14 = li32(this.i14);
                        this.i14 = ((this.i14 != 0) ? 1 : 0);
                        this.i14 = (this.i14 & 0x01);
                    }
                    else
                    {
                        
                    _label_67: 
                        this.i14 = 0;
                    };
                    
                _label_68: 
                    if (!(this.i14 == 0))
                    {
                        this.i14 = 1;
                    }
                    else
                    {
                        
                    _label_69: 
                        this.i14 = 0;
                    };
                    if (!(!(this.i14 == this.i17)))
                    {
                        this.i14 = li32(this.i19);
                        this.i14 = (this.i14 & 0xFFFFC000);
                        this.i14 = (this.i14 >>> 12);
                        this.i17 = li32(this.i9);
                        this.i13 = (this.i14 + this.i13);
                        this.i13 = (this.i13 + -524276);
                        this.i14 = this.i17;
                        goto _label_3;
                    };
                    this.i14 = li32(this.i9);
                    this.i13 = (this.i13 + 8);
                    goto _label_3;
                    
                _label_70: 
                    this.i23 = (this.i23 & 0x01FF);
                    this.i23 = (this.i23 * 12);
                    this.i23 = (this.i14 + this.i23);
                    this.i18 = (this.i21 & 0xFF);
                    if (this.i18 == 0) goto _label_147;
                    
                _label_71: 
                    this.i14 = this.i23;
                    this.i20 = (this.i20 & 0xFF);
                    this.i20 = (this.i20 * 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i20 = (this.i12 + this.i20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_lessthan.start();
                    return;
                case 38:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i14 == this.i17) goto _label_74;
                    
                _label_72: 
                    this.i14 = li32(this.i9);
                    this.i13 = (this.i13 + 8);
                    goto _label_3;
                    
                _label_73: 
                    this.i18 = this.i23;
                    this.i20 = (this.i20 * 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i14 = (this.i14 + this.i20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i18, (public::mstate.esp + 8));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_lessthan.start();
                    return;
                case 39:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i14 == this.i17)) goto _label_72;
                    
                _label_74: 
                    this.i14 = li32(this.i19);
                    this.i14 = (this.i14 & 0xFFFFC000);
                    this.i14 = (this.i14 >>> 12);
                    this.i17 = li32(this.i9);
                    this.i13 = (this.i14 + this.i13);
                    this.i13 = (this.i13 + -524276);
                    this.i14 = this.i17;
                    goto _label_3;
                    
                _label_75: 
                    si32(this.i19, this.i11);
                    this.i20 = (this.i18 >>> 23);
                    this.i21 = (this.i18 >>> 31);
                    this.i23 = (this.i18 >>> 14);
                    this.i18 = (this.i18 & 0x400000);
                    if (!(this.i18 == 0))
                    {
                        this.i23 = (this.i23 & 0xFF);
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i12 + this.i23);
                        this.i21 = (this.i21 & 0xFF);
                        if (this.i21 == 0) goto _label_76;
                    }
                    else
                    {
                        this.i23 = (this.i23 & 0x01FF);
                        this.i23 = (this.i23 * 12);
                        this.i23 = (this.i14 + this.i23);
                        this.i18 = (this.i21 & 0xFF);
                        if (this.i18 == 0) goto _label_148;
                    };
                    this.i14 = this.i23;
                    this.i20 = (this.i20 & 0xFF);
                    this.i20 = (this.i20 * 12);
                    this.i20 = (this.i12 + this.i20);
                    goto _label_77;
                    
                _label_76: 
                    this.i18 = this.i23;
                    this.i20 = (this.i20 * 12);
                    this.i20 = (this.i14 + this.i20);
                    this.i14 = this.i18;
                    
                _label_77: 
                    this.i18 = this.i20;
                    this.i20 = li32(this.i18 + 8);
                    this.i21 = li32(this.i14 + 8);
                    this.i23 = (this.i14 + 8);
                    this.i22 = (this.i18 + 8);
                    if (this.i20 == this.i21) goto _label_80;
                    this.i14 = _luaT_typenames;
                    this.i18 = (this.i21 << 2);
                    this.i20 = (this.i20 << 2);
                    this.i18 = (this.i14 + this.i18);
                    this.i14 = (this.i14 + this.i20);
                    this.i14 = li32(this.i14);
                    this.i18 = li32(this.i18);
                    this.i20 = li8(this.i14 + 2);
                    this.i23 = li8(this.i18 + 2);
                    if (!(this.i20 == this.i23)) goto _label_78;
                    this.i18 = __2E_str16273;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 40:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_79;
                    
                _label_78: 
                    this.i20 = __2E_str17274;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i18, (public::mstate.esp + 12));
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 41:
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_79: 
                    if (this.i17 == 0) goto _label_83;
                    goto _label_85;
                    
                _label_80: 
                    if (this.i20 == 4) goto _label_84;
                    if (!(!(this.i20 == 3)))
                    {
                        this.f0 = lf64(this.i18);
                        this.f1 = lf64(this.i14);
                        this.i14 = ((this.f0 <= this.f1) ? 1 : 0);
                        this.i14 = (this.i14 & 0x01);
                        if (this.i14 == this.i17) goto _label_83;
                        goto _label_85;
                    };
                    this.i20 = 14;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i20, (public::mstate.esp + 12));
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_call_orderTM.start();
                    return;
                case 42:
                    this.i20 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i20 == -1))
                    {
                        this.i14 = this.i20;
                        goto _label_82;
                    };
                    this.i20 = 13;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i18, (public::mstate.esp + 8));
                    si32(this.i20, (public::mstate.esp + 12));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_call_orderTM.start();
                    return;
                case 43:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i14 == -1))
                    {
                        this.i14 = ((this.i14 == 0) ? 1 : 0);
                        this.i14 = (this.i14 & 0x01);
                        if (this.i14 == this.i17) goto _label_83;
                        goto _label_85;
                    };
                    this.i14 = _luaT_typenames;
                    this.i18 = li32(this.i22);
                    this.i20 = li32(this.i23);
                    this.i20 = (this.i20 << 2);
                    this.i18 = (this.i18 << 2);
                    this.i20 = (this.i14 + this.i20);
                    this.i14 = (this.i14 + this.i18);
                    this.i14 = li32(this.i14);
                    this.i18 = li32(this.i20);
                    this.i20 = li8(this.i14 + 2);
                    this.i21 = li8(this.i18 + 2);
                    if (!(this.i20 == this.i21)) goto _label_81;
                    this.i18 = __2E_str16273;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 44:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = 0;
                    goto _label_82;
                    
                _label_81: 
                    this.i20 = __2E_str17274;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i18, (public::mstate.esp + 12));
                    state = 45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 45:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i14 = 0;
                    
                _label_82: 
                    if (!(this.i14 == this.i17)) goto _label_85;
                    
                _label_83: 
                    this.i14 = li32(this.i19);
                    this.i14 = (this.i14 & 0xFFFFC000);
                    this.i14 = (this.i14 >>> 12);
                    this.i17 = li32(this.i9);
                    this.i13 = (this.i14 + this.i13);
                    this.i13 = (this.i13 + -524276);
                    this.i14 = this.i17;
                    goto _label_3;
                    
                _label_84: 
                    this.i14 = li32(this.i14);
                    this.i18 = li32(this.i18);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i18, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    state = 46;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_l_strcmp.start();
                    return;
                case 46:
                    this.i14 = public::mstate.eax;
                    this.i14 = ((this.i14 < 1) ? 1 : 0);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i14 = (this.i14 & 0x01);
                    if (this.i14 == this.i17) goto _label_83;
                    
                _label_85: 
                    this.i14 = li32(this.i9);
                    this.i13 = (this.i13 + 8);
                    goto _label_3;
                    
                _label_86: 
                    this.i17 = (this.i17 * 12);
                    this.i17 = (this.i14 + this.i17);
                    this.i17 = li32(this.i17 + 8);
                    if (!(this.i17 == 1))
                    {
                        if (!(this.i17 == 0)) goto _label_88;
                        
                    _label_87: 
                        this.i17 = 1;
                        goto _label_89;
                    };
                    this.i17 = li32(this.i21);
                    if (this.i17 == 0) goto _label_87;
                    
                _label_88: 
                    this.i17 = 0;
                    
                _label_89: 
                    this.i18 = (this.i18 >>> 14);
                    this.i18 = (this.i18 & 0x01FF);
                    if (!(this.i17 == this.i18))
                    {
                        this.i17 = li32(this.i19);
                        this.i17 = (this.i17 & 0xFFFFC000);
                        this.i17 = (this.i17 >>> 12);
                        this.i13 = (this.i17 + this.i13);
                        this.i13 = (this.i13 + -524276);
                        goto _label_3;
                    };
                    this.i13 = (this.i13 + 8);
                    goto _label_3;
                    
                _label_90: 
                    this.i23 = (this.i20 * 12);
                    this.i23 = (this.i14 + this.i23);
                    this.i23 = li32(this.i23);
                    if (this.i23 == 0) goto _label_14;
                    
                _label_91: 
                    this.i23 = 0;
                    
                _label_92: 
                    this.i18 = (this.i18 >>> 14);
                    this.i18 = (this.i18 & 0x01FF);
                    if (!(this.i23 == this.i18))
                    {
                        this.i18 = (this.i20 * 12);
                        this.i17 = (this.i17 * 12);
                        this.i18 = (this.i14 + this.i18);
                        this.f0 = lf64(this.i18);
                        this.i17 = (this.i14 + this.i17);
                        sf64(this.f0, this.i17);
                        si32(this.i21, (this.i17 + 8));
                        this.i17 = li32(this.i19);
                        this.i17 = (this.i17 & 0xFFFFC000);
                        this.i17 = (this.i17 >>> 12);
                        this.i13 = (this.i17 + this.i13);
                        this.i13 = (this.i13 + -524276);
                        goto _label_3;
                    };
                    this.i13 = (this.i13 + 8);
                    goto _label_3;
                    
                _label_93: 
                    this.i13 = (this.i18 >>> 14);
                    this.i13 = (this.i13 & 0x01FF);
                    this.i13 = (this.i13 + -1);
                    if (!(uint(this.i18) < uint(0x800000)))
                    {
                        this.i18 = (this.i18 >>> 23);
                        this.i17 = (this.i17 + this.i18);
                        this.i17 = (this.i17 * 12);
                        this.i14 = (this.i14 + this.i17);
                        si32(this.i14, this.i6);
                    };
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_precall.start();
                    return;
                case 47:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i14 == 1))
                    {
                        if (!(this.i14 == 0)) goto _label_7;
                        this.i13 = li32(public::mstate.ebp + -90);
                        this.i13 = (this.i13 + 1);
                        this.i2 = this.i13;
                        goto _label_1;
                    };
                    if (!(this.i13 < 0))
                    {
                        this.i13 = li32(this.i10);
                        this.i13 = li32(this.i13 + 8);
                        si32(this.i13, this.i6);
                        this.i14 = li32(this.i9);
                        this.i13 = this.i19;
                        goto _label_3;
                    };
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_94: 
                    this.i12 = 0;
                    this.i15 = this.i12;
                    
                _label_95: 
                    this.i16 = (this.i14 + this.i15);
                    this.f0 = lf64(this.i16);
                    this.i18 = (this.i13 + this.i15);
                    sf64(this.f0, this.i18);
                    this.i16 = li32(this.i16 + 8);
                    si32(this.i16, (this.i18 + 8));
                    this.i15 = (this.i15 + 12);
                    this.i16 = li32(this.i6);
                    this.i12 = (this.i12 + 1);
                    this.i18 = (this.i14 + this.i15);
                    if (uint(this.i18) < uint(this.i16)) goto _label_149;
                    this.i13 = this.i12;
                    
                _label_96: 
                    this.i13 = (this.i13 * 12);
                    this.i13 = (this.i17 + this.i13);
                    si32(this.i13, this.i6);
                    si32(this.i13, (this.i2 + -16));
                    this.i13 = li32(this.i11);
                    si32(this.i13, (this.i2 + -12));
                    this.i13 = li32(this.i2 + -4);
                    this.i13 = (this.i13 + 1);
                    si32(this.i13, (this.i2 + -4));
                    this.i2 = li32(this.i10);
                    this.i2 = (this.i2 + -24);
                    si32(this.i2, this.i10);
                    goto _label_2;
                    
                _label_97: 
                    this.i14 = li32(this.i9);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_98: 
                    if (!(uint(this.i18) < uint(0x800000)))
                    {
                        this.i2 = (this.i18 >>> 23);
                        this.i2 = (this.i2 + this.i17);
                        this.i2 = (this.i2 * 12);
                        this.i2 = (this.i2 + this.i14);
                        this.i2 = (this.i2 + -12);
                        si32(this.i2, this.i6);
                    };
                    this.i2 = li32(this.i4);
                    if (this.i2 == 0) goto _label_99;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    state = 48;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_close.start();
                    return;
                case 48:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_99: 
                    si32(this.i19, this.i11);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    state = 49;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_poscall.start();
                    return;
                case 49:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i13 = li32(public::mstate.ebp + -90);
                    this.i13 = (this.i13 + -1);
                    this.i14 = li32(public::mstate.ebp + -90);
                    if (this.i14 == 1) goto _label_7;
                    if (!(!(this.i2 == 0)))
                    {
                        this.i2 = this.i13;
                        goto _label_1;
                    };
                    this.i2 = li32(this.i10);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, this.i6);
                    this.i2 = this.i13;
                    goto _label_1;
                    
                _label_100: 
                    this.f0 = 0;
                    this.i20 = (this.i17 * 12);
                    this.i21 = (this.i20 + this.i14);
                    this.i20 = (this.i14 + this.i20);
                    this.f1 = lf64(this.i21 + 24);
                    this.f2 = lf64(this.i20);
                    this.f3 = lf64(this.i21 + 12);
                    this.f2 = (this.f2 + this.f1);
                    this.f4 = ((this.f1 > this.f0) ? this.f2 : this.f3);
                    this.f0 = ((this.f1 > this.f0) ? this.f3 : this.f2);
                    if (this.f4 > this.f0) goto _label_20;
                    this.i19 = 3;
                    this.i17 = (this.i17 * 12);
                    this.i18 = (this.i18 & 0xFFFFC000);
                    sf64(this.f2, this.i20);
                    this.i20 = (this.i14 + this.i17);
                    si32(this.i19, (this.i20 + 8));
                    this.i17 = (this.i17 + this.i14);
                    this.i18 = (this.i18 >>> 12);
                    sf64(this.f2, (this.i17 + 36));
                    this.i13 = (this.i18 + this.i13);
                    si32(this.i19, (this.i17 + 44));
                    this.i13 = (this.i13 + -524280);
                    goto _label_3;
                    
                _label_101: 
                    this.i21 = (this.i23 * 12);
                    this.i21 = (this.i14 + this.i21);
                    this.i25 = li32(this.i21 + 8);
                    this.i21 = (this.i21 + 8);
                    if (this.i25 == 3) goto _label_103;
                    if (!(this.i25 == 4)) goto _label_102;
                    this.i25 = (public::mstate.ebp + -32);
                    this.i26 = li32(this.i24);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i26 = (this.i26 + 16);
                    si32(this.i26, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    state = 50;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_str2d.start();
                    return;
                case 50:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i25 == 0))
                    {
                        this.i25 = 3;
                        this.i23 = (this.i23 * 12);
                        this.f0 = lf64(public::mstate.ebp + -32);
                        this.i23 = (this.i14 + this.i23);
                        sf64(this.f0, this.i23);
                        si32(this.i25, this.i21);
                        if (!(this.i24 == 0)) goto _label_103;
                    };
                    
                _label_102: 
                    this.i20 = __2E_str8173;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    state = 51;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 51:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_106;
                    
                _label_103: 
                    this.i21 = (this.i20 * 12);
                    this.i21 = (this.i14 + this.i21);
                    this.i23 = li32(this.i21 + 8);
                    this.i21 = (this.i21 + 8);
                    if (!(this.i23 == 4))
                    {
                        if (!(!(this.i23 == 3)))
                        {
                            goto _label_106;
                        };
                        
                    _label_104: 
                        this.i19 = 0;
                        goto _label_105;
                    };
                    this.i23 = (public::mstate.ebp + -40);
                    this.i24 = li32(this.i19);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i24 = (this.i24 + 16);
                    si32(this.i24, public::mstate.esp);
                    si32(this.i23, (public::mstate.esp + 4));
                    state = 52;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_str2d.start();
                    return;
                case 52:
                    this.i23 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i23 == 0) goto _label_104;
                    this.i23 = 3;
                    this.i20 = (this.i20 * 12);
                    this.f0 = lf64(public::mstate.ebp + -40);
                    this.i20 = (this.i14 + this.i20);
                    sf64(this.f0, this.i20);
                    si32(this.i23, this.i21);
                    
                _label_105: 
                    if (!(this.i19 == 0)) goto _label_106;
                    this.i20 = __2E_str9174;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    state = 53;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 53:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_106: 
                    this.i20 = 3;
                    this.i17 = (this.i17 * 12);
                    this.i17 = (this.i14 + this.i17);
                    this.i18 = (this.i18 & 0xFFFFC000);
                    this.f0 = lf64(this.i17);
                    this.f1 = lf64(this.i19);
                    this.i18 = (this.i18 >>> 12);
                    this.f0 = (this.f0 - this.f1);
                    this.i13 = (this.i18 + this.i13);
                    sf64(this.f0, this.i17);
                    si32(this.i20, this.i22);
                    this.i13 = (this.i13 + -524280);
                    goto _label_3;
                    
                _label_107: 
                    this.i20 = (this.i17 + 2);
                    this.i21 = (this.i20 * 12);
                    this.i23 = (this.i17 * 12);
                    this.i21 = (this.i14 + this.i21);
                    this.i22 = (this.i23 + this.i14);
                    this.f0 = lf64(this.i21);
                    sf64(this.f0, (this.i22 + 60));
                    this.i21 = li32(this.i21 + 8);
                    si32(this.i21, (this.i22 + 68));
                    this.f0 = lf64(this.i22 + 12);
                    sf64(this.f0, (this.i22 + 48));
                    this.i21 = li32(this.i22 + 20);
                    this.i17 = (this.i17 + 3);
                    this.i24 = (this.i17 * 12);
                    si32(this.i21, (this.i22 + 56));
                    this.i21 = (this.i14 + this.i23);
                    this.f0 = lf64(this.i21);
                    this.i14 = (this.i14 + this.i24);
                    sf64(this.f0, this.i14);
                    this.i21 = li32(this.i21 + 8);
                    si32(this.i21, (this.i14 + 8));
                    this.i21 = (this.i22 + 72);
                    si32(this.i21, this.i6);
                    si32(this.i19, this.i11);
                    this.i18 = (this.i18 >>> 14);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i18 = (this.i18 & 0x01FF);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i18, (public::mstate.esp + 8));
                    state = 54;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 54:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i14 = li32(this.i10);
                    this.i18 = li32(this.i9);
                    this.i14 = li32(this.i14 + 8);
                    si32(this.i14, this.i6);
                    this.i14 = (this.i18 + this.i24);
                    this.i14 = li32(this.i14 + 8);
                    if (!(this.i14 == 0))
                    {
                        this.i17 = (this.i17 * 12);
                        this.i20 = (this.i20 * 12);
                        this.i17 = (this.i18 + this.i17);
                        this.f0 = lf64(this.i17);
                        this.i17 = (this.i18 + this.i20);
                        sf64(this.f0, this.i17);
                        si32(this.i14, (this.i17 + 8));
                        this.i14 = li32(this.i19);
                        this.i14 = (this.i14 & 0xFFFFC000);
                        this.i14 = (this.i14 >>> 12);
                        this.i13 = (this.i14 + this.i13);
                        this.i13 = (this.i13 + -524276);
                        this.i14 = this.i18;
                        goto _label_3;
                    };
                    this.i13 = (this.i13 + 8);
                    this.i14 = this.i18;
                    goto _label_3;
                    
                _label_108: 
                    this.i18 = li32(this.i6);
                    this.i22 = li32(this.i10);
                    this.i22 = li32(this.i22 + 8);
                    this.i18 = (this.i18 - this.i21);
                    this.i18 = (this.i18 / 12);
                    si32(this.i22, this.i6);
                    this.i18 = (this.i18 + -1);
                    
                _label_109: 
                    if (!(this.i20 == 0))
                    {
                        this.i13 = this.i20;
                    }
                    else
                    {
                        this.i19 = li32(this.i19);
                        this.i20 = (this.i13 + 8);
                        this.i13 = this.i19;
                        this.i19 = this.i20;
                    };
                    this.i20 = (this.i17 * 12);
                    this.i20 = (this.i14 + this.i20);
                    this.i20 = li32(this.i20 + 8);
                    if (!(this.i20 == 5))
                    {
                        
                    _label_110: 
                        this.i13 = this.i19;
                        goto _label_3;
                    };
                    this.i20 = li32(this.i21);
                    this.i21 = (this.i13 * 50);
                    this.i22 = li32(this.i20 + 28);
                    this.i21 = (this.i18 + this.i21);
                    this.i21 = (this.i21 + -50);
                    this.i24 = this.i20;
                    if (this.i22 >= this.i21) goto _label_116;
                    this.i22 = _dummynode_;
                    this.i25 = li32(this.i20 + 16);
                    if (this.i25 == this.i22) goto _label_111;
                    this.i22 = 1;
                    this.i25 = li8(this.i20 + 7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i22 = (this.i22 << this.i25);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    si32(this.i21, (public::mstate.esp + 8));
                    si32(this.i22, (public::mstate.esp + 12));
                    state = 55;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_resize.start();
                    return;
                case 55:
                    public::mstate.esp = (public::mstate.esp + 16);
                    goto _label_112;
                    
                _label_111: 
                    this.i22 = 0;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    si32(this.i21, (public::mstate.esp + 8));
                    si32(this.i22, (public::mstate.esp + 12));
                    state = 56;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_resize.start();
                    return;
                case 56:
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_112: 
                    if (this.i18 < 1) goto _label_110;
                    
                _label_113: 
                    this.i17 = (this.i18 + this.i17);
                    this.i13 = (this.i13 * 50);
                    this.i17 = (this.i17 * 12);
                    this.i17 = (this.i23 + this.i17);
                    this.i13 = (this.i13 + -50);
                    this.i21 = (this.i20 + 24);
                    this.i23 = (this.i24 + 5);
                    
                _label_114: 
                    this.i22 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i25 = (this.i13 + this.i18);
                    si32(this.i20, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 57:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i27 = this.i17;
                    this.i28 = this.i17;
                    if (!(this.i26 == this.i22))
                    {
                        this.i25 = this.i26;
                        goto _label_115;
                    };
                    this.i22 = 3;
                    this.f0 = Number(this.i25);
                    sf64(this.f0, this.i0);
                    si32(this.i22, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i25 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i20, (public::mstate.esp + 4));
                    si32(this.i25, (public::mstate.esp + 8));
                    state = 58;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 58:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_115: 
                    this.i22 = this.i25;
                    this.f0 = lf64(this.i27);
                    sf64(this.f0, this.i22);
                    this.i25 = li32(this.i17 + 8);
                    si32(this.i25, (this.i22 + 8));
                    this.i22 = li32(this.i17 + 8);
                    if (!(this.i22 < 4))
                    {
                        this.i22 = li32(this.i28);
                        this.i22 = li8(this.i22 + 5);
                        this.i22 = (this.i22 & 0x03);
                        if (!(this.i22 == 0))
                        {
                            this.i22 = li8(this.i23);
                            this.i25 = (this.i22 & 0x04);
                            if (!(this.i25 == 0))
                            {
                                this.i25 = li32(this.i7);
                                this.i22 = (this.i22 & 0xFFFFFFFB);
                                si8(this.i22, this.i23);
                                this.i22 = li32(this.i25 + 40);
                                si32(this.i22, this.i21);
                                si32(this.i24, (this.i25 + 40));
                            };
                        };
                    };
                    this.i17 = (this.i17 + -12);
                    this.i18 = (this.i18 + -1);
                    if (this.i18 < 1) goto _label_110;
                    goto _label_114;
                    
                _label_116: 
                    if (this.i18 > 0) goto _label_113;
                    goto _label_110;
                    
                _label_117: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i21, (public::mstate.esp + 4));
                    state = 59;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_close.start();
                    return;
                case 59:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_118: 
                    this.i18 = (this.i18 & 0xFFFFC000);
                    this.i22 = li32(this.i16);
                    this.i22 = li32(this.i22 + 16);
                    this.i18 = (this.i18 >>> 12);
                    this.i18 = (this.i22 + this.i18);
                    this.i18 = li32(this.i18);
                    this.i22 = li8(this.i18 + 72);
                    this.i23 = li32(this.i15);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i22, (public::mstate.esp + 4));
                    si32(this.i23, (public::mstate.esp + 8));
                    state = 60;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_newLclosure.start();
                    return;
                case 60:
                    this.i23 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i18, (this.i23 + 16));
                    this.i18 = this.i23;
                    if (!(this.i22 > 0))
                    {
                        this.i13 = this.i19;
                        goto _label_125;
                    };
                    this.i19 = 0;
                    this.i24 = this.i19;
                    
                _label_119: 
                    this.i25 = (this.i20 + this.i24);
                    this.i25 = li32(this.i25 + 4);
                    this.i26 = (this.i25 >>> 23);
                    this.i25 = (this.i25 & 0x3F);
                    if (!(!(this.i25 == 4)))
                    {
                        this.i26 = (this.i26 << 2);
                        this.i26 = (this.i2 + this.i26);
                        this.i26 = li32(this.i26 + 20);
                        this.i25 = (this.i18 + this.i24);
                        si32(this.i26, (this.i25 + 20));
                        goto _label_124;
                    };
                    this.i25 = li32(this.i7);
                    this.i27 = li32(this.i4);
                    this.i26 = (this.i26 * 12);
                    this.i26 = (this.i14 + this.i26);
                    if (!(this.i27 == 0))
                    {
                        this.i27 = this.i4;
                    }
                    else
                    {
                        this.i27 = this.i4;
                        goto _label_121;
                        
                    _label_120: 
                        if (!(!(this.i27 == this.i26)))
                        {
                            this.i27 = li8(this.i25 + 20);
                            this.i25 = li8(this.i29 + 5);
                            this.i27 = (this.i27 ^ 0x03);
                            this.i26 = (this.i29 + 5);
                            this.i27 = (this.i27 & this.i25);
                            this.i27 = (this.i27 & 0x03);
                            if (!(!(this.i27 == 0)))
                            {
                                this.i27 = this.i28;
                                goto _label_123;
                            };
                            this.i27 = (this.i25 ^ 0x03);
                            si8(this.i27, this.i26);
                            this.i27 = this.i28;
                            goto _label_123;
                        };
                        this.i27 = li32(this.i29);
                        this.i28 = this.i29;
                        if (this.i27 == 0) goto _label_150;
                        this.i27 = this.i28;
                    };
                    this.i30 = this.i27;
                    this.i28 = li32(this.i30);
                    this.i27 = li32(this.i28 + 8);
                    this.i29 = this.i28;
                    if (uint(this.i27) >= uint(this.i26)) goto _label_120;
                    this.i27 = this.i30;
                    
                _label_121: 
                    this.i28 = 24;
                    this.i29 = li32(this.i25 + 12);
                    this.i30 = li32(this.i25 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i31 = 0;
                    si32(this.i30, public::mstate.esp);
                    si32(this.i31, (public::mstate.esp + 4));
                    si32(this.i31, (public::mstate.esp + 8));
                    si32(this.i28, (public::mstate.esp + 12));
                    state = 61;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i29]());
                    return;
                case 61:
                    this.i28 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i28 == 0)) goto _label_122;
                    this.i29 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i29, (public::mstate.esp + 4));
                    state = 62;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 62:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_122: 
                    this.i29 = 10;
                    this.i30 = li32(this.i25 + 68);
                    this.i30 = (this.i30 + 24);
                    si32(this.i30, (this.i25 + 68));
                    si8(this.i29, (this.i28 + 4));
                    this.i29 = li8(this.i25 + 20);
                    this.i29 = (this.i29 & 0x03);
                    si8(this.i29, (this.i28 + 5));
                    si32(this.i26, (this.i28 + 8));
                    this.i26 = li32(this.i27);
                    si32(this.i26, this.i28);
                    si32(this.i28, this.i27);
                    this.i27 = (this.i25 + 108);
                    si32(this.i27, (this.i28 + 12));
                    this.i27 = li32(this.i25 + 124);
                    si32(this.i27, (this.i28 + 16));
                    si32(this.i28, (this.i27 + 12));
                    si32(this.i28, (this.i25 + 124));
                    this.i27 = this.i28;
                    
                _label_123: 
                    this.i25 = this.i27;
                    this.i26 = (this.i18 + this.i24);
                    si32(this.i25, (this.i26 + 20));
                    
                _label_124: 
                    this.i24 = (this.i24 + 4);
                    this.i19 = (this.i19 + 1);
                    if (!(this.i19 == this.i22)) goto _label_119;
                    this.i18 = (this.i19 << 2);
                    this.i13 = (this.i18 + this.i13);
                    this.i13 = (this.i13 + 4);
                    
                _label_125: 
                    this.i18 = 6;
                    this.i17 = (this.i17 * 12);
                    si32(this.i23, this.i21);
                    this.i14 = (this.i14 + this.i17);
                    si32(this.i18, (this.i14 + 8));
                    si32(this.i13, this.i11);
                    this.i14 = li32(this.i7);
                    this.i17 = li32(this.i14 + 68);
                    this.i14 = li32(this.i14 + 64);
                    if (uint(this.i17) < uint(this.i14)) goto _label_126;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 63;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 63:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i14 = li32(this.i9);
                    goto _label_3;
                    
                _label_126: 
                    this.i14 = li32(this.i9);
                    goto _label_3;
                    
                _label_127: 
                    this.i13 = li32(this.i10);
                    this.i20 = li32(this.i13);
                    this.i22 = li32(this.i13 + 4);
                    this.i23 = (this.i20 - this.i22);
                    this.i24 = li32(this.i16);
                    this.i24 = li8(this.i24 + 73);
                    this.i23 = (this.i23 / 12);
                    this.i23 = (this.i23 - this.i24);
                    this.i18 = (this.i18 >>> 23);
                    this.i23 = (this.i23 + -1);
                    this.i25 = (this.i18 + -1);
                    if (!(this.i18 == 0)) goto _label_130;
                    si32(this.i19, this.i11);
                    this.i14 = li32(this.i5);
                    this.i21 = li32(this.i6);
                    this.i25 = (this.i23 * 12);
                    this.i14 = (this.i14 - this.i21);
                    if (this.i14 > this.i25) goto _label_129;
                    this.i14 = li32(public::mstate.ebp + -108);
                    this.i14 = li32(this.i14);
                    if (this.i14 < this.i23) goto _label_128;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i14 = (this.i14 << 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    state = 64;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 64:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_129;
                    
                _label_128: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i14 = (this.i14 + this.i23);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    state = 65;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 65:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_129: 
                    this.i14 = (this.i23 + this.i17);
                    this.i21 = li32(this.i9);
                    this.i14 = (this.i14 * 12);
                    this.i25 = (this.i17 * 12);
                    this.i14 = (this.i21 + this.i14);
                    si32(this.i14, this.i6);
                    this.i14 = (this.i21 + this.i25);
                    if (!(this.i23 > 0))
                    {
                        this.i13 = this.i19;
                        this.i14 = this.i21;
                        goto _label_3;
                    };
                    this.i17 = this.i14;
                    this.i14 = this.i21;
                    this.i21 = this.i23;
                    goto _label_131;
                    
                _label_130: 
                    if (this.i25 < 1) goto _label_20;
                    this.i17 = this.i21;
                    this.i21 = this.i25;
                    
                _label_131: 
                    this.i18 = this.i21;
                    this.i21 = 0;
                    this.i20 = (this.i20 - this.i22);
                    this.i22 = (this.i24 & 0xFF);
                    this.i20 = (this.i20 / 12);
                    this.i20 = (this.i20 - this.i22);
                    this.i20 = (this.i20 * -12);
                    this.i22 = this.i21;
                    do 
                    {
                        if (!(this.i21 >= this.i23))
                        {
                            this.i24 = li32(this.i13);
                            this.i25 = (this.i20 + this.i22);
                            this.i24 = (this.i24 + this.i25);
                            this.f0 = lf64(this.i24 + 12);
                            this.i25 = (this.i17 + this.i22);
                            sf64(this.f0, this.i25);
                            this.i24 = li32(this.i24 + 20);
                            si32(this.i24, (this.i25 + 8));
                        }
                        else
                        {
                            this.i24 = 0;
                            this.i25 = (this.i17 + this.i22);
                            si32(this.i24, (this.i25 + 8));
                        };
                        this.i22 = (this.i22 + 12);
                        this.i21 = (this.i21 + 1);
                        if (!(this.i21 < this.i18))
                        {
                            this.i13 = this.i19;
                            goto _label_3;
                        };
                    } while (true);
                    
                _label_132: 
                    goto _label_29;
                    
                _label_133: 
                    //unresolved jump
                    
                _label_134: 
                    this.i18 = 3;
                    this.f0 = lf64(this.i23);
                    this.f1 = lf64(this.i13);
                    this.i13 = (this.i17 * 12);
                    this.i13 = (this.i14 + this.i13);
                    this.f0 = (this.f0 + this.f1);
                    sf64(this.f0, this.i13);
                    si32(this.i18, (this.i13 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_135: 
                    //unresolved jump
                    
                _label_136: 
                    this.i18 = 3;
                    this.f0 = lf64(this.i23);
                    this.f1 = lf64(this.i13);
                    this.i13 = (this.i17 * 12);
                    this.i13 = (this.i14 + this.i13);
                    this.f0 = (this.f0 - this.f1);
                    sf64(this.f0, this.i13);
                    si32(this.i18, (this.i13 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_137: 
                    //unresolved jump
                    
                _label_138: 
                    this.i18 = 3;
                    this.f0 = lf64(this.i23);
                    this.f1 = lf64(this.i13);
                    this.i13 = (this.i17 * 12);
                    this.i13 = (this.i14 + this.i13);
                    this.f0 = (this.f0 * this.f1);
                    sf64(this.f0, this.i13);
                    si32(this.i18, (this.i13 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_139: 
                    //unresolved jump
                    
                _label_140: 
                    this.i18 = 3;
                    this.f0 = lf64(this.i23);
                    this.f1 = lf64(this.i13);
                    this.i13 = (this.i17 * 12);
                    this.i13 = (this.i14 + this.i13);
                    this.f0 = (this.f0 / this.f1);
                    sf64(this.f0, this.i13);
                    si32(this.i18, (this.i13 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_141: 
                    //unresolved jump
                    
                _label_142: 
                    this.i18 = 3;
                    this.f1 = lf64(this.i23);
                    this.f2 = lf64(this.i13);
                    this.f0 = (this.f1 / this.f2);
                    this.f0 = Math.floor(this.f0);
                    this.f0 = (this.f0 * this.f2);
                    this.i13 = (this.i17 * 12);
                    this.i13 = (this.i14 + this.i13);
                    this.f0 = (this.f1 - this.f0);
                    sf64(this.f0, this.i13);
                    si32(this.i18, (this.i13 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_143: 
                    //unresolved jump
                    
                _label_144: 
                    this.i18 = 3;
                    this.f0 = lf64(this.i23);
                    this.f1 = lf64(this.i13);
                    this.i13 = (this.i17 * 12);
                    this.i13 = (this.i14 + this.i13);
                    this.f0 = Math.pow(this.f0, this.f1);
                    sf64(this.f0, this.i13);
                    si32(this.i18, (this.i13 + 8));
                    this.i13 = this.i19;
                    goto _label_3;
                    
                _label_145: 
                    goto _label_59;
                    
                _label_146: 
                    this.i14 = li32(this.i14);
                    this.i18 = li32(this.i18);
                    this.i14 = ((this.i14 == this.i18) ? 1 : 0);
                    this.i14 = (this.i14 & 0x01);
                    goto _label_68;
                    
                _label_147: 
                    goto _label_73;
                    
                _label_148: 
                    goto _label_76;
                    
                _label_149: 
                    goto _label_95;
                    
                _label_150: 
                    this.i27 = this.i28;
                    goto _label_121;
                default:
                    throw ("Invalid state in _luaV_execute");
            };
        }


    }
} cmodule.lua_wrapper

