package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_db_gethook extends Machine 
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
            var _local_1:FSM_db_gethook;
            _local_1 = new (FSM_db_gethook)();
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
                    this.i0 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getthread.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li8(this.i0 + 56);
                    this.i3 = li32(this.i0 + 68);
                    this.i4 = (this.i2 & 0x01);
                    this.i5 = (public::mstate.ebp + -16);
                    if (this.i3 == 0) goto _label_3;
                    this.i6 = _hookf;
                    if (this.i3 == this.i6) goto _label_3;
                    this.i3 = li32(this.i1 + 16);
                    this.i6 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i6) < uint(this.i3)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i3 = __2E_str37287;
                    this.i6 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = 13;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i6);
                    this.i3 = 4;
                    si32(this.i3, (this.i6 + 8));
                    this.i3 = li32(this.i1 + 8);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, (this.i1 + 8));
                    if (!(this.i4 == 0)) goto _label_5;
                    
                _label_2: 
                    this.i4 = 0;
                    goto _label_6;
                    
                _label_3: 
                    this.i3 = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_gethooktable.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i6 = li32(this.i1 + 8);
                    si32(this.i0, this.i6);
                    si32(this.i3, (this.i6 + 8));
                    this.i3 = li32(this.i1 + 8);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i1 + 8);
                    this.i6 = li32(this.i6);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = (this.i7 + -12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_get.start();
                case 6:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f0 = lf64(this.i6);
                    sf64(this.f0, (this.i7 + -12));
                    this.i6 = li32(this.i6 + 8);
                    si32(this.i6, (this.i7 + -4));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i1 + 8);
                    this.i7 = (this.i1 + 8);
                    this.i8 = this.i3;
                    this.i9 = (this.i3 + 12);
                    if (!(uint(this.i9) < uint(this.i6)))
                    {
                        this.i3 = this.i6;
                    }
                    else
                    {
                        this.i3 = (this.i3 + 12);
                        this.i6 = this.i8;
                        
                    _label_4: 
                        this.f0 = lf64(this.i6 + 12);
                        sf64(this.f0, this.i6);
                        this.i8 = li32(this.i6 + 20);
                        si32(this.i8, (this.i6 + 8));
                        this.i6 = li32(this.i7);
                        this.i8 = (this.i3 + 12);
                        this.i9 = this.i3;
                        if (uint(this.i8) < uint(this.i6)) goto _label_9;
                        this.i3 = this.i6;
                    };
                    this.i3 = (this.i3 + -12);
                    si32(this.i3, this.i7);
                    if (this.i4 == 0) goto _label_2;
                    
                _label_5: 
                    this.i4 = 99;
                    si8(this.i4, this.i5);
                    this.i4 = 1;
                    
                _label_6: 
                    this.i3 = this.i4;
                    this.i4 = (this.i2 & 0x02);
                    if ((!(this.i4 == 0)))
                    {
                        this.i4 = (public::mstate.ebp + -16);
                        this.i6 = 114;
                        this.i4 = (this.i4 + this.i3);
                        si8(this.i6, this.i4);
                        this.i3 = (this.i3 + 1);
                    };
                    this.i4 = (public::mstate.ebp + -16);
                    this.i4 = (this.i4 + this.i3);
                    this.i2 = (this.i2 & 0x04);
                    if (this.i2 == 0) goto _label_7;
                    this.i2 = 108;
                    this.i6 = (public::mstate.ebp + -16);
                    si8(this.i2, this.i4);
                    this.i4 = (this.i3 + this.i6);
                    this.i2 = 0;
                    si8(this.i2, (this.i4 + 1));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0 + 60);
                    this.i4 = li32(this.i1 + 8);
                    this.f0 = Number(this.i0);
                    sf64(this.f0, this.i4);
                    this.i0 = 3;
                    si32(this.i0, (this.i4 + 8));
                    this.i4 = li32(this.i1 + 8);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, (this.i1 + 8));
                    goto _label_8;
                    
                _label_7: 
                    this.i2 = 0;
                    si8(this.i2, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushstring.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0 + 60);
                    this.i2 = li32(this.i1 + 8);
                    this.f0 = Number(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = 3;
                    si32(this.i0, (this.i2 + 8));
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    
                _label_8: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_9: 
                    this.i3 = this.i8;
                    this.i6 = this.i9;
                    goto _label_4;
                default:
                    throw ("Invalid state in _db_gethook");
            };
        }


    }
}

