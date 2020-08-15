package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___swhatbuf extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;


        public static function start():void
        {
            var _local_1:FSM___swhatbuf;
            _local_1 = new (FSM___swhatbuf)();
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
                    public::mstate.esp = (public::mstate.esp - 0x1000);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i0 = li16(this.i0 + 14);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i1 = (this.i0 << 16);
                    this.i1 = (this.i1 >> 16);
                    if (this.i1 < 0) goto _label_1;
                    this.i1 = (this.i0 << 16);
                    this.i1 = (this.i1 >> 16);
                    if (this.i1 < 2) goto _label_2;
                    this.i0 = (this.i0 << 16);
                    this.i0 = (this.i0 >> 16);
                    state = 1;
                case 1:
                    this.i0 = public::mstate.system.fsize(this.i0);
                    if (this.i0 > -1) goto _label_2;
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = __2E_str251;
                    this.i4 = 59;
                    this.i5 = 2;
                    this.i6 = (public::mstate.ebp + -4096);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i4, (public::mstate.esp + 16));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i6;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i5, _val_2E_1440);
                    
                _label_1: 
                    this.i0 = 0;
                    si32(this.i0, this.i3);
                    this.i3 = 0x0400;
                    si32(this.i3, this.i2);
                    this.i2 = 0x0800;
                    public::mstate.eax = this.i2;
                    do 
                    {
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_2: 
                        this.i0 = 0;
                        si32(this.i0, this.i3);
                        this.i0 = 0x0400;
                        si32(this.i0, this.i2);
                        this.i0 = 0x0800;
                        public::mstate.eax = this.i0;
                    } while (true);
                default:
                    throw ("Invalid state in ___swhatbuf");
            };
        }


    }
}

