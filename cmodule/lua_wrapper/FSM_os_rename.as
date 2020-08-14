package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_os_rename extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_os_rename;
            _local_1 = new (FSM_os_rename)();
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
                    public::mstate.esp = (public::mstate.esp - 0x1000);
                    this.i2 = 0;
                    this.i3 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 1;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 1:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 2;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = __2E_str2987;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i1 = __2E_str13;
                    this.i5 = 368;
                    this.i6 = 78;
                    this.i7 = (public::mstate.ebp + -4096);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i5, (public::mstate.esp + 16));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i7;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i6, _val_2E_1440);
                    this.i0 = li32(this.i3 + 8);
                    si32(this.i2, (this.i0 + 8));
                    this.i0 = li32(this.i3 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i3 + 8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _ebuf_2E_1986;
                    this.i1 = 0x0800;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strerror_r.start();
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = (this.i3 + 8);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = 22;
                        si32(this.i0, _val_2E_1440);
                    };
                    this.i0 = __2E_str15318;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = _ebuf_2E_1986;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i1);
                    this.i2 = 0x40538000;
                    this.i3 = 0;
                    si32(this.i3, this.i0);
                    si32(this.i2, (this.i0 + 4));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 8));
                    this.i0 = li32(this.i1);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i1);
                    public::mstate.eax = this.i2;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _os_rename");
            };
        }


    }
} cmodule.lua_wrapper

