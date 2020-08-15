package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_auxwrap extends Machine 
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
            var _local_1:FSM_luaB_auxwrap;
            _local_1 = new (FSM_luaB_auxwrap)();
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
                    public::mstate.esp = (public::mstate.esp - 0);
                    this.i0 = -10003;
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
                    if (!(this.i2 == 8))
                    {
                        this.i0 = 0;
                    }
                    else
                    {
                        this.i0 = li32(this.i0);
                    };
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    this.i2 = (this.i2 - this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 / 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_auxresume.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = (this.i1 + 12);
                    this.i3 = (this.i1 + 8);
                    if (this.i0 > -1) goto _label_3;
                    this.i4 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = _luaO_nilobject_;
                    if (this.i4 == this.i5) goto _label_2;
                    this.i4 = li32(this.i4 + 8);
                    this.i4 = (this.i4 + -3);
                    if (uint(this.i4) > uint(1)) goto _label_2;
                    this.i4 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_where.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i3);
                    this.i6 = this.i5;
                    if (!(uint(this.i5) <= uint(this.i4)))
                    {
                        this.i7 = 0;
                        do 
                        {
                            this.i8 = (this.i7 ^ 0xFFFFFFFF);
                            this.i8 = (this.i8 * 12);
                            this.i8 = (this.i6 + this.i8);
                            this.f0 = lf64(this.i8);
                            sf64(this.f0, this.i5);
                            this.i9 = li32(this.i8 + 8);
                            si32(this.i9, (this.i5 + 8));
                            this.i5 = (this.i5 + -12);
                            this.i7 = (this.i7 + 1);
                        } while (!(uint(this.i8) <= uint(this.i4)));
                    };
                    this.i5 = li32(this.i3);
                    this.f0 = lf64(this.i5);
                    sf64(this.f0, this.i4);
                    this.i5 = li32(this.i5 + 8);
                    si32(this.i5, (this.i4 + 8));
                    this.i4 = li32(this.i1 + 16);
                    this.i5 = li32(this.i4 + 68);
                    this.i4 = li32(this.i4 + 64);
                    if (uint(this.i5) < uint(this.i4)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i4 = 2;
                    this.i5 = li32(this.i3);
                    this.i2 = li32(this.i2);
                    this.i2 = (this.i5 - this.i2);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i3);
                    this.i2 = (this.i2 + -12);
                    si32(this.i2, this.i3);
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaB_auxwrap");
            };
        }


    }
}

