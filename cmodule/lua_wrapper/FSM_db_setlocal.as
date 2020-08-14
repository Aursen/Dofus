package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_db_setlocal extends Machine 
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
            var _local_1:FSM_db_setlocal;
            _local_1 = new (FSM_db_setlocal)();
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
                    this.i0 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getthread.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i0 + 20);
                    this.i4 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = (public::mstate.ebp + -112);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_getstack390.start();
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(public::mstate.ebp + -4);
                    this.i4 = (this.i0 + 40);
                    if (!(this.i2 == 0)) goto _label_1;
                    this.i0 = __2E_str31281;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    goto _label_4;
                    
                _label_1: 
                    this.i2 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 + 3);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i5 == this.i2))
                    {
                        this.i2 = li32(this.i5 + 8);
                        if (!(this.i2 == -1)) goto _label_2;
                    };
                    this.i2 = __2E_str11186329;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i2 = li32(public::mstate.ebp + -4);
                    this.i3 = li32(this.i1 + 8);
                    this.i5 = (this.i1 + 8);
                    this.i6 = (this.i2 + 3);
                    if (!(this.i6 < 0))
                    {
                        this.i2 = li32(this.i1 + 12);
                        this.i7 = (this.i1 + 12);
                        this.i8 = (this.i6 * 12);
                        this.i8 = (this.i2 + this.i8);
                        if ((uint(this.i3) < uint(this.i8)))
                        {
                            this.i2 = this.i3;
                            
                        _label_3: 
                            this.i3 = 0;
                            si32(this.i3, (this.i2 + 8));
                            this.i2 = (this.i2 + 12);
                            si32(this.i2, this.i5);
                            this.i3 = li32(this.i7);
                            this.i8 = (this.i6 * 12);
                            this.i8 = (this.i3 + this.i8);
                            if (uint(this.i2) < uint(this.i8)) goto _label_5;
                            this.i2 = this.i3;
                        };
                        this.i3 = (this.i6 * 12);
                        this.i2 = (this.i2 + this.i3);
                    }
                    else
                    {
                        this.i2 = (this.i2 * 12);
                        this.i2 = (this.i2 + this.i3);
                        this.i2 = (this.i2 + 48);
                    };
                    si32(this.i2, this.i5);
                    if (!(this.i0 == this.i1))
                    {
                        this.i3 = 0;
                        this.i2 = (this.i2 + -12);
                        si32(this.i2, this.i5);
                        this.i2 = (this.i0 + 8);
                        this.i6 = this.i3;
                        do 
                        {
                            this.i7 = li32(this.i2);
                            this.i8 = li32(this.i5);
                            this.i9 = (this.i7 + 12);
                            si32(this.i9, this.i2);
                            this.i8 = (this.i8 + this.i6);
                            this.f0 = lf64(this.i8);
                            sf64(this.f0, this.i7);
                            this.i8 = li32(this.i8 + 8);
                            si32(this.i8, (this.i7 + 8));
                            this.i6 = (this.i6 + 12);
                            this.i7 = (this.i3 + 1);
                            if ((this.i3 == 0)) break;
                            this.i3 = this.i7;
                        } while (true);
                    };
                    this.i2 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 + 2);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(public::mstate.ebp + -16);
                    this.i4 = li32(this.i4);
                    this.i5 = (this.i3 * 24);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i4 + this.i5);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_findlocal.start();
                case 8:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i0 + 8);
                    this.i0 = (this.i0 + 8);
                    if (!(!(this.i5 == 0)))
                    {
                        this.i2 = this.i6;
                    }
                    else
                    {
                        this.i3 = (this.i3 * 24);
                        this.i3 = (this.i4 + this.i3);
                        this.i3 = li32(this.i3);
                        this.f0 = lf64(this.i6 + -12);
                        this.i2 = (this.i2 * 12);
                        this.i2 = (this.i2 + this.i3);
                        sf64(this.f0, (this.i2 + -12));
                        this.i3 = li32(this.i6 + -4);
                        si32(this.i3, (this.i2 + -4));
                        this.i2 = li32(this.i0);
                    };
                    this.i3 = 1;
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.eax = this.i3;
                    
                _label_4: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_5: 
                    goto _label_3;
                default:
                    throw ("Invalid state in _db_setlocal");
            };
        }


    }
} cmodule.lua_wrapper

