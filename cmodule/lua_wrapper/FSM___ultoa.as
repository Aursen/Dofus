package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___ultoa extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 0;

        public var i10:int;
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
            var _local_1:FSM___ultoa;
            _local_1 = new (FSM___ultoa)();
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
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(public::mstate.ebp + 20);
                    this.i4 = li32(public::mstate.ebp + 24);
                    this.i5 = li32(public::mstate.ebp + 28);
                    this.i6 = sxi8(li8(public::mstate.ebp + 32));
                    this.i7 = li32(public::mstate.ebp + 36);
                    if (!(this.i2 == 8))
                    {
                        if (!(this.i2 == 10))
                        {
                            if (!(this.i2 == 16)) goto _label_6;
                            this.i3 = 0;
                            do 
                            {
                                this.i2 = (this.i0 & 0x0F);
                                this.i2 = (this.i4 + this.i2);
                                this.i5 = (this.i3 ^ 0xFFFFFFFF);
                                this.i2 = li8(this.i2);
                                this.i5 = (this.i1 + this.i5);
                                si8(this.i2, this.i5);
                                this.i3 = (this.i3 + 1);
                                this.i2 = (this.i0 >>> 4);
                                if (uint(this.i0) < uint(16)) goto _label_7;
                                this.i0 = this.i2;
                            } while (true);
                        };
                        if (!(uint(this.i0) > uint(9)))
                        {
                            this.i0 = (this.i0 + 48);
                            si8(this.i0, (this.i1 + -1));
                            this.i0 = (this.i1 + -1);
                            goto _label_9;
                        };
                        if (!(this.i0 < 0))
                        {
                            this.i3 = 0;
                            this.i4 = this.i1;
                        }
                        else
                        {
                            this.i3 = 1;
                            this.i4 = (uint(this.i0) / uint(10));
                            this.i2 = (this.i4 * 10);
                            this.i0 = (this.i0 - this.i2);
                            this.i0 = (this.i0 + 48);
                            si8(this.i0, (this.i1 + -1));
                            this.i1 = (this.i1 + -1);
                            this.i0 = this.i4;
                            this.i4 = this.i1;
                        };
                        this.i1 = this.i7;
                        do 
                        {
                            this.i2 = (this.i1 + 1);
                            this.i7 = this.i1;
                            if (!(this.i5 == 0))
                            {
                                
                            _label_1: 
                                this.i8 = (this.i0 / 10);
                                this.i8 = (this.i8 * 10);
                                this.i8 = (this.i0 - this.i8);
                                this.i8 = (this.i8 + 48);
                                si8(this.i8, (this.i4 + -1));
                                this.i8 = li8(this.i7);
                                this.i3 = (this.i3 + 1);
                                this.i9 = (this.i4 + -1);
                                this.i10 = (this.i8 << 24);
                                this.i10 = (this.i10 >> 24);
                                if (this.i10 == this.i3) goto _label_4;
                                
                            _label_2: 
                                this.i4 = this.i9;
                                
                            _label_3: 
                                this.i8 = (this.i0 / 10);
                                this.i0 = (this.i0 + 9);
                                if ((uint(this.i0) > uint(18))) break;
                                this.i3 = this.i4;
                                goto _label_8;
                            };
                            this.i3 = this.i4;
                            do 
                            {
                                this.i4 = (this.i0 / 10);
                                this.i1 = (this.i4 * 10);
                                this.i1 = (this.i0 - this.i1);
                                this.i1 = (this.i1 + 48);
                                si8(this.i1, (this.i3 + -1));
                                this.i3 = (this.i3 + -1);
                                this.i0 = (this.i0 + 9);
                                if (!(uint(this.i0) > uint(18))) goto _label_8;
                                this.i0 = this.i4;
                            } while (true);
                            
                        _label_4: 
                            this.i8 = (this.i8 & 0xFF);
                            if (this.i8 == 127) goto _label_2;
                            if (this.i0 < 10) goto _label_2;
                            si8(this.i6, (this.i4 + -2));
                            this.i3 = li8(this.i2);
                            this.i4 = (this.i4 + -2);
                            if (!(!(this.i3 == 0)))
                            {
                                this.i3 = 0;
                                goto _label_3;
                            };
                            this.i3 = (this.i1 + 1);
                            this.i2 = (this.i0 / 10);
                            this.i0 = (this.i0 + 9);
                            if (!(uint(this.i0) > uint(18)))
                            {
                                this.i3 = this.i4;
                                goto _label_8;
                            };
                            this.i0 = 0;
                            this.i1 = this.i3;
                            this.i3 = this.i0;
                            this.i0 = this.i2;
                        } while (true);
                        this.i0 = this.i8;
                        goto _label_1;
                    };
                    this.i4 = 0;
                    do 
                    {
                        this.i2 = (this.i0 | 0x30);
                        this.i5 = (this.i4 ^ 0xFFFFFFFF);
                        this.i2 = (this.i2 & 0x37);
                        this.i5 = (this.i1 + this.i5);
                        si8(this.i2, this.i5);
                        this.i4 = (this.i4 + 1);
                        this.i6 = (this.i0 >>> 3);
                        if ((uint(this.i0) < uint(8))) break;
                        this.i0 = this.i6;
                    } while (true);
                    if (!(this.i3 == 0))
                    {
                        this.i3 = (this.i2 & 0xFF);
                        if (!(this.i3 == 48)) goto _label_5;
                    };
                    this.i3 = this.i5;
                    goto _label_8;
                    
                _label_5: 
                    this.i3 = 48;
                    this.i0 = (this.i4 + -1);
                    this.i0 = (-2 - this.i0);
                    this.i0 = (this.i1 + this.i0);
                    si8(this.i3, this.i0);
                    goto _label_9;
                    
                _label_6: 
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_abort1.start();
                    return;
                case 1:
                    
                _label_7: 
                    this.i3 = this.i5;
                    
                _label_8: 
                    this.i0 = this.i3;
                    
                _label_9: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___ultoa");
            };
        }


    }
}

