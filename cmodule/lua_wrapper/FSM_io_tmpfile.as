package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_io_tmpfile extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var f0:Number;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_io_tmpfile;
            _local_1 = new (FSM_io_tmpfile)();
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
                    public::mstate.esp = (public::mstate.esp - 20512);
                    this.i0 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = li32(public::mstate.ebp + 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_newuserdata.start();
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 0;
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -10000;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = __2E_str17320;
                    do 
                    {
                        this.i4 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i5 = this.i1;
                        if ((this.i4 == 0)) break;
                        this.i1 = this.i5;
                    } while (true);
                    this.i4 = __2E_str17320;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 - this.i4);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, (public::mstate.ebp + -20512));
                    this.i1 = 4;
                    si32(this.i1, (public::mstate.ebp + -20504));
                    this.i4 = li32(this.i2 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (public::mstate.ebp + -20512);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i2 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i2 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = __2E_str876;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = __2E_str14274;
                    si32(this.i0, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getenv.start();
                case 6:
                    this.i0 = public::mstate.eax;
                    this.i1 = __2E_str7280;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = ((this.i0 == 0) ? this.i1 : this.i0);
                    this.i1 = li8(this.i0);
                    this.i4 = (this.i2 + 8);
                    this.i5 = this.i0;
                    if (this.i1 == 0) goto _label_3;
                    this.i1 = this.i0;
                    do 
                    {
                        this.i6 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i7 = this.i1;
                        if (this.i6 == 0) goto _label_4;
                        this.i1 = this.i7;
                    } while (true);
                    
                _label_1: 
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + -20488);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = __2E_str340;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i1 = __2E_str138;
                    this.i5 = 34;
                    this.i6 = 78;
                    this.i7 = (public::mstate.ebp + -20480);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i5, (public::mstate.esp + 16));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i7;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i6, _val_2E_1440);
                    
                _label_2: 
                    this.i0 = 0;
                    si32(this.i0, this.i3);
                    this.i1 = li32(_val_2E_1440);
                    this.i3 = li32(this.i4);
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _ebuf_2E_1986;
                    this.i3 = 0x0800;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strerror_r.start();
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = 22;
                        si32(this.i0, _val_2E_1440);
                    };
                    this.i0 = __2E_str54344;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = _ebuf_2E_1986;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 10:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
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
                    
                _label_3: 
                    this.i1 = this.i5;
                    
                _label_4: 
                    this.i6 = __2E_str45;
                    this.i0 = (this.i1 - this.i0);
                    this.i0 = (this.i0 + this.i5);
                    this.i0 = li8(this.i0 + -1);
                    this.i1 = __2E_str5151;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = ((this.i0 == 47) ? this.i6 : this.i1);
                    this.i1 = __2E_str513;
                    this.i6 = (public::mstate.ebp + -20488);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_asprintf.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(public::mstate.ebp + -20488);
                    if (this.i0 == 0) goto _label_2;
                    this.i0 = __2E_str340;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i1 = __2E_str138;
                    this.i5 = 34;
                    this.i6 = 78;
                    this.i7 = (public::mstate.ebp + -4096);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i5, (public::mstate.esp + 16));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i7;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i6, _val_2E_1440);
                    this.i0 = li32(public::mstate.ebp + -20488);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (public::mstate.ebp + -20484);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__gettemp.start();
                    return;
                case 13:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(public::mstate.ebp + -20484);
                    this.i5 = ((this.i0 == 0) ? -1 : this.i1);
                    if (this.i5 == -1) goto _label_1;
                    this.i0 = __2E_str26;
                    this.i6 = 4;
                    this.i1 = this.i6;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i7 = __2E_str96;
                    this.i0 = __2E_str13;
                    this.i1 = 400;
                    this.i8 = 78;
                    this.i9 = (public::mstate.ebp + -8192);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    si32(this.i1, (public::mstate.esp + 16));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i10 = 3;
                    this.i0 = this.i9;
                    this.i1 = this.i10;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i8, _val_2E_1440);
                    this.i0 = li32(public::mstate.ebp + -20488);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 15:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = __2E_str340;
                    this.i1 = this.i6;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str138;
                    this.i1 = 34;
                    this.i6 = (public::mstate.ebp + -12288);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    si32(this.i1, (public::mstate.esp + 16));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i0 = this.i6;
                    this.i1 = this.i10;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i8, _val_2E_1440);
                    this.i0 = li8(_nofile_2E_3458_2E_b);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i0 = __2E_str270;
                        this.i1 = 4;
                        this.i6 = 1;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        si8(this.i6, _nofile_2E_3458_2E_b);
                    };
                    this.i0 = __2E_str32;
                    this.i1 = 4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = __2E_str96;
                    this.i1 = __2E_str13;
                    this.i6 = 345;
                    this.i7 = 78;
                    this.i8 = (public::mstate.ebp + -16384);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i6, (public::mstate.esp + 16));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i8;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i7, _val_2E_1440);
                    this.i0 = this.i5;
                    state = 18;
                case 18:
                    this.i0 = public::mstate.system.close(this.i0);
                    si32(this.i7, _val_2E_1440);
                    goto _label_2;
                default:
                    throw ("Invalid state in _io_tmpfile");
            };
        }


    }
} cmodule.lua_wrapper

