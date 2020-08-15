package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_io_readline extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;
        public var i4:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_io_readline;
            _local_1 = new (FSM_io_readline)();
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
                    this.i0 = -10003;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 8);
                    if (!(this.i2 == 2))
                    {
                        if (!(this.i2 == 7))
                        {
                            this.i0 = 0;
                        }
                        else
                        {
                            this.i0 = li32(this.i0);
                            this.i0 = (this.i0 + 20);
                        };
                    }
                    else
                    {
                        this.i0 = li32(this.i0);
                    };
                    this.i0 = li32(this.i0);
                    if (!(this.i0 == 0)) goto _label_1;
                    this.i2 = __2E_str32335;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_read_line.start();
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li16(this.i0 + 12);
                    this.i0 = (this.i0 & 0x40);
                    if (this.i0 == 0) goto _label_2;
                    this.i2 = _ebuf_2E_1986;
                    this.i0 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 0x0800;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strerror_r.start();
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i2 == 0))
                    {
                        this.i2 = 22;
                        si32(this.i2, _val_2E_1440);
                    };
                    this.i2 = __2E_str54344;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = _ebuf_2E_1986;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_6;
                    
                _label_2: 
                    if (!(this.i2 == 0))
                    {
                        this.i1 = 1;
                        
                    _label_3: 
                        this.i0 = this.i1;
                        public::mstate.eax = this.i0;
                        goto _label_7;
                    };
                    this.i0 = -10004;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i0 + 8);
                    if (this.i2 == 0) goto _label_6;
                    if (!(!(this.i2 == 1)))
                    {
                        this.i0 = li32(this.i0);
                        if (!(!(this.i0 == 0)))
                        {
                            this.i1 = 0;
                            goto _label_3;
                        };
                    };
                    this.i0 = li32(this.i1 + 8);
                    this.i2 = li32(this.i1 + 12);
                    this.i3 = (this.i1 + 12);
                    this.i4 = (this.i1 + 8);
                    if (!(uint(this.i0) < uint(this.i2)))
                    {
                        this.i0 = this.i2;
                        goto _label_5;
                    };
                    
                _label_4: 
                    this.i2 = 0;
                    si32(this.i2, (this.i0 + 8));
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i4);
                    this.i2 = li32(this.i3);
                    if (uint(this.i0) < uint(this.i2)) goto _label_4;
                    this.i0 = this.i2;
                    
                _label_5: 
                    this.i2 = -10003;
                    si32(this.i0, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i4);
                    this.f0 = lf64(this.i0);
                    sf64(this.f0, this.i2);
                    this.i0 = li32(this.i0 + 8);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = li32(this.i4);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_aux_close.start();
                    return;
                case 8:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i1 = 0;
                    public::mstate.eax = this.i1;
                    
                _label_7: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _io_readline");
            };
        }


    }
}

