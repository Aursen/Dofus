package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_math_tanh extends Machine 
    {

        public static const intRegCount:int = 4;
        public static const NumberRegCount:int = 5;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;
        public var f1:Number;
        public var f2:Number;
        public var f3:Number;
        public var i3:int;
        public var f4:Number;


        public static function start():void
        {
            var _local_1:FSM_math_tanh;
            _local_1 = new (FSM_math_tanh)();
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
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checknumber.start();
                    return;
                case 1:
                    this.f1 = public::mstate.st0;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f2 = -(this.f1);
                    this.f0 = this.f1;
                    this.f0 = Math.exp(this.f0);
                    this.f3 = this.f0;
                    this.f0 = this.f2;
                    this.f0 = Math.exp(this.f0);
                    this.f4 = this.f0;
                    this.f0 = this.f1;
                    this.f0 = Math.exp(this.f0);
                    this.f1 = this.f0;
                    this.f0 = this.f2;
                    this.f0 = Math.exp(this.f0);
                    this.f0 = (this.f1 + this.f0);
                    this.f1 = (this.f3 - this.f4);
                    this.f0 = (this.f0 * 0.5);
                    this.f1 = (this.f1 * 0.5);
                    this.i2 = li32(this.i1 + 8);
                    this.f0 = (this.f1 / this.f0);
                    sf64(this.f0, this.i2);
                    this.i3 = 3;
                    si32(this.i3, (this.i2 + 8));
                    this.i2 = li32(this.i1 + 8);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, (this.i1 + 8));
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _math_tanh");
            };
        }


    }
} cmodule.lua_wrapper

