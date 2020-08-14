package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_sweeplist extends Machine 
    {

        public static const intRegCount:int = 14;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
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
            var _local_1:FSM_sweeplist;
            _local_1 = new (FSM_sweeplist)();
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
                    this.i1 = li32(this.i0 + 16);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li8(this.i1 + 20);
                    this.i4 = li32(this.i2);
                    this.i3 = (this.i3 ^ 0x03);
                    this.i5 = (this.i1 + 20);
                    this.i6 = (this.i0 + 16);
                    this.i7 = li32(public::mstate.ebp + 16);
                    if (!(this.i4 == 0)) goto _label_14;
                    this.i0 = this.i2;
                    goto _label_15;
                    
                _label_1: 
                    this.i4 = li8(this.i2 + 4);
                    this.i10 = (this.i2 + 4);
                    this.i11 = this.i2;
                    if (!(this.i4 == 8)) goto _label_2;
                    this.i4 = -3;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i12 = (this.i2 + 96);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i12, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sweeplist.start();
                    return;
                case 1:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i4 = li8(this.i11 + 5);
                    this.i11 = (this.i11 + 5);
                    this.i12 = (this.i4 ^ 0x03);
                    this.i12 = (this.i12 & this.i3);
                    this.i12 = (this.i12 & 0xFF);
                    if (!(this.i12 == 0))
                    {
                        this.i9 = li8(this.i5);
                        this.i4 = (this.i4 & 0xFFFFFFF8);
                        this.i9 = (this.i9 & 0x03);
                        this.i4 = (this.i9 | this.i4);
                        si8(this.i4, this.i11);
                        goto _label_13;
                    };
                    this.i4 = li32(this.i2);
                    si32(this.i4, this.i9);
                    this.i4 = li32(this.i1);
                    this.i11 = this.i2;
                    if (!(!(this.i4 == this.i2)))
                    {
                        this.i4 = li32(this.i11);
                        si32(this.i4, this.i1);
                    };
                    this.i4 = li8(this.i10);
                    if (this.i4 > 6) goto _label_3;
                    if (this.i4 == 4) goto _label_11;
                    if (this.i4 == 5) goto _label_9;
                    if (!(this.i4 == 6)) goto _label_5;
                    this.i4 = li8(this.i2 + 6);
                    this.i10 = this.i2;
                    this.i11 = this.i2;
                    if (this.i4 == 0) goto _label_6;
                    this.i2 = 0;
                    this.i4 = li8(this.i11 + 7);
                    this.i4 = (this.i4 * 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = (this.i4 + 20);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i9;
                    goto _label_13;
                    
                _label_3: 
                    if (this.i4 > 8) goto _label_4;
                    if (this.i4 == 7) goto _label_12;
                    if (!(this.i4 == 8)) goto _label_5;
                    this.i4 = 112;
                    this.i10 = li32(this.i2 + 32);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_close.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_freestack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i10, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i9;
                    goto _label_13;
                    
                _label_4: 
                    if (!(this.i4 == 9))
                    {
                        if (this.i4 == 10) goto _label_7;
                        
                    _label_5: 
                        this.i2 = this.i9;
                        goto _label_13;
                    };
                    this.i4 = 0;
                    this.i10 = li32(this.i2 + 44);
                    this.i11 = li32(this.i2 + 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = (this.i10 << 2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 6:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i10 = li32(this.i2 + 52);
                    this.i11 = li32(this.i2 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = (this.i10 << 2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 7:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i10 = li32(this.i2 + 40);
                    this.i11 = li32(this.i2 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = (this.i10 * 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 8:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i10 = li32(this.i2 + 48);
                    this.i11 = li32(this.i2 + 20);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = (this.i10 << 2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 9:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i10 = li32(this.i2 + 56);
                    this.i11 = li32(this.i2 + 24);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = (this.i10 * 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 10:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i10 = li32(this.i2 + 36);
                    this.i11 = li32(this.i2 + 28);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = (this.i10 << 2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 11:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = 76;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 12:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i9;
                    goto _label_13;
                    
                _label_6: 
                    this.i4 = 0;
                    this.i2 = li8(this.i2 + 7);
                    this.i2 = (this.i2 << 2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + 20);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 13:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i9;
                    goto _label_13;
                    
                _label_7: 
                    this.i4 = li32(this.i2 + 8);
                    this.i10 = this.i2;
                    this.i11 = this.i2;
                    this.i2 = (this.i2 + 12);
                    if (this.i4 == this.i2) goto _label_8;
                    this.i2 = 0;
                    this.i4 = li32(this.i11 + 16);
                    this.i12 = li32(this.i11 + 12);
                    si32(this.i12, (this.i4 + 12));
                    this.i4 = li32(this.i11 + 12);
                    this.i11 = li32(this.i11 + 16);
                    si32(this.i11, (this.i4 + 16));
                    this.i4 = li32(this.i6);
                    this.i11 = li32(this.i4 + 12);
                    this.i12 = li32(this.i4 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i13 = 24;
                    si32(this.i12, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 14:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i4 + 68);
                    this.i2 = (this.i2 + -24);
                    si32(this.i2, (this.i4 + 68));
                    this.i2 = this.i9;
                    goto _label_13;
                    
                _label_8: 
                    this.i2 = 0;
                    this.i4 = li32(this.i6);
                    this.i11 = li32(this.i4 + 12);
                    this.i12 = li32(this.i4 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i13 = 24;
                    si32(this.i12, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i13, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i11]());
                    return;
                case 15:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i4 + 68);
                    this.i2 = (this.i2 + -24);
                    si32(this.i2, (this.i4 + 68));
                    this.i2 = this.i9;
                    goto _label_13;
                    
                _label_9: 
                    this.i4 = _dummynode_;
                    this.i10 = li32(this.i2 + 16);
                    this.i11 = this.i2;
                    if (this.i10 == this.i4) goto _label_10;
                    this.i4 = 28;
                    this.i12 = li8(this.i11 + 7);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i13 = 0;
                    this.i4 = (this.i4 << this.i12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i13, (public::mstate.esp + 12));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 16:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    
                _label_10: 
                    this.i4 = 0;
                    this.i10 = li32(this.i11 + 28);
                    this.i11 = li32(this.i11 + 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = (this.i10 * 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 17:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i10 = 32;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaM_realloc_.start();
                    return;
                case 18:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = this.i9;
                    goto _label_13;
                    
                _label_11: 
                    this.i4 = 0;
                    this.i10 = li32(this.i6);
                    this.i11 = li32(this.i10 + 4);
                    this.i11 = (this.i11 + -1);
                    si32(this.i11, (this.i10 + 4));
                    this.i10 = li32(this.i6);
                    this.i11 = li32(this.i2 + 12);
                    this.i12 = li32(this.i10 + 12);
                    this.i13 = li32(this.i10 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i11 = (this.i11 + 17);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i12]());
                    return;
                case 19:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i10 + 68);
                    this.i2 = (this.i2 - this.i11);
                    si32(this.i2, (this.i10 + 68));
                    this.i2 = this.i9;
                    goto _label_13;
                    
                _label_12: 
                    this.i4 = 0;
                    this.i10 = li32(this.i6);
                    this.i11 = li32(this.i2 + 16);
                    this.i12 = li32(this.i10 + 12);
                    this.i13 = li32(this.i10 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i11 = (this.i11 + 20);
                    si32(this.i13, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    si32(this.i4, (public::mstate.esp + 12));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i12]());
                    return;
                case 20:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i2 = li32(this.i10 + 68);
                    this.i2 = (this.i2 - this.i11);
                    si32(this.i2, (this.i10 + 68));
                    this.i2 = this.i9;
                    
                _label_13: 
                    this.i4 = li32(this.i2);
                    this.i8 = (this.i8 + 1);
                    if ((this.i4 == 0))
                    {
                        this.i0 = this.i2;
                        goto _label_15;
                        
                    _label_14: 
                        this.i8 = 0;
                        this.i1 = (this.i1 + 28);
                    };
                    this.i9 = this.i2;
                    this.i2 = this.i4;
                    if (!(this.i8 == this.i7)) goto _label_1;
                    this.i0 = this.i9;
                    
                _label_15: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _sweeplist");
            };
        }


    }
} cmodule.lua_wrapper

