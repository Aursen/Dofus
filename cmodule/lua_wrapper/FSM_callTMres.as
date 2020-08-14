package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_callTMres extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_callTMres;
            _local_1 = new (FSM_callTMres)();
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
                    this.i1 = li32(public::mstate.ebp + 16);
                    this.i2 = li32(this.i0 + 32);
                    this.i3 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i3);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i3 + 8));
                    this.i1 = li32(public::mstate.ebp + 20);
                    this.i3 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, (this.i3 + 12));
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i3 + 20));
                    this.i1 = li32(public::mstate.ebp + 24);
                    this.i3 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, (this.i3 + 24));
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i3 + 32));
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(this.i0 + 28);
                    this.i4 = li32(this.i0 + 8);
                    this.i5 = (this.i0 + 8);
                    this.i1 = (this.i1 - this.i2);
                    this.i2 = (this.i0 + 32);
                    this.i3 = (this.i3 - this.i4);
                    if (this.i3 > 36) goto _label_2;
                    this.i3 = li32(this.i0 + 44);
                    if (this.i3 < 3) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_2;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = (this.i3 + 3);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i3 = 1;
                    this.i4 = li32(this.i5);
                    this.i6 = (this.i4 + 36);
                    si32(this.i6, this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i5);
                    this.i2 = li32(this.i2);
                    this.i3 = (this.i0 + -12);
                    si32(this.i3, this.i5);
                    this.f0 = lf64(this.i0 + -12);
                    this.i1 = (this.i2 + this.i1);
                    sf64(this.f0, this.i1);
                    this.i0 = li32(this.i0 + -4);
                    si32(this.i0, (this.i1 + 8));
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _callTMres");
            };
        }


    }
} cmodule.lua_wrapper

