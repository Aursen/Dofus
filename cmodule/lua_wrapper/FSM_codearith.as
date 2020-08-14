package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_codearith extends Machine 
    {

        public static const intRegCount:int = 9;
        public static const NumberRegCount:int = 4;

        public var f0:Number;
        public var f1:Number;
        public var f2:Number;
        public var f3:Number;
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
            var _local_1:FSM_codearith;
            _local_1 = new (FSM_codearith)();
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
                    this.i0 = li32(public::mstate.ebp + 16);
                    this.i1 = li32(this.i0);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(public::mstate.ebp + 20);
                    this.i5 = this.i0;
                    if (!(!(this.i1 == 5)))
                    {
                        this.i1 = li32(this.i0 + 12);
                        if (!(!(this.i1 == -1)))
                        {
                            this.i1 = li32(this.i0 + 16);
                            if (!(!(this.i1 == -1)))
                            {
                                this.i1 = li32(this.i4);
                                if (!(!(this.i1 == 5)))
                                {
                                    this.i1 = li32(this.i4 + 12);
                                    if (!(!(this.i1 == -1)))
                                    {
                                        this.i1 = li32(this.i4 + 16);
                                        if (!(!(this.i1 == -1)))
                                        {
                                            this.f1 = lf64(this.i0 + 4);
                                            this.f2 = lf64(this.i4 + 4);
                                            this.i1 = (this.i0 + 4);
                                            if (!(this.i3 > 15))
                                            {
                                                if (!(this.i3 > 13))
                                                {
                                                    if (this.i3 == 12) goto _label_3;
                                                    if (!(this.i3 == 13)) goto _label_1;
                                                    this.f0 = 0;
                                                    this.f1 = (this.f1 - this.f2);
                                                    if ((this.f1 == Number.NaN) || (this.f0 == Number.NaN)) goto _label_10;
                                                    goto _label_8;
                                                };
                                                if (this.i3 == 14) goto _label_4;
                                                if (!(this.i3 == 15)) goto _label_1;
                                                this.f0 = 0;
                                                if (this.f2 == this.f0) goto _label_10;
                                                this.f0 = 0;
                                                this.f1 = (this.f1 / this.f2);
                                                if ((this.f1 == Number.NaN) || (this.f0 == Number.NaN)) goto _label_10;
                                                goto _label_8;
                                            };
                                            if (!(this.i3 > 17))
                                            {
                                                if (this.i3 == 16) goto _label_5;
                                                if (this.i3 == 17) goto _label_6;
                                                
                                            _label_1: 
                                                this.f1 = 0;
                                                goto _label_7;
                                            };
                                            if (!(this.i3 == 18))
                                            {
                                                if (!(this.i3 == 20)) goto _label_1;
                                                
                                            _label_2: 
                                                this.i1 = 0;
                                                goto _label_11;
                                                
                                            _label_3: 
                                                this.f0 = 0;
                                                this.f1 = (this.f1 + this.f2);
                                                if ((this.f1 == Number.NaN) || (this.f0 == Number.NaN)) goto _label_10;
                                                goto _label_8;
                                                
                                            _label_4: 
                                                this.f0 = 0;
                                                this.f1 = (this.f1 * this.f2);
                                                if ((this.f1 == Number.NaN) || (this.f0 == Number.NaN)) goto _label_10;
                                                goto _label_8;
                                                
                                            _label_5: 
                                                this.f0 = 0;
                                                if (this.f2 == this.f0) goto _label_10;
                                                this.f3 = 0;
                                                this.f0 = (this.f1 / this.f2);
                                                this.f0 = Math.floor(this.f0);
                                                this.f2 = (this.f0 * this.f2);
                                                this.f1 = (this.f1 - this.f2);
                                                if ((this.f1 == Number.NaN) || (this.f3 == Number.NaN)) goto _label_10;
                                                goto _label_8;
                                                
                                            _label_6: 
                                                this.f3 = 0;
                                                this.f0 = this.f1;
                                                this.f1 = this.f2;
                                                this.f0 = Math.pow(this.f0, this.f1);
                                                this.f1 = this.f0;
                                                if ((this.f1 == Number.NaN) || (this.f3 == Number.NaN)) goto _label_10;
                                            }
                                            else
                                            {
                                                this.f1 = -(this.f1);
                                                
                                            _label_7: 
                                                this.f0 = 0;
                                                if ((this.f1 == Number.NaN) || (this.f0 == Number.NaN)) goto _label_10;
                                            };
                                            
                                        _label_8: 
                                            this.f0 = this.f1;
                                            sf64(this.f0, this.i1);
                                            
                                        _label_9: 
                                            public::mstate.esp = public::mstate.ebp;
                                            public::mstate.ebp = li32(public::mstate.esp);
                                            public::mstate.esp = (public::mstate.esp + 4);
                                            public::mstate.esp = (public::mstate.esp + 4);
                                            public::mstate.gworker = caller;
                                            return;
                                        };
                                    };
                                };
                            };
                        };
                    };
                    
                _label_10: 
                    if (this.i3 == 18) goto _label_2;
                    if (this.i3 == 20) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2RK.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_11: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2RK.start();
                    return;
                case 2:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = (this.i0 + 4);
                    if (this.i6 <= this.i1) goto _label_13;
                    this.i7 = li32(this.i5);
                    if (!(!(this.i7 == 12)))
                    {
                        this.i7 = li32(this.i0);
                        this.i8 = (this.i7 & 0x0100);
                        if (!(!(this.i8 == 0)))
                        {
                            this.i8 = li8(this.i2 + 50);
                            if (!(this.i8 > this.i7))
                            {
                                this.i7 = li32(this.i2 + 36);
                                this.i7 = (this.i7 + -1);
                                si32(this.i7, (this.i2 + 36));
                            };
                        };
                    };
                    this.i7 = li32(this.i4);
                    if (!(!(this.i7 == 12)))
                    {
                        this.i4 = li32(this.i4 + 4);
                        this.i7 = (this.i4 & 0x0100);
                        if (!(!(this.i7 == 0)))
                        {
                            this.i7 = li8(this.i2 + 50);
                            if (!(this.i7 > this.i4))
                            {
                                this.i4 = li32(this.i2 + 36);
                                this.i4 = (this.i4 + -1);
                                si32(this.i4, (this.i2 + 36));
                            };
                        };
                    };
                    
                _label_12: 
                    this.i4 = 11;
                    this.i7 = li32(this.i2 + 12);
                    this.i7 = li32(this.i7 + 8);
                    this.i6 = (this.i6 << 23);
                    this.i3 = (this.i6 | this.i3);
                    this.i1 = (this.i1 << 14);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i3 | this.i1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i0);
                    si32(this.i4, this.i5);
                    goto _label_9;
                    
                _label_13: 
                    this.i7 = li32(this.i4);
                    if (!(!(this.i7 == 12)))
                    {
                        this.i4 = li32(this.i4 + 4);
                        this.i7 = (this.i4 & 0x0100);
                        if (!(!(this.i7 == 0)))
                        {
                            this.i7 = li8(this.i2 + 50);
                            if (!(this.i7 > this.i4))
                            {
                                this.i4 = li32(this.i2 + 36);
                                this.i4 = (this.i4 + -1);
                                si32(this.i4, (this.i2 + 36));
                            };
                        };
                    };
                    this.i4 = li32(this.i5);
                    if (!(!(this.i4 == 12)))
                    {
                        this.i4 = li32(this.i0);
                        this.i7 = (this.i4 & 0x0100);
                        if (!(!(this.i7 == 0)))
                        {
                            this.i7 = li8(this.i2 + 50);
                            if (!(this.i7 > this.i4))
                            {
                                this.i4 = li32(this.i2 + 36);
                                this.i4 = (this.i4 + -1);
                                si32(this.i4, (this.i2 + 36));
                            };
                        };
                    };
                    goto _label_12;
                default:
                    throw ("Invalid state in _codearith");
            };
        }


    }
} cmodule.lua_wrapper

