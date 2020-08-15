package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_xpcall extends Machine 
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
            var _local_1:FSM_luaB_xpcall;
            _local_1 = new (FSM_luaB_xpcall)();
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
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 2;
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
                    if (!(this.i0 == this.i2))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (!(this.i0 == -1)) goto _label_1;
                    };
                    this.i0 = __2E_str11186329;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i0 = li32(this.i1 + 12);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = (this.i1 + 12);
                    this.i4 = (this.i1 + 8);
                    this.i5 = (this.i0 + 24);
                    if (!(uint(this.i2) < uint(this.i5)))
                    {
                        this.i2 = this.i0;
                        goto _label_3;
                    };
                    
                _label_2: 
                    this.i0 = 0;
                    si32(this.i0, (this.i2 + 8));
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    this.i0 = li32(this.i3);
                    this.i5 = (this.i0 + 24);
                    if (uint(this.i2) < uint(this.i5)) goto _label_2;
                    this.i2 = this.i0;
                    
                _label_3: 
                    this.i0 = this.i2;
                    this.i2 = 1;
                    this.i0 = (this.i0 + 24);
                    si32(this.i0, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.i5 = this.i2;
                    if (!(uint(this.i2) <= uint(this.i0)))
                    {
                        this.i6 = 0;
                        do 
                        {
                            this.i7 = (this.i6 ^ 0xFFFFFFFF);
                            this.i7 = (this.i7 * 12);
                            this.i7 = (this.i5 + this.i7);
                            this.f0 = lf64(this.i7);
                            sf64(this.f0, this.i2);
                            this.i8 = li32(this.i7 + 8);
                            si32(this.i8, (this.i2 + 8));
                            this.i2 = (this.i2 + -12);
                            this.i6 = (this.i6 + 1);
                        } while (!(uint(this.i7) <= uint(this.i0)));
                    };
                    this.i2 = 1;
                    this.i5 = li32(this.i4);
                    this.f0 = lf64(this.i5);
                    sf64(this.f0, this.i0);
                    this.i5 = li32(this.i5 + 8);
                    si32(this.i5, (this.i0 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 32);
                    this.i5 = li32(this.i4);
                    this.i5 = (this.i5 + -12);
                    si32(this.i5, (public::mstate.ebp + -8));
                    this.i6 = -1;
                    si32(this.i6, (public::mstate.ebp + -4));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i6 = _f_call;
                    this.i5 = (this.i5 - this.i2);
                    this.i7 = (public::mstate.ebp + -8);
                    this.i0 = (this.i0 - this.i2);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i0, (public::mstate.esp + 16));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_pcall.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i1 + 20);
                    this.i5 = li32(this.i4);
                    this.i6 = li32(this.i2 + 8);
                    this.i2 = (this.i2 + 8);
                    if (!(uint(this.i5) < uint(this.i6)))
                    {
                        si32(this.i5, this.i2);
                    };
                    this.i2 = 1;
                    this.i0 = ((this.i0 == 0) ? 1 : 0);
                    this.i5 = li32(this.i4);
                    this.i0 = (this.i0 & 0x01);
                    si32(this.i0, this.i5);
                    si32(this.i2, (this.i5 + 8));
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_replace.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i4);
                    this.i1 = li32(this.i3);
                    this.i0 = (this.i0 - this.i1);
                    this.i0 = (this.i0 / 12);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaB_xpcall");
            };
        }


    }
}

