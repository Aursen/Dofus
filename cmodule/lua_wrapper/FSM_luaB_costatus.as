package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_costatus extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;


        public static function start():void
        {
            var _local_1:FSM_luaB_costatus;
            _local_1 = new (FSM_luaB_costatus)();
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
                    public::mstate.esp = (public::mstate.esp - 224);
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 8);
                    if (!(this.i2 == 8))
                    {
                        this.i0 = 0;
                    }
                    else
                    {
                        this.i0 = li32(this.i0);
                    };
                    if (!(this.i0 == 0)) goto _label_3;
                    this.i2 = __2E_str63352;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(!(this.i0 == this.i1)))
                    {
                        this.i0 = 0;
                        goto _label_2;
                    };
                    this.i2 = li8(this.i0 + 6);
                    if (!(this.i2 == 0))
                    {
                        if (!(this.i2 == 1)) goto _label_1;
                        this.i0 = 1;
                        goto _label_2;
                    };
                    this.i2 = (public::mstate.ebp + -224);
                    this.i3 = li32(this.i0 + 20);
                    this.i4 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = 0;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i2 < 1))
                    {
                        this.i0 = 2;
                    }
                    else
                    {
                        this.i2 = li32(this.i0 + 8);
                        this.i0 = li32(this.i0 + 12);
                        this.i0 = (this.i2 - this.i0);
                        this.i0 = (this.i0 + 11);
                        this.i0 = ((uint(this.i0) < uint(23)) ? 3 : 1);
                        goto _label_2;
                        
                    _label_1: 
                        this.i0 = 3;
                    };
                    
                _label_2: 
                    this.i2 = _statnames;
                    this.i0 = (this.i0 << 2);
                    this.i0 = (this.i2 + this.i0);
                    this.i0 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_3: 
                    if (!(!(this.i0 == this.i1)))
                    {
                        this.i0 = 0;
                        goto _label_5;
                    };
                    this.i2 = li8(this.i0 + 6);
                    if (!(this.i2 == 0))
                    {
                        if (!(this.i2 == 1)) goto _label_4;
                        this.i0 = 1;
                        goto _label_5;
                    };
                    this.i2 = (public::mstate.ebp + -112);
                    this.i3 = li32(this.i0 + 20);
                    this.i4 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = 0;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i2 < 1))
                    {
                        this.i0 = 2;
                    }
                    else
                    {
                        this.i2 = li32(this.i0 + 8);
                        this.i0 = li32(this.i0 + 12);
                        this.i0 = (this.i2 - this.i0);
                        this.i0 = (this.i0 + 11);
                        this.i0 = ((uint(this.i0) < uint(23)) ? 3 : 1);
                        goto _label_5;
                        
                    _label_4: 
                        this.i0 = 3;
                    };
                    
                _label_5: 
                    goto _label_2;
                default:
                    throw ("Invalid state in _luaB_costatus");
            };
        }


    }
}

