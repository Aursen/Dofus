package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaK_concat extends Machine 
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
            var _local_1:FSM_luaK_concat;
            _local_1 = new (FSM_luaK_concat)();
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
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    if (this.i2 == -1) goto _label_1;
                    this.i3 = li32(this.i1);
                    if (this.i3 == -1) goto _label_2;
                    this.i1 = li32(this.i0);
                    this.i4 = li32(this.i1 + 12);
                    do 
                    {
                        this.i5 = (this.i3 << 2);
                        this.i5 = (this.i4 + this.i5);
                        this.i5 = li32(this.i5);
                        this.i5 = (this.i5 >>> 14);
                        this.i5 = (this.i5 + -131071);
                        if (!(!(this.i5 == -1)))
                        {
                            this.i5 = -1;
                        }
                        else
                        {
                            this.i5 = (this.i3 + this.i5);
                            this.i5 = (this.i5 + 1);
                        };
                        if ((this.i5 == -1)) break;
                        this.i3 = this.i5;
                    } while (true);
                    this.i0 = li32(this.i0 + 12);
                    this.i1 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fixjump393394.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 16);
                    do 
                    {
                        
                    _label_1: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_2: 
                        si32(this.i2, this.i1);
                    } while (true);
                default:
                    throw ("Invalid state in _luaK_concat");
            };
        }


    }
} cmodule.lua_wrapper

