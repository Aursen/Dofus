package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_strcoll extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_strcoll;
            _local_1 = new (FSM_strcoll)();
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
                    public::mstate.esp = (public::mstate.esp - 24);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li8(___collate_load_error_2E_b);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = this.i0;
                    this.i4 = this.i2;
                    if (!(!(this.i1 == 0)))
                    {
                        this.i0 = li8(this.i0);
                        this.i1 = li8(this.i2);
                        if ((this.i0 == this.i1))
                        {
                            this.i2 = 0;
                            do 
                            {
                                this.i1 = (this.i4 + this.i2);
                                this.i1 = (this.i1 + 1);
                                this.i0 = (this.i0 & 0xFF);
                                if (this.i0 == 0) goto _label_1;
                                this.i0 = (this.i3 + this.i2);
                                this.i0 = li8(this.i0 + 1);
                                this.i1 = li8(this.i1);
                                this.i2 = (this.i2 + 1);
                            } while (!(!(this.i0 == this.i1)));
                            this.i2 = (this.i4 + this.i2);
                        };
                        this.i2 = li8(this.i2);
                        this.i0 = (this.i0 & 0xFF);
                        this.i0 = (this.i0 - this.i2);
                        goto _label_18;
                        
                    _label_1: 
                        this.i0 = 0;
                        goto _label_18;
                    };
                    this.i1 = 1;
                    si32(this.i1, (public::mstate.ebp + -20));
                    si32(this.i1, (public::mstate.ebp + -24));
                    this.i1 = li8(___collate_substitute_nontrivial_2E_b);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = 0;
                        this.i3 = this.i1;
                        this.i4 = this.i1;
                        goto _label_10;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___collate_substitute.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___collate_substitute.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = li8(this.i0);
                    if (!(this.i2 == 0))
                    {
                        this.i2 = 0;
                        this.i3 = this.i0;
                        this.i4 = this.i1;
                        goto _label_11;
                    };
                    this.i2 = 0;
                    this.i3 = this.i0;
                    this.i4 = this.i1;
                    goto _label_12;
                    
                _label_2: 
                    this.i0 = 0;
                    si32(this.i0, (public::mstate.ebp + -12));
                    si32(this.i0, (public::mstate.ebp + -16));
                    this.i0 = li8(this.i6);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = 0;
                        goto _label_4;
                    };
                    this.i0 = this.i6;
                    goto _label_5;
                    
                _label_3: 
                    this.i4 = (public::mstate.ebp + -8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -16);
                    this.i9 = (public::mstate.ebp + -24);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___collate_lookup.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(public::mstate.ebp + -24);
                    this.i0 = (this.i2 + this.i0);
                    this.i2 = (this.i6 + this.i0);
                    this.i4 = li8(this.i2);
                    if (this.i4 == 0) goto _label_20;
                    
                _label_4: 
                    this.i2 = this.i0;
                    this.i4 = li32(public::mstate.ebp + -16);
                    this.i0 = (this.i6 + this.i2);
                    if (this.i4 == 0) goto _label_3;
                    
                _label_5: 
                    this.i2 = 0;
                    goto _label_7;
                    
                _label_6: 
                    this.i4 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i8 = (public::mstate.ebp + -12);
                    this.i9 = (public::mstate.ebp + -20);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___collate_lookup.start();
                case 4:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i4 = li32(public::mstate.ebp + -20);
                    this.i2 = (this.i2 + this.i4);
                    
                _label_7: 
                    this.i6 = (this.i7 + this.i2);
                    this.i4 = li8(this.i6);
                    if (!(this.i4 == 0))
                    {
                        this.i4 = li32(public::mstate.ebp + -12);
                        if (this.i4 == 0) goto _label_6;
                    };
                    this.i2 = li32(public::mstate.ebp + -16);
                    if (!(!(this.i2 == 0)))
                    {
                        
                    _label_8: 
                        this.i4 = this.i1;
                        this.i2 = this.i5;
                        this.i1 = this.i6;
                        goto _label_12;
                    };
                    this.i4 = li32(public::mstate.ebp + -12);
                    if (this.i4 == 0) goto _label_8;
                    if (this.i2 == this.i4) goto _label_9;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 5:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = (this.i2 - this.i4);
                    goto _label_18;
                    
                _label_9: 
                    if (!(this.i5 == 0))
                    {
                        this.i2 = this.i6;
                        this.i4 = this.i3;
                        this.i3 = this.i5;
                    }
                    else
                    {
                        this.i2 = li32(public::mstate.ebp + -8);
                        this.i4 = li32(public::mstate.ebp + -4);
                        this.i5 = (this.i2 - this.i4);
                        this.i2 = this.i6;
                        this.i4 = this.i3;
                        this.i3 = this.i5;
                    };
                    
                _label_10: 
                    this.i5 = this.i2;
                    this.i2 = this.i4;
                    this.i6 = this.i3;
                    this.i3 = li8(this.i0);
                    if (this.i3 == 0) goto _label_21;
                    this.i3 = this.i0;
                    this.i4 = this.i5;
                    this.i0 = this.i2;
                    this.i2 = this.i6;
                    
                _label_11: 
                    this.i6 = this.i3;
                    this.i7 = this.i4;
                    this.i3 = this.i0;
                    this.i5 = this.i2;
                    this.i0 = li8(this.i7);
                    if (!(this.i0 == 0)) goto _label_2;
                    this.i4 = this.i1;
                    this.i2 = this.i5;
                    this.i0 = this.i6;
                    this.i1 = this.i7;
                    
                _label_12: 
                    this.i0 = li8(this.i0);
                    if (!(this.i0 == 0)) goto _label_14;
                    this.i5 = li8(this.i1);
                    if (this.i5 == 0) goto _label_13;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 7:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    this.i0 = (this.i5 & 0xFF);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 8:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = (0 - this.i0);
                    goto _label_18;
                    
                _label_13: 
                    this.i6 = (this.i0 & 0xFF);
                    if (!(!(this.i6 == 0)))
                    {
                        this.i0 = this.i5;
                        goto _label_16;
                    };
                    
                _label_14: 
                    this.i1 = li8(this.i1);
                    if (!(this.i1 == 0)) goto _label_15;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 10:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = (this.i0 & 0xFF);
                    goto _label_18;
                    
                _label_15: 
                    this.i0 = (this.i0 & 0xFF);
                    if (!(this.i0 == 0)) goto _label_17;
                    this.i0 = this.i1;
                    
                _label_16: 
                    this.i0 = (this.i0 & 0xFF);
                    if (!(this.i0 == 0)) goto _label_17;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 11:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 12:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.eax = this.i2;
                    goto _label_19;
                    
                _label_17: 
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 13:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 14:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_18: 
                    public::mstate.eax = this.i0;
                    
                _label_19: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_20: 
                    this.i0 = this.i2;
                    goto _label_5;
                    
                _label_21: 
                    this.i3 = this.i2;
                    this.i4 = this.i1;
                    this.i2 = this.i6;
                    this.i1 = this.i5;
                    goto _label_12;
                default:
                    throw ("Invalid state in _strcoll");
            };
        }


    }
} cmodule.lua_wrapper

