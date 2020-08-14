package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_asprintf extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;


        public static function start():void
        {
            var _local_1:FSM_asprintf;
            _local_1 = new (FSM_asprintf)();
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
                    public::mstate.esp = (public::mstate.esp - 260);
                    this.i0 = -1;
                    si16(this.i0, (public::mstate.ebp + -242));
                    this.i0 = 16904;
                    si16(this.i0, (public::mstate.ebp + -244));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 128;
                    this.i1 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, (public::mstate.ebp + -256));
                    this.i1 = (public::mstate.ebp + -256);
                    si32(this.i0, (public::mstate.ebp + -240));
                    this.i2 = (this.i1 + 16);
                    this.i3 = li32(public::mstate.ebp + 8);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i1 = 0;
                        
                    _label_1: 
                        si32(this.i1, this.i3);
                        this.i1 = 12;
                        si32(this.i1, _val_2E_1440);
                        
                    _label_2: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i0 = 127;
                    si32(this.i0, (public::mstate.ebp + -248));
                    this.i4 = (public::mstate.ebp + -160);
                    si32(this.i0, (public::mstate.ebp + -236));
                    si32(this.i4, (public::mstate.ebp + -200));
                    this.i0 = 0;
                    si32(this.i0, (public::mstate.ebp + -160));
                    si32(this.i0, (public::mstate.ebp + -156));
                    si32(this.i0, (public::mstate.ebp + -152));
                    si32(this.i0, (public::mstate.ebp + -148));
                    si32(this.i0, (public::mstate.ebp + -144));
                    this.i4 = (this.i4 + 20);
                    this.i5 = 128;
                    memset(this.i4, this.i0, this.i5);
                    this.i0 = (public::mstate.ebp + 12);
                    si32(this.i0, (public::mstate.ebp + -260));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = __2E_str412;
                    this.i5 = (public::mstate.ebp + -256);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___vfprintf.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i0 > -1) goto _label_3;
                    this.i1 = 0;
                    this.i2 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_1;
                    
                _label_3: 
                    this.i0 = 0;
                    this.i1 = li32(this.i1);
                    si8(this.i0, this.i1);
                    this.i0 = li32(this.i2);
                    si32(this.i0, this.i3);
                    goto _label_2;
                default:
                    throw ("Invalid state in _asprintf");
            };
        }


    }
} cmodule.lua_wrapper

