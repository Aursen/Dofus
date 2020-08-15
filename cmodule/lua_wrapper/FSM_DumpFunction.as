package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_DumpFunction extends Machine 
    {

        public static const intRegCount:int = 19;
        public static const NumberRegCount:int = 1;

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
            var _local_1:FSM_DumpFunction;
            _local_1 = new (FSM_DumpFunction)();
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
                    public::mstate.esp = (public::mstate.esp - 64);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 32);
                    this.i2 = (this.i0 + 32);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = li32(public::mstate.ebp + 12);
                    if (!(!(this.i1 == this.i4)))
                    {
                        
                    _label_1: 
                        this.i1 = 0;
                        goto _label_2;
                    };
                    this.i4 = li32(this.i3 + 12);
                    if (!(this.i4 == 0)) goto _label_1;
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_DumpString.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i0 + 60);
                    si32(this.i1, (public::mstate.ebp + -52));
                    this.i1 = li32(this.i3 + 16);
                    this.i4 = (this.i3 + 16);
                    if (!(this.i1 == 0)) goto _label_3;
                    this.i1 = 4;
                    this.i5 = li32(this.i3 + 4);
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -52);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i1, this.i4);
                    
                _label_3: 
                    this.i5 = li32(this.i0 + 64);
                    si32(this.i5, (public::mstate.ebp + -32));
                    if (!(this.i1 == 0)) goto _label_4;
                    this.i1 = 4;
                    this.i5 = li32(this.i3 + 4);
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -32);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i1, this.i4);
                    
                _label_4: 
                    this.i5 = li8(this.i0 + 72);
                    si8(this.i5, (public::mstate.ebp + -18));
                    if (!(this.i1 == 0)) goto _label_5;
                    this.i1 = 1;
                    this.i5 = li32(this.i3 + 4);
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -18);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 4:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i1, this.i4);
                    
                _label_5: 
                    this.i5 = li8(this.i0 + 73);
                    si8(this.i5, (public::mstate.ebp + -17));
                    if (!(this.i1 == 0)) goto _label_6;
                    this.i1 = 1;
                    this.i5 = li32(this.i3 + 4);
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -17);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 5:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i1, this.i4);
                    
                _label_6: 
                    this.i5 = li8(this.i0 + 74);
                    si8(this.i5, (public::mstate.ebp + -11));
                    if (!(this.i1 == 0)) goto _label_7;
                    this.i1 = 1;
                    this.i5 = li32(this.i3 + 4);
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -11);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 6:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i1, this.i4);
                    
                _label_7: 
                    this.i5 = li8(this.i0 + 75);
                    si8(this.i5, (public::mstate.ebp + -1));
                    if (!(this.i1 == 0)) goto _label_8;
                    this.i1 = 1;
                    this.i5 = li32(this.i3 + 4);
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -1);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 7:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i1, this.i4);
                    
                _label_8: 
                    this.i1 = li32(this.i0 + 44);
                    this.i5 = li32(this.i0 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_DumpVector.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i0 + 40);
                    si32(this.i1, (public::mstate.ebp + -8));
                    this.i5 = li32(this.i4);
                    if (!(this.i5 == 0)) goto _label_9;
                    this.i5 = 4;
                    this.i6 = li32(this.i3 + 4);
                    this.i7 = li32(this.i3 + 8);
                    this.i8 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (public::mstate.ebp + -8);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 9:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i5, this.i4);
                    
                _label_9: 
                    if (this.i1 < 1) goto _label_17;
                    this.i5 = 0;
                    this.i6 = (this.i3 + 8);
                    this.i7 = (this.i3 + 4);
                    this.i8 = (public::mstate.ebp + -64);
                    this.i9 = (this.i0 + 8);
                    this.i10 = this.i3;
                    
                _label_10: 
                    this.i11 = li32(this.i9);
                    this.i12 = (this.i5 * 12);
                    this.i12 = (this.i11 + this.i12);
                    this.i13 = li8(this.i12 + 8);
                    si8(this.i13, (public::mstate.ebp + -9));
                    this.i13 = li32(this.i4);
                    this.i14 = (this.i12 + 8);
                    if (!(this.i13 == 0)) goto _label_11;
                    this.i13 = 1;
                    this.i15 = li32(this.i7);
                    this.i16 = li32(this.i6);
                    this.i17 = li32(this.i10);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i18 = (public::mstate.ebp + -9);
                    si32(this.i17, public::mstate.esp);
                    si32(this.i18, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i16, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i15]());
                    return;
                case 10:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i13, this.i4);
                    
                _label_11: 
                    this.i14 = li32(this.i14);
                    if (this.i14 == 4) goto _label_15;
                    if (this.i14 == 3) goto _label_13;
                    if (!(this.i14 == 1)) goto _label_16;
                    this.i11 = li8(this.i12);
                    si8(this.i11, (public::mstate.ebp + -10));
                    if (!(this.i13 == 0)) goto _label_12;
                    this.i11 = 1;
                    this.i12 = li32(this.i7);
                    this.i13 = li32(this.i6);
                    this.i14 = li32(this.i10);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i15 = (public::mstate.ebp + -10);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i12]());
                    return;
                case 11:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i11, this.i4);
                    
                _label_12: 
                    this.i5 = (this.i5 + 1);
                    if (this.i5 >= this.i1) goto _label_17;
                    goto _label_10;
                    
                _label_13: 
                    this.i12 = (this.i5 * 12);
                    this.i12 = (this.i11 + this.i12);
                    this.f0 = lf64(this.i12);
                    sf64(this.f0, (public::mstate.ebp + -64));
                    if (!(this.i13 == 0)) goto _label_14;
                    this.i12 = 8;
                    this.i11 = li32(this.i7);
                    this.i13 = li32(this.i6);
                    this.i14 = li32(this.i10);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 12:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i12, this.i4);
                    
                _label_14: 
                    this.i5 = (this.i5 + 1);
                    if (this.i5 >= this.i1) goto _label_17;
                    goto _label_10;
                    
                _label_15: 
                    this.i11 = li32(this.i12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_DumpString.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_16: 
                    this.i5 = (this.i5 + 1);
                    if (!(this.i5 >= this.i1)) goto _label_10;
                    
                _label_17: 
                    this.i1 = li32(this.i0 + 52);
                    si32(this.i1, (public::mstate.ebp + -16));
                    this.i5 = li32(this.i4);
                    if (!(this.i5 == 0)) goto _label_18;
                    this.i5 = 4;
                    this.i6 = li32(this.i3 + 4);
                    this.i7 = li32(this.i3 + 8);
                    this.i8 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (public::mstate.ebp + -16);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 14:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i5, this.i4);
                    
                _label_18: 
                    if (this.i1 < 1) goto _label_20;
                    this.i5 = 0;
                    this.i6 = (this.i0 + 16);
                    this.i7 = this.i5;
                    
                _label_19: 
                    this.i8 = li32(this.i6);
                    this.i8 = (this.i8 + this.i7);
                    this.i9 = li32(this.i2);
                    this.i8 = li32(this.i8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_DumpFunction.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = (this.i7 + 4);
                    this.i5 = (this.i5 + 1);
                    if (!(this.i5 == this.i1)) goto _label_19;
                    
                _label_20: 
                    this.i1 = li32(this.i3 + 12);
                    this.i2 = (this.i3 + 12);
                    if (!(this.i1 == 0))
                    {
                        this.i1 = 0;
                    }
                    else
                    {
                        this.i1 = li32(this.i0 + 48);
                    };
                    this.i5 = li32(this.i0 + 20);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_DumpVector.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i2);
                    if (!(this.i1 == 0)) goto _label_22;
                    this.i1 = li32(this.i0 + 56);
                    si32(this.i1, (public::mstate.ebp + -24));
                    this.i5 = li32(this.i4);
                    if (!(this.i5 == 0)) goto _label_21;
                    this.i5 = 4;
                    this.i6 = li32(this.i3 + 4);
                    this.i7 = li32(this.i3 + 8);
                    this.i8 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (public::mstate.ebp + -24);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 17:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i5, this.i4);
                    
                _label_21: 
                    if (this.i1 > 0) goto _label_23;
                    this.i1 = this.i5;
                    goto _label_27;
                    
                _label_22: 
                    this.i1 = 0;
                    si32(this.i1, (public::mstate.ebp + -28));
                    this.i1 = li32(this.i4);
                    if (!(this.i1 == 0)) goto _label_27;
                    this.i1 = 4;
                    this.i5 = li32(this.i3 + 4);
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -28);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 18:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i1, this.i4);
                    goto _label_27;
                    
                _label_23: 
                    this.i5 = 0;
                    this.i6 = (public::mstate.ebp + -40);
                    this.i7 = (this.i3 + 8);
                    this.i8 = (this.i3 + 4);
                    this.i9 = (public::mstate.ebp + -36);
                    this.i10 = (this.i0 + 24);
                    this.i11 = this.i3;
                    this.i12 = this.i5;
                    
                _label_24: 
                    this.i13 = li32(this.i10);
                    this.i13 = (this.i13 + this.i12);
                    this.i13 = li32(this.i13);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_DumpString.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i13 = li32(this.i10);
                    this.i13 = (this.i13 + this.i12);
                    this.i13 = li32(this.i13 + 4);
                    si32(this.i13, (public::mstate.ebp + -36));
                    this.i13 = li32(this.i4);
                    if (!(this.i13 == 0)) goto _label_25;
                    this.i13 = 4;
                    this.i14 = li32(this.i8);
                    this.i15 = li32(this.i7);
                    this.i16 = li32(this.i11);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i16, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i15, (public::mstate.esp + 12));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i14]());
                    return;
                case 20:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i13, this.i4);
                    
                _label_25: 
                    this.i14 = li32(this.i10);
                    this.i14 = (this.i14 + this.i12);
                    this.i14 = li32(this.i14 + 8);
                    si32(this.i14, (public::mstate.ebp + -40));
                    if (!(this.i13 == 0)) goto _label_26;
                    this.i13 = 4;
                    this.i14 = li32(this.i8);
                    this.i15 = li32(this.i7);
                    this.i16 = li32(this.i11);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i16, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i15, (public::mstate.esp + 12));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i14]());
                    return;
                case 21:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i13, this.i4);
                    
                _label_26: 
                    this.i12 = (this.i12 + 12);
                    this.i5 = (this.i5 + 1);
                    if (!(this.i5 == this.i1)) goto _label_24;
                    this.i1 = this.i13;
                    
                _label_27: 
                    this.i2 = li32(this.i2);
                    if (!(this.i2 == 0)) goto _label_30;
                    this.i2 = li32(this.i0 + 36);
                    si32(this.i2, (public::mstate.ebp + -44));
                    if (!(this.i1 == 0)) goto _label_28;
                    this.i1 = 4;
                    this.i5 = li32(this.i3 + 4);
                    this.i6 = li32(this.i3 + 8);
                    this.i7 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -44);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i5]());
                    return;
                case 22:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i1, this.i4);
                    
                _label_28: 
                    //unresolved if
                    this.i1 = 0;
                    this.i4 = (this.i0 + 28);
                    this.i0 = this.i1;
                    
                _label_29: 
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + this.i0);
                    this.i5 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_DumpString.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = (this.i0 + 4);
                    this.i1 = (this.i1 + 1);
                    //unresolved if
                    goto _label_29;
                    
                _label_30: 
                    this.i0 = 0;
                    si32(this.i0, (public::mstate.ebp + -48));
                    if (!(this.i1 == 0)) goto _label_31;
                    this.i0 = 4;
                    this.i1 = li32(this.i3 + 4);
                    this.i2 = li32(this.i3 + 8);
                    this.i3 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (public::mstate.ebp + -48);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i1]());
                    return;
                case 24:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i0, this.i4);
                    do 
                    {
                        
                    _label_31: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    } while (true);
                default:
                    throw ("Invalid state in _DumpFunction");
            };
        }


    }
}

