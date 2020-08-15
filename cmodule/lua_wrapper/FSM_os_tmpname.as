package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_os_tmpname extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;


        public static function start():void
        {
            var _local_1:FSM_os_tmpname;
            _local_1 = new (FSM_os_tmpname)();
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
                    public::mstate.esp = (public::mstate.esp - 48);
                    this.i0 = (public::mstate.ebp + -48);
                    this.i1 = __2E_str12394;
                    this.i2 = 16;
                    memcpy(this.i0, this.i1, this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (public::mstate.ebp + -4);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__gettemp.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(public::mstate.ebp + -4);
                    this.i1 = ((this.i1 == 0) ? -1 : this.i2);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = this.i0;
                    if (this.i1 == -1) goto _label_1;
                    this.i4 = 1;
                    this.i0 = this.i1;
                    state = 2;
                case 2:
                    this.i0 = public::mstate.system.close(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.eax = this.i4;
                    goto _label_2;
                    
                _label_1: 
                    this.i0 = __2E_str13395;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    
                _label_2: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _os_tmpname");
            };
        }


    }
}

