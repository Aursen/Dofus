package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_db_debug extends Machine 
    {

        public static const intRegCount:int = 32;
        public static const NumberRegCount:int = 0;

        public var i21:int;
        public var i30:int;
        public var i31:int;
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
            var _local_1:FSM_db_debug;
            _local_1 = new (FSM_db_debug)();
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
                    public::mstate.esp = (public::mstate.esp - 480);
                    this.i0 = (public::mstate.ebp + -64);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = (public::mstate.ebp + -32);
                    this.i3 = (public::mstate.ebp + -112);
                    this.i4 = (public::mstate.ebp + -144);
                    this.i5 = (public::mstate.ebp + -88);
                    this.i6 = (public::mstate.ebp + -80);
                    this.i7 = (public::mstate.ebp + -72);
                    this.i8 = (public::mstate.ebp + -120);
                    this.i9 = (this.i2 + 12);
                    this.i10 = (this.i3 + 4);
                    si32(this.i10, (public::mstate.ebp + -405));
                    this.i10 = (this.i5 + 4);
                    si32(this.i10, (public::mstate.ebp + -414));
                    this.i10 = (this.i3 + 8);
                    si32(this.i10, (public::mstate.ebp + -423));
                    this.i10 = (this.i1 + 12);
                    this.i11 = (this.i6 + 4);
                    si32(this.i11, (public::mstate.ebp + -432));
                    this.i11 = (this.i1 + 16);
                    si32(this.i11, (public::mstate.ebp + -441));
                    this.i11 = (this.i1 + 32);
                    this.i12 = (this.i1 + 8);
                    this.i13 = (this.i1 + 108);
                    si32(this.i13, (public::mstate.ebp + -450));
                    this.i13 = (this.i2 + 4);
                    this.i14 = (this.i2 + 16);
                    si32(this.i14, (public::mstate.ebp + -459));
                    this.i14 = (this.i0 + 4);
                    si32(this.i14, (public::mstate.ebp + -468));
                    this.i14 = (this.i0 + 12);
                    si32(this.i14, (public::mstate.ebp + -477));
                    this.i14 = (this.i0 + 8);
                    this.i15 = (this.i0 + 16);
                    this.i16 = (this.i7 + 4);
                    this.i17 = (this.i4 + 4);
                    this.i18 = (this.i4 + 8);
                    this.i19 = (this.i8 + 4);
                    this.i20 = (public::mstate.ebp + -400);
                    this.i21 = this.i6;
                    this.i22 = this.i2;
                    this.i23 = this.i7;
                    this.i24 = this.i20;
                    
                _label_1: 
                    this.i25 = __2E_str38288;
                    si32(this.i25, this.i8);
                    this.i25 = 11;
                    si32(this.i25, this.i19);
                    si32(this.i25, this.i18);
                    this.i25 = (public::mstate.ebp + -120);
                    si32(this.i25, this.i4);
                    this.i25 = 1;
                    si32(this.i25, this.i17);
                    this.i25 = li32(___sF + 232);
                    this.i26 = li32(this.i25 + 16);
                    this.i25 = (this.i25 + 16);
                    if (!(!(this.i26 == 0)))
                    {
                        this.i26 = -1;
                        si32(this.i26, this.i25);
                    };
                    this.i25 = ___sF;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i26 = (public::mstate.ebp + -144);
                    this.i27 = (this.i25 + 176);
                    si32(this.i27, public::mstate.esp);
                    si32(this.i26, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sfvwrite.start();
                    return;
                case 1:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i26 = 250;
                    si32(this.i24, public::mstate.esp);
                    si32(this.i26, (public::mstate.esp + 4));
                    si32(this.i25, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fgets.start();
                    return;
                case 2:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i25 == 0))
                    {
                        this.i25 = li8(this.i24);
                        if (!(this.i25 == 99))
                        {
                            this.i26 = __2E_str39289;
                            this.i27 = this.i25;
                        }
                        else
                        {
                            this.i26 = __2E_str39289;
                            this.i27 = 0;
                            this.i28 = this.i25;
                            do 
                            {
                                this.i29 = (this.i26 + this.i27);
                                this.i29 = (this.i29 + 1);
                                this.i28 = (this.i28 & 0xFF);
                                if (this.i28 == 0) goto _label_2;
                                this.i28 = (this.i20 + this.i27);
                                this.i28 = li8(this.i28 + 1);
                                this.i29 = li8(this.i29);
                                this.i27 = (this.i27 + 1);
                            } while (!(!(this.i28 == this.i29)));
                            this.i26 = __2E_str39289;
                            this.i26 = (this.i26 + this.i27);
                            this.i27 = this.i28;
                        };
                        this.i26 = li8(this.i26);
                        this.i27 = (this.i27 & 0xFF);
                        if (!(this.i27 == this.i26)) goto _label_3;
                    };
                    
                _label_2: 
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_3: 
                    this.i25 = (this.i25 & 0xFF);
                    if (this.i25 == 0) goto _label_12;
                    this.i25 = this.i20;
                    do 
                    {
                        this.i26 = li8(this.i25 + 1);
                        this.i25 = (this.i25 + 1);
                        this.i27 = this.i25;
                        if (this.i26 == 0) goto _label_13;
                        this.i25 = this.i27;
                    } while (true);
                    
                _label_4: 
                    this.i26 = (public::mstate.ebp + -88);
                    this.i25 = (this.i25 - this.i27);
                    this.i27 = li32(public::mstate.ebp + -423);
                    si32(this.i25, this.i27);
                    this.i27 = li32(public::mstate.ebp + -414);
                    si32(this.i25, this.i27);
                    si32(this.i26, this.i3);
                    this.i25 = 1;
                    this.i26 = li32(public::mstate.ebp + -405);
                    si32(this.i25, this.i26);
                    this.i25 = li32(___sF + 232);
                    this.i26 = li32(this.i25 + 16);
                    this.i25 = (this.i25 + 16);
                    if (!(!(this.i26 == 0)))
                    {
                        this.i26 = -1;
                        si32(this.i26, this.i25);
                    };
                    this.i25 = ___sF;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i26 = (public::mstate.ebp + -112);
                    this.i25 = (this.i25 + 176);
                    si32(this.i25, public::mstate.esp);
                    si32(this.i26, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sfvwrite.start();
                    return;
                case 3:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i25 = li32(___sF + 184);
                    this.i25 = (this.i25 + -1);
                    si32(this.i25, (___sF + 184));
                    if (this.i25 > -1) goto _label_6;
                    this.i26 = li32(___sF + 200);
                    if (this.i25 < this.i26) goto _label_5;
                    this.i25 = 10;
                    this.i26 = li32(___sF + 176);
                    si8(this.i25, this.i26);
                    this.i25 = li32(___sF + 176);
                    this.i26 = li8(this.i25);
                    if (!(this.i26 == 10))
                    {
                        this.i25 = (this.i25 + 1);
                        si32(this.i25, (___sF + 176));
                        goto _label_7;
                    };
                    this.i25 = ___sF;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i25 = (this.i25 + 176);
                    this.i26 = 10;
                    si32(this.i26, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___swbuf.start();
                    return;
                case 4:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_7;
                    
                _label_5: 
                    this.i25 = ___sF;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i25 = (this.i25 + 176);
                    this.i26 = 10;
                    si32(this.i26, public::mstate.esp);
                    si32(this.i25, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___swbuf.start();
                    return;
                case 5:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_7;
                    
                _label_6: 
                    this.i25 = 10;
                    this.i26 = li32(___sF + 176);
                    si8(this.i25, this.i26);
                    this.i25 = li32(___sF + 176);
                    this.i25 = (this.i25 + 1);
                    si32(this.i25, (___sF + 176));
                    
                _label_7: 
                    this.i25 = li32(this.i12);
                    this.i26 = li32(this.i10);
                    if (!(uint(this.i25) < uint(this.i26)))
                    {
                        this.i25 = this.i26;
                        goto _label_9;
                    };
                    
                _label_8: 
                    this.i26 = 0;
                    si32(this.i26, (this.i25 + 8));
                    this.i25 = (this.i25 + 12);
                    si32(this.i25, this.i12);
                    this.i26 = li32(this.i10);
                    if (uint(this.i25) < uint(this.i26)) goto _label_8;
                    this.i25 = this.i26;
                    do 
                    {
                        
                    _label_9: 
                        si32(this.i25, this.i12);
                        goto _label_1;
                        
                    _label_10: 
                        this.i25 = li32(this.i12);
                        this.i26 = li32(this.i10);
                        if (!(uint(this.i25) < uint(this.i26)))
                        {
                            this.i25 = this.i26;
                            continue;
                        };
                        
                    _label_11: 
                        this.i26 = 0;
                        si32(this.i26, (this.i25 + 8));
                        this.i25 = (this.i25 + 12);
                        si32(this.i25, this.i12);
                        this.i26 = li32(this.i10);
                        if (uint(this.i25) < uint(this.i26)) goto _label_11;
                        this.i25 = this.i26;
                    } while (true);
                    
                _label_12: 
                    this.i25 = this.i24;
                    
                _label_13: 
                    this.i26 = _getS;
                    si32(this.i24, this.i23);
                    this.i25 = (this.i25 - this.i20);
                    si32(this.i25, this.i16);
                    si32(this.i1, this.i15);
                    si32(this.i26, this.i14);
                    this.i25 = li32(public::mstate.ebp + -477);
                    si32(this.i7, this.i25);
                    this.i25 = 0;
                    si32(this.i25, this.i0);
                    this.i26 = li32(public::mstate.ebp + -468);
                    si32(this.i25, this.i26);
                    this.i26 = (public::mstate.ebp + -64);
                    si32(this.i26, this.i2);
                    this.i26 = __2E_str40290;
                    this.i27 = li32(public::mstate.ebp + -459);
                    si32(this.i26, this.i27);
                    si32(this.i25, this.i13);
                    si32(this.i25, this.i9);
                    this.i26 = li32(public::mstate.ebp + -450);
                    this.i26 = li32(this.i26);
                    this.i27 = li32(this.i12);
                    this.i28 = li32(this.i11);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i29 = _f_parser;
                    this.i27 = (this.i27 - this.i28);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i29, (public::mstate.esp + 4));
                    si32(this.i22, (public::mstate.esp + 8));
                    si32(this.i27, (public::mstate.esp + 12));
                    si32(this.i26, (public::mstate.esp + 16));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_pcall.start();
                    return;
                case 6:
                    this.i26 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i27 = li32(public::mstate.ebp + -441);
                    this.i27 = li32(this.i27);
                    this.i28 = li32(this.i9);
                    this.i29 = li32(this.i13);
                    this.i30 = li32(this.i27 + 12);
                    this.i31 = li32(this.i27 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i31, public::mstate.esp);
                    si32(this.i29, (public::mstate.esp + 4));
                    si32(this.i28, (public::mstate.esp + 8));
                    si32(this.i25, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i30]());
                    return;
                case 7:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i25 = li32(this.i27 + 68);
                    this.i25 = (this.i25 - this.i28);
                    si32(this.i25, (this.i27 + 68));
                    if (!(this.i26 == 0)) goto _label_14;
                    this.i25 = 0;
                    this.i26 = li32(this.i12);
                    this.i26 = (this.i26 + -12);
                    si32(this.i26, this.i21);
                    this.i27 = li32(public::mstate.ebp + -432);
                    si32(this.i25, this.i27);
                    this.i27 = li32(this.i11);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i28 = _f_call;
                    this.i26 = (this.i26 - this.i27);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i28, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i26, (public::mstate.esp + 12));
                    si32(this.i25, (public::mstate.esp + 16));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_pcall.start();
                    return;
                case 8:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    if (this.i25 == 0) goto _label_10;
                    
                _label_14: 
                    this.i25 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i26 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i26, (public::mstate.esp + 4));
                    si32(this.i25, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 9:
                    this.i25 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i25, this.i5);
                    this.i26 = li8(this.i25);
                    this.i27 = this.i25;
                    //unresolved if
                    this.i25 = this.i27;
                    do 
                    {
                        this.i26 = li8(this.i25 + 1);
                        this.i25 = (this.i25 + 1);
                        this.i28 = this.i25;
                        if (this.i26 == 0) goto _label_4;
                        this.i25 = this.i28;
                    } while (true);
                default:
                    throw ("Invalid state in _db_debug");
            };
        }


    }
}

