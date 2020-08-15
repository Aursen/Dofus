package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_push_onecapture extends Machine 
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
            var _local_1:FSM_push_onecapture;
            _local_1 = new (FSM_push_onecapture)();
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
                    this.i3 = li32(public::mstate.ebp + 20);
                    this.i4 = li32(this.i0 + 12);
                    if (this.i4 > this.i1) goto _label_5;
                    if (!(this.i1 == 0)) goto _label_4;
                    this.i0 = li32(this.i0 + 8);
                    this.i1 = li32(this.i0 + 16);
                    this.i4 = li32(this.i1 + 68);
                    this.i1 = li32(this.i1 + 64);
                    this.i3 = (this.i3 - this.i2);
                    if (uint(this.i4) < uint(this.i1)) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i1 = 4;
                    this.i4 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i4);
                    si32(this.i1, (this.i4 + 8));
                    
                _label_2: 
                    this.i1 = li32(this.i0 + 8);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i0 + 8));
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_4: 
                    this.i1 = __2E_str21451;
                    this.i0 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_3;
                    
                _label_5: 
                    this.i1 = (this.i1 << 3);
                    this.i1 = (this.i0 + this.i1);
                    this.i2 = li32(this.i1 + 20);
                    this.i1 = (this.i1 + 16);
                    this.i3 = (this.i0 + 8);
                    if (this.i2 == -2) goto _label_7;
                    if (!(this.i2 == -1)) goto _label_8;
                    this.i0 = __2E_str22452;
                    this.i4 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i3);
                    this.i3 = li32(this.i0 + 16);
                    this.i1 = li32(this.i1);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_6: 
                    this.i3 = 4;
                    this.i4 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 6:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, this.i4);
                    si32(this.i3, (this.i4 + 8));
                    goto _label_2;
                    
                _label_7: 
                    this.i2 = 3;
                    this.i1 = li32(this.i1);
                    this.i0 = li32(this.i0);
                    this.i1 = (this.i1 + 1);
                    this.i3 = li32(this.i3);
                    this.i4 = li32(this.i3 + 8);
                    this.i1 = (this.i1 - this.i0);
                    this.f0 = Number(this.i1);
                    sf64(this.f0, this.i4);
                    si32(this.i2, (this.i4 + 8));
                    this.i1 = li32(this.i3 + 8);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i3 + 8));
                    goto _label_3;
                    
                _label_8: 
                    this.i0 = li32(this.i3);
                    this.i3 = li32(this.i0 + 16);
                    this.i1 = li32(this.i1);
                    this.i4 = li32(this.i3 + 68);
                    this.i3 = li32(this.i3 + 64);
                    if (uint(this.i4) < uint(this.i3)) goto _label_9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaC_step.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_9: 
                    goto _label_6;
                default:
                    throw ("Invalid state in _push_onecapture");
            };
        }


    }
}

