package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaL_addlstring extends Machine 
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
            var _local_1:FSM_luaL_addlstring;
            _local_1 = new (FSM_luaL_addlstring)();
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
                    this.i2 = li32(public::mstate.ebp + 12);
                    if (this.i1 == 0) goto _label_3;
                    this.i3 = 0;
                    this.i4 = (this.i0 + 1036);
                    this.i5 = this.i0;
                    
                _label_1: 
                    this.i6 = li32(this.i5);
                    this.i7 = (this.i2 + this.i3);
                    if (uint(this.i6) < uint(this.i4)) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 1:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i6 == 0) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i6 = li32(this.i5);
                    this.i7 = li8(this.i7);
                    si8(this.i7, this.i6);
                    this.i6 = (this.i6 + 1);
                    si32(this.i6, this.i5);
                    this.i3 = (this.i3 + 1);
                    if (!(this.i3 == this.i1)) goto _label_1;
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaL_addlstring");
            };
        }


    }
}

