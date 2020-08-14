package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_pcall extends Machine 
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
            var _local_1:FSM_luaB_pcall;
            _local_1 = new (FSM_luaB_pcall)();
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
                    this.i2 = _luaO_nilobject_;
                    if (!(this.i0 == this.i2))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (!(this.i0 == -1)) goto _label_1;
                    };
                    this.i0 = __2E_str11186329;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
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
                    this.i0 = -1;
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    this.i3 = (this.i2 - this.i3);
                    this.i3 = (this.i3 / -12);
                    this.i3 = (this.i3 * 12);
                    this.i2 = (this.i2 + this.i3);
                    si32(this.i2, (public::mstate.ebp + -8));
                    si32(this.i0, (public::mstate.ebp + -4));
                    this.i0 = li32(this.i1 + 32);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i3 = _f_call;
                    this.i4 = 0;
                    this.i0 = (this.i2 - this.i0);
                    this.i2 = (public::mstate.ebp + -8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    si32(this.i4, (public::mstate.esp + 16));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_pcall.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i1 + 20);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = li32(this.i2 + 8);
                    this.i2 = (this.i2 + 8);
                    this.i5 = (this.i1 + 12);
                    this.i6 = (this.i1 + 8);
                    if (!(uint(this.i3) < uint(this.i4)))
                    {
                        si32(this.i3, this.i2);
                    };
                    this.i2 = 1;
                    this.i0 = ((this.i0 == 0) ? 1 : 0);
                    this.i3 = li32(this.i6);
                    this.i0 = (this.i0 & 0x01);
                    si32(this.i0, this.i3);
                    si32(this.i2, (this.i3 + 8));
                    this.i0 = li32(this.i6);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i6);
                    this.i2 = this.i1;
                    if (!(uint(this.i1) <= uint(this.i0)))
                    {
                        this.i3 = 0;
                        do 
                        {
                            this.i4 = (this.i3 ^ 0xFFFFFFFF);
                            this.i4 = (this.i4 * 12);
                            this.i4 = (this.i2 + this.i4);
                            this.f0 = lf64(this.i4);
                            sf64(this.f0, this.i1);
                            this.i7 = li32(this.i4 + 8);
                            si32(this.i7, (this.i1 + 8));
                            this.i1 = (this.i1 + -12);
                            this.i3 = (this.i3 + 1);
                        } while (!(uint(this.i4) <= uint(this.i0)));
                    };
                    this.i1 = li32(this.i6);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i0);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = li32(this.i6);
                    this.i1 = li32(this.i5);
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
                    throw ("Invalid state in _luaB_pcall");
            };
        }


    }
} cmodule.lua_wrapper

