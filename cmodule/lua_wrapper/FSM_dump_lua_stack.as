package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_dump_lua_stack extends Machine 
    {

        public static const intRegCount:int = 14;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
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
            var _local_1:FSM_dump_lua_stack;
            _local_1 = new (FSM_dump_lua_stack)();
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
                    public::mstate.esp = (public::mstate.esp - 1040);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 8);
                    this.i2 = li32(this.i0 + 12);
                    this.i3 = (this.i1 - this.i2);
                    this.i4 = (this.i3 / 12);
                    this.i5 = (this.i0 + 12);
                    this.i6 = (this.i0 + 8);
                    this.i7 = li32(public::mstate.ebp + 12);
                    this.i8 = (this.i3 + 11);
                    if (uint(this.i8) > uint(22)) goto _label_2;
                    this.i1 = li32(this.i0 + 16);
                    this.i2 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    if (uint(this.i2) < uint(this.i1)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i1 = __2E_str198;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 20;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i6);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i6);
                    this.i2 = li32(this.i5);
                    this.i1 = (this.i1 - this.i2);
                    this.i2 = (this.i4 + 1);
                    this.i1 = (this.i1 / 12);
                    if (this.i1 == this.i2) goto _label_10;
                    this.i1 = __2E_str8206;
                    goto _label_9;
                    
                _label_2: 
                    this.i8 = _luaB_tostring;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 3:
                    this.i8 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, (public::mstate.ebp + -1032));
                    this.i10 = (this.i8 + 12);
                    si32(this.i10, (public::mstate.ebp + -1040));
                    si32(this.i9, (public::mstate.ebp + -1036));
                    this.i9 = (this.i8 + 4);
                    this.i8 = (this.i8 + 8);
                    if (this.i3 < 12) goto _label_7;
                    this.i1 = (this.i1 - this.i2);
                    this.i1 = (this.i1 / 12);
                    this.i2 = (this.i4 + 1);
                    
                _label_3: 
                    this.i3 = __2E_str2200;
                    this.i10 = __2E_str1199;
                    this.i3 = ((this.i1 == this.i7) ? this.i3 : this.i10);
                    this.i10 = li8(this.i3);
                    this.i11 = this.i3;
                    if (this.i10 == 0) goto _label_11;
                    this.i10 = this.i3;
                    do 
                    {
                        this.i12 = li8(this.i10 + 1);
                        this.i10 = (this.i10 + 1);
                        this.i13 = this.i10;
                        if (this.i12 == 0) goto _label_12;
                        this.i10 = this.i13;
                    } while (true);
                    
                _label_4: 
                    this.i10 = this.i11;
                    
                _label_5: 
                    this.i12 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i10 - this.i3);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i10 = _luaO_nilobject_;
                    if (!(!(this.i3 == this.i10)))
                    {
                        this.i3 = -1;
                    }
                    else
                    {
                        this.i3 = li32(this.i3 + 8);
                    };
                    if (!(!(this.i3 == -1)))
                    {
                        this.i3 = __2E_str2251;
                    }
                    else
                    {
                        this.i10 = _luaT_typenames;
                        this.i3 = (this.i3 << 2);
                        this.i3 = (this.i10 + this.i3);
                        this.i3 = li32(this.i3);
                    };
                    this.i10 = li8(this.i3);
                    this.i11 = this.i3;
                    if (this.i10 == 0) goto _label_13;
                    this.i10 = this.i11;
                    do 
                    {
                        this.i12 = li8(this.i10 + 1);
                        this.i10 = (this.i10 + 1);
                        this.i13 = this.i10;
                        if (this.i12 == 0) goto _label_14;
                        this.i10 = this.i13;
                    } while (true);
                    
                _label_6: 
                    this.i10 = __2E_str5203;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i11 = (public::mstate.ebp + -1040);
                    this.i3 = (this.i3 - this.i10);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i10 = li32(this.i6);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i10);
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i10 + 8));
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i10 = li32(this.i6);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i10);
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i10 + 8));
                    this.i3 = li32(this.i6);
                    this.i10 = (this.i3 + 12);
                    si32(this.i10, this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 1;
                    this.i3 = (this.i3 + -12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i11, public::mstate.esp);
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addvalue.start();
                    return;
                case 10:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = __2E_str6204;
                    do 
                    {
                        this.i10 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i11 = this.i3;
                        if ((this.i10 == 0)) break;
                        this.i3 = this.i11;
                    } while (true);
                    this.i10 = __2E_str6204;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i11 = (public::mstate.ebp + -1040);
                    this.i3 = (this.i3 - this.i10);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = (this.i1 + -1);
                    if (!(this.i1 < 1)) goto _label_3;
                    
                _label_7: 
                    this.i1 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 12:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = li32(this.i9);
                    this.i2 = li32(this.i8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = 1;
                    si32(this.i1, this.i9);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 14:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6);
                    this.i3 = this.i1;
                    this.i7 = (this.i1 + 12);
                    if (!(uint(this.i7) < uint(this.i2)))
                    {
                        this.i1 = this.i2;
                    }
                    else
                    {
                        this.i1 = (this.i1 + 12);
                        this.i2 = this.i3;
                        
                    _label_8: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i3 = li32(this.i2 + 20);
                        si32(this.i3, (this.i2 + 8));
                        this.i2 = li32(this.i6);
                        this.i3 = (this.i1 + 12);
                        this.i7 = this.i1;
                        if (uint(this.i3) < uint(this.i2)) goto _label_15;
                        this.i1 = this.i2;
                    };
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i6);
                    this.i2 = li32(this.i5);
                    this.i1 = (this.i1 - this.i2);
                    this.i2 = (this.i4 + 1);
                    this.i1 = (this.i1 / 12);
                    if (this.i1 == this.i2) goto _label_10;
                    this.i1 = __2E_str7205;
                    
                _label_9: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_10: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_11: 
                    this.i10 = this.i11;
                    
                _label_12: 
                    this.i12 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i10 - this.i3);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 16:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i6);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, this.i3);
                    this.i10 = 3;
                    si32(this.i10, (this.i3 + 8));
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i6);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i12, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addvalue.start();
                    return;
                case 17:
                    this.i3 = __2E_str4202;
                    this.i10 = __2E_str3201;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = ((this.i1 == this.i7) ? this.i3 : this.i10);
                    this.i10 = li8(this.i3);
                    this.i11 = this.i3;
                    if (this.i10 == 0) goto _label_4;
                    this.i10 = this.i3;
                    do 
                    {
                        this.i12 = li8(this.i10 + 1);
                        this.i10 = (this.i10 + 1);
                        this.i13 = this.i10;
                        if (this.i12 == 0) goto _label_5;
                        this.i10 = this.i13;
                    } while (true);
                    
                _label_13: 
                    this.i10 = this.i3;
                    
                _label_14: 
                    this.i12 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = (this.i10 - this.i11);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_addlstring.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = __2E_str5203;
                    do 
                    {
                        this.i10 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i11 = this.i3;
                        if (this.i10 == 0) goto _label_6;
                        this.i3 = this.i11;
                    } while (true);
                    
                _label_15: 
                    this.i1 = this.i3;
                    this.i2 = this.i7;
                    goto _label_8;
                default:
                    throw ("Invalid state in _dump_lua_stack");
            };
        }


    }
} cmodule.lua_wrapper

