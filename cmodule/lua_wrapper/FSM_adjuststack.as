package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_adjuststack extends Machine 
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
            var _local_1:FSM_adjuststack;
            _local_1 = new (FSM_adjuststack)();
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
                    this.i1 = li32(this.i0 + 4);
                    this.i2 = (this.i0 + 4);
                    if (this.i1 < 2) goto _label_3;
                    this.i1 = -1;
                    this.i0 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_objlen.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = 1;
                    this.i4 = 0;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = (this.i4 + -2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_objlen.start();
                    return;
                case 2:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i2);
                    this.i7 = (this.i6 + this.i4);
                    if (!(this.i7 > 9))
                    {
                        if (!(uint(this.i1) > uint(this.i5)))
                        {
                            this.i1 = this.i3;
                            goto _label_2;
                        };
                    };
                    this.i4 = (this.i4 + -1);
                    this.i3 = (this.i3 + 1);
                    this.i1 = (this.i5 + this.i1);
                    if (this.i6 > this.i3) goto _label_4;
                    this.i1 = this.i3;
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i2);
                    this.i1 = (1 - this.i1);
                    this.i0 = (this.i1 + this.i0);
                    si32(this.i0, this.i2);
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_4: 
                    goto _label_1;
                default:
                    throw ("Invalid state in _adjuststack");
            };
        }


    }
}

