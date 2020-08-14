package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaK_dischargevars extends Machine 
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
            var _local_1:FSM_luaK_dischargevars;
            _local_1 = new (FSM_luaK_dischargevars)();
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
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(this.i0);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = this.i0;
                    if (!(this.i1 > 8))
                    {
                        if (this.i1 == 6) goto _label_3;
                        if (this.i1 == 7) goto _label_4;
                        if (!(this.i1 == 8)) goto _label_8;
                        this.i1 = 11;
                        this.i4 = li32(this.i2 + 12);
                        this.i5 = li32(this.i0 + 4);
                        this.i4 = li32(this.i4 + 8);
                        this.i5 = (this.i5 << 14);
                        public::mstate.esp = (public::mstate.esp - 12);
                        this.i5 = (this.i5 | 0x05);
                        goto _label_5;
                    };
                    if (this.i1 == 9) goto _label_6;
                    if (this.i1 == 13) goto _label_7;
                    if (!(this.i1 == 14)) goto _label_8;
                    this.i1 = 11;
                    this.i0 = li32(this.i0 + 4);
                    this.i2 = li32(this.i2);
                    this.i2 = li32(this.i2 + 12);
                    this.i0 = (this.i0 << 2);
                    this.i0 = (this.i2 + this.i0);
                    this.i2 = li32(this.i0);
                    this.i2 = (this.i2 | 0x01000000);
                    this.i2 = (this.i2 & 0x017FFFFF);
                    
                _label_1: 
                    si32(this.i2, this.i0);
                    
                _label_2: 
                    si32(this.i1, this.i3);
                    goto _label_8;
                    
                _label_3: 
                    this.i0 = 12;
                    si32(this.i0, this.i3);
                    goto _label_8;
                    
                _label_4: 
                    this.i1 = 11;
                    this.i4 = li32(this.i2 + 12);
                    this.i5 = li32(this.i0 + 4);
                    this.i4 = li32(this.i4 + 8);
                    this.i5 = (this.i5 << 23);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 | 0x04);
                    
                _label_5: 
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (this.i0 + 4));
                    goto _label_2;
                    
                _label_6: 
                    this.i1 = li32(this.i0 + 8);
                    this.i4 = (this.i0 + 8);
                    this.i5 = (this.i1 & 0x0100);
                    if (!(!(this.i5 == 0)))
                    {
                        this.i5 = li8(this.i2 + 50);
                        if (!(this.i5 > this.i1))
                        {
                            this.i1 = li32(this.i2 + 36);
                            this.i1 = (this.i1 + -1);
                            si32(this.i1, (this.i2 + 36));
                        };
                    };
                    this.i1 = li32(this.i0 + 4);
                    this.i0 = (this.i0 + 4);
                    this.i5 = (this.i1 & 0x0100);
                    if (!(!(this.i5 == 0)))
                    {
                        this.i5 = li8(this.i2 + 50);
                        if (!(this.i5 > this.i1))
                        {
                            this.i1 = li32(this.i2 + 36);
                            this.i1 = (this.i1 + -1);
                            si32(this.i1, (this.i2 + 36));
                        };
                    };
                    this.i1 = 11;
                    this.i4 = li32(this.i4);
                    this.i5 = li32(this.i0);
                    this.i6 = li32(this.i2 + 12);
                    this.i6 = li32(this.i6 + 8);
                    this.i4 = (this.i4 << 14);
                    this.i5 = (this.i5 << 23);
                    this.i4 = (this.i5 | this.i4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 | 0x06);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_1;
                    
                _label_7: 
                    this.i1 = 12;
                    si32(this.i1, this.i3);
                    this.i2 = li32(this.i2);
                    this.i3 = li32(this.i0 + 4);
                    this.i2 = li32(this.i2 + 12);
                    this.i3 = (this.i3 << 2);
                    this.i2 = (this.i2 + this.i3);
                    this.i2 = li32(this.i2);
                    this.i2 = (this.i2 >>> 6);
                    this.i2 = (this.i2 & 0xFF);
                    si32(this.i2, (this.i0 + 4));
                    
                _label_8: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaK_dischargevars");
            };
        }


    }
} cmodule.lua_wrapper

