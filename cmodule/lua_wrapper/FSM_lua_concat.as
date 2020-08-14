package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_lua_concat extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_lua_concat;
            _local_1 = new (FSM_lua_concat)();
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
                    //unresolved if
                    this.i2 = li32(this.i0 + 16);
                    this.i3 = li32(this.i2 + 68);
                    this.i2 = li32(this.i2 + 64);
                    if (uint(this.i3) < uint(this.i2)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = li32(this.i0 + 12);
                    this.i2 = (this.i2 - this.i3);
                    this.i2 = (this.i2 / 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_concat.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = (1 - this.i1);
                    this.i2 = li32(this.i0 + 8);
                    this.i1 = (this.i1 * 12);
                    this.i1 = (this.i2 + this.i1);
                    
                _label_2: 
                    si32(this.i1, (this.i0 + 8));
                    do 
                    {
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    } while ((!(this.i1 == 0)));
                    this.i1 = __2E_str45;
                    this.i2 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i2);
                    this.i1 = 4;
                    si32(this.i1, (this.i2 + 8));
                    this.i1 = li32(this.i0 + 8);
                    this.i1 = (this.i1 + 12);
                    goto _label_2;
                default:
                    throw ("Invalid state in _lua_concat");
            };
        }


    }
} cmodule.lua_wrapper

