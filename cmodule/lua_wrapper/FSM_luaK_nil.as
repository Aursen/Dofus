package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaK_nil extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;


        public static function start():void
        {
            var _local_1:FSM_luaK_nil;
            _local_1 = new (FSM_luaK_nil)();
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
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 24);
                    this.i2 = li32(this.i0 + 28);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(public::mstate.ebp + 16);
                    if (!(this.i1 <= this.i2))
                    {
                        if (!(this.i1 == 0)) goto _label_2;
                        this.i1 = li8(this.i0 + 50);
                        if (!(this.i1 > this.i3))
                        {
                            goto _label_3;
                        };
                    };
                    
                _label_1: 
                    this.i1 = (this.i3 + this.i4);
                    this.i1 = (this.i1 + 511);
                    this.i2 = li32(this.i0 + 12);
                    this.i2 = li32(this.i2 + 8);
                    this.i1 = (this.i1 << 23);
                    this.i3 = (this.i3 << 6);
                    this.i1 = (this.i3 | this.i1);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i1 | 0x03);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_3;
                    
                _label_2: 
                    this.i2 = li32(this.i0);
                    this.i2 = li32(this.i2 + 12);
                    this.i1 = (this.i1 << 2);
                    this.i1 = (this.i1 + this.i2);
                    this.i2 = li32(this.i1 + -4);
                    this.i1 = (this.i1 + -4);
                    this.i5 = (this.i2 & 0x3F);
                    if (!(this.i5 == 3)) goto _label_1;
                    this.i5 = (this.i2 >>> 6);
                    this.i6 = (this.i2 >>> 23);
                    this.i5 = (this.i5 & 0xFF);
                    if (this.i5 > this.i3) goto _label_1;
                    this.i5 = (this.i6 + 1);
                    if (this.i5 < this.i3) goto _label_1;
                    this.i0 = (this.i3 + this.i4);
                    this.i0 = (this.i0 + -1);
                    if (!(this.i0 <= this.i6))
                    {
                        this.i0 = (this.i4 + this.i3);
                        this.i0 = (this.i0 << 23);
                        this.i0 = (this.i0 + -8388608);
                        this.i3 = (this.i2 & 0x7FFFFF);
                        this.i0 = (this.i3 | this.i0);
                        si32(this.i0, this.i1);
                    };
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaK_nil");
            };
        }


    }
}

