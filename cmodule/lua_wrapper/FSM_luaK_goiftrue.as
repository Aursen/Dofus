package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaK_goiftrue extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;


        public static function start():void
        {
            var _local_1:FSM_luaK_goiftrue;
            _local_1 = new (FSM_luaK_goiftrue)();
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
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = li32(public::mstate.ebp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_dischargevars.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = li32(this.i1);
                    if (this.i2 > 3) goto _label_1;
                    if (this.i2 == 2) goto _label_2;
                    if (!(this.i2 == 3)) goto _label_3;
                    this.i2 = -1;
                    this.i3 = li32(this.i0 + 32);
                    si32(this.i2, (this.i0 + 32));
                    this.i2 = li32(this.i0 + 12);
                    this.i2 = li32(this.i2 + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = 2147450902;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -4));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (public::mstate.ebp + -4);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(public::mstate.ebp + -4);
                    goto _label_4;
                    
                _label_1: 
                    if (!(this.i2 == 10))
                    {
                        this.i2 = (this.i2 + -4);
                        if (uint(this.i2) > uint(1)) goto _label_3;
                        
                    _label_2: 
                        this.i2 = -1;
                        goto _label_4;
                    };
                    this.i2 = li32(this.i1 + 4);
                    this.i3 = li32(this.i0);
                    this.i3 = li32(this.i3 + 12);
                    this.i4 = (this.i2 << 2);
                    this.i4 = (this.i3 + this.i4);
                    this.i5 = (this.i1 + 4);
                    if (!(this.i2 > 0))
                    {
                        this.i2 = this.i4;
                    }
                    else
                    {
                        this.i6 = _luaP_opmodes;
                        this.i2 = (this.i2 << 2);
                        this.i2 = (this.i2 + this.i3);
                        this.i3 = li32(this.i2 + -4);
                        this.i3 = (this.i3 & 0x3F);
                        this.i3 = (this.i6 + this.i3);
                        this.i3 = li8(this.i3);
                        this.i3 = (this.i3 << 24);
                        this.i3 = (this.i3 >> 24);
                        this.i2 = (this.i2 + -4);
                        this.i2 = ((this.i3 > -1) ? this.i4 : this.i2);
                    };
                    this.i3 = li32(this.i2);
                    this.i4 = (this.i3 & 0x3FC0);
                    this.i4 = ((this.i4 == 0) ? 64 : 0);
                    this.i3 = (this.i3 & 0xFFFFC03F);
                    this.i3 = (this.i4 | this.i3);
                    si32(this.i3, this.i2);
                    this.i2 = li32(this.i5);
                    goto _label_4;
                    
                _label_3: 
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_jumponcond.start();
                    return;
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_4: 
                    this.i3 = -1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i1 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = li32(this.i1 + 12);
                    this.i4 = li32(this.i0 + 24);
                    si32(this.i4, (this.i0 + 28));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = (this.i0 + 32);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (this.i1 + 12));
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaK_goiftrue");
            };
        }


    }
} cmodule.lua_wrapper

