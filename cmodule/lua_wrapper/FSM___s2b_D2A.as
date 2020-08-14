package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___s2b_D2A extends Machine 
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
            var _local_1:FSM___s2b_D2A;
            _local_1 = new (FSM___s2b_D2A)();
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
                    this.i1 = (this.i0 + 8);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = li32(public::mstate.ebp + 12);
                    this.i4 = li32(public::mstate.ebp + 20);
                    this.i5 = (this.i1 / 9);
                    this.i6 = this.i2;
                    if (!(this.i1 < 18))
                    {
                        this.i1 = 1;
                        this.i7 = 0;
                        do 
                        {
                            this.i7 = (this.i7 + 1);
                            this.i1 = (this.i1 << 1);
                            if (!(this.i5 > this.i1))
                            {
                                this.i1 = this.i7;
                                goto _label_1;
                            };
                        } while (true);
                    };
                    this.i1 = 0;
                    
                _label_1: 
                    this.i5 = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___Balloc_D2A.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i4, (this.i1 + 20));
                    si32(this.i5, (this.i1 + 16));
                    if (this.i3 < 10) goto _label_3;
                    this.i4 = 0;
                    this.i5 = (this.i3 + -9);
                    
                _label_2: 
                    this.i7 = 10;
                    this.i8 = (this.i6 + this.i4);
                    this.i8 = sxi8(li8(this.i8 + 9));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i8 = (this.i8 + -48);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___multadd_D2A.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = (this.i4 + 1);
                    if (!(this.i4 == this.i5)) goto _label_2;
                    this.i4 = (this.i4 << 0);
                    this.i2 = (this.i4 + this.i2);
                    this.i2 = (this.i2 + 10);
                    if (!(this.i3 < this.i0)) goto _label_6;
                    goto _label_4;
                    
                _label_3: 
                    this.i2 = (this.i2 + 10);
                    if (!(this.i0 > 9)) goto _label_6;
                    this.i3 = 9;
                    
                _label_4: 
                    this.i4 = 0;
                    
                _label_5: 
                    this.i5 = 10;
                    this.i6 = (this.i2 + this.i4);
                    this.i6 = sxi8(li8(this.i6));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (this.i6 + -48);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___multadd_D2A.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = (this.i4 + 1);
                    this.i5 = (this.i3 + this.i4);
                    if (!(this.i5 < this.i0))
                    {
                        
                    _label_6: 
                        this.i0 = this.i1;
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    goto _label_5;
                default:
                    throw ("Invalid state in ___s2b_D2A");
            };
        }


    }
} cmodule.lua_wrapper

