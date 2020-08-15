package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___Balloc_D2A extends Machine 
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
            var _local_1:FSM___Balloc_D2A;
            _local_1 = new (FSM___Balloc_D2A)();
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
                    this.i0 = _freelist;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = (this.i1 << 2);
                    this.i0 = (this.i0 + this.i2);
                    this.i2 = li32(this.i0);
                    if (!(this.i2 == 0))
                    {
                        this.i1 = li32(this.i2);
                        si32(this.i1, this.i0);
                        this.i1 = this.i2;
                        goto _label_1;
                    };
                    this.i0 = 1;
                    this.i0 = (this.i0 << this.i1);
                    this.i2 = (this.i0 << 2);
                    this.i3 = li32(_pmem_next);
                    this.i2 = (this.i2 + 27);
                    this.i4 = _private_mem;
                    this.i4 = (this.i3 - this.i4);
                    this.i5 = (this.i2 >>> 3);
                    this.i4 = (this.i4 >> 3);
                    this.i4 = (this.i4 + this.i5);
                    if (!(uint(this.i4) > uint(288)))
                    {
                        this.i2 = (this.i5 << 3);
                        this.i2 = (this.i3 + this.i2);
                        si32(this.i2, _pmem_next);
                        si32(this.i1, (this.i3 + 4));
                        si32(this.i0, (this.i3 + 8));
                        this.i1 = this.i3;
                        goto _label_1;
                    };
                    this.i3 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 & 0xFFFFFFF8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i1, (this.i2 + 4));
                    si32(this.i0, (this.i2 + 8));
                    this.i1 = this.i2;
                    
                _label_1: 
                    this.i0 = this.i1;
                    this.i1 = 0;
                    si32(this.i1, (this.i0 + 16));
                    si32(this.i1, (this.i0 + 12));
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___Balloc_D2A");
            };
        }


    }
}

