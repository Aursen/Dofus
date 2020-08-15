package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaK_checkstack extends Machine 
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
            var _local_1:FSM_luaK_checkstack;
            _local_1 = new (FSM_luaK_checkstack)();
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
                    public::mstate.esp = (public::mstate.esp - 80);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0);
                    this.i2 = li32(this.i0 + 36);
                    this.i3 = li8(this.i1 + 75);
                    this.i4 = li32(public::mstate.ebp + 12);
                    this.i1 = (this.i1 + 75);
                    this.i2 = (this.i2 + this.i4);
                    this.i4 = this.i0;
                    if (this.i3 >= this.i2) goto _label_5;
                    this.i3 = this.i2;
                    if (this.i2 < 250) goto _label_4;
                    this.i1 = 80;
                    this.i0 = li32(this.i0 + 12);
                    this.i2 = li32(this.i0 + 52);
                    this.i5 = li32(this.i0 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i6 = (public::mstate.ebp + -80);
                    this.i2 = (this.i2 + 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i0 + 4);
                    this.i2 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i7 = __2E_str15272;
                    this.i8 = __2E_str21255;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i8, (public::mstate.esp + 16));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = (this.i0 + 40);
                    if (this.i5 == 0) goto _label_2;
                    this.i6 = (this.i5 + -284);
                    if (uint(this.i6) > uint(2)) goto _label_1;
                    this.i5 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0 + 48);
                    this.i0 = li32(this.i0);
                    this.i5 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = __2E_str35292;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 4:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_3;
                    
                _label_1: 
                    this.i6 = __2E_str35292;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 7:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = 3;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_3;
                    
                _label_2: 
                    this.i1 = 3;
                    this.i0 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_3: 
                    this.i1 = li32(this.i4);
                    si8(this.i3, (this.i1 + 75));
                    goto _label_5;
                    
                _label_4: 
                    si8(this.i3, this.i1);
                    
                _label_5: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaK_checkstack");
            };
        }


    }
}

