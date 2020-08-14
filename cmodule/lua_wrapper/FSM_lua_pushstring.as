package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_pushstring extends Machine 
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
            var _local_1:FSM_lua_pushstring;
            _local_1 = new (FSM_lua_pushstring)();
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
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = this.i1;
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = 0;
                        this.i2 = li32(this.i0 + 8);
                        si32(this.i1, (this.i2 + 8));
                        
                    _label_1: 
                        this.i1 = li32(this.i0 + 8);
                        this.i1 = (this.i1 + 12);
                        si32(this.i1, (this.i0 + 8));
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i3 = li8(this.i1);
                    if (!(this.i3 == 0))
                    {
                        this.i3 = this.i2;
                        do 
                        {
                            this.i4 = li8(this.i3 + 1);
                            this.i3 = (this.i3 + 1);
                            this.i5 = this.i3;
                            if (this.i4 == 0) goto _label_2;
                            this.i3 = this.i5;
                        } while (true);
                    };
                    this.i3 = this.i1;
                    
                _label_2: 
                    this.i4 = li32(this.i0 + 16);
                    this.i5 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    this.i2 = (this.i3 - this.i2);
                    if (uint(this.i5) < uint(this.i4)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    this.i3 = 4;
                    this.i4 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i4);
                    si32(this.i3, (this.i4 + 8));
                    goto _label_1;
                default:
                    throw ("Invalid state in _lua_pushstring");
            };
        }


    }
} cmodule.lua_wrapper

