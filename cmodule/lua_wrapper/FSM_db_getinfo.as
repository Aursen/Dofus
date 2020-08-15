package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_db_getinfo extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var f0:Number;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_db_getinfo;
            _local_1 = new (FSM_db_getinfo)();
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
                    public::mstate.esp = (public::mstate.esp - 260);
                    this.i0 = (public::mstate.ebp + -260);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getthread.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(public::mstate.ebp + -260);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 + 2);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = _luaO_nilobject_;
                    if (!(!(this.i3 == this.i4)))
                    {
                        
                    _label_1: 
                        this.i2 = __2E_str16266;
                        goto _label_2;
                    };
                    this.i3 = li32(this.i3 + 8);
                    if (this.i3 < 1) goto _label_1;
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i3 = li32(public::mstate.ebp + -260);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_isnumber.start();
                    return;
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(public::mstate.ebp + -260);
                    this.i4 = (this.i4 + 1);
                    if (this.i3 == 0) goto _label_3;
                    this.i3 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tointeger.start();
                    return;
                case 5:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i0 + 20);
                    this.i6 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 6:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i4 == 0)) goto _label_5;
                    this.i0 = 0;
                    this.i2 = li32(this.i1 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    goto _label_16;
                    
                _label_3: 
                    this.i3 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i4 == this.i3) goto _label_4;
                    this.i3 = li32(this.i4 + 8);
                    if (!(this.i3 == 6)) goto _label_4;
                    this.i3 = __2E_str17267;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 8:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = -1;
                    this.i3 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(public::mstate.ebp + -260);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 10:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i4);
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i4 + 8));
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = (this.i3 + 12);
                    si32(this.i4, (this.i1 + 8));
                    this.i4 = (this.i1 + 8);
                    if (!(this.i0 == this.i1))
                    {
                        this.i5 = 0;
                        si32(this.i3, this.i4);
                        this.i3 = (this.i0 + 8);
                        this.i6 = this.i5;
                        do 
                        {
                            this.i7 = li32(this.i3);
                            this.i8 = li32(this.i4);
                            this.i9 = (this.i7 + 12);
                            si32(this.i9, this.i3);
                            this.i8 = (this.i8 + this.i6);
                            this.f0 = lf64(this.i8);
                            sf64(this.f0, this.i7);
                            this.i8 = li32(this.i8 + 8);
                            si32(this.i8, (this.i7 + 8));
                            this.i6 = (this.i6 + 12);
                            this.i7 = (this.i5 + 1);
                            if ((this.i5 == 0)) break;
                            this.i5 = this.i7;
                        } while (true);
                    };
                    this.i3 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getinfo.start();
                    return;
                case 11:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i3 == 0) goto _label_20;
                    goto _label_6;
                    
                _label_4: 
                    this.i2 = __2E_str18268;
                    this.i0 = li32(public::mstate.ebp + -260);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = 0;
                    public::mstate.eax = this.i2;
                    goto _label_18;
                    
                _label_5: 
                    this.i3 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getinfo.start();
                    return;
                case 13:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i3 == 0) goto _label_20;
                    
                _label_6: 
                    this.i3 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_createtable.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li8(this.i2);
                    this.i4 = this.i2;
                    if (this.i3 == 83) goto _label_21;
                    this.i3 = this.i4;
                    do 
                    {
                        this.i5 = li8(this.i3);
                        if (!(!(this.i5 == 0)))
                        {
                            this.i3 = 0;
                            goto _label_22;
                        };
                        this.i5 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i6 = this.i3;
                        if (this.i5 == 83) goto _label_22;
                        this.i3 = this.i6;
                    } while (true);
                    
                _label_7: 
                    this.i6 = __2E_str20270;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 15:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -16));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -8));
                    this.i5 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 + -12);
                    this.i6 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i1 + 8);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, (this.i1 + 8));
                    this.i3 = (public::mstate.ebp + -256);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 + 36);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 18:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str21271;
                    this.i6 = (this.i1 + 8);
                    do 
                    {
                        this.i7 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i8 = this.i5;
                        if ((this.i7 == 0)) break;
                        this.i5 = this.i8;
                    } while (true);
                    this.i7 = __2E_str21271;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 19:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -32));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -24));
                    this.i5 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 + -12);
                    this.i7 = (public::mstate.ebp + -32);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i6);
                    this.i5 = (this.i3 + -12);
                    si32(this.i5, this.i6);
                    this.i5 = li32(public::mstate.ebp + -228);
                    this.f0 = Number(this.i5);
                    sf64(this.f0, (this.i3 + -12));
                    this.i5 = 3;
                    si32(this.i5, (this.i3 + -4));
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 21:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str22272;
                    do 
                    {
                        this.i7 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i8 = this.i5;
                        if ((this.i7 == 0)) break;
                        this.i5 = this.i8;
                    } while (true);
                    this.i7 = __2E_str22272;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 22:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -48));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -40));
                    this.i5 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 + -12);
                    this.i7 = (public::mstate.ebp + -48);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i6);
                    this.i5 = (this.i3 + -12);
                    si32(this.i5, this.i6);
                    this.i5 = li32(public::mstate.ebp + -224);
                    this.f0 = Number(this.i5);
                    sf64(this.f0, (this.i3 + -12));
                    this.i5 = 3;
                    si32(this.i5, (this.i3 + -4));
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 24:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str23273;
                    do 
                    {
                        this.i7 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i8 = this.i5;
                        if ((this.i7 == 0)) break;
                        this.i5 = this.i8;
                    } while (true);
                    this.i7 = __2E_str23273;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 25:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -64));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -56));
                    this.i5 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 + -12);
                    this.i7 = (public::mstate.ebp + -64);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i6);
                    this.i3 = li32(public::mstate.ebp + -244);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 28:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str24274;
                    do 
                    {
                        this.i7 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i8 = this.i5;
                        if ((this.i7 == 0)) break;
                        this.i5 = this.i8;
                    } while (true);
                    this.i7 = __2E_str24274;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 29:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -80));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -72));
                    this.i5 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 + -12);
                    this.i7 = (public::mstate.ebp + -80);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i6);
                    
                _label_8: 
                    this.i3 = li8(this.i2);
                    if (this.i3 == 108) goto _label_23;
                    this.i3 = this.i4;
                    do 
                    {
                        this.i5 = li8(this.i3);
                        if (!(!(this.i5 == 0)))
                        {
                            this.i3 = 0;
                            goto _label_24;
                        };
                        this.i5 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i6 = this.i3;
                        if (this.i5 == 108) goto _label_24;
                        this.i3 = this.i6;
                    } while (true);
                    
                _label_9: 
                    this.i7 = __2E_str25275366;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 31:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -96));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -88));
                    this.i5 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 + -12);
                    this.i7 = (public::mstate.ebp + -96);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i6);
                    
                _label_10: 
                    this.i3 = li8(this.i2);
                    if (this.i3 == 117) goto _label_25;
                    this.i3 = this.i4;
                    do 
                    {
                        this.i5 = li8(this.i3);
                        if (!(!(this.i5 == 0)))
                        {
                            this.i3 = 0;
                            goto _label_26;
                        };
                        this.i5 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i6 = this.i3;
                        if (this.i5 == 117) goto _label_26;
                        this.i3 = this.i6;
                    } while (true);
                    
                _label_11: 
                    this.i7 = __2E_str26276;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 33:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -112));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -104));
                    this.i5 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 + -12);
                    this.i7 = (public::mstate.ebp + -112);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i6);
                    
                _label_12: 
                    this.i3 = li8(this.i2);
                    if (this.i3 == 110) goto _label_27;
                    this.i3 = this.i4;
                    do 
                    {
                        this.i5 = li8(this.i3);
                        if (!(!(this.i5 == 0)))
                        {
                            this.i3 = 0;
                            goto _label_28;
                        };
                        this.i5 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i6 = this.i3;
                        if (this.i5 == 110) goto _label_28;
                        this.i3 = this.i6;
                    } while (true);
                    
                _label_13: 
                    this.i6 = __2E_str27277;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 35:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -128));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -120));
                    this.i5 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 + -12);
                    this.i6 = (public::mstate.ebp + -128);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 36:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i1 + 8);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, (this.i1 + 8));
                    this.i3 = li32(public::mstate.ebp + -248);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 37:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 38:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str28278;
                    this.i6 = (this.i1 + 8);
                    do 
                    {
                        this.i7 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i8 = this.i5;
                        if ((this.i7 == 0)) break;
                        this.i5 = this.i8;
                    } while (true);
                    this.i7 = __2E_str28278;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 39:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -144));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -136));
                    this.i5 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i5 + -12);
                    this.i7 = (public::mstate.ebp + -144);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 40:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i6);
                    
                _label_14: 
                    this.i3 = li8(this.i2);
                    if (this.i3 == 76) goto _label_29;
                    this.i3 = this.i4;
                    do 
                    {
                        this.i5 = li8(this.i3);
                        if (!(!(this.i5 == 0)))
                        {
                            this.i3 = 0;
                            goto _label_30;
                        };
                        this.i5 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i6 = this.i3;
                        if (this.i5 == 76) goto _label_30;
                        this.i3 = this.i6;
                    } while (true);
                    
                _label_15: 
                    if (this.i2 == 0) goto _label_16;
                    this.i2 = __2E_str30280;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 41;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_treatstackoption.start();
                    return;
                case 41:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_16: 
                    this.i0 = 1;
                    
                _label_17: 
                    public::mstate.eax = this.i0;
                    
                _label_18: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_19: 
                    this.i3 = li8(this.i2 + 1);
                    this.i2 = (this.i2 + 1);
                    this.i4 = this.i2;
                    if (this.i3 == 102) goto _label_15;
                    this.i2 = this.i4;
                    goto _label_32;
                    
                _label_20: 
                    this.i0 = __2E_str19269;
                    this.i2 = li32(public::mstate.ebp + -260);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + 2);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 42;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 42:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = 0;
                    goto _label_17;
                    
                _label_21: 
                    this.i3 = this.i2;
                    
                _label_22: 
                    if (this.i3 == 0) goto _label_8;
                    this.i3 = -2;
                    this.i5 = li32(public::mstate.ebp + -240);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 43:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 44:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str20270;
                    do 
                    {
                        this.i6 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i7 = this.i5;
                        if (this.i6 == 0) goto _label_7;
                        this.i5 = this.i7;
                    } while (true);
                    
                _label_23: 
                    this.i3 = this.i2;
                    
                _label_24: 
                    if (this.i3 == 0) goto _label_10;
                    this.i3 = 3;
                    this.i5 = li32(public::mstate.ebp + -236);
                    this.i6 = li32(this.i1 + 8);
                    this.f0 = Number(this.i5);
                    sf64(this.f0, this.i6);
                    si32(this.i3, (this.i6 + 8));
                    this.i3 = li32(this.i1 + 8);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 45:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str25275366;
                    this.i6 = (this.i1 + 8);
                    do 
                    {
                        this.i7 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i8 = this.i5;
                        if (this.i7 == 0) goto _label_9;
                        this.i5 = this.i8;
                    } while (true);
                    
                _label_25: 
                    this.i3 = this.i2;
                    
                _label_26: 
                    if (this.i3 == 0) goto _label_12;
                    this.i3 = 3;
                    this.i5 = li32(public::mstate.ebp + -232);
                    this.i6 = li32(this.i1 + 8);
                    this.f0 = Number(this.i5);
                    sf64(this.f0, this.i6);
                    si32(this.i3, (this.i6 + 8));
                    this.i3 = li32(this.i1 + 8);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 46:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str26276;
                    this.i6 = (this.i1 + 8);
                    do 
                    {
                        this.i7 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i8 = this.i5;
                        if (this.i7 == 0) goto _label_11;
                        this.i5 = this.i8;
                    } while (true);
                    
                _label_27: 
                    this.i3 = this.i2;
                    
                _label_28: 
                    if (this.i3 == 0) goto _label_14;
                    this.i3 = -2;
                    this.i5 = li32(public::mstate.ebp + -252);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 47:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 48:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str27277;
                    do 
                    {
                        this.i6 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i7 = this.i5;
                        if (this.i6 == 0) goto _label_13;
                        this.i5 = this.i7;
                    } while (true);
                    
                _label_29: 
                    this.i3 = this.i2;
                    
                _label_30: 
                    if (this.i3 == 0) goto _label_31;
                    this.i3 = __2E_str29279;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 49;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_treatstackoption.start();
                    return;
                case 49:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_31: 
                    this.i3 = li8(this.i2);
                    //unresolved if
                    this.i2 = this.i4;
                    
                _label_32: 
                    this.i3 = li8(this.i2);
                    if (!(this.i3 == 0)) goto _label_19;
                    this.i2 = 0;
                    goto _label_15;
                default:
                    throw ("Invalid state in _db_getinfo");
            };
        }


    }
}

