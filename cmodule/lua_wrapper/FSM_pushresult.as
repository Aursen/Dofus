package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_pushresult extends Machine 
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
            var _local_1:FSM_pushresult;
            _local_1 = new (FSM_pushresult)();
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
                    this.i1 = li32(_val_2E_1440);
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = (this.i0 + 8);
                    this.i4 = li32(public::mstate.ebp + 16);
                    this.i5 = li32(public::mstate.ebp + 12);
                    if (!(this.i5 == 0))
                    {
                        this.i0 = 1;
                        si32(this.i0, this.i2);
                        si32(this.i0, (this.i2 + 8));
                        this.i1 = li32(this.i3);
                        this.i1 = (this.i1 + 12);
                        si32(this.i1, this.i3);
                        public::mstate.eax = this.i0;
                        
                    _label_1: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i5 = 0;
                    si32(this.i5, (this.i2 + 8));
                    this.i2 = li32(this.i3);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = _ebuf_2E_1986;
                    this.i5 = 0x0800;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strerror_r.start();
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i2 == 0))
                    {
                        this.i2 = 22;
                        si32(this.i2, _val_2E_1440);
                    };
                    if (this.i4 == 0) goto _label_2;
                    this.i2 = __2E_str15318;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = _ebuf_2E_1986;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    goto _label_3;
                    
                _label_2: 
                    this.i2 = __2E_str54344;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = _ebuf_2E_1986;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_pushfstring.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i0 = li32(this.i3);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, this.i0);
                    this.i1 = 3;
                    si32(this.i1, (this.i0 + 8));
                    this.i0 = li32(this.i3);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i3);
                    public::mstate.eax = this.i1;
                    goto _label_1;
                default:
                    throw ("Invalid state in _pushresult");
            };
        }


    }
} cmodule.lua_wrapper

