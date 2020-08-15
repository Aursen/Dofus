package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___ungetc extends Machine 
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
            var _local_1:FSM___ungetc;
            _local_1 = new (FSM___ungetc)();
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
                    if (this.i0 == -1) goto _label_7;
                    this.i2 = li16(this.i1 + 12);
                    this.i3 = (this.i1 + 12);
                    this.i4 = this.i2;
                    this.i5 = (this.i2 & 0x04);
                    if (!(this.i5 == 0)) goto _label_2;
                    this.i5 = (this.i4 & 0x10);
                    if (this.i5 == 0) goto _label_7;
                    this.i4 = (this.i4 & 0x08);
                    if (!(!(this.i4 == 0))) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflush.start();
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i2 == 0)) goto _label_7;
                    this.i2 = 0;
                    this.i4 = li16(this.i3);
                    this.i4 = (this.i4 & 0xFFFFFFF7);
                    si16(this.i4, this.i3);
                    si32(this.i2, (this.i1 + 8));
                    si32(this.i2, (this.i1 + 24));
                    this.i2 = this.i4;
                    
                _label_1: 
                    this.i2 = (this.i2 | 0x04);
                    si16(this.i2, this.i3);
                    
                _label_2: 
                    this.i4 = li32(this.i1 + 48);
                    this.i5 = (this.i1 + 48);
                    if (this.i4 == 0) goto _label_5;
                    this.i2 = li32(this.i1 + 4);
                    this.i3 = li32(this.i1 + 52);
                    this.i6 = (this.i1 + 52);
                    this.i7 = (this.i1 + 4);
                    if (this.i2 < this.i3) goto _label_4;
                    this.i2 = (this.i1 + 64);
                    if (!(this.i4 == this.i2)) goto _label_3;
                    this.i3 = 0x0400;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = 0;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 2:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = this.i3;
                    if (this.i3 == 0) goto _label_7;
                    this.i8 = 0x0400;
                    si32(this.i3, this.i5);
                    si32(this.i8, this.i6);
                    this.i3 = li8(this.i1 + 66);
                    si8(this.i3, (this.i4 + 1023));
                    this.i3 = li8(this.i1 + 65);
                    si8(this.i3, (this.i4 + 1022));
                    this.i3 = li8(this.i2);
                    si8(this.i3, (this.i4 + 1021));
                    this.i3 = (this.i4 + 1021);
                    si32(this.i3, this.i1);
                    goto _label_4;
                    
                _label_3: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i3 << 1);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i4 == 0))
                    {
                        this.i8 = (this.i4 + this.i3);
                        this.i9 = this.i4;
                        memcpy(this.i8, this.i9, this.i3);
                        si32(this.i8, this.i1);
                        si32(this.i4, this.i5);
                        si32(this.i2, this.i6);
                        
                    _label_4: 
                        this.i2 = li32(this.i1);
                        this.i3 = (this.i2 + -1);
                        si32(this.i3, this.i1);
                        si8(this.i0, (this.i2 + -1));
                        this.i0 = li32(this.i7);
                        this.i0 = (this.i0 + 1);
                        si32(this.i0, this.i7);
                        goto _label_7;
                        
                    _label_5: 
                        this.i2 = (this.i2 & 0xFFFFFFDF);
                        si16(this.i2, this.i3);
                        this.i2 = li32(this.i1 + 16);
                        if (this.i2 == 0) goto _label_8;
                        this.i3 = li32(this.i1);
                        this.i4 = this.i1;
                        if (uint(this.i3) <= uint(this.i2)) goto _label_8;
                        this.i2 = li8(this.i3 + -1);
                        this.i3 = (this.i3 + -1);
                        this.i6 = (this.i0 & 0xFF);
                        if (!(this.i2 == this.i6)) goto _label_8;
                        si32(this.i3, this.i4);
                        this.i0 = li32(this.i1 + 4);
                        this.i0 = (this.i0 + 1);
                        
                    _label_6: 
                        si32(this.i0, (this.i1 + 4));
                    };
                    
                _label_7: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_8: 
                    this.i2 = 3;
                    this.i3 = li32(this.i1 + 4);
                    si32(this.i3, (this.i1 + 60));
                    this.i3 = li32(this.i1 + 56);
                    this.i4 = li32(this.i1);
                    si32(this.i4, this.i3);
                    this.i3 = (this.i1 + 64);
                    si32(this.i3, this.i5);
                    si32(this.i2, (this.i1 + 52));
                    si8(this.i0, (this.i1 + 66));
                    this.i0 = (this.i1 + 66);
                    si32(this.i0, this.i1);
                    this.i0 = 1;
                    goto _label_6;
                default:
                    throw ("Invalid state in ___ungetc");
            };
        }


    }
}

