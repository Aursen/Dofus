package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___pow5mult_D2A extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;


        public static function start():void
        {
            var _local_1:FSM___pow5mult_D2A;
            _local_1 = new (FSM___pow5mult_D2A)();
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
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = (this.i0 & 0x03);
                    if (!(!(this.i2 == 0))) goto _label_1;
                    this.i3 = _p05_2E_3773;
                    this.i2 = (this.i2 << 2);
                    this.i2 = (this.i2 + this.i3);
                    this.i2 = li32(this.i2 + -4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___multadd_D2A.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i2 = (this.i0 >> 2);
                    if (!(uint(this.i0) > uint(3)))
                    {
                        
                    _label_2: 
                        this.i0 = this.i1;
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i0 = li32(_p5s);
                    if (!(this.i0 == 0)) goto _label_4;
                    this.i0 = li32(_freelist + 4);
                    if (!(this.i0 == 0))
                    {
                        this.i3 = li32(this.i0);
                        si32(this.i3, (_freelist + 4));
                        goto _label_3;
                    };
                    this.i0 = _private_mem;
                    this.i3 = li32(_pmem_next);
                    this.i0 = (this.i3 - this.i0);
                    this.i0 = (this.i0 >> 3);
                    this.i0 = (this.i0 + 4);
                    if (!(uint(this.i0) > uint(288)))
                    {
                        this.i0 = 1;
                        this.i4 = (this.i3 + 32);
                        si32(this.i4, _pmem_next);
                        si32(this.i0, (this.i3 + 4));
                        this.i0 = 2;
                        si32(this.i0, (this.i3 + 8));
                        this.i0 = this.i3;
                        goto _label_3;
                    };
                    this.i0 = 32;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_malloc.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = 1;
                    si32(this.i3, (this.i0 + 4));
                    this.i3 = 2;
                    si32(this.i3, (this.i0 + 8));
                    
                _label_3: 
                    this.i3 = 0;
                    si32(this.i3, (this.i0 + 12));
                    this.i4 = 625;
                    si32(this.i4, (this.i0 + 20));
                    this.i4 = 1;
                    si32(this.i4, (this.i0 + 16));
                    si32(this.i0, _p5s);
                    si32(this.i3, this.i0);
                    
                _label_4: 
                    this.i3 = (this.i2 & 0x01);
                    if (!(!(this.i3 == 0))) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___mult_D2A.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = this.i3;
                    }
                    else
                    {
                        this.i4 = _freelist;
                        this.i5 = li32(this.i1 + 4);
                        this.i5 = (this.i5 << 2);
                        this.i4 = (this.i4 + this.i5);
                        this.i5 = li32(this.i4);
                        si32(this.i5, this.i1);
                        si32(this.i1, this.i4);
                        this.i1 = this.i3;
                    };
                    
                _label_5: 
                    this.i3 = (this.i2 >> 1);
                    if (!(uint(this.i2) > uint(1))) goto _label_2;
                    this.i2 = li32(this.i0);
                    this.i4 = this.i0;
                    if (!(this.i2 == 0))
                    {
                        this.i0 = this.i2;
                        this.i2 = this.i3;
                        goto _label_4;
                    };
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___mult_D2A.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, this.i4);
                    si32(this.i2, this.i0);
                    this.i2 = this.i3;
                    goto _label_4;
                default:
                    throw ("Invalid state in ___pow5mult_D2A");
            };
        }


    }
}

