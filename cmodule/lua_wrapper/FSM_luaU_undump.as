package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaU_undump extends Machine 
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
            var _local_1:FSM_luaU_undump;
            _local_1 = new (FSM_luaU_undump)();
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
                    public::mstate.esp = (public::mstate.esp - 48);
                    this.i0 = (public::mstate.ebp + -48);
                    this.i1 = li32(public::mstate.ebp + 20);
                    this.i2 = li8(this.i1);
                    this.i3 = (public::mstate.ebp + -32);
                    this.i4 = li32(public::mstate.ebp + 8);
                    this.i5 = li32(public::mstate.ebp + 12);
                    this.i6 = li32(public::mstate.ebp + 16);
                    if (!(this.i2 == 61))
                    {
                        this.i7 = (this.i2 & 0xFF);
                        if (!(this.i7 == 64)) goto _label_1;
                    };
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, (public::mstate.ebp + -4));
                    goto _label_2;
                    
                _label_1: 
                    this.i7 = (public::mstate.ebp + -16);
                    this.i7 = (this.i7 + 12);
                    this.i2 = (this.i2 & 0xFF);
                    if (!(!(this.i2 == 27)))
                    {
                        this.i1 = __2E_str8163;
                        si32(this.i1, this.i7);
                    }
                    else
                    {
                        si32(this.i1, this.i7);
                    };
                    
                _label_2: 
                    this.i1 = 27;
                    si32(this.i4, (public::mstate.ebp + -16));
                    si32(this.i5, (public::mstate.ebp + -12));
                    si32(this.i6, (public::mstate.ebp + -8));
                    this.i2 = 76;
                    this.i5 = 117;
                    this.i6 = 97;
                    si8(this.i1, (public::mstate.ebp + -32));
                    si8(this.i2, (public::mstate.ebp + -31));
                    si8(this.i5, (public::mstate.ebp + -30));
                    si8(this.i6, (public::mstate.ebp + -29));
                    this.i1 = 81;
                    si8(this.i1, (public::mstate.ebp + -28));
                    this.i1 = 0;
                    si8(this.i1, (public::mstate.ebp + -27));
                    this.i2 = 1;
                    si8(this.i2, (public::mstate.ebp + -26));
                    this.i2 = 4;
                    si8(this.i2, (public::mstate.ebp + -25));
                    si8(this.i2, (public::mstate.ebp + -24));
                    si8(this.i2, (public::mstate.ebp + -23));
                    this.i2 = 8;
                    si8(this.i2, (public::mstate.ebp + -22));
                    si8(this.i1, (public::mstate.ebp + -21));
                    this.i2 = li32(public::mstate.ebp + -12);
                    this.i5 = 12;
                    this.i6 = (this.i2 + 4);
                    this.i7 = (public::mstate.ebp + -16);
                    this.i8 = this.i2;
                    
                _label_3: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i8, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaZ_lookahead.start();
                    return;
                case 1:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(!(this.i9 == -1)))
                    {
                        this.i1 = this.i5;
                    }
                    else
                    {
                        this.i9 = (public::mstate.ebp + -48);
                        this.i10 = li32(this.i2);
                        this.i11 = li32(this.i6);
                        this.i9 = (this.i9 + this.i1);
                        this.i10 = ((uint(this.i10) <= uint(this.i5)) ? this.i10 : this.i5);
                        memcpy(this.i9, this.i11, this.i10);
                        this.i9 = li32(this.i2);
                        this.i9 = (this.i9 - this.i10);
                        si32(this.i9, this.i2);
                        this.i9 = li32(this.i6);
                        this.i9 = (this.i9 + this.i10);
                        si32(this.i9, this.i6);
                        this.i9 = (this.i5 - this.i10);
                        this.i1 = (this.i1 + this.i10);
                        if (!(this.i5 == this.i10))
                        {
                            this.i5 = this.i9;
                            goto _label_3;
                        };
                        this.i1 = 0;
                    };
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = 0;
                        this.i2 = 13;
                        goto _label_4;
                    };
                    this.i1 = __2E_str156317;
                    this.i2 = li32(public::mstate.ebp + -4);
                    this.i5 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = __2E_str1157;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = 13;
                    this.i5 = 0;
                    this.i2 = this.i1;
                    this.i1 = this.i5;
                    do 
                    {
                        
                    _label_4: 
                        this.i5 = (this.i0 + this.i1);
                        this.i6 = (this.i3 + this.i1);
                        this.i6 = li8(this.i6);
                        this.i5 = li8(this.i5);
                        if ((!(this.i6 == this.i5))) break;
                        this.i2 = (this.i2 + -1);
                        this.i1 = (this.i1 + 1);
                        if (this.i2 == 1) goto _label_5;
                    } while (true);
                    this.i0 = __2E_str156317;
                    this.i1 = li32(public::mstate.ebp + -4);
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = __2E_str9164;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = __2E_str10165;
                    this.i1 = 2;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 6:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (public::mstate.ebp + -16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadFunction.start();
                    return;
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.eax = this.i4;
                    goto _label_6;
                    
                _label_5: 
                    this.i0 = __2E_str10165;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = 2;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_LoadFunction.start();
                    return;
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.eax = this.i0;
                    
                _label_6: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaU_undump");
            };
        }


    }
} cmodule.lua_wrapper

