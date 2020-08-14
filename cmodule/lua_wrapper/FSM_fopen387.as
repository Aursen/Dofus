package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_fopen387 extends Machine 
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
            var _local_1:FSM_fopen387;
            _local_1 = new (FSM_fopen387)();
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
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = sxi8(li8(public::mstate.ebp + 12));
                    this.i2 = sxi8(li8(public::mstate.ebp + 16));
                    this.i3 = sxi8(li8(public::mstate.ebp + 20));
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflags386.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(public::mstate.ebp + 8);
                    if (!(!(this.i0 == 0)))
                    {
                        
                    _label_1: 
                        this.i0 = 0;
                        goto _label_2;
                    };
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sfp.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    if (this.i2 == 0) goto _label_1;
                    this.i3 = 438;
                    this.i4 = li32(public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_open.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i1 > -1))
                    {
                        this.i0 = 0;
                        si16(this.i0, (this.i2 + 12));
                    }
                    else
                    {
                        this.i3 = ___sread;
                        si16(this.i1, (this.i2 + 14));
                        si16(this.i0, (this.i2 + 12));
                        si32(this.i2, (this.i2 + 28));
                        si32(this.i3, (this.i2 + 36));
                        this.i0 = ___swrite;
                        si32(this.i0, (this.i2 + 44));
                        this.i0 = ___sseek;
                        si32(this.i0, (this.i2 + 40));
                        this.i0 = ___sclose;
                        si32(this.i0, (this.i2 + 32));
                        this.i0 = li32(public::mstate.ebp + -4);
                        this.i0 = (this.i0 & 0x08);
                        if (!(this.i0 == 0)) goto _label_4;
                        this.i0 = this.i2;
                    };
                    
                _label_2: 
                    public::mstate.eax = this.i0;
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_4: 
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = 2;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM__sseek.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    this.i0 = public::mstate.edx;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.eax = this.i2;
                    goto _label_3;
                default:
                    throw ("Invalid state in _fopen387");
            };
        }


    }
} cmodule.lua_wrapper

