package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_error extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_luaB_error;
            _local_1 = new (FSM_luaB_error)();
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
                    if (!(!(this.i0 == this.i2)))
                    {
                        
                    _label_1: 
                        this.i0 = 1;
                        goto _label_2;
                    };
                    this.i0 = li32(this.i0 + 8);
                    if (this.i0 < 1) goto _label_1;
                    this.i0 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i2 = li32(this.i1 + 12);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = (this.i1 + 12);
                    this.i5 = (this.i1 + 8);
                    this.i6 = (this.i2 + 12);
                    if (!(uint(this.i3) < uint(this.i6)))
                    {
                        this.i3 = this.i2;
                        goto _label_4;
                        
                    _label_3: 
                        this.i3 = this.i2;
                    };
                    this.i2 = 0;
                    si32(this.i2, (this.i3 + 8));
                    this.i2 = (this.i3 + 12);
                    si32(this.i2, this.i5);
                    this.i6 = li32(this.i4);
                    if (this.i3 < this.i6) goto _label_3;
                    this.i3 = this.i6;
                    
                _label_4: 
                    this.i2 = this.i3;
                    this.i3 = 1;
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(!(this.i2 == this.i3)))
                    {
                        this.i2 = 0;
                    }
                    else
                    {
                        this.i2 = li32(this.i2 + 8);
                        this.i2 = (this.i2 + -3);
                        this.i2 = ((uint(this.i2) < uint(2)) ? 1 : 0);
                    };
                    this.i2 = (this.i2 ^ 0x01);
                    this.i2 = (this.i2 & 0x01);
                    if (!(this.i2 == 0)) goto _label_6;
                    if (this.i0 < 1) goto _label_6;
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_where.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i5);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    this.i0 = li32(this.i1 + 16);
                    this.i2 = li32(this.i0 + 68);
                    this.i0 = li32(this.i0 + 64);
                    if (uint(this.i2) < uint(this.i0)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i0 = 2;
                    this.i2 = li32(this.i5);
                    this.i3 = li32(this.i4);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i5);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = 0;
                    public::mstate.eax = this.i1;
                    goto _label_7;
                    
                _label_6: 
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_errormsg.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.eax = this.i0;
                    
                _label_7: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaB_error");
            };
        }


    }
}

