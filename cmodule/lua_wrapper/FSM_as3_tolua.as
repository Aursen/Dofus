package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_as3_tolua extends Machine 
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
            var _local_1:FSM_as3_tolua;
            _local_1 = new (FSM_as3_tolua)();
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
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = -10000;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    this.i2 = (this.i2 - this.i3);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = __2E_str1143;
                    this.i4 = (this.i2 / 12);
                    this.i5 = (this.i1 + 12);
                    this.i6 = (this.i1 + 8);
                    do 
                    {
                        this.i7 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i8 = this.i3;
                        if ((this.i7 == 0)) break;
                        this.i3 = this.i8;
                    } while (true);
                    this.i7 = __2E_str1143;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 2:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -16));
                    this.i3 = 4;
                    si32(this.i3, (public::mstate.ebp + -8));
                    this.i3 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    if (this.i2 < 12) goto _label_7;
                    this.i0 = 1;
                    this.i2 = (this.i4 + 1);
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i3 + 8);
                    if (!(this.i7 == 2))
                    {
                        if (!(this.i7 == 7))
                        {
                            this.i3 = 0;
                        }
                        else
                        {
                            this.i3 = li32(this.i3);
                            this.i3 = (this.i3 + 20);
                        };
                    }
                    else
                    {
                        this.i3 = li32(this.i3);
                    };
                    if (this.i3 == 0) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getmetatable.start();
                case 5:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i7 == 0)) goto _label_3;
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 6:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i6);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i7);
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i7 + 8));
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i6);
                    this.i0 = (this.i0 + 1);
                    if (this.i0 > this.i4) goto _label_7;
                    goto _label_1;
                    
                _label_3: 
                    this.i7 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = _luaO_nilobject_;
                    if (this.i7 == this.i9) goto _label_5;
                    this.i9 = _luaO_nilobject_;
                    if (this.i8 == this.i9) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_rawequalObj.start();
                case 9:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i6);
                    this.i8 = (this.i8 + -12);
                    si32(this.i8, this.i6);
                    if (this.i7 == 0) goto _label_6;
                    this.i3 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_as3_to_lua_stack_if_convertible.start();
                    return;
                case 10:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i3 == 0)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 11:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i6);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i7);
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i7 + 8));
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i6);
                    
                _label_4: 
                    this.i0 = (this.i0 + 1);
                    if (this.i0 > this.i4) goto _label_7;
                    goto _label_1;
                    
                _label_5: 
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i6);
                    
                _label_6: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 12:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i6);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i7);
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i7 + 8));
                    this.i3 = li32(this.i6);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i6);
                    this.i0 = (this.i0 + 1);
                    if (!(this.i0 > this.i4)) goto _label_1;
                    
                _label_7: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i4 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 13:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6);
                    this.i3 = this.i0;
                    this.i7 = (this.i0 + 12);
                    if (!(uint(this.i7) < uint(this.i2)))
                    {
                        this.i0 = this.i2;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i2 = this.i3;
                        
                    _label_8: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i3 = li32(this.i2 + 20);
                        si32(this.i3, (this.i2 + 8));
                        this.i2 = li32(this.i6);
                        this.i3 = (this.i0 + 12);
                        this.i7 = this.i0;
                        if (uint(this.i3) < uint(this.i2)) goto _label_19;
                        this.i0 = this.i2;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    this.i2 = li32(this.i5);
                    this.i3 = (this.i4 << 1);
                    this.i0 = (this.i0 - this.i2);
                    this.i0 = (this.i0 / 12);
                    if (this.i0 == this.i3) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i1 + 16);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    this.i7 = (this.i1 + 16);
                    if (uint(this.i2) < uint(this.i0)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i0 = __2E_str19226;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 19;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 16:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_10: 
                    this.i0 = __2E_str1100;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
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
                    this.i0 = li32(this.i6);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i6);
                    this.i2 = 0x4073F000;
                    this.i8 = 0;
                    si32(this.i8, (this.i0 + 12));
                    si32(this.i2, (this.i0 + 16));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_11: 
                    this.i0 = __2E_str2101;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 20:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i6);
                    this.f0 = Number(this.i4);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_12: 
                    this.i0 = __2E_str3102;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 22:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i6);
                    this.i8 = li32(this.i5);
                    this.i2 = (this.i2 - this.i8);
                    this.i2 = (this.i2 / 12);
                    this.i2 = (this.i2 + -7);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_13: 
                    this.i0 = __2E_str4103;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 24:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, this.i6);
                    this.f0 = Number(this.i3);
                    sf64(this.f0, (this.i0 + 12));
                    this.i2 = 3;
                    si32(this.i2, (this.i0 + 20));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_14: 
                    this.i0 = __2E_str10143;
                    this.i2 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 26:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i2);
                    this.i0 = 4;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_15: 
                    this.i0 = 10;
                    this.i2 = li32(this.i6);
                    this.i3 = li32(this.i5);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -108);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 29:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 30:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i6);
                    this.i3 = this.i0;
                    this.i8 = (this.i0 + 12);
                    if (!(uint(this.i8) < uint(this.i2)))
                    {
                        this.i0 = this.i2;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i2 = this.i3;
                        
                    _label_16: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i3 = li32(this.i2 + 20);
                        si32(this.i3, (this.i2 + 8));
                        this.i2 = li32(this.i6);
                        this.i3 = (this.i0 + 12);
                        this.i8 = this.i0;
                        if (uint(this.i3) < uint(this.i2)) goto _label_20;
                        this.i0 = this.i2;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    this.i0 = li32(this.i7);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_17: 
                    this.i0 = 2;
                    this.i2 = li32(this.i6);
                    this.i3 = li32(this.i5);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 33:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_18: 
                    public::mstate.eax = this.i4;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_19: 
                    this.i0 = this.i3;
                    this.i2 = this.i7;
                    goto _label_8;
                    
                _label_20: 
                    this.i0 = this.i3;
                    this.i2 = this.i8;
                    goto _label_16;
                default:
                    throw ("Invalid state in _as3_tolua");
            };
        }


    }
}

