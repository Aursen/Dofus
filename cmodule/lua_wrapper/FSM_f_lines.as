package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_f_lines extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_f_lines;
            _local_1 = new (FSM_f_lines)();
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
                    this.i0 = __2E_str17320;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkudata.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0);
                    if (!(this.i0 == 0)) goto _label_1;
                    this.i0 = __2E_str20323;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i3);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = (this.i2 + 12);
                    si32(this.i3, (this.i1 + 8));
                    this.i3 = 0;
                    si32(this.i3, (this.i2 + 12));
                    si32(this.i0, (this.i2 + 20));
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = _io_readline;
                    this.i3 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _f_lines");
            };
        }


    }
}

