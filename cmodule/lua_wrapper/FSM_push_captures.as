package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_push_captures extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;


        public static function start():void
        {
            var _local_1:FSM_push_captures;
            _local_1 = new (FSM_push_captures)();
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
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(public::mstate.ebp + 16);
                    if (!(!(this.i1 == 0)))
                    {
                        if (!(this.i3 == 0)) goto _label_2;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_checkstack.start();
                    return;
                case 1:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i5 == 0)) goto _label_1;
                    this.i5 = __2E_str10185328;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = __2E_str23453;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    if (!(this.i1 > 0))
                    {
                        this.i0 = this.i1;
                        goto _label_5;
                    };
                    this.i2 = this.i1;
                    goto _label_3;
                    
                _label_2: 
                    this.i1 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_checkstack.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i1 == 0))
                    {
                        this.i2 = 1;
                        goto _label_3;
                    };
                    this.i1 = __2E_str10185328;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = __2E_str23453;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = 1;
                    
                _label_3: 
                    this.i1 = this.i2;
                    this.i2 = 0;
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_onecapture.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = (this.i2 + 1);
                    if (!(this.i2 < this.i1))
                    {
                        this.i0 = this.i1;
                        
                    _label_5: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    goto _label_4;
                default:
                    throw ("Invalid state in _push_captures");
            };
        }


    }
} cmodule.lua_wrapper

