package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_recfield extends Machine 
    {

        public static const intRegCount:int = 12;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
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
            var _local_1:FSM_recfield;
            _local_1 = new (FSM_recfield)();
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
                    public::mstate.esp = (public::mstate.esp - 0x0100);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 36);
                    this.i2 = li32(this.i1 + 36);
                    this.i3 = li32(this.i0 + 12);
                    this.i4 = (this.i0 + 12);
                    this.i5 = (this.i1 + 36);
                    this.i6 = (this.i0 + 36);
                    this.i7 = li32(public::mstate.ebp + 12);
                    if (!(this.i3 == 285)) goto _label_4;
                    this.i4 = li32(this.i7 + 24);
                    if (this.i4 < 2147483646) goto _label_3;
                    this.i4 = li32(this.i1);
                    this.i4 = li32(this.i4 + 60);
                    this.i3 = li32(this.i1 + 16);
                    this.i8 = (this.i1 + 12);
                    if (!(this.i4 == 0)) goto _label_1;
                    this.i4 = __2E_str196;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = __2E_str23117;
                    this.i10 = 2147483645;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 1:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i8);
                    this.i8 = li32(this.i3 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 80;
                    this.i10 = (public::mstate.ebp + -192);
                    this.i8 = (this.i8 + 16);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = li32(this.i3 + 4);
                    this.i9 = li32(this.i3 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i11 = __2E_str15272;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    si32(this.i4, (public::mstate.esp + 16));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i4 = li32(this.i3 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 3;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_2;
                    
                _label_1: 
                    this.i9 = __2E_str297;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i10 = __2E_str23117;
                    this.i11 = 2147483645;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i11, (public::mstate.esp + 12));
                    si32(this.i10, (public::mstate.esp + 16));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 5:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i3 = li32(this.i8);
                    this.i8 = li32(this.i3 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 80;
                    this.i10 = (public::mstate.ebp + -112);
                    this.i8 = (this.i8 + 16);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = li32(this.i3 + 4);
                    this.i9 = li32(this.i3 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i11 = __2E_str15272;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    si32(this.i4, (public::mstate.esp + 16));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i4 = li32(this.i3 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 3;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_str_checkname.start();
                    return;
                case 9:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i6 = li32(this.i6);
                    si32(this.i3, (public::mstate.ebp + -32));
                    si32(this.i4, (public::mstate.ebp + -24));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (public::mstate.ebp + -32);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addk.start();
                    return;
                case 10:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = -1;
                    si32(this.i3, (public::mstate.ebp + -212));
                    si32(this.i3, (public::mstate.ebp + -208));
                    si32(this.i4, (public::mstate.ebp + -224));
                    si32(this.i6, (public::mstate.ebp + -220));
                    goto _label_6;
                    
                _label_3: 
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_str_checkname.start();
                    return;
                case 11:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i6 = li32(this.i6);
                    si32(this.i3, (public::mstate.ebp + -16));
                    si32(this.i4, (public::mstate.ebp + -8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (public::mstate.ebp + -16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addk.start();
                    return;
                case 12:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = -1;
                    si32(this.i3, (public::mstate.ebp + -212));
                    si32(this.i3, (public::mstate.ebp + -208));
                    si32(this.i4, (public::mstate.ebp + -224));
                    si32(this.i6, (public::mstate.ebp + -220));
                    goto _label_6;
                    
                _label_4: 
                    this.i3 = li32(this.i0 + 4);
                    si32(this.i3, (this.i0 + 8));
                    this.i3 = li32(this.i0 + 24);
                    this.i8 = (this.i0 + 24);
                    if (!(this.i3 == 287))
                    {
                        this.i9 = 287;
                        si32(this.i3, this.i4);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i9, this.i8);
                        goto _label_5;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 13:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i3, this.i4);
                    
                _label_5: 
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (public::mstate.ebp + -224);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_subexpr.start();
                    return;
                case 14:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2val.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 93;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_checknext.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_6: 
                    this.i3 = 61;
                    this.i4 = li32(this.i7 + 24);
                    this.i4 = (this.i4 + 1);
                    si32(this.i4, (this.i7 + 24));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_checknext.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (public::mstate.ebp + -224);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2RK.start();
                    return;
                case 18:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (public::mstate.ebp + -256);
                    this.i6 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_subexpr.start();
                    return;
                case 19:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2RK.start();
                    return;
                case 20:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i7 + 20);
                    this.i4 = li32(this.i4 + 4);
                    this.i6 = li32(this.i1 + 12);
                    this.i3 = (this.i3 << 23);
                    this.i4 = (this.i4 << 6);
                    this.i6 = li32(this.i6 + 8);
                    this.i3 = (this.i4 | this.i3);
                    this.i0 = (this.i0 << 14);
                    this.i0 = (this.i3 | this.i0);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 | 0x09);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 21:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _recfield");
            };
        }


    }
}

