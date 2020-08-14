package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_f_setvbuf extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_f_setvbuf;
            _local_1 = new (FSM_f_setvbuf)();
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = __2E_str17320;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkudata.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0);
                    if (!(this.i2 == 0))
                    {
                        this.i0 = this.i2;
                        goto _label_1;
                    };
                    this.i2 = __2E_str20323;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0);
                    
                _label_1: 
                    this.i2 = _modenames_2E_2991;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = 0;
                    this.i4 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkoption.start();
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = _luaO_nilobject_;
                    if (!(!(this.i3 == this.i4)))
                    {
                        
                    _label_2: 
                        this.i3 = 0x0400;
                        goto _label_3;
                    };
                    this.i3 = li32(this.i3 + 8);
                    if (this.i3 < 1) goto _label_2;
                    this.i3 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 5:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i4 = _mode_2E_2990;
                    this.i2 = (this.i2 << 2);
                    this.i2 = (this.i4 + this.i2);
                    this.i2 = li32(this.i2);
                    if (!(this.i2 == 2))
                    {
                        if (!(this.i3 < 0))
                        {
                            if (uint(this.i2) < uint(2)) goto _label_4;
                        };
                        this.i0 = -1;
                        goto _label_10;
                    };
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflush.start();
                    return;
                case 6:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i4 = li32(this.i0 + 48);
                    this.i5 = (this.i0 + 48);
                    if (this.i4 == 0) goto _label_6;
                    this.i6 = (this.i0 + 64);
                    if (this.i4 == this.i6) goto _label_5;
                    this.i6 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_5: 
                    this.i4 = 0;
                    si32(this.i4, this.i5);
                    
                _label_6: 
                    this.i4 = 0;
                    si32(this.i4, (this.i0 + 24));
                    si32(this.i4, (this.i0 + 4));
                    this.i4 = sxi16(li16(this.i0 + 12));
                    this.i5 = (this.i0 + 12);
                    this.i6 = (this.i0 + 24);
                    this.i7 = (this.i4 & 0x80);
                    if (this.i7 == 0) goto _label_7;
                    this.i7 = 0;
                    this.i8 = li32(this.i0 + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 8:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_7: 
                    this.i4 = (this.i4 & 0xFFFFE35C);
                    if (!(!(this.i2 == 2)))
                    {
                        this.i2 = 0;
                        this.i3 = this.i4;
                        goto _label_9;
                    };
                    this.i7 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (public::mstate.ebp + -8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___swhatbuf.start();
                    return;
                case 9:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = li32(public::mstate.ebp + -8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = ((this.i3 == 0) ? this.i8 : this.i3);
                    this.i9 = 0;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 10:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = (this.i7 | this.i4);
                    if (!(this.i9 == 0))
                    {
                        this.i7 = 0;
                        goto _label_8;
                    };
                    if (!(!(this.i3 == this.i8)))
                    {
                        this.i7 = -1;
                        goto _label_8;
                    };
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 11:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = -1;
                    this.i3 = this.i8;
                    
                _label_8: 
                    if (!(!(this.i9 == 0)))
                    {
                        this.i3 = this.i4;
                        this.i2 = this.i7;
                        
                    _label_9: 
                        this.i4 = 0;
                        this.i3 = (this.i3 | 0x02);
                        si16(this.i3, this.i5);
                        si32(this.i4, (this.i0 + 8));
                        this.i3 = (this.i0 + 67);
                        si32(this.i3, this.i0);
                        si32(this.i3, (this.i0 + 16));
                        this.i3 = 1;
                        si32(this.i3, (this.i0 + 20));
                        this.i0 = this.i2;
                    }
                    else
                    {
                        this.i2 = ((this.i2 == 1) ? 1 : 0);
                        this.i2 = (this.i2 & 0x01);
                        this.i8 = ((this.i3 == this.i8) ? 0 : 0x0800);
                        this.i2 = (this.i4 | this.i2);
                        this.i2 = (this.i2 | this.i8);
                        this.i2 = (this.i2 | 0x80);
                        si16(this.i2, this.i5);
                        si32(this.i9, this.i0);
                        si32(this.i9, (this.i0 + 16));
                        si32(this.i3, (this.i0 + 20));
                        this.i4 = (this.i2 & 0x08);
                        if (!(this.i4 == 0))
                        {
                            this.i0 = (this.i0 + 8);
                            this.i2 = (this.i2 & 0x01);
                            if (!(this.i2 == 0))
                            {
                                this.i2 = 0;
                                si32(this.i2, this.i0);
                                this.i0 = (0 - this.i3);
                                si32(this.i0, this.i6);
                                this.i0 = 1;
                                si8(this.i0, ___cleanup_2E_b);
                                this.i0 = this.i7;
                            }
                            else
                            {
                                this.i2 = 1;
                                si32(this.i3, this.i0);
                                si8(this.i2, ___cleanup_2E_b);
                                this.i0 = this.i7;
                            };
                        }
                        else
                        {
                            this.i2 = 0;
                            si32(this.i2, (this.i0 + 8));
                            this.i0 = 1;
                            si8(this.i0, ___cleanup_2E_b);
                            this.i0 = this.i7;
                        };
                    };
                    
                _label_10: 
                    this.i2 = 0;
                    this.i0 = ((this.i0 == 0) ? 1 : 0);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 & 0x01);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pushresult.start();
                    return;
                case 12:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _f_setvbuf");
            };
        }


    }
} cmodule.lua_wrapper

