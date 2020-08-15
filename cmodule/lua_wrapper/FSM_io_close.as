package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_io_close extends Machine 
    {

        public static const intRegCount:int = 3;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_io_close;
            _local_1 = new (FSM_io_close)();
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
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (!(this.i0 == this.i2))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (!(this.i0 == -1)) goto _label_3;
                    };
                    this.i0 = -10001;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = __2E_str17320;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkudata.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0);
                    if (!(this.i0 == 0)) goto _label_1;
                    this.i0 = __2E_str20323;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_aux_close.start();
                    return;
                case 6:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.eax = this.i1;
                    
                _label_2: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_3: 
                    this.i0 = __2E_str17320;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkudata.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0);
                    if (!(this.i0 == 0)) goto _label_4;
                    this.i0 = __2E_str20323;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_aux_close.start();
                    return;
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.eax = this.i0;
                    goto _label_2;
                default:
                    throw ("Invalid state in _io_close");
            };
        }


    }
}

