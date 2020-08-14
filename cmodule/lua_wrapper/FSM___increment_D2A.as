package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___increment_D2A extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;


        public static function start():void
        {
            var _local_1:FSM___increment_D2A;
            _local_1 = new (FSM___increment_D2A)();
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
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 16);
                    this.i3 = (this.i1 + 20);
                    this.i4 = (this.i1 + 16);
                    do 
                    {
                        this.i5 = li32(this.i3);
                        this.i6 = this.i3;
                        if ((this.i5 == -1)) continue;
                        this.i0 = (this.i5 + 1);
                        si32(this.i0, this.i6);
                        public::mstate.eax = this.i1;
                    } while ((public::mstate.esp = public::mstate.ebp), (public::mstate.ebp = li32(public::mstate.esp)), (public::mstate.esp = (public::mstate.esp + 4)), (public::mstate.esp = (public::mstate.esp + 4)), (public::mstate.gworker = caller), return, (this.i5 = 0), si32(this.i5, this.i6), (this.i3 = (this.i3 + 4)), (this.i0 = (this.i0 + 1)), !(this.i0 >= this.i2));
                    this.i0 = li32(this.i1 + 8);
                    if (!(this.i2 >= this.i0)) goto _label_1;
                    this.i0 = li32(this.i1 + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___Balloc_D2A.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = li32(this.i4);
                    this.i3 = (this.i0 + 12);
                    this.i2 = (this.i2 << 2);
                    this.i4 = (this.i1 + 12);
                    this.i2 = (this.i2 + 8);
                    memcpy(this.i3, this.i4, this.i2);
                    this.i2 = (this.i1 + 4);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = this.i0;
                    }
                    else
                    {
                        this.i3 = _freelist;
                        this.i2 = li32(this.i2);
                        this.i2 = (this.i2 << 2);
                        this.i2 = (this.i3 + this.i2);
                        this.i3 = li32(this.i2);
                        si32(this.i3, this.i1);
                        si32(this.i1, this.i2);
                        this.i1 = this.i0;
                    };
                    
                _label_1: 
                    this.i0 = this.i1;
                    this.i1 = 1;
                    this.i2 = li32(this.i0 + 16);
                    this.i3 = (this.i2 << 2);
                    this.i3 = (this.i0 + this.i3);
                    si32(this.i1, (this.i3 + 20));
                    this.i1 = (this.i2 + 1);
                    si32(this.i1, (this.i0 + 16));
                    public::mstate.eax = this.i0;
                    //unresolved jump
                default:
                    throw ("Invalid state in ___increment_D2A");
            };
        }


    }
} cmodule.lua_wrapper

