package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_read_numeral extends Machine 
    {

        public static const intRegCount:int = 12;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
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
            var _local_1:FSM_read_numeral;
            _local_1 = new (FSM_read_numeral)();
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
                    public::mstate.esp = (public::mstate.esp - 100);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = (this.i0 + 44);
                    this.i3 = this.i0;
                    
                _label_1: 
                    this.i4 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i2);
                    this.i5 = li32(this.i4);
                    this.i6 = (this.i5 + -1);
                    si32(this.i6, this.i4);
                    this.i4 = li32(this.i2);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = li32(this.i4 + 4);
                        this.i6 = li8(this.i5);
                        this.i5 = (this.i5 + 1);
                        si32(this.i5, (this.i4 + 4));
                        si32(this.i6, this.i3);
                        this.i4 = this.i6;
                        this.i5 = this.i6;
                        goto _label_4;
                    };
                    this.i5 = (public::mstate.ebp + -100);
                    this.i6 = li32(this.i4 + 16);
                    this.i7 = li32(this.i4 + 8);
                    this.i8 = li32(this.i4 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 2:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_2: 
                        this.i4 = -1;
                        goto _label_3;
                    };
                    this.i6 = li32(public::mstate.ebp + -100);
                    if (this.i6 == 0) goto _label_2;
                    this.i6 = (this.i6 + -1);
                    si32(this.i6, this.i4);
                    si32(this.i5, (this.i4 + 4));
                    this.i6 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i4 + 4));
                    this.i4 = this.i6;
                    
                _label_3: 
                    this.i5 = this.i4;
                    si32(this.i5, this.i3);
                    if (uint(this.i5) > uint(0xFF)) goto _label_15;
                    this.i4 = this.i5;
                    
                _label_4: 
                    this.i6 = __DefaultRuneLocale;
                    this.i5 = (this.i5 << 2);
                    this.i5 = (this.i6 + this.i5);
                    this.i5 = li32(this.i5 + 52);
                    this.i5 = (this.i5 & 0x0400);
                    if (!(this.i5 == 0)) goto _label_1;
                    
                _label_5: 
                    if (this.i4 == 46) goto _label_1;
                    this.i4 = __2E_str41297;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_check_next.start();
                    return;
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i4 == 0) goto _label_10;
                    this.i4 = __2E_str42298;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_check_next.start();
                    return;
                case 4:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i3);
                    if (uint(this.i4) > uint(0xFF)) goto _label_16;
                    this.i5 = this.i4;
                    
                _label_6: 
                    this.i6 = li32(__CurrentRuneLocale);
                    this.i4 = (this.i4 << 2);
                    this.i4 = (this.i6 + this.i4);
                    this.i4 = li32(this.i4 + 52);
                    this.i4 = (this.i4 & 0x0500);
                    if (this.i4 == 0) goto _label_12;
                    this.i4 = this.i5;
                    
                _label_7: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i2);
                    this.i5 = li32(this.i4);
                    this.i6 = (this.i5 + -1);
                    si32(this.i6, this.i4);
                    this.i4 = li32(this.i2);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = li32(this.i4 + 4);
                        this.i6 = li8(this.i5);
                        this.i5 = (this.i5 + 1);
                        si32(this.i5, (this.i4 + 4));
                        si32(this.i6, this.i3);
                        this.i5 = this.i6;
                        this.i4 = this.i6;
                        goto _label_6;
                    };
                    this.i5 = (public::mstate.ebp + -4);
                    this.i6 = li32(this.i4 + 16);
                    this.i7 = li32(this.i4 + 8);
                    this.i8 = li32(this.i4 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i7]());
                    return;
                case 6:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i5 == 0)))
                    {
                        
                    _label_8: 
                        this.i4 = -1;
                        goto _label_9;
                    };
                    this.i6 = li32(public::mstate.ebp + -4);
                    if (this.i6 == 0) goto _label_8;
                    this.i6 = (this.i6 + -1);
                    si32(this.i6, this.i4);
                    si32(this.i5, (this.i4 + 4));
                    this.i6 = li8(this.i5);
                    this.i5 = (this.i5 + 1);
                    si32(this.i5, (this.i4 + 4));
                    this.i4 = this.i6;
                    
                _label_9: 
                    si32(this.i4, this.i3);
                    
                _label_10: 
                    this.i4 = li32(this.i3);
                    if (!(uint(this.i4) > uint(0xFF)))
                    {
                        this.i5 = this.i4;
                        goto _label_6;
                    };
                    this.i5 = this.i4;
                    
                _label_11: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM____runetype.start();
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i4 = (this.i4 & 0x0500);
                    if (!(this.i4 == 0))
                    {
                        this.i4 = this.i5;
                        goto _label_7;
                    };
                    this.i4 = this.i5;
                    goto _label_13;
                    
                _label_12: 
                    this.i4 = this.i5;
                    
                _label_13: 
                    if (!(!(this.i4 == 95))) goto _label_7;
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 48);
                    this.i3 = li8(this.i0 + 56);
                    this.i4 = li32(this.i2 + 4);
                    this.i2 = li32(this.i2);
                    this.i5 = (this.i0 + 48);
                    this.i6 = (this.i0 + 56);
                    if (!(this.i4 == 0))
                    {
                        this.i7 = 0;
                        this.i2 = (this.i2 + this.i4);
                        this.i2 = (this.i2 + -1);
                        do 
                        {
                            this.i8 = li8(this.i2);
                            this.i9 = this.i2;
                            if (!(!(this.i8 == 46)))
                            {
                                si8(this.i3, this.i9);
                            };
                            this.i2 = (this.i2 + -1);
                            this.i7 = (this.i7 + 1);
                        } while (!(this.i7 == this.i4));
                    };
                    this.i2 = li32(this.i5);
                    this.i2 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_str2d.start();
                    return;
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i2 == 0)) goto _label_14;
                    this.i2 = li8(___mlocale_changed_2E_b);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i2 = 1;
                        si8(this.i2, ___mlocale_changed_2E_b);
                    };
                    this.i2 = li8(___nlocale_changed_2E_b);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i2 = __C_numeric_locale;
                        this.i3 = li32(__numeric_using_locale);
                        this.i4 = __numeric_locale;
                        this.i2 = ((this.i3 == 0) ? this.i2 : this.i4);
                        this.i3 = li32(this.i2);
                        si32(this.i3, _ret_2E_1494_2E_0);
                        this.i3 = li32(this.i2 + 4);
                        si32(this.i3, _ret_2E_1494_2E_1);
                        this.i2 = li32(this.i2 + 8);
                        si32(this.i2, _ret_2E_1494_2E_2);
                        this.i2 = 1;
                        si8(this.i2, ___nlocale_changed_2E_b);
                    };
                    this.i2 = li32(_ret_2E_1494_2E_0);
                    this.i3 = li8(this.i6);
                    this.i2 = li8(this.i2);
                    si8(this.i2, this.i6);
                    this.i4 = li32(this.i5);
                    this.i7 = li32(this.i4 + 4);
                    this.i4 = li32(this.i4);
                    if (!(this.i7 == 0))
                    {
                        this.i8 = 0;
                        this.i4 = (this.i4 + this.i7);
                        this.i4 = (this.i4 + -1);
                        do 
                        {
                            this.i9 = li8(this.i4);
                            this.i10 = (this.i3 & 0xFF);
                            this.i11 = this.i4;
                            if (!(!(this.i9 == this.i10)))
                            {
                                si8(this.i2, this.i11);
                            };
                            this.i4 = (this.i4 + -1);
                            this.i8 = (this.i8 + 1);
                        } while (!(this.i8 == this.i7));
                    };
                    this.i2 = li32(this.i5);
                    this.i2 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_str2d.start();
                    return;
                case 10:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i1 == 0)) goto _label_14;
                    this.i1 = li32(this.i5);
                    this.i2 = li8(this.i6);
                    this.i3 = li32(this.i1 + 4);
                    this.i1 = li32(this.i1);
                    if (!(this.i3 == 0))
                    {
                        this.i4 = 0;
                        this.i1 = (this.i1 + this.i3);
                        this.i1 = (this.i1 + -1);
                        do 
                        {
                            this.i6 = li8(this.i1);
                            this.i7 = (this.i2 & 0xFF);
                            this.i8 = this.i1;
                            if (!(!(this.i6 == this.i7)))
                            {
                                this.i6 = 46;
                                si8(this.i6, this.i8);
                            };
                            this.i1 = (this.i1 + -1);
                            this.i4 = (this.i4 + 1);
                        } while (!(this.i4 == this.i3));
                    };
                    this.i1 = 80;
                    this.i2 = li32(this.i0 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (public::mstate.ebp + -96);
                    this.i2 = (this.i2 + 16);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 11:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i0 + 4);
                    this.i2 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i4 = __2E_str15272;
                    this.i6 = __2E_str4348;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i6, (public::mstate.esp + 16));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 12:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    this.i2 = li32(this.i2);
                    this.i3 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = __2E_str35292;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 14:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_14: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_15: 
                    this.i4 = this.i5;
                    goto _label_5;
                    
                _label_16: 
                    this.i5 = this.i4;
                    goto _label_11;
                default:
                    throw ("Invalid state in _read_numeral");
            };
        }


    }
}

