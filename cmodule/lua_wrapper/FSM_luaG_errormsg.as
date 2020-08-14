package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaG_errormsg extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;
        public var i4:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_luaG_errormsg;
            _local_1 = new (FSM_luaG_errormsg)();
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
                    this.i1 = li32(this.i0 + 108);
                    if (this.i1 == 0) goto _label_4;
                    this.i2 = li32(this.i0 + 32);
                    this.i1 = (this.i2 + this.i1);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = (this.i1 + 8);
                    if (this.i2 == 6) goto _label_1;
                    this.i2 = 5;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i2 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i2 + -12);
                    sf64(this.f0, this.i2);
                    this.i4 = li32(this.i2 + -4);
                    si32(this.i4, (this.i2 + 8));
                    this.i2 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, (this.i2 + -12));
                    this.i1 = li32(this.i3);
                    si32(this.i1, (this.i2 + -4));
                    this.i1 = li32(this.i0 + 28);
                    this.i2 = li32(this.i0 + 8);
                    this.i3 = (this.i0 + 8);
                    this.i1 = (this.i1 - this.i2);
                    if (this.i1 > 12) goto _label_3;
                    this.i1 = li32(this.i0 + 44);
                    if (this.i1 < 1) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_3;
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 + 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i1 = 1;
                    this.i2 = li32(this.i3);
                    this.i4 = (this.i2 + 12);
                    si32(this.i4, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 2;
                    goto _label_5;
                    
                _label_4: 
                    this.i1 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    
                _label_5: 
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaG_errormsg");
            };
        }


    }
} cmodule.lua_wrapper

