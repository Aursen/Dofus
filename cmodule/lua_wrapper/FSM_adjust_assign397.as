package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_adjust_assign397 extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;


        public static function start():void
        {
            var _local_1:FSM_adjust_assign397;
            _local_1 = new (FSM_adjust_assign397)();
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
                    this.i0 = li32(public::mstate.ebp + 20);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = li32(this.i0);
                    this.i1 = (this.i1 - this.i2);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i4 = (this.i3 + -13);
                    if (uint(this.i4) > uint(1)) goto _label_1;
                    this.i1 = (this.i1 + 1);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = ((this.i1 < 0) ? 0 : this.i1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_setreturns.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i1 < 2) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i1 + -1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_checkstack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i2 + 36);
                    this.i0 = (this.i1 + this.i0);
                    si32(this.i0, (this.i2 + 36));
                    goto _label_3;
                    
                _label_1: 
                    if (this.i3 == 0) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    if (this.i1 < 1) goto _label_3;
                    this.i0 = li32(this.i2 + 36);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_checkstack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li32(this.i2 + 36);
                    this.i3 = (this.i3 + this.i1);
                    si32(this.i3, (this.i2 + 36));
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_nil.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _adjust_assign397");
            };
        }


    }
} cmodule.lua_wrapper

