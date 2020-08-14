package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaF_close extends Machine 
    {

        public static const intRegCount:int = 12;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
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
            var _local_1:FSM_luaF_close;
            _local_1 = new (FSM_luaF_close)();
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
                    this.i1 = li32(this.i0 + 96);
                    this.i2 = (this.i0 + 96);
                    this.i3 = li32(public::mstate.ebp + 12);
                    if (this.i1 == 0) goto _label_9;
                    this.i4 = li32(this.i0 + 16);
                    this.i4 = (this.i4 + 20);
                    this.i5 = (this.i0 + 16);
                    goto _label_8;
                    
                _label_1: 
                    this.i8 = li32(this.i7);
                    si32(this.i8, this.i2);
                    this.i8 = li8(this.i4);
                    this.i9 = li8(this.i7 + 5);
                    this.i8 = (this.i8 ^ 0x03);
                    this.i10 = (this.i7 + 5);
                    this.i8 = (this.i8 & this.i9);
                    this.i9 = this.i7;
                    this.i8 = (this.i8 & 0x03);
                    if (this.i8 == 0) goto _label_4;
                    this.i6 = li32(this.i6);
                    this.i9 = (this.i1 + 12);
                    if (this.i6 == this.i9) goto _label_2;
                    this.i6 = 0;
                    this.i9 = li32(this.i1 + 16);
                    this.i10 = li32(this.i1 + 12);
                    si32(this.i10, (this.i9 + 12));
                    this.i9 = li32(this.i1 + 12);
                    this.i1 = li32(this.i1 + 16);
                    si32(this.i1, (this.i9 + 16));
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = 24;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    goto _label_3;
                    
                _label_2: 
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = 24;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_3: 
                    this.i1 = li32(this.i2);
                    if (this.i1 == 0) goto _label_9;
                    goto _label_8;
                    
                _label_4: 
                    this.i8 = li32(this.i1 + 16);
                    this.i11 = li32(this.i1 + 12);
                    si32(this.i11, (this.i8 + 12));
                    this.i8 = li32(this.i1 + 12);
                    this.i11 = li32(this.i1 + 16);
                    si32(this.i11, (this.i8 + 16));
                    this.i8 = li32(this.i6);
                    this.f0 = lf64(this.i8);
                    sf64(this.f0, (this.i1 + 12));
                    this.i8 = li32(this.i8 + 8);
                    si32(this.i8, (this.i1 + 20));
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, this.i6);
                    this.i1 = li32(this.i5);
                    this.i8 = li32(this.i1 + 28);
                    si32(this.i8, this.i9);
                    si32(this.i7, (this.i1 + 28));
                    this.i7 = li8(this.i10);
                    this.i8 = this.i7;
                    this.i9 = (this.i7 & 0x04);
                    if (!(this.i9 == 0)) goto _label_7;
                    this.i8 = (this.i8 & 0x03);
                    if (!(this.i8 == 0)) goto _label_7;
                    this.i8 = li8(this.i1 + 21);
                    if (!(this.i8 == 1)) goto _label_6;
                    this.i1 = (this.i7 | 0x04);
                    si8(this.i1, this.i10);
                    this.i7 = li32(this.i6);
                    this.i6 = li32(this.i7 + 8);
                    if (this.i6 < 4) goto _label_7;
                    this.i7 = li32(this.i7);
                    this.i6 = li8(this.i7 + 5);
                    this.i6 = (this.i6 & 0x03);
                    if (this.i6 == 0) goto _label_7;
                    this.i6 = li32(this.i5);
                    this.i8 = li8(this.i6 + 21);
                    if (!(this.i8 == 1)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_7;
                    
                _label_5: 
                    this.i7 = li8(this.i6 + 20);
                    this.i1 = (this.i1 & 0xFFFFFFF8);
                    this.i7 = (this.i7 & 0x03);
                    this.i1 = (this.i7 | this.i1);
                    si8(this.i1, this.i10);
                    goto _label_7;
                    
                _label_6: 
                    this.i1 = li8(this.i1 + 20);
                    this.i6 = (this.i7 & 0xFFFFFFF8);
                    this.i1 = (this.i1 & 0x03);
                    this.i1 = (this.i1 | this.i6);
                    si8(this.i1, this.i10);
                    
                _label_7: 
                    this.i1 = li32(this.i2);
                    if (!(this.i1 == 0))
                    {
                        
                    _label_8: 
                        this.i7 = this.i1;
                        this.i8 = li32(this.i7 + 8);
                        this.i6 = (this.i7 + 8);
                        this.i1 = this.i7;
                        if (uint(this.i8) >= uint(this.i3)) goto _label_1;
                    };
                    
                _label_9: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaF_close");
            };
        }


    }
} cmodule.lua_wrapper

