package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_emptybuffer extends Machine 
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
            var _local_1:FSM_emptybuffer;
            _local_1 = new (FSM_emptybuffer)();
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
                    this.i1 = li32(this.i0);
                    this.i2 = (this.i0 + 12);
                    this.i3 = this.i0;
                    if (this.i1 == this.i2) goto _label_2;
                    this.i4 = li32(this.i0 + 8);
                    this.i5 = li32(this.i4 + 16);
                    this.i6 = li32(this.i5 + 68);
                    this.i5 = li32(this.i5 + 64);
                    this.i7 = (this.i0 + 12);
                    this.i1 = (this.i1 - this.i7);
                    if (uint(this.i6) < uint(this.i5)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i5 = 4;
                    this.i6 = li32(this.i4 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i6);
                    si32(this.i5, (this.i6 + 8));
                    this.i1 = li32(this.i4 + 8);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i4 + 8));
                    si32(this.i2, this.i3);
                    this.i1 = li32(this.i0 + 4);
                    this.i1 = (this.i1 + 1);
                    si32(this.i1, (this.i0 + 4));
                    this.i0 = 1;
                    goto _label_3;
                    
                _label_2: 
                    this.i0 = 0;
                    
                _label_3: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _emptybuffer");
            };
        }


    }
}

