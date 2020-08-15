package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_yield extends Machine 
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
            var _local_1:FSM_luaB_yield;
            _local_1 = new (FSM_luaB_yield)();
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
                    this.i1 = li32(this.i0 + 8);
                    this.i2 = li32(this.i0 + 12);
                    this.i3 = li16(this.i0 + 52);
                    this.i4 = li16(this.i0 + 54);
                    this.i1 = (this.i1 - this.i2);
                    this.i2 = (this.i0 + 12);
                    this.i5 = (this.i0 + 8);
                    if (uint(this.i3) <= uint(this.i4)) goto _label_1;
                    this.i3 = __2E_str818;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i3 = 1;
                    this.i1 = (this.i1 / -12);
                    this.i4 = li32(this.i5);
                    this.i1 = (this.i1 * 12);
                    this.i1 = (this.i4 + this.i1);
                    si32(this.i1, this.i2);
                    si8(this.i3, (this.i0 + 6));
                    this.i0 = -1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaB_yield");
            };
        }


    }
}

