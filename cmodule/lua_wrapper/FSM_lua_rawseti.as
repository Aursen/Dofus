package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_rawseti extends Machine 
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
            var _local_1:FSM_lua_rawseti;
            _local_1 = new (FSM_lua_rawseti)();
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
                    this.i0 = _luaO_nilobject_;
                    this.i1 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = li32(public::mstate.ebp + 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = li32(public::mstate.ebp + 16);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 2:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = (this.i1 + 8);
                    if (!(this.i6 == this.i0))
                    {
                        this.i4 = this.i6;
                        goto _label_1;
                    };
                    this.i0 = 3;
                    this.f0 = Number(this.i5);
                    sf64(this.f0, (public::mstate.ebp + -16));
                    si32(this.i0, (public::mstate.ebp + -8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i0 = this.i4;
                    this.f0 = lf64(this.i3 + -12);
                    sf64(this.f0, this.i0);
                    this.i3 = li32(this.i3 + -4);
                    si32(this.i3, (this.i0 + 8));
                    this.i0 = li32(this.i7);
                    this.i3 = li32(this.i0 + -4);
                    if (!(this.i3 < 4))
                    {
                        this.i3 = li32(this.i0 + -12);
                        this.i3 = li8(this.i3 + 5);
                        this.i3 = (this.i3 & 0x03);
                        if (!(this.i3 == 0))
                        {
                            this.i2 = li32(this.i2);
                            this.i3 = li8(this.i2 + 5);
                            this.i4 = (this.i2 + 5);
                            this.i5 = (this.i3 & 0x04);
                            if (!(this.i5 == 0))
                            {
                                this.i0 = li32(this.i1 + 16);
                                this.i1 = (this.i3 & 0xFFFFFFFB);
                                si8(this.i1, this.i4);
                                this.i1 = li32(this.i0 + 40);
                                si32(this.i1, (this.i2 + 24));
                                si32(this.i2, (this.i0 + 40));
                                this.i0 = li32(this.i7);
                            };
                        };
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i7);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _lua_rawseti");
            };
        }


    }
}

