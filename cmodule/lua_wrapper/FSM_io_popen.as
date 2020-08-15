package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_io_popen extends Machine 
    {

        public static const intRegCount:int = 9;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_io_popen;
            _local_1 = new (FSM_io_popen)();
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
                    public::mstate.esp = (public::mstate.esp - 0x1010);
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 2;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = _luaO_nilobject_;
                    if (!(!(this.i0 == this.i1)))
                    {
                        
                    _label_1: 
                        this.i0 = __2E_str19170;
                        goto _label_2;
                    };
                    this.i0 = li32(this.i0 + 8);
                    if (this.i0 < 1) goto _label_1;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = 2;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i1 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_newuserdata.start();
                    return;
                case 4:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = 0;
                    si32(this.i1, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -10000;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str17320;
                    this.i6 = this.i0;
                    do 
                    {
                        this.i7 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i8 = this.i5;
                        if ((this.i7 == 0)) break;
                        this.i5 = this.i8;
                    } while (true);
                    this.i7 = __2E_str17320;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i7);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 6:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -4112));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -4104));
                    this.i5 = li32(this.i2 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = (public::mstate.ebp + -4112);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i2 + 8);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i2 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -2;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i1 = 0;
                    si32(this.i1, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fflush.start();
                    return;
                case 9:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = li8(this.i0);
                    if (!(this.i1 == 43))
                    {
                        this.i5 = this.i6;
                        do 
                        {
                            this.i6 = li8(this.i5);
                            if (!(!(this.i6 == 0)))
                            {
                                this.i5 = 0;
                                goto _label_3;
                            };
                            this.i6 = li8(this.i5 + 1);
                            this.i5 = (this.i5 + 1);
                            this.i7 = this.i5;
                            if (this.i6 == 43) goto _label_3;
                            this.i5 = this.i7;
                        } while (true);
                    };
                    this.i5 = this.i0;
                    
                _label_3: 
                    if (!(!(this.i5 == 0)))
                    {
                        this.i5 = (this.i1 & 0xFF);
                        if (!(this.i5 == 114))
                        {
                            this.i1 = (this.i1 & 0xFF);
                            if (!(this.i1 == 119)) goto _label_4;
                        };
                        this.i0 = li8(this.i0 + 1);
                        if (!(this.i0 == 0)) goto _label_4;
                    };
                    this.i0 = __2E_str31;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i1 = __2E_str13;
                    this.i5 = 353;
                    this.i6 = 78;
                    this.i7 = (public::mstate.ebp + -4096);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i5, (public::mstate.esp + 16));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i7;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i6, _val_2E_1440);
                    
                _label_4: 
                    this.i0 = 0;
                    si32(this.i0, this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pushresult.start();
                    return;
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _io_popen");
            };
        }


    }
}

