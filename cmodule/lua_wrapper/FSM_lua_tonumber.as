package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_tonumber extends Machine 
    {

        public static const intRegCount:int = 2;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_lua_tonumber;
            _local_1 = new (FSM_lua_tonumber)();
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
                    public::mstate.esp = (public::mstate.esp - 32);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i0 + 8);
                    if (!(this.i1 == 4))
                    {
                        if (!(!(this.i1 == 3)))
                        {
                            goto _label_3;
                        };
                        
                    _label_1: 
                        this.i0 = 0;
                        goto _label_2;
                    };
                    this.i1 = (public::mstate.ebp + -8);
                    this.i0 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i0 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_str2d.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 == 0) goto _label_1;
                    this.i0 = 3;
                    this.f0 = lf64(public::mstate.ebp + -8);
                    sf64(this.f0, (public::mstate.ebp + -32));
                    si32(this.i0, (public::mstate.ebp + -24));
                    this.i0 = (public::mstate.ebp + -32);
                    
                _label_2: 
                    if (!(this.i0 == 0))
                    {
                        
                    _label_3: 
                        this.f0 = lf64(this.i0);
                        
                    _label_4: 
                        public::mstate.st0 = this.f0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.f0 = 0;
                    goto _label_4;
                default:
                    throw ("Invalid state in _lua_tonumber");
            };
        }


    }
}

