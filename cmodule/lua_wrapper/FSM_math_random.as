package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_math_random extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 2;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var f0:Number;
        public var f1:Number;


        public static function start():void
        {
            var _local_1:FSM_math_random;
            _local_1 = new (FSM_math_random)();
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
                    this.i0 = li32(_next);
                    this.i1 = li32(public::mstate.ebp + 8);
                    if ((this.i0 == 0))
                    {
                        this.i0 = 123459876;
                        si32(this.i0, _next);
                    };
                    this.i2 = (uint(this.i0) / uint(127773));
                    this.i3 = (this.i2 * 127773);
                    this.i0 = (this.i0 - this.i3);
                    this.i2 = (this.i2 * 2836);
                    this.i0 = (this.i0 * 16807);
                    this.i0 = (this.i0 - this.i2);
                    this.i2 = (this.i0 + 2147483647);
                    this.i0 = ((this.i0 > -1) ? this.i0 : this.i2);
                    this.i2 = (this.i0 & 0x7FFFFFFF);
                    this.i3 = (uint(this.i2) / uint(2147483647));
                    this.i3 = (this.i3 * 2147483647);
                    si32(this.i0, _next);
                    this.i0 = (this.i2 - this.i3);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    this.i3 = (this.i2 - this.i3);
                    this.f0 = Number(this.i0);
                    this.i0 = (this.i3 / 12);
                    this.i3 = (this.i1 + 8);
                    this.f0 = (this.f0 / 2147480000);
                    if (this.i0 == 2) goto _label_5;
                    if (!(this.i0 == 1))
                    {
                        if (!(this.i0 == 0)) goto _label_7;
                        this.i1 = 3;
                        sf64(this.f0, this.i2);
                        si32(this.i1, (this.i2 + 8));
                        goto _label_3;
                    };
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    this.f1 = Number(this.i0);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.f0 = (this.f1 * this.f0);
                    if (this.i0 > 0) goto _label_1;
                    this.i0 = __2E_str28376;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.f0 = Math.floor(this.f0);
                    this.i1 = li32(this.i3);
                    this.f0 = (this.f0 + 1);
                    sf64(this.f0, this.i1);
                    this.i0 = 3;
                    si32(this.i0, (this.i1 + 8));
                    this.i1 = li32(this.i3);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i3);
                    public::mstate.eax = this.i2;
                    goto _label_4;
                    
                _label_1: 
                    this.i1 = 3;
                    this.f0 = Math.floor(this.f0);
                    this.i0 = li32(this.i3);
                    this.f0 = (this.f0 + 1);
                    
                _label_2: 
                    sf64(this.f0, this.i0);
                    si32(this.i1, (this.i0 + 8));
                    
                _label_3: 
                    this.i1 = li32(this.i3);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i3);
                    this.i1 = 1;
                    public::mstate.eax = this.i1;
                    
                _label_4: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_5: 
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 <= this.i2) goto _label_6;
                    this.i4 = __2E_str28376;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_6: 
                    this.i1 = 3;
                    this.i4 = (1 - this.i0);
                    this.i2 = (this.i4 + this.i2);
                    this.f1 = Number(this.i2);
                    this.f0 = (this.f1 * this.f0);
                    this.f0 = Math.floor(this.f0);
                    this.f1 = Number(this.i0);
                    this.i0 = li32(this.i3);
                    this.f0 = (this.f0 + this.f1);
                    goto _label_2;
                    
                _label_7: 
                    this.i0 = __2E_str29377;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    goto _label_4;
                default:
                    throw ("Invalid state in _math_random");
            };
        }


    }
} cmodule.lua_wrapper

