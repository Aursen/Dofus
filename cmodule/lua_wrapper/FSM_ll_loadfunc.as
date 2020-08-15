package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_ll_loadfunc extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_ll_loadfunc;
            _local_1 = new (FSM_ll_loadfunc)();
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
                    this.i0 = __2E_str5476;
                    this.i1 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = __2E_str6477;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -10000;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = (this.i3 + -12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = (this.i1 + 8);
                    this.i4 = _luaO_nilobject_;
                    if (!(this.i0 == this.i4))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (this.i0 == 0) goto _label_1;
                    };
                    this.i2 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i2 + 8);
                    if (!(this.i0 == 2))
                    {
                        if (!(this.i0 == 7))
                        {
                            this.i2 = 0;
                        }
                        else
                        {
                            this.i2 = li32(this.i2);
                            this.i2 = (this.i2 + 20);
                        };
                    }
                    else
                    {
                        this.i2 = li32(this.i2);
                    };
                    this.i0 = li32(this.i2);
                    if (!(this.i0 == 0)) goto _label_4;
                    goto _label_2;
                    
                _label_1: 
                    this.i0 = 4;
                    this.i4 = li32(this.i3);
                    this.i4 = (this.i4 + -12);
                    si32(this.i4, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_newuserdata.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = 0;
                    si32(this.i4, this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = -10000;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = __2E_str4475;
                    do 
                    {
                        this.i6 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i7 = this.i5;
                        if ((this.i6 == 0)) break;
                        this.i5 = this.i7;
                    } while (true);
                    this.i6 = __2E_str4475;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 - this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 8:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i5, (public::mstate.ebp + -16));
                    this.i5 = 4;
                    si32(this.i5, (public::mstate.ebp + -8));
                    this.i5 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i4 = li32(this.i3);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = __2E_str5476;
                    this.i6 = __2E_str6477;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 11:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 12:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i3);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i4);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i4 + 8));
                    this.i2 = li32(this.i3);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -10000;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 13:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (this.i4 + -24);
                    this.i4 = (this.i4 + -12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i3);
                    this.i2 = (this.i2 + -24);
                    si32(this.i2, this.i3);
                    this.i2 = li32(this.i0);
                    if (!(this.i2 == 0))
                    {
                        this.i2 = this.i0;
                        goto _label_4;
                    };
                    this.i2 = this.i0;
                    
                _label_2: 
                    this.i0 = li32(this.i1 + 16);
                    this.i4 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i4) < uint(this.i0)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    this.i0 = __2E_str7478;
                    this.i4 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 58;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 16:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, this.i4);
                    this.i0 = 4;
                    si32(this.i0, (this.i4 + 8));
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i3);
                    this.i0 = 0;
                    si32(this.i0, this.i2);
                    
                _label_4: 
                    this.i0 = this.i2;
                    this.i0 = li32(this.i0);
                    if (this.i0 == 0) goto _label_6;
                    this.i0 = li32(this.i1 + 16);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 17:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i0 = __2E_str7478;
                    this.i2 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 58;
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
                    this.i0 = 2;
                    goto _label_7;
                    
                _label_6: 
                    this.i0 = 1;
                    
                _label_7: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _ll_loadfunc");
            };
        }


    }
}

