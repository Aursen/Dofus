package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_do_pcall_with_traceback extends Machine 
    {

        public static const intRegCount:int = 13;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
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
            var _local_1:FSM_do_pcall_with_traceback;
            _local_1 = new (FSM_do_pcall_with_traceback)();
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
                    this.i0 = -10002;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 - this.i3);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i0 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i2 = public::mstate.eax;
                    this.i4 = (this.i0 - this.i3);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = __2E_str18175;
                    this.i5 = (this.i4 + -1);
                    this.i6 = (this.i1 + 12);
                    this.i7 = (this.i1 + 8);
                    this.i8 = sxi8(li8(public::mstate.ebp + 16));
                    do 
                    {
                        this.i9 = li8(this.i0 + 1);
                        this.i0 = (this.i0 + 1);
                        this.i10 = this.i0;
                        if ((this.i9 == 0)) break;
                        this.i0 = this.i10;
                    } while (true);
                    this.i9 = __2E_str18175;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 - this.i9);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, (public::mstate.ebp + -112));
                    this.i0 = 4;
                    si32(this.i0, (public::mstate.ebp + -104));
                    this.i0 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (public::mstate.ebp + -112);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (!(this.i0 == this.i2))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (this.i0 == 5) goto _label_1;
                    };
                    this.i8 = __2E_str19176;
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i7);
                    this.i2 = 0;
                    this.i0 = this.i8;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i8 = this.i2;
                    goto _label_2;
                    
                _label_1: 
                    this.i0 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str20177;
                    do 
                    {
                        this.i9 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i10 = this.i2;
                        if ((this.i9 == 0)) break;
                        this.i2 = this.i10;
                    } while (true);
                    this.i9 = __2E_str20177;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i9);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -32));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -24));
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (public::mstate.ebp + -32);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 8);
                    if (!(this.i2 == 0))
                    {
                        if (!(this.i2 == 1))
                        {
                            this.i0 = 1;
                        }
                        else
                        {
                            this.i0 = li32(this.i0);
                            this.i0 = ((this.i0 != 0) ? 1 : 0);
                            this.i0 = (this.i0 & 0x01);
                        };
                    }
                    else
                    {
                        this.i0 = 0;
                    };
                    this.i2 = 1;
                    this.i9 = li32(this.i7);
                    this.i8 = (this.i8 & 0xFF);
                    this.i8 = ((this.i8 != 0) ? 1 : 0);
                    this.i10 = (this.i9 + -12);
                    si32(this.i10, this.i7);
                    this.i8 = (this.i8 & 0x01);
                    si32(this.i8, (this.i9 + -12));
                    si32(this.i2, (this.i9 + -4));
                    this.i8 = li32(this.i7);
                    this.i8 = (this.i8 + 12);
                    si32(this.i8, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 9:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = __2E_str20177;
                    do 
                    {
                        this.i9 = li8(this.i2 + 1);
                        this.i2 = (this.i2 + 1);
                        this.i10 = this.i2;
                        if ((this.i9 == 0)) break;
                        this.i2 = this.i10;
                    } while (true);
                    this.i9 = __2E_str20177;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 - this.i9);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 10:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -16));
                    this.i2 = 4;
                    si32(this.i2, (public::mstate.ebp + -8));
                    this.i2 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i9 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i8 = li32(this.i7);
                    this.i8 = (this.i8 + -24);
                    si32(this.i8, this.i7);
                    this.i8 = this.i0;
                    
                _label_2: 
                    this.i0 = this.i8;
                    this.i2 = _db_errorfb;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushcclosure.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 13:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i7);
                    this.i9 = this.i8;
                    if (!(uint(this.i8) <= uint(this.i2)))
                    {
                        this.i10 = 0;
                        do 
                        {
                            this.i11 = (this.i10 ^ 0xFFFFFFFF);
                            this.i11 = (this.i11 * 12);
                            this.i11 = (this.i9 + this.i11);
                            this.f0 = lf64(this.i11);
                            sf64(this.f0, this.i8);
                            this.i12 = li32(this.i11 + 8);
                            si32(this.i12, (this.i8 + 8));
                            this.i8 = (this.i8 + -12);
                            this.i10 = (this.i10 + 1);
                        } while (!(uint(this.i11) <= uint(this.i2)));
                    };
                    this.i8 = li32(this.i7);
                    this.f0 = lf64(this.i8);
                    sf64(this.f0, this.i2);
                    this.i8 = li32(this.i8 + 8);
                    si32(this.i8, (this.i2 + 8));
                    this.i2 = (this.i3 + this.i5);
                    this.i8 = li32(this.i7);
                    this.i9 = li32(this.i6);
                    this.i8 = (this.i8 - this.i9);
                    this.i2 = (this.i2 + 2);
                    this.i8 = (this.i8 / 12);
                    if (this.i8 == this.i2) goto _label_13;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i1 + 16);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    this.i4 = (this.i1 + 16);
                    if (uint(this.i3) < uint(this.i0)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    this.i0 = __2E_str23180;
                    this.i3 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 14;
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
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i4);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_4: 
                    this.i0 = __2E_str1100;
                    this.i3 = li32(this.i7);
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
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i7);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i7);
                    this.i3 = 0x406D0000;
                    this.i8 = 0;
                    si32(this.i8, (this.i0 + 12));
                    si32(this.i3, (this.i0 + 16));
                    this.i3 = 3;
                    si32(this.i3, (this.i0 + 20));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i4);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i0 = __2E_str2101;
                    this.i3 = li32(this.i7);
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
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i7);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i7);
                    this.f0 = Number(this.i5);
                    sf64(this.f0, (this.i0 + 12));
                    this.i3 = 3;
                    si32(this.i3, (this.i0 + 20));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i4);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 21:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i0 = __2E_str3102;
                    this.i3 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 22:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i7);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i7);
                    this.i5 = li32(this.i6);
                    this.i3 = (this.i3 - this.i5);
                    this.i3 = (this.i3 / 12);
                    this.i3 = (this.i3 + -7);
                    this.f0 = Number(this.i3);
                    sf64(this.f0, (this.i0 + 12));
                    this.i3 = 3;
                    si32(this.i3, (this.i0 + 20));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i4);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 23:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_7: 
                    this.i0 = __2E_str4103;
                    this.i3 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 24:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i7);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i7);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, (this.i0 + 12));
                    this.i3 = 3;
                    si32(this.i3, (this.i0 + 20));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i4);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_8: 
                    this.i0 = __2E_str10143;
                    this.i3 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 26:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 4;
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i4);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 27;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 27:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    this.i0 = 10;
                    this.i3 = li32(this.i7);
                    this.i5 = li32(this.i6);
                    this.i3 = (this.i3 - this.i5);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 28;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 28:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + -108);
                    si32(this.i0, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 29:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i7);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i3);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i3 + 8));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 30:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i7);
                    this.i5 = this.i0;
                    this.i2 = (this.i0 + 12);
                    if (!(uint(this.i2) < uint(this.i3)))
                    {
                        this.i0 = this.i3;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i3 = this.i5;
                        
                    _label_10: 
                        this.f0 = lf64(this.i3 + 12);
                        sf64(this.f0, this.i3);
                        this.i5 = li32(this.i3 + 20);
                        si32(this.i5, (this.i3 + 8));
                        this.i3 = li32(this.i7);
                        this.i5 = (this.i0 + 12);
                        this.i2 = this.i0;
                        if (uint(this.i5) < uint(this.i3)) goto _label_27;
                        this.i0 = this.i3;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i7);
                    this.i0 = li32(this.i4);
                    this.i3 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i3) < uint(this.i0)) goto _label_11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 31;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 31:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_11: 
                    this.i0 = 2;
                    this.i3 = li32(this.i7);
                    this.i4 = li32(this.i6);
                    this.i3 = (this.i3 - this.i4);
                    this.i3 = (this.i3 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 32:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 0;
                    this.i3 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 33:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i7);
                    this.i0 = __2E_str157;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i1;
                    
                _label_12: 
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    state = 34;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 34:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_13: 
                    if (!(!(this.i5 == 0)))
                    {
                        this.i2 = 0;
                        goto _label_14;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 35:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i1 + 32);
                    this.i2 = (this.i2 - this.i8);
                    
                _label_14: 
                    this.i8 = -1;
                    this.i3 = (this.i3 ^ 0xFFFFFFFF);
                    this.i9 = li32(this.i7);
                    this.i3 = (this.i3 * 12);
                    this.i3 = (this.i9 + this.i3);
                    si32(this.i3, (public::mstate.ebp + -40));
                    si32(this.i8, (public::mstate.ebp + -36));
                    this.i8 = li32(this.i1 + 32);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i9 = _f_call;
                    this.i3 = (this.i3 - this.i8);
                    this.i8 = (public::mstate.ebp + -40);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_pcall.start();
                    return;
                case 36:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i3 = li32(this.i1 + 20);
                    this.i8 = li32(this.i7);
                    this.i9 = li32(this.i3 + 8);
                    this.i3 = (this.i3 + 8);
                    if (!(uint(this.i8) < uint(this.i9)))
                    {
                        si32(this.i8, this.i3);
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 37:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i7);
                    this.i9 = this.i3;
                    this.i10 = (this.i3 + 12);
                    if (!(uint(this.i10) < uint(this.i8)))
                    {
                        this.i3 = this.i8;
                    }
                    else
                    {
                        this.i3 = (this.i3 + 12);
                        this.i8 = this.i9;
                        
                    _label_15: 
                        this.f0 = lf64(this.i8 + 12);
                        sf64(this.f0, this.i8);
                        this.i9 = li32(this.i8 + 20);
                        si32(this.i9, (this.i8 + 8));
                        this.i8 = li32(this.i7);
                        this.i9 = (this.i3 + 12);
                        this.i10 = this.i3;
                        if (uint(this.i9) < uint(this.i8)) goto _label_28;
                        this.i3 = this.i8;
                    };
                    this.i8 = -10002;
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 38:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = __2E_str18175;
                    do 
                    {
                        this.i9 = li8(this.i8 + 1);
                        this.i8 = (this.i8 + 1);
                        this.i10 = this.i8;
                        if ((this.i9 == 0)) break;
                        this.i8 = this.i10;
                    } while (true);
                    this.i9 = __2E_str18175;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 - this.i9);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 39;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 39:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, (public::mstate.ebp + -64));
                    this.i8 = 4;
                    si32(this.i8, (public::mstate.ebp + -56));
                    this.i8 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = (public::mstate.ebp + -64);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 40:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i7);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 41:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = _luaO_nilobject_;
                    if (!(!(this.i3 == this.i8)))
                    {
                        this.i3 = 0;
                    }
                    else
                    {
                        this.i3 = li32(this.i3 + 8);
                        this.i3 = ((this.i3 == 5) ? 1 : 0);
                    };
                    this.i3 = (this.i3 & 0x01);
                    if (!(!(this.i3 == 0)))
                    {
                        this.i0 = __2E_str19176;
                        this.i3 = li32(this.i7);
                        this.i3 = (this.i3 + -12);
                        si32(this.i3, this.i7);
                        trace(public::mstate.gworker.stringFromPtr(this.i0));
                        if (!(this.i2 == 0))
                        {
                            goto _label_17;
                        };
                        
                    _label_16: 
                        public::mstate.eax = this.i2;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i3 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 42:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = __2E_str20177;
                    do 
                    {
                        this.i9 = li8(this.i8 + 1);
                        this.i8 = (this.i8 + 1);
                        this.i10 = this.i8;
                        if ((this.i9 == 0)) break;
                        this.i8 = this.i10;
                    } while (true);
                    this.i9 = __2E_str20177;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 - this.i9);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 43;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 43:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i8, (public::mstate.ebp + -80));
                    this.i8 = 4;
                    si32(this.i8, (public::mstate.ebp + -72));
                    this.i8 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = (public::mstate.ebp + -80);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 44;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 44:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i7);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 45:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i7);
                    this.i0 = ((this.i0 != 0) ? 1 : 0);
                    this.i8 = (this.i3 + -12);
                    si32(this.i8, this.i7);
                    this.i0 = (this.i0 & 0x01);
                    si32(this.i0, (this.i3 + -12));
                    this.i0 = 1;
                    si32(this.i0, (this.i3 + -4));
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 46:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = this.i9;
                    do 
                    {
                        this.i8 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i9 = this.i3;
                        if ((this.i8 == 0)) break;
                        this.i3 = this.i9;
                    } while (true);
                    this.i8 = __2E_str20177;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 47:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -96));
                    this.i3 = 4;
                    si32(this.i3, (public::mstate.ebp + -88));
                    this.i3 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = (this.i3 + -12);
                    this.i8 = (public::mstate.ebp + -96);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 48;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 48:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + -24);
                    si32(this.i0, this.i7);
                    if (this.i2 == 0) goto _label_16;
                    
                _label_17: 
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 49;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_gc.start();
                    return;
                case 49:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i7);
                    this.i3 = li32(this.i6);
                    this.i0 = (this.i0 - this.i3);
                    this.i0 = (this.i0 / 12);
                    if (this.i0 == this.i4) goto _label_16;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 50;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_dump_lua_stack.start();
                    return;
                case 50:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 16);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    this.i3 = (this.i1 + 16);
                    if (uint(this.i0) < uint(this.i2)) goto _label_18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 51;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 51:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_18: 
                    this.i2 = __2E_str23180;
                    this.i0 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 14;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 52;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 52:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i0);
                    this.i2 = 4;
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i7);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i7);
                    this.i2 = li32(this.i3);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 53;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 53:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_19: 
                    this.i2 = __2E_str1100;
                    this.i0 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 54;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 54:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i0);
                    this.i2 = 4;
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i7);
                    this.i0 = (this.i2 + 12);
                    si32(this.i0, this.i7);
                    this.i0 = 0x406F2000;
                    this.i8 = 0;
                    si32(this.i8, (this.i2 + 12));
                    si32(this.i0, (this.i2 + 16));
                    this.i0 = 3;
                    si32(this.i0, (this.i2 + 20));
                    this.i2 = li32(this.i7);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i7);
                    this.i2 = li32(this.i3);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 55;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 55:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_20: 
                    this.i2 = __2E_str2101;
                    this.i0 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = 38;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 56;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 56:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i0);
                    this.i2 = 4;
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i7);
                    this.i0 = (this.i2 + 12);
                    si32(this.i0, this.i7);
                    this.f0 = Number(this.i5);
                    sf64(this.f0, (this.i2 + 12));
                    this.i0 = 3;
                    si32(this.i0, (this.i2 + 20));
                    this.i2 = li32(this.i7);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i7);
                    this.i2 = li32(this.i3);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 57;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 57:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_21: 
                    this.i2 = __2E_str3102;
                    this.i0 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 16;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 58;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 58:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i0);
                    this.i2 = 4;
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i7);
                    this.i0 = (this.i2 + 12);
                    si32(this.i0, this.i7);
                    this.i5 = li32(this.i6);
                    this.i0 = (this.i0 - this.i5);
                    this.i0 = (this.i0 / 12);
                    this.i0 = (this.i0 + -7);
                    this.f0 = Number(this.i0);
                    sf64(this.f0, (this.i2 + 12));
                    this.i0 = 3;
                    si32(this.i0, (this.i2 + 20));
                    this.i2 = li32(this.i7);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i7);
                    this.i2 = li32(this.i3);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 59;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 59:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_22: 
                    this.i2 = __2E_str4103;
                    this.i0 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 18;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 60;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 60:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i0);
                    this.i2 = 4;
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i7);
                    this.i0 = (this.i2 + 12);
                    si32(this.i0, this.i7);
                    this.f0 = Number(this.i4);
                    sf64(this.f0, (this.i2 + 12));
                    this.i0 = 3;
                    si32(this.i0, (this.i2 + 20));
                    this.i2 = li32(this.i7);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i7);
                    this.i2 = li32(this.i3);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 61;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 61:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_23: 
                    this.i2 = __2E_str10143;
                    this.i0 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 62;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 62:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i0);
                    this.i2 = 4;
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i7);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i7);
                    this.i2 = li32(this.i3);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 63;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 63:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_24: 
                    this.i2 = 10;
                    this.i0 = li32(this.i7);
                    this.i4 = li32(this.i6);
                    this.i0 = (this.i0 - this.i4);
                    this.i0 = (this.i0 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 64;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 64:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i7);
                    this.i2 = (this.i2 + -108);
                    si32(this.i2, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 65:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i7);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i0);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i0 + 8));
                    this.i2 = li32(this.i7);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 66:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i7);
                    this.i4 = this.i2;
                    this.i5 = (this.i2 + 12);
                    if (!(uint(this.i5) < uint(this.i0)))
                    {
                        this.i2 = this.i0;
                    }
                    else
                    {
                        this.i2 = (this.i2 + 12);
                        this.i0 = this.i4;
                        
                    _label_25: 
                        this.f0 = lf64(this.i0 + 12);
                        sf64(this.f0, this.i0);
                        this.i4 = li32(this.i0 + 20);
                        si32(this.i4, (this.i0 + 8));
                        this.i0 = li32(this.i7);
                        this.i4 = (this.i2 + 12);
                        this.i5 = this.i2;
                        if (uint(this.i4) < uint(this.i0)) goto _label_29;
                        this.i2 = this.i0;
                    };
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i7);
                    this.i2 = li32(this.i3);
                    this.i0 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i0) < uint(this.i2)) goto _label_26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 67;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 67:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_26: 
                    this.i2 = 2;
                    this.i0 = li32(this.i7);
                    this.i3 = li32(this.i6);
                    this.i0 = (this.i0 - this.i3);
                    this.i0 = (this.i0 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 68;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 68:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i7);
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i7);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 0;
                    this.i3 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 69;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 69:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i7);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i7);
                    this.i0 = __2E_str157;
                    trace(public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i2;
                    goto _label_12;
                    
                _label_27: 
                    this.i0 = this.i5;
                    this.i3 = this.i2;
                    goto _label_10;
                    
                _label_28: 
                    this.i3 = this.i9;
                    this.i8 = this.i10;
                    goto _label_15;
                    
                _label_29: 
                    this.i2 = this.i4;
                    this.i0 = this.i5;
                    goto _label_25;
                default:
                    throw ("Invalid state in _do_pcall_with_traceback");
            };
        }


    }
}

