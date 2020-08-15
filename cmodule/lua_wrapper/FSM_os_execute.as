package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_os_execute extends Machine 
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
            var _local_1:FSM_os_execute;
            _local_1 = new (FSM_os_execute)();
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
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = li32(public::mstate.ebp + 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = _luaO_nilobject_;
                    if (this.i0 == this.i1) goto _label_1;
                    this.i0 = li32(this.i0 + 8);
                    if (this.i0 < 1) goto _label_1;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = 1;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i0 = __2E_str47;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i1 = __2E_str13;
                    this.i3 = 145;
                    this.i4 = 78;
                    this.i5 = (public::mstate.ebp + -4096);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i3, (public::mstate.esp + 16));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i3 = 3;
                    this.i0 = this.i5;
                    this.i1 = this.i3;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i4, _val_2E_1440);
                    this.i0 = li32(this.i2 + 8);
                    this.i1 = -1074790400;
                    this.i4 = 0;
                    si32(this.i4, this.i0);
                    si32(this.i1, (this.i0 + 4));
                    si32(this.i3, (this.i0 + 8));
                    this.i0 = li32(this.i2 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _os_execute");
            };
        }


    }
}

