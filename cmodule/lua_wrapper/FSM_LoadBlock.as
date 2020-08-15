package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_LoadBlock extends Machine 
    {

        public static const intRegCount:int = 10;
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
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_LoadBlock;
            _local_1 = new (FSM_LoadBlock)();
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
                    this.i1 = li32(this.i0 + 4);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    if (!(this.i3 == 0)) goto _label_4;
                    
                _label_1: 
                    this.i1 = 0;
                    
                _label_2: 
                    if (this.i1 == 0) goto _label_3;
                    this.i1 = __2E_str156317;
                    this.i2 = li32(this.i0 + 12);
                    this.i3 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = __2E_str1157;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i0);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = 3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_4: 
                    this.i4 = 0;
                    this.i5 = (this.i1 + 4);
                    this.i6 = this.i1;
                    
                _label_5: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaZ_lookahead.start();
                    return;
                case 3:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(!(this.i7 == -1)))
                    {
                        this.i1 = this.i3;
                        goto _label_2;
                    };
                    this.i7 = li32(this.i6);
                    this.i8 = li32(this.i5);
                    this.i9 = (this.i2 + this.i4);
                    this.i7 = ((uint(this.i7) <= uint(this.i3)) ? this.i7 : this.i3);
                    memcpy(this.i9, this.i8, this.i7);
                    this.i8 = li32(this.i6);
                    this.i8 = (this.i8 - this.i7);
                    si32(this.i8, this.i6);
                    this.i8 = li32(this.i5);
                    this.i8 = (this.i8 + this.i7);
                    si32(this.i8, this.i5);
                    this.i8 = (this.i3 - this.i7);
                    this.i4 = (this.i4 + this.i7);
                    if (this.i3 == this.i7) goto _label_1;
                    this.i3 = this.i8;
                    goto _label_5;
                default:
                    throw ("Invalid state in _LoadBlock");
            };
        }


    }
}

