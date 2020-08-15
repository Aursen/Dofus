package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_singlestep extends Machine 
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
            var _local_1:FSM_singlestep;
            _local_1 = new (FSM_singlestep)();
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
                    this.i1 = li32(this.i0 + 16);
                    this.i2 = li8(this.i1 + 21);
                    this.i3 = (this.i1 + 21);
                    this.i4 = (this.i0 + 16);
                    this.i5 = this.i1;
                    if (this.i2 > 1) goto _label_1;
                    if (this.i2 == 0) goto _label_3;
                    if (!(this.i2 == 1)) goto _label_2;
                    this.i4 = li32(this.i5 + 36);
                    this.i2 = (this.i5 + 36);
                    if (this.i4 == 0) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i5, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_propagatemark.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    goto _label_38;
                    
                _label_1: 
                    if (this.i2 == 2) goto _label_28;
                    if (this.i2 == 3) goto _label_30;
                    if (this.i2 == 4) goto _label_36;
                    
                _label_2: 
                    this.i0 = 0;
                    goto _label_38;
                    
                _label_3: 
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_markroot.start();
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    public::mstate.eax = this.i1;
                    
                _label_5: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_6: 
                    this.i4 = li32(this.i5 + 124);
                    this.i6 = (this.i5 + 108);
                    if (this.i6 == this.i4) goto _label_9;
                    
                _label_7: 
                    this.i7 = li8(this.i4 + 5);
                    this.i8 = (this.i7 & 0x04);
                    if (!(this.i8 == 0)) goto _label_8;
                    this.i7 = (this.i7 & 0x03);
                    if (!(this.i7 == 0)) goto _label_8;
                    this.i7 = li32(this.i4 + 8);
                    this.i8 = li32(this.i7 + 8);
                    if (this.i8 < 4) goto _label_8;
                    this.i7 = li32(this.i7);
                    this.i8 = li8(this.i7 + 5);
                    this.i8 = (this.i8 & 0x03);
                    if (this.i8 == 0) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_8: 
                    this.i4 = li32(this.i4 + 16);
                    if (!(this.i6 == this.i4)) goto _label_7;
                    
                _label_9: 
                    this.i4 = li32(this.i2);
                    if (this.i4 == 0) goto _label_11;
                    
                _label_10: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i5, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_propagatemark.start();
                    return;
                case 4:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i4 = li32(this.i2);
                    if (!(this.i4 == 0)) goto _label_10;
                    
                _label_11: 
                    this.i4 = 0;
                    this.i6 = li32(this.i5 + 44);
                    si32(this.i6, this.i2);
                    si32(this.i4, (this.i5 + 44));
                    this.i4 = li8(this.i0 + 5);
                    this.i6 = (this.i5 + 44);
                    this.i4 = (this.i4 & 0x03);
                    if (this.i4 == 0) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_12: 
                    this.i4 = 0;
                    this.i1 = (this.i1 + 132);
                    
                _label_13: 
                    this.i7 = li32(this.i1);
                    if (this.i7 == 0) goto _label_14;
                    this.i8 = li8(this.i7 + 5);
                    this.i8 = (this.i8 & 0x03);
                    if (this.i8 == 0) goto _label_14;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_14: 
                    this.i1 = (this.i1 + 4);
                    this.i4 = (this.i4 + 1);
                    if (!(this.i4 == 9)) goto _label_13;
                    this.i4 = li32(this.i2);
                    if (this.i4 == 0) goto _label_16;
                    
                _label_15: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i5, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_propagatemark.start();
                    return;
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i4 = li32(this.i2);
                    if (!(this.i4 == 0)) goto _label_15;
                    
                _label_16: 
                    this.i4 = 0;
                    this.i1 = li32(this.i5 + 40);
                    si32(this.i1, this.i2);
                    si32(this.i4, (this.i5 + 40));
                    if (this.i1 == 0) goto _label_18;
                    
                _label_17: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i5, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_propagatemark.start();
                    return;
                case 8:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i4 = li32(this.i2);
                    if (!(this.i4 == 0)) goto _label_17;
                    
                _label_18: 
                    this.i4 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_separateudata.start();
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i5 + 48);
                    this.i1 = (this.i5 + 48);
                    if (this.i4 == 0) goto _label_20;
                    this.i7 = (this.i5 + 20);
                    
                _label_19: 
                    this.i4 = li32(this.i4);
                    this.i8 = li8(this.i4 + 5);
                    this.i9 = li8(this.i7);
                    this.i8 = (this.i8 & 0xFFFFFFF8);
                    this.i9 = (this.i9 & 0x03);
                    this.i8 = (this.i9 | this.i8);
                    si8(this.i8, (this.i4 + 5));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i1);
                    if (!(this.i8 == this.i4)) goto _label_19;
                    
                _label_20: 
                    this.i4 = li32(this.i2);
                    if (this.i4 == 0) goto _label_39;
                    this.i4 = 0;
                    
                _label_21: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i5, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_propagatemark.start();
                    return;
                case 11:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i7 = li32(this.i2);
                    this.i4 = (this.i1 + this.i4);
                    if (this.i7 == 0) goto _label_40;
                    goto _label_21;
                    
                _label_22: 
                    this.i2 = 1;
                    this.i6 = li8(this.i1 + 7);
                    this.i2 = (this.i2 << this.i6);
                    if (this.i2 == 0) goto _label_26;
                    this.i6 = 0;
                    this.i7 = (this.i2 * 28);
                    this.i8 = (this.i1 + 16);
                    
                _label_23: 
                    this.i9 = li32(this.i8);
                    this.i10 = (this.i9 + this.i7);
                    this.i11 = li32(this.i10 + -20);
                    this.i10 = (this.i10 + -20);
                    if (this.i11 == 0) goto _label_25;
                    this.i11 = 1;
                    this.i12 = (this.i7 + this.i9);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i12 = (this.i12 + -16);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_iscleared.start();
                case 12:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i11 == 0)) goto _label_24;
                    this.i11 = 0;
                    this.i12 = (this.i7 + this.i9);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i12 = (this.i12 + -28);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_iscleared.start();
                case 13:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i11 == 0))
                    {
                        
                    _label_24: 
                        this.i11 = 0;
                        this.i9 = (this.i9 + this.i7);
                        si32(this.i11, this.i10);
                        this.i10 = li32(this.i9 + -8);
                        this.i9 = (this.i9 + -8);
                        if (!(this.i10 < 4))
                        {
                            this.i10 = 11;
                            si32(this.i10, this.i9);
                        };
                    };
                    
                _label_25: 
                    this.i7 = (this.i7 + -28);
                    this.i6 = (this.i6 + 1);
                    if (!(this.i6 == this.i2)) goto _label_23;
                    
                _label_26: 
                    this.i1 = li32(this.i1 + 24);
                    if (!(this.i1 == 0))
                    {
                        goto _label_41;
                    };
                    
                _label_27: 
                    this.i1 = 0;
                    this.i2 = li8(this.i5 + 20);
                    this.i2 = (this.i2 ^ 0x03);
                    si8(this.i2, (this.i5 + 20));
                    si32(this.i1, (this.i5 + 24));
                    this.i2 = (this.i5 + 28);
                    si32(this.i2, (this.i5 + 32));
                    this.i2 = 2;
                    si8(this.i2, this.i3);
                    this.i0 = (0 - this.i0);
                    this.i3 = li32(this.i5 + 68);
                    this.i0 = (this.i0 - this.i4);
                    this.i0 = (this.i0 + this.i3);
                    si32(this.i0, (this.i5 + 72));
                    goto _label_4;
                    
                _label_28: 
                    this.i4 = -3;
                    this.i1 = li32(this.i5 + 24);
                    this.i2 = li32(this.i5 + 68);
                    this.i6 = li32(this.i5);
                    this.i7 = (this.i1 + 1);
                    si32(this.i7, (this.i5 + 24));
                    this.i1 = (this.i1 << 2);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i6 + this.i1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sweeplist.start();
                    return;
                case 14:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i5 + 24);
                    this.i4 = li32(this.i5 + 8);
                    this.i1 = (this.i5 + 68);
                    if (!(this.i0 < this.i4))
                    {
                        this.i0 = 3;
                        si8(this.i0, this.i3);
                    };
                    this.i0 = 10;
                    this.i3 = li32(this.i5 + 72);
                    this.i4 = li32(this.i1);
                    this.i3 = (this.i3 - this.i2);
                    this.i3 = (this.i3 + this.i4);
                    
                _label_29: 
                    si32(this.i3, (this.i5 + 72));
                    goto _label_38;
                    
                _label_30: 
                    this.i1 = 40;
                    this.i2 = li32(this.i5 + 68);
                    this.i6 = li32(this.i5 + 32);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sweeplist.start();
                    return;
                case 15:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, (this.i5 + 32));
                    this.i1 = li32(this.i1);
                    this.i6 = (this.i5 + 68);
                    if (!(this.i1 == 0)) goto _label_35;
                    this.i1 = li32(this.i4);
                    this.i7 = li32(this.i1 + 8);
                    this.i8 = li32(this.i1 + 4);
                    this.i9 = (this.i7 >> 31);
                    this.i9 = (this.i9 >>> 30);
                    this.i9 = (this.i7 + this.i9);
                    this.i9 = (this.i9 >> 2);
                    if (uint(this.i8) >= uint(this.i9)) goto _label_31;
                    if (this.i7 < 65) goto _label_31;
                    this.i8 = (this.i7 >>> 31);
                    this.i7 = (this.i7 + this.i8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = (this.i7 >> 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_resize.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_31: 
                    this.i7 = li32(this.i1 + 60);
                    this.i8 = (this.i1 + 60);
                    if (uint(this.i7) < uint(65)) goto _label_34;
                    this.i9 = (this.i7 >>> 1);
                    this.i1 = (this.i1 + 52);
                    this.i10 = (this.i9 + 1);
                    if (uint(this.i10) > uint(-3)) goto _label_33;
                    this.i4 = li32(this.i4);
                    this.i10 = li32(this.i1);
                    this.i11 = li32(this.i4 + 12);
                    this.i12 = li32(this.i4 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 17:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i10 == 0)) goto _label_32;
                    if (uint(this.i7) < uint(2)) goto _label_32;
                    this.i11 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_32: 
                    this.i0 = 4;
                    this.i11 = li32(this.i4 + 68);
                    this.i7 = (this.i9 - this.i7);
                    this.i7 = (this.i7 + this.i11);
                    si32(this.i7, (this.i4 + 68));
                    si32(this.i10, this.i1);
                    si32(this.i9, this.i8);
                    si8(this.i0, this.i3);
                    goto _label_35;
                    
                _label_33: 
                    this.i4 = __2E_str149;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 0;
                    si32(this.i0, this.i1);
                    si32(this.i9, this.i8);
                    
                _label_34: 
                    this.i0 = 4;
                    si8(this.i0, this.i3);
                    
                _label_35: 
                    this.i0 = 400;
                    this.i3 = li32(this.i5 + 72);
                    this.i1 = li32(this.i6);
                    this.i3 = (this.i3 - this.i2);
                    this.i3 = (this.i3 + this.i1);
                    goto _label_29;
                    
                _label_36: 
                    this.i1 = li32(this.i5 + 48);
                    if (this.i1 == 0) goto _label_37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_GCTM.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i5 + 72);
                    this.i3 = (this.i5 + 72);
                    if (!(uint(this.i0) > uint(100)))
                    {
                        this.i0 = 100;
                    }
                    else
                    {
                        this.i5 = 100;
                        this.i0 = (this.i0 + -100);
                        si32(this.i0, this.i3);
                        public::mstate.eax = this.i5;
                        goto _label_5;
                        
                    _label_37: 
                        this.i0 = 0;
                        si8(this.i0, this.i3);
                        si32(this.i0, (this.i5 + 76));
                    };
                    
                _label_38: 
                    public::mstate.eax = this.i0;
                    goto _label_5;
                    
                _label_39: 
                    this.i4 = 0;
                    
                _label_40: 
                    this.i1 = li32(this.i6);
                    if (this.i1 == 0) goto _label_27;
                    
                _label_41: 
                    this.i2 = li8(this.i1 + 5);
                    this.i2 = (this.i2 & 0x10);
                    if (this.i2 == 0) goto _label_22;
                    this.i2 = li32(this.i1 + 28);
                    if (this.i2 == 0) goto _label_22;
                    this.i6 = 0;
                    this.i7 = (this.i2 * 12);
                    this.i8 = (this.i1 + 12);
                    
                _label_42: 
                    this.i9 = 0;
                    this.i10 = li32(this.i8);
                    this.i11 = (this.i7 + this.i10);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = (this.i11 + -12);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_iscleared.start();
                case 21:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i9 == 0))
                    {
                        this.i9 = 0;
                        this.i10 = (this.i10 + this.i7);
                        si32(this.i9, (this.i10 + -4));
                    };
                    this.i7 = (this.i7 + -12);
                    this.i6 = (this.i6 + 1);
                    if (this.i6 == this.i2) goto _label_22;
                    goto _label_42;
                default:
                    throw ("Invalid state in _singlestep");
            };
        }


    }
}

