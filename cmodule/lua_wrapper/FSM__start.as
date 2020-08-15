package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM__start extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM__start;
            _local_1 = new (FSM__start)();
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
                    this.i2 = li32(this.i0);
                    this.i1 = (this.i2 << 2);
                    this.i1 = (this.i1 + this.i0);
                    this.i1 = (this.i1 + 8);
                    si32(this.i1, _environ);
                    if (!(this.i2 < 1))
                    {
                        this.i0 = li32(this.i0 + 4);
                        this.i1 = this.i0;
                        if (!(this.i0 == 0))
                        {
                            si32(this.i1, ___progname);
                            this.i3 = li8(this.i1);
                            if (!(this.i3 == 0))
                            {
                                do 
                                {
                                    this.i3 = li8(this.i0);
                                    if ((this.i3 == 47))
                                    {
                                        this.i1 = (this.i0 + 1);
                                    };
                                    this.i3 = li8(this.i0 + 1);
                                    this.i0 = (this.i0 + 1);
                                } while (!(this.i3 == 0));
                                si32(this.i1, ___progname);
                            };
                        };
                    };
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_atexit.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = __fini;
                    si32(this.i0, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_atexit.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = __2E_str1;
                    this.i1 = 4;
                    this.i3 = __UTF8_mbrtowc;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i3, ___mbrtowc);
                    this.i0 = __UTF8_wcrtomb;
                    si32(this.i0, ___wcrtomb);
                    this.i0 = __UTF8_mbsinit;
                    si32(this.i0, ___mbsinit);
                    this.i0 = __UTF8_mbsnrtowcs;
                    si32(this.i0, ___mbsnrtowcs);
                    this.i0 = __UTF8_wcsnrtombs;
                    si32(this.i0, ___wcsnrtombs);
                    this.i0 = __DefaultRuneLocale;
                    si32(this.i0, __CurrentRuneLocale);
                    this.i0 = 6;
                    si32(this.i0, ___mb_cur_max);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_main385.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                default:
                    throw ("Invalid state in __start");
            };
        }


    }
}

