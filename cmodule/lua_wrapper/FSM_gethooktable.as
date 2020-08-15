package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_gethooktable extends Machine 
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
            var _local_1:FSM_gethooktable;
            _local_1 = new (FSM_gethooktable)();
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
                    this.i0 = _KEY_HOOK;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    si32(this.i0, this.i2);
                    this.i0 = 2;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -10000;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
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
                case 2:
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
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = (this.i1 + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(this.i0 == this.i3))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (this.i0 == 5) goto _label_1;
                    };
                    this.i0 = 1;
                    this.i3 = li32(this.i2);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i2);
                    this.i3 = _KEY_HOOK;
                    si32(this.i3, this.i0);
                    this.i3 = 2;
                    si32(this.i3, (this.i0 + 8));
                    this.i0 = li32(this.i2);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i2);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i3);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i2);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -10000;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawset.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _gethooktable");
            };
        }


    }
}

