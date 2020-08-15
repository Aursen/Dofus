package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_checkudata extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_luaL_checkudata;
            _local_1 = new (FSM_luaL_checkudata)();
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
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = this.i3;
                    if (!(this.i2 == 2))
                    {
                        if (!(this.i2 == 7))
                        {
                            this.i0 = 0;
                        }
                        else
                        {
                            this.i0 = li32(this.i0);
                            this.i0 = (this.i0 + 20);
                        };
                    }
                    else
                    {
                        this.i0 = li32(this.i0);
                    };
                    if (this.i0 == 0) goto _label_1;
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getmetatable.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i2 == 0) goto _label_1;
                    this.i2 = -10000;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li8(this.i3);
                    if (this.i5 == 0) goto _label_2;
                    this.i5 = this.i4;
                    do 
                    {
                        this.i6 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i7 = this.i5;
                        if (this.i6 == 0) goto _label_3;
                        this.i5 = this.i7;
                    } while (true);
                    
                _label_1: 
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (!(!(this.i0 == this.i2)))
                    {
                        this.i0 = -1;
                    }
                    else
                    {
                        this.i0 = li32(this.i0 + 8);
                    };
                    if (!(!(this.i0 == -1)))
                    {
                        this.i0 = __2E_str2251;
                    }
                    else
                    {
                        this.i2 = _luaT_typenames;
                        this.i0 = (this.i0 << 2);
                        this.i0 = (this.i2 + this.i0);
                        this.i0 = li32(this.i0);
                    };
                    this.i2 = __2E_str9184327;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = 0;
                    goto _label_4;
                    
                _label_2: 
                    this.i5 = this.i3;
                    
                _label_3: 
                    this.i6 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i5 - this.i4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 7:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i4, (public::mstate.ebp + -16));
                    si32(this.i6, (public::mstate.ebp + -8));
                    this.i4 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 10:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = (this.i1 + 8);
                    this.i6 = _luaO_nilobject_;
                    if (this.i4 == this.i6) goto _label_1;
                    this.i6 = _luaO_nilobject_;
                    if (this.i2 == this.i6) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_rawequalObj.start();
                case 11:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i2 == 0) goto _label_1;
                    this.i1 = li32(this.i5);
                    this.i1 = (this.i1 + -24);
                    si32(this.i1, this.i5);
                    
                _label_4: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaL_checkudata");
            };
        }


    }
}

