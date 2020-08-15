package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___messages_load_locale extends Machine 
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
            var _local_1:FSM___messages_load_locale;
            _local_1 = new (FSM___messages_load_locale)();
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
                    this.i0 = __messages_using_locale;
                    public::mstate.esp = (public::mstate.esp - 28);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = __messages_locale_buf;
                    this.i3 = __2E_str417;
                    this.i4 = __messages_locale;
                    this.i5 = 2;
                    this.i6 = 4;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i6, (public::mstate.esp + 16));
                    si32(this.i5, (public::mstate.esp + 20));
                    si32(this.i4, (public::mstate.esp + 24));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___part_load_locale.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 28);
                    if (!(!(this.i0 == 0)))
                    {
                        this.i1 = li32(__messages_locale + 8);
                        if (!(!(this.i1 == 0)))
                        {
                            this.i1 = _empty;
                            si32(this.i1, (__messages_locale + 8));
                        };
                        this.i1 = li32(__messages_locale + 12);
                        if (!(!(this.i1 == 0)))
                        {
                            this.i1 = _empty;
                            si32(this.i1, (__messages_locale + 12));
                        };
                    };
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___messages_load_locale");
            };
        }


    }
}

