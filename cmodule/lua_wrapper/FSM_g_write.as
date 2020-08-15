package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_g_write extends Machine 
    {

        public static const intRegCount:int = 15;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
        public var f0:Number;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_g_write;
            _local_1 = new (FSM_g_write)();
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
                    public::mstate.esp = (public::mstate.esp - 36);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 8);
                    this.i2 = li32(this.i0 + 12);
                    this.i1 = (this.i1 - this.i2);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = (this.i1 + -12);
                    if (!(uint(this.i4) > uint(11)))
                    {
                        this.i1 = 1;
                        goto _label_7;
                    };
                    this.i4 = (public::mstate.ebp + -32);
                    this.i5 = (public::mstate.ebp + -8);
                    this.i1 = (this.i1 / 12);
                    this.i6 = 1;
                    this.i7 = 0;
                    this.i8 = (this.i2 + 56);
                    this.i9 = (this.i4 + 4);
                    this.i10 = (this.i4 + 8);
                    this.i11 = (this.i5 + 4);
                    this.i1 = (this.i1 + -1);
                    
                _label_1: 
                    this.i12 = _luaO_nilobject_;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i13 = (this.i3 + this.i7);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i14 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i14 == this.i12) goto _label_4;
                    this.i12 = li32(this.i14 + 8);
                    if (!(this.i12 == 3)) goto _label_4;
                    if (!(!(this.i6 == 0)))
                    {
                        
                    _label_2: 
                        this.i6 = 0;
                        goto _label_6;
                    };
                    this.i6 = __2E_str1166;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tonumber.start();
                    return;
                case 2:
                    this.f0 = public::mstate.st0;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    sf64(this.f0, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fprintf.start();
                    return;
                case 3:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i6 < 1) goto _label_2;
                    
                _label_3: 
                    this.i6 = 1;
                    goto _label_6;
                    
                _label_4: 
                    this.i12 = (public::mstate.ebp + -36);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i13, (public::mstate.esp + 4));
                    si32(this.i12, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 4:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i6 == 0) goto _label_5;
                    this.i6 = (public::mstate.ebp + -8);
                    this.i13 = li32(public::mstate.ebp + -36);
                    si32(this.i12, this.i5);
                    si32(this.i13, this.i11);
                    si32(this.i13, this.i10);
                    si32(this.i6, this.i4);
                    this.i6 = 1;
                    si32(this.i6, this.i9);
                    this.i6 = li32(this.i8);
                    this.i12 = li32(this.i6 + 16);
                    this.i6 = (this.i6 + 16);
                    if (!(!(this.i12 == 0)))
                    {
                        this.i12 = -1;
                        si32(this.i12, this.i6);
                    };
                    this.i6 = (public::mstate.ebp + -32);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sfvwrite.start();
                    return;
                case 5:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(!(this.i6 == 0)))
                    {
                        this.i6 = this.i13;
                    }
                    else
                    {
                        this.i6 = li32(this.i10);
                        this.i6 = (this.i13 - this.i6);
                    };
                    this.i12 = li32(public::mstate.ebp + -36);
                    if (this.i6 == this.i12) goto _label_3;
                    
                _label_5: 
                    this.i6 = 0;
                    
                _label_6: 
                    this.i7 = (this.i7 + 1);
                    if (!(this.i7 == this.i1)) goto _label_1;
                    this.i1 = this.i6;
                    
                _label_7: 
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pushresult.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _g_write");
            };
        }


    }
}

