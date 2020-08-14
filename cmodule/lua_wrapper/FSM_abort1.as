package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_abort1 extends Machine 
    {

        public static const intRegCount:int = 12;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_abort1;
            _local_1 = new (FSM_abort1)();
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
                    public::mstate.esp = (public::mstate.esp - 0x5000);
                    this.i0 = li8(___cleanup_2E_b);
                    this.i0 = (this.i0 ^ 0x01);
                    this.i0 = (this.i0 & 0x01);
                    if (!(!(this.i0 == 0)))
                    {
                        state = 1;
                        public::mstate.esp = (public::mstate.esp - 4);
                        FSM__cleanup.start();
                        return;
                    };
                case 1:
                    this.i2 = __2E_str340;
                    this.i3 = 4;
                    this.i0 = this.i2;
                    this.i1 = this.i3;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i4 = __2E_str96;
                    this.i5 = __2E_str138;
                    this.i6 = 34;
                    this.i7 = 78;
                    this.i0 = (public::mstate.ebp + -20480);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i6, (public::mstate.esp + 16));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i8 = 3;
                    this.i1 = this.i8;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i7, _val_2E_1440);
                    this.i9 = __2E_str977;
                    this.i10 = __2E_str37;
                    this.i0 = this.i9;
                    this.i1 = this.i3;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i10;
                    this.i1 = this.i3;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i11 = 50;
                    this.i0 = (public::mstate.ebp + -16384);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i11, (public::mstate.esp + 16));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = this.i8;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i7, _val_2E_1440);
                    this.i0 = __2E_str643;
                    this.i1 = this.i3;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = 10;
                    this.i1 = (public::mstate.ebp + -12288);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i0, (public::mstate.esp + 16));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i0 = this.i1;
                    this.i1 = this.i8;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i7, _val_2E_1440);
                    this.i0 = this.i2;
                    this.i1 = this.i3;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = (public::mstate.ebp + -8192);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i6, (public::mstate.esp + 16));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = this.i8;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i7, _val_2E_1440);
                    this.i0 = this.i9;
                    this.i1 = this.i3;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    this.i0 = this.i10;
                    this.i1 = this.i3;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i0 = (public::mstate.ebp + -4096);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i5, (public::mstate.esp + 12));
                    si32(this.i11, (public::mstate.esp + 16));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = this.i8;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i7, _val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = 1;
                    si32(this.i0, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 4);
                default:
                    throw ("Invalid state in _abort1");
            };
        }


    }
} cmodule.lua_wrapper

