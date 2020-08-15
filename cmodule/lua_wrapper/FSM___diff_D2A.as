package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___diff_D2A extends Machine 
    {

        public static const intRegCount:int = 14;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
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
            var _local_1:FSM___diff_D2A;
            _local_1 = new (FSM___diff_D2A)();
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
                    this.i2 = li32(this.i0 + 16);
                    this.i3 = li32(this.i1 + 16);
                    this.i4 = (this.i2 - this.i3);
                    if (!(this.i2 == this.i3))
                    {
                        this.i3 = this.i4;
                    }
                    else
                    {
                        this.i2 = 0;
                        
                    _label_1: 
                        this.i4 = (this.i2 ^ 0xFFFFFFFF);
                        this.i4 = (this.i3 + this.i4);
                        this.i5 = (this.i4 << 2);
                        this.i6 = (this.i0 + this.i5);
                        this.i5 = (this.i1 + this.i5);
                        this.i6 = li32(this.i6 + 20);
                        this.i5 = li32(this.i5 + 20);
                        if (!(this.i6 == this.i5))
                        {
                            this.i2 = ((uint(this.i6) < uint(this.i5)) ? -1 : 1);
                            this.i3 = this.i2;
                        }
                        else
                        {
                            this.i2 = (this.i2 + 1);
                            if (this.i4 > 0) goto _label_9;
                            this.i2 = 0;
                            this.i3 = this.i2;
                        };
                    };
                    this.i2 = this.i3;
                    if (!(this.i2 == 0)) goto _label_3;
                    this.i0 = li32(_freelist);
                    if (!(this.i0 == 0))
                    {
                        this.i1 = li32(this.i0);
                        si32(this.i1, _freelist);
                        goto _label_2;
                    };
                    this.i0 = _private_mem;
                    this.i1 = li32(_pmem_next);
                    this.i0 = (this.i1 - this.i0);
                    this.i0 = (this.i0 >> 3);
                    this.i0 = (this.i0 + 3);
                    if (!(uint(this.i0) > uint(288)))
                    {
                        this.i0 = 0;
                        this.i2 = (this.i1 + 24);
                        si32(this.i2, _pmem_next);
                        si32(this.i0, (this.i1 + 4));
                        this.i0 = 1;
                        si32(this.i0, (this.i1 + 8));
                        this.i0 = this.i1;
                        goto _label_2;
                    };
                    this.i0 = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_malloc.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = 0;
                    si32(this.i1, (this.i0 + 4));
                    this.i1 = 1;
                    si32(this.i1, (this.i0 + 8));
                    
                _label_2: 
                    this.i1 = 0;
                    si32(this.i1, (this.i0 + 12));
                    this.i2 = 1;
                    si32(this.i2, (this.i0 + 16));
                    si32(this.i1, (this.i0 + 20));
                    public::mstate.eax = this.i0;
                    goto _label_8;
                    
                _label_3: 
                    this.i3 = 20;
                    this.i4 = ((this.i2 < 0) ? this.i1 : this.i0);
                    this.i5 = li32(this.i4 + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i5, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___Balloc_D2A.start();
                    return;
                case 2:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i6 = (this.i2 >>> 31);
                    si32(this.i6, (this.i5 + 12));
                    this.i0 = ((this.i2 < 0) ? this.i0 : this.i1);
                    this.i1 = li32(this.i4 + 16);
                    this.i2 = li32(this.i0 + 16);
                    this.i6 = 0;
                    this.i7 = this.i6;
                    this.i8 = this.i6;
                    this.i9 = this.i5;
                    this.i10 = this.i4;
                    do 
                    {
                        this.i11 = 0;
                        this.i12 = (this.i4 + this.i3);
                        this.i13 = (this.i0 + this.i3);
                        this.i12 = li32(this.i12);
                        this.i13 = li32(this.i13);
                        this.i12 = __subc(this.i12, this.i13);
                        this.i13 = __sube(this.i11, this.i11);
                        this.i6 = __subc(this.i12, this.i6);
                        this.i7 = __sube(this.i13, this.i7);
                        this.i12 = (this.i9 + this.i3);
                        si32(this.i6, this.i12);
                        this.i6 = (this.i7 & 0x01);
                        this.i3 = (this.i3 + 4);
                        this.i7 = (this.i8 + 1);
                        if (this.i7 >= this.i2) goto _label_4;
                        this.i8 = this.i7;
                        this.i7 = this.i11;
                    } while (true);
                    do 
                    {
                        this.i0 = 0;
                        do 
                        {
                            this.i2 = 0;
                            this.i3 = (this.i7 + this.i0);
                            this.i3 = (this.i3 << 2);
                            this.i4 = (this.i10 + this.i3);
                            this.i4 = li32(this.i4 + 20);
                            this.i6 = __subc(this.i4, this.i6);
                            this.i11 = __sube(this.i2, this.i11);
                            this.i3 = (this.i5 + this.i3);
                            this.i0 = (this.i0 + 1);
                            si32(this.i6, (this.i3 + 20));
                            this.i6 = (this.i11 & 0x01);
                            this.i11 = (this.i7 + this.i0);
                            if (this.i11 >= this.i1) goto _label_5;
                            this.i11 = this.i2;
                        } while (true);
                        
                    _label_4: 
                        this.i0 = (this.i7 << 2);
                        this.i0 = (this.i5 + this.i0);
                        this.i0 = (this.i0 + 20);
                    } while ((this.i7 < this.i1));
                    this.i11 = this.i0;
                    while ((this.i0 = li32(this.i11 + -4)), (this.i0 == 0))
                    {
                        this.i2 = -1;
                        this.i11 = (this.i11 + -8);
                        this.i0 = this.i11;
                        this.i11 = this.i2;
                        do 
                        {
                            this.i2 = li32(this.i0);
                            this.i0 = (this.i0 + -4);
                            this.i11 = (this.i11 + 1);
                            if (!(this.i2 == 0)) goto _label_6;
                        } while (true);
                        
                    _label_5: 
                        this.i11 = (this.i11 << 2);
                        this.i11 = (this.i5 + this.i11);
                        this.i11 = (this.i11 + 20);
                    };
                    this.i11 = this.i1;
                    goto _label_7;
                    
                _label_6: 
                    this.i11 = (this.i1 - this.i11);
                    this.i11 = (this.i11 + -1);
                    
                _label_7: 
                    this.i0 = this.i11;
                    si32(this.i0, (this.i5 + 16));
                    public::mstate.eax = this.i5;
                    
                _label_8: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_9: 
                    goto _label_1;
                default:
                    throw ("Invalid state in ___diff_D2A");
            };
        }


    }
}

