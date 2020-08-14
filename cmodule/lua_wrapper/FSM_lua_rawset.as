package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_rawset extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 2;

        public var f1:Number;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_lua_rawset;
            _local_1 = new (FSM_lua_rawset)();
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
                    public::mstate.esp = (public::mstate.esp - 0);
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = li32(public::mstate.ebp + 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i3 + -24);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_get.start();
                case 2:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si8(this.i0, (this.i4 + 6));
                    this.i0 = (this.i1 + 8);
                    this.i7 = _luaO_nilobject_;
                    if (!(this.i6 == this.i7))
                    {
                        this.i4 = this.i6;
                        goto _label_3;
                    };
                    this.i6 = li32(this.i3 + -16);
                    if (this.i6 == 3) goto _label_1;
                    if (!(this.i6 == 0)) goto _label_2;
                    this.i6 = __2E_str3127;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 4:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_3;
                    
                _label_1: 
                    this.f0 = 0;
                    this.f1 = lf64(this.i3 + -24);
                    if ((!(this.f1 == Number.NaN)) && (!(this.f0 == Number.NaN))) goto _label_2;
                    this.i6 = __2E_str4128;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 6:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_3;
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.f0 = lf64(this.i3 + -12);
                    sf64(this.f0, this.i4);
                    this.i3 = li32(this.i3 + -4);
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i0);
                    this.i4 = li32(this.i3 + -4);
                    if (!(this.i4 < 4))
                    {
                        this.i4 = li32(this.i3 + -12);
                        this.i4 = li8(this.i4 + 5);
                        this.i4 = (this.i4 & 0x03);
                        if (!(this.i4 == 0))
                        {
                            this.i2 = li32(this.i2);
                            this.i4 = li8(this.i2 + 5);
                            this.i5 = (this.i2 + 5);
                            this.i6 = (this.i4 & 0x04);
                            if (!(this.i6 == 0))
                            {
                                this.i3 = li32(this.i1 + 16);
                                this.i1 = (this.i4 & 0xFFFFFFFB);
                                si8(this.i1, this.i5);
                                this.i1 = li32(this.i3 + 40);
                                si32(this.i1, (this.i2 + 24));
                                si32(this.i2, (this.i3 + 40));
                                this.i3 = li32(this.i0);
                                this.i3 = (this.i3 + -24);
                                si32(this.i3, this.i0);
                                goto _label_4;
                            };
                        };
                    };
                    this.i1 = (this.i3 + -24);
                    si32(this.i1, this.i0);
                    
                _label_4: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _lua_rawset");
            };
        }


    }
} cmodule.lua_wrapper

