package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaK_exp2val extends Machine 
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
            var _local_1:FSM_luaK_exp2val;
            _local_1 = new (FSM_luaK_exp2val)();
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
                    this.i1 = li32(this.i0 + 12);
                    this.i2 = li32(this.i0 + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = li32(public::mstate.ebp + 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = (this.i0 + 16);
                    this.i5 = (this.i0 + 12);
                    //unresolved if
                    this.i1 = li32(this.i0);
                    if (!(this.i1 == 12)) goto _label_1;
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i4);
                    this.i4 = li32(this.i0 + 4);
                    if (this.i1 == this.i2) goto _label_2;
                    this.i1 = li8(this.i3 + 50);
                    if (this.i4 < this.i1) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exp2reg.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_2;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    do 
                    {
                        
                    _label_2: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    } while (true);
                default:
                    throw ("Invalid state in _luaK_exp2val");
            };
        }


    }
}

