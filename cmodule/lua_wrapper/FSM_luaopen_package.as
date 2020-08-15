package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaopen_package extends Machine 
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
            var _local_1:FSM_luaopen_package;
            _local_1 = new (FSM_luaopen_package)();
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
                    this.i0 = __2E_str4475;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_newmetatable.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _gctm;
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str1186;
                    do 
                    {
                        this.i3 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i4 = this.i2;
                        if ((this.i3 == 0)) break;
                        this.i2 = this.i4;
                    } while (true);
                    this.i3 = __2E_str1186;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i3);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
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
                    this.i3 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = (this.i3 + -12);
                    this.i4 = (public::mstate.ebp + -80);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = __2E_str44513;
                    this.i3 = _pk_funcs;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_register.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i3);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -10001;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_replace.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = _loaders;
                    this.i2 = 1;
                    this.i3 = (this.i1 + 8);
                    
                _label_1: 
                    this.i4 = 0;
                    this.i5 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i0 + 4);
                    this.i2 = (this.i2 + 1);
                    this.i0 = (this.i0 + 4);
                    if (!(this.i4 == 0)) goto _label_1;
                    this.i0 = -2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 12:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str30499;
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str30499;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 13:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -48));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -40));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i4 = (public::mstate.ebp + -48);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = __2E_str19489;
                    this.i2 = __2E_str45514;
                    this.i4 = __2E_str46515;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_setpath.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = __2E_str23492;
                    this.i2 = __2E_str47516;
                    this.i4 = __2E_str48517;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_setpath.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i1 + 16);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i0 = __2E_str49518;
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 9;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 18:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 19:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str50519;
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str50519;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 20:
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
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = __2E_str13188331;
                    this.i2 = 2;
                    this.i4 = -10000;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_findtable.start();
                    return;
                case 22:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 23:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str51520;
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str51520;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 24:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -32));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -24));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i4 = (public::mstate.ebp + -32);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 27:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str25494;
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str25494;
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
                    this.i0 = -10002;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 30:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i3);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _ll_funcs;
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_register.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 12);
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
                    throw ("Invalid state in _luaopen_package");
            };
        }


    }
}

