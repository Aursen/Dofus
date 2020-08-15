package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaH_setstr extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;


        public static function start():void
        {
            var _local_1:FSM_luaH_setstr;
            _local_1 = new (FSM_luaH_setstr)();
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
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i0 = 1;
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li8(this.i1 + 7);
                    this.i0 = (this.i0 << this.i2);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(this.i2 + 8);
                    this.i0 = (this.i0 + -1);
                    this.i0 = (this.i0 & this.i3);
                    this.i3 = li32(this.i1 + 16);
                    this.i0 = (this.i0 * 28);
                    this.i4 = li32(public::mstate.ebp + 8);
                    this.i0 = (this.i3 + this.i0);
                    do 
                    {
                        this.i3 = li32(this.i0 + 20);
                        if (!(!(this.i3 == 4)))
                        {
                            this.i3 = li32(this.i0 + 12);
                            if (!(!(this.i3 == this.i2))) goto _label_1;
                        };
                        this.i0 = li32(this.i0 + 24);
                    } while (!(this.i0 == 0));
                    this.i0 = _luaO_nilobject_;
                    
                _label_1: 
                    this.i3 = _luaO_nilobject_;
                    if (!(this.i0 == this.i3)) goto _label_2;
                    this.i0 = 4;
                    si32(this.i2, (public::mstate.ebp + -16));
                    si32(this.i0, (public::mstate.ebp + -8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (public::mstate.ebp + -16);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_newkey.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaH_setstr");
            };
        }


    }
}

