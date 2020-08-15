package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM__ftello extends Machine 
    {

        public static const intRegCount:int = 9;
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


        public static function start():void
        {
            var _local_1:FSM__ftello;
            _local_1 = new (FSM__ftello)();
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
                    this.i2 = li32(this.i0 + 40);
                    if (!(!(this.i2 == 0)))
                    {
                        this.i0 = 29;
                        si32(this.i0, _val_2E_1440);
                        
                    _label_1: 
                        this.i0 = 1;
                        goto _label_8;
                    };
                    this.i2 = li16(this.i0 + 12);
                    this.i3 = (this.i0 + 12);
                    this.i4 = this.i2;
                    this.i5 = (this.i2 & 0x1000);
                    if (!(this.i5 == 0))
                    {
                        this.i5 = li32(this.i0 + 80);
                        this.i6 = li32(this.i0 + 84);
                        this.i4 = (this.i4 & 0x04);
                        if (this.i4 == 0) goto _label_4;
                        goto _label_2;
                    };
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__sseek.start();
                    return;
                case 1:
                    this.i5 = public::mstate.eax;
                    this.i6 = public::mstate.edx;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = (this.i5 & this.i6);
                    if (this.i2 == -1) goto _label_1;
                    this.i2 = li16(this.i3);
                    this.i4 = (this.i2 & 0x04);
                    if (!(this.i4 == 0))
                    {
                        
                    _label_2: 
                        this.i4 = this.i6;
                        this.i6 = li32(this.i0 + 48);
                        if (!(this.i6 == 0))
                        {
                            this.i7 = li32(this.i0 + 60);
                            this.i8 = (this.i7 >> 31);
                            this.i5 = __subc(this.i5, this.i7);
                            this.i4 = __sube(this.i4, this.i8);
                            if (this.i4 < 0) goto _label_10;
                            this.i2 = this.i5;
                            this.i3 = this.i4;
                        }
                        else
                        {
                            this.i7 = li32(this.i0 + 4);
                            this.i8 = (this.i7 >> 31);
                            this.i5 = __subc(this.i5, this.i7);
                            this.i4 = __sube(this.i4, this.i8);
                            if (this.i4 < 0) goto _label_10;
                            this.i2 = this.i5;
                            this.i3 = this.i4;
                        };
                        if (!(!(this.i6 == 0)))
                        {
                            
                        _label_3: 
                            this.i0 = this.i2;
                            this.i2 = this.i3;
                            this.i3 = 0;
                            si32(this.i0, this.i1);
                            si32(this.i2, (this.i1 + 4));
                            public::mstate.eax = this.i3;
                            goto _label_9;
                        };
                        this.i5 = 0;
                        this.i0 = li32(this.i0 + 4);
                        this.i4 = (this.i0 >> 31);
                        this.i2 = __subc(this.i2, this.i0);
                        this.i3 = __sube(this.i3, this.i4);
                        si32(this.i2, this.i1);
                        si32(this.i3, (this.i1 + 4));
                        public::mstate.eax = this.i5;
                        goto _label_9;
                        
                    _label_4: 
                        this.i3 = this.i5;
                        this.i5 = this.i6;
                        
                    _label_5: 
                        this.i4 = this.i5;
                        this.i2 = (this.i2 & 0x08);
                        if (!(!(this.i2 == 0)))
                        {
                            
                        _label_6: 
                            this.i2 = this.i3;
                            this.i3 = this.i4;
                            goto _label_3;
                        };
                        this.i2 = li32(this.i0);
                        if (this.i2 == 0) goto _label_6;
                        this.i5 = 2147483647;
                        this.i0 = li32(this.i0 + 16);
                        this.i6 = 0;
                        this.i2 = (this.i2 - this.i0);
                        this.i0 = -1;
                        this.i0 = __subc(this.i0, this.i2);
                        this.i5 = __sube(this.i5, this.i6);
                        this.i7 = ((this.i5 >= this.i4) ? 1 : 0);
                        this.i0 = ((uint(this.i0) >= uint(this.i3)) ? 1 : 0);
                        this.i5 = ((this.i5 == this.i4) ? 1 : 0);
                        this.i0 = ((this.i5 != 0) ? this.i0 : this.i7);
                        if (!(!(this.i0 == 0)))
                        {
                            this.i2 = 84;
                            si32(this.i2, _val_2E_1440);
                            
                        _label_7: 
                            this.i2 = 1;
                            public::mstate.eax = this.i2;
                        }
                        else
                        {
                            this.i0 = 0;
                            this.i2 = __addc(this.i2, this.i3);
                            this.i3 = __adde(this.i6, this.i4);
                            si32(this.i2, this.i1);
                            si32(this.i3, (this.i1 + 4));
                            
                        _label_8: 
                            public::mstate.eax = this.i0;
                        };
                        
                    _label_9: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i3 = this.i5;
                    this.i5 = this.i6;
                    goto _label_5;
                    
                _label_10: 
                    this.i0 = 5;
                    this.i2 = (this.i2 | 0x40);
                    si16(this.i2, this.i3);
                    si32(this.i0, _val_2E_1440);
                    goto _label_7;
                default:
                    throw ("Invalid state in __ftello");
            };
        }


    }
}

