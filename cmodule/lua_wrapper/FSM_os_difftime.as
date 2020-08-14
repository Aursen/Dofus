package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_os_difftime extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 2;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;
        public var f1:Number;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_os_difftime;
            _local_1 = new (FSM_os_difftime)();
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
                    this.i0 = 2;
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
                        this.f0 = 0;
                        goto _label_2;
                    };
                    this.i0 = li32(this.i0 + 8);
                    if (this.i0 < 1) goto _label_1;
                    this.i0 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checknumber.start();
                    return;
                case 2:
                    this.f0 = public::mstate.st0;
                    this.i0 = int(this.f0);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f0 = Number(this.i0);
                    
                _label_2: 
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checknumber.start();
                    return;
                case 3:
                    this.f1 = public::mstate.st0;
                    this.i2 = int(this.f1);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f1 = Number(this.i2);
                    this.i2 = li32(this.i1 + 8);
                    this.f0 = (this.f1 - this.f0);
                    sf64(this.f0, this.i2);
                    this.i3 = 3;
                    si32(this.i3, (this.i2 + 8));
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _os_difftime");
            };
        }


    }
} cmodule.lua_wrapper

