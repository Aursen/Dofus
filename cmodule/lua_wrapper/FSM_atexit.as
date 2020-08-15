package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_atexit extends Machine 
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
            var _local_1:FSM_atexit;
            _local_1 = new (FSM_atexit)();
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
                    this.i0 = li32(___atexit);
                    this.i1 = li32(public::mstate.ebp + 8);
                    if (this.i0 == 0) goto _label_4;
                    this.i2 = this.i0;
                    goto _label_3;
                    
                _label_1: 
                    this.i2 = 520;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 0;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i2 == 0) goto _label_6;
                    this.i3 = li32(___atexit);
                    if (this.i0 == this.i3) goto _label_2;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(___atexit);
                    this.i2 = li32(this.i0 + 4);
                    //unresolved if
                    goto _label_5;
                    
                _label_2: 
                    this.i0 = 0;
                    si32(this.i0, (this.i2 + 4));
                    si32(this.i3, this.i2);
                    si32(this.i2, ___atexit);
                    this.i0 = this.i2;
                    this.i2 = this.i0;
                    
                _label_3: 
                    this.i3 = li32(this.i0 + 4);
                    if ((this.i3 > 31))
                    {
                        this.i0 = this.i2;
                        goto _label_1;
                        
                    _label_4: 
                        this.i0 = ___atexit0_2E_3021;
                        si32(this.i0, ___atexit);
                    };
                    
                _label_5: 
                    this.i2 = 1;
                    this.i3 = li32(this.i0 + 4);
                    this.i4 = (this.i3 << 4);
                    this.i4 = (this.i0 + this.i4);
                    si32(this.i2, (this.i4 + 8));
                    si32(this.i1, (this.i4 + 12));
                    this.i1 = 0;
                    si32(this.i1, (this.i4 + 16));
                    si32(this.i1, (this.i4 + 20));
                    this.i1 = (this.i3 + 1);
                    si32(this.i1, (this.i0 + 4));
                    
                _label_6: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _atexit");
            };
        }


    }
}

