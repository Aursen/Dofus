package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_next extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 2;

        public var i10:int;
        public var f0:Number;
        public var f1:Number;
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
            var _local_1:FSM_lua_next;
            _local_1 = new (FSM_lua_next)();
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
                    this.i0 = _luaO_nilobject_;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    this.i0 = ((uint(this.i2) > uint(this.i3)) ? this.i3 : this.i0);
                    this.i0 = li32(this.i0);
                    this.i3 = li32(this.i2 + -4);
                    this.i4 = (this.i2 + -4);
                    this.i5 = (this.i2 + -12);
                    this.i6 = (this.i1 + 8);
                    if (!(this.i3 == 3))
                    {
                        if (!(!(this.i3 == 0)))
                        {
                            this.i1 = -1;
                            goto _label_5;
                        };
                        this.i7 = -1;
                    }
                    else
                    {
                        this.f0 = lf64(this.i2 + -12);
                        this.i7 = int(this.f0);
                        this.f1 = Number(this.i7);
                        this.i7 = ((this.f1 == this.f0) ? this.i7 : -1);
                    };
                    if (!(this.i7 < 1))
                    {
                        this.i8 = li32(this.i0 + 28);
                        if (!(this.i8 < this.i7))
                        {
                            this.i1 = (this.i7 + -1);
                            if (this.i8 > this.i7) goto _label_3;
                            this.i1 = this.i7;
                            goto _label_6;
                        };
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_mainposition.start();
                case 1:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = this.i5;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i9 = (this.i7 + 12);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_rawequalObj.start();
                case 2:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(!(this.i10 == 0)))
                    {
                        this.i10 = li32(this.i7 + 20);
                        if (this.i3 < 4) goto _label_2;
                        if (!(this.i10 == 11)) goto _label_2;
                        this.i9 = li32(this.i9);
                        this.i10 = li32(this.i8);
                        if (!(this.i9 == this.i10)) goto _label_2;
                    };
                    this.i1 = li32(this.i0 + 16);
                    this.i1 = (this.i7 - this.i1);
                    this.i3 = li32(this.i0 + 28);
                    this.i1 = (this.i1 / 28);
                    this.i1 = (this.i3 + this.i1);
                    goto _label_5;
                    
                _label_2: 
                    this.i7 = li32(this.i7 + 24);
                    if (!(this.i7 == 0))
                    {
                        goto _label_1;
                        
                    _label_3: 
                        this.i3 = this.i7;
                        
                    _label_4: 
                        this.i5 = li32(this.i0 + 12);
                        this.i7 = (this.i3 * 12);
                        this.i5 = (this.i5 + this.i7);
                        this.i5 = li32(this.i5 + 8);
                        this.i7 = (this.i0 + 12);
                        if (!(this.i5 == 0)) goto _label_8;
                        this.i1 = this.i3;
                        goto _label_5;
                    };
                    this.i3 = __2E_str1125;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = 0;
                    
                _label_5: 
                    this.i3 = li32(this.i0 + 28);
                    this.i5 = (this.i1 + 1);
                    if (!(this.i3 > this.i5))
                    {
                        this.i1 = this.i5;
                        
                    _label_6: 
                        this.i3 = 1;
                        this.i5 = li8(this.i0 + 7);
                        this.i7 = li32(this.i0 + 28);
                        this.i3 = (this.i3 << this.i5);
                        this.i5 = (this.i1 - this.i7);
                        if (!(this.i3 > this.i5))
                        {
                            
                        _label_7: 
                            this.i1 = 0;
                            goto _label_9;
                        };
                        this.i1 = (this.i1 - this.i7);
                        this.i5 = li32(this.i0 + 16);
                        this.i7 = (this.i1 * 28);
                        this.i7 = (this.i5 + this.i7);
                        this.i7 = (this.i7 + 8);
                        this.i0 = (this.i0 + 16);
                        do 
                        {
                            this.i8 = li32(this.i7);
                            if (!(this.i8 == 0))
                            {
                                this.i7 = 1;
                                this.i1 = (this.i1 * 28);
                                this.i3 = (this.i5 + this.i1);
                                this.f0 = lf64(this.i3 + 12);
                                sf64(this.f0, (this.i2 + -12));
                                this.i3 = li32(this.i3 + 20);
                                si32(this.i3, this.i4);
                                this.i0 = li32(this.i0);
                                this.i1 = (this.i0 + this.i1);
                                this.f0 = lf64(this.i1);
                                sf64(this.f0, this.i2);
                                this.i1 = li32(this.i1 + 8);
                                si32(this.i1, (this.i2 + 8));
                                this.i1 = this.i7;
                                goto _label_9;
                            };
                            this.i7 = (this.i7 + 28);
                            this.i1 = (this.i1 + 1);
                            if (this.i3 <= this.i1) goto _label_7;
                        } while (true);
                        
                    _label_8: 
                        this.i0 = 3;
                        this.i1 = (this.i1 + 2);
                        this.f0 = Number(this.i1);
                        sf64(this.f0, (this.i2 + -12));
                        si32(this.i0, this.i4);
                        this.i1 = li32(this.i7);
                        this.i0 = (this.i3 * 12);
                        this.i1 = (this.i1 + this.i0);
                        this.f0 = lf64(this.i1);
                        sf64(this.f0, this.i2);
                        this.i1 = li32(this.i1 + 8);
                        si32(this.i1, (this.i2 + 8));
                        this.i1 = 1;
                        
                    _label_9: 
                        this.i0 = this.i1;
                        this.i1 = li32(this.i6);
                        if (!(this.i0 == 0))
                        {
                            this.i1 = (this.i1 + 12);
                            
                        _label_10: 
                            si32(this.i1, this.i6);
                            public::mstate.eax = this.i0;
                            public::mstate.esp = public::mstate.ebp;
                            public::mstate.ebp = li32(public::mstate.esp);
                            public::mstate.esp = (public::mstate.esp + 4);
                            public::mstate.esp = (public::mstate.esp + 4);
                            public::mstate.gworker = caller;
                            return;
                        };
                        this.i1 = (this.i1 + -12);
                        goto _label_10;
                    };
                    this.i3 = this.i5;
                    goto _label_4;
                default:
                    throw ("Invalid state in _lua_next");
            };
        }


    }
} cmodule.lua_wrapper

