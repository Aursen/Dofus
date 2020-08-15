package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_llex extends Machine 
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
            var _local_1:FSM_llex;
            _local_1 = new (FSM_llex)();
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
                    public::mstate.esp = (public::mstate.esp - 436);
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 48);
                    si32(this.i0, (this.i2 + 4));
                    this.i0 = (this.i1 + 44);
                    this.i2 = (this.i1 + 48);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = this.i1;
                    
                _label_1: 
                    this.i5 = li32(this.i4);
                    if (this.i5 > 45) goto _label_6;
                    if (this.i5 > 33) goto _label_3;
                    if (this.i5 == -1) goto _label_138;
                    if (!(this.i5 == 10))
                    {
                        if (!(this.i5 == 13))
                        {
                            goto _label_7;
                        };
                    };
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_inclinenumber.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i5 = li32(this.i4);
                    if (this.i5 > 45) goto _label_13;
                    if (this.i5 > 33) goto _label_12;
                    if (this.i5 == -1) goto _label_138;
                    if (this.i5 == 10) goto _label_2;
                    if (this.i5 == 13) goto _label_2;
                    goto _label_14;
                    
                _label_3: 
                    if (this.i5 == 34) goto _label_63;
                    if (this.i5 == 39) goto _label_63;
                    if (!(this.i5 == 45))
                    {
                        goto _label_7;
                    };
                    
                _label_4: 
                    this.i5 = li32(this.i0);
                    this.i6 = li32(this.i5);
                    this.i7 = (this.i6 + -1);
                    si32(this.i7, this.i5);
                    this.i5 = li32(this.i0);
                    if (this.i6 == 0) goto _label_16;
                    this.i6 = li32(this.i5 + 4);
                    this.i7 = li8(this.i6);
                    this.i6 = (this.i6 + 1);
                    si32(this.i6, (this.i5 + 4));
                    si32(this.i7, this.i4);
                    if (this.i7 == 45) goto _label_19;
                    
                _label_5: 
                    this.i2 = 45;
                    goto _label_139;
                    
                _label_6: 
                    if (!(this.i5 > 61))
                    {
                        if (this.i5 == 46) goto _label_107;
                        if (this.i5 == 60) goto _label_39;
                        if (this.i5 == 61) goto _label_32;
                    }
                    else
                    {
                        if (this.i5 == 62) goto _label_46;
                        if (this.i5 == 91) goto _label_30;
                        if (this.i5 == 126) goto _label_56;
                    };
                    
                _label_7: 
                    this.i6 = this.i5;
                    
                _label_8: 
                    if (uint(this.i5) < uint(0x0100)) goto _label_117;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i5, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM____runetype.start();
                case 2:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i5 = (this.i5 & 0x4000);
                    if (!(this.i5 == 0))
                    {
                        goto _label_118;
                    };
                    
                _label_9: 
                    if (!(uint(this.i6) > uint(0xFF)))
                    {
                        this.i5 = __DefaultRuneLocale;
                        this.i7 = (this.i6 << 2);
                        this.i5 = (this.i5 + this.i7);
                        this.i5 = li32(this.i5 + 52);
                        this.i5 = (this.i5 & 0x0400);
                        if (!(this.i5 == 0)) goto _label_125;
                        if (!(uint(this.i6) > uint(0xFF))) goto _label_126;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i6, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM____runetype.start();
                case 3:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i5 = (this.i5 & 0x0100);
                    if (!(this.i6 == 95))
                    {
                        if (this.i5 == 0) goto _label_127;
                    };
                    
                _label_10: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i0);
                    this.i5 = li32(this.i6);
                    this.i7 = (this.i5 + -1);
                    si32(this.i7, this.i6);
                    this.i6 = li32(this.i0);
                    if (this.i5 == 0) goto _label_128;
                    this.i5 = li32(this.i6 + 4);
                    this.i7 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i6 + 4));
                    si32(this.i7, this.i4);
                    this.i6 = this.i7;
                    this.i5 = this.i7;
                    
                _label_11: 
                    this.i7 = li32(__CurrentRuneLocale);
                    this.i5 = (this.i5 << 2);
                    this.i5 = (this.i7 + this.i5);
                    this.i5 = li32(this.i5 + 52);
                    this.i5 = (this.i5 & 0x0500);
                    if (this.i5 == 0) goto _label_131;
                    goto _label_10;
                    
                _label_12: 
                    if (!(this.i5 == 34))
                    {
                        if (!(this.i5 == 39))
                        {
                            if (this.i5 == 45) goto _label_4;
                            goto _label_14;
                            
                        _label_13: 
                            if (!(this.i5 > 61))
                            {
                                if (this.i5 == 46) goto _label_15;
                                if (this.i5 == 60) goto _label_39;
                                if (this.i5 == 61) goto _label_32;
                            }
                            else
                            {
                                if (this.i5 == 62) goto _label_46;
                                if (this.i5 == 91) goto _label_30;
                                if (this.i5 == 126) goto _label_56;
                            };
                            
                        _label_14: 
                            this.i6 = this.i5;
                            goto _label_8;
                            
                        _label_15: 
                            this.i2 = this.i5;
                            goto _label_108;
                        };
                    };
                    goto _label_63;
                    
                _label_16: 
                    this.i6 = (public::mstate.ebp + -436);
                    this.i7 = li32(this.i5 + 16);
                    this.i8 = li32(this.i5 + 8);
                    this.i9 = li32(this.i5 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 5:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i6 == 0)))
                    {
                        
                    _label_17: 
                        this.i5 = -1;
                        goto _label_18;
                    };
                    this.i7 = li32(public::mstate.ebp + -436);
                    if (this.i7 == 0) goto _label_17;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i5);
                    si32(this.i6, (this.i5 + 4));
                    this.i7 = li8(this.i6);
                    this.i6 = (this.i6 + 1);
                    si32(this.i6, (this.i5 + 4));
                    this.i5 = this.i7;
                    
                _label_18: 
                    si32(this.i5, this.i4);
                    if (!(this.i5 == 45)) goto _label_5;
                    
                _label_19: 
                    this.i5 = li32(this.i0);
                    this.i6 = li32(this.i5);
                    this.i7 = (this.i6 + -1);
                    si32(this.i7, this.i5);
                    this.i5 = li32(this.i0);
                    if (!(this.i6 == 0))
                    {
                        this.i6 = li32(this.i5 + 4);
                        this.i7 = li8(this.i6);
                        this.i6 = (this.i6 + 1);
                        si32(this.i6, (this.i5 + 4));
                        si32(this.i7, this.i4);
                        if (this.i7 == 91) goto _label_22;
                        goto _label_28;
                    };
                    this.i6 = (public::mstate.ebp + -428);
                    this.i7 = li32(this.i5 + 16);
                    this.i8 = li32(this.i5 + 8);
                    this.i9 = li32(this.i5 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 6:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i6 == 0)))
                    {
                        
                    _label_20: 
                        this.i5 = -1;
                        goto _label_21;
                    };
                    this.i7 = li32(public::mstate.ebp + -428);
                    if (this.i7 == 0) goto _label_20;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i5);
                    si32(this.i6, (this.i5 + 4));
                    this.i7 = li8(this.i6);
                    this.i6 = (this.i6 + 1);
                    si32(this.i6, (this.i5 + 4));
                    this.i5 = this.i7;
                    
                _label_21: 
                    si32(this.i5, this.i4);
                    if (!(this.i5 == 91)) goto _label_28;
                    
                _label_22: 
                    this.i5 = 0;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_skip_sep.start();
                    return;
                case 7:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i7 = li32(this.i2);
                    si32(this.i5, (this.i7 + 4));
                    if (this.i6 < 0) goto _label_28;
                    this.i5 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_read_long_string.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i2);
                    si32(this.i5, (this.i6 + 4));
                    this.i5 = li32(this.i4);
                    if (!(this.i5 > 45))
                    {
                        if (!(this.i5 > 33))
                        {
                            if (this.i5 == -1) goto _label_138;
                            if (this.i5 == 10) goto _label_2;
                            if (this.i5 == 13) goto _label_2;
                        }
                        else
                        {
                            if (this.i5 == 34) goto _label_24;
                            if (this.i5 == 39) goto _label_24;
                            if (this.i5 == 45) goto _label_4;
                        };
                    }
                    else
                    {
                        if (!(this.i5 > 61))
                        {
                            if (this.i5 == 46) goto _label_23;
                            if (this.i5 == 60) goto _label_39;
                            if (this.i5 == 61) goto _label_32;
                        }
                        else
                        {
                            if (this.i5 == 62) goto _label_46;
                            if (this.i5 == 91) goto _label_30;
                            if (this.i5 == 126) goto _label_56;
                        };
                    };
                    this.i6 = this.i5;
                    goto _label_8;
                    
                _label_23: 
                    this.i2 = this.i5;
                    goto _label_108;
                    
                _label_24: 
                    goto _label_63;
                    
                _label_25: 
                    this.i5 = li32(this.i0);
                    this.i6 = li32(this.i5);
                    this.i7 = (this.i6 + -1);
                    si32(this.i7, this.i5);
                    this.i5 = li32(this.i0);
                    if (!(this.i6 == 0))
                    {
                        this.i6 = li32(this.i5 + 4);
                        this.i7 = li8(this.i6);
                        this.i6 = (this.i6 + 1);
                        si32(this.i6, (this.i5 + 4));
                        si32(this.i7, this.i4);
                        if (this.i7 == 10) goto _label_1;
                        if (this.i7 == 13) goto _label_1;
                        this.i5 = this.i7;
                        goto _label_29;
                    };
                    this.i6 = (public::mstate.ebp + -420);
                    this.i7 = li32(this.i5 + 16);
                    this.i8 = li32(this.i5 + 8);
                    this.i9 = li32(this.i5 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 9:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i6 == 0)))
                    {
                        
                    _label_26: 
                        this.i5 = -1;
                        goto _label_27;
                    };
                    this.i7 = li32(public::mstate.ebp + -420);
                    if (this.i7 == 0) goto _label_26;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i5);
                    si32(this.i6, (this.i5 + 4));
                    this.i7 = li8(this.i6);
                    this.i6 = (this.i6 + 1);
                    si32(this.i6, (this.i5 + 4));
                    this.i5 = this.i7;
                    
                _label_27: 
                    si32(this.i5, this.i4);
                    
                _label_28: 
                    this.i5 = li32(this.i4);
                    if (this.i5 == 10) goto _label_1;
                    if (this.i5 == 13) goto _label_1;
                    
                _label_29: 
                    if (this.i5 == -1) goto _label_1;
                    goto _label_25;
                    
                _label_30: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_skip_sep.start();
                    return;
                case 10:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i5 < 0) goto _label_31;
                    this.i2 = 286;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_read_long_string.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_132;
                    
                _label_31: 
                    if (!(!(this.i5 == -1)))
                    {
                        this.i2 = 91;
                        goto _label_139;
                    };
                    this.i5 = 80;
                    this.i3 = li32(this.i1 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (public::mstate.ebp + -416);
                    this.i3 = (this.i3 + 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 12:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(this.i1 + 4);
                    this.i3 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i7 = __2E_str15272;
                    this.i8 = __2E_str44299;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i8, (public::mstate.esp + 16));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 13:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i2);
                    this.i2 = li32(this.i2);
                    this.i3 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = __2E_str35292;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 15:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_32: 
                    this.i2 = li32(this.i0);
                    this.i5 = li32(this.i2);
                    this.i1 = (this.i5 + -1);
                    si32(this.i1, this.i2);
                    this.i2 = li32(this.i0);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = li32(this.i2 + 4);
                        this.i1 = li8(this.i5);
                        this.i5 = (this.i5 + 1);
                        si32(this.i5, (this.i2 + 4));
                        si32(this.i1, this.i4);
                        if (this.i1 == 61) goto _label_36;
                        
                    _label_33: 
                        this.i2 = 61;
                        goto _label_139;
                    };
                    this.i5 = (public::mstate.ebp + -328);
                    this.i1 = li32(this.i2 + 16);
                    this.i3 = li32(this.i2 + 8);
                    this.i6 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i3]());
                    return;
                case 17:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_34: 
                        this.i2 = -1;
                        goto _label_35;
                    };
                    this.i1 = li32(public::mstate.ebp + -328);
                    if (this.i1 == 0) goto _label_34;
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, this.i2);
                    si32(this.i5, (this.i2 + 4));
                    this.i1 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i2 + 4));
                    this.i2 = this.i1;
                    
                _label_35: 
                    si32(this.i2, this.i4);
                    if (!(this.i2 == 61)) goto _label_33;
                    
                _label_36: 
                    this.i2 = li32(this.i0);
                    this.i5 = li32(this.i2);
                    this.i1 = (this.i5 + -1);
                    si32(this.i1, this.i2);
                    this.i2 = li32(this.i0);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = 280;
                        goto _label_51;
                    };
                    this.i5 = (public::mstate.ebp + -320);
                    this.i0 = li32(this.i2 + 16);
                    this.i1 = li32(this.i2 + 8);
                    this.i3 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i1]());
                    return;
                case 18:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_37: 
                        this.i2 = -1;
                        goto _label_38;
                    };
                    this.i0 = li32(public::mstate.ebp + -320);
                    if (this.i0 == 0) goto _label_37;
                    this.i0 = (this.i0 + -1);
                    si32(this.i0, this.i2);
                    si32(this.i5, (this.i2 + 4));
                    this.i0 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i2 + 4));
                    this.i2 = this.i0;
                    
                _label_38: 
                    this.i5 = 280;
                    goto _label_54;
                    
                _label_39: 
                    this.i2 = li32(this.i0);
                    this.i5 = li32(this.i2);
                    this.i1 = (this.i5 + -1);
                    si32(this.i1, this.i2);
                    this.i2 = li32(this.i0);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = li32(this.i2 + 4);
                        this.i1 = li8(this.i5);
                        this.i5 = (this.i5 + 1);
                        si32(this.i5, (this.i2 + 4));
                        si32(this.i1, this.i4);
                        if (this.i1 == 61) goto _label_43;
                        
                    _label_40: 
                        this.i2 = 60;
                        goto _label_139;
                    };
                    this.i5 = (public::mstate.ebp + -316);
                    this.i1 = li32(this.i2 + 16);
                    this.i3 = li32(this.i2 + 8);
                    this.i6 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i3]());
                    return;
                case 19:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_41: 
                        this.i2 = -1;
                        goto _label_42;
                    };
                    this.i1 = li32(public::mstate.ebp + -316);
                    if (this.i1 == 0) goto _label_41;
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, this.i2);
                    si32(this.i5, (this.i2 + 4));
                    this.i1 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i2 + 4));
                    this.i2 = this.i1;
                    
                _label_42: 
                    si32(this.i2, this.i4);
                    if (!(this.i2 == 61)) goto _label_40;
                    
                _label_43: 
                    this.i2 = li32(this.i0);
                    this.i5 = li32(this.i2);
                    this.i1 = (this.i5 + -1);
                    si32(this.i1, this.i2);
                    this.i2 = li32(this.i0);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = 282;
                        goto _label_51;
                    };
                    this.i5 = (public::mstate.ebp + -312);
                    this.i0 = li32(this.i2 + 16);
                    this.i1 = li32(this.i2 + 8);
                    this.i3 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i1]());
                    return;
                case 20:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_44: 
                        this.i2 = -1;
                        goto _label_45;
                    };
                    this.i0 = li32(public::mstate.ebp + -312);
                    if (this.i0 == 0) goto _label_44;
                    this.i0 = (this.i0 + -1);
                    si32(this.i0, this.i2);
                    si32(this.i5, (this.i2 + 4));
                    this.i0 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i2 + 4));
                    this.i2 = this.i0;
                    
                _label_45: 
                    this.i5 = 282;
                    goto _label_54;
                    
                _label_46: 
                    this.i2 = li32(this.i0);
                    this.i5 = li32(this.i2);
                    this.i1 = (this.i5 + -1);
                    si32(this.i1, this.i2);
                    this.i2 = li32(this.i0);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = li32(this.i2 + 4);
                        this.i1 = li8(this.i5);
                        this.i5 = (this.i5 + 1);
                        si32(this.i5, (this.i2 + 4));
                        si32(this.i1, this.i4);
                        if (this.i1 == 61) goto _label_50;
                        
                    _label_47: 
                        this.i2 = 62;
                        goto _label_139;
                    };
                    this.i5 = (public::mstate.ebp + -308);
                    this.i1 = li32(this.i2 + 16);
                    this.i3 = li32(this.i2 + 8);
                    this.i6 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i3]());
                    return;
                case 21:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_48: 
                        this.i2 = -1;
                        goto _label_49;
                    };
                    this.i1 = li32(public::mstate.ebp + -308);
                    if (this.i1 == 0) goto _label_48;
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, this.i2);
                    si32(this.i5, (this.i2 + 4));
                    this.i1 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i2 + 4));
                    this.i2 = this.i1;
                    
                _label_49: 
                    si32(this.i2, this.i4);
                    if (!(this.i2 == 61)) goto _label_47;
                    
                _label_50: 
                    this.i2 = li32(this.i0);
                    this.i5 = li32(this.i2);
                    this.i1 = (this.i5 + -1);
                    si32(this.i1, this.i2);
                    this.i2 = li32(this.i0);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = 281;
                        
                    _label_51: 
                        this.i0 = li32(this.i2 + 4);
                        this.i1 = li8(this.i0);
                        this.i0 = (this.i0 + 1);
                        si32(this.i0, (this.i2 + 4));
                        si32(this.i1, this.i4);
                        goto _label_55;
                    };
                    this.i5 = (public::mstate.ebp + -300);
                    this.i0 = li32(this.i2 + 16);
                    this.i1 = li32(this.i2 + 8);
                    this.i3 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i1]());
                    return;
                case 22:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_52: 
                        this.i2 = -1;
                        goto _label_53;
                    };
                    this.i0 = li32(public::mstate.ebp + -300);
                    if (this.i0 == 0) goto _label_52;
                    this.i0 = (this.i0 + -1);
                    si32(this.i0, this.i2);
                    si32(this.i5, (this.i2 + 4));
                    this.i0 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i2 + 4));
                    this.i2 = this.i0;
                    
                _label_53: 
                    this.i5 = 281;
                    
                _label_54: 
                    si32(this.i2, this.i4);
                    
                _label_55: 
                    public::mstate.eax = this.i5;
                    goto _label_137;
                    
                _label_56: 
                    this.i2 = li32(this.i0);
                    this.i5 = li32(this.i2);
                    this.i1 = (this.i5 + -1);
                    si32(this.i1, this.i2);
                    this.i2 = li32(this.i0);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = li32(this.i2 + 4);
                        this.i1 = li8(this.i5);
                        this.i5 = (this.i5 + 1);
                        si32(this.i5, (this.i2 + 4));
                        si32(this.i1, this.i4);
                        if (this.i1 == 61) goto _label_60;
                        
                    _label_57: 
                        this.i2 = 126;
                        goto _label_139;
                    };
                    this.i5 = (public::mstate.ebp + -296);
                    this.i1 = li32(this.i2 + 16);
                    this.i3 = li32(this.i2 + 8);
                    this.i6 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i3]());
                    return;
                case 23:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_58: 
                        this.i2 = -1;
                        goto _label_59;
                    };
                    this.i1 = li32(public::mstate.ebp + -296);
                    if (this.i1 == 0) goto _label_58;
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, this.i2);
                    si32(this.i5, (this.i2 + 4));
                    this.i1 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i2 + 4));
                    this.i2 = this.i1;
                    
                _label_59: 
                    si32(this.i2, this.i4);
                    if (!(this.i2 == 61)) goto _label_57;
                    
                _label_60: 
                    this.i2 = li32(this.i0);
                    this.i5 = li32(this.i2);
                    this.i1 = (this.i5 + -1);
                    si32(this.i1, this.i2);
                    this.i2 = li32(this.i0);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = 283;
                        goto _label_51;
                    };
                    this.i5 = (public::mstate.ebp + -288);
                    this.i0 = li32(this.i2 + 16);
                    this.i1 = li32(this.i2 + 8);
                    this.i3 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i1]());
                    return;
                case 24:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_61: 
                        this.i2 = -1;
                        goto _label_62;
                    };
                    this.i0 = li32(public::mstate.ebp + -288);
                    if (this.i0 == 0) goto _label_61;
                    this.i0 = (this.i0 + -1);
                    si32(this.i0, this.i2);
                    si32(this.i5, (this.i2 + 4));
                    this.i0 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i2 + 4));
                    this.i2 = this.i0;
                    
                _label_62: 
                    this.i5 = 283;
                    goto _label_54;
                    
                _label_63: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i0);
                    this.i7 = li32(this.i6);
                    this.i8 = (this.i7 + -1);
                    si32(this.i8, this.i6);
                    this.i6 = li32(this.i0);
                    if (this.i7 == 0) goto _label_67;
                    this.i7 = li32(this.i6 + 4);
                    this.i8 = li8(this.i7);
                    this.i7 = (this.i7 + 1);
                    si32(this.i7, (this.i6 + 4));
                    si32(this.i8, this.i4);
                    if (this.i8 == this.i5) goto _label_66;
                    this.i6 = this.i8;
                    
                _label_64: 
                    if (this.i8 > 12) goto _label_70;
                    if (this.i8 == -1) goto _label_72;
                    if (!(this.i8 == 10))
                    {
                        goto _label_100;
                    };
                    
                _label_65: 
                    this.i6 = 80;
                    this.i8 = li32(this.i1 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (public::mstate.ebp + -192);
                    this.i8 = (this.i8 + 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 26:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i1 + 4);
                    this.i8 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i9 = __2E_str15272;
                    this.i10 = __2E_str45300;
                    si32(this.i8, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    si32(this.i10, (public::mstate.esp + 16));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 27:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i2);
                    this.i8 = li32(this.i8);
                    this.i7 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = __2E_str35292;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 29:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i6 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = 3;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_103;
                    
                _label_66: 
                    this.i5 = this.i8;
                    goto _label_104;
                    
                _label_67: 
                    this.i8 = (public::mstate.ebp + -280);
                    this.i7 = li32(this.i6 + 16);
                    this.i9 = li32(this.i6 + 8);
                    this.i10 = li32(this.i6 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i9]());
                    return;
                case 31:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i8 == 0)))
                    {
                        
                    _label_68: 
                        this.i6 = -1;
                        goto _label_69;
                    };
                    this.i7 = li32(public::mstate.ebp + -280);
                    if (this.i7 == 0) goto _label_68;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i6);
                    si32(this.i8, (this.i6 + 4));
                    this.i7 = li8(this.i8);
                    this.i8 = (this.i8 + 1);
                    si32(this.i8, (this.i6 + 4));
                    this.i6 = this.i7;
                    
                _label_69: 
                    si32(this.i6, this.i4);
                    goto _label_103;
                    
                _label_70: 
                    if (this.i8 == 13) goto _label_65;
                    if (!(this.i8 == 92)) goto _label_100;
                    this.i6 = li32(this.i0);
                    this.i8 = li32(this.i6);
                    this.i7 = (this.i8 + -1);
                    si32(this.i7, this.i6);
                    this.i6 = li32(this.i0);
                    if (this.i8 == 0) goto _label_80;
                    this.i8 = li32(this.i6 + 4);
                    this.i7 = li8(this.i8);
                    this.i8 = (this.i8 + 1);
                    si32(this.i8, (this.i6 + 4));
                    si32(this.i7, this.i4);
                    if (this.i7 > 101) goto _label_75;
                    if (this.i7 > 12) goto _label_73;
                    if (this.i7 == -1) goto _label_103;
                    if (!(this.i7 == 10))
                    {
                        goto _label_77;
                    };
                    
                _label_71: 
                    this.i6 = 10;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_inclinenumber.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 4);
                    goto _label_103;
                    
                _label_72: 
                    this.i6 = 80;
                    this.i8 = li32(this.i1 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (public::mstate.ebp + -272);
                    this.i8 = (this.i8 + 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 34:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i1 + 4);
                    this.i8 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i9 = __2E_str15272;
                    this.i10 = __2E_str45300;
                    si32(this.i8, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    si32(this.i10, (public::mstate.esp + 16));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 35:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = 287;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 36:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = __2E_str35292;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 37:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i6 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = 3;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 38;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 38:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_103;
                    
                _label_73: 
                    if (this.i7 == 13) goto _label_71;
                    if (this.i7 == 97) goto _label_96;
                    if (!(this.i7 == 98))
                    {
                        goto _label_77;
                    };
                    
                _label_74: 
                    this.i6 = 8;
                    goto _label_97;
                    
                _label_75: 
                    if (!(this.i7 > 113))
                    {
                        if (this.i7 == 102) goto _label_83;
                        if (!(this.i7 == 110))
                        {
                            goto _label_77;
                        };
                        
                    _label_76: 
                        this.i6 = 10;
                        goto _label_97;
                    };
                    if (this.i7 == 114) goto _label_84;
                    if (this.i7 == 116) goto _label_85;
                    if (this.i7 == 118) goto _label_86;
                    
                _label_77: 
                    this.i6 = this.i7;
                    
                _label_78: 
                    if (uint(this.i6) > uint(0xFF)) goto _label_87;
                    this.i8 = __DefaultRuneLocale;
                    this.i7 = (this.i6 << 2);
                    this.i8 = (this.i8 + this.i7);
                    this.i8 = li32(this.i8 + 52);
                    this.i8 = (this.i8 & 0x0400);
                    if (this.i8 == 0) goto _label_87;
                    this.i8 = 0;
                    this.i7 = 1;
                    
                _label_79: 
                    this.i9 = li32(this.i0);
                    this.i10 = li32(this.i9);
                    this.i11 = (this.i10 + -1);
                    this.i8 = (this.i8 * 10);
                    si32(this.i11, this.i9);
                    this.i6 = (this.i8 + this.i6);
                    this.i8 = li32(this.i0);
                    this.i9 = (this.i6 + -48);
                    if (this.i10 == 0) goto _label_90;
                    this.i6 = li32(this.i8 + 4);
                    this.i10 = li8(this.i6);
                    this.i6 = (this.i6 + 1);
                    si32(this.i6, (this.i8 + 4));
                    si32(this.i10, this.i4);
                    if (this.i7 > 2) goto _label_94;
                    this.i6 = this.i10;
                    goto _label_93;
                    
                _label_80: 
                    this.i8 = (public::mstate.ebp + -100);
                    this.i7 = li32(this.i6 + 16);
                    this.i9 = li32(this.i6 + 8);
                    this.i10 = li32(this.i6 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i9]());
                    return;
                case 39:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i8 == 0)))
                    {
                        
                    _label_81: 
                        this.i6 = -1;
                        goto _label_82;
                    };
                    this.i7 = li32(public::mstate.ebp + -100);
                    if (this.i7 == 0) goto _label_81;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i6);
                    si32(this.i8, (this.i6 + 4));
                    this.i7 = li8(this.i8);
                    this.i8 = (this.i8 + 1);
                    si32(this.i8, (this.i6 + 4));
                    this.i6 = this.i7;
                    
                _label_82: 
                    si32(this.i6, this.i4);
                    if (!(this.i6 > 101))
                    {
                        if (!(this.i6 > 12))
                        {
                            if (this.i6 == -1) goto _label_103;
                            if (this.i6 == 10) goto _label_71;
                        }
                        else
                        {
                            if (this.i6 == 13) goto _label_71;
                            if (this.i6 == 97) goto _label_96;
                            if (this.i6 == 98) goto _label_74;
                        };
                    }
                    else
                    {
                        if (!(this.i6 > 113))
                        {
                            if (this.i6 == 102) goto _label_83;
                            if (this.i6 == 110) goto _label_76;
                        }
                        else
                        {
                            if (this.i6 == 114) goto _label_84;
                            if (this.i6 == 116) goto _label_85;
                            if (this.i6 == 118) goto _label_86;
                        };
                    };
                    goto _label_78;
                    
                _label_83: 
                    this.i6 = 12;
                    goto _label_97;
                    
                _label_84: 
                    this.i6 = 13;
                    goto _label_97;
                    
                _label_85: 
                    this.i6 = 9;
                    goto _label_97;
                    
                _label_86: 
                    this.i6 = 11;
                    goto _label_97;
                    
                _label_87: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 40:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i0);
                    this.i8 = li32(this.i6);
                    this.i7 = (this.i8 + -1);
                    si32(this.i7, this.i6);
                    this.i6 = li32(this.i0);
                    if (!(this.i8 == 0))
                    {
                        this.i8 = li32(this.i6 + 4);
                        this.i7 = li8(this.i8);
                        this.i8 = (this.i8 + 1);
                        si32(this.i8, (this.i6 + 4));
                        si32(this.i7, this.i4);
                        goto _label_103;
                    };
                    this.i8 = (public::mstate.ebp + -4);
                    this.i7 = li32(this.i6 + 16);
                    this.i9 = li32(this.i6 + 8);
                    this.i10 = li32(this.i6 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i9]());
                    return;
                case 41:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i8 == 0)))
                    {
                        
                    _label_88: 
                        this.i6 = -1;
                        goto _label_89;
                    };
                    this.i7 = li32(public::mstate.ebp + -4);
                    if (this.i7 == 0) goto _label_88;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i6);
                    si32(this.i8, (this.i6 + 4));
                    this.i7 = li8(this.i8);
                    this.i8 = (this.i8 + 1);
                    si32(this.i8, (this.i6 + 4));
                    this.i6 = this.i7;
                    
                _label_89: 
                    si32(this.i6, this.i4);
                    goto _label_103;
                    
                _label_90: 
                    this.i6 = (public::mstate.ebp + -8);
                    this.i10 = li32(this.i8 + 16);
                    this.i11 = li32(this.i8 + 8);
                    this.i12 = li32(this.i8 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 42:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i6 == 0)))
                    {
                        
                    _label_91: 
                        this.i6 = -1;
                        goto _label_92;
                    };
                    this.i10 = li32(public::mstate.ebp + -8);
                    if (this.i10 == 0) goto _label_91;
                    this.i10 = (this.i10 + -1);
                    si32(this.i10, this.i8);
                    si32(this.i6, (this.i8 + 4));
                    this.i10 = li8(this.i6);
                    this.i6 = (this.i6 + 1);
                    si32(this.i6, (this.i8 + 4));
                    this.i6 = this.i10;
                    
                _label_92: 
                    si32(this.i6, this.i4);
                    if (!(this.i7 > 2))
                    {
                        
                    _label_93: 
                        if (!(uint(this.i6) > uint(0xFF)))
                        {
                            this.i8 = __DefaultRuneLocale;
                            this.i10 = (this.i6 << 2);
                            this.i8 = (this.i8 + this.i10);
                            this.i8 = li32(this.i8 + 52);
                            this.i7 = (this.i7 + 1);
                            this.i8 = (this.i8 & 0x0400);
                            if (!(this.i8 == 0))
                            {
                                this.i8 = this.i9;
                                goto _label_79;
                            };
                        };
                    };
                    
                _label_94: 
                    if (this.i9 < 0x0100) goto _label_95;
                    this.i6 = 80;
                    this.i8 = li32(this.i1 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (public::mstate.ebp + -96);
                    this.i8 = (this.i8 + 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 43:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i1 + 4);
                    this.i8 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i10 = __2E_str15272;
                    this.i11 = __2E_str46301;
                    si32(this.i8, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    si32(this.i11, (public::mstate.esp + 16));
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 44:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 45:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i2);
                    this.i8 = li32(this.i8);
                    this.i7 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = __2E_str35292;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 46;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 46:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i6 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = 3;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 47:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 48;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 48:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_103;
                    
                _label_95: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    state = 49;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 49:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_103;
                    
                _label_96: 
                    this.i6 = 7;
                    
                _label_97: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 50;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 50:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i0);
                    this.i8 = li32(this.i6);
                    this.i7 = (this.i8 + -1);
                    si32(this.i7, this.i6);
                    this.i6 = li32(this.i0);
                    if (!(this.i8 == 0))
                    {
                        this.i8 = li32(this.i6 + 4);
                        this.i7 = li8(this.i8);
                        this.i8 = (this.i8 + 1);
                        si32(this.i8, (this.i6 + 4));
                        si32(this.i7, this.i4);
                        goto _label_103;
                    };
                    this.i8 = (public::mstate.ebp + -276);
                    this.i7 = li32(this.i6 + 16);
                    this.i9 = li32(this.i6 + 8);
                    this.i10 = li32(this.i6 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 51;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i9]());
                    return;
                case 51:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i8 == 0)))
                    {
                        
                    _label_98: 
                        this.i6 = -1;
                        goto _label_99;
                    };
                    this.i7 = li32(public::mstate.ebp + -276);
                    if (this.i7 == 0) goto _label_98;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i6);
                    si32(this.i8, (this.i6 + 4));
                    this.i7 = li8(this.i8);
                    this.i8 = (this.i8 + 1);
                    si32(this.i8, (this.i6 + 4));
                    this.i6 = this.i7;
                    
                _label_99: 
                    si32(this.i6, this.i4);
                    goto _label_103;
                    
                _label_100: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 52;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 52:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i0);
                    this.i8 = li32(this.i6);
                    this.i7 = (this.i8 + -1);
                    si32(this.i7, this.i6);
                    this.i6 = li32(this.i0);
                    if (!(this.i8 == 0))
                    {
                        this.i8 = li32(this.i6 + 4);
                        this.i7 = li8(this.i8);
                        this.i8 = (this.i8 + 1);
                        si32(this.i8, (this.i6 + 4));
                        si32(this.i7, this.i4);
                        goto _label_103;
                    };
                    this.i8 = (public::mstate.ebp + -284);
                    this.i7 = li32(this.i6 + 16);
                    this.i9 = li32(this.i6 + 8);
                    this.i10 = li32(this.i6 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 53;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i9]());
                    return;
                case 53:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i8 == 0)))
                    {
                        
                    _label_101: 
                        this.i6 = -1;
                        goto _label_102;
                    };
                    this.i7 = li32(public::mstate.ebp + -284);
                    if (this.i7 == 0) goto _label_101;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i6);
                    si32(this.i8, (this.i6 + 4));
                    this.i7 = li8(this.i8);
                    this.i8 = (this.i8 + 1);
                    si32(this.i8, (this.i6 + 4));
                    this.i6 = this.i7;
                    
                _label_102: 
                    si32(this.i6, this.i4);
                    
                _label_103: 
                    this.i8 = li32(this.i4);
                    if (!(this.i8 == this.i5))
                    {
                        this.i6 = this.i8;
                        goto _label_64;
                    };
                    this.i5 = this.i8;
                    
                _label_104: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 54;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 54:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i0);
                    this.i6 = li32(this.i5);
                    this.i7 = (this.i6 + -1);
                    si32(this.i7, this.i5);
                    this.i5 = li32(this.i0);
                    if (!(this.i6 == 0))
                    {
                        this.i0 = li32(this.i5 + 4);
                        this.i6 = li8(this.i0);
                        this.i0 = (this.i0 + 1);
                        si32(this.i0, (this.i5 + 4));
                        this.i5 = this.i6;
                        goto _label_106;
                    };
                    this.i0 = (public::mstate.ebp + -292);
                    this.i6 = li32(this.i5 + 16);
                    this.i7 = li32(this.i5 + 8);
                    this.i8 = li32(this.i5 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 55;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 55:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i0 == 0)))
                    {
                        
                    _label_105: 
                        this.i5 = -1;
                        goto _label_106;
                    };
                    this.i6 = li32(public::mstate.ebp + -292);
                    if (this.i6 == 0) goto _label_105;
                    this.i6 = (this.i6 + -1);
                    si32(this.i6, this.i5);
                    si32(this.i0, (this.i5 + 4));
                    this.i6 = li8(this.i0);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, (this.i5 + 4));
                    this.i5 = this.i6;
                    
                _label_106: 
                    si32(this.i5, this.i4);
                    this.i2 = li32(this.i2);
                    this.i5 = li32(this.i2 + 4);
                    this.i2 = li32(this.i2);
                    this.i0 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + 1);
                    this.i5 = (this.i5 + -2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 56;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 56:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(this.i1 + 36);
                    this.i5 = li32(this.i5 + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 57;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_setstr.start();
                    return;
                case 57:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i5 + 8);
                    this.i1 = (this.i5 + 8);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = 1;
                        si32(this.i0, this.i5);
                        si32(this.i0, this.i1);
                    };
                    this.i5 = 286;
                    si32(this.i2, this.i3);
                    goto _label_55;
                    
                _label_107: 
                    this.i2 = this.i5;
                    
                _label_108: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 58;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 58:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0);
                    this.i5 = li32(this.i2);
                    this.i6 = (this.i5 + -1);
                    si32(this.i6, this.i2);
                    this.i2 = li32(this.i0);
                    if (this.i5 == 0) goto _label_111;
                    this.i5 = __2E_str20159;
                    this.i0 = li32(this.i2 + 4);
                    this.i6 = li8(this.i0);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, (this.i2 + 4));
                    si32(this.i6, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 59;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_check_next.start();
                    return;
                case 59:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i2 == 0))
                    {
                        goto _label_114;
                    };
                    
                _label_109: 
                    this.i2 = li32(this.i4);
                    if (uint(this.i2) < uint(0x0100)) goto _label_115;
                    
                _label_110: 
                    this.i2 = 46;
                    goto _label_139;
                    
                _label_111: 
                    this.i5 = (public::mstate.ebp + -304);
                    this.i0 = li32(this.i2 + 16);
                    this.i6 = li32(this.i2 + 8);
                    this.i7 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 60;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 60:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_112: 
                        this.i2 = -1;
                        goto _label_113;
                    };
                    this.i0 = li32(public::mstate.ebp + -304);
                    if (this.i0 == 0) goto _label_112;
                    this.i0 = (this.i0 + -1);
                    si32(this.i0, this.i2);
                    si32(this.i5, (this.i2 + 4));
                    this.i0 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i2 + 4));
                    this.i2 = this.i0;
                    
                _label_113: 
                    this.i5 = __2E_str20159;
                    si32(this.i2, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 61;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_check_next.start();
                    return;
                case 61:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i2 == 0) goto _label_109;
                    
                _label_114: 
                    this.i2 = __2E_str20159;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 62;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_check_next.start();
                    return;
                case 62:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = ((this.i2 == 0) ? 278 : 279);
                    goto _label_132;
                    
                _label_115: 
                    this.i5 = __DefaultRuneLocale;
                    this.i2 = (this.i2 << 2);
                    this.i2 = (this.i5 + this.i2);
                    this.i2 = li32(this.i2 + 52);
                    this.i2 = (this.i2 & 0x0400);
                    if (this.i2 == 0) goto _label_110;
                    
                _label_116: 
                    this.i2 = 284;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 63;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_read_numeral.start();
                    return;
                case 63:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_132;
                    
                _label_117: 
                    this.i7 = li32(__CurrentRuneLocale);
                    this.i5 = (this.i5 << 2);
                    this.i5 = (this.i7 + this.i5);
                    this.i5 = li32(this.i5 + 52);
                    this.i5 = (this.i5 & 0x4000);
                    if (this.i5 == 0) goto _label_9;
                    
                _label_118: 
                    this.i5 = li32(this.i0);
                    this.i6 = li32(this.i5);
                    this.i7 = (this.i6 + -1);
                    si32(this.i7, this.i5);
                    this.i5 = li32(this.i0);
                    if (!(this.i6 == 0))
                    {
                        this.i6 = li32(this.i5 + 4);
                        this.i7 = li8(this.i6);
                        this.i6 = (this.i6 + 1);
                        si32(this.i6, (this.i5 + 4));
                        si32(this.i7, this.i4);
                        if (!(this.i7 > 45))
                        {
                            if (!(this.i7 > 33))
                            {
                                if (this.i7 == -1) goto _label_138;
                                if (this.i7 == 10) goto _label_2;
                                if (this.i7 == 13) goto _label_2;
                            }
                            else
                            {
                                if (this.i7 == 34) goto _label_120;
                                if (this.i7 == 39) goto _label_120;
                                if (this.i7 == 45) goto _label_4;
                            };
                        }
                        else
                        {
                            if (!(this.i7 > 61))
                            {
                                if (this.i7 == 46) goto _label_119;
                                if (this.i7 == 60) goto _label_39;
                                if (this.i7 == 61) goto _label_32;
                            }
                            else
                            {
                                if (this.i7 == 62) goto _label_46;
                                if (this.i7 == 91) goto _label_30;
                                if (this.i7 == 126) goto _label_56;
                            };
                        };
                        this.i6 = this.i7;
                        this.i5 = this.i7;
                        goto _label_8;
                        
                    _label_119: 
                        this.i2 = this.i7;
                        goto _label_108;
                        
                    _label_120: 
                        this.i5 = this.i7;
                        goto _label_63;
                    };
                    this.i6 = (public::mstate.ebp + -324);
                    this.i7 = li32(this.i5 + 16);
                    this.i8 = li32(this.i5 + 8);
                    this.i9 = li32(this.i5 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 64;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 64:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i6 == 0)))
                    {
                        
                    _label_121: 
                        this.i5 = -1;
                        goto _label_122;
                    };
                    this.i7 = li32(public::mstate.ebp + -324);
                    if (this.i7 == 0) goto _label_121;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i5);
                    si32(this.i6, (this.i5 + 4));
                    this.i7 = li8(this.i6);
                    this.i6 = (this.i6 + 1);
                    si32(this.i6, (this.i5 + 4));
                    this.i5 = this.i7;
                    
                _label_122: 
                    si32(this.i5, this.i4);
                    if (!(this.i5 > 45))
                    {
                        if (!(this.i5 > 33))
                        {
                            if (this.i5 == -1) goto _label_138;
                            if (this.i5 == 10) goto _label_2;
                            if (this.i5 == 13) goto _label_2;
                        }
                        else
                        {
                            if (this.i5 == 34) goto _label_124;
                            if (this.i5 == 39) goto _label_124;
                            if (this.i5 == 45) goto _label_4;
                        };
                    }
                    else
                    {
                        if (!(this.i5 > 61))
                        {
                            if (this.i5 == 46) goto _label_123;
                            if (this.i5 == 60) goto _label_39;
                            if (this.i5 == 61) goto _label_32;
                        }
                        else
                        {
                            if (this.i5 == 62) goto _label_46;
                            if (this.i5 == 91) goto _label_30;
                            if (this.i5 == 126) goto _label_56;
                        };
                    };
                    this.i6 = this.i5;
                    goto _label_8;
                    
                _label_123: 
                    this.i2 = this.i5;
                    goto _label_108;
                    
                _label_124: 
                    goto _label_63;
                    
                _label_125: 
                    goto _label_116;
                    
                _label_126: 
                    this.i5 = li32(__CurrentRuneLocale);
                    this.i7 = (this.i6 << 2);
                    this.i5 = (this.i5 + this.i7);
                    this.i5 = li32(this.i5 + 52);
                    this.i5 = (this.i5 & 0x0100);
                    //unresolved if
                    //unresolved if
                    
                _label_127: 
                    this.i2 = li32(this.i0);
                    this.i1 = li32(this.i2);
                    this.i3 = (this.i1 + -1);
                    si32(this.i3, this.i2);
                    this.i2 = li32(this.i0);
                    if (this.i1 == 0) goto _label_133;
                    this.i0 = li32(this.i2 + 4);
                    this.i1 = li8(this.i0);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, (this.i2 + 4));
                    si32(this.i1, this.i4);
                    goto _label_136;
                    
                _label_128: 
                    this.i5 = (public::mstate.ebp + -424);
                    this.i7 = li32(this.i6 + 16);
                    this.i8 = li32(this.i6 + 8);
                    this.i9 = li32(this.i6 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 65;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i8]());
                    return;
                case 65:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_129: 
                        this.i6 = -1;
                        goto _label_130;
                    };
                    this.i7 = li32(public::mstate.ebp + -424);
                    if (this.i7 == 0) goto _label_129;
                    this.i7 = (this.i7 + -1);
                    si32(this.i7, this.i6);
                    si32(this.i5, (this.i6 + 4));
                    this.i7 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i6 + 4));
                    this.i6 = this.i7;
                    
                _label_130: 
                    this.i5 = this.i6;
                    si32(this.i5, this.i4);
                    if (!(uint(this.i5) > uint(0xFF)))
                    {
                        this.i6 = this.i5;
                        goto _label_11;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i5, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM____runetype.start();
                case 66:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i6 = (this.i6 & 0x0500);
                    if (!(this.i6 == 0))
                    {
                        this.i6 = this.i5;
                        goto _label_10;
                    };
                    this.i6 = this.i5;
                    
                _label_131: 
                    if (!(!(this.i6 == 95))) goto _label_10;
                    this.i0 = li32(this.i2);
                    this.i2 = li32(this.i0 + 4);
                    this.i0 = li32(this.i0);
                    this.i4 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 67;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 67:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i1 + 36);
                    this.i2 = li32(this.i2 + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 68;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_setstr.start();
                    return;
                case 68:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i2 + 8);
                    this.i6 = (this.i2 + 8);
                    if (!(!(this.i4 == 0)))
                    {
                        this.i4 = 1;
                        si32(this.i4, this.i2);
                        si32(this.i4, this.i6);
                    };
                    this.i2 = li8(this.i0 + 6);
                    if (!(this.i2 == 0))
                    {
                        this.i0 = (this.i2 | 0x0100);
                        this.i0 = (this.i0 & 0x01FF);
                        goto _label_140;
                    };
                    this.i2 = 285;
                    si32(this.i0, this.i3);
                    
                _label_132: 
                    public::mstate.eax = this.i2;
                    goto _label_137;
                    
                _label_133: 
                    this.i0 = (public::mstate.ebp + -432);
                    this.i1 = li32(this.i2 + 16);
                    this.i3 = li32(this.i2 + 8);
                    this.i5 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 69;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i3]());
                    return;
                case 69:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i0 == 0)))
                    {
                        
                    _label_134: 
                        this.i2 = -1;
                        goto _label_135;
                    };
                    this.i1 = li32(public::mstate.ebp + -432);
                    if (this.i1 == 0) goto _label_134;
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, this.i2);
                    si32(this.i0, (this.i2 + 4));
                    this.i1 = li8(this.i0);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, (this.i2 + 4));
                    this.i2 = this.i1;
                    
                _label_135: 
                    si32(this.i2, this.i4);
                    
                _label_136: 
                    public::mstate.eax = this.i6;
                    do 
                    {
                        
                    _label_137: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_138: 
                        this.i2 = 287;
                        
                    _label_139: 
                        this.i0 = this.i2;
                        
                    _label_140: 
                        public::mstate.eax = this.i0;
                    } while (true);
                default:
                    throw ("Invalid state in _llex");
            };
        }


    }
}

