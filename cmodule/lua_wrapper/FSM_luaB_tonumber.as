package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_tonumber extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;
        public var i4:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_luaB_tonumber;
            _local_1 = new (FSM_luaB_tonumber)();
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
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (!(!(this.i0 == this.i2)))
                    {
                        
                    _label_1: 
                        this.i0 = 10;
                        goto _label_2;
                    };
                    this.i0 = li32(this.i0 + 8);
                    if (this.i0 < 1) goto _label_1;
                    this.i0 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    if (!(this.i0 == 10)) goto _label_4;
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (!(this.i0 == this.i2))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (!(this.i0 == -1)) goto _label_3;
                    };
                    this.i0 = __2E_str11186329;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_isnumber.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 == 0) goto _label_8;
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tonumber.start();
                    return;
                case 6:
                    this.f0 = public::mstate.st0;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 8);
                    sf64(this.f0, this.i2);
                    this.i3 = 3;
                    si32(this.i3, (this.i2 + 8));
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    goto _label_9;
                    
                _label_4: 
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = (this.i0 + -2);
                    if (uint(this.i3) < uint(35)) goto _label_5;
                    this.i3 = __2E_str34234;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (public::mstate.ebp + -4);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtoul.start();
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(public::mstate.ebp + -4);
                    if (this.i2 == this.i3) goto _label_8;
                    this.i2 = this.i3;
                    goto _label_6;
                    
                _label_5: 
                    this.i3 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtoul.start();
                case 10:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(public::mstate.ebp + -4);
                    if (!(this.i2 == this.i3))
                    {
                        this.i2 = this.i3;
                        
                    _label_6: 
                        this.i3 = li8(this.i2);
                        this.i4 = li32(__CurrentRuneLocale);
                        this.i3 = (this.i3 << 2);
                        this.i3 = (this.i4 + this.i3);
                        this.i3 = li32(this.i3 + 52);
                        this.i3 = (this.i3 & 0x4000);
                        if (this.i3 == 0) goto _label_11;
                        do 
                        {
                            this.i3 = (this.i2 + 1);
                            si32(this.i3, (public::mstate.ebp + -4));
                            this.i2 = li8(this.i2 + 1);
                            this.i2 = (this.i2 << 2);
                            this.i2 = (this.i4 + this.i2);
                            this.i2 = li32(this.i2 + 52);
                            this.i2 = (this.i2 & 0x4000);
                            if ((this.i2 == 0)) break;
                            this.i2 = this.i3;
                        } while (true);
                        this.i2 = this.i3;
                        
                    _label_7: 
                        this.i2 = li8(this.i2);
                        if (!(!(this.i2 == 0)))
                        {
                            this.i2 = 3;
                            this.i3 = li32(this.i1 + 8);
                            this.f0 = Number(uint(this.i0));
                            sf64(this.f0, this.i3);
                            si32(this.i2, (this.i3 + 8));
                            this.i0 = li32(this.i1 + 8);
                            this.i0 = (this.i0 + 12);
                            si32(this.i0, (this.i1 + 8));
                            this.i1 = 1;
                            public::mstate.eax = this.i1;
                            goto _label_10;
                        };
                    };
                    
                _label_8: 
                    this.i0 = 0;
                    this.i2 = li32(this.i1 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = 1;
                    
                _label_9: 
                    public::mstate.eax = this.i0;
                    
                _label_10: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_11: 
                    goto _label_7;
                default:
                    throw ("Invalid state in _luaB_tonumber");
            };
        }


    }
}

