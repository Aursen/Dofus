package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_getfenv extends Machine 
    {

        public static const intRegCount:int = 3;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_luaB_getfenv;
            _local_1 = new (FSM_luaB_getfenv)();
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
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getfunc.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 8);
                    if (!(this.i2 == 6)) goto _label_1;
                    this.i0 = li32(this.i0);
                    this.i0 = li8(this.i0 + 6);
                    if (this.i0 == 0) goto _label_1;
                    this.i0 = -10002;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    this.i1 = 1;
                    public::mstate.eax = this.i1;
                    goto _label_2;
                    
                _label_1: 
                    this.i0 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getfenv.start();
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    
                _label_2: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaB_getfenv");
            };
        }


    }
}

