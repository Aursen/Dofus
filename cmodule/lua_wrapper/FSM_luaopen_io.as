package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaopen_io extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_luaopen_io;
            _local_1 = new (FSM_luaopen_io)();
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
                    public::mstate.esp = (public::mstate.esp - 80);
                    this.i0 = __2E_str17320;
                    this.i1 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_newmetatable.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
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
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str11139;
                    this.i3 = (this.i1 + 8);
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str11139;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -80));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -72));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i4 = (public::mstate.ebp + -80);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _flib;
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_register.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _io_fclose;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str22325;
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str22325;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 10:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -32));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -24));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i5 = (public::mstate.ebp + -32);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -10001;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_replace.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = __2E_str41344;
                    this.i2 = _iolib;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_register.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _io_noclose;
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 16:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = this.i4;
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str22325;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 17:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -16));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -8));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i4 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    this.i0 = ___sF;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = __2E_str42345;
                    this.i4 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_createstdfile.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = __2E_str43346;
                    this.i4 = 2;
                    this.i5 = (this.i0 + 88);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_createstdfile.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = __2E_str44347;
                    this.i0 = (this.i0 + 176);
                    this.i4 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_createstdfile.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 22:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str6309;
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str6309;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 23:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -48));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -40));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = (public::mstate.ebp + -48);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _io_pclose;
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 27:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str22325;
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str22325;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 28:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -64));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -56));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i4 = (public::mstate.ebp + -64);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setfenv.start();
                case 30:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaopen_io");
            };
        }


    }
}

