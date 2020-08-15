package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_addvalue extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_luaL_addvalue;
            _local_1 = new (FSM_luaL_addvalue)();
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
                    this.i0 = (public::mstate.ebp + -4);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = -1;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i1);
                    this.i4 = li32(public::mstate.ebp + -4);
                    this.i5 = (this.i1 + 1036);
                    this.i6 = this.i1;
                    this.i5 = (this.i5 - this.i3);
                    if (!(uint(this.i5) < uint(this.i4)))
                    {
                        this.i1 = this.i3;
                        this.i3 = this.i4;
                        memcpy(this.i1, this.i0, this.i3);
                        this.i1 = li32(this.i6);
                        this.i0 = li32(public::mstate.ebp + -4);
                        this.i1 = (this.i1 + this.i0);
                        si32(this.i1, this.i6);
                        this.i1 = li32(this.i2 + 8);
                        this.i1 = (this.i1 + -12);
                        si32(this.i1, (this.i2 + 8));
                        
                    _label_1: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i0 == 0) goto _label_2;
                    this.i0 = -2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i2 + 8);
                    this.i2 = (this.i2 + 8);
                    this.i4 = this.i3;
                    if (!(uint(this.i3) <= uint(this.i0)))
                    {
                        this.i5 = 0;
                        do 
                        {
                            this.i6 = (this.i5 ^ 0xFFFFFFFF);
                            this.i6 = (this.i6 * 12);
                            this.i6 = (this.i4 + this.i6);
                            this.f0 = lf64(this.i6);
                            sf64(this.f0, this.i3);
                            this.i7 = li32(this.i6 + 8);
                            si32(this.i7, (this.i3 + 8));
                            this.i3 = (this.i3 + -12);
                            this.i5 = (this.i5 + 1);
                        } while (!(uint(this.i6) <= uint(this.i0)));
                    };
                    this.i2 = li32(this.i2);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, this.i0);
                    this.i2 = li32(this.i2 + 8);
                    si32(this.i2, (this.i0 + 8));
                    
                _label_2: 
                    this.i0 = li32(this.i1 + 4);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, (this.i1 + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    goto _label_1;
                default:
                    throw ("Invalid state in _luaL_addvalue");
            };
        }


    }
}

