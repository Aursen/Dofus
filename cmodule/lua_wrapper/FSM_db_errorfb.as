package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_db_errorfb extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_db_errorfb;
            _local_1 = new (FSM_db_errorfb)();
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
                    public::mstate.esp = (public::mstate.esp - 112);
                    this.i0 = 1;
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
                        this.i0 = 0;
                        this.i2 = this.i1;
                        goto _label_2;
                    };
                    this.i0 = li32(this.i0 + 8);
                    if (!(this.i0 == 8)) goto _label_1;
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 8);
                    if (!(this.i2 == 8))
                    {
                        this.i2 = 0;
                        this.i0 = 1;
                    }
                    else
                    {
                        this.i2 = 1;
                        this.i3 = li32(this.i0);
                        this.i0 = this.i2;
                        this.i2 = this.i3;
                    };
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i0 + 2);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_isnumber.start();
                    return;
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i4 == 0) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tointeger.start();
                    return;
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i1 + 8);
                    this.i4 = (this.i4 + -12);
                    si32(this.i4, (this.i1 + 8));
                    this.i5 = li32(this.i1 + 12);
                    this.i4 = (this.i4 - this.i5);
                    this.i4 = (this.i4 / 12);
                    if (!(this.i4 == this.i0)) goto _label_8;
                    
                _label_3: 
                    this.i4 = li32(this.i1 + 16);
                    this.i5 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    this.i6 = (this.i1 + 16);
                    if (uint(this.i5) < uint(this.i4)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i4 = __2E_str45;
                    this.i5 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 6:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i5);
                    this.i4 = 4;
                    si32(this.i4, (this.i5 + 8));
                    this.i4 = li32(this.i1 + 8);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (this.i1 + 8));
                    this.i4 = li32(this.i6);
                    this.i5 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    this.i6 = (this.i1 + 8);
                    if (uint(this.i5) < uint(this.i4)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i4 = __2E_str3160;
                    this.i5 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 8:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i5);
                    this.i4 = 4;
                    si32(this.i4, (this.i5 + 8));
                    this.i4 = li32(this.i6);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i6);
                    this.i4 = li32(this.i2 + 20);
                    this.i5 = li32(this.i2 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (public::mstate.ebp + -112);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 9:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i4 == 0) goto _label_23;
                    this.i4 = 1;
                    this.i5 = this.i3;
                    
                _label_6: 
                    this.i6 = (this.i3 + 1);
                    if (this.i6 < 13) goto _label_14;
                    if (this.i4 == 0) goto _label_14;
                    this.i4 = (public::mstate.ebp + -112);
                    this.i7 = li32(this.i2 + 20);
                    this.i8 = li32(this.i2 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (this.i5 + 11);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 10:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i7 = (this.i2 + 40);
                    this.i8 = (this.i2 + 20);
                    if (!(this.i4 == 0)) goto _label_11;
                    this.i3 = 0;
                    this.i4 = this.i3;
                    this.i3 = this.i5;
                    goto _label_22;
                    
                _label_7: 
                    this.i3 = ((this.i2 == this.i1) ? 1 : 0);
                    this.i4 = li32(this.i1 + 8);
                    this.i5 = li32(this.i1 + 12);
                    this.i4 = (this.i4 - this.i5);
                    this.i3 = (this.i3 & 0x01);
                    this.i4 = (this.i4 / 12);
                    if (this.i4 == this.i0) goto _label_3;
                    
                _label_8: 
                    this.i4 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i0 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 11:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i5 == this.i4) goto _label_24;
                    this.i4 = li32(this.i5 + 8);
                    this.i4 = (this.i4 + -3);
                    if (uint(this.i4) > uint(1)) goto _label_24;
                    this.i4 = li32(this.i1 + 16);
                    this.i5 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    this.i6 = (this.i1 + 16);
                    if (uint(this.i5) < uint(this.i4)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i4 = __2E_str10143;
                    this.i5 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 13:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i5);
                    this.i4 = 4;
                    si32(this.i4, (this.i5 + 8));
                    this.i4 = li32(this.i1 + 8);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (this.i1 + 8));
                    this.i4 = li32(this.i6);
                    this.i5 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    this.i6 = (this.i1 + 8);
                    if (uint(this.i5) < uint(this.i4)) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i4 = __2E_str3160;
                    this.i5 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 15:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i5);
                    this.i4 = 4;
                    si32(this.i4, (this.i5 + 8));
                    this.i4 = li32(this.i6);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i6);
                    this.i4 = 1;
                    goto _label_22;
                    
                _label_11: 
                    this.i4 = li32(this.i1 + 16);
                    this.i5 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    if (uint(this.i5) < uint(this.i4)) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_12: 
                    this.i4 = __2E_str4161;
                    this.i5 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 5;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 17:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, this.i5);
                    this.i4 = 4;
                    si32(this.i4, (this.i5 + 8));
                    this.i4 = li32(this.i1 + 8);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (this.i1 + 8));
                    this.i4 = li32(this.i8);
                    this.i5 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (public::mstate.ebp + -112);
                    this.i10 = (this.i3 + 11);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 18:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i4 == 0) goto _label_26;
                    this.i4 = this.i3;
                    
                _label_13: 
                    this.i3 = (public::mstate.ebp + -112);
                    this.i5 = li32(this.i8);
                    this.i6 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (this.i4 + 12);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 19:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i4 = (this.i4 + 1);
                    if (this.i3 == 0) goto _label_21;
                    goto _label_13;
                    
                _label_14: 
                    this.i3 = li32(this.i1 + 16);
                    this.i5 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    this.i7 = (this.i1 + 16);
                    if (uint(this.i5) < uint(this.i3)) goto _label_15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 20:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_15: 
                    this.i3 = __2E_str5162;
                    this.i5 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 21:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i5);
                    this.i3 = 4;
                    si32(this.i3, (this.i5 + 8));
                    this.i3 = li32(this.i1 + 8);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, (this.i1 + 8));
                    this.i3 = (public::mstate.ebp + -112);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = __2E_str6163;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getinfo.start();
                    return;
                case 22:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = __2E_str7164;
                    this.i3 = (this.i3 + 36);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 23:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(public::mstate.ebp + -92);
                    this.i8 = (this.i1 + 8);
                    if (this.i5 < 1) goto _label_16;
                    this.i9 = __2E_str8165;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 24:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_16: 
                    this.i5 = li32(public::mstate.ebp + -104);
                    this.i5 = li8(this.i5);
                    if (this.i5 == 0) goto _label_17;
                    this.i3 = __2E_str9166;
                    this.i5 = li32(public::mstate.ebp + -108);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 25:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i8);
                    this.i5 = li32(this.i1 + 12);
                    this.i3 = (this.i3 - this.i5);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 - this.i0);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = this.i6;
                    goto _label_22;
                    
                _label_17: 
                    this.i5 = li32(public::mstate.ebp + -100);
                    this.i5 = li8(this.i5);
                    if (this.i5 == 67) goto _label_18;
                    this.i9 = (this.i5 & 0xFF);
                    if (this.i9 == 116) goto _label_18;
                    this.i5 = (this.i5 & 0xFF);
                    if (!(this.i5 == 109)) goto _label_20;
                    this.i3 = __2E_str10167;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 27:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i8);
                    this.i5 = li32(this.i1 + 12);
                    this.i3 = (this.i3 - this.i5);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 - this.i0);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = this.i6;
                    goto _label_22;
                    
                _label_18: 
                    this.i3 = li32(this.i7);
                    this.i5 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i5) < uint(this.i3)) goto _label_19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 29:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_19: 
                    this.i3 = __2E_str11168;
                    this.i5 = li32(this.i8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 30:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i5);
                    this.i3 = 4;
                    si32(this.i3, (this.i5 + 8));
                    this.i3 = li32(this.i8);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i8);
                    this.i5 = li32(this.i1 + 12);
                    this.i3 = (this.i3 - this.i5);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 - this.i0);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = this.i6;
                    goto _label_22;
                    
                _label_20: 
                    this.i5 = __2E_str12169;
                    this.i7 = li32(public::mstate.ebp + -84);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i7, (public::mstate.esp + 12));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 32:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i8);
                    this.i5 = li32(this.i1 + 12);
                    this.i3 = (this.i3 - this.i5);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 - this.i0);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = this.i6;
                    goto _label_22;
                    
                _label_21: 
                    this.i3 = 0;
                    this.i5 = (this.i4 + 1);
                    this.i4 = this.i3;
                    this.i3 = this.i5;
                    
                _label_22: 
                    this.i5 = (public::mstate.ebp + -112);
                    this.i6 = li32(this.i2 + 20);
                    this.i7 = li32(this.i2 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 34:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = this.i3;
                        goto _label_6;
                    };
                    
                _label_23: 
                    this.i2 = 1;
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = li32(this.i1 + 12);
                    this.i3 = (this.i3 - this.i4);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i3 - this.i0);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 35;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 35:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.eax = this.i2;
                    goto _label_25;
                    
                _label_24: 
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    
                _label_25: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_26: 
                    this.i4 = 0;
                    this.i3 = this.i6;
                    goto _label_22;
                default:
                    throw ("Invalid state in _db_errorfb");
            };
        }


    }
}

