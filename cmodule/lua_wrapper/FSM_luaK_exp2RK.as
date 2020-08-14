package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaK_exp2RK extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_luaK_exp2RK;
            _local_1 = new (FSM_luaK_exp2RK)();
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
                    public::mstate.esp = (public::mstate.esp - 64);
                    this.i0 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2val.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1);
                    this.i3 = this.i1;
                    this.i4 = (this.i2 + -1);
                    if (!(uint(this.i4) < uint(3)))
                    {
                        if (this.i2 == 4) goto _label_4;
                        if (!(this.i2 == 5)) goto _label_6;
                    };
                    this.i4 = li32(this.i0 + 40);
                    if (this.i4 > 0xFF) goto _label_6;
                    if (this.i2 == 5) goto _label_1;
                    if (!(this.i2 == 1)) goto _label_2;
                    this.i2 = 0;
                    si32(this.i2, (public::mstate.ebp + -40));
                    this.i2 = li32(this.i0 + 4);
                    si32(this.i2, (public::mstate.ebp + -32));
                    this.i2 = 5;
                    si32(this.i2, (public::mstate.ebp + -24));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (public::mstate.ebp + -32);
                    this.i4 = (public::mstate.ebp + -48);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addk.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_3;
                    
                _label_1: 
                    this.i2 = 3;
                    this.f0 = lf64(this.i1 + 4);
                    sf64(this.f0, (public::mstate.ebp + -16));
                    si32(this.i2, (public::mstate.ebp + -8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (public::mstate.ebp + -16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addk.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_3;
                    
                _label_2: 
                    this.i4 = 1;
                    this.i2 = ((this.i2 == 2) ? 1 : 0);
                    this.i2 = (this.i2 & 0x01);
                    si32(this.i2, (public::mstate.ebp + -64));
                    si32(this.i4, (public::mstate.ebp + -56));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (public::mstate.ebp + -64);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_addk.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i2 = 4;
                    si32(this.i0, (this.i1 + 4));
                    si32(this.i2, this.i3);
                    this.i0 = (this.i0 | 0x0100);
                    goto _label_5;
                    
                _label_4: 
                    this.i2 = li32(this.i1 + 4);
                    if (!(this.i2 > 0xFF))
                    {
                        this.i0 = (this.i2 | 0x0100);
                        
                    _label_5: 
                        public::mstate.eax = this.i0;
                        goto _label_9;
                    };
                    
                _label_6: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i3);
                    if (!(this.i2 == 12)) goto _label_7;
                    this.i2 = li32(this.i1 + 12);
                    this.i3 = li32(this.i1 + 16);
                    this.i4 = li32(this.i1 + 4);
                    this.i5 = (this.i1 + 4);
                    if (this.i2 == this.i3) goto _label_8;
                    this.i2 = li8(this.i0 + 50);
                    if (this.i4 < this.i2) goto _label_7;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exp2reg.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i5);
                    goto _label_5;
                    
                _label_7: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i1 + 4);
                    
                _label_8: 
                    public::mstate.eax = this.i4;
                    
                _label_9: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaK_exp2RK");
            };
        }


    }
} cmodule.lua_wrapper

