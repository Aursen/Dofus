package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_read_long_string extends Machine 
    {

        public static const intRegCount:int = 17;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var i15:int;
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
            var _local_1:FSM_read_long_string;
            _local_1 = new (FSM_read_long_string)();
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
                    public::mstate.esp = (public::mstate.esp - 200);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i0 + 44);
                    this.i2 = li32(this.i1);
                    this.i3 = (this.i2 + -1);
                    si32(this.i3, this.i1);
                    this.i1 = li32(this.i0 + 44);
                    this.i3 = (this.i0 + 44);
                    this.i4 = li32(public::mstate.ebp + 12);
                    this.i5 = li32(public::mstate.ebp + 16);
                    this.i6 = this.i0;
                    if (!(this.i2 == 0))
                    {
                        this.i2 = li32(this.i1 + 4);
                        this.i7 = li8(this.i2);
                        this.i2 = (this.i2 + 1);
                        si32(this.i2, (this.i1 + 4));
                        si32(this.i7, this.i6);
                        if (this.i7 == 10) goto _label_3;
                        if (this.i7 == 13) goto _label_3;
                        goto _label_4;
                    };
                    this.i2 = (public::mstate.ebp + -200);
                    this.i7 = li32(this.i1 + 16);
                    this.i8 = li32(this.i1 + 8);
                    this.i9 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i2 == 0)))
                    {
                        
                    _label_1: 
                        this.i1 = -1;
                        goto _label_2;
                    };
                    this.i7 = li32(public::mstate.ebp + -200);
                    if (this.i7 == 0) goto _label_1;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i1);
                    si32(this.i2, (this.i1 + 4));
                    this.i7 = li8(this.i2);
                    this.i2 = (this.i2 + 1);
                    si32(this.i2, (this.i1 + 4));
                    this.i1 = this.i7;
                    
                _label_2: 
                    si32(this.i1, this.i6);
                    if (!(this.i1 == 10))
                    {
                        if (!(this.i1 == 13)) goto _label_4;
                    };
                    
                _label_3: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_inclinenumber.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i1 = __2E_str39295;
                    this.i2 = __2E_str38294;
                    this.i1 = ((this.i4 == 0) ? this.i1 : this.i2);
                    this.i2 = (public::mstate.ebp + -192);
                    this.i7 = (this.i0 + 40);
                    this.i8 = (this.i0 + 4);
                    this.i9 = (public::mstate.ebp + -96);
                    this.i10 = (this.i0 + 52);
                    this.i11 = (this.i0 + 48);
                    
                _label_5: 
                    this.i12 = li32(this.i6);
                    if (this.i12 > 12) goto _label_8;
                    if (this.i12 == -1) goto _label_10;
                    if (!(this.i12 == 10))
                    {
                        goto _label_9;
                    };
                    
                _label_6: 
                    if (!(this.i4 == 0)) goto _label_36;
                    
                _label_7: 
                    this.i12 = 10;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_inclinenumber.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i12 = li32(this.i11);
                    this.i13 = 0;
                    si32(this.i13, (this.i12 + 4));
                    this.i12 = li32(this.i6);
                    if (this.i12 > 12) goto _label_25;
                    if (!(this.i12 == -1))
                    {
                        if (this.i12 == 10) goto _label_7;
                        goto _label_26;
                        
                    _label_8: 
                        if (this.i12 == 13) goto _label_6;
                        if (this.i12 == 91) goto _label_11;
                        if (this.i12 == 93) goto _label_19;
                        
                    _label_9: 
                        goto _label_26;
                    };
                    
                _label_10: 
                    this.i12 = 80;
                    this.i13 = li32(this.i10);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = (this.i13 + 16);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = li32(this.i8);
                    this.i13 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i14 = __2E_str15272;
                    this.i15 = (public::mstate.ebp + -192);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i15, (public::mstate.esp + 8));
                    si32(this.i12, (public::mstate.esp + 12));
                    si32(this.i1, (public::mstate.esp + 16));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 7:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i13 = 287;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 8:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i14 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i15 = __2E_str35292;
                    si32(this.i14, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 9:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i12 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i13 = 3;
                    si32(this.i12, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i12 = li32(this.i6);
                    if (!(this.i12 > 12))
                    {
                        if (this.i12 == -1) goto _label_10;
                        if (this.i12 == 10) goto _label_6;
                    }
                    else
                    {
                        if (this.i12 == 13) goto _label_6;
                        if (this.i12 == 91) goto _label_11;
                        if (this.i12 == 93) goto _label_19;
                    };
                    goto _label_26;
                    
                _label_11: 
                    if (!(this.i5 == 0)) goto _label_16;
                    
                _label_12: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_skip_sep.start();
                    return;
                case 11:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i12 == this.i5)) goto _label_5;
                    this.i12 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i12 = li32(this.i3);
                    this.i13 = li32(this.i12);
                    this.i14 = (this.i13 + -1);
                    si32(this.i14, this.i12);
                    this.i12 = li32(this.i3);
                    if (!(!(this.i13 == 0))) goto _label_14;
                    this.i13 = li32(this.i12 + 4);
                    this.i14 = li8(this.i13);
                    this.i13 = (this.i13 + 1);
                    si32(this.i13, (this.i12 + 4));
                    this.i12 = this.i14;
                    
                _label_13: 
                    this.i13 = 80;
                    si32(this.i12, this.i6);
                    this.i12 = li32(this.i10);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i12 = (this.i12 + 16);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 13:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = li32(this.i8);
                    this.i13 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i14 = __2E_str15272;
                    this.i15 = __2E_str40296;
                    this.i16 = (public::mstate.ebp + -96);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i16, (public::mstate.esp + 8));
                    si32(this.i12, (public::mstate.esp + 12));
                    si32(this.i15, (public::mstate.esp + 16));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 14:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i13 = 91;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 15:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i14 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i15 = __2E_str35292;
                    si32(this.i14, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 16:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i12 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i13 = 3;
                    si32(this.i12, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i12 = li32(this.i6);
                    if (!(this.i12 > 12))
                    {
                        if (this.i12 == -1) goto _label_10;
                        if (this.i12 == 10) goto _label_6;
                    }
                    else
                    {
                        if (this.i12 == 13) goto _label_6;
                        if (this.i12 == 91) goto _label_12;
                        if (this.i12 == 93) goto _label_19;
                    };
                    goto _label_26;
                    
                _label_14: 
                    this.i13 = (public::mstate.ebp + -12);
                    this.i14 = li32(this.i12 + 16);
                    this.i15 = li32(this.i12 + 8);
                    this.i16 = li32(this.i12 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i15]());
                    return;
                case 18:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i13 == 0)))
                    {
                        
                    _label_15: 
                        this.i12 = -1;
                        goto _label_13;
                    };
                    this.i14 = li32(public::mstate.ebp + -12);
                    if (this.i14 == 0) goto _label_15;
                    this.i14 = (this.i14 + -1);
                    si32(this.i14, this.i12);
                    si32(this.i13, (this.i12 + 4));
                    this.i14 = li8(this.i13);
                    this.i13 = (this.i13 + 1);
                    si32(this.i13, (this.i12 + 4));
                    this.i12 = this.i14;
                    goto _label_13;
                    
                _label_16: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_skip_sep.start();
                    return;
                case 19:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i12 == this.i5)) goto _label_5;
                    this.i12 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i12 = li32(this.i3);
                    this.i13 = li32(this.i12);
                    this.i14 = (this.i13 + -1);
                    si32(this.i14, this.i12);
                    this.i12 = li32(this.i3);
                    if (!(this.i13 == 0))
                    {
                        this.i13 = li32(this.i12 + 4);
                        this.i14 = li8(this.i13);
                        this.i13 = (this.i13 + 1);
                        si32(this.i13, (this.i12 + 4));
                        si32(this.i14, this.i6);
                        goto _label_5;
                    };
                    this.i13 = (public::mstate.ebp + -8);
                    this.i14 = li32(this.i12 + 16);
                    this.i15 = li32(this.i12 + 8);
                    this.i16 = li32(this.i12 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i15]());
                    return;
                case 21:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i13 == 0)))
                    {
                        
                    _label_17: 
                        this.i12 = -1;
                        goto _label_18;
                    };
                    this.i14 = li32(public::mstate.ebp + -8);
                    if (this.i14 == 0) goto _label_17;
                    this.i14 = (this.i14 + -1);
                    si32(this.i14, this.i12);
                    si32(this.i13, (this.i12 + 4));
                    this.i14 = li8(this.i13);
                    this.i13 = (this.i13 + 1);
                    si32(this.i13, (this.i12 + 4));
                    this.i12 = this.i14;
                    
                _label_18: 
                    si32(this.i12, this.i6);
                    goto _label_5;
                    
                _label_19: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_skip_sep.start();
                    return;
                case 22:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i12 == this.i5)) goto _label_5;
                    this.i1 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i3);
                    this.i2 = li32(this.i1);
                    this.i8 = (this.i2 + -1);
                    si32(this.i8, this.i1);
                    this.i1 = li32(this.i3);
                    if (this.i2 == 0) goto _label_21;
                    this.i2 = li32(this.i1 + 4);
                    this.i3 = li8(this.i2);
                    this.i2 = (this.i2 + 1);
                    si32(this.i2, (this.i1 + 4));
                    si32(this.i3, this.i6);
                    if (this.i4 == 0) goto _label_24;
                    
                _label_20: 
                    this.i1 = li32(this.i11);
                    this.i2 = li32(this.i1);
                    this.i1 = li32(this.i1 + 4);
                    this.i3 = li32(this.i7);
                    this.i6 = (this.i5 << 1);
                    this.i1 = (this.i1 - this.i6);
                    this.i2 = (this.i5 + this.i2);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 + -4);
                    this.i2 = (this.i2 + 2);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 24:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i0 + 36);
                    this.i0 = li32(this.i0 + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_setstr.start();
                    return;
                case 25:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = (this.i0 + 8);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i2 = 1;
                        si32(this.i2, this.i0);
                        si32(this.i2, this.i3);
                    };
                    si32(this.i1, this.i4);
                    goto _label_24;
                    
                _label_21: 
                    this.i2 = (public::mstate.ebp + -4);
                    this.i3 = li32(this.i1 + 16);
                    this.i8 = li32(this.i1 + 8);
                    this.i9 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 26:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i2 == 0)))
                    {
                        
                    _label_22: 
                        this.i1 = -1;
                        goto _label_23;
                    };
                    this.i3 = li32(public::mstate.ebp + -4);
                    if (this.i3 == 0) goto _label_22;
                    this.i3 = (this.i3 + -1);
                    si32(this.i3, this.i1);
                    si32(this.i2, (this.i1 + 4));
                    this.i3 = li8(this.i2);
                    this.i2 = (this.i2 + 1);
                    si32(this.i2, (this.i1 + 4));
                    this.i1 = this.i3;
                    
                _label_23: 
                    si32(this.i1, this.i6);
                    if (!(this.i4 == 0)) goto _label_20;
                    
                _label_24: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_25: 
                    if (this.i12 == 13) goto _label_7;
                    if (this.i12 == 91) goto _label_11;
                    if (this.i12 == 93) goto _label_19;
                    
                _label_26: 
                    if (this.i4 == 0) goto _label_28;
                    
                _label_27: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i12 = li32(this.i3);
                    this.i13 = li32(this.i12);
                    this.i14 = (this.i13 + -1);
                    si32(this.i14, this.i12);
                    this.i12 = li32(this.i3);
                    if (this.i13 == 0) goto _label_33;
                    this.i13 = li32(this.i12 + 4);
                    this.i14 = li8(this.i13);
                    this.i13 = (this.i13 + 1);
                    si32(this.i13, (this.i12 + 4));
                    si32(this.i14, this.i6);
                    if (this.i14 > 12) goto _label_31;
                    if (this.i14 == -1) goto _label_10;
                    if (this.i14 == 10) goto _label_6;
                    goto _label_32;
                    
                _label_28: 
                    this.i12 = li32(this.i3);
                    this.i13 = li32(this.i12);
                    this.i14 = (this.i13 + -1);
                    si32(this.i14, this.i12);
                    this.i12 = li32(this.i3);
                    if (!(this.i13 == 0))
                    {
                        this.i13 = li32(this.i12 + 4);
                        this.i14 = li8(this.i13);
                        this.i13 = (this.i13 + 1);
                        si32(this.i13, (this.i12 + 4));
                        si32(this.i14, this.i6);
                        if (!(this.i14 > 12))
                        {
                            if (this.i14 == -1) goto _label_10;
                            if (this.i14 == 10) goto _label_6;
                            goto _label_28;
                        };
                        if (this.i14 == 13) goto _label_6;
                        if (this.i14 == 91) goto _label_11;
                        if (this.i14 == 93) goto _label_19;
                        goto _label_28;
                    };
                    this.i13 = (public::mstate.ebp + -100);
                    this.i14 = li32(this.i12 + 16);
                    this.i15 = li32(this.i12 + 8);
                    this.i16 = li32(this.i12 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i15]());
                    return;
                case 28:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i13 == 0)))
                    {
                        
                    _label_29: 
                        this.i12 = -1;
                        goto _label_30;
                    };
                    this.i14 = li32(public::mstate.ebp + -100);
                    if (this.i14 == 0) goto _label_29;
                    this.i14 = (this.i14 + -1);
                    si32(this.i14, this.i12);
                    si32(this.i13, (this.i12 + 4));
                    this.i14 = li8(this.i13);
                    this.i13 = (this.i13 + 1);
                    si32(this.i13, (this.i12 + 4));
                    this.i12 = this.i14;
                    
                _label_30: 
                    si32(this.i12, this.i6);
                    if (!(this.i12 > 12))
                    {
                        if (this.i12 == -1) goto _label_10;
                        if (this.i12 == 10) goto _label_6;
                        goto _label_28;
                    };
                    if (this.i12 == 13) goto _label_6;
                    if (this.i12 == 91) goto _label_11;
                    if (this.i12 == 93) goto _label_19;
                    goto _label_28;
                    
                _label_31: 
                    if (this.i14 == 13) goto _label_6;
                    if (this.i14 == 91) goto _label_11;
                    if (this.i14 == 93) goto _label_19;
                    
                _label_32: 
                    this.i12 = this.i14;
                    goto _label_27;
                    
                _label_33: 
                    this.i13 = (public::mstate.ebp + -196);
                    this.i14 = li32(this.i12 + 16);
                    this.i15 = li32(this.i12 + 8);
                    this.i16 = li32(this.i12 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i16, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i15]());
                    return;
                case 29:
                    this.i13 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i13 == 0)))
                    {
                        
                    _label_34: 
                        this.i12 = -1;
                        goto _label_35;
                    };
                    this.i14 = li32(public::mstate.ebp + -196);
                    if (this.i14 == 0) goto _label_34;
                    this.i14 = (this.i14 + -1);
                    si32(this.i14, this.i12);
                    si32(this.i13, (this.i12 + 4));
                    this.i14 = li8(this.i13);
                    this.i13 = (this.i13 + 1);
                    si32(this.i13, (this.i12 + 4));
                    this.i12 = this.i14;
                    
                _label_35: 
                    si32(this.i12, this.i6);
                    if (!(this.i12 > 12))
                    {
                        if (this.i12 == -1) goto _label_10;
                        if (this.i12 == 10) goto _label_6;
                    }
                    else
                    {
                        if (this.i12 == 13) goto _label_6;
                        if (this.i12 == 91) goto _label_11;
                        if (this.i12 == 93) goto _label_19;
                    };
                    goto _label_27;
                    
                _label_36: 
                    this.i12 = 10;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_inclinenumber.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 4);
                    goto _label_5;
                default:
                    throw ("Invalid state in _read_long_string");
            };
        }


    }
} cmodule.lua_wrapper

