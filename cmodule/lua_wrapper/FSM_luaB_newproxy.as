package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_newproxy extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_luaB_newproxy;
            _local_1 = new (FSM_luaB_newproxy)();
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
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 12);
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = (this.i0 + 12);
                    this.i4 = (this.i0 + 8);
                    this.i5 = (this.i1 + 12);
                    if (!(uint(this.i2) < uint(this.i5)))
                    {
                        this.i2 = this.i1;
                        goto _label_2;
                        
                    _label_1: 
                        this.i2 = this.i1;
                    };
                    this.i1 = 0;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = (this.i2 + 12);
                    si32(this.i1, this.i4);
                    this.i5 = li32(this.i3);
                    if (this.i2 < this.i5) goto _label_1;
                    this.i2 = this.i5;
                    
                _label_2: 
                    this.i1 = this.i2;
                    this.i2 = 0;
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_newuserdata.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 8);
                    if (this.i2 == 0) goto _label_3;
                    if (!(!(this.i2 == 1)))
                    {
                        this.i1 = li32(this.i1);
                        if (this.i1 == 0) goto _label_3;
                    };
                    this.i1 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (this.i1 == this.i2) goto _label_5;
                    this.i1 = li32(this.i1 + 8);
                    if (!(this.i1 == 1)) goto _label_5;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i2);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i4);
                    this.i2 = (this.i1 + 12);
                    si32(this.i2, this.i4);
                    this.i2 = 1;
                    si32(this.i2, (this.i1 + 12));
                    si32(this.i2, (this.i1 + 20));
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = -10003;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawset.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = 2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.eax = this.i2;
                    goto _label_4;
                    
                _label_3: 
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    
                _label_4: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_5: 
                    this.i1 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getmetatable.start();
                case 8:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i1 == 0) goto _label_6;
                    this.i1 = -10003;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 9:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.i1 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i2 + -12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_get.start();
                case 10:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, (this.i2 + -12));
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i2 + -4));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 11:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 8);
                    if (!(this.i2 == 0))
                    {
                        if (!(this.i2 == 1)) goto _label_7;
                        this.i2 = li32(this.i4);
                        this.i1 = li32(this.i1);
                        this.i2 = (this.i2 + -12);
                        si32(this.i2, this.i4);
                        if (this.i1 == 0) goto _label_6;
                        goto _label_8;
                    };
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i4);
                    
                _label_6: 
                    this.i4 = __2E_str62351;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_8;
                    
                _label_7: 
                    this.i1 = li32(this.i4);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i4);
                    
                _label_8: 
                    this.i1 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getmetatable.start();
                case 13:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 14:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.eax = this.i1;
                    goto _label_4;
                default:
                    throw ("Invalid state in _luaB_newproxy");
            };
        }


    }
} cmodule.lua_wrapper

