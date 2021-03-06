package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_str_find_aux extends Machine 
    {

        public static const intRegCount:int = 15;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var f0:Number;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_str_find_aux;
            _local_1 = new (FSM_str_find_aux)();
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
                    public::mstate.esp = (public::mstate.esp - 288);
                    this.i0 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (public::mstate.ebp + -8);
                    this.i3 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(public::mstate.ebp + 12);
                    this.i6 = this.i2;
                    this.i7 = this.i0;
                    this.i8 = _luaO_nilobject_;
                    if (!(!(this.i4 == this.i8)))
                    {
                        
                    _label_1: 
                        this.i4 = 1;
                        goto _label_2;
                    };
                    this.i4 = li32(this.i4 + 8);
                    if (this.i4 < 1) goto _label_1;
                    this.i4 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 4:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    if (!(this.i4 > -1))
                    {
                        this.i4 = (this.i4 + this.i3);
                        this.i4 = (this.i4 + 1);
                        this.i4 = ((this.i4 > -1) ? this.i4 : 0);
                    }
                    else
                    {
                        this.i4 = ((this.i4 > -1) ? this.i4 : 0);
                    };
                    this.i3 = this.i4;
                    this.i3 = (this.i3 + -1);
                    if (!(this.i3 > -1))
                    {
                        this.i3 = 0;
                    }
                    else
                    {
                        this.i4 = li32(public::mstate.ebp + -4);
                        if ((uint(this.i3) > uint(this.i4)))
                        {
                            this.i3 = this.i4;
                        };
                    };
                    if (this.i5 == 0) goto _label_10;
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i4 + 8);
                    if (!(this.i8 == 0))
                    {
                        if (!(this.i8 == 1)) goto _label_5;
                        this.i4 = li32(this.i4);
                        if (!(this.i4 == 0)) goto _label_5;
                    };
                    this.i4 = li8(this.i2);
                    if (!(!(this.i4 == 0)))
                    {
                        
                    _label_3: 
                        this.i4 = 0;
                        goto _label_4;
                    };
                    this.i8 = (this.i6 + 1);
                    this.i9 = this.i2;
                    _loop_1:
                    do 
                    {
                        this.i10 = __2E_str37467;
                        this.i11 = this.i8;
                        while ((this.i12 = this.i10), (this.i10 = li8(this.i12)), (!(this.i10 == 0)))
                        {
                            this.i12 = (this.i12 + 1);
                            this.i13 = (this.i4 & 0xFF);
                            this.i10 = (this.i10 & 0xFF);
                            if ((this.i10 == this.i13)) break _loop_1;
                            this.i10 = this.i12;
                        };
                        this.i4 = li8(this.i11);
                        this.i8 = (this.i8 + 1);
                        if (this.i4 == 0) goto _label_3;
                        this.i9 = this.i11;
                    } while (true);
                    this.i4 = this.i9;
                    
                _label_4: 
                    if (!(!(this.i4 == 0)))
                    {
                        
                    _label_5: 
                        this.i5 = li32(public::mstate.ebp + -8);
                        this.i7 = li32(public::mstate.ebp + -4);
                        this.i4 = (this.i0 + this.i3);
                        this.i3 = (this.i7 - this.i3);
                        if (!(!(this.i5 == 0)))
                        {
                            this.i3 = this.i4;
                        }
                        else
                        {
                            if (!(uint(this.i5) <= uint(this.i3)))
                            {
                                
                            _label_6: 
                                this.i3 = 0;
                                goto _label_9;
                            };
                            this.i7 = (this.i5 + -1);
                            this.i8 = (this.i3 - this.i7);
                            if (this.i3 == this.i7) goto _label_6;
                            this.i3 = li8(this.i2);
                            this.i2 = this.i8;
                            while ((this.i9 = this.i2), (this.i2 = this.i4), (this.i8 = this.i2), if (!(this.i9 == 0)) goto _label_7;
, (this.i2 = 0), (this.i4 = this.i2), (this.i2 = this.i4), if (this.i4 == 0) goto _label_6;
, true)
                            {
                                this.i10 = (this.i4 + 1);
                                if (this.i7 == 0) goto _label_8;
                                this.i11 = 1;
                                this.i12 = this.i5;
                                do 
                                {
                                    this.i13 = (this.i6 + this.i11);
                                    this.i14 = (this.i2 + this.i11);
                                    this.i14 = li8(this.i14);
                                    this.i13 = li8(this.i13);
                                    if ((!(this.i14 == this.i13))) break;
                                    this.i12 = (this.i12 + -1);
                                    this.i11 = (this.i11 + 1);
                                    if (this.i12 == 1) goto _label_8;
                                } while (true);
                                this.i2 = (this.i8 - this.i10);
                                this.i2 = (this.i2 + this.i9);
                                if (this.i2 == 0) goto _label_6;
                                this.i4 = this.i10;
                            };
                            
                        _label_7: 
                            this.i2 = (this.i9 + 1);
                            this.i4 = this.i8;
                            do 
                            {
                                this.i10 = li8(this.i4);
                                this.i11 = (this.i3 & 0xFF);
                                this.i12 = this.i4;
                                if (!(!(this.i10 == this.i11)))
                                {
                                    this.i2 = this.i12;
                                    //unresolved jump
                                };
                                this.i2 = (this.i2 + -1);
                                this.i4 = (this.i4 + 1);
                                //unresolved if
                            } while (true);
                            
                        _label_8: 
                            this.i3 = this.i4;
                        };
                        
                    _label_9: 
                        this.i2 = this.i3;
                        if (this.i2 == 0) goto _label_15;
                        this.i3 = 3;
                        this.i5 = (1 - this.i0);
                        this.i5 = (this.i2 + this.i5);
                        this.i7 = li32(this.i1 + 8);
                        this.f0 = Number(this.i5);
                        sf64(this.f0, this.i7);
                        si32(this.i3, (this.i7 + 8));
                        this.i5 = li32(this.i1 + 8);
                        this.i7 = (this.i5 + 12);
                        si32(this.i7, (this.i1 + 8));
                        this.i7 = li32(public::mstate.ebp + -8);
                        this.i0 = (this.i2 - this.i0);
                        this.i0 = (this.i0 + this.i7);
                        this.f0 = Number(this.i0);
                        sf64(this.f0, (this.i5 + 12));
                        si32(this.i3, (this.i5 + 20));
                        this.i0 = li32(this.i1 + 8);
                        this.i0 = (this.i0 + 12);
                        si32(this.i0, (this.i1 + 8));
                        this.i0 = 2;
                        goto _label_16;
                    };
                    
                _label_10: 
                    this.i4 = li8(this.i2);
                    if (!(this.i4 == 94))
                    {
                        this.i4 = 1;
                    }
                    else
                    {
                        this.i4 = 0;
                        this.i2 = (this.i2 + 1);
                    };
                    this.i6 = (public::mstate.ebp + -288);
                    si32(this.i1, (public::mstate.ebp + -280));
                    si32(this.i0, (public::mstate.ebp + -288));
                    this.i8 = li32(public::mstate.ebp + -4);
                    this.i8 = (this.i0 + this.i8);
                    si32(this.i8, (public::mstate.ebp + -284));
                    this.i8 = (this.i6 + 12);
                    this.i6 = (this.i6 + 4);
                    this.i4 = (this.i4 ^ 0x01);
                    this.i4 = (this.i4 & 0x01);
                    if (!(this.i4 == 0)) goto _label_12;
                    this.i0 = (this.i3 + this.i7);
                    
                _label_11: 
                    this.i3 = 0;
                    si32(this.i3, this.i8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (public::mstate.ebp + -288);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 6:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = this.i0;
                    if (!(this.i3 == 0))
                    {
                        this.i0 = this.i3;
                        this.i2 = this.i4;
                        goto _label_13;
                    };
                    this.i3 = li32(this.i6);
                    this.i4 = (this.i0 + 1);
                    if (uint(this.i0) >= uint(this.i3)) goto _label_15;
                    this.i0 = this.i4;
                    goto _label_11;
                    
                _label_12: 
                    this.i4 = 0;
                    si32(this.i4, this.i8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (public::mstate.ebp + -288);
                    this.i3 = (this.i0 + this.i3);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i0 == 0) goto _label_15;
                    this.i2 = this.i3;
                    
                _label_13: 
                    if (this.i5 == 0) goto _label_14;
                    this.i3 = 3;
                    this.i4 = (1 - this.i7);
                    this.i2 = (this.i2 + this.i4);
                    this.i4 = li32(this.i1 + 8);
                    this.f0 = Number(this.i2);
                    sf64(this.f0, this.i4);
                    si32(this.i3, (this.i4 + 8));
                    this.i2 = li32(this.i1 + 8);
                    this.i0 = (this.i0 - this.i7);
                    this.i4 = (this.i2 + 12);
                    si32(this.i4, (this.i1 + 8));
                    this.f0 = Number(this.i0);
                    sf64(this.f0, (this.i2 + 12));
                    si32(this.i3, (this.i2 + 20));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = 0;
                    this.i1 = (public::mstate.ebp + -288);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_captures.start();
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = (this.i0 + 2);
                    goto _label_16;
                    
                _label_14: 
                    this.i1 = (public::mstate.ebp + -288);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_captures.start();
                    return;
                case 9:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.eax = this.i1;
                    goto _label_17;
                    
                _label_15: 
                    this.i0 = 0;
                    this.i2 = li32(this.i1 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i1 + 8);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = 1;
                    
                _label_16: 
                    public::mstate.eax = this.i0;
                    
                _label_17: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _str_find_aux");
            };
        }


    }
}

