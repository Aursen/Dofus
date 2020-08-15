package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaK_setreturns extends Machine 
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
            var _local_1:FSM_luaK_setreturns;
            _local_1 = new (FSM_luaK_setreturns)();
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
                    this.i1 = li32(this.i0);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = li32(public::mstate.ebp + 16);
                    if (!(this.i1 == 14))
                    {
                        if (!(this.i1 == 13)) goto _label_1;
                        this.i0 = li32(this.i0 + 4);
                        this.i2 = li32(this.i2);
                        this.i2 = li32(this.i2 + 12);
                        this.i0 = (this.i0 << 2);
                        this.i3 = (this.i3 << 14);
                        this.i0 = (this.i2 + this.i0);
                        this.i2 = li32(this.i0);
                        this.i3 = (this.i3 + 0x4000);
                        this.i3 = (this.i3 & 0x7FC000);
                        this.i2 = (this.i2 & 0xFF803FFF);
                        this.i2 = (this.i2 | this.i3);
                        si32(this.i2, this.i0);
                        goto _label_1;
                    };
                    this.i1 = 1;
                    this.i4 = li32(this.i0 + 4);
                    this.i5 = li32(this.i2);
                    this.i5 = li32(this.i5 + 12);
                    this.i4 = (this.i4 << 2);
                    this.i4 = (this.i5 + this.i4);
                    this.i5 = li32(this.i4);
                    this.i3 = (this.i3 << 23);
                    this.i3 = (this.i3 + 0x800000);
                    this.i5 = (this.i5 & 0x7FFFFF);
                    this.i3 = (this.i5 | this.i3);
                    si32(this.i3, this.i4);
                    this.i3 = li32(this.i2);
                    this.i0 = li32(this.i0 + 4);
                    this.i3 = li32(this.i3 + 12);
                    this.i0 = (this.i0 << 2);
                    this.i4 = li32(this.i2 + 36);
                    this.i0 = (this.i3 + this.i0);
                    this.i3 = li32(this.i0);
                    this.i4 = (this.i4 << 6);
                    this.i4 = (this.i4 & 0x3FC0);
                    this.i3 = (this.i3 & 0xFFFFC03F);
                    this.i3 = (this.i4 | this.i3);
                    si32(this.i3, this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_checkstack.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i2 + 36);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, (this.i2 + 36));
                    
                _label_1: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaK_setreturns");
            };
        }


    }
}

