package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_gmatch_aux extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_gmatch_aux;
            _local_1 = new (FSM_gmatch_aux)();
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
                    public::mstate.esp = (public::mstate.esp - 276);
                    this.i0 = (public::mstate.ebp + -276);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = -10003;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = -10004;
                    this.i3 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, (public::mstate.ebp + -264));
                    si32(this.i0, (public::mstate.ebp + -272));
                    this.i3 = li32(public::mstate.ebp + -276);
                    this.i3 = (this.i0 + this.i3);
                    si32(this.i3, (public::mstate.ebp + -268));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -10005;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tointeger.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = (public::mstate.ebp + -272);
                    this.i5 = li32(public::mstate.ebp + -268);
                    this.i4 = (this.i4 + 4);
                    this.i6 = (this.i0 + this.i3);
                    if (uint(this.i5) < uint(this.i6)) goto _label_3;
                    this.i5 = (public::mstate.ebp + -272);
                    this.i3 = (this.i3 + this.i0);
                    this.i5 = (this.i5 + 12);
                    
                _label_1: 
                    this.i6 = 0;
                    si32(this.i6, this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (public::mstate.ebp + -272);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 4:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i7 = this.i3;
                    if (this.i6 == 0) goto _label_2;
                    this.i3 = 3;
                    this.i2 = ((this.i6 == this.i7) ? 1 : 0);
                    this.i2 = (this.i2 & 0x01);
                    this.i0 = (this.i6 - this.i0);
                    this.i0 = (this.i0 + this.i2);
                    this.i2 = li32(this.i1 + 8);
                    this.f0 = Number(this.i0);
                    sf64(this.f0, this.i2);
                    si32(this.i3, (this.i2 + 8));
                    this.i3 = li32(this.i1 + 8);
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, (this.i1 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = -10005;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_replace.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (public::mstate.ebp + -272);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_captures.start();
                    return;
                case 6:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.eax = this.i3;
                    goto _label_4;
                    
                _label_2: 
                    this.i6 = li32(this.i4);
                    this.i3 = (this.i3 + 1);
                    if (!(uint(this.i6) < uint(this.i3))) goto _label_1;
                    
                _label_3: 
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    
                _label_4: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _gmatch_aux");
            };
        }


    }
}

