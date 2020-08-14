package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_loadfile extends Machine 
    {

        public static const intRegCount:int = 16;
        public static const NumberRegCount:int = 1;

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


        public static function start():void
        {
            var _local_1:FSM_luaL_loadfile;
            _local_1 = new (FSM_luaL_loadfile)();
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
                    public::mstate.esp = (public::mstate.esp - 9296);
                    this.i2 = (public::mstate.ebp + -9296);
                    this.i3 = li32(public::mstate.ebp + 8);
                    this.i0 = li32(this.i3 + 8);
                    this.i1 = li32(this.i3 + 12);
                    this.i0 = (this.i0 - this.i1);
                    this.i4 = (this.i0 / 12);
                    this.i0 = 0;
                    si32(this.i0, (public::mstate.ebp + -9296));
                    this.i5 = (this.i2 + 4);
                    this.i6 = (this.i4 + 1);
                    this.i7 = (this.i3 + 12);
                    this.i8 = (this.i3 + 8);
                    this.i9 = li32(public::mstate.ebp + 12);
                    if (!(this.i9 == 0)) goto _label_3;
                    this.i0 = li32(this.i3 + 16);
                    this.i1 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i1) < uint(this.i0)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i0 = __2E_str17192335;
                    this.i1 = li32(this.i8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 6;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i1);
                    this.i0 = 4;
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = li32(this.i8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i8);
                    this.i0 = ___sF;
                    si32(this.i0, this.i5);
                    
                _label_2: 
                    this.i1 = li32(this.i0 + 4);
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, (this.i0 + 4));
                    this.i0 = li32(this.i5);
                    if (this.i1 > -1) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___srefill.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i1 == 0) goto _label_5;
                    this.i0 = -1;
                    goto _label_6;
                    
                _label_3: 
                    this.i0 = __2E_str18193336;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li8(__2E_str19170 + 2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = 114;
                    this.i10 = 0;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fopen387.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i0, this.i5);
                    if (!(this.i0 == 0)) goto _label_2;
                    this.i0 = __2E_str20195338;
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_errfile.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = 6;
                    public::mstate.eax = this.i0;
                    goto _label_37;
                    
                _label_5: 
                    this.i1 = li32(this.i0 + 4);
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, (this.i0 + 4));
                    this.i1 = li32(this.i0);
                    this.i10 = li8(this.i1);
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, this.i0);
                    this.i0 = this.i10;
                    
                _label_6: 
                    if (!(this.i0 == 35))
                    {
                        do 
                        {
                            
                        _label_7: 
                            if (!(!(this.i0 == 27)))
                            {
                                if (!(this.i9 == 0)) goto _label_12;
                            };
                            goto _label_30;
                            
                        _label_8: 
                            this.i1 = li32(this.i0);
                            this.i10 = li8(this.i1);
                            this.i1 = (this.i1 + 1);
                            si32(this.i1, this.i0);
                            if ((this.i10 == 35)) break;
                            this.i0 = this.i10;
                        } while (true);
                    };
                    this.i0 = 1;
                    si32(this.i0, this.i2);
                    
                _label_9: 
                    this.i0 = li32(this.i5);
                    this.i1 = li32(this.i0 + 4);
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, (this.i0 + 4));
                    this.i0 = li32(this.i5);
                    if (this.i1 > -1) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___srefill.start();
                    return;
                case 7:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i1 == 0))
                    {
                        this.i0 = -1;
                    }
                    else
                    {
                        this.i1 = li32(this.i0 + 4);
                        this.i1 = (this.i1 + -1);
                        si32(this.i1, (this.i0 + 4));
                        this.i1 = li32(this.i0);
                        this.i10 = li8(this.i1);
                        this.i1 = (this.i1 + 1);
                        si32(this.i1, this.i0);
                        this.i0 = this.i10;
                    };
                    if (!(this.i0 == 10))
                    {
                        if (!(this.i0 == -1)) goto _label_9;
                        goto _label_7;
                        
                    _label_10: 
                        this.i1 = li32(this.i0);
                        this.i10 = li8(this.i1);
                        this.i1 = (this.i1 + 1);
                        si32(this.i1, this.i0);
                        if (!(this.i10 == 10))
                        {
                            if (!(this.i10 == -1)) goto _label_9;
                            this.i0 = this.i10;
                            goto _label_7;
                        };
                    };
                    this.i0 = li32(this.i5);
                    this.i1 = li32(this.i0 + 4);
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, (this.i0 + 4));
                    this.i0 = li32(this.i5);
                    if (this.i1 > -1) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___srefill.start();
                    return;
                case 8:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i1 == 0))
                    {
                        this.i0 = -1;
                    }
                    else
                    {
                        this.i1 = li32(this.i0 + 4);
                        this.i1 = (this.i1 + -1);
                        si32(this.i1, (this.i0 + 4));
                        this.i1 = li32(this.i0);
                        this.i10 = li8(this.i1);
                        this.i1 = (this.i1 + 1);
                        si32(this.i1, this.i0);
                        this.i0 = this.i10;
                    };
                    if( ((!(this.i0 == 27))) || (!(!(this.i9 == 0))) )
                    {
                        goto _label_30;
                        
                    _label_11: 
                        this.i1 = li32(this.i0);
                        this.i10 = li8(this.i1);
                        this.i1 = (this.i1 + 1);
                        si32(this.i1, this.i0);
                        if (!(!(this.i10 == 27)))
                        {
                            if (!(this.i9 == 0)) goto _label_12;
                        };
                        this.i0 = this.i10;
                        goto _label_30;
                    };
                    
                _label_12: 
                    this.i10 = li32(this.i5);
                    this.i0 = li8(___sdidinit_2E_b);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = _usual;
                        this.i1 = _usual_extra;
                        this.i11 = 0;
                        this.i0 = (this.i0 + 56);
                        do 
                        {
                            si32(this.i1, this.i0);
                            this.i1 = (this.i1 + 148);
                            this.i0 = (this.i0 + 88);
                            this.i11 = (this.i11 + 1);
                        } while (!(this.i11 == 17));
                        this.i0 = 1;
                        si8(this.i0, ___cleanup_2E_b);
                        si8(this.i0, ___sdidinit_2E_b);
                    };
                    this.i0 = li16(this.i10 + 12);
                    this.i11 = (this.i10 + 12);
                    if (!(this.i9 == 0)) goto _label_13;
                    this.i0 = (this.i0 & 0xFFFF);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = 22;
                        si32(this.i0, _val_2E_1440);
                        this.i0 = 0;
                        goto _label_26;
                    };
                    this.i0 = __2E_str32;
                    this.i11 = 4;
                    this.i1 = this.i11;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i11 = __2E_str13;
                    this.i1 = 345;
                    this.i12 = 78;
                    this.i13 = (public::mstate.ebp + -4096);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    si32(this.i11, (public::mstate.esp + 12));
                    si32(this.i1, (public::mstate.esp + 16));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i11 = 3;
                    this.i0 = this.i13;
                    this.i1 = this.i11;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i12, _val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i10, public::mstate.esp);
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 10:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i12, _val_2E_1440);
                    this.i0 = 0;
                    goto _label_26;
                    
                _label_13: 
                    this.i1 = (this.i0 & 0xFFFF);
                    if (!(this.i1 == 0)) goto _label_14;
                    this.i0 = 32;
                    si16(this.i0, this.i11);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 438;
                    this.i1 = 0;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_open.start();
                    return;
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = -1;
                    goto _label_19;
                    
                _label_14: 
                    this.i0 = (this.i0 & 0x08);
                    if (this.i0 == 0) goto _label_15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i10, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflush.start();
                    return;
                case 12:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_15: 
                    this.i0 = li32(this.i10 + 32);
                    this.i1 = li16(this.i10 + 14);
                    this.i12 = ((this.i0 != 0) ? 1 : 0);
                    this.i1 = (this.i1 << 16);
                    this.i12 = (this.i12 & 0x01);
                    this.i1 = (this.i1 >> 16);
                    this.i13 = (this.i10 + 32);
                    if( ((this.i1 > -1)) || (!(!(this.i0 == 0))) )
                    {
                        this.i0 = this.i12;
                        goto _label_16;
                    };
                    this.i12 = 0;
                    this.i14 = li32(this.i10 + 28);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i0]());
                    return;
                case 13:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = this.i12;
                    
                _label_16: 
                    this.i12 = 438;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i14 = 0;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i14, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_open.start();
                    return;
                case 14:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i14 > -1))
                    {
                        if (!(this.i0 == 0)) goto _label_18;
                    };
                    
                _label_17: 
                    this.i12 = this.i1;
                    this.i1 = this.i0;
                    this.i0 = this.i14;
                    goto _label_19;
                    
                _label_18: 
                    this.i12 = li32(_val_2E_1440);
                    this.i12 = (this.i12 + -23);
                    if (uint(this.i12) > uint(1)) goto _label_17;
                    this.i0 = 438;
                    this.i12 = li32(this.i13);
                    this.i13 = li32(this.i10 + 28);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i13, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i12]());
                    return;
                case 15:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i13 = 0;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_open.start();
                    return;
                case 16:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i12 = this.i1;
                    this.i1 = this.i13;
                    
                _label_19: 
                    this.i13 = this.i0;
                    this.i0 = li32(_val_2E_1440);
                    if (this.i1 == 0) goto _label_20;
                    this.i1 = li32(this.i10 + 32);
                    this.i14 = li32(this.i10 + 28);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i14, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i1]());
                    return;
                case 17:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_20: 
                    this.i1 = li16(this.i11);
                    this.i1 = (this.i1 & 0x80);
                    if (this.i1 == 0) goto _label_21;
                    this.i1 = 0;
                    this.i14 = li32(this.i10 + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i14, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 18:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_21: 
                    this.i1 = 0;
                    si32(this.i1, (this.i10 + 8));
                    si32(this.i1, (this.i10 + 4));
                    si32(this.i1, this.i10);
                    si32(this.i1, (this.i10 + 16));
                    si32(this.i1, (this.i10 + 20));
                    si32(this.i1, (this.i10 + 24));
                    this.i1 = li32(this.i10 + 48);
                    this.i14 = (this.i10 + 48);
                    if (this.i1 == 0) goto _label_23;
                    this.i15 = (this.i10 + 64);
                    if (this.i1 == this.i15) goto _label_22;
                    this.i15 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 19:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_22: 
                    this.i1 = 0;
                    si32(this.i1, this.i14);
                    
                _label_23: 
                    this.i1 = 0;
                    si32(this.i1, (this.i10 + 52));
                    this.i1 = li32(this.i10 + 68);
                    this.i14 = (this.i10 + 68);
                    if (this.i1 == 0) goto _label_24;
                    this.i15 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i15, (public::mstate.esp + 4));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 20:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i15, this.i14);
                    
                _label_24: 
                    this.i1 = 0;
                    si32(this.i1, (this.i10 + 72));
                    this.i14 = li32(this.i10 + 56);
                    si32(this.i1, (this.i14 + 16));
                    this.i14 = li32(this.i10 + 56);
                    this.i14 = (this.i14 + 20);
                    this.i15 = 128;
                    memset(this.i14, this.i1, this.i15);
                    if (!(this.i13 > -1))
                    {
                        this.i10 = 0;
                        si16(this.i10, this.i11);
                        si32(this.i0, _val_2E_1440);
                        this.i0 = this.i10;
                        goto _label_26;
                    };
                    if (this.i13 == this.i12) goto _label_25;
                    if (this.i12 < 0) goto _label_25;
                    this.i0 = __2E_str48;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i1 = __2E_str13;
                    this.i12 = 138;
                    this.i14 = 78;
                    this.i15 = (public::mstate.ebp + -8192);
                    si32(this.i15, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i14, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i12, (public::mstate.esp + 16));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i15;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i14, _val_2E_1440);
                    
                _label_25: 
                    this.i0 = 4;
                    si16(this.i0, this.i11);
                    si16(this.i13, (this.i10 + 14));
                    si32(this.i10, (this.i10 + 28));
                    this.i0 = ___sread;
                    si32(this.i0, (this.i10 + 36));
                    this.i0 = ___swrite;
                    si32(this.i0, (this.i10 + 44));
                    this.i0 = ___sseek;
                    si32(this.i0, (this.i10 + 40));
                    this.i0 = ___sclose;
                    si32(this.i0, (this.i10 + 32));
                    this.i0 = this.i10;
                    
                _label_26: 
                    si32(this.i0, this.i5);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = __2E_str23197;
                        goto _label_4;
                    };
                    
                _label_27: 
                    this.i0 = li32(this.i5);
                    this.i1 = li32(this.i0 + 4);
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, (this.i0 + 4));
                    this.i0 = li32(this.i5);
                    if (this.i1 > -1) goto _label_28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___srefill.start();
                    return;
                case 22:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i1 == 0))
                    {
                        this.i0 = -1;
                    }
                    else
                    {
                        this.i1 = li32(this.i0 + 4);
                        this.i1 = (this.i1 + -1);
                        si32(this.i1, (this.i0 + 4));
                        this.i1 = li32(this.i0);
                        this.i10 = li8(this.i1);
                        this.i1 = (this.i1 + 1);
                        si32(this.i1, this.i0);
                        this.i0 = this.i10;
                    };
                    if (!(this.i0 == -1))
                    {
                        if (!(this.i0 == 27)) goto _label_27;
                    };
                    goto _label_29;
                    
                _label_28: 
                    this.i1 = li32(this.i0);
                    this.i10 = li8(this.i1);
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, this.i0);
                    if (!(this.i10 == 27)) goto _label_27;
                    this.i0 = this.i10;
                    
                _label_29: 
                    this.i1 = 0;
                    si32(this.i1, this.i2);
                    
                _label_30: 
                    this.i1 = -1;
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_ungetc.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 0;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 24:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -8240));
                    this.i2 = _getF;
                    si32(this.i2, (public::mstate.ebp + -8248));
                    this.i2 = (public::mstate.ebp + -9296);
                    si32(this.i2, (public::mstate.ebp + -8244));
                    si32(this.i0, (public::mstate.ebp + -8256));
                    this.i2 = __2E_str6354;
                    si32(this.i0, (public::mstate.ebp + -8252));
                    this.i10 = (public::mstate.ebp + -8256);
                    si32(this.i10, (public::mstate.ebp + -8224));
                    this.i1 = ((this.i1 == 0) ? this.i2 : this.i1);
                    si32(this.i1, (public::mstate.ebp + -8208));
                    si32(this.i0, (public::mstate.ebp + -8220));
                    si32(this.i0, (public::mstate.ebp + -8212));
                    this.i1 = li32(this.i3 + 108);
                    this.i2 = li32(this.i8);
                    this.i10 = li32(this.i3 + 32);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i11 = _f_parser;
                    this.i2 = (this.i2 - this.i10);
                    this.i10 = (public::mstate.ebp + -8224);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    si32(this.i1, (public::mstate.esp + 16));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_pcall.start();
                    return;
                case 25:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i3 + 16);
                    this.i10 = li32(public::mstate.ebp + -8212);
                    this.i11 = li32(public::mstate.ebp + -8220);
                    this.i12 = li32(this.i2 + 12);
                    this.i13 = li32(this.i2 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i12]());
                    return;
                case 26:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i2 + 68);
                    this.i0 = (this.i0 - this.i10);
                    si32(this.i0, (this.i2 + 68));
                    this.i0 = li32(this.i5);
                    this.i2 = li16(this.i0 + 12);
                    this.i2 = (this.i2 & 0x40);
                    if (this.i9 == 0) goto _label_31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 27:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_31: 
                    if (this.i2 == 0) goto _label_34;
                    this.i1 = li32(this.i8);
                    if (!(this.i6 < 0))
                    {
                        this.i4 = li32(this.i7);
                        this.i0 = (this.i6 * 12);
                        this.i0 = (this.i4 + this.i0);
                        if (!(uint(this.i1) < uint(this.i0)))
                        {
                            this.i1 = this.i4;
                            goto _label_33;
                        };
                        
                    _label_32: 
                        this.i4 = 0;
                        si32(this.i4, (this.i1 + 8));
                        this.i1 = (this.i1 + 12);
                        si32(this.i1, this.i8);
                        this.i4 = li32(this.i7);
                        this.i0 = (this.i6 * 12);
                        this.i0 = (this.i4 + this.i0);
                        if (uint(this.i1) < uint(this.i0)) goto _label_32;
                        this.i1 = this.i4;
                        
                    _label_33: 
                        this.i4 = (this.i6 * 12);
                        this.i1 = (this.i1 + this.i4);
                    }
                    else
                    {
                        this.i0 = (this.i4 * 12);
                        this.i1 = (this.i0 + this.i1);
                        this.i1 = (this.i1 + 24);
                    };
                    this.i0 = __2E_str24198;
                    si32(this.i1, this.i8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_errfile.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = 6;
                    goto _label_36;
                    
                _label_34: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 29:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i8);
                    this.i3 = this.i0;
                    this.i4 = (this.i0 + 12);
                    if (!(uint(this.i4) < uint(this.i2)))
                    {
                        this.i0 = this.i2;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i2 = this.i3;
                        
                    _label_35: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i3 = li32(this.i2 + 20);
                        si32(this.i3, (this.i2 + 8));
                        this.i2 = li32(this.i8);
                        this.i3 = (this.i0 + 12);
                        this.i4 = this.i0;
                        if (uint(this.i3) < uint(this.i2)) goto _label_38;
                        this.i0 = this.i2;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i8);
                    
                _label_36: 
                    public::mstate.eax = this.i1;
                    
                _label_37: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_38: 
                    this.i0 = this.i3;
                    this.i2 = this.i4;
                    goto _label_35;
                default:
                    throw ("Invalid state in _luaL_loadfile");
            };
        }


    }
} cmodule.lua_wrapper

