package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_f_seek extends Machine 
    {

        public static const intRegCount:int = 9;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var f0:Number;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_f_seek;
            _local_1 = new (FSM_f_seek)();
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
                    this.i2 = __2E_str35338;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = _modenames_2E_2974;
                    this.i4 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
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
                        this.i3 = 0;
                        this.i4 = this.i3;
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
                    this.i4 = (this.i3 >> 31);
                    
                _label_3: 
                    this.i5 = _mode_2E_2973;
                    this.i2 = (this.i2 << 2);
                    this.i2 = (this.i5 + this.i2);
                    this.i2 = li32(this.i2);
                    this.i5 = li32(_val_2E_1440);
                    this.i6 = li8(___sdidinit_2E_b);
                    if (!(!(this.i6 == 0)))
                    {
                        this.i6 = _usual;
                        this.i7 = _usual_extra;
                        this.i8 = 0;
                        this.i6 = (this.i6 + 56);
                        do 
                        {
                            si32(this.i7, this.i6);
                            this.i7 = (this.i7 + 148);
                            this.i6 = (this.i6 + 88);
                            this.i8 = (this.i8 + 1);
                        } while (!(this.i8 == 17));
                        this.i6 = 1;
                        si8(this.i6, ___cleanup_2E_b);
                        si8(this.i6, ___sdidinit_2E_b);
                    };
                    this.i6 = 1;
                    public::mstate.esp = (public::mstate.esp - 20);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    si32(this.i6, (public::mstate.esp + 16));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__fseeko.start();
                    return;
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    if (!(this.i2 == 0)) goto _label_4;
                    this.i2 = (public::mstate.ebp + -8);
                    si32(this.i5, _val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__ftello.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 == 0) goto _label_5;
                    this.i0 = -1;
                    this.i2 = this.i0;
                    goto _label_6;
                    
                _label_4: 
                    this.i0 = 0;
                    this.i2 = li32(_val_2E_1440);
                    this.i3 = li32(this.i1 + 8);
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _ebuf_2E_1986;
                    this.i3 = 0x0800;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strerror_r.start();
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = (this.i1 + 8);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = 22;
                        si32(this.i0, _val_2E_1440);
                    };
                    this.i0 = __2E_str54344;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = _ebuf_2E_1986;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i3);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, this.i0);
                    this.i1 = 3;
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i3);
                    public::mstate.eax = this.i1;
                    goto _label_7;
                    
                _label_5: 
                    this.i0 = li32(public::mstate.ebp + -8);
                    this.i2 = li32(public::mstate.ebp + -4);
                    if ((this.i2 < 0))
                    {
                        this.i0 = 29;
                        si32(this.i0, _val_2E_1440);
                        this.i0 = -1;
                        this.i2 = this.i0;
                    };
                    
                _label_6: 
                    this.i3 = ((this.i2 < 0) ? 1 : 0);
                    this.i4 = ((uint(this.i0) < uint(-2147483648)) ? 1 : 0);
                    this.i2 = ((this.i2 == 0) ? 1 : 0);
                    this.i2 = ((this.i2 != 0) ? this.i4 : this.i3);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i0 = 84;
                        si32(this.i0, _val_2E_1440);
                        this.f0 = -1;
                    }
                    else
                    {
                        this.f0 = Number(this.i0);
                    };
                    this.i0 = 3;
                    this.i2 = li32(this.i1 + 8);
                    sf64(this.f0, this.i2);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    
                _label_7: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _f_seek");
            };
        }


    }
} cmodule.lua_wrapper

