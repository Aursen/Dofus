package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaG_typeerror extends Machine 
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
            var _local_1:FSM_luaG_typeerror;
            _local_1 = new (FSM_luaG_typeerror)();
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
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 12);
                    si32(this.i0, (public::mstate.ebp + -4));
                    this.i0 = li32(this.i1 + 8);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = _luaT_typenames;
                    this.i0 = (this.i0 << 2);
                    this.i4 = li32(this.i2 + 20);
                    this.i0 = (this.i3 + this.i0);
                    this.i0 = li32(this.i0);
                    this.i3 = li32(this.i4);
                    this.i5 = li32(this.i4 + 8);
                    this.i6 = li32(public::mstate.ebp + 16);
                    if (!(uint(this.i5) > uint(this.i3)))
                    {
                        
                    _label_1: 
                        this.i1 = 0;
                        goto _label_2;
                    };
                    while (!(this.i3 == this.i1))
                    {
                        this.i3 = (this.i3 + 12);
                        if (uint(this.i5) <= uint(this.i3)) goto _label_1;
                    };
                    this.i3 = (public::mstate.ebp + -4);
                    this.i5 = li32(this.i2 + 12);
                    this.i1 = (this.i1 - this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = (this.i1 / 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getobjname.start();
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_2: 
                    if (this.i1 == 0) goto _label_3;
                    this.i3 = __2E_str18275;
                    this.i4 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 24);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i4, (public::mstate.esp + 16));
                    si32(this.i0, (public::mstate.esp + 20));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 24);
                    goto _label_4;
                    
                _label_3: 
                    this.i1 = __2E_str19276;
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_4: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaG_typeerror");
            };
        }


    }
}

