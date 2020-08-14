package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_createstdfile extends Machine 
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
            var _local_1:FSM_createstdfile;
            _local_1 = new (FSM_createstdfile)();
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
                    public::mstate.esp = (public::mstate.esp - 48);
                    this.i0 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_newuserdata.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = 0;
                    si32(this.i2, this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -10000;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(public::mstate.ebp + 20);
                    this.i4 = __2E_str17320;
                    this.i5 = li32(public::mstate.ebp + 12);
                    this.i6 = li32(public::mstate.ebp + 16);
                    this.i7 = this.i3;
                    do 
                    {
                        this.i8 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i9 = this.i4;
                        if ((this.i8 == 0)) break;
                        this.i4 = this.i9;
                    } while (true);
                    this.i8 = __2E_str17320;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 - this.i8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, (public::mstate.ebp + -48));
                    this.i4 = 4;
                    si32(this.i4, (public::mstate.ebp + -40));
                    this.i4 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -48);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setmetatable.start();
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i5, this.i0);
                    this.i0 = (this.i1 + 8);
                    if (this.i6 < 1) goto _label_1;
                    this.i2 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i0);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i4);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i4 + 8));
                    this.i2 = li32(this.i0);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i0);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = -10001;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i0);
                    this.f0 = lf64(this.i4);
                    sf64(this.f0, this.i5);
                    this.i4 = li32(this.i4 + 8);
                    si32(this.i4, (this.i5 + 8));
                    this.i4 = li32(this.i0);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setfenv.start();
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 10:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li8(this.i3);
                    if (this.i4 == 0) goto _label_2;
                    do 
                    {
                        this.i4 = li8(this.i7 + 1);
                        this.i7 = (this.i7 + 1);
                        this.i5 = this.i7;
                        if (this.i4 == 0) goto _label_3;
                        this.i7 = this.i5;
                    } while (true);
                    
                _label_1: 
                    this.i2 = -2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 11:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i0);
                    this.f0 = lf64(this.i4);
                    sf64(this.f0, this.i5);
                    this.i4 = li32(this.i4 + 8);
                    si32(this.i4, (this.i5 + 8));
                    this.i4 = li32(this.i0);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_setfenv.start();
                case 12:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 13:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li8(this.i3);
                    if (this.i4 == 0) goto _label_5;
                    this.i4 = this.i7;
                    do 
                    {
                        this.i5 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i6 = this.i4;
                        if (this.i5 == 0) goto _label_6;
                        this.i4 = this.i6;
                    } while (true);
                    
                _label_2: 
                    this.i7 = this.i3;
                    
                _label_3: 
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (this.i7 - this.i3);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 14:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -16));
                    si32(this.i4, (public::mstate.ebp + -8));
                    this.i3 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = (this.i3 + -12);
                    this.i7 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    
                _label_4: 
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i0);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i0);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_5: 
                    this.i4 = this.i3;
                    
                _label_6: 
                    this.i5 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 - this.i7);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 16:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -32));
                    si32(this.i5, (public::mstate.ebp + -24));
                    this.i3 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = (this.i3 + -12);
                    this.i4 = (public::mstate.ebp + -32);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    goto _label_4;
                default:
                    throw ("Invalid state in _createstdfile");
            };
        }


    }
} cmodule.lua_wrapper

