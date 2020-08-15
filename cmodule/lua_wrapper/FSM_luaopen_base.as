package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaopen_base extends Machine 
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
            var _local_1:FSM_luaopen_base;
            _local_1 = new (FSM_luaopen_base)();
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
                    public::mstate.esp = (public::mstate.esp - 96);
                    this.i0 = -10002;
                    this.i1 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i3);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str68357;
                    this.i3 = (this.i1 + 8);
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str68357;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -96));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -88));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i5 = (public::mstate.ebp + -96);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _base_funcs;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_register.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i1 + 16);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    this.i4 = (this.i1 + 16);
                    if (uint(this.i2) < uint(this.i0)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i0 = __2E_str69358;
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 7;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -10002;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str70359;
                    do 
                    {
                        this.i5 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i6 = this.i2;
                        if ((this.i5 == 0)) break;
                        this.i2 = this.i6;
                    } while (true);
                    this.i5 = __2E_str70359;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i5);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -48));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -40));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i5 = (public::mstate.ebp + -48);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _ipairsaux;
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _luaB_ipairs;
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 13:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str71360;
                    do 
                    {
                        this.i5 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i6 = this.i2;
                        if ((this.i5 == 0)) break;
                        this.i2 = this.i6;
                    } while (true);
                    this.i5 = __2E_str71360;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i5);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
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
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _luaB_next;
                    this.i2 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _luaB_pairs;
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 18:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str72361;
                    do 
                    {
                        this.i5 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i6 = this.i2;
                        if ((this.i5 == 0)) break;
                        this.i2 = this.i6;
                    } while (true);
                    this.i5 = __2E_str72361;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i5);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 19:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -16));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -8));
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i5 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 22:
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 23:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i4);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 24:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i0 = __2E_str73362;
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 25:
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
                case 26:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str14142;
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str14142;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 27:
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
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _luaB_newproxy;
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -10002;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 30:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str75364;
                    do 
                    {
                        this.i4 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i5 = this.i2;
                        if ((this.i4 == 0)) break;
                        this.i2 = this.i5;
                    } while (true);
                    this.i4 = __2E_str75364;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 31:
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
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = __2E_str76365;
                    this.i2 = _co_funcs;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_register.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = 2;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaopen_base");
            };
        }


    }
}

