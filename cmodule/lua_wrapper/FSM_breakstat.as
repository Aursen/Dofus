package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_breakstat extends Machine 
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
            var _local_1:FSM_breakstat;
            _local_1 = new (FSM_breakstat)();
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
                    public::mstate.esp = (public::mstate.esp - 96);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 36);
                    this.i2 = li32(this.i1 + 20);
                    if (!(this.i2 == 0))
                    {
                        this.i3 = 0;
                    }
                    else
                    {
                        this.i3 = 0;
                        goto _label_2;
                        
                    _label_1: 
                        this.i4 = li8(this.i2 + 9);
                        this.i2 = li32(this.i2);
                        this.i3 = (this.i4 | this.i3);
                        if (this.i2 == 0) goto _label_8;
                    };
                    this.i4 = li8(this.i2 + 10);
                    if (this.i4 == 0) goto _label_1;
                    
                _label_2: 
                    if (!(this.i2 == 0)) goto _label_5;
                    this.i4 = 80;
                    this.i5 = li32(this.i0 + 52);
                    this.i6 = li32(this.i0 + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = (public::mstate.ebp + -96);
                    this.i5 = (this.i5 + 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i0 + 4);
                    this.i5 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i8 = __2E_str15272;
                    this.i9 = __2E_str9104;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    si32(this.i9, (public::mstate.esp + 16));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 2:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i5 = (this.i0 + 40);
                    if (this.i6 == 0) goto _label_4;
                    this.i7 = (this.i6 + -284);
                    if (uint(this.i7) > uint(2)) goto _label_3;
                    this.i6 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_save.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = li32(this.i0 + 48);
                    this.i0 = li32(this.i0);
                    this.i6 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i7 = __2E_str35292;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = 3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_5;
                    
                _label_3: 
                    this.i7 = __2E_str35292;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaX_token2str.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i5 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = 3;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_5;
                    
                _label_4: 
                    this.i0 = 3;
                    this.i4 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_5: 
                    if (this.i3 == 0) goto _label_6;
                    this.i0 = -1;
                    this.i3 = li32(this.i1 + 12);
                    this.i4 = li8(this.i2 + 8);
                    this.i3 = li32(this.i3 + 8);
                    this.i4 = (this.i4 << 6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i4 | 0x23);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 10:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i3 = li32(this.i1 + 32);
                    si32(this.i0, (this.i1 + 32));
                    this.i0 = li32(this.i1 + 12);
                    this.i0 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 2147450902;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, (public::mstate.ebp + -4));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (public::mstate.ebp + -4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 12:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(public::mstate.ebp + -4);
                    goto _label_7;
                    
                _label_6: 
                    this.i0 = -1;
                    this.i3 = li32(this.i1 + 32);
                    si32(this.i0, (this.i1 + 32));
                    this.i0 = li32(this.i1 + 12);
                    this.i0 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 2147450902;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 13:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i0, (public::mstate.ebp + -8));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i0 = (public::mstate.ebp + -8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(public::mstate.ebp + -8);
                    
                _label_7: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + 4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 15:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_8: 
                    goto _label_2;
                default:
                    throw ("Invalid state in _breakstat");
            };
        }


    }
}

