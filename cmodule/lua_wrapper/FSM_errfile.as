package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_errfile extends Machine 
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
            var _local_1:FSM_errfile;
            _local_1 = new (FSM_errfile)();
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
                    this.i0 = _ebuf_2E_1986;
                    this.i1 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 0x0800;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strerror_r.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = 22;
                        si32(this.i0, _val_2E_1440);
                    };
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i4 = __2E_str16191334;
                    this.i5 = _ebuf_2E_1986;
                    this.i0 = (this.i0 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    si32(this.i5, (public::mstate.esp + 16));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i1 = (this.i1 + 8);
                    this.i3 = this.i0;
                    this.i4 = (this.i0 + 12);
                    if (!(uint(this.i4) < uint(this.i2)))
                    {
                        this.i0 = this.i2;
                    }
                    else
                    {
                        this.i0 = (this.i0 + 12);
                        this.i2 = this.i3;
                        
                    _label_1: 
                        this.f0 = lf64(this.i2 + 12);
                        sf64(this.f0, this.i2);
                        this.i3 = li32(this.i2 + 20);
                        si32(this.i3, (this.i2 + 8));
                        this.i2 = li32(this.i1);
                        this.i3 = (this.i0 + 12);
                        this.i4 = this.i0;
                        if (uint(this.i3) < uint(this.i2)) goto _label_2;
                        this.i0 = this.i2;
                    };
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i1);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_2: 
                    this.i0 = this.i3;
                    this.i2 = this.i4;
                    goto _label_1;
                default:
                    throw ("Invalid state in _errfile");
            };
        }


    }
}

