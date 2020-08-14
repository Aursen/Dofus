package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_classend extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_classend;
            _local_1 = new (FSM_classend)();
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
                    this.i1 = sxi8(li8(this.i0));
                    this.i2 = (this.i0 + 1);
                    this.i3 = li32(public::mstate.ebp + 8);
                    if (!(this.i1 == 37))
                    {
                        if (this.i1 == 91) goto _label_1;
                        this.i0 = this.i2;
                        goto _label_6;
                    };
                    this.i2 = li8(this.i2);
                    this.i0 = (this.i0 + 2);
                    if (!(this.i2 == 0)) goto _label_6;
                    this.i2 = __2E_str19449;
                    this.i3 = li32(this.i3 + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_6;
                    
                _label_1: 
                    this.i1 = li8(this.i2);
                    if (!(this.i1 == 94))
                    {
                        this.i0 = this.i2;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 2);
                    };
                    this.i1 = (this.i3 + 8);
                    
                _label_2: 
                    this.i2 = li8(this.i0);
                    if (!(this.i2 == 0)) goto _label_3;
                    this.i2 = __2E_str20450;
                    this.i3 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i2 = li8(this.i0);
                    this.i3 = (this.i0 + 1);
                    if (!(this.i2 == 37))
                    {
                        
                    _label_4: 
                        this.i0 = this.i3;
                        goto _label_5;
                    };
                    this.i2 = li8(this.i3);
                    if (this.i2 == 0) goto _label_4;
                    this.i0 = (this.i0 + 2);
                    
                _label_5: 
                    this.i2 = li8(this.i0);
                    if (!(this.i2 == 93)) goto _label_2;
                    this.i0 = (this.i0 + 1);
                    
                _label_6: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _classend");
            };
        }


    }
} cmodule.lua_wrapper

