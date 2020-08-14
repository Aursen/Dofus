package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_getmetafield extends Machine 
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
            var _local_1:FSM_luaL_getmetafield;
            _local_1 = new (FSM_luaL_getmetafield)();
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
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getmetatable.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    this.i2 = li32(public::mstate.ebp + 12);
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 == 0) goto _label_3;
                    this.i0 = -2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i0 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i2 + -12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_get.start();
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, (this.i2 + -12));
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + -4));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = (this.i1 + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(this.i0 == this.i3))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (!(!(this.i0 == 0)))
                        {
                            this.i1 = 0;
                            this.i0 = li32(this.i2);
                            this.i0 = (this.i0 + -24);
                            goto _label_2;
                        };
                    };
                    this.i0 = -2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i2);
                    this.i3 = this.i0;
                    this.i4 = (this.i0 + 12);
                    if (!(uint(this.i4) < uint(this.i1)))
                    {
                        this.i0 = this.i1;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i1 = this.i3;
                        
                    _label_1: 
                        this.f0 = lf64(this.i1 + 12);
                        sf64(this.f0, this.i1);
                        this.i3 = li32(this.i1 + 20);
                        si32(this.i3, (this.i1 + 8));
                        this.i1 = li32(this.i2);
                        this.i3 = (this.i0 + 12);
                        this.i4 = this.i0;
                        if (uint(this.i3) < uint(this.i1)) goto _label_5;
                        this.i0 = this.i1;
                    };
                    this.i1 = 1;
                    this.i0 = (this.i0 + -12);
                    
                _label_2: 
                    si32(this.i0, this.i2);
                    public::mstate.eax = this.i1;
                    goto _label_4;
                    
                _label_3: 
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    
                _label_4: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_5: 
                    this.i0 = this.i3;
                    this.i1 = this.i4;
                    goto _label_1;
                default:
                    throw ("Invalid state in _luaL_getmetafield");
            };
        }


    }
} cmodule.lua_wrapper

