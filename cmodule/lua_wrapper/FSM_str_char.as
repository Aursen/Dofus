package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_str_char extends Machine 
    {

        public static const intRegCount:int = 9;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_str_char;
            _local_1 = new (FSM_str_char)();
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
                    public::mstate.esp = (public::mstate.esp - 1040);
                    this.i0 = (public::mstate.ebp + -1040);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    si32(this.i1, (public::mstate.ebp + -1032));
                    this.i4 = (this.i0 + 12);
                    this.i2 = (this.i2 - this.i3);
                    si32(this.i4, (public::mstate.ebp + -1040));
                    this.i3 = 0;
                    si32(this.i3, (public::mstate.ebp + -1036));
                    this.i3 = (this.i0 + 4);
                    this.i4 = (this.i0 + 8);
                    this.i5 = (this.i2 / 12);
                    if (this.i2 < 12) goto _label_4;
                    this.i2 = (public::mstate.ebp + -1040);
                    this.i2 = (this.i2 + 1036);
                    this.i6 = 1;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkinteger.start();
                    return;
                case 1:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = (this.i7 & 0xFF);
                    if (this.i8 == this.i7) goto _label_2;
                    this.i8 = __2E_str17447;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_argerror.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i8 = li32(this.i0);
                    if (uint(this.i8) < uint(this.i2)) goto _label_3;
                    this.i8 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i8, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 3:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i8 == 0) goto _label_3;
                    this.i8 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i8, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_3: 
                    this.i8 = li32(this.i0);
                    si8(this.i7, this.i8);
                    this.i7 = (this.i8 + 1);
                    si32(this.i7, this.i0);
                    this.i6 = (this.i6 + 1);
                    if (!(this.i6 > this.i5)) goto _label_1;
                    
                _label_4: 
                    this.i0 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i3);
                    this.i1 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _str_char");
            };
        }


    }
}

