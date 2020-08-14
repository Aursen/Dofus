package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_callallgcTM392 extends Machine 
    {

        public static const intRegCount:int = 3;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;


        public static function start():void
        {
            var _local_1:FSM_callallgcTM392;
            _local_1 = new (FSM_callallgcTM392)();
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
                    this.i1 = li32(this.i0 + 16);
                    this.i1 = li32(this.i1 + 48);
                    this.i2 = (this.i0 + 16);
                    if (this.i1 == 0) goto _label_2;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_GCTM.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = li32(this.i2);
                    this.i1 = li32(this.i1 + 48);
                    if (!(this.i1 == 0)) goto _label_1;
                    
                _label_2: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _callallgcTM392");
            };
        }


    }
} cmodule.lua_wrapper

