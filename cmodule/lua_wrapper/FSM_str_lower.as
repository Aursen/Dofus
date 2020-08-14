package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_str_lower extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_str_lower;
            _local_1 = new (FSM_str_lower)();
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
                    this.i0 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    this.i2 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, (public::mstate.ebp + -1032));
                    this.i1 = (this.i2 + 12);
                    si32(this.i1, (public::mstate.ebp + -1040));
                    this.i3 = 0;
                    si32(this.i3, (public::mstate.ebp + -1036));
                    this.i3 = li32(public::mstate.ebp + -4);
                    this.i4 = (this.i2 + 4);
                    this.i5 = (this.i2 + 8);
                    if (this.i3 == 0) goto _label_3;
                    this.i3 = (public::mstate.ebp + -1040);
                    this.i3 = (this.i3 + 1036);
                    this.i6 = 0;
                    
                _label_1: 
                    if (uint(this.i1) < uint(this.i3)) goto _label_2;
                    this.i1 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i1 == 0) goto _label_2;
                    this.i1 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i1 = (this.i0 + this.i6);
                    this.i1 = li8(this.i1);
                    this.i7 = li32(__CurrentRuneLocale);
                    this.i1 = (this.i1 << 2);
                    this.i1 = (this.i7 + this.i1);
                    this.i7 = li32(this.i2);
                    this.i1 = li8(this.i1 + 1076);
                    si8(this.i1, this.i7);
                    this.i1 = (this.i7 + 1);
                    si32(this.i1, this.i2);
                    this.i7 = li32(public::mstate.ebp + -4);
                    this.i6 = (this.i6 + 1);
                    if (!(uint(this.i6) >= uint(this.i7))) goto _label_1;
                    
                _label_3: 
                    this.i0 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i4);
                    this.i1 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 5:
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
                    throw ("Invalid state in _str_lower");
            };
        }


    }
} cmodule.lua_wrapper

