package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_discharge2reg extends Machine 
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
            var _local_1:FSM_discharge2reg;
            _local_1 = new (FSM_discharge2reg)();
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
                    this.i0 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = this.i1;
                    if (this.i2 > 4) goto _label_1;
                    if (this.i2 == 1) goto _label_3;
                    this.i5 = (this.i2 + -2);
                    if (uint(this.i5) < uint(2)) goto _label_5;
                    if (!(this.i2 == 4)) goto _label_11;
                    this.i2 = 12;
                    this.i5 = li32(this.i1 + 4);
                    this.i6 = li32(this.i0 + 12);
                    this.i6 = li32(this.i6 + 8);
                    this.i5 = (this.i5 << 14);
                    this.i7 = (this.i3 << 6);
                    this.i5 = (this.i7 | this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = (this.i5 | 0x01);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_8;
                    
                _label_1: 
                    if (this.i2 == 5) goto _label_6;
                    if (this.i2 == 11) goto _label_7;
                    if (!(this.i2 == 12)) goto _label_11;
                    this.i2 = li32(this.i1 + 4);
                    this.i1 = (this.i1 + 4);
                    if (this.i2 == this.i3) goto _label_9;
                    this.i5 = 12;
                    this.i6 = li32(this.i0 + 12);
                    this.i6 = li32(this.i6 + 8);
                    this.i2 = (this.i2 << 23);
                    this.i7 = (this.i3 << 6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i7 | this.i2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i1);
                    
                _label_2: 
                    si32(this.i5, this.i4);
                    goto _label_11;
                    
                _label_3: 
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_nil.start();
                    return;
                case 4:
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (this.i1 + 4));
                    this.i0 = 12;
                    goto _label_10;
                    
                _label_5: 
                    this.i5 = 12;
                    this.i2 = ((this.i2 == 2) ? 1 : 0);
                    this.i2 = (this.i2 & 0x01);
                    this.i6 = li32(this.i0 + 12);
                    this.i6 = li32(this.i6 + 8);
                    this.i2 = (this.i2 << 23);
                    this.i7 = (this.i3 << 6);
                    this.i2 = (this.i7 | this.i2);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 | 0x02);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (this.i1 + 4));
                    goto _label_2;
                    
                _label_6: 
                    this.i2 = 3;
                    this.f0 = lf64(this.i1 + 4);
                    sf64(this.f0, (public::mstate.ebp + -16));
                    si32(this.i2, (public::mstate.ebp + -8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (public::mstate.ebp + -16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addk.start();
                    return;
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = li32(this.i0 + 12);
                    this.i5 = li32(this.i5 + 8);
                    this.i2 = (this.i2 << 14);
                    this.i6 = (this.i3 << 6);
                    this.i2 = (this.i6 | this.i2);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 | 0x01);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    goto _label_4;
                    
                _label_7: 
                    this.i2 = 12;
                    this.i5 = li32(this.i1 + 4);
                    this.i0 = li32(this.i0);
                    this.i0 = li32(this.i0 + 12);
                    this.i5 = (this.i5 << 2);
                    this.i0 = (this.i0 + this.i5);
                    this.i5 = li32(this.i0);
                    this.i6 = (this.i3 << 6);
                    this.i6 = (this.i6 & 0x3FC0);
                    this.i5 = (this.i5 & 0xFFFFC03F);
                    this.i5 = (this.i5 | this.i6);
                    si32(this.i5, this.i0);
                    
                _label_8: 
                    si32(this.i3, (this.i1 + 4));
                    si32(this.i2, this.i4);
                    goto _label_11;
                    
                _label_9: 
                    this.i0 = 12;
                    si32(this.i3, this.i1);
                    
                _label_10: 
                    si32(this.i0, this.i4);
                    
                _label_11: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _discharge2reg");
            };
        }


    }
}

