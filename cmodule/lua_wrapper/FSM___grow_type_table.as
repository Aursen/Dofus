package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___grow_type_table extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM___grow_type_table;
            _local_1 = new (FSM___grow_type_table)();
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
                    this.i4 = li32(this.i3);
                    this.i2 = (this.i2 + 1);
                    this.i5 = (this.i1 << 1);
                    this.i2 = ((this.i2 > this.i5) ? this.i2 : this.i5);
                    if (!(this.i1 == 8)) goto _label_3;
                    this.i5 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = (this.i2 << 2);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 1:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = this.i5;
                    if (!(!(this.i5 == 0)))
                    {
                        state = 2;
                        public::mstate.esp = (public::mstate.esp - 4);
                        FSM_abort1.start();
                        return;
                    };
                case 2:
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (this.i1 << 2);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_bcopy.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i1 < this.i2))
                    {
                        this.i1 = this.i6;
                        goto _label_5;
                    };
                    this.i4 = this.i6;
                    
                _label_1: 
                    this.i5 = (this.i1 << 2);
                    this.i5 = (this.i4 + this.i5);
                    
                _label_2: 
                    this.i6 = 0;
                    si32(this.i6, this.i5);
                    this.i5 = (this.i5 + 4);
                    this.i1 = (this.i1 + 1);
                    if (this.i1 < this.i2) goto _label_6;
                    this.i1 = this.i4;
                    goto _label_5;
                    
                _label_3: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i2 << 2);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 4:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = this.i4;
                    if (!(this.i5 == 0)) goto _label_4;
                    if (this.i4 == 0) goto _label_4;
                    this.i4 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 5:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_4: 
                    if (!(!(this.i5 == 0)))
                    {
                        state = 6;
                        public::mstate.esp = (public::mstate.esp - 4);
                        FSM_abort1.start();
                        return;
                    };
                case 6:
                    this.i4 = this.i5;
                    if (this.i1 < this.i2) goto _label_1;
                    this.i1 = this.i4;
                    
                _label_5: 
                    si32(this.i1, this.i3);
                    si32(this.i2, this.i0);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_6: 
                    goto _label_2;
                default:
                    throw ("Invalid state in ___grow_type_table");
            };
        }


    }
}

