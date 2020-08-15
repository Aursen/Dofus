package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_Arith extends Machine 
    {

        public static const intRegCount:int = 9;
        public static const NumberRegCount:int = 3;

        public var f0:Number;
        public var f1:Number;
        public var f2:Number;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;


        public static function start():void
        {
            var _local_1:FSM_Arith;
            _local_1 = new (FSM_Arith)();
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
                    public::mstate.esp = (public::mstate.esp - 80);
                    this.i0 = li32(public::mstate.ebp + 16);
                    this.i1 = li32(this.i0 + 8);
                    this.i2 = (this.i0 + 8);
                    this.i3 = li32(public::mstate.ebp + 8);
                    this.i4 = li32(public::mstate.ebp + 12);
                    this.i5 = li32(public::mstate.ebp + 20);
                    this.i6 = li32(public::mstate.ebp + 24);
                    if (!(this.i1 == 4))
                    {
                        if (!(!(this.i1 == 3)))
                        {
                            this.i1 = this.i0;
                            goto _label_1;
                        };
                        this.i1 = 0;
                        goto _label_1;
                    };
                    this.i1 = (public::mstate.ebp + -48);
                    this.i7 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = (this.i7 + 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_str2d.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i1 == 0)) goto _label_14;
                    this.i1 = 0;
                    
                _label_1: 
                    if (this.i1 == 0) goto _label_10;
                    this.i7 = li32(this.i5 + 8);
                    if (!(this.i7 == 4))
                    {
                        if (!(!(this.i7 == 3)))
                        {
                            this.i7 = this.i5;
                            goto _label_2;
                        };
                        this.i7 = 0;
                        goto _label_2;
                    };
                    this.i7 = (public::mstate.ebp + -40);
                    this.i8 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = (this.i8 + 16);
                    si32(this.i8, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_str2d.start();
                    return;
                case 2:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i7 == 0)) goto _label_15;
                    this.i7 = 0;
                    
                _label_2: 
                    if (!(this.i7 == 0))
                    {
                        this.f1 = lf64(this.i1);
                        this.f2 = lf64(this.i7);
                        if (!(this.i6 > 7))
                        {
                            if (this.i6 == 5) goto _label_3;
                            if (this.i6 == 6) goto _label_4;
                            if (!(this.i6 == 7)) goto _label_7;
                            this.i0 = 3;
                            this.f1 = (this.f1 * this.f2);
                            goto _label_5;
                        };
                        if (!(this.i6 > 9))
                        {
                            if (this.i6 == 8) goto _label_8;
                            if (!(this.i6 == 9)) goto _label_7;
                            this.i0 = 3;
                            this.f0 = (this.f1 / this.f2);
                            this.f0 = Math.floor(this.f0);
                            this.f2 = (this.f0 * this.f2);
                        }
                        else
                        {
                            if (this.i6 == 10) goto _label_9;
                            if (!(this.i6 == 11)) goto _label_7;
                            this.i0 = 3;
                            this.f0 = -(this.f1);
                            sf64(this.f0, this.i4);
                            goto _label_6;
                            
                        _label_3: 
                            this.i0 = 3;
                            this.f1 = (this.f1 + this.f2);
                            goto _label_5;
                            
                        _label_4: 
                            this.i0 = 3;
                        };
                        this.f1 = (this.f1 - this.f2);
                        do 
                        {
                            
                        _label_5: 
                            sf64(this.f1, this.i4);
                            
                        _label_6: 
                            si32(this.i0, (this.i4 + 8));
                            
                        _label_7: 
                            public::mstate.esp = public::mstate.ebp;
                            public::mstate.ebp = li32(public::mstate.esp);
                            public::mstate.esp = (public::mstate.esp + 4);
                            public::mstate.esp = (public::mstate.esp + 4);
                            public::mstate.gworker = caller;
                            return;
                            
                        _label_8: 
                            this.i0 = 3;
                            this.f1 = (this.f1 / this.f2);
                            continue;
                            
                        _label_9: 
                            this.i0 = 3;
                            this.f0 = this.f1;
                            this.f1 = this.f2;
                            this.f0 = Math.pow(this.f0, this.f1);
                            this.f1 = this.f0;
                        } while (true);
                    };
                    
                _label_10: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = li32(this.i1 + 8);
                    if (!(this.i7 == 0))
                    {
                        this.i6 = this.i1;
                        goto _label_11;
                    };
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 4:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_11: 
                    this.i1 = this.i6;
                    this.i6 = li32(this.i1 + 8);
                    if (this.i6 == 0) goto _label_12;
                    public::mstate.esp = (public::mstate.esp - 20);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    si32(this.i5, (public::mstate.esp + 16));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_callTMres.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 20);
                    goto _label_7;
                    
                _label_12: 
                    this.i1 = li32(this.i2);
                    if (!(this.i1 == 4))
                    {
                        if (!(!(this.i1 == 3)))
                        {
                            this.i1 = this.i0;
                            goto _label_13;
                        };
                        this.i1 = 0;
                        goto _label_13;
                    };
                    this.i1 = (public::mstate.ebp + -8);
                    this.i2 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 + 16);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_str2d.start();
                    return;
                case 6:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i1 == 0)) goto _label_16;
                    this.i1 = 0;
                    
                _label_13: 
                    this.i2 = __2E_str20277;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = ((this.i1 == 0) ? this.i0 : this.i5);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_typeerror.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_7;
                    
                _label_14: 
                    this.i1 = 3;
                    this.f0 = lf64(public::mstate.ebp + -48);
                    sf64(this.f0, (public::mstate.ebp + -64));
                    si32(this.i1, (public::mstate.ebp + -56));
                    this.i1 = (public::mstate.ebp + -64);
                    goto _label_1;
                    
                _label_15: 
                    this.i7 = 3;
                    this.f0 = lf64(public::mstate.ebp + -40);
                    sf64(this.f0, (public::mstate.ebp + -80));
                    si32(this.i7, (public::mstate.ebp + -72));
                    this.i7 = (public::mstate.ebp + -80);
                    goto _label_2;
                    
                _label_16: 
                    this.i1 = 3;
                    this.f0 = lf64(public::mstate.ebp + -8);
                    sf64(this.f0, (public::mstate.ebp + -32));
                    si32(this.i1, (public::mstate.ebp + -24));
                    this.i1 = (public::mstate.ebp + -32);
                    goto _label_13;
                default:
                    throw ("Invalid state in _Arith");
            };
        }


    }
}

