package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_dofile extends Machine 
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
            var _local_1:FSM_luaB_dofile;
            _local_1 = new (FSM_luaB_dofile)();
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
                    if (!(!(this.i0 == this.i2)))
                    {
                        
                    _label_1: 
                        this.i0 = 0;
                        goto _label_2;
                    };
                    this.i0 = li32(this.i0 + 8);
                    if (this.i0 < 1) goto _label_1;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_loadfile.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    this.i2 = (this.i2 - this.i3);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = (this.i2 / 12);
                    this.i3 = (this.i1 + 12);
                    this.i4 = (this.i1 + 8);
                    if (this.i0 == 0) goto _label_4;
                    this.i0 = -1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i5 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 + -12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i1 + 20);
                    this.i0 = li32(this.i4);
                    this.i5 = li32(this.i1 + 8);
                    this.i1 = (this.i1 + 8);
                    if (!(uint(this.i0) < uint(this.i5)))
                    {
                        si32(this.i0, this.i1);
                    };
                    this.i1 = li32(this.i4);
                    this.i3 = li32(this.i3);
                    this.i1 = (this.i1 - this.i3);
                    this.i1 = (this.i1 / 12);
                    this.i1 = (this.i1 - this.i2);
                    public::mstate.eax = this.i1;
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_4: 
                    this.i0 = -1;
                    this.i5 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 + -12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i1 + 20);
                    this.i1 = li32(this.i4);
                    this.i5 = li32(this.i0 + 8);
                    this.i0 = (this.i0 + 8);
                    if (!(uint(this.i1) < uint(this.i5)))
                    {
                        si32(this.i1, this.i0);
                    };
                    this.i0 = li32(this.i4);
                    this.i1 = li32(this.i3);
                    this.i0 = (this.i0 - this.i1);
                    this.i0 = (this.i0 / 12);
                    this.i0 = (this.i0 - this.i2);
                    public::mstate.eax = this.i0;
                    goto _label_3;
                default:
                    throw ("Invalid state in _luaB_dofile");
            };
        }


    }
}

