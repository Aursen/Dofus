package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_os_remove extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_os_remove;
            _local_1 = new (FSM_os_remove)();
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
                    public::mstate.esp = (public::mstate.esp - 0x3400);
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i1 = 1;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = this.i3;
                    state = 2;
                case 2:
                    this.i0 = public::mstate.system.psize(this.i0);
                    if (!(this.i0 < 0))
                    {
                        this.i0 = 0;
                        this.i1 = this.i0;
                        goto _label_1;
                    };
                    this.i0 = __2E_str655;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = 0x0400;
                    this.i4 = (public::mstate.ebp + -13312);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_snprintf.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = 0;
                    si8(this.i0, (public::mstate.ebp + -12289));
                    this.i0 = this.i4;
                    state = 4;
                case 4:
                    this.i0 = public::mstate.system.psize(this.i0);
                    if (!(this.i0 < 0))
                    {
                        this.i0 = 0;
                        this.i1 = 1;
                        goto _label_1;
                    };
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = __2E_str251;
                    this.i4 = 28;
                    this.i5 = 2;
                    this.i6 = (public::mstate.ebp + -12288);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i4, (public::mstate.esp + 16));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i6;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i5, _val_2E_1440);
                    this.i0 = 1;
                    this.i1 = 0;
                    
                _label_1: 
                    this.i0 = (this.i0 & 0x01);
                    if (!(this.i0 == 0)) goto _label_3;
                    this.i0 = (this.i1 ^ 0x01);
                    this.i0 = (this.i0 & 0x01);
                    if (!(this.i0 == 0)) goto _label_2;
                    this.i0 = __2E_str21;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i1 = __2E_str13;
                    this.i4 = 446;
                    this.i5 = 78;
                    this.i6 = (public::mstate.ebp + -4096);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i4, (public::mstate.esp + 16));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i6;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i5, _val_2E_1440);
                    goto _label_3;
                    
                _label_2: 
                    this.i0 = __2E_str26;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i1 = __2E_str13;
                    this.i4 = 400;
                    this.i5 = 78;
                    this.i6 = (public::mstate.ebp + -8192);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i4, (public::mstate.esp + 16));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i6;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i5, _val_2E_1440);
                    
                _label_3: 
                    this.i0 = 0;
                    this.i1 = li32(_val_2E_1440);
                    this.i4 = li32(this.i2 + 8);
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i2 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i2 + 8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _ebuf_2E_1986;
                    this.i4 = 0x0800;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strerror_r.start();
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = (this.i2 + 8);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = 22;
                        si32(this.i0, _val_2E_1440);
                    };
                    this.i0 = __2E_str15318;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = _ebuf_2E_1986;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i4);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, this.i0);
                    this.i1 = 3;
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i4);
                    public::mstate.eax = this.i1;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _os_remove");
            };
        }


    }
}

