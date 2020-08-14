package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_db_getlocal extends Machine 
    {

        public static const intRegCount:int = 9;
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


        public static function start():void
        {
            var _local_1:FSM_db_getlocal;
            _local_1 = new (FSM_db_getlocal)();
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
                    goto _label_3;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i3 + 2);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 5:
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
                case 6:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i5 == 0) goto _label_2;
                    this.i3 = (this.i3 * 24);
                    this.i3 = (this.i4 + this.i3);
                    this.i3 = li32(this.i3);
                    this.i2 = (this.i2 * 12);
                    this.i2 = (this.i2 + this.i3);
                    this.i3 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i2 + -12);
                    sf64(this.f0, this.i3);
                    this.i2 = li32(this.i2 + -4);
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = li32(this.i0 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i0 + 8));
                    if (!(this.i0 == this.i1))
                    {
                        this.i2 = 0;
                        this.i3 = li32(this.i0 + 8);
                        this.i3 = (this.i3 + -12);
                        si32(this.i3, (this.i0 + 8));
                        this.i3 = (this.i1 + 8);
                        this.i0 = (this.i0 + 8);
                        this.i4 = this.i2;
                        do 
                        {
                            this.i6 = li32(this.i3);
                            this.i7 = li32(this.i0);
                            this.i8 = (this.i6 + 12);
                            si32(this.i8, this.i3);
                            this.i7 = (this.i7 + this.i4);
                            this.f0 = lf64(this.i7);
                            sf64(this.f0, this.i6);
                            this.i7 = li32(this.i7 + 8);
                            si32(this.i7, (this.i6 + 8));
                            this.i4 = (this.i4 + 12);
                            this.i6 = (this.i2 + 1);
                            if ((this.i2 == 0)) break;
                            this.i2 = this.i6;
                        } while (true);
                    };
                    this.i0 = -2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    this.i1 = 2;
                    public::mstate.eax = this.i1;
                    goto _label_4;
                    
                _label_2: 
                    this.i0 = 0;
                    this.i2 = li32(this.i1 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = 1;
                    
                _label_3: 
                    public::mstate.eax = this.i0;
                    
                _label_4: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _db_getlocal");
            };
        }


    }
} cmodule.lua_wrapper

