package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_argerror extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_luaL_argerror;
            _local_1 = new (FSM_luaL_argerror)();
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
                    public::mstate.esp = (public::mstate.esp - 112);
                    this.i0 = (public::mstate.ebp + -112);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 20);
                    this.i3 = li32(this.i1 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = 0;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i0 == 0)) goto _label_3;
                    this.i0 = __2E_str3178321;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    
                _label_1: 
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_2: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_3: 
                    this.i0 = __2E_str515;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (public::mstate.ebp + -112);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getinfo.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(public::mstate.ebp + -104);
                    this.i4 = li8(this.i0);
                    if (!(this.i4 == 109))
                    {
                        this.i0 = __2E_str7264;
                    }
                    else
                    {
                        this.i5 = __2E_str7264;
                        this.i6 = 0;
                        do 
                        {
                            this.i7 = (this.i5 + this.i6);
                            this.i7 = (this.i7 + 1);
                            this.i4 = (this.i4 & 0xFF);
                            if (this.i4 == 0) goto _label_4;
                            this.i4 = (this.i0 + this.i6);
                            this.i4 = li8(this.i4 + 1);
                            this.i7 = li8(this.i7);
                            this.i6 = (this.i6 + 1);
                        } while (!(!(this.i4 == this.i7)));
                        this.i0 = __2E_str7264;
                        this.i0 = (this.i0 + this.i6);
                    };
                    this.i0 = li8(this.i0);
                    this.i4 = (this.i4 & 0xFF);
                    if ((this.i4 == this.i0))
                    {
                        
                    _label_4: 
                        this.i0 = (this.i2 + -1);
                        if (this.i2 == 1) goto _label_5;
                        this.i2 = this.i0;
                    };
                    this.i0 = this.i2;
                    this.i2 = (public::mstate.ebp + -112);
                    this.i4 = li32(public::mstate.ebp + -108);
                    this.i2 = (this.i2 + 4);
                    if (!(!(this.i4 == 0)))
                    {
                        this.i4 = __2E_str6354;
                        si32(this.i4, this.i2);
                        public::mstate.esp = (public::mstate.esp - 20);
                        this.i2 = __2E_str8183326;
                    }
                    else
                    {
                        this.i2 = __2E_str8183326;
                        public::mstate.esp = (public::mstate.esp - 20);
                    };
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    si32(this.i3, (public::mstate.esp + 16));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 20);
                    goto _label_2;
                    
                _label_5: 
                    this.i2 = __2E_str6181324;
                    this.i0 = li32(public::mstate.ebp + -108);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    goto _label_1;
                default:
                    throw ("Invalid state in _luaL_argerror");
            };
        }


    }
}

