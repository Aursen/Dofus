package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_new_localvar extends Machine 
    {

        public static const intRegCount:int = 13;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
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
            var _local_1:FSM_new_localvar;
            _local_1 = new (FSM_new_localvar)();
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
                    public::mstate.esp = (public::mstate.esp - 160);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 36);
                    this.i2 = li8(this.i1 + 50);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = (this.i1 + 50);
                    this.i5 = (this.i0 + 36);
                    this.i6 = li32(public::mstate.ebp + 12);
                    this.i2 = (this.i3 + this.i2);
                    this.i2 = (this.i2 + 1);
                    if (this.i2 < 201) goto _label_2;
                    this.i2 = li32(this.i1);
                    this.i2 = li32(this.i2 + 60);
                    this.i7 = li32(this.i1 + 16);
                    this.i8 = (this.i1 + 12);
                    if (!(this.i2 == 0)) goto _label_1;
                    this.i2 = __2E_str196;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = __2E_str499;
                    this.i10 = 200;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i9, (public::mstate.esp + 12));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i7 = li32(this.i8);
                    this.i8 = li32(this.i7 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 80;
                    this.i10 = (public::mstate.ebp + -160);
                    this.i8 = (this.i8 + 16);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = li32(this.i7 + 4);
                    this.i9 = li32(this.i7 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i11 = __2E_str15272;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i7 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_2;
                    
                _label_1: 
                    this.i9 = __2E_str297;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i10 = __2E_str499;
                    this.i11 = 200;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i11, (public::mstate.esp + 12));
                    si32(this.i10, (public::mstate.esp + 16));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i7 = li32(this.i8);
                    this.i8 = li32(this.i7 + 52);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i9 = 80;
                    this.i10 = (public::mstate.ebp + -80);
                    this.i8 = (this.i8 + 16);
                    si32(this.i10, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_chunkid.start();
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i8 = li32(this.i7 + 4);
                    this.i9 = li32(this.i7 + 40);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i11 = __2E_str15272;
                    si32(this.i9, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_pushfstring.start();
                    return;
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i7 + 40);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = 3;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_throw.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i2 = li32(this.i5);
                    this.i5 = li32(this.i2);
                    this.i7 = sxi16(li16(this.i2 + 48));
                    this.i4 = li8(this.i4);
                    this.i8 = li32(this.i5 + 56);
                    this.i2 = (this.i2 + 48);
                    this.i9 = (this.i5 + 56);
                    this.i3 = (this.i4 + this.i3);
                    this.i4 = (this.i7 + 1);
                    if (!(this.i4 > this.i8)) goto _label_4;
                    this.i4 = __2E_str5100;
                    this.i7 = li32(this.i5 + 24);
                    this.i10 = li32(this.i0 + 40);
                    public::mstate.esp = (public::mstate.esp - 24);
                    this.i11 = 32767;
                    this.i12 = 12;
                    si32(this.i10, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i9, (public::mstate.esp + 8));
                    si32(this.i12, (public::mstate.esp + 12));
                    si32(this.i11, (public::mstate.esp + 16));
                    si32(this.i4, (public::mstate.esp + 20));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_growaux_.start();
                    return;
                case 9:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 24);
                    si32(this.i4, (this.i5 + 24));
                    this.i7 = li32(this.i9);
                    if (!(this.i7 > this.i8))
                    {
                        this.i8 = this.i4;
                        goto _label_5;
                        
                    _label_3: 
                        this.i4 = this.i7;
                    };
                    this.i7 = 0;
                    this.i10 = (this.i8 * 12);
                    this.i4 = (this.i4 + this.i10);
                    si32(this.i7, this.i4);
                    this.i8 = (this.i8 + 1);
                    
                _label_4: 
                    this.i4 = li32(this.i9);
                    this.i7 = li32(this.i5 + 24);
                    if (this.i4 > this.i8) goto _label_3;
                    this.i8 = this.i7;
                    
                _label_5: 
                    this.i4 = this.i8;
                    this.i7 = sxi16(li16(this.i2));
                    this.i7 = (this.i7 * 12);
                    this.i4 = (this.i4 + this.i7);
                    si32(this.i6, this.i4);
                    this.i4 = li8(this.i6 + 5);
                    this.i4 = (this.i4 & 0x03);
                    if (this.i4 == 0) goto _label_7;
                    this.i4 = li8(this.i5 + 5);
                    this.i5 = (this.i5 + 5);
                    this.i7 = (this.i4 & 0x04);
                    if (this.i7 == 0) goto _label_7;
                    this.i0 = li32(this.i0 + 40);
                    this.i0 = li32(this.i0 + 16);
                    this.i7 = li8(this.i0 + 21);
                    if (!(this.i7 == 1)) goto _label_6;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_reallymarkobject.start();
                case 10:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_7;
                    
                _label_6: 
                    this.i0 = li8(this.i0 + 20);
                    this.i4 = (this.i4 & 0xFFFFFFF8);
                    this.i0 = (this.i0 & 0x03);
                    this.i0 = (this.i0 | this.i4);
                    si8(this.i0, this.i5);
                    
                _label_7: 
                    this.i0 = li16(this.i2);
                    this.i4 = (this.i0 + 1);
                    this.i3 = (this.i3 << 1);
                    si16(this.i4, this.i2);
                    this.i1 = (this.i1 + this.i3);
                    si16(this.i0, (this.i1 + 172));
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _new_localvar");
            };
        }


    }
} cmodule.lua_wrapper

