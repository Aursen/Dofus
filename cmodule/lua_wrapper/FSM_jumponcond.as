package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_jumponcond extends Machine 
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
            var _local_1:FSM_jumponcond;
            _local_1 = new (FSM_jumponcond)();
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
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(this.i0);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = this.i0;
                    if (this.i1 == 12) goto _label_3;
                    if (!(this.i1 == 11)) goto _label_2;
                    this.i5 = li32(this.i0 + 4);
                    this.i6 = li32(this.i2);
                    this.i6 = li32(this.i6 + 12);
                    this.i5 = (this.i5 << 2);
                    this.i5 = (this.i6 + this.i5);
                    this.i5 = li32(this.i5);
                    this.i6 = (this.i5 & 0x3F);
                    if (!(this.i6 == 19)) goto _label_1;
                    this.i0 = -1;
                    this.i1 = li32(this.i2 + 24);
                    this.i1 = (this.i1 + -1);
                    si32(this.i1, (this.i2 + 24));
                    this.i1 = li32(this.i2 + 12);
                    this.i3 = ((this.i3 == 0) ? 1 : 0);
                    this.i4 = (this.i5 >>> 17);
                    this.i1 = li32(this.i1 + 8);
                    this.i3 = (this.i3 & 0x01);
                    this.i4 = (this.i4 | 0x1A);
                    this.i4 = (this.i4 & 0x7FDA);
                    this.i3 = (this.i3 << 14);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i4 | this.i3);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i2 + 32);
                    si32(this.i0, (this.i2 + 32));
                    this.i0 = li32(this.i2 + 12);
                    this.i0 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 2147450902;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, (public::mstate.ebp + -8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (public::mstate.ebp + -8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(public::mstate.ebp + -8);
                    goto _label_4;
                    
                _label_1: 
                    if (this.i1 == 12) goto _label_3;
                    
                _label_2: 
                    this.i1 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_checkstack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i2 + 36);
                    this.i5 = (this.i1 + 1);
                    si32(this.i5, (this.i2 + 36));
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_discharge2reg.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i1 = li32(this.i4);
                    if (!(!(this.i1 == 12)))
                    {
                        this.i1 = li32(this.i0 + 4);
                        this.i4 = (this.i1 & 0x0100);
                        if (!(!(this.i4 == 0)))
                        {
                            this.i4 = li8(this.i2 + 50);
                            if (!(this.i4 > this.i1))
                            {
                                this.i1 = li32(this.i2 + 36);
                                this.i1 = (this.i1 + -1);
                                si32(this.i1, (this.i2 + 36));
                            };
                        };
                    };
                    this.i1 = -1;
                    this.i0 = li32(this.i0 + 4);
                    this.i4 = li32(this.i2 + 12);
                    this.i4 = li32(this.i4 + 8);
                    this.i3 = (this.i3 << 14);
                    this.i0 = (this.i0 << 23);
                    this.i0 = (this.i0 | this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (this.i0 | 0x3FDB);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i2 + 32);
                    si32(this.i1, (this.i2 + 32));
                    this.i1 = li32(this.i2 + 12);
                    this.i1 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 2147450902;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 7:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, (public::mstate.ebp + -4));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (public::mstate.ebp + -4);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(public::mstate.ebp + -4);
                    
                _label_4: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _jumponcond");
            };
        }


    }
}

