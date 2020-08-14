package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_getF extends Machine 
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
            var _local_1:FSM_getF;
            _local_1 = new (FSM_getF)();
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
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = this.i0;
                    if (!(this.i1 == 0))
                    {
                        this.i3 = 0;
                        si32(this.i3, this.i0);
                        this.i3 = 1;
                        si32(this.i3, this.i2);
                        this.i2 = __2E_str10143;
                        public::mstate.eax = this.i2;
                        goto _label_3;
                    };
                    this.i0 = li32(this.i3 + 4);
                    this.i1 = li16(this.i0 + 12);
                    this.i1 = (this.i1 & 0x20);
                    if (!(this.i1 == 0)) goto _label_1;
                    this.i1 = 0x0400;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = 1;
                    this.i3 = (this.i3 + 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fread.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i0, this.i2);
                    this.i0 = ((this.i0 == 0) ? 0 : this.i3);
                    goto _label_2;
                    
                _label_1: 
                    this.i0 = 0;
                    
                _label_2: 
                    public::mstate.eax = this.i0;
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _getF");
            };
        }


    }
} cmodule.lua_wrapper

