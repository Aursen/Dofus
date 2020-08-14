package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_hookf extends Machine 
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
            var _local_1:FSM_hookf;
            _local_1 = new (FSM_hookf)();
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
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -10000;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 8);
                    this.i2 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = (this.i3 + -12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_get.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, (this.i3 + -12));
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i3 + -4));
                    this.i2 = li32(this.i1 + 8);
                    si32(this.i1, this.i2);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
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
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = _luaO_nilobject_;
                    if (this.i0 == this.i4) goto _label_1;
                    this.i0 = li32(this.i0 + 8);
                    if (!(this.i0 == 6)) goto _label_1;
                    this.i0 = _hooknames_2E_2751;
                    this.i4 = li32(this.i3);
                    this.i4 = (this.i4 << 2);
                    this.i0 = (this.i0 + this.i4);
                    this.i0 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i3 + 20);
                    this.i3 = li32(this.i2);
                    if (!(this.i0 < 0))
                    {
                        this.i4 = 3;
                        this.f0 = Number(this.i0);
                        sf64(this.f0, this.i3);
                        si32(this.i4, (this.i3 + 8));
                        this.i3 = li32(this.i2);
                        this.i0 = (this.i3 + 12);
                        si32(this.i0, this.i2);
                        public::mstate.esp = (public::mstate.esp - 12);
                        this.i2 = 0;
                        this.i3 = (this.i3 + -24);
                        si32(this.i1, public::mstate.esp);
                        si32(this.i3, (public::mstate.esp + 4));
                        si32(this.i2, (public::mstate.esp + 8));
                    }
                    else
                    {
                        this.i0 = 0;
                        si32(this.i0, (this.i3 + 8));
                        this.i3 = li32(this.i2);
                        this.i4 = (this.i3 + 12);
                        si32(this.i4, this.i2);
                        public::mstate.esp = (public::mstate.esp - 12);
                        this.i2 = (this.i3 + -24);
                        si32(this.i1, public::mstate.esp);
                        si32(this.i2, (public::mstate.esp + 4));
                        si32(this.i0, (public::mstate.esp + 8));
                    };
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _hookf");
            };
        }


    }
} cmodule.lua_wrapper

