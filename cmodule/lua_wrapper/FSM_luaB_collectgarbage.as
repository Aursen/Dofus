package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_collectgarbage extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 2;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;
        public var f1:Number;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_luaB_collectgarbage;
            _local_1 = new (FSM_luaB_collectgarbage)();
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
                    this.i0 = __2E_str45245;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = _opts_2E_2859;
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkoption.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(!(this.i2 == this.i3)))
                    {
                        
                    _label_1: 
                        this.i2 = 0;
                        goto _label_2;
                    };
                    this.i2 = li32(this.i2 + 8);
                    if (this.i2 < 1) goto _label_1;
                    this.i2 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i3 = _optsnum_2E_2860;
                    this.i0 = (this.i0 << 2);
                    this.i0 = (this.i3 + this.i0);
                    this.i0 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_gc.start();
                    return;
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i0 == 5) goto _label_3;
                    if (!(this.i0 == 3)) goto _label_5;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 4;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_gc.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    this.f0 = Number(this.i0);
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.f0 = (this.f0 * 0.000976562);
                    this.f1 = Number(this.i2);
                    this.i2 = li32(this.i1 + 8);
                    this.f0 = (this.f1 + this.f0);
                    sf64(this.f0, this.i2);
                    this.i0 = 3;
                    si32(this.i0, (this.i2 + 8));
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    this.i1 = 1;
                    public::mstate.eax = this.i1;
                    goto _label_4;
                    
                _label_3: 
                    this.i0 = 1;
                    this.i2 = ((this.i2 != 0) ? 1 : 0);
                    this.i3 = li32(this.i1 + 8);
                    this.i2 = (this.i2 & 0x01);
                    si32(this.i2, this.i3);
                    si32(this.i0, (this.i3 + 8));
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    do 
                    {
                        public::mstate.eax = this.i0;
                        
                    _label_4: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_5: 
                        this.i0 = 3;
                        this.i3 = li32(this.i1 + 8);
                        this.f0 = Number(this.i2);
                        sf64(this.f0, this.i3);
                        si32(this.i0, (this.i3 + 8));
                        this.i0 = li32(this.i1 + 8);
                        this.i0 = (this.i0 + 12);
                        si32(this.i0, (this.i1 + 8));
                        this.i0 = 1;
                    } while (true);
                default:
                    throw ("Invalid state in _luaB_collectgarbage");
            };
        }


    }
}

