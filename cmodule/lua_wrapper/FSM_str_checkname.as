package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_str_checkname extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_str_checkname;
            _local_1 = new (FSM_str_checkname)();
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
                    this.i1 = li32(this.i0 + 12);
                    this.i2 = (this.i0 + 12);
                    if (this.i1 == 285) goto _label_1;
                    this.i1 = 285;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_error_expected.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i1 = li32(this.i0 + 16);
                    this.i3 = li32(this.i0 + 4);
                    si32(this.i3, (this.i0 + 8));
                    this.i3 = li32(this.i0 + 24);
                    this.i4 = (this.i0 + 16);
                    this.i5 = (this.i0 + 24);
                    if (!(this.i3 == 287))
                    {
                        this.i4 = 287;
                        si32(this.i3, this.i2);
                        this.f0 = lf64(this.i0 + 28);
                        sf64(this.f0, (this.i0 + 16));
                        si32(this.i4, this.i5);
                        
                    _label_2: 
                        public::mstate.eax = this.i1;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, this.i2);
                    goto _label_2;
                default:
                    throw ("Invalid state in _str_checkname");
            };
        }


    }
}

